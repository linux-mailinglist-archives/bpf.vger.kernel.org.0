Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E2107E1F
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2019 12:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKWLIA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Nov 2019 06:08:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44903 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKWLIA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 06:08:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so6395458lfa.11
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2019 03:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/p7I6bXbQZAl+3KkycvGgFqY+FUZZbVXBBY92/0QKE=;
        b=ciCn81CzFNs4aQILLBfwUm46QQjUXKLy+AGRgfMdn67K1coc6luN3zMbsipVG/bM/T
         nVdcaKceJIPBhzfLUVU5vHeuFFFt7okRYSPIWbppXrGNKBbneBJNFGVnLraYTkzcvuq8
         bKDkTgxZjKq7xzD7Oie/GBMiOamjERi/AlGZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/p7I6bXbQZAl+3KkycvGgFqY+FUZZbVXBBY92/0QKE=;
        b=Pt6JcmoV3x10s/39IjFL1Eo/22klZG4k6BUjkF2u3FKdFtGPcX6+S4QoFk6FaEmbkh
         kW2tZhUpI6Rb5aeQnrsRuVyDGrQDuGnnkwutneh0j06QZLgj64HSr6cqV5mQBA/ALncA
         mw8Gw+3NFwflLPycmo6auj8+uIjyl4c8lj3SvuhuknjhX6Hv3JerOFYazoPobfBOI+bS
         J3fdEj3bo3gu6mS1yBdNmfTsX3Dx5GprcRS+cY9L5DvNC/Fhw3lXDZa0b2jdlF9tYheO
         jrVY8DY+FVBfuGMm6zBNMPScG0Z5ccntI25Hj8NQqhLIqLDiLRXmP/5kO/6nhJ0YBfr+
         NnYg==
X-Gm-Message-State: APjAAAWSmbUlhOKZU+MFVPLoSdIWEZYudomSMFrqBOa4wi4Z+gw/6/EQ
        p3K7R2XFmeQ9vM0waR3XNC5amo5GvGQvHg==
X-Google-Smtp-Source: APXvYqxpeXUzIyLE/+zJPIOhC2p7y7qQFkqXvNBSca+HirJQUZFb3bEWMCQ9HVEOcAREj3F9YBYT3w==
X-Received: by 2002:a19:8c1c:: with SMTP id o28mr14728835lfd.105.1574507276356;
        Sat, 23 Nov 2019 03:07:56 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id c12sm603574ljk.77.2019.11.23.03.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 03:07:55 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 2/8] bpf, sockmap: Let all kernel-land lookup values in SOCKMAP
Date:   Sat, 23 Nov 2019 12:07:45 +0100
Message-Id: <20191123110751.6729-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191123110751.6729-1-jakub@cloudflare.com>
References: <20191123110751.6729-1-jakub@cloudflare.com>
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
index e8460fdc597d..9f572d56e81a 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -273,7 +273,7 @@ static struct sock *__sock_map_lookup_elem(struct bpf_map *map, u32 key)
 
 static void *sock_map_lookup(struct bpf_map *map, void *key)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return __sock_map_lookup_elem(map, *(u32 *)key);
 }
 
 static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
@@ -899,6 +899,11 @@ static void sock_hash_free(struct bpf_map *map)
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
@@ -978,7 +983,7 @@ const struct bpf_map_ops sock_hash_ops = {
 	.map_get_next_key	= sock_hash_get_next_key,
 	.map_update_elem	= sock_hash_update_elem,
 	.map_delete_elem	= sock_hash_delete_elem,
-	.map_lookup_elem	= sock_map_lookup,
+	.map_lookup_elem	= sock_hash_lookup,
 	.map_release_uref	= sock_hash_release_progs,
 	.map_check_btf		= map_check_no_btf,
 };
-- 
2.20.1

