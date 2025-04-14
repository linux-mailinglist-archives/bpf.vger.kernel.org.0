Return-Path: <bpf+bounces-55882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C99A8884C
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA3917C64F
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF0284685;
	Mon, 14 Apr 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYKZaJ3O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF527F742
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647304; cv=none; b=CxHlp3onTovSSqGARMvOa/ILEWyKOMjsC51Cc5z8rSL3ywu/2JMUyLERBrZrUUVSHPOaLxd72guyemT+pdsT3qncFi3Ptez+L73Gk/CU6yVeyKSgiQSmo08aht6wWYab6TolatFWNgVzGeLcFD99Ic+4A03HS4qV78fThJLBI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647304; c=relaxed/simple;
	bh=Cp3upDhesnS43wX5nAYNbho/4UvxGnwfR+P736Z+yl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWyefL97Kf3eyrzckVyT642Lp36h6g+lZ8gKTKMqwsDOUqGL0Ayyum/lFFVmZyr84H2D2V2lhkqrD72CTIbXuw69Ar5+40Qw+d0w54lWmDqLAcPxih0xHUY23yd3+uBZQLhOfMFXvsTyk9PABoFxcFXNr6IMURHM4c4VdxvPkeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYKZaJ3O; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so37095865e9.2
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647301; x=1745252101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52w6kA4jGbf1DSoxm/zsOz6TRz5VtIMuCeWUJu+mRjE=;
        b=nYKZaJ3OPHuffGl8sHiGRh7uPmGVmRO9OjlgiisDBzPSyWzw/gBMwacaqO3sR25kXa
         Qfr4iOKV/ISUKR5n/hKcnWNbu7UVnlLkM+y5esZj3tReucaW0HtkHTRrH2ebfwrW6NoI
         Fpwh0ChKuzLOYLDldk1WRXz2HVB3cg9I5rhxYRgUnGlPdLYnKx0Ljp7ilrDltgJ1OCHd
         qmgQQSd+e7KfzxvV3yDiCoFFR1ahFvC7eAVo35kSdhqhK3gAsJKyNyLGKCDjkXPa8YRv
         z1ZG8OJTjG5JxbCbqY+rQQD3Bac93LnzQznuez1weQKsFAsFD8J8/p5XeAoEfzKVWJhP
         IriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647301; x=1745252101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52w6kA4jGbf1DSoxm/zsOz6TRz5VtIMuCeWUJu+mRjE=;
        b=hPEdniCEJEkjyM7k0qrrzOqxx0TdK9Mla911dKP99MvJzWNgCyTOIuIdljOpibsqjA
         BX16+GUrDsdt07LePprSzjN4YlC3Iasbr0xkD/fM9nDj3uOpPRYl3nr5wo7TyAZJ/E77
         ZenYIOKqvM0s0NBIEXEXlimV1eWiZVOOx/Q2DbfGGTJDzTGtCYffkEcg5dHL/RLHiugg
         egBQWO51TTZQqhphGDkWMEvMk9/xv4WFfQqhrIi5WySRbtIKQI/1X5vmpjOYrOIHX7QJ
         Qa4sK2s2ZfBsZV7wwBmZNtFTN2GWYlhkvRn9pkksk9d01OcmIwApDsfT8LwuOYXcJJch
         jiYg==
X-Gm-Message-State: AOJu0YxGUFbTSN2t1F2kd457h0E6GXzz3oaAeCzcqh6/+k+/pqbUb3a0
	DNUAvNN/LiKdTA4Nz1QgWnz8ZNCY++yA0zNqyPC6/IJiYpfLZrdO8GjAsGZdBgE=
X-Gm-Gg: ASbGncu9LTy8/uSGroz2SuEM5Lv30OaUF7L+5JoJFC9blq5w4hbbLpmcNXr6j8XPMjv
	HlBwoHscDa++bFxFSK+/nCve4vxiwBap6y06iBnh8T7jlQIhSh6ThGXPHsT+c4zTi2Y2QrZ2HF2
	2oWBynMy5LUIK46cBshJndSkasGhYpQUu3gH1U+Dy6fiAHcmwUgGao+xFIoZqVtycgJdamwL6Hm
	fOJ3rZGsIVcwa1VdLiDso+5+Kq2335eghbfu1VpFMfWVZB78J96THj7jNXOt5jz3eaWA520x8Rm
	zP+8oQv1kW8YJeiAsBGQdlZYOnR3Vw==
