Return-Path: <bpf+bounces-69980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF68BAA6C8
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462433AEC90
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2C3275870;
	Mon, 29 Sep 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3xGBQKK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB026B759
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172948; cv=none; b=dZgNGJZaJH4RASAkAOO6wFah3hFfAFIqSg7Javo2uDdoFLB8WRk4Sz/zkYSGJGW9hvKJ6KWEl+WLFF5fyLTzEq2y4M11tKosGRaANMX2JwfApcJzqqNPpnjDWaATM0/tgrqyRBN/B8/5geCFAZGCovT/BXXZZa6p96C6cxNMQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172948; c=relaxed/simple;
	bh=fKtsBVVZrwXhvs4xGsoMfIzV+lzZRRuS+hR0a0WuWTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RVNTJMnwqnONlLCmA1SAX3xSUfXZ8KA8IbisXmQKTJ4rS9gZYm629GfWYvSAn1r4TJKFk5asFN2N2rUr5MU2XlyL9Ik1HECl9ith9Naao7ZglnC2Njn5UTjE5D+cV58B/QBgTgJ3pz3mNFq7zSja4y4j9nYvt17ZeGkhy1aKe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3xGBQKK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e60221fso6953069b3a.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172945; x=1759777745; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23me5LsIGKvV3LZyzJtrbgmlsoLLJrcCc9Uj9IrIdaM=;
        b=T3xGBQKKurcLxVLN3OkYa/fL4Navv80sJtfdny/VoJ/KIuC4ur+hcodAU6imEre4K7
         ceZGpX+ICKGQUj0l6gdBKVjSvmo+TYLM/vllpfZUQG9hZbeF4ObhtkMUFo/GcoMR2eXP
         rjgNmmXL/dhOkwZuiUoKp30QVjAqwFMBDT8FheZnAWPqVSlsB/5E8BMmng1djGlw+R+D
         /sApBWrByJ4/hl5a2z+q1Z4q0JlJrbCiQJt13nkUCdIz+SSEdITj46Yh+k+uYv21v1sx
         8SZgD/Z5JOx3cvnSGoFZ/vd6fCNUyVPNzUq56UyfiaPotA+1raS5Rn3jyelimvkvkeYp
         jWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172946; x=1759777746;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23me5LsIGKvV3LZyzJtrbgmlsoLLJrcCc9Uj9IrIdaM=;
        b=C3WzqfyiIVO9xErlf1yH+ZvTMq1VaqCthhJXVnMgzHIQqH7dICzs0xxwaXrkHac1kQ
         bz49IHhkp4wcxLBPiB6HdiJJn8ty5mv2GcHWxH50HLWfi/ttNnLnxf7gzFnq3ueuQ4Yq
         JvFU/0s+mzW2vofg+t1i7bC/NZ229CWhVATi88rkZGvl1V97LDPuxrWYRagqRVoQjRx3
         Kn/fn8BNGNMlznIT4OO+vX6sfGqGszogk/hq9VhkHjTUTnfK8EWjMJ4uIwoWRPzFLz/P
         XZcVTpGTDXnYmSDJs3gEh72w+rgJIbL0ZeI84LgSSrXB1BPNkB+Bma2xNZbRPUp0VK71
         caMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsQBcbRiOJGVG9ZKXlyt1DERUJlt3SzBMZ3W5HTn5FRtztzrGPBSDknuHZZ9lH9oeoW2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDplgdOuqNxKQIVuv2uVX3XdCmrE3U7i5ekjnrbMSUPZ0KBeIy
	/CRxTiYDQDJfw/+XAORLozMT5A2A4E8vvTXc0Fqf6pUiKO/R2WT0j7xT6lnjmfIGf172AGFwb/I
	LS4F57DvMuQ==
