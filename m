Return-Path: <bpf+bounces-70405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15182BBCC58
	for <lists+bpf@lfdr.de>; Sun, 05 Oct 2025 23:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E053B960F
	for <lists+bpf@lfdr.de>; Sun,  5 Oct 2025 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA312C08BD;
	Sun,  5 Oct 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcMFlUpn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB92BFC70
	for <bpf@vger.kernel.org>; Sun,  5 Oct 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699351; cv=none; b=W66S9TMsYTSWAcIrvmYV1NRh9vDoWg7WMp2u4ZSwpyNa0wC+8g/VHps+HzJ71JuclcreS3bIZrT5waV8DeREr5TqpYd/ooGLb6j5gXPB574NBX0BH01RWRQqOoxCsTclZijRpm/L+xwWXNZmZqF/dAvLW54OVLFQOE643Ut82+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699351; c=relaxed/simple;
	bh=CCQPc58TSvr0cy3nKc2lprmjbQNbCaQTJI1JHBO4fZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UYocnPRfrr0SBI4jycFGNAR+2wAFOzwg/Jfxbu+5X537u6ltlJHrUCR0HQOpAjDnKVdfxFZFqkaty7tiEHN2BMBZGgKhii8rueINW6ABRAo5augz8q3OSodEHAiAONrFwX0AT8v2Yxg+18+CTySFzEO89+I4lrXA0+O8jzJXx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcMFlUpn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3307af9b595so3360685a91.0
        for <bpf@vger.kernel.org>; Sun, 05 Oct 2025 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699349; x=1760304149; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDQxJshrzMcNiF4ov5sFxJSEj5wisWjGXrUgTQiuK7I=;
        b=FcMFlUpndp5sInmz+zA9xLYJFRMm/CTgTtgtTNcOhjRvz4J0mgodt3RxPwrb0W38Pi
         gxg383Tcx+22FaNNcs86Quchuz4JH10ckxtRAKVKKwCH/r1HtydSBQi2aGujlrhRacxb
         D39JIG2QNgqU//gjQUah5e/UdOLOQSFYNrfPR2LV0U2EF5VQDnNIS9ChyM8fM7IvYyIa
         zKi3M7kMBfvuvDo613WLjYEaWghu4aotaByfaRc8iVueRqK1WLfofzH8Mcl6nm2JaoRk
         a5B3bNLQFow7k2C8J7qtVDcvEiYdH3HzO5X6kKRkj91ogrnOmT/m4x86SiO7ddy2ZZ0i
         EFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699349; x=1760304149;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDQxJshrzMcNiF4ov5sFxJSEj5wisWjGXrUgTQiuK7I=;
        b=Ejf/JIeVyMJmyWVXitYES4NqR3x6i98xsp0I1BilNwFOcblzuz/mf6tzT3bEA4S7T4
         nhfKRrnCucnaMVRjCFsPf8TydE4t6fs7ukXcMmM6j1c1McB5Y/f4vnzEGACfI+nJcqqb
         GGShR009nZvBEarR8ZfPvysCvOAEygnod+SLOIP2fyc6RUIqfdh0WVHUv5DZ/YoTvrH1
         VDt9ui5e5wYKlmZq0cZdkZy893evV49RLYW6Sd50x4co3Dj+H9jasUZYfkvJ2CnY4leX
         +CwYayTs6deaiF1ClX9BvLhfaHQiOMk+kyubTSK0mvYTGweOcfoAaHGttRqYv1BLmsx+
         RY0g==
X-Forwarded-Encrypted: i=1; AJvYcCVwCW9MnDU7MtkxBOF3b9hR8D31/HkYcDIC2+vTbuN+kbJX1uXoqpL7y+Dw1qP/20sPqN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAnUJ5cE00w6tPdFr7nc3ksfDsqniC+VriYF38GqTWuQiBjFd
	Y0i85T55mrpi71ULcbYPG0nvza9qz+68ymh22Q+Y+ZJrXN7IK+kxeNb4v/+LS+MsidFObbEqxmm
	qC9JuwWLsSA==
X-Google-Smtp-Source: AGHT+IHNmdwNHNGJJio68vZQzxJW4gUw2wiEz4abGSKgXJDJaQ0VM0ja+fEKLhEkaSVx43BLmivRKC1zYmpG
X-Received: from plps1.prod.google.com ([2002:a17:902:9881:b0:24c:966a:4a6b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c0c:b0:24b:25f:5f81
 with SMTP id d9443c01a7336-28e9a574b99mr129613255ad.17.1759699349121; Sun, 05
 Oct 2025 14:22:29 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:05 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-5-irogers@google.com>
Subject: [PATCH v7 04/11] perf dso: Support BPF programs in dso__read_symbol
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Set the buffer to the code in the BPF linear info. This enables BPF
JIT code disassembly by LLVM and capstone. Move the common but minimal
disassmble_bpf_image call to disassemble_objdump so that it is only
called after falling back to the objdump option. Similarly move the
disassmble_bpf function to disassemble_objdump and rename to
disassmble_bpf_libbfd to make it clearer that this support relies on
libbfd.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c |  12 +++--
 tools/perf/util/dso.c    | 100 ++++++++++++++++++++++++++-------------
 tools/perf/util/libbfd.c |   4 +-
 tools/perf/util/libbfd.h |   6 +--
 4 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index a1240543c89c..e64902e520ab 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1521,6 +1521,12 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	struct child_process objdump_process;
 	int err;
 
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return symbol__disassemble_bpf_libbfd(sym, args);
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
+		return symbol__disassemble_bpf_image(sym, args);
+
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
@@ -1655,11 +1661,7 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_name(dso), sym, sym->name);
 
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
-		return symbol__disassemble_bpf(sym, args);
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
-		return symbol__disassemble_bpf_image(sym, args);
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
 		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
 	} else if (dso__is_kcore(dso)) {
 		kce.addr = map__rip_2objdump(map, sym->start);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 87d075942de6..0aed5c8691bd 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1816,23 +1816,17 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	return 0;
 }
 
