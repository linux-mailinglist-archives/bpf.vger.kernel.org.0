Return-Path: <bpf+bounces-57682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12140AAE799
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0527D3ADE55
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD7628C5B7;
	Wed,  7 May 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL8xz+1F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED2B28C2C1
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638260; cv=none; b=holLc3ZHd3DYDFZ87ME/DTCz293ewBGD8SvNiiq5fR/jIrW6ccim8f0rt/9y8SEknWuC5BJwV1j+HbfEKEn4LEpVr/c0aHd7oLuYdMFVysMLLHRWBIc+LPlb5uSaJb/ZOQc2C2Y09RuVwGirYOxtsSnxosCcWu9BtE9XALVNVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638260; c=relaxed/simple;
	bh=WhbQJiQmhN/GRwyk5nNRX6N+xFEDf6b7sa8zMN3wTYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyJjxOtkK6E1gCR7CYUIYcNqXeYUOjvZcbdLgjHgxSquv1G1ldMjcq3L9Yav5nPNaDg5xr+FVwOcoztuuLceBoxBHFbu1bLicZA/rNpC/PVF5cOBKn+SrIdCNzJNCBeMjEp7jvq4zxgZNy0NFP62M798ZXPcaUJVNLZXvWNfa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL8xz+1F; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a0b7fbdde7so93985f8f.2
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638256; x=1747243056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzt4hq4cSPSXuynuwR+uIRWcpYvSvlH3VA2tKCzraoM=;
        b=XL8xz+1FUvBW0van87D/LobZbvr4kGXgTrYT2eYnAv4cPvQ2R7lwOC7VMQkUpP5JRO
         SDKBzi4q5F7dpFXwajFP+rc/ZRQsdIh+0x2XDicHbYILsHkvZ1XDxSJR14N/MyB/ffd8
         VNrbyoVR2dN9LA2tNM0KJ8a/aPqWYLLHkvq8l5lfR/vqdf4Z5ix5Whjj6vPcR77GiKlb
         l5CuU7xbNbB6LBoLsBQvGiOwg0DMP3dxx0wYxMGfdH2wmHZgA/cuPwE3VRAmrpYX5Ig0
         Cy2sy+8Pq6x3a/Mt3+ipDZz41ouWCYL0t+tMNcNocP7KkRxdmCKjer80263DlwLCeml8
         jHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638256; x=1747243056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzt4hq4cSPSXuynuwR+uIRWcpYvSvlH3VA2tKCzraoM=;
        b=PrHnCbTI9ZndGDidZFT9KVYXRg4qrl8jNXhO0AKxw6I4HgCoqaFQtCBO/1hd89l32R
         bbPM+qa1XXQeMuuZ0YPi6k7Y7Ij/ZOg0sxK6pty+H+ozZl4nCqCcXM6XRr5E/D5XziFI
         Xi8sLYdfhIxVX3OtmEAtBocpktljAEn/UwaqN0pEZhqLMXAkDZkeYkss2DTiG6Zy04nB
         NRHtB/TwxW2uFgjcRU+qa/4PHrN1f84klHNXr0ES1s6vYg23BbPM+WqVaIFtD0cSUMtU
         w+io6INmEhEmkeX0mr7+SLiU/UrfnXOp/hKMe8LgAZRrtp2I+w1X4Nhp7lWaFnK2zht3
         xhvw==
X-Gm-Message-State: AOJu0YwUDBZDHtxTlp8j9Q8GMXoQ3dhrRAawt7CCuGxrqrHRCr2FBjc1
	TbPFoxLTMegxqbo2oiQXBjpS/VZM66YQLxLWm7metnk/FSC34TcLs+4xfKQRbm0=
X-Gm-Gg: ASbGnctYf/GelkEW8JKwoeJxbt7UvdojJtXWzpTKujZya70DuoeEJAJj2JyDs+gcUBW
	67BGMQjvNkN+2zV/jNjc+mC71N4T0y7knel6Wu72+mcmnA3UmJ1mHzLlOFjRibJrDHbt4HLSrKr
	y/0CMTUvcqKhmzjgPJPlwu6BqVQ/0+oLglHoT44Xlxvge+3BuE51PX5YyvWodVhsytqCDe1igWJ
	+ej5EcrONsCZzXfnQJbK+pZqnbSSJ+ZvrxqYJDkKE5/kt3BVjEWJm5IhyfHUEbhGSjaW8jNkF0A
	/b0ULzsyr/uIp1Ma7JKeNtPy07EoeA==
X-Google-Smtp-Source: AGHT+IEcNfjC/p+4tHuqWeP3ebdlexLQiqtZVwRjHeRY2VG0zVftknUxNG3MFpkOP6yM75d/mXrrHQ==
X-Received: by 2002:a5d:588e:0:b0:3a0:8598:8e7c with SMTP id ffacd0b85a97d-3a0b49967b2mr3330345f8f.6.1746638255891;
        Wed, 07 May 2025 10:17:35 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:9::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b16ec6sm17060232f8f.83.2025.05.07.10.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping streams
