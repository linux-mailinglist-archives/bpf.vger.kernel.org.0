Return-Path: <bpf+bounces-44546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52289C4810
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 22:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74665282AC8
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A31D1B9B50;
	Mon, 11 Nov 2024 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGIc/Szs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3351BB6B5
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360579; cv=none; b=OZAIqEgDzXGwW+XtZL4GWRpEJH2YiWTivXiIXkqFW5hic3w+bH/VlA+fszxLSQ5c3sSEdT1cQpoAWweyNs+g6sxQ46hqhwOqUpu54AEpRT+hk3/QI9WsUcjkntgoPw/YWgPuZFs7vC9Ixm/mYNjgRhJh3CE7dPtmSvwEE3+284Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360579; c=relaxed/simple;
	bh=RTx3ofl9R/STlvQgzlvU0EM6qkahssKn7DU2RfUiYac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO6NCvW5X89KykXv4a0AQiX86Vdggy3buyIkTlpoC4/cCO/aYU67INprNC8dNC6iVXY9cjQaOm9SShaPQqutr8DGy7jJXGkQzQyuk4Ur3hShXzlq7Ie2DlQFUgH3/GPKVVteuAHwTNZsY8ESPYXW7MHMbHNS/ebkfb4TDau/NZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGIc/Szs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so765711566b.1
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 13:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731360574; x=1731965374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n1X1M4Lrx55Hf6PeWVJiVOPOhqpgDUN+JrBtOQtPmU=;
        b=BGIc/SzsGCJLUNq+9v59G89DBDZcPFfvkfITgAo7FnyEjS5m3DKYv0kZb7VRqr3Ifz
         ABbeVTm4AFlQ4b3ZIerdKO716Xo35y/+xsAS2RZZxB8aXmYzuz3osUxlZVESZfdT/C1y
         05uzmsR/O+PlMKBao78ifE4DrvaxyksWFSRON05pm472io3jYBf7+LskejrOrY0H9CFo
         bvQmIMuGLedoapqHC/iPAFVcrS/L5yA8kPqGFwnwe88m5BYSwbPqvDqZI3EVSpkIygPb
         TeOTpERRDMRFZhT6/ufNRnK1ZFqOLrkF1OcYMroAvWSEUk7DA5/c1eITjQ6s4X6K1Xdw
         PcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731360574; x=1731965374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4n1X1M4Lrx55Hf6PeWVJiVOPOhqpgDUN+JrBtOQtPmU=;
        b=aYYZkdFpHM9u9MFtKjURdgwWhueThKhfMpx7Oh+7iIhYVFXRMU5tewSXjSjbIlbjsp
         DCxeEoElCgVh3dDvZE01AVqVfqrgM9+EFMgQFhIKyKQyoLjOu2AjklWrD1AlfVxy046T
         vBgAXWRNYI010h2khNUtbWLwvN/GZ5ziy3AWdLpDH94hXn3tj2PBf1vdGZtp948CkplS
         Mez+Wvuu4KV+YEEQ2s8TfWT5HZJ0dgDRDoS794Ue7F8Uu63+5Xir3jYUuyQvgNCiNPF0
         6sPZ8rGXbRPsuCzjFodmO1Foe5o/nM5fd9cIoujraYv5Uhk3v+1JenGgrHYZsCBAy5Dh
         10LQ==
X-Gm-Message-State: AOJu0YyyF9aaxklB4HOrWIg3jE7+XeaELDEQITRG5pn0+zKLQJdJCpOL
	KO8rqIxZgR/GyqZ0YLWzMCFeSeXDf6klha1MoPD6EsGuA+9f4vCk8YrlgQ==
X-Google-Smtp-Source: AGHT+IFtedNRkUIqe7kaqdilevo6I3oEAAFZUPfNWbaoOoQQyIE5yKU/9fFpHnFIhw7qAxjPidDNVQ==
X-Received: by 2002:a17:907:961f:b0:a9a:420c:d1a6 with SMTP id a640c23a62f3a-a9eeffee0a2mr1401885266b.48.1731360573855;
        Mon, 11 Nov 2024 13:29:33 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::5:3961])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defc3csm629570266b.166.2024.11.11.13.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:29:32 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 4/4] libbpf: stringify errno in log messages in the remaining code
