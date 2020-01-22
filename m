Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B91454C3
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 14:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAVNGG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 08:06:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46904 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbgAVNGG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 08:06:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id m26so6658999ljc.13
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2020 05:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnfQTb/oMmNZbNj4Xo4mm6Wr12Q7k7FRLMMU2huOCf8=;
        b=RJkS+IKF9nU/1gJLoTFVdKLurug9Mnj5zkfe6K+3WXC5uJqWkXWLyIZN+5lphiHweT
         CYBqQtt9eQFeb3ryi3x6aZSj8JXbRMQyQL4dLxn61x09yx2LLyIDEBtnmV7ItXqWupMs
         bb6CNgG+nnB10vPnVG91cng2q9ZQH71R8uWI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnfQTb/oMmNZbNj4Xo4mm6Wr12Q7k7FRLMMU2huOCf8=;
        b=QzskkqxQpciNr+ZOU/eKUNYByTWqSNrMW1Oev/c0YTATqqF/oRFstFgfvGXaVwgFea
         StkHpM0GVTa8rJMmlpp2iSCrvjPjjkEz8LHJdyGARA3qbx5S8NNjqBCjbvzrkcCDfzy7
         XrR9sHOHL20NU5PxRC4tJce63FyiWN12OtAPcC4U7fw8Mjnbw2DV/HkKvX+Svikzqmql
         vqRB9ttFSuF+RQhlctcn1Dc4eNIWqN6m2lMvmgDTpTMnVP33tMf3bOn9La0lTbdzp6St
         ngbVk8zANF3erC5Cdj7Ffc5AcUq7r9omP/lJKeNHrdPHBlKisKYhEGTPwTPeU0ZTtycT
         hVnQ==
X-Gm-Message-State: APjAAAWFVA7w0chOVLHa/m9NK+XFXdrmH8q52FVRcpVFlIZNSd8HIj//
        J5jEotVPd4pPXsJqVsPI5xvJG2HL/xRW8w==
X-Google-Smtp-Source: APXvYqw1qG6jOD3kWcLw8icSAux4ph5fexaqunOgVLqzTLkmtCEAqreZAhvAMbGZTPwzxnDY9ShoRw==
X-Received: by 2002:a2e:916:: with SMTP id 22mr19539505ljj.60.1579698363335;
        Wed, 22 Jan 2020 05:06:03 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id e17sm20374532ljg.101.2020.01.22.05.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 05:06:02 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Martin Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 08/12] bpf, sockmap: Let all kernel-land lookup values in SOCKMAP
Date:   Wed, 22 Jan 2020 14:05:45 +0100
Message-Id: <20200122130549.832236-9-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122130549.832236-1-jakub@cloudflare.com>
References: <20200122130549.832236-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't require the kernel code, like BPF helpers, that needs access to
SOCKMAP map contents to live in net/core/sock_map.c. Expose the SOCKMAP
lookup operation to all kernel-land.

Lookup from BPF context is not whitelisted yet. While syscalls have a
dedicated lookup handler.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index cabe85892ba3..839c17e01b2e 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -297,7 +297,7 @@ static struct sock *__sock_map_lookup_elem(struct bpf_map *map, u32 key)
 
 static void *sock_map_lookup(struct bpf_map *map, void *key)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return __sock_map_lookup_elem(map, *(u32 *)key);
 }
 
 static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
@@ -965,6 +965,11 @@ static void sock_hash_free(struct bpf_map *map)
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
@@ -1044,7 +1049,7 @@ const struct bpf_map_ops sock_hash_ops = {
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

