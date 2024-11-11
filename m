Return-Path: <bpf+bounces-44544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE0F9C4849
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 22:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB9DB2E0ED
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648F1BBBE0;
	Mon, 11 Nov 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnyMOe+3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6F1BAEFC
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360575; cv=none; b=hnrKN3oDhlc3UniZ/QRWLiLLFYuALRG8SCNHBAx7HdjDfm9wAk/l0WH82wgsk0WffgtX+Qgfetr/pivTzmVy9eHMsteOmWP0+79I5f5zycAeb6GKLJdoNcADrWTn4UKjgKlcyZy5QC1wO33qjp8ajrd8HLk8zaqdil2j4WGyi2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360575; c=relaxed/simple;
	bh=7KjidYkLBcPZ+5VraYK57PAsVIiB/8sTVUkfl0oeW78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdJMVGy8kPOW/ffXR4GWxutUBkmiSGloyhzeow1wDQOaZ4rYyZPDwPXdx15fUVcU8jgOegUKIgdRVVAjo4stLlk33HEQ9FAqFhKCpyqbwO4T2vO/JyzeWkfBF/F18sxg+z+fmhxN7ndr/fAooqqeLF/OJOtihG3f1lD1mE8nv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnyMOe+3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso845853266b.3
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 13:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731360572; x=1731965372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYbybi1xb+8t2tFTa6T9Dlhs2DUIrFn1tCgEK2bmhvE=;
        b=LnyMOe+3M0nVXA+lJDSiqK83njW0clUD8IuP20ZPdUBFurpWmD7oZrwInsUs1rv3OO
         lPZeVvzZH7mW+BACJ9DoA5tiTo7L69hvr0rFZa/Fixavfs23cygID5F9Ix6JpVI3VbBR
         c7fi+HjPjJFst5Wc5BYo5VzFm7Mftglheg08mD8lrpeD3gVS3+cS++HQlYh6XqJsgO6M
         h128MtK1HLhdgf21mehatwyI5UHeeUm9x7w7b1jhMZ8WBpn7Omgl5eg0CGRVUjROtT6G
         lOaRRpbw4dV/dRQoFbtLwCjvbbUeKHx7zku+rC8VCsZH3zv708pS71g3e7bG0CjqNnb/
         dUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731360572; x=1731965372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYbybi1xb+8t2tFTa6T9Dlhs2DUIrFn1tCgEK2bmhvE=;
        b=S1tl2PpfYL2EZZa4DiQJFsiXrqMzDsYiS4otXr4d7MctLoPyz8liaw3bf7+eFF5u4G
         zXMhieZSBdUT6PJ7jnliMOae0sK39AqFmtW/9uJJJ0X0TLJVfpVqHCMabg1cr3+r09xy
         bw9i3PUouaRYJcweo76ytUHPNL4WCGUZLih92rDZuEY3uykfATL7P45tEYkfjEZOi0Lt
         ldhzg6FV76ZRMHLZ6X743/Z+MmP6INM8f2T4pUcGeCnLdPhV4cj7RwFL0otsXDYaXRi7
         1hYk/1VpcxMoSSL9zsIPhDbxkslCHuci4W5dNAzNotFqRIdbNguHxi/sQ1LhzmeE7Wbn
         deZw==
X-Gm-Message-State: AOJu0YweVfsLnT8q72gzN96tOxsAV7vE4DncUvWSA/AeqwmoOtS6kI/6
	5N0uGMq/4KDVpNZ0ogDKOf4AHcQqKxSgyxuMn3hQHSwuI5aq+1oBHXUSrA==
X-Google-Smtp-Source: AGHT+IHE62kYpVgf17skZnQC+J0KDxhXJ2eeIHCFFT8MCdLaHFL7X9IwxhSJsJfCHMmlSJrQZmR9hg==
X-Received: by 2002:a17:907:9815:b0:a9a:bcd:b726 with SMTP id a640c23a62f3a-a9eeff25c74mr1376336566b.25.1731360571558;
        Mon, 11 Nov 2024 13:29:31 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::5:3961])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defc3csm629570266b.166.2024.11.11.13.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:29:31 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 3/4] libbpf: stringify errno in log messages in btf*.c
Date: Mon, 11 Nov 2024 21:29:18 +0000
Message-ID: <20241111212919.368971-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111212919.368971-1-mykyta.yatsenko5@gmail.com>
References: <20241111212919.368971-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Convert numeric error codes into the string representations in log
messages in btf.c and btf_dump.c.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/btf.c      | 26 ++++++++++++++------------
 tools/lib/bpf/btf_dump.c |  3 ++-
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index e9673c0ecbe7..8befb8103e32 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -22,6 +22,7 @@
 #include "libbpf_internal.h"
 #include "hashmap.h"
 #include "strset.h"