Date: Mon, 11 Nov 2024 21:29:19 +0000
Message-ID: <20241111212919.368971-5-mykyta.yatsenko5@gmail.com>
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
messages in the rest of libbpf source files.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/elf.c        |  4 +---
 tools/lib/bpf/features.c   | 15 ++++++---------
 tools/lib/bpf/gen_loader.c |  3 ++-
 tools/lib/bpf/linker.c     | 21 ++++++++++++---------
 tools/lib/bpf/ringbuf.c    | 34 ++++++++++++++++++----------------
 tools/lib/bpf/usdt.c       | 32 +++++++++++++++++---------------
 6 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index b5ab1cb13e5e..823f83ad819c 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -24,7 +24,6 @@
 
 int elf_open(const char *binary_path, struct elf_fd *elf_fd)
 {
-	char errmsg[STRERR_BUFSIZE];
 	int fd, ret;
 	Elf *elf;
 
@@ -38,8 +37,7 @@ int elf_open(const char *binary_path, struct elf_fd *elf_fd)
 	fd = open(binary_path, O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		ret = -errno;
-		pr_warn("elf: failed to open %s: %s\n", binary_path,
-			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
+		pr_warn("elf: failed to open %s: %s\n", binary_path, errstr(ret));
 		return ret;
 	}
 	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 50befe125ddc..760657f5224c 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -47,7 +47,6 @@ static int probe_kern_prog_name(int token_fd)
 
 static int probe_kern_global_data(int token_fd)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] = {
 		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 16),
 		BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 42),
@@ -67,9 +66,8 @@ static int probe_kern_global_data(int token_fd)
 	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_global", sizeof(int), 32, 1, &map_opts);
 	if (map < 0) {
 		ret = -errno;
-		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
-		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
-			__func__, cp, -ret);
+		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
+			__func__, errstr(ret));
 		return ret;
 	}
 
@@ -267,7 +265,6 @@ static int probe_kern_probe_read_kernel(int token_fd)
 
 static int probe_prog_bind_map(int token_fd)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -285,9 +282,8 @@ static int probe_prog_bind_map(int token_fd)
 	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int), 32, 1, &map_opts);
 	if (map < 0) {
 		ret = -errno;
-		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
-		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
-			__func__, cp, -ret);
+		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
+			__func__, errstr(ret));
 		return ret;
 	}
 
@@ -604,7 +600,8 @@ bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_
 		} else if (ret == 0) {
 			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
 		} else {
-			pr_warn("Detection of kernel %s support failed: %d\n", feat->desc, ret);
+			pr_warn("Detection of kernel %s support failed: %s\n",
+				feat->desc, errstr(ret));
 			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
 		}
 	}
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 8a2b0f62d91d..113ae4abd345 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -14,6 +14,7 @@
 #include "bpf_gen_internal.h"
 #include "skel_internal.h"
 #include <asm/byteorder.h>
+#include "str_error.h"
 
 #define MAX_USED_MAPS	64
 #define MAX_USED_PROGS	32
@@ -393,7 +394,7 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 			      blob_fd_array_off(gen, i));
 	emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
 	emit(gen, BPF_EXIT_INSN());
