Return-Path: <bpf+bounces-49506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580CA197E8
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861AE3A4322
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1899D217F28;
	Wed, 22 Jan 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uk+uC17T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837621771D
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567806; cv=none; b=RrxIVLEii4mUVhGvEmvCrqy61vlQjfUT/VBuO3U14exgLNoRsniclri1ExOzugrHLopwuKhO/D1b9AH0xtoqESsrtb6N+UlBJXfrdU5P3pt9Y+P5FyahTB3whrS6QrrgzWE4qAzypsiVXZYkiZ0iIvw/mMcCOJJragwf8eHaAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567806; c=relaxed/simple;
	bh=/6e4emTQAma3I/ECUbvp8eDgQ0XP3VoFcLmrxffX71Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mm98vHNvoQ1HcdYEVl8a+atbWf5VSsHodvR/e1EtzGbmglc3oNJyRHx5NfiBhxZdEPYk8nQE3ZBErCNPiIOzwHTkSuFV/uhAESn4f2iI1CRA1qS+hJpmprLKAZ10RvnrmeziQyiZ7nBJnkTQ0iXhkDSFQCDXWhIwgDteI8YWX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uk+uC17T; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e578b0d2afdso18712285276.3
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 09:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567804; x=1738172604; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VogZlDmYyWqz8VLnX5mLueZuF1SFjnllQQUCqGSdoSM=;
        b=Uk+uC17TjtTR+PMrqoPJdhl0MXaeuSvIS/phiQFw8IoktxBfrAqga7Y4PBljZ3fPIo
         mv/rouFKQtSPCr4EzvuaYK08ZwA5+eWkSP8CbgUxXCuOblGKu+raL7p0zOtRZOqQfYVN
         v6u6iqWnXUAtN2OjpP+Rp1hdPN3qZAh65wLDSBavmJDsG1dAAHbWRrC5U9I+fXQSkqCZ
         AHej6dJqE/Opn3zx4JtjYEpnQWJMYivYya21uPDBWUsz1gk7QBstPfqnQRKoUZMRrc0K
         Mt7e3w24P4tE9DXRBYSKbwkpA1/Gd2kwjeFltxcOC0+uSBFSeDFSKz2uT5O5r9JMSVu4
         QyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567804; x=1738172604;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VogZlDmYyWqz8VLnX5mLueZuF1SFjnllQQUCqGSdoSM=;
        b=qq0esimchiY7kUg4ekvfmRDdrSKYht24AIHZlZ9Lv8FMcryTgi/1yZ+7zDjC7Bqphw
         ahMfZE+lPujwQ4isbm/mcJT96r3+x3GDffQ2VagF8MbMfW+ELXVoHMCuOmj0/NycBDsE
         fVu/ahKAcuiEz5SeSWor+qhqopJvzEHB7x2xoSOqwFka5HDSvt36Ix/Y6VAZ1YZV7G1m
         /ioI5f4U8cNpe7aAllpB6qfZFo9bCbYgoxxF1kqKta85uBKceM88+IYAZSFjz4kIjCHK
         mmLE91bDiHY5xxZ7N8uQvpo/kteKVraFABj92w3qPmAYVAwt/UEaw5GcUs6HwHCtODHl
         WOTg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8Jin+HidCucHULU6ySZQ+Gksj3n4st7C9z1lW3tME/7QCoEAZXjSPmGj6gXYbwFm4uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwtRshn0N1UZf1YiOn0NVhGb0fux1Nc9rJcO0o0ty+iWP6+o72
	W7pQ5YbdaczUEIzLIX/OtvvK3kd1QMwhpq9RTNWSMP8tqF2OvrCydqugFTwXW5px/WaIo9dIRUX
	HCHZ1qQ==
X-Google-Smtp-Source: AGHT+IHkuY00040+mvLKGu21zh7GGvsLOIJdp3hWaxKfD0++kd9sPhyMqVnTMrrTJitRqM1oG5JXLSFmPL3k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:a469:0:b0:e57:41ff:5165 with SMTP id
 3f1490d57ef6-e57b103232fmr44707276.2.1737567803903; Wed, 22 Jan 2025 09:43:23
 -0800 (PST)
Date: Wed, 22 Jan 2025 09:42:55 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 05/18] perf capstone: Remove open_capstone_handle
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

open_capstone_handle is similar to capstone_init and used only by
symbol__disassemble_capstone. symbol__disassemble_capstone_powerpc
already uses capstone_init, transition symbol__disassemble_capstone
and eliminate open_capstone_handle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index c0a6d94ebc18..c9845e4d8781 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -137,33 +137,6 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
 #endif
 }
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-static int open_capstone_handle(struct annotate_args *args, bool is_64bit, csh *handle)
-{
-	struct annotation_options *opt = args->options;
-	cs_mode mode = is_64bit ? CS_MODE_64 : CS_MODE_32;
-
-	/* TODO: support more architectures */
-	if (!arch__is(args->arch, "x86"))
-		return -1;
-
-	if (cs_open(CS_ARCH_X86, mode, handle) != CS_ERR_OK)
-		return -1;
-
-	if (!opt->disassembler_style ||
-	    !strcmp(opt->disassembler_style, "att"))
-		cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
-
-	/*
-	 * Resolving address operands to symbols is implemented
-	 * on x86 by investigating instruction details.
-	 */
-	cs_option(*handle, CS_OPT_DETAIL, CS_OPT_ON);
-
-	return 0;
-}
-#endif
-
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 				  struct annotate_args *args, u64 addr)
@@ -309,6 +282,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	cs_insn *insn = NULL;
 	char disasm_buf[512];
 	struct disasm_line *dl;
+	bool disassembler_style = false;
 
 	if (args->options->objdump_path)
 		return -1;
@@ -333,7 +307,11 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 	annotation_line__add(&dl->al, &notes->src->source);
 
-	if (open_capstone_handle(args, is_64bit, &handle) < 0)
+	if (!args->options->disassembler_style ||
+	    !strcmp(args->options->disassembler_style, "att"))
+		disassembler_style = true;
+
+	if (capstone_init(maps__machine(args->ms.maps), &handle, is_64bit, disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
-- 
2.48.1.262.g85cc9f2d1e-goog


