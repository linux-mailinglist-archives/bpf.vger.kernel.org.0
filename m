Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73909136B5D
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 11:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgAJKuq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jan 2020 05:50:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36618 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgAJKum (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jan 2020 05:50:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so1477237wma.1
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 02:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0Aj0VLYUwGMhJ4GNkWeTIBSGefgbFRBwyuWeyL3e58=;
        b=RF9X9I26tgK8y3bpWYudKhQ7JksPz+FHhZfm4yDfFEgxyZ1QLxQ2QNjkVfLs5UYD8V
         e8dMZqb114RYX+j/ab5qJfB5LLSqdv5LiCKKfMpZ1lVT/bSdakwqFHhvpPX9CtUPjQQm
         ckfyUImqwj3TLYY6xdkub5qjdViifW+RLadWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0Aj0VLYUwGMhJ4GNkWeTIBSGefgbFRBwyuWeyL3e58=;
        b=QnUajA3fUlLQQVnHdPSWXv0WQhhf3DpdCinY8dR/1dlJEhcabQRlB9nc5t1dLukoC1
         uCjFkP/ClhQPXZjfkPApNL0sz2DsUdATb/4RYNVC/TFN6EZaJLcXq+7HRsm9SRxIeyOH
         1xMhFRKgulKXzCIu05vGW1eNZ8Yy2ZCw07hKPRaum7zTG8YKoYnEZgY0wB5MXpril0d/
         vVpKPAecjkHZIU6a1BkEF9kywOmWHOBWRv5/D9WWEO57HvVvQoIGg4h1jYae7Z7T5RRq
         ZD9A3QujGSDS/odLafoSlwHykYQsryO3+3J4Lg8mv3M+1oTxMoUrdIJ50xoL/+g4MIDc
         eX6w==
X-Gm-Message-State: APjAAAWXNI99mNrizJysMXt52sAaIe18WGJsyrQrepKOIKAxKmi61STd
        c9pjCTLmVZYeqYhrbB0XvSxi4YujINGtOg==
X-Google-Smtp-Source: APXvYqzBeW7j2u73cjVsz15Us1l27ET1S6P39Qtvz4fwAQTRPHoPp/8LgBK3uVLWXz7/i8mVIndttQ==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr3329645wmb.17.1578653440356;
        Fri, 10 Jan 2020 02:50:40 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id f16sm1738068wrm.65.2020.01.10.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 02:50:39 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v2 08/11] bpf, sockmap: Let all kernel-land lookup values in SOCKMAP
Date:   Fri, 10 Jan 2020 11:50:24 +0100
Message-Id: <20200110105027.257877-9-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110105027.257877-1-jakub@cloudflare.com>
References: <20200110105027.257877-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't require the kernel code, like BPF helpers, that needs access to
SOCKMAP map contents to live in the sock_map module. Expose the SOCKMAP
lookup operation to all kernel-land.

Lookup from BPF context is not whitelisted yet. While syscalls have a
dedicated lookup handler.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 3731191a7d1e..a046c86a8362 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -297,7 +297,7 @@ static struct sock *__sock_map_lookup_elem(struct bpf_map *map, u32 key)
 
 static void *sock_map_lookup(struct bpf_map *map, void *key)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return __sock_map_lookup_elem(map, *(u32 *)key);
 }
 
 static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
@@ -961,6 +961,11 @@ static void sock_hash_free(struct bpf_map *map)
 	kfree(htab);
 }
 
+static void *sock_hash_lookup(struct bpf_map *map, void *key)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static void sock_hash_release_progs(struct bpf_map *map)
 {
 	psock_progs_drop(&container_of(map, struct bpf_htab, map)->progs);
@@ -1040,7 +1045,7 @@ const struct bpf_map_ops sock_hash_ops = {
 	.map_get_next_key	= sock_hash_get_next_key,
 	.map_update_elem	= sock_hash_update_elem,
 	.map_delete_elem	= sock_hash_delete_elem,
-	.map_lookup_elem	= sock_map_lookup,
+	.map_lookup_elem	= sock_hash_lookup,
 	.map_release_uref	= sock_hash_release_progs,
 	.map_check_btf		= map_check_no_btf,
 };
-- 
2.24.1

