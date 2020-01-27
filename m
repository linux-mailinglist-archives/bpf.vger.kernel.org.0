Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E91614A448
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 13:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgA0M4E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 07:56:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38411 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgA0Mzu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 07:55:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so10572643ljh.5
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 04:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G09HRGhwPdZDY62vjA1pLcudfQCy/8dGc2lbZn0Cidw=;
        b=v96dtw9LTgpW1iPBRIkpUk46nysZzf5TOP30IBdpi5iAR6Ig7gvxOCTBEoaBaBL9Ok
         WOPxtS+s8vaEvb6e4UQyyIj/D3FS/B3omvhXaUA5JVe1YqeQXkySFigTXOcMs7VtyzuG
         zsvpyxptfnnuo6eGkiqtJL7S4VjuthAeqNW1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G09HRGhwPdZDY62vjA1pLcudfQCy/8dGc2lbZn0Cidw=;
        b=ENYUbWtrZjIrgNgyBmdskKlzQpn1he3pndx4LHO9Q+1SAHIVbwA359N69zKUgnuU6B
         2LyhM+BlsQMw2htDlFRxqWzWerxmGkgEDmvAYweXzMGbuvz22P0uyZXFcAFCRGCc6+ef
         2KvICTph3DgrYRSgoq571qdxG7L2xTqciIcbyfeAoeEA8RHrv8r9H+++kglzjUy2WXBC
         i1aBMekyE3sVJct3liOTUOJngReLF8T3owqnEWsaB2Dmb3Mpuqj4vYymmjytB7zIyk//
         QUzeXkV6EdkM3O6dlhvPpyAbMv6h4hwfZBZYwJMop3+2OxQzOZ658NA4e7af0SWJmFgn
         36RA==
X-Gm-Message-State: APjAAAVyU8joTZU7BQmlG0zF5KNmyYFAqCBwyKphijYKxP/JItge/tbv
        pBr+0RpQsUV6Rb+BGnnvVI/ap4fFVHuPTA==
X-Google-Smtp-Source: APXvYqwxGJHA2eqk/1jpaTd620VaivgTDWMTJqJ5y905Q1ztdrXkhIf0xe4oKuSTnFwi680y8WFSwA==
X-Received: by 2002:a2e:88d6:: with SMTP id a22mr9451398ljk.163.1580129747303;
        Mon, 27 Jan 2020 04:55:47 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id y18sm851592ljm.93.2020.01.27.04.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 04:55:46 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v5 07/12] bpf, sockmap: Return socket cookie on lookup from syscall
Date:   Mon, 27 Jan 2020 13:55:29 +0100
Message-Id: <20200127125534.137492-8-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127125534.137492-1-jakub@cloudflare.com>
References: <20200127125534.137492-1-jakub@cloudflare.com>
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