Date: Wed,  7 May 2025 10:17:19 -0700
Message-ID: <20250507171720.1958296-11-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250507171720.1958296-1-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8831; h=from:subject; bh=WhbQJiQmhN/GRwyk5nNRX6N+xFEDf6b7sa8zMN3wTYs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WK7AicxDxVfzifpDeD/TOGMaVU3TUbTopsU3fA HPlc2wSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuVigAKCRBM4MiGSL8RyqGjD/ wIoht+CcTJy8oWKU8+Z+gvelv75DoZuEjmvO6mj63CERPBXuIU5nmPqMsTGN7ADAbUOSiQl9T1pavn yfMGUan1WbnSRweNJG/Zo1r5wK84nP98wy9B8lSNy8R8692wY7Z+jTb+TZYXYby/6dG9BrFGFBfFXm 2SZJWGHJ+I241r5+XKxrs+2y7aVF/CIAJTr2PskWATQ/Xg5kv5sQHwD2yhvjiGyO9GFyIJNXIKKcL3 ASE9uNOPFMoFumfveTKS5e0ODdn0DtWnhENNk6O5b0exI6lFAtOncpP3LKQfGcJ5h86DhTLQT60Gsf HUjwGi4ZimairlN/1WDvMUJXTfO2OufFzTGq+fOnQwvsNYYjrTTmAQDRsg0rj/RLTQKCREnJsd2iZm Z7YU8XFhlGtkDtG46iky7cDKRaRp2lcGIsC++BSFCDYjaucrG/DRvAIirIvhcK+6/2ks7x6sCBqgQm Q+LX4QMkxJWGmwGG3R4xS19YpzAJDz4Ww2yRH/N19h8kOIgcUkCzDY3e7UlZfMRbS7CB20uxn6yjbj 7LZFnDAdEK6GkpSdBVPBPEkXbxwze3HgCpEPd1fTeyIe/T4bJQz1Coc5JnqBRwSKr0ZgpsBegCAbI5 AOe4U3q8yzVyhIBtuS/jwUiIzcaUhKYpZgd4eQbQbmDiqKZOzVyQqYsvKJuQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add bpftool support for dumping streams of a given BPF program.
The syntax is `bpftool prog tracelog { stdout | stderr } PROG`.
The stdout is dumped to stdout, stderr is dumped to stderr.

Cc: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpftool/Documentation/bpftool-prog.rst    |  6 ++
 tools/bpf/bpftool/Makefile                    |  2 +-
 tools/bpf/bpftool/bash-completion/bpftool     | 16 +++-
 tools/bpf/bpftool/prog.c                      | 88 ++++++++++++++++++-
 tools/bpf/bpftool/skeleton/stream.bpf.c       | 69 +++++++++++++++
 5 files changed, 178 insertions(+), 3 deletions(-)
 create mode 100644 tools/bpf/bpftool/skeleton/stream.bpf.c

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index d6304e01afe0..258e16ee8def 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -173,6 +173,12 @@ bpftool prog tracelog
     purposes. For streaming data from BPF programs to user space, one can use
     perf events (see also **bpftool-map**\ (8)).
 
+bpftool prog tracelog { stdout | stderr } *PROG*
+    Dump the BPF stream of the program. BPF programs can write to these streams
+    at runtime with the **bpf_stream_vprintk**\ () kfunc. The kernel may write
+    error messages to the standard error stream. This facility should be used
+    only for debugging purposes.
+
 bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ctx_in *FILE* [ctx_out *FILE* [ctx_size_out *M*]]] [repeat *N*]
     Run BPF program *PROG* in the kernel testing infrastructure for BPF,
     meaning that the program works on the data and context provided by the
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
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 1ce409a6cbd9..c7c0bf3aee24 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -518,7 +518,21 @@ _bpftool()
                     esac
                     ;;
                 tracelog)
-                    return 0
+                    case $prev in
+                        $command)
+                            COMPREPLY+=( $( compgen -W "stdout stderr" -- \
+                                "$cur" ) )
+                            return 0
+                            ;;
+                        stdout|stderr)
+                            COMPREPLY=( $( compgen -W "$PROG_TYPE" -- \
+                                "$cur" ) )
+                            return 0
+                            ;;
+                        *)
+                            return 0
+                            ;;
+                    esac
                     ;;
                 profile)
                     case $cword in
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index f010295350be..7abe4698c86c 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -35,6 +35,8 @@
 #include "main.h"
 #include "xlated_dumper.h"
 
+#include "stream.skel.h"
+
 #define BPF_METADATA_PREFIX "bpf_metadata_"
 #define BPF_METADATA_PREFIX_LEN (sizeof(BPF_METADATA_PREFIX) - 1)
 
