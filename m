Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD214A442
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 13:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgA0Mz7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 07:55:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39885 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgA0Mzv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 07:55:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id o11so10547330ljc.6
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 04:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eC0CkR7IbFG6bDxCz3dMivOibOCCpaaJ3Hu5W6QGrjg=;
        b=Y8DmGmBOBARcKoKVntkslzGfDEybnqtXWVcNiy1c3OA2IBMf5Lak2xU9gxmvidUPea
         9s1cLdP8INsLwhJ3J9i6ucAoOpQc0EN175daa993TqHOoHPU8oBbZWjHzYjVIoHCTbRx
         LiTJyePxhS/I79s6jGQZGAB8VdgXgNw3RAegs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eC0CkR7IbFG6bDxCz3dMivOibOCCpaaJ3Hu5W6QGrjg=;
        b=P/Zsj0HL1DkD8+GtmLxUAKXSbIoOk2vsGZH12s5NkV8gFTOv+RhxQCbvXi0sAerO+s
         pc7zOWqoSIBJWGgnqNYmp9cos4OI06e9C15bM6zk2Uj/J+IQQnVd4czKxUCGyT3Fg48d
         WWYUz0MxdC63+mQ2iT0G5yrqC5HQYYmjyzbmTuW01MKiafKrjV8lsvGeEKr1Q7PkRg8P
         grgL7VFMu437o3ixFbzMhIR+4rissheVvzK4AV3ItzZ/HcffglAdrcvVSO4LaEs3vvYt
         YtUmZq85iYUGV/yTuy8vvv+dJknVCYv417WOXawC85q4dwnFam1dUN8hFwy1p601+/+V
         drLA==
X-Gm-Message-State: APjAAAVz1y9ABy30pFzu4cBSJB9wyAxa+um73ivUHW7g7C0ymHwt6Cn6
        /JQiPZ8U6l0hvswbKPtwthg2xf/+OtJCEA==
X-Google-Smtp-Source: APXvYqzFwIouLUOSlzfAtQupujoyLs+otnLU8/OKBP1gc7S0nKmo4kvPvZtbgQiNLtCdFSvWlqHhlw==
X-Received: by 2002:a2e:914d:: with SMTP id q13mr10091410ljg.198.1580129748857;
        Mon, 27 Jan 2020 04:55:48 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id b13sm7998342lfi.77.2020.01.27.04.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 04:55:48 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v5 08/12] bpf, sockmap: Let all kernel-land lookup values in SOCKMAP
Date:   Mon, 27 Jan 2020 13:55:30 +0100
Message-Id: <20200127125534.137492-9-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127125534.137492-1-jakub@cloudflare.com>
References: <20200127125534.137492-1-jakub@cloudflare.com>
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