X-Google-Smtp-Source: AGHT+IHlNMsaNnxnRGiy4D0ntYn0r647kJyVCpNabceAxmdh4wBfUSRPD4yrSxy4X/ujKU7Rp5d25g==
X-Received: by 2002:a05:600c:1d88:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-43f3a94c5a0mr122750865e9.12.1744647300600;
        Mon, 14 Apr 2025 09:15:00 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:9::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338dc13sm187520335e9.3.2025.04.14.09.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:59 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 12/13] bpftool: Add support for dumping streams
Date: Mon, 14 Apr 2025 09:14:42 -0700
Message-ID: <20250414161443.1146103-13-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7824; h=from:subject; bh=Cp3upDhesnS43wX5nAYNbho/4UvxGnwfR+P736Z+yl4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOKUwJ++rSH0cRqrh1XGSMo1fuUH8TgzXOYvB0d 0rwTlomJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0zigAKCRBM4MiGSL8RyufcD/ 4gScGL4Y9o2Gq11b4ZUVnrtoZWZtqR1D/FGtwVK4k5I9ZfRaEimdeUpVlCj2CmR4iMCdM6iebz1mf7 zDzFeca4f1sI+VlNn/O6HWmXcb04opT+0AXdrBpSkMVE8bCKAtlDjvlLuly9mShv/XRrw7PRUtNXp0 KrOHJivodObfyC2LPn+Lu2GKvHY1t+7rz0hLwFwhrUeEACqfN+Vdv/aAfwtociMftTJb99Ik6HihmX fcZgTdRc0FgCRly8TxeFIZCeQWSmsEnFw/GLN9rXHSGDflIRmS8TD3EkhQ/1Fx8Je6J1bunezBktTr VX07caNMmB946q9m2CsUJsPNsY6hREv1/fBGX3h8f2vzO7aoz+EN3MXokLs7ruUZRrl43vfcDoKSD+ eA/VmU91IcmrloYxW+QUgIvXOhU6dKRBFDTYexGxrWI3BlvxevBwZabYD6YkeC/mhdyIeMxQJSK4rf 337Nbl+oc0iG1jJPFzSkPZOWPX1puOhoBFDvNRMasGOcfXBDOZwyrb+rp6Rjee2eNKMOe37Ka2Ut0A Pr+81MEnYXg8+GaNYC84cXGgzMtu7qu3sfIr50MHs7Z0PYc2rcOT0vVLHg5TN1ftFTh0XSVbTbhvZB GbYmHf4hvJlxreRDQRo4Q4JV9V95weznTZlZkOI/PL+dWSjCN6/9vC9Pi/8A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add bpftool support for dumping streams of a given BPF program.
TODO: JSON and filepath support.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/bpf/bpftool/Makefile              |  2 +-
 tools/bpf/bpftool/prog.c                | 71 +++++++++++++++++-
 tools/bpf/bpftool/skeleton/stream.bpf.c | 96 +++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 3 deletions(-)
 create mode 100644 tools/bpf/bpftool/skeleton/stream.bpf.c

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 9e9a5f006cd2..eb908223c3bb 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -234,7 +234,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
 $(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o $(BPFTOOL_BOOTSTRAP)
 	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) gen skeleton $< > $@
 
-$(OUTPUT)prog.o: $(OUTPUT)profiler.skel.h
+$(OUTPUT)prog.o: $(OUTPUT)profiler.skel.h $(OUTPUT)stream.skel.h
 
 $(OUTPUT)pids.o: $(OUTPUT)pid_iter.skel.h
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index f010295350be..d0800fec9c3d 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -35,12 +35,16 @@
 #include "main.h"
 #include "xlated_dumper.h"
 