@@ -697,6 +699,15 @@ static int do_show(int argc, char **argv)
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
 static int
 prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 	  char *filepath, bool opcodes, bool visual, bool linum)
@@ -1113,6 +1124,80 @@ static int do_detach(int argc, char **argv)
 	return 0;
 }
 
+enum prog_tracelog_mode {
+	TRACE_STDOUT,
+	TRACE_STDERR,
+};
+
+static int
+prog_tracelog_stream(struct bpf_prog_info *info, enum prog_tracelog_mode mode)
+{
+	FILE *file = mode == TRACE_STDOUT ? stdout : stderr;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ring_buffer *ringbuf;
+	struct stream_bpf *skel;
+	int map_fd, ret = -1;
+
+	__u32 prog_id = info->id;
+	__u32 stream_id = mode == TRACE_STDOUT ? 1 : 2;
+
+	skel = stream_bpf__open_and_load();
+	if (!skel)
+		return -errno;
+	skel->bss->prog_id = prog_id;
+	skel->bss->stream_id = stream_id;
+
+	map_fd = bpf_map__fd(skel->maps.ringbuf);
+	ringbuf = ring_buffer__new(map_fd, process_stream_sample, file, NULL);
+	if (!ringbuf) {
+		ret = -errno;
+		goto end;
+	}
+	do {
+		skel->bss->written_count = skel->bss->written_size = 0;
+		ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.bpftool_dump_prog_stream), &opts);
+		if (ring_buffer__consume_n(ringbuf, skel->bss->written_count) != skel->bss->written_count) {
+			ret = -EINVAL;
+			goto end;
+		}
+	} while (!ret && opts.retval == EAGAIN);
+
+	if (opts.retval != 0)
+		ret = -EINVAL;
+end:
+	stream_bpf__destroy(skel);
+	return ret;
+}
+
+
+static int do_tracelog_any(int argc, char **argv)
+{
+	enum prog_tracelog_mode mode;
+	struct bpf_prog_info info;
+	__u32 info_len = sizeof(info);
+	int fd, err;
+
+	if (argc == 0)
+		return do_tracelog(argc, argv);
+	if (!is_prefix(*argv, "stdout") && !is_prefix(*argv, "stderr"))
+		usage();
+	mode = is_prefix(*argv, "stdout") ? TRACE_STDOUT : TRACE_STDERR;
+	NEXT_ARG();
+
+	if (!REQ_ARGS(2))
+		return -1;
+
+	fd = prog_parse_fd(&argc, &argv);
+	if (fd < 0)
+		return -1;
+
+	err = bpf_prog_get_info_by_fd(fd, &info, &info_len);
+	if (err < 0)
+		return -1;
+
+	return prog_tracelog_stream(&info, mode);
+}
+
 static int check_single_stdin(char *file_data_in, char *file_ctx_in)
 {
 	if (file_data_in && file_ctx_in &&
@@ -2483,6 +2568,7 @@ static int do_help(int argc, char **argv)
 		"                         [repeat N]\n"
 		"       %1$s %2$s profile PROG [duration DURATION] METRICs\n"
 		"       %1$s %2$s tracelog\n"
+		"       %1$s %2$s tracelog { stdout | stderr } PROG\n"
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_MAP "\n"
@@ -2522,7 +2608,7 @@ static const struct cmd cmds[] = {
 	{ "loadall",	do_loadall },
 	{ "attach",	do_attach },
 	{ "detach",	do_detach },
-	{ "tracelog",	do_tracelog },
+	{ "tracelog",	do_tracelog_any },
 	{ "run",	do_run },
 	{ "profile",	do_profile },
 	{ 0 }
diff --git a/tools/bpf/bpftool/skeleton/stream.bpf.c b/tools/bpf/bpftool/skeleton/stream.bpf.c
new file mode 100644
index 000000000000..910315959144
--- /dev/null
+++ b/tools/bpf/bpftool/skeleton/stream.bpf.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+	struct bpf_stream_elem *elem;
+	struct bpf_stream *stream;
+	bool cont = false;
+	bool ret = 0;
+
+	stream = bpf_prog_stream_get(stream_id, prog_id);
+	if (!stream)
+		return ENOENT;
+
+	bpf_repeat(BPF_MAX_LOOPS) {
+		struct bpf_dynptr dst_dptr, src_dptr;
+		int size;
+
+		elem = bpf_stream_next_elem(stream);
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
+		/* Probe and exit if no more space, probe for twice the typical size. */
+		if (bpf_ringbuf_reserve_dynptr(&ringbuf, 2048, 0, &dst_dptr))
+			cont = true;
+		bpf_ringbuf_discard_dynptr(&dst_dptr, 0);
+
+		if (ret || cont)
+			break;
+	}
+
+	bpf_prog_stream_put(stream);
+
+	return ret ? ret : (cont ? EAGAIN : 0);
+}
+
+char _license[] SEC("license") = "Dual BSD/GPL";
-- 
2.47.1


