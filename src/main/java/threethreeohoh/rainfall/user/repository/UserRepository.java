package threethreeohoh.rainfall.user.repository;

import threethreeohoh.rainfall.user.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long>{

    @Query(
            """
                SELECT u
                FROM User u
                Where u.email = :email 
                    
            """)
    Optional<User> findByEmail(String email);

}