-const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
-			   const struct map *map, const struct symbol *sym,
-			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
+static const u8 *__dso__read_symbol(struct dso *dso, const char *symfs_filename,
+				    u64 start, size_t len,
+				    u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
 {
 	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	size_t len;
+	int fd;
+	ssize_t count;
 	struct find_file_offset_data data = {
 		.ip = start,
 	};
-
-	*out_buf = NULL;
-	*out_buf_len = 0;
-	*is_64bit = false;
+	u8 *code_buf = NULL;
 
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	fd = open(symfs_filename, O_RDONLY);
@@ -1840,28 +1834,70 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 	if (fd < 0)
 		return NULL;
 
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0)
-		goto err;
-
-	len = end - start;
-	buf = malloc(len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, len, data.offset);
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0) {
+		close(fd);
+		return NULL;
+	}
+	code_buf = malloc(len);
+	if (code_buf == NULL) {
+		close(fd);
+		return NULL;
+	}
+	count = pread(fd, code_buf, len, data.offset);
 	close(fd);
-	fd = -1;
+	if ((u64)count != len) {
+		free(code_buf);
+		return NULL;
+	}
+	*out_buf = code_buf;
+	*out_buf_len = len;
+	return code_buf;
+}
 
-	if ((u64)count != len)
-		goto err;
+/*
+ * Read a symbol into memory for disassembly by a library like capstone of
+ * libLLVM. If memory is allocated out_buf holds it.
+ */
+const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
+			   const struct map *map, const struct symbol *sym,
+			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
+{
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	size_t len = end - start;
 
-	*out_buf = buf;
-	*out_buf_len = len;
-	return buf;
+	*out_buf = NULL;
+	*out_buf_len = 0;
+	*is_64bit = false;
 
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
+		/*
+		 * Note, there is fallback BPF image disassembly in the objdump
+		 * version but it currently does nothing.
+		 */
+		return NULL;
+	}
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
+#ifdef HAVE_LIBBPF_SUPPORT
+		struct bpf_prog_info_node *info_node;
+		struct perf_bpil *info_linear;
+
+		*is_64bit = sizeof(void *) == sizeof(u64);
+		info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
+							 dso__bpf_prog(dso)->id);
+		if (!info_node) {
+			errno = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+			return NULL;
+		}
+		info_linear = info_node->info_linear;
+		assert(len <= info_linear->info.jited_prog_len);
+		*out_buf_len = len;
+		return (const u8 *)(uintptr_t)(info_linear->info.jited_prog_insns);
+#else
+		pr_debug("No BPF program disassembly support\n");
+		return NULL;
+#endif
+	}
+	return __dso__read_symbol(dso, symfs_filename, start, len,
+				  out_buf, out_buf_len, is_64bit);
 }
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 09a0eeb78a1a..01147fbf73b3 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -448,8 +448,8 @@ int libbfd_filename__read_debuglink(const char *filename, char *debuglink,
 	return err;
 }
 
-int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
-			    struct annotate_args *args  __maybe_unused)
+int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
+				   struct annotate_args *args  __maybe_unused)
 {
 #ifdef HAVE_LIBBPF_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
diff --git a/tools/perf/util/libbfd.h b/tools/perf/util/libbfd.h
index 7441e95f8ec0..e300f171d1bd 100644
--- a/tools/perf/util/libbfd.h
+++ b/tools/perf/util/libbfd.h
@@ -29,7 +29,7 @@ int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block
 
 int libbfd_filename__read_debuglink(const char *filename, char *debuglink, size_t size);
 
-int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args);
+int symbol__disassemble_bpf_libbfd(struct symbol *sym, struct annotate_args *args);
 
 #else // !defined(HAVE_LIBBFD_SUPPORT)
 #include "annotate.h"
@@ -72,8 +72,8 @@ static inline int libbfd_filename__read_debuglink(const char *filename __always_
 	return -1;
 }
 
-static inline int symbol__disassemble_bpf(struct symbol *sym __always_unused,
-					  struct annotate_args *args __always_unused)
+static inline int symbol__disassemble_bpf_libbfd(struct symbol *sym __always_unused,
+						 struct annotate_args *args __always_unused)
 {
 	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
 }
-- 
2.51.0.618.g983fd99d29-goog


