Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10BAE162BB1
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 18:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgBRRKk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Feb 2020 12:10:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33258 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgBRRKj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Feb 2020 12:10:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so24954259wrt.0
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2020 09:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AvILV5sd++2yz20AaI1JEY6SvwDzjXwDSBRjXm9Bc0I=;
        b=tYycTgws14HRJbxNRyzbkSeEbHByISs2Usq5DA6DAjL8JrFKMOU0eQOoPkf5nsidif
         G87FFDjQfqNsa/8sP+OQSiNuZ2Ly+/02EjY+tX5rLEBVCjmFWM1yhvOLVcIAGJ6boJuU
         cf74nWO2fjEeasJJXeYx9vL104A99k2SUSe/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvILV5sd++2yz20AaI1JEY6SvwDzjXwDSBRjXm9Bc0I=;
        b=O9YGyez0uuiAn5gfcZN9GFA/rT+NInf7ymwj+rxMz5Z1TEUZbGXiol7kI/jKxvIIcy
         5ZVwVngsZOH12h0lATEQPXRl7nGLK7GlAuHX/vp4UJK/qYPVlzEWghhd++cl9Vs+H/4Y
         P2YDMbt6Syh0vix4IyLFQpeWq+AL5nIx2yQ3uOcsoCR9JsZD5cXZFa2PLrzsDWbm2xnK
         PQIm7qqLmMTpj26StBUpe6Y9gtzXs34TzHjySL9g41Gv3c2oBN17lo+u3iu275stlwRG
         ocb+nlkPV55UF1dBI0PvDl3NI0Mf/Lan83aM1UE3ce+LqLmZwgaTphB8DjGZDWQGnaLf
         vY3A==
X-Gm-Message-State: APjAAAUIauHEMz1Pv1tSlSQuskjk65TiPT7GkgREzzhMQ3TAWdzpcvBb
        Uf91wSzp28fLaNosZH9N8ze7H180jf3Nc5yD
X-Google-Smtp-Source: APXvYqzgkX/Dp81uuzPESM84eHCfeMQu0td+58MoSVdM8sSwmTANs2ejb2oy/yHW8Pfj9J3KR8+C6w==
X-Received: by 2002:a5d:6089:: with SMTP id w9mr28568769wrt.94.1582045836782;
        Tue, 18 Feb 2020 09:10:36 -0800 (PST)
Received: from cloudflare.com ([88.157.168.82])
        by smtp.gmail.com with ESMTPSA id f8sm6984368wru.12.2020.02.18.09.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:10:36 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Martin Lau <kafai@fb.com>
Subject: [PATCH bpf-next v7 07/11] bpf, sockmap: Let all kernel-land lookup values in SOCKMAP/SOCKHASH
Date:   Tue, 18 Feb 2020 17:10:19 +0000
Message-Id: <20200218171023.844439-8-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218171023.844439-1-jakub@cloudflare.com>
References: <20200218171023.844439-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't require the kernel code, like BPF helpers, that needs access to
SOCK{MAP,HASH} map contents to live in net/core/sock_map.c. Expose the
lookup operation to all kernel-land.

Lookup from BPF context is not whitelisted yet. While syscalls have a
dedicated lookup handler.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f48c934d5da0..2e0f465295c3 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -301,7 +301,7 @@ static struct sock *__sock_map_lookup_elem(struct bpf_map *map, u32 key)
 
 static void *sock_map_lookup(struct bpf_map *map, void *key)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return __sock_map_lookup_elem(map, *(u32 *)key);
 }
 
 static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
@@ -991,6 +991,11 @@ static void *sock_hash_lookup_sys(struct bpf_map *map, void *key)
 	return &sk->sk_cookie;
 }
 
+static void *sock_hash_lookup(struct bpf_map *map, void *key)
+{
+	return __sock_hash_lookup_elem(map, key);
+}
+
 static void sock_hash_release_progs(struct bpf_map *map)
 {
 	psock_progs_drop(&container_of(map, struct bpf_htab, map)->progs);
@@ -1079,7 +1084,7 @@ const struct bpf_map_ops sock_hash_ops = {
 	.map_get_next_key	= sock_hash_get_next_key,
 	.map_update_elem	= sock_hash_update_elem,
 	.map_delete_elem	= sock_hash_delete_elem,
-	.map_lookup_elem	= sock_map_lookup,
+	.map_lookup_elem	= sock_hash_lookup,
 	.map_lookup_elem_sys_only = sock_hash_lookup_sys,
 	.map_release_uref	= sock_hash_release_progs,
 	.map_check_btf		= map_check_no_btf,
-- 
2.24.1

