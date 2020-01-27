Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22B14A49F
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 14:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgA0NLN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 08:11:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46437 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA0NLL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 08:11:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id x14so8225845ljd.13
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 05:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G09HRGhwPdZDY62vjA1pLcudfQCy/8dGc2lbZn0Cidw=;
        b=M/DcS4G+s7Pax+Nuz01O1O/cdaVv8YHSokZtrTgXfDTuXnUpwVj+TDdx3SRcZf8DNV
         gdn9nQMUAyrH3Kfb5crQs6sbBp83znEXqd+upeZTm/dUmIYDgQE2ysnH4Aa1ySA9wXoI
         DRBkyZg1xeZXFiRbxAr6ya+vpqhAUdAm4nP6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G09HRGhwPdZDY62vjA1pLcudfQCy/8dGc2lbZn0Cidw=;
        b=srT/HyfjKTAG1Vml67AKVWFWoB7FpCkvZRATA2kKI6bMR0h5SPJqlwdk2YTDzmWmd9
         /BLYKwbroa/MyhoX7v9RBEoEHcFzYDU0TR3VQ8yf76IU5P4JPAAas3A9lF2OXQfUvGfV
         lUnHzyLFVCg9pLipqDpsZNaBvjfo8Dcn/Q8dBYDkQgDcp7rPySzCH+9Tg1DnrDujkjdv
         fijbJPjGqtsup9VvkahHwTVgQGnTm4cPgN6szEa+EsohA0Qo8x5ZpbJG3ueoXZha0TE9
         mc3wT1y3EZqh5TOR/mP6bcaQGWUPmCwARD6cLOwCdJLCyZjSkr9tNOugJhLFzrB01uXX
         fBTw==
X-Gm-Message-State: APjAAAWCxzvKMfR1n/Rv/67T4M6EvlSu08dBeANMoZLB5DyUBmsbjzRK
        pQZBE2x5fBOHJOBpF4IMQUyRUw6ZzEQ/FA==
X-Google-Smtp-Source: APXvYqxa1AEgw0TJcjsP64HDmI9tfsadNfQb4NDheOM5Q70uf+9h1QGWfEEdDOaESvV/Jb4Ef3IoDw==
X-Received: by 2002:a05:651c:86:: with SMTP id 6mr7764274ljq.193.1580130669562;
        Mon, 27 Jan 2020 05:11:09 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id r15sm8105444ljh.11.2020.01.27.05.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 05:11:09 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v6 07/12] bpf, sockmap: Return socket cookie on lookup from syscall
Date:   Mon, 27 Jan 2020 14:10:52 +0100
Message-Id: <20200127131057.150941-8-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127131057.150941-1-jakub@cloudflare.com>
References: <20200127131057.150941-1-jakub@cloudflare.com>
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

Since socket cookies are u64 values, SOCKMAP needs to support such a value
size for lookup to be possible. This requires special handling on update,
though. Attempts to do a lookup on SOCKMAP holding u32 values will be met
with ENOSPC error.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index cadae12bb3d4..71d0a21e6db1 100644
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
 
@@ -301,6 +303,21 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
+{
+	struct sock *sk;
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
@@ -462,12 +479,19 @@ static bool sock_hash_sk_is_suitable(const struct sock *sk)
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
@@ -571,6 +595,7 @@ const struct bpf_map_ops sock_map_ops = {
 	.map_alloc		= sock_map_alloc,
 	.map_free		= sock_map_free,
 	.map_get_next_key	= sock_map_get_next_key,
+	.map_lookup_elem_sys_only = sock_map_lookup_sys,
 	.map_update_elem	= sock_map_update_elem,
 	.map_delete_elem	= sock_map_delete_elem,
 	.map_lookup_elem	= sock_map_lookup,
-- 
2.24.1