-	pr_debug("gen: finish %d\n", gen->error);
+	pr_debug("gen: finish %s\n", errstr(gen->error));
 	if (!gen->error) {
 		struct gen_loader_opts *opts = gen->opts;
 
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index f83c1c29982c..cf71d149fe26 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -20,6 +20,7 @@
 #include "btf.h"
 #include "libbpf_internal.h"
 #include "strset.h"
+#include "str_error.h"
 
 #define BTF_EXTERN_SEC ".extern"
 
@@ -306,7 +307,7 @@ static int init_output_elf(struct bpf_linker *linker, const char *file)
 	linker->fd = open(file, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0644);
 	if (linker->fd < 0) {
 		err = -errno;
-		pr_warn("failed to create '%s': %d\n", file, err);
+		pr_warn("failed to create '%s': %s\n", file, errstr(err));
 		return err;
 	}
 
@@ -560,7 +561,7 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 	obj->fd = open(filename, O_RDONLY | O_CLOEXEC);
 	if (obj->fd < 0) {
 		err = -errno;
-		pr_warn("failed to open file '%s': %d\n", filename, err);
+		pr_warn("failed to open file '%s': %s\n", filename, errstr(err));
 		return err;
 	}
 	obj->elf = elf_begin(obj->fd, ELF_C_READ_MMAP, NULL);
@@ -670,7 +671,8 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 				obj->btf = btf__new(data->d_buf, shdr->sh_size);
 				err = libbpf_get_error(obj->btf);
 				if (err) {
-					pr_warn("failed to parse .BTF from %s: %d\n", filename, err);
+					pr_warn("failed to parse .BTF from %s: %s\n",
+						filename, errstr(err));
 					return err;
 				}
 				sec->skipped = true;
@@ -680,7 +682,8 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 				obj->btf_ext = btf_ext__new(data->d_buf, shdr->sh_size);
 				err = libbpf_get_error(obj->btf_ext);
 				if (err) {
-					pr_warn("failed to parse .BTF.ext from '%s': %d\n", filename, err);
+					pr_warn("failed to parse .BTF.ext from '%s': %s\n",
+						filename, errstr(err));
 					return err;
 				}
 				sec->skipped = true;
@@ -2774,14 +2777,14 @@ static int finalize_btf(struct bpf_linker *linker)
 
 	err = finalize_btf_ext(linker);
 	if (err) {
-		pr_warn(".BTF.ext generation failed: %d\n", err);
+		pr_warn(".BTF.ext generation failed: %s\n", errstr(err));
 		return err;
 	}
 
 	opts.btf_ext = linker->btf_ext;
 	err = btf__dedup(linker->btf, &opts);
 	if (err) {
-		pr_warn("BTF dedup failed: %d\n", err);
+		pr_warn("BTF dedup failed: %s\n", errstr(err));
 		return err;
 	}
 
@@ -2799,7 +2802,7 @@ static int finalize_btf(struct bpf_linker *linker)
 
 	err = emit_elf_data_sec(linker, BTF_ELF_SEC, 8, raw_data, raw_sz);
 	if (err) {
-		pr_warn("failed to write out .BTF ELF section: %d\n", err);
+		pr_warn("failed to write out .BTF ELF section: %s\n", errstr(err));
 		return err;
 	}
 
@@ -2811,7 +2814,7 @@ static int finalize_btf(struct bpf_linker *linker)
 
 		err = emit_elf_data_sec(linker, BTF_EXT_ELF_SEC, 8, raw_data, raw_sz);
 		if (err) {
-			pr_warn("failed to write out .BTF.ext ELF section: %d\n", err);
+			pr_warn("failed to write out .BTF.ext ELF section: %s\n", errstr(err));
 			return err;
 		}
 	}
@@ -2987,7 +2990,7 @@ static int finalize_btf_ext(struct bpf_linker *linker)
 	err = libbpf_get_error(linker->btf_ext);
 	if (err) {
 		linker->btf_ext = NULL;
-		pr_warn("failed to parse final .BTF.ext data: %d\n", err);
+		pr_warn("failed to parse final .BTF.ext data: %s\n", errstr(err));
 		goto out;
 	}
 
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index bfd8dac4c0cc..9702b70da444 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -21,6 +21,7 @@
 #include "libbpf.h"
 #include "libbpf_internal.h"
 #include "bpf.h"