X-Google-Smtp-Source: AGHT+IEGJkvupWf4rQtKx0upUagq28uTpq7hSM4UAUkHSWoRUnkpLsZoBBntb8d18v7zVQzjqen0T6+nL+7f
X-Received: from pgbdp9.prod.google.com ([2002:a05:6a02:f09:b0:b54:fe27:c3e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d98:b0:248:86a1:a253
 with SMTP id adf61e73a8af0-2e7c750079amr21765837637.15.1759172945527; Mon, 29
 Sep 2025 12:09:05 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:07:59 -0700
In-Reply-To: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929190805.201446-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-10-irogers@google.com>
Subject: [PATCH v6 09/15] perf dso: Move read_symbol from llvm/capstone to dso
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
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

Move the read_symbol function to dso.h, make the return type const and
add a mutable out_buf out parameter. In future changes this will allow
a code pointer to be returned without necessary allocating memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c | 64 +++++-----------------------
 tools/perf/util/dso.c      | 67 +++++++++++++++++++++++++++++
 tools/perf/util/dso.h      |  4 ++
 tools/perf/util/llvm.c     | 87 +++++++-------------------------------
 4 files changed, 97 insertions(+), 125 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index fa9aa9cde68d..5aeae261f7ee 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -434,66 +434,23 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	return 0;
 }
 
-static u8 *
-read_symbol(const char *filename, struct map *map, struct symbol *sym,
-	    u64 *len, bool *is_64bit)
-{
-	struct dso *dso = map__dso(map);
-	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
-
-	*is_64bit = false;
-
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
-		return NULL;
-
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
-			    is_64bit) == 0)
-		goto err;
-
-	*len = end - start;
-	buf = malloc(*len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, *len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != *len)
-		goto err;
-
-	return buf;
-
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
-}
-
 int symbol__disassemble_capstone(const char *filename __maybe_unused,
 				 struct symbol *sym __maybe_unused,
 				 struct annotate_args *args __maybe_unused)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms.map;
+	struct dso *dso = map__dso(map);
 	u64 start = map__rip_2objdump(map, sym->start);
-	u64 len;
 	u64 offset;
 	int i, count, free_count;
 	bool is_64bit = false;
 	bool needs_cs_close = false;
-	u8 *buf = NULL;
+	/* Malloc-ed buffer containing instructions read from disk. */
+	u8 *code_buf = NULL;
+	/* Pointer to code to be disassembled. */
+	const u8 *buf;
+	u64 buf_len;
 	csh handle;
 	struct cs_insn *insn = NULL;
 	char disasm_buf[512];
@@ -503,7 +460,8 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	if (args->options->objdump_path)
 		return -1;
 
-	buf = read_symbol(filename, map, sym, &len, &is_64bit);
+	buf = dso__read_symbol(dso, filename, map, sym,
+			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
 		return -1;
 
@@ -532,7 +490,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 	needs_cs_close = true;
 
-	free_count = count = perf_cs_disasm(handle, buf, len, start, len, &insn);
+	free_count = count = perf_cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
 
@@ -556,7 +514,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	}
 
 	/* It failed in the middle: probably due to unknown instructions */
-	if (offset != len) {
+	if (offset != buf_len) {
 		struct list_head *list = &notes->src->source;
 
 		/* Discard all lines and fallback to objdump */
@@ -575,7 +533,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 		if (free_count > 0)
 			perf_cs_free(insn, free_count);
 	}
-	free(buf);
+	free(code_buf);
 	return count < 0 ? count : 0;
 
 err:
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 282e3af85d5a..87d075942de6 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1798,3 +1798,70 @@ bool is_perf_pid_map_name(const char *dso_name)
 
 	return perf_pid_map_tid(dso_name, &tid);
 }