+#include "stream.skel.h"
+
 #define BPF_METADATA_PREFIX "bpf_metadata_"
 #define BPF_METADATA_PREFIX_LEN (sizeof(BPF_METADATA_PREFIX) - 1)
 
 enum dump_mode {
 	DUMP_JITED,
 	DUMP_XLATED,
+	DUMP_STDOUT,
+	DUMP_STDERR,
 };
 
 static const bool attach_types[] = {
@@ -697,6 +701,55 @@ static int do_show(int argc, char **argv)
 	return err;
 }
 
+static int process_stream_sample(void *ctx, void *data, size_t len)
+{
+	FILE *file = ctx;
+
+	fprintf(file, "%s", (char *)data);
+	fflush(file);
+	return 0;
+}
+
+static int
+prog_dump_stream(struct bpf_prog_info *info, enum dump_mode mode, const char *filepath)
+{
+	FILE *file = mode == DUMP_STDOUT ? stdout : stderr;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ring_buffer *ringbuf;
+	struct stream_bpf *skel;
+	int map_fd, ret = -1;
+
+	__u32 prog_id = info->id;
+	__u32 stream_id = mode == DUMP_STDOUT ? 1 : 2;
+
+	skel = stream_bpf__open_and_load();
+	if (!skel)
+		return -errno;
+	skel->bss->prog_id = prog_id;
+	skel->bss->stream_id = stream_id;
+
+	//TODO(kkd): Filepath handling
+	map_fd = bpf_map__fd(skel->maps.ringbuf);
+	ringbuf = ring_buffer__new(map_fd, process_stream_sample, file, NULL);
+	if (!ringbuf) {
+		ret = -errno;
+		goto end;
+	}
+	do {
+		skel->bss->written_count = skel->bss->written_size = 0;
+		ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.bpftool_dump_prog_stream), &opts);
+		ret = -EINVAL;
+		if (ring_buffer__consume_n(ringbuf, skel->bss->written_count) != skel->bss->written_count)
+			goto end;
+	} while (!ret && opts.retval == EAGAIN);
+
+	if (opts.retval != 0)
+		ret = -EINVAL;
+end:
+	stream_bpf__destroy(skel);
+	return ret;
+}
+
 static int
 prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 	  char *filepath, bool opcodes, bool visual, bool linum)
@@ -719,13 +772,15 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 		}
 		buf = u64_to_ptr(info->jited_prog_insns);
 		member_len = info->jited_prog_len;
-	} else {	/* DUMP_XLATED */
+	} else if (mode == DUMP_XLATED) {	/* DUMP_XLATED */
 		if (info->xlated_prog_len == 0 || !info->xlated_prog_insns) {
 			p_err("error retrieving insn dump: kernel.kptr_restrict set?");
 			return -1;
 		}
 		buf = u64_to_ptr(info->xlated_prog_insns);
 		member_len = info->xlated_prog_len;
+	} else if (mode == DUMP_STDOUT || mode == DUMP_STDERR) {
+		return prog_dump_stream(info, mode, filepath);
 	}
 
 	if (info->btf_id) {
@@ -898,8 +953,10 @@ static int do_dump(int argc, char **argv)
 		mode = DUMP_JITED;
 	} else if (is_prefix(*argv, "xlated")) {
 		mode = DUMP_XLATED;
+	} else if (is_prefix(*argv, "stdout") || is_prefix(*argv, "stderr")) {
+		mode = is_prefix(*argv, "stdout") ? DUMP_STDOUT : DUMP_STDERR;
 	} else {
-		p_err("expected 'xlated' or 'jited', got: %s", *argv);
+		p_err("expected 'stdout', 'stderr', 'xlated' or 'jited', got: %s", *argv);
 		return -1;
 	}
 	NEXT_ARG();
@@ -950,6 +1007,14 @@ static int do_dump(int argc, char **argv)
 		}
 	}
 
