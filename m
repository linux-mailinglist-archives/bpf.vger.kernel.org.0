Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509CC14A4AB
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 14:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgA0NLZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 08:11:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34240 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgA0NLN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 08:11:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so6162646lfc.1
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 05:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eC0CkR7IbFG6bDxCz3dMivOibOCCpaaJ3Hu5W6QGrjg=;
        b=tJ+sPj7Vz0gbEnV6wJVNPWyqvGbBupr3Hr1L0OlPU5+WpLLZHKnwaIrcfsy6wW0xgW
         RhGHSuXln1d8DQ9CEzoKbIsiap3YVPC717E+8ffntJwoyWQJspHDnyv+5nVGIm8z8ECH
         pe/Qw874MA8nTueLqhpd5Sg/lq3Q3/X3Ycs34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eC0CkR7IbFG6bDxCz3dMivOibOCCpaaJ3Hu5W6QGrjg=;
        b=HPSS7o+/fRThRV3P9k21lchFNTsCQnPkysIwvj8lD3gUeD2khoJrUiQL6ppGT6L9sX
         y0xtbn3BeHaeHUkS9u+4aLnC6rO6PK2lfbvPpiZhuaCPYpNrDa2uwVbRCmKjpVt9K1Ld
         b8BHxht7nv9GpnbZx2VZ/6Frc8ynW7FhlHYKo9jeyNQK0r9KxmihvJCxE2contpRVUZn
         h3KjHUPW8IpO9eG0L7Gw+RCk3sL+Fq/6nPVkF52JWvWzQCUr8Cqsw1sM24k9Rsu4gjz5
         gHFst43ACZSKxSkSy3A0LS0H+k9t/ynWoqT59XaBKaEeguYV06A60w/phmn65WH3Obib
         AUJw==
X-Gm-Message-State: APjAAAUYGmK3tykx4KKzemEO11YS4zk/4hZ0qlEV3Xw5bY6MXpMStAWx
        704d79UhkN9hNyR6m/5Gi9cuahar4kM3Xw==
X-Google-Smtp-Source: APXvYqzLgMXpYlkmUZyMlRObE/MZFGz2MqtBCUghAhyndKaZwHfs76SAGY01Urh40n5X1aHQ0wgLTg==
X-Received: by 2002:a19:cc11:: with SMTP id c17mr8028556lfg.161.1580130670986;
        Mon, 27 Jan 2020 05:11:10 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id d9sm8129534lja.73.2020.01.27.05.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 05:11:10 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v6 08/12] bpf, sockmap: Let all kernel-land lookup values in SOCKMAP
Date:   Mon, 27 Jan 2020 14:10:53 +0100
Message-Id: <20200127131057.150941-9-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127131057.150941-1-jakub@cloudflare.com>
References: <20200127131057.150941-1-jakub@cloudflare.com>
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

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 71d0a21e6db1..2cbde385e1a0 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -300,7 +300,7 @@ static struct sock *__sock_map_lookup_elem(struct bpf_map *map, u32 key)
 
 static void *sock_map_lookup(struct bpf_map *map, void *key)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return __sock_map_lookup_elem(map, *(u32 *)key);
 }
 
 static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
@@ -969,6 +969,11 @@ static void sock_hash_free(struct bpf_map *map)
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
@@ -1048,7 +1053,7 @@ const struct bpf_map_ops sock_hash_ops = {
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

