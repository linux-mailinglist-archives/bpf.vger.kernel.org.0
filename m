Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C8136B63
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 11:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgAJKuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jan 2020 05:50:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44077 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgAJKuf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jan 2020 05:50:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so1321279wrm.11
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 02:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dKpIUjyaCCE7cHiIaspK1fnCtwKUAKNxkQzczi+/SQ=;
        b=S0GPYVQh0LUBZMngOEZfR71WfLQ6vh4qcXtT3+XKaZ0cfim0O7IV/ChorfctrXWRjA
         dloT931G3sxPo5CWW8eHPGXf15dC7DG8f+PWwy9R+f20plYSp7jDOnlmnugg1SSl9xJE
         /u5178CcGqEDQEZLj03uzjyLkhHguvc4CxOnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dKpIUjyaCCE7cHiIaspK1fnCtwKUAKNxkQzczi+/SQ=;
        b=rEoAOGV42W77qi6OAInPQ+RTdyIblYF6GVTjX53s5t7Fl8+2/RnpTQ9Cqc3uSx2Z21
         TuB9ISdnSjsVJfufLTyHDRfzqrLn+1ESygN5Th4vLOW3myOY6/2rrjD8wPs2SdtJwgZL
         3P4vpz21hHaMEvrkaAvoWWtRyDWER1amYlQJhXwNTfcLzhNZo1KtKFkGOimgMjxFC77v
         0z+ZXPkC2qFrsHSfC+Dpo/1VR6QrSY8j3tCoFNq0PzH4COjJf1IJf2GUY4tCZkT0njaa
         Sn3ifEpMQ/MlQdgU9JEHfqy2YUc3vHlW42p5wD/lo/Xc7n8BmUbZKU71wnHuZXtTs1T1
         AKoQ==
X-Gm-Message-State: APjAAAV6jTMP5z/QWVkhPH0ehBxA3K9/9go3cdHyHAo1fO0Exlgry5sL
        +hKvghBLQHmkjD8jZM5vjdVCQI9k6+6Pyg==
X-Google-Smtp-Source: APXvYqwuZHWCSc2vtm+wOwV8UlOAhiufneJnW2LNZRHRaN73Nu/9zib7MldG/9mE/gmmTMxYBdQq+w==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr2907639wrx.288.1578653433523;
        Fri, 10 Jan 2020 02:50:33 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id w8sm1842044wmm.0.2020.01.10.02.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 02:50:32 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v2 03/11] net, sk_msg: Clear sk_user_data pointer on clone if tagged
Date:   Fri, 10 Jan 2020 11:50:19 +0100
Message-Id: <20200110105027.257877-4-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110105027.257877-1-jakub@cloudflare.com>
References: <20200110105027.257877-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sk_user_data can hold a pointer to an object that is not intended to be
shared between the parent socket and the child that gets a pointer copy on
clone. This is the case when sk_user_data points at reference-counted
object, like struct sk_psock.

One way to resolve it is to tag the pointer with a no-copy flag by
repurposing its lowest bit. Based on the bit-flag value we clear the child
sk_user_data pointer after cloning the parent socket.

The no-copy flag is stored in the pointer itself as opposed to externally,
say in socket flags, to guarantee that the pointer and the flag are copied
from parent to child socket in an atomic fashion. Parent socket state is
subject to change while copying, we don't hold any locks at that time.

This approach relies on an assumption that sk_user_data holds a pointer to
an object aligned to 2 or more bytes. A manual audit of existing users of
rcu_dereference_sk_user_data helper confirms it. Also, an RCU-protected
sk_user_data is not likely to hold a pointer to a char value or a
pathological case of "struct { char c; }". To be safe, warn when the
flag-bit is set when setting sk_user_data to catch any future misuses.

It is worth considering why clearing sk_user_data unconditionally is not an
option. There exist users, DRBD, NVMe, and Xen drivers being among them,
that rely on the pointer being copied when cloning the listening socket.