+#include "str_error.h"
 
 #define BTF_MAX_NR_TYPES 0x7fffffffU
 #define BTF_MAX_STR_OFFSET 0x7fffffffU
@@ -1179,7 +1180,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	fd = open(path, O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		err = -errno;
-		pr_warn("failed to open %s: %s\n", path, strerror(errno));
+		pr_warn("failed to open %s: %s\n", path, errstr(err));
 		return ERR_PTR(err);
 	}
 
@@ -1445,7 +1446,7 @@ int btf_load_into_kernel(struct btf *btf,
 			goto retry_load;
 
 		err = -errno;
-		pr_warn("BTF loading error: %d\n", err);
+		pr_warn("BTF loading error: %s\n", errstr(err));
 		/* don't print out contents of custom log_buf */
 		if (!log_buf && buf[0])
 			pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END BTF LOAD LOG --\n", buf);
@@ -3464,42 +3465,42 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 
 	err = btf_dedup_prep(d);
 	if (err) {
-		pr_debug("btf_dedup_prep failed:%d\n", err);
+		pr_debug("btf_dedup_prep failed: %s\n", errstr(err));
 		goto done;
 	}
 	err = btf_dedup_strings(d);
 	if (err < 0) {
-		pr_debug("btf_dedup_strings failed:%d\n", err);
+		pr_debug("btf_dedup_strings failed: %s\n", errstr(err));
 		goto done;
 	}
 	err = btf_dedup_prim_types(d);
 	if (err < 0) {
-		pr_debug("btf_dedup_prim_types failed:%d\n", err);
+		pr_debug("btf_dedup_prim_types failed: %s\n", errstr(err));
 		goto done;
 	}
 	err = btf_dedup_struct_types(d);
 	if (err < 0) {
-		pr_debug("btf_dedup_struct_types failed:%d\n", err);
+		pr_debug("btf_dedup_struct_types failed: %s\n", errstr(err));
 		goto done;
 	}
 	err = btf_dedup_resolve_fwds(d);
 	if (err < 0) {
-		pr_debug("btf_dedup_resolve_fwds failed:%d\n", err);
+		pr_debug("btf_dedup_resolve_fwds failed: %s\n", errstr(err));
 		goto done;
 	}
 	err = btf_dedup_ref_types(d);
 	if (err < 0) {
-		pr_debug("btf_dedup_ref_types failed:%d\n", err);
+		pr_debug("btf_dedup_ref_types failed: %s\n", errstr(err));
 		goto done;
 	}
 	err = btf_dedup_compact_types(d);
 	if (err < 0) {
-		pr_debug("btf_dedup_compact_types failed:%d\n", err);
+		pr_debug("btf_dedup_compact_types failed: %s\n", errstr(err));
 		goto done;
 	}
 	err = btf_dedup_remap_types(d);
 	if (err < 0) {
-		pr_debug("btf_dedup_remap_types failed:%d\n", err);
+		pr_debug("btf_dedup_remap_types failed: %s\n", errstr(err));
 		goto done;
 	}
 
@@ -5218,7 +5219,8 @@ struct btf *btf__load_vmlinux_btf(void)
 		btf = btf__parse(sysfs_btf_path, NULL);
 		if (!btf) {
 			err = -errno;
-			pr_warn("failed to read kernel BTF from '%s': %d\n", sysfs_btf_path, err);
+			pr_warn("failed to read kernel BTF from '%s': %s\n",
+				sysfs_btf_path, errstr(err));
 			return libbpf_err_ptr(err);
 		}
 		pr_debug("loaded kernel BTF from '%s'\n", sysfs_btf_path);
@@ -5235,7 +5237,7 @@ struct btf *btf__load_vmlinux_btf(void)
 
 		btf = btf__parse(path, NULL);
 		err = libbpf_get_error(btf);
-		pr_debug("loading kernel BTF '%s': %d\n", path, err);
+		pr_debug("loading kernel BTF '%s': %s\n", path, errstr(err));
 		if (err)
 			continue;
 
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 468392f9882d..a3fc6908f6c9 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -21,6 +21,7 @@
 #include "hashmap.h"
 #include "libbpf.h"
 #include "libbpf_internal.h"
+#include "str_error.h"
 
 static const char PREFIXES[] = "\t\t\t\t\t\t\t\t\t\t\t\t\t";
 static const size_t PREFIX_CNT = sizeof(PREFIXES) - 1;
@@ -1304,7 +1305,7 @@ static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
 			 * chain, restore stack, emit warning, and try to
 			 * proceed nevertheless
 			 */
-			pr_warn("not enough memory for decl stack: %d\n", err);
+			pr_warn("not enough memory for decl stack: %s\n", errstr(err));
 			d->decl_stack_cnt = stack_start;
 			return;
 		}
-- 
2.47.0


