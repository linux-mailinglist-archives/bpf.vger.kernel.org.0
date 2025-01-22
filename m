Return-Path: <bpf+bounces-49449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4BA18BF5
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 07:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC861882BA9
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 06:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5044D1C07C1;
	Wed, 22 Jan 2025 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIbZOfM0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873AE1B85EC
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527105; cv=none; b=cMKAM/rtKmZf15f8zv9CnT9KyvPMj42JLkuTf5ItmbjoeJZ2omP3mgrCkAOSaNX47yZxyHXoSWnO4GXSINSHVl/6Az4IfkB4Re/1N0HpnIFC65c985zf2rk3subsAn7Ta7ovpYteZI4HpPKftD6LhZPLQyuR5RiQ+umALlYUeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527105; c=relaxed/simple;
	bh=HyF8MzGPJg1E6Do/DMTf+qbt3SxXfZbYtVitHb/HJLs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CGMFd9p/HAoLZJ+wI9TRKav68j04MwTL3AwL6zYJ951RM/vwQrtSoBFEtw4Iw+dFl0RI6T9lbOPfcZM72fbGTauxAR94z3A0rlg4peSMfXTs5mY/POsBagZZuimSjiB4jjYrL7T3KIjKtkYZsdBnhm8DD6d1rYI2re6YhehQ9sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIbZOfM0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e572f6dee18so17071889276.0
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 22:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527103; x=1738131903; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgrvkZ657QImwi6lc3WsCCSLkVlVfHzjlVLn1y8own8=;
        b=BIbZOfM0oZMDcjTw8dHudjz/5IdMC7Adzc9/sPMbzypg962eT86wQLKnvrFkEzzXSW
         GUKDm7eVSJs2RILH5L2crREwT7U5DBjBygTMH1Tna+3YYR/vqaTc627r4/ldLWmFC2Up
         pZIUc+MOYrvcinziNMrwgunBbA4fkRvDzVqdQ3tYMo1/6LW0wH/h5MTASePiWtHNyuX5
         hNiig0ajiffFW8pKIpkZXdRZPkEvutmbZWOaKVLvwAjrwRndrhIs5VKcn6RyXZZvBEqU
         PZBkjXt6G2b47Wo91OTAsLvGjd7YhnZcbrqo48YNFHX7cf5L8WkBCi9mxjQ7CplEiwuh
         xveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527103; x=1738131903;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgrvkZ657QImwi6lc3WsCCSLkVlVfHzjlVLn1y8own8=;
        b=SvPmiSghYySj1H7sUYiOAmnurNELRp5cryIRn8HV2PzAW8AINm0VgCaHaJsk+ZP8Sr
         hsdCXlZje8iGOj682ipCFxzd4S+Q+er+mmgYiHOC4G84bQePPZOzxpm7rifc11Guswf8
         UQFURRTdiPfDt/yM1QW2IH8AwC8NI5re2NexYjgMopoKWnyT4ffCnpk8Tz9TCDKMn0jQ
         au1fUTJN4b46ASdU2N5AdCGyyFyPRbwfxUNzAURi/pE92/Rs4f6j76guyFNQ/mXKiius
         Q9RnXOCvWlxgP8s3y1RzTozlHrqyWh1XO3pVaqtiBpUEAuDnRgCqMu+8gFZ5kFQtTuDM
         jrAg==
X-Forwarded-Encrypted: i=1; AJvYcCXoDDWNoJbsm41EOFoIcRm9Xww8Jvhotrf+TmjQinCv2+EkDoKRv22udi6w+m56S/t4AVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZUMee8ZzU9bndVatypeqKqfCn1nzewTlKGVQ18m36qY/o16i
	4LggJ9ZG+lAblWakiZlyqZ7WsfUTHGEJTbv5iYxRH/CsZMQ37rYFDFU04yoB759AqZzHUFxHH2K
	fdHuu7g==
X-Google-Smtp-Source: AGHT+IFEOrfiAwnNwnDSaAeF9iqef1fiQ/E6IuDI5dItzM8nXl59fKPhAOg42XIax1O7ETkSWKQsfIZHvj1T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:5204:b0:6ef:c86b:af48 with SMTP
 id 00721157ae682-6f6eb649e8dmr258027b3.2.1737527102737; Tue, 21 Jan 2025
 22:25:02 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:24 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 09/17] perf dso: Move read_symbol from llvm/capstone to dso
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
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
index 8d65c7a55a8b..f103988184c8 100644
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
index 5c6e85fdae0d..0285904ed26d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1664,3 +1664,70 @@ bool is_perf_pid_map_name(const char *dso_name)
 
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
index bb8e8f444054..734e3a3d95f0 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -828,4 +828,8 @@ u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
 bool perf_pid_map_tid(const char *dso_name, int *tid);
 bool is_perf_pid_map_name(const char *dso_name);
 
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
2.48.0.rc2.279.g1de40edade-goog