Potentially we could distinguish these users by checking if the listening
socket has been created in kernel-space via sock_create_kern, and hence has
sk_kern_sock flag set. However, this is not the case for NVMe and Xen
drivers, which create sockets without marking them as belonging to the
kernel.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/net/sock.h | 37 +++++++++++++++++++++++++++++++++++--
 net/core/skmsg.c   |  2 +-
 net/core/sock.c    |  6 ++++++
 net/ipv4/tcp_bpf.c |  4 ++++
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8dff68b4c316..071003331f55 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -518,10 +518,43 @@ enum sk_pacing {
 	SK_PACING_FQ		= 2,
 };
 
+/* Pointer stored in sk_user_data might not be suitable for copying
+ * when cloning the socket. For instance, it can point to a reference
+ * counted object. sk_user_data bottom bit is set if pointer must not
+ * be copied.
+ */
+#define SK_USER_DATA_NOCOPY	1UL
+#define SK_USER_DATA_PTRMASK	~(SK_USER_DATA_NOCOPY)
+
+/**
+ * sk_user_data_is_nocopy - Test if sk_user_data pointer must not be copied
+ * @sk: socket
+ */
+static inline bool sk_user_data_is_nocopy(const struct sock *sk)
+{
+	return ((uintptr_t)sk->sk_user_data & SK_USER_DATA_NOCOPY);
+}
+
 #define __sk_user_data(sk) ((*((void __rcu **)&(sk)->sk_user_data)))
 
-#define rcu_dereference_sk_user_data(sk)	rcu_dereference(__sk_user_data((sk)))
-#define rcu_assign_sk_user_data(sk, ptr)	rcu_assign_pointer(__sk_user_data((sk)), ptr)
+#define rcu_dereference_sk_user_data(sk)				\
+({									\
+	void *__tmp = rcu_dereference(__sk_user_data((sk)));		\
+	(void *)((uintptr_t)__tmp & SK_USER_DATA_PTRMASK);		\
+})
+#define rcu_assign_sk_user_data(sk, ptr)				\
+({									\
+	uintptr_t __tmp = (uintptr_t)(ptr);				\
+	WARN_ON(__tmp & ~SK_USER_DATA_PTRMASK);				\
+	rcu_assign_pointer(__sk_user_data((sk)), __tmp);		\
+})
+#define rcu_assign_sk_user_data_nocopy(sk, ptr)				\
+({									\
+	uintptr_t __tmp = (uintptr_t)(ptr);				\
+	WARN_ON(__tmp & ~SK_USER_DATA_PTRMASK);				\
+	rcu_assign_pointer(__sk_user_data((sk)),			\
+			   __tmp | SK_USER_DATA_NOCOPY);		\
+})
 
 /*
  * SK_CAN_REUSE and SK_NO_REUSE on a socket mean that the socket is OK
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index ded2d5227678..eeb28cb85664 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -512,7 +512,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 	sk_psock_set_state(psock, SK_PSOCK_TX_ENABLED);
 	refcount_set(&psock->refcnt, 1);
 
-	rcu_assign_sk_user_data(sk, psock);
+	rcu_assign_sk_user_data_nocopy(sk, psock);
 	sock_hold(sk);
 
 	return psock;
diff --git a/net/core/sock.c b/net/core/sock.c
index 96b4e8820ae8..4ad2bc4d4b55 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1864,6 +1864,12 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 			goto out;
 		}
 
+		/* Clear sk_user_data if parent had the pointer tagged
+		 * as not suitable for copying when cloning.
+		 */
+		if (sk_user_data_is_nocopy(newsk))
+			RCU_INIT_POINTER(newsk->sk_user_data, NULL);
+
 		newsk->sk_err	   = 0;
 		newsk->sk_err_soft = 0;
 		newsk->sk_priority = 0;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index e6ffdb47b619..f6c83747c71e 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -535,6 +535,10 @@ static void tcp_bpf_remove(struct sock *sk, struct sk_psock *psock)
 {
 	struct sk_psock_link *link;
 
+	/* Did a child socket inadvertently inherit parent's psock? */
+	if (WARN_ON(sk != psock->sk))
+		return;
+
 	while ((link = sk_psock_link_pop(psock))) {
 		sk_psock_unlink(sk, link);
 		sk_psock_free_link(link);
-- 
2.24.1