+
+struct find_file_offset_data {
+	u64 ip;
+	u64 offset;
+};
+
+/* This will be called for each PHDR in an ELF binary */
+static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
+{
+	struct find_file_offset_data *data = arg;
+
+	if (start <= data->ip && data->ip < start + len) {
+		data->offset = pgoff + data->ip - start;
+		return 1;
+	}
+	return 0;
+}
+
+const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
+			   const struct map *map, const struct symbol *sym,
+			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
+{
+	struct nscookie nsc;
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	int fd, count;
+	u8 *buf = NULL;
+	size_t len;
+	struct find_file_offset_data data = {
+		.ip = start,
+	};
+
+	*out_buf = NULL;
+	*out_buf_len = 0;
+	*is_64bit = false;
+
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	fd = open(symfs_filename, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
+	if (fd < 0)
+		return NULL;
+
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0)
+		goto err;
+
+	len = end - start;
+	buf = malloc(len);
+	if (buf == NULL)
+		goto err;
+
+	count = pread(fd, buf, len, data.offset);
+	close(fd);
+	fd = -1;
+
+	if ((u64)count != len)
+		goto err;
+
+	*out_buf = buf;
+	*out_buf_len = len;
+	return buf;
+
+err:
+	if (fd >= 0)
+		close(fd);
+	free(buf);
+	return NULL;
+}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index fd8e95de77f7..f8ccb9816b89 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -924,4 +924,8 @@ static inline struct debuginfo *dso__debuginfo(struct dso *dso)
 	return debuginfo__new(dso__long_name(dso));
 }
 
+const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
+			   const struct map *map, const struct symbol *sym,
+			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit);
+
 #endif /* __PERF_DSO */
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index f6a8943b7c9d..a0774373f0d6 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -296,71 +296,6 @@ void dso__free_a2l_llvm(struct dso *dso __maybe_unused)
 	/* Nothing to free. */
 }
 
-
-struct find_file_offset_data {
-	u64 ip;
-	u64 offset;
-};
-
-/* This will be called for each PHDR in an ELF binary */
-static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
-{
-	struct find_file_offset_data *data = arg;
-
-	if (start <= data->ip && data->ip < start + len) {
-		data->offset = pgoff + data->ip - start;
-		return 1;
-	}
-	return 0;
-}
-
-static u8 *
-read_symbol(const char *filename, struct map *map, struct symbol *sym,
-	    u64 *len, bool *is_64bit)
-{
-	struct dso *dso = map__dso(map);
-	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
-
-	*is_64bit = false;
-
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
-		return NULL;
-
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
-			    is_64bit) == 0)
-		goto err;
-
-	*len = end - start;
-	buf = malloc(*len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, *len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != *len)
-		goto err;
-
-	return buf;
-
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
-}
-
 /*
  * Whenever LLVM wants to resolve an address into a symbol, it calls this
  * callback. We don't ever actually _return_ anything (in particular, because
@@ -397,8 +332,11 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	struct map *map = args->ms.map;
 	struct dso *dso = map__dso(map);
 	u64 start = map__rip_2objdump(map, sym->start);
-	u8 *buf;
-	u64 len;
+	/* Malloc-ed buffer containing instructions read from disk. */
+	u8 *code_buf = NULL;
+	/* Pointer to code to be disassembled. */
+	const u8 *buf;
+	u64 buf_len;
 	u64 pc;
 	bool is_64bit;
 	char triplet[64];
@@ -418,7 +356,8 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	perf_LLVMInitializeAllTargetMCs();
 	perf_LLVMInitializeAllDisassemblers();
 
-	buf = read_symbol(filename, map, sym, &len, &is_64bit);
+	buf = dso__read_symbol(dso, filename, map, sym,
+			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
 		return -1;
 
@@ -466,14 +405,18 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	annotation_line__add(&dl->al, &notes->src->source);
 
 	pc = start;
-	for (u64 offset = 0; offset < len; ) {
+	for (u64 offset = 0; offset < buf_len; ) {
 		unsigned int ins_len;
 
 		storage.branch_addr = 0;
 		storage.pcrel_load_addr = 0;
 
-		ins_len = perf_LLVMDisasmInstruction(disasm, buf + offset,
-						     len - offset, pc,
+		/*
+		 * LLVM's API has the code be disassembled as non-const, cast
+		 * here as we may be disassembling from mapped read-only memory.
+		 */
+		ins_len = perf_LLVMDisasmInstruction(disasm, (u8 *)(buf + offset),
+						     buf_len - offset, pc,
 						     disasm_buf, sizeof(disasm_buf));
 		if (ins_len == 0)
 			goto err;
@@ -531,7 +474,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 
 err:
 	perf_LLVMDisasmDispose(disasm);
-	free(buf);
+	free(code_buf);
 	free(line_storage);
 	return ret;
 }
-- 
2.51.0.570.gb178f27e6d-goog


