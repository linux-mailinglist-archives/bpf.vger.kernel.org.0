Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027D485EFF
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2019 11:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389820AbfHHJuG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Aug 2019 05:50:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:34846 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731485AbfHHJuF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Aug 2019 05:50:05 -0400
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hvf3X-0006I0-9h; Thu, 08 Aug 2019 11:49:59 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, m@lambda.lt,
        edumazet@google.com, ast@kernel.org, willemb@google.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net 1/2] sock: make cookie generation global instead of per netns
Date:   Thu,  8 Aug 2019 11:49:36 +0200
Message-Id: <20190808094937.26918-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190808094937.26918-1-daniel@iogearbox.net>
References: <20190808094937.26918-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25535/Thu Aug  8 10:18:42 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Generating and retrieving socket cookies are a useful feature that is
exposed to BPF for various program types through bpf_get_socket_cookie()
helper.

The fact that the cookie counter is per netns is quite a limitation
for BPF in practice in particular for programs in host namespace that
use socket cookies as part of a map lookup key since they will be
causing socket cookie collisions e.g. when attached to BPF cgroup hooks
or cls_bpf on tc egress in host namespace handling container traffic
from veths or ipvlan slaves. Change the counter to be global instead.

Socket cookie consumers must assume the value as opqaue in any case.
The cookie does not guarantee an always unique identifier since it
could wrap in fabricated corner cases where two sockets could end up
holding the same cookie, but is good enough to be used as a hint for
many use cases; not every socket must have a cookie generated hence
knowledge of the counter value does not provide much value either way.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Martynas Pumputis <m@lambda.lt>
---
 include/net/net_namespace.h | 1 -
 include/uapi/linux/bpf.h    | 4 ++--
 net/core/sock_diag.c        | 3 ++-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 4a9da951a794..cb668bc2692d 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -61,7 +61,6 @@ struct net {
 	spinlock_t		rules_mod_lock;
 
 	u32			hash_mix;
-	atomic64_t		cookie_gen;
 
 	struct list_head	list;		/* list of network namespaces */
 	struct list_head	exit_list;	/* To linked to call pernet exit
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fa1c753dcdbc..a5aa7d3ac6a1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1466,8 +1466,8 @@ union bpf_attr {
  * 		If no cookie has been set yet, generate a new cookie. Once
  * 		generated, the socket cookie remains stable for the life of the
  * 		socket. This helper can be useful for monitoring per socket
- * 		networking traffic statistics as it provides a unique socket
- * 		identifier per namespace.
+ * 		networking traffic statistics as it provides a global socket
+ * 		identifier that can be assumed unique.
  * 	Return
  * 		A 8-byte long non-decreasing number on success, or 0 if the
  * 		socket field is missing inside *skb*.
diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index 3312a5849a97..c13ffbd33d8d 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -19,6 +19,7 @@ static const struct sock_diag_handler *sock_diag_handlers[AF_MAX];
 static int (*inet_rcv_compat)(struct sk_buff *skb, struct nlmsghdr *nlh);
 static DEFINE_MUTEX(sock_diag_table_mutex);
 static struct workqueue_struct *broadcast_wq;
+static atomic64_t cookie_gen;
 
 u64 sock_gen_cookie(struct sock *sk)
 {
@@ -27,7 +28,7 @@ u64 sock_gen_cookie(struct sock *sk)
 
 		if (res)
 			return res;
-		res = atomic64_inc_return(&sock_net(sk)->cookie_gen);
+		res = atomic64_inc_return(&cookie_gen);
 		atomic64_cmpxchg(&sk->sk_cookie, 0, res);
 	}
 }
-- 
2.17.1