+#include "str_error.h"
 
 struct ring {
 	ring_buffer_sample_fn sample_cb;
@@ -88,8 +89,8 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	err = bpf_map_get_info_by_fd(map_fd, &info, &len);
 	if (err) {
 		err = -errno;
-		pr_warn("ringbuf: failed to get map info for fd=%d: %d\n",
-			map_fd, err);
+		pr_warn("ringbuf: failed to get map info for fd=%d: %s\n",
+			map_fd, errstr(err));
 		return libbpf_err(err);
 	}
 
@@ -123,8 +124,8 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	tmp = mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
 	if (tmp == MAP_FAILED) {
 		err = -errno;
-		pr_warn("ringbuf: failed to mmap consumer page for map fd=%d: %d\n",
-			map_fd, err);
+		pr_warn("ringbuf: failed to mmap consumer page for map fd=%d: %s\n",
+			map_fd, errstr(err));
 		goto err_out;
 	}
 	r->consumer_pos = tmp;
@@ -142,8 +143,8 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	tmp = mmap(NULL, (size_t)mmap_sz, PROT_READ, MAP_SHARED, map_fd, rb->page_size);
 	if (tmp == MAP_FAILED) {
 		err = -errno;
-		pr_warn("ringbuf: failed to mmap data pages for map fd=%d: %d\n",
-			map_fd, err);
+		pr_warn("ringbuf: failed to mmap data pages for map fd=%d: %s\n",
+			map_fd, errstr(err));
 		goto err_out;
 	}
 	r->producer_pos = tmp;
@@ -156,8 +157,8 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	e->data.fd = rb->ring_cnt;
 	if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, e) < 0) {
 		err = -errno;
-		pr_warn("ringbuf: failed to epoll add map fd=%d: %d\n",
-			map_fd, err);
+		pr_warn("ringbuf: failed to epoll add map fd=%d: %s\n",
+			map_fd, errstr(err));
 		goto err_out;
 	}
 
@@ -205,7 +206,7 @@ ring_buffer__new(int map_fd, ring_buffer_sample_fn sample_cb, void *ctx,
 	rb->epoll_fd = epoll_create1(EPOLL_CLOEXEC);
 	if (rb->epoll_fd < 0) {
 		err = -errno;
-		pr_warn("ringbuf: failed to create epoll instance: %d\n", err);
+		pr_warn("ringbuf: failed to create epoll instance: %s\n", errstr(err));
 		goto err_out;
 	}
 
@@ -458,7 +459,8 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
 	err = bpf_map_get_info_by_fd(map_fd, &info, &len);
 	if (err) {
 		err = -errno;
-		pr_warn("user ringbuf: failed to get map info for fd=%d: %d\n", map_fd, err);
+		pr_warn("user ringbuf: failed to get map info for fd=%d: %s\n",
+			map_fd, errstr(err));
 		return err;
 	}
 
@@ -474,8 +476,8 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
 	tmp = mmap(NULL, rb->page_size, PROT_READ, MAP_SHARED, map_fd, 0);
 	if (tmp == MAP_FAILED) {
 		err = -errno;
-		pr_warn("user ringbuf: failed to mmap consumer page for map fd=%d: %d\n",
-			map_fd, err);
+		pr_warn("user ringbuf: failed to mmap consumer page for map fd=%d: %s\n",
+			map_fd, errstr(err));
 		return err;
 	}
 	rb->consumer_pos = tmp;
@@ -494,8 +496,8 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
 		   map_fd, rb->page_size);
 	if (tmp == MAP_FAILED) {
 		err = -errno;
-		pr_warn("user ringbuf: failed to mmap data pages for map fd=%d: %d\n",
-			map_fd, err);
+		pr_warn("user ringbuf: failed to mmap data pages for map fd=%d: %s\n",
+			map_fd, errstr(err));
 		return err;
 	}
 
@@ -506,7 +508,7 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
 	rb_epoll->events = EPOLLOUT;
 	if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, rb_epoll) < 0) {
 		err = -errno;
-		pr_warn("user ringbuf: failed to epoll add map fd=%d: %d\n", map_fd, err);
+		pr_warn("user ringbuf: failed to epoll add map fd=%d: %s\n", map_fd, errstr(err));
 		return err;
 	}
 
@@ -531,7 +533,7 @@ user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts)
 	rb->epoll_fd = epoll_create1(EPOLL_CLOEXEC);
 	if (rb->epoll_fd < 0) {
 		err = -errno;
-		pr_warn("user ringbuf: failed to create epoll instance: %d\n", err);
+		pr_warn("user ringbuf: failed to create epoll instance: %s\n", errstr(err));
 		goto err_out;
 	}
 
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 93794f01bb67..5f085736c6c4 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -20,6 +20,7 @@
 #include "libbpf_common.h"
 #include "libbpf_internal.h"
 #include "hashmap.h"
