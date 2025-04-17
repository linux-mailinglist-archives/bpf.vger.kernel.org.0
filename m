Return-Path: <bpf+bounces-56190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAF6A92DB4
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02428A75D4
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B7E224240;
	Thu, 17 Apr 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RvtyyBGc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FEC2236ED
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931287; cv=none; b=iXsPrsVzgl/+Z/npddIBli/DbPeyi6iQaWOzM56om/oSrDg2V4B8qmEacEruTgG8JQ8WuKFIZ50uNI4778htZ6omsh3dwK2pKgIZXYoQfXytMFyRxC78gH1pAAdwRTTH+S/x387ZfpkMwu4zwNfZQILNg1CHXi967ApGVAsMImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931287; c=relaxed/simple;
	bh=LRLZdT5hOWA0SXwX+weES0oI2ZWCXSQ23XqvPbFD5aY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rD5RFfCugqoGtFU9jUNgCVy4b8uRZCUxiD5BiobsnqzoL8FVFBjgxL4HK7O6vNZD4tIvTPne25lAuwapgV7sdWaYv1r3ANHnXbQE/pYFu4fHaFgbNU8JXfNMucf3Wi2ZYCo+YB8WSBdJavR76FNBpbFDmPQOqlSRMcLdKqh1xJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RvtyyBGc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224192ff68bso12622135ad.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931285; x=1745536085; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+v/iA3QAz14KzOUNaxFJb9QhGqk7bNH0V+P+kCM29I=;
        b=RvtyyBGcYB9JfwXtI52aNH7Xuq0llXIi4DgzFPp7sylcC+vrWjB+FnXLRe0rKJNaM8
         qYFZWXsK4qycA54s04DeKrmTOSxbPZ03AYIaGZ8SyTYK6x/X/hTQISEihpo6dJLrkxJT
         McTsCEEval9miCnqz6FwZfR4VgJ6jX9GiCfDfg3F2jifmppeLhc3RtuMFR3eM0nHoiti
         sHrXcI5Jj+UMevq523ZrvhoHPLf14FUnBwQ3YGdq6tW1IRtRp4JPT55zkFNKJPS16jfp
         u92eT012Y2YYpxNfFs4q/tyFPu59+k0iyJzkq+V8z7Qf7Oi3OPRivlprq+2Y9CkhkUVs
         5veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931285; x=1745536085;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+v/iA3QAz14KzOUNaxFJb9QhGqk7bNH0V+P+kCM29I=;
        b=pWUnG4fcfqSB/13ZFm2e5na/YfYzkq8y5revRlNoW/DUhC4uM2fofufp1fwhpmWxsZ
         vwerDCHZ3CosJIIPDVz4X5gnPfchfIpWk4ssYAGbpNvuFqwk1JVmj92jNSrX4oEcic8z
         uTY6WpRgpGslnBG8cJdiaRbGVzj53buzbc2/F3z3s8+azHqQ0H91Sz94rneg4Tmjch93
         N8K2ErWVhC+M+46EsFFLrbOzwgzhaaLuhdZ9P7cXO4TxT/PyGBzEeh4/2Gv52YohTHZx
         lqoUXBEqm6jEXATQoFr8Gdhb2ui7yPMdn9ApIOe6lPecjgDRdPMcYiSaT2ecfPNprWYx
         n8cw==
X-Forwarded-Encrypted: i=1; AJvYcCXLgr/RpkAsetVichMAZGM8MJ9j7U8t3ZOmsg3oN4qFiV5Sl68pz135b4aldSP9DfTe9uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzc2gTTLC4besF4wTIUiuTcaVxfQqVAqLW/qj2Z47460B+f8Fu
	HYw2DSdiQOeexipKleIw1zm/wBS/Q/H7z2gHUtn3Tok5dRj8j4NyCTGLiGFxLXr6wz0figfLuj1
	MTFdijg==
X-Google-Smtp-Source: AGHT+IG7ZoF5x6T+kA85kaMATkQC66Ptfdqe25x2XYwjUy5ZUI7EMa3SwBgwuXxfCajqgxBSSEbaedI1jfQj
X-Received: from plrp11.prod.google.com ([2002:a17:902:b08b:b0:223:432c:56d4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80f:b0:223:fb3a:8647
 with SMTP id d9443c01a7336-22c53607c39mr9603665ad.41.1744931285231; Thu, 17
 Apr 2025 16:08:05 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:26 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-6-irogers@google.com>
Subject: [PATCH v4 05/19] perf capstone: Remove open_capstone_handle
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
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
2.49.0.805.g082f7c87e0-goog