+	if (mode == DUMP_STDOUT || mode == DUMP_STDERR) {
+		if (opcodes || visual || linum) {
+			p_err("'%s' is not compatible with 'opcodes', 'visual', or 'linum'",
+			      mode == DUMP_STDOUT ? "stdout" : "stderr");
+			goto exit_close;
+		}
+	}
+
 	if (filepath && (opcodes || visual || linum)) {
 		p_err("'file' is not compatible with 'opcodes', 'visual', or 'linum'");
 		goto exit_close;
@@ -2468,6 +2533,8 @@ static int do_help(int argc, char **argv)
 		"Usage: %1$s %2$s { show | list } [PROG]\n"
 		"       %1$s %2$s dump xlated PROG [{ file FILE | [opcodes] [linum] [visual] }]\n"
 		"       %1$s %2$s dump jited  PROG [{ file FILE | [opcodes] [linum] }]\n"
+		"	%1$s %2$s dump stdout PROG [{ file FILE }]\n"
+		"	%1$s %2$s dump stderr PROG [{ file FILE }]\n"
 		"       %1$s %2$s pin   PROG FILE\n"
 		"       %1$s %2$s { load | loadall } OBJ  PATH \\\n"
 		"                         [type TYPE] [{ offload_dev | xdpmeta_dev } NAME] \\\n"
diff --git a/tools/bpf/bpftool/skeleton/stream.bpf.c b/tools/bpf/bpftool/skeleton/stream.bpf.c
new file mode 100644
index 000000000000..31b5933e0384
--- /dev/null
+++ b/tools/bpf/bpftool/skeleton/stream.bpf.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 1024 * 1024);
+} ringbuf SEC(".maps");
+
+struct value {
+	struct bpf_stream_elem_batch __kptr *batch;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct value);
+	__uint(max_entries, 1);
+} array SEC(".maps");
+
+int written_size;
+int written_count;
+int stream_id;
+int prog_id;
+
+#define ENOENT 2
+#define EAGAIN 11
+#define EFAULT 14
+
+SEC("syscall")
+int bpftool_dump_prog_stream(void *ctx)
+{
+	struct bpf_stream_elem_batch *elem_batch;
+	struct bpf_stream_elem *elem;
+	struct bpf_stream *stream;
+	bool cont = false;
+	struct value *v;
+	bool ret = 0;
+
+	stream = bpf_prog_stream_get(BPF_STDERR, prog_id);
+	if (!stream)
+		return ENOENT;
+
+	v = bpf_map_lookup_elem(&array, &(int){0});
+
+	if (v->batch)
+		elem_batch = bpf_kptr_xchg(&v->batch, NULL);
+	else
+		elem_batch = bpf_stream_next_elem_batch(stream);
+	if (!elem_batch)
+		goto end;
+
+	bpf_repeat(BPF_MAX_LOOPS) {
+		struct bpf_dynptr dst_dptr, src_dptr;
+		int size;
+
+		elem = bpf_stream_next_elem(elem_batch);
+		if (!elem)
+			break;
+		size = elem->mem_slice.len;
+
+		if (bpf_dynptr_from_mem_slice(&elem->mem_slice, 0, &src_dptr))
+			ret = EFAULT;
+		if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 0, &dst_dptr))
+			ret = EFAULT;
+		if (bpf_dynptr_copy(&dst_dptr, 0, &src_dptr, 0, size))
+			ret = EFAULT;
+		bpf_ringbuf_submit_dynptr(&dst_dptr, 0);
+
+		written_count++;
+		written_size += size;
+
+		bpf_stream_free_elem(elem);
+
+		/* Probe and exit if no more space, probe for twice the typical size.*/
+		if (bpf_ringbuf_reserve_dynptr(&ringbuf, 2048, 0, &dst_dptr))
+			cont = true;
+		bpf_ringbuf_discard_dynptr(&dst_dptr, 0);
+
+		if (ret || cont)
+			break;
+	}
+
+	if (cont)
+		elem_batch = bpf_kptr_xchg(&v->batch, elem_batch);
+	if (elem_batch)
+		bpf_stream_free_elem_batch(elem_batch);
+end:
+	bpf_prog_stream_put(stream);
+
+	return ret ?: (cont ? EAGAIN : 0);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