+#include "str_error.h"
 
 /* libbpf's USDT support consists of BPF-side state/code and user-space
  * state/code working together in concert. BPF-side parts are defined in
@@ -465,8 +466,8 @@ static int parse_vma_segs(int pid, const char *lib_path, struct elf_seg **segs,
 		goto proceed;
 
 	if (!realpath(lib_path, path)) {
-		pr_warn("usdt: failed to get absolute path of '%s' (err %d), using path as is...\n",
-			lib_path, -errno);
+		pr_warn("usdt: failed to get absolute path of '%s' (err %s), using path as is...\n",
+			lib_path, errstr(-errno));
 		libbpf_strlcpy(path, lib_path, sizeof(path));
 	}
 
@@ -475,8 +476,8 @@ static int parse_vma_segs(int pid, const char *lib_path, struct elf_seg **segs,
 	f = fopen(line, "re");
 	if (!f) {
 		err = -errno;
-		pr_warn("usdt: failed to open '%s' to get base addr of '%s': %d\n",
-			line, lib_path, err);
+		pr_warn("usdt: failed to open '%s' to get base addr of '%s': %s\n",
+			line, lib_path, errstr(err));
 		return err;
 	}
 
@@ -606,7 +607,8 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
 
 	err = parse_elf_segs(elf, path, &segs, &seg_cnt);
 	if (err) {
-		pr_warn("usdt: failed to process ELF program segments for '%s': %d\n", path, err);
+		pr_warn("usdt: failed to process ELF program segments for '%s': %s\n",
+			path, errstr(err));
 		goto err_out;
 	}
 
@@ -708,8 +710,8 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
 			if (vma_seg_cnt == 0) {
 				err = parse_vma_segs(pid, path, &vma_segs, &vma_seg_cnt);
 				if (err) {
-					pr_warn("usdt: failed to get memory segments in PID %d for shared library '%s': %d\n",
-						pid, path, err);
+					pr_warn("usdt: failed to get memory segments in PID %d for shared library '%s': %s\n",
+						pid, path, errstr(err));
 					goto err_out;
 				}
 			}
@@ -1047,8 +1049,8 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 
 		if (is_new && bpf_map_update_elem(spec_map_fd, &spec_id, &target->spec, BPF_ANY)) {
 			err = -errno;
-			pr_warn("usdt: failed to set USDT spec #%d for '%s:%s' in '%s': %d\n",
-				spec_id, usdt_provider, usdt_name, path, err);
+			pr_warn("usdt: failed to set USDT spec #%d for '%s:%s' in '%s': %s\n",
+				spec_id, usdt_provider, usdt_name, path, errstr(err));
 			goto err_out;
 		}
 		if (!man->has_bpf_cookie &&
@@ -1058,9 +1060,9 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 				pr_warn("usdt: IP collision detected for spec #%d for '%s:%s' in '%s'\n",
 				        spec_id, usdt_provider, usdt_name, path);
 			} else {
-				pr_warn("usdt: failed to map IP 0x%lx to spec #%d for '%s:%s' in '%s': %d\n",
+				pr_warn("usdt: failed to map IP 0x%lx to spec #%d for '%s:%s' in '%s': %s\n",
 					target->abs_ip, spec_id, usdt_provider, usdt_name,
-					path, err);
+					path, errstr(err));
 			}
 			goto err_out;
 		}
@@ -1076,8 +1078,8 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 								      target->rel_ip, &opts);
 			err = libbpf_get_error(uprobe_link);
 			if (err) {
-				pr_warn("usdt: failed to attach uprobe #%d for '%s:%s' in '%s': %d\n",
-					i, usdt_provider, usdt_name, path, err);
+				pr_warn("usdt: failed to attach uprobe #%d for '%s:%s' in '%s': %s\n",
+					i, usdt_provider, usdt_name, path, errstr(err));
 				goto err_out;
 			}
 
@@ -1099,8 +1101,8 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 								    NULL, &opts_multi);
 		if (!link->multi_link) {
 			err = -errno;
-			pr_warn("usdt: failed to attach uprobe multi for '%s:%s' in '%s': %d\n",
-				usdt_provider, usdt_name, path, err);
+			pr_warn("usdt: failed to attach uprobe multi for '%s:%s' in '%s': %s\n",
+				usdt_provider, usdt_name, path, errstr(err));
 			goto err_out;
 		}
 
-- 
2.47.0


