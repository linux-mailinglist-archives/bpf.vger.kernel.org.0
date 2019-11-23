Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE8107E1A
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2019 12:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfKWLH5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Nov 2019 06:07:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36507 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfKWLH5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 06:07:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15so10294689lja.3
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2019 03:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4szVR/O76HqiTJlzrOTMqDMxaA5pR6qPc74y5Z8/h3U=;
        b=qWJBwijohGKs7NYs1rJzvjjGZJCGQIC09lF9YenuzbvTZjoqxif/ZJgjI/uRrtCV70
         UFqaTfW19UNWYSDvCzNfEyGqqqEVWrEFXJwExmWc0C1uiSsnGBZ8+70n789myQzhw/+a
         9FqXLQaz4sCdgcvjS/ym/OzSBtkNroXuKdr7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4szVR/O76HqiTJlzrOTMqDMxaA5pR6qPc74y5Z8/h3U=;
        b=QTuy4906L79Q80u1KqkrwKDVDwLjo7EvJzKKtfL06MbZPZnRRlrL/3VEhKqFR1VXdZ
         Za2gTWudoV0/1xwTFFaNsIwsSc5Tee9qp7dn8gHVm08Y0sED4xYO/JczhmOVYL1cLYsY
         3rVd7hSVUpwKLcGyBAiEYW0NMBhfyLRV47bO7xNWfftat4+AWj1JsmD4KNWdmavxR3Ty
         8kMl7F9lQeqqznyc/OzdbvmmwItUTk6ldSiNnBqbf3rvsx0XCEPP4c883+xZ/V9OTVgj
         gAG2dBeXfAEIHNQrIVLooxx+sg3uAPvUrntdlLKgcRaktJmmi40zRTg8S2U1z06pXHlU
         zzEg==
X-Gm-Message-State: APjAAAV9YKja/FD/EXGLgmn+cT7Od+/ITdvFYhZlKOO4fsGStPHU78+K
        hJO18gGveeC7W9RuzrJWNz0V/vYHZ0rh7g==
X-Google-Smtp-Source: APXvYqxj5SRVgsq3O/Gwn8oooPHLc/dW0czt66T54dYmjbM6DgNMxWNsEGyBo24n2IW72OIFnogz8Q==
X-Received: by 2002:a05:651c:289:: with SMTP id b9mr15890456ljo.80.1574507274871;
        Sat, 23 Nov 2019 03:07:54 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id t17sm596932ljc.88.2019.11.23.03.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 03:07:54 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 1/8] bpf, sockmap: Return socket cookie on lookup from syscall
Date:   Sat, 23 Nov 2019 12:07:44 +0100
Message-Id: <20191123110751.6729-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191123110751.6729-1-jakub@cloudflare.com>
References: <20191123110751.6729-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tooling that populates the SOCKMAP with sockets from user-space needs a way
to inspect its contents. Returning the struct sock * that SOCKMAP holds to
user-space is neither safe nor useful. An approach established by
REUSEPORT_SOCKARRAY is to return a socket cookie (a unique identifier)
instead.

Since socket cookies are u64 values SOCKMAP needs to support such a value
size for lookup to be possible. This requires special handling on update,
though. Attempts to do a lookup on SOCKMAP holding u32 values will be met
with ENOSPC error.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index eb114ee419b6..e8460fdc597d 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -10,6 +10,7 @@
 #include <linux/skmsg.h>
 #include <linux/list.h>
 #include <linux/jhash.h>
+#include <linux/sock_diag.h>
 
 struct bpf_stab {
 	struct bpf_map map;
@@ -31,7 +32,8 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(-EPERM);
 	if (attr->max_entries == 0 ||
 	    attr->key_size    != 4 ||
-	    attr->value_size  != 4 ||
+	    (attr->value_size != sizeof(u32) &&
+	     attr->value_size != sizeof(u64)) ||
 	    attr->map_flags & ~SOCK_CREATE_FLAG_MASK)
 		return ERR_PTR(-EINVAL);
 
@@ -274,6 +276,23 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
+{
+	struct sock *sk;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	if (map->value_size != sizeof(u64))
+		return ERR_PTR(-ENOSPC);
+
+	sk = __sock_map_lookup_elem(map, *(u32 *)key);
+	if (!sk)
+		return ERR_PTR(-ENOENT);
+
+	sock_gen_cookie(sk);
+	return &sk->sk_cookie;
+}
+
 static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 			     struct sock **psk)
 {
@@ -399,12 +418,19 @@ static bool sock_map_sk_is_suitable(const struct sock *sk)
 static int sock_map_update_elem(struct bpf_map *map, void *key,
 				void *value, u64 flags)
 {
-	u32 ufd = *(u32 *)value;
 	u32 idx = *(u32 *)key;
 	struct socket *sock;
 	struct sock *sk;
+	u64 ufd;
 	int ret;
 
+	if (map->value_size == sizeof(u64))
+		ufd = *(u64 *)value;
+	else
+		ufd = *(u32 *)value;
+	if (ufd > S32_MAX)
+		return -EINVAL;
+
 	sock = sockfd_lookup(ufd, &ret);
 	if (!sock)
 		return ret;
@@ -500,6 +526,7 @@ const struct bpf_map_ops sock_map_ops = {
 	.map_alloc		= sock_map_alloc,
 	.map_free		= sock_map_free,
 	.map_get_next_key	= sock_map_get_next_key,
+	.map_lookup_elem_sys_only = sock_map_lookup_sys,
 	.map_update_elem	= sock_map_update_elem,
 	.map_delete_elem	= sock_map_delete_elem,
 	.map_lookup_elem	= sock_map_lookup,
-- 
2.20.1

