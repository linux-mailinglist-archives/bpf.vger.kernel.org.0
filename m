Return-Path: <bpf+bounces-69976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F3BAA6B3
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5B016A551
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 19:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F3257828;
	Mon, 29 Sep 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3w6i+ft"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872352512E6
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172930; cv=none; b=D+jXLZL7wFcIql7mAvcBuKtUIIi45XEQpTsrS1d/rB6SJdej6+e9hgWKTFtQxFYnRRfv/+jjbRE+ux/0nr/vo6yrGhSpWm6BZyGi/kq6EX05oYU+EdkByU2VHd0b3u7w4l5LEn23x3nt7j6DjoyLIzPfohZA8IfajdZAsVBG8bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172930; c=relaxed/simple;
	bh=UcoUgqD5Q/SkkemokbzVJ+iRz4obkkfuwAK0b461Crs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=m0lu9+1fEM/9tHIsziWmf747CnFulHkayNPNc1soERigcrrcsWPxDys6uvVchXngUMkeT8g6Eqlqd+UXza6YGGAZ6tgwNbotWSacoreqyfhZZ+zHvRpCJE4oPoJq6m0NuQG/BOsI/UDMDakNkGNImu4ckVDSt5q4MYYHMg+hIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3w6i+ft; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-336b9f3b5b0so2530955a91.3
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 12:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172928; x=1759777728; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDZ0M0yiFaINDqNMQn65gDjbecQUNUjlpaqlu/RqK2I=;
        b=p3w6i+ftPrDkUqxxcped1KiUy9YHWkk+yPMGN5b+uZlBMZcr6LAVpGwXKlnFojDiqo
         tEndCHyYQPvyNR0jy+MgSmipXXYxn/2pTKrfQPzsGjqoZJgtdWMqmH5Dlcxe7zElYQi2
         A1jXbssINrQhswDJLeeuYsZ17s7/M16+NDwLKUr9YlnKfieUV6l02AlfnoJm5t4WUBRK
         ye3wCdDpL+itCOd1C3H7X5Jwep0HJkUw4mvUApLEgrojPvV+R6XHAbzJXLSnGcshwY3S
         nhhVt7LEStJIH3RyM72XubnJm4XzCJxsBbU01Cn9xDYQstFirgXlOEe6AGVnsn1PMZTZ
         v1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172928; x=1759777728;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDZ0M0yiFaINDqNMQn65gDjbecQUNUjlpaqlu/RqK2I=;
        b=rMigQjjpYvOMo5o8ssdtJ6EDGLXdouTMVsRvkyPdawo5gOJmlCCcBzUjeb1lIlBSBx
         dIGcyzHEnSPxA1VK8V5AcS645/wJV8jsa9Sxi3IW9mwpXuogGluVVnh5iazYTjF+NPZO
         zEJ1h9LRoBOj0rR7mCBnndhfoeYabl3QPdShyW9HenYQZ6xh7HOqVJYMu21agtB3wmFC
         +mx7zp4hJflxTV8j9LE51lft4QBLBBAA5XcMXWIUhlMEHlzNfxX+hX1GXvUGMbuZYPsD
         ta0pbgvxWK6GOGTeN3564HTPDhCNnapCU9gEADKCOMUGEuf6xWJd9bQckUFSJrpjlTKU
         3ytg==
X-Forwarded-Encrypted: i=1; AJvYcCXXlnSFRGJIAjjcVCx/dYaGM/MwmEQGJ/mrjxUTVnrXLCnSzNaZtWnwKMHp5NsWneEHkaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15H4f/YVMFAWNg3oSckESwOFFzuVJ2uU9V0H/q6NL6Qc3trRo
	Kl74sLEXZir8mopnalRdvbhtVLaQJNE7AzcgB9MMheBgvh8qcH8Jp0vXQOBrPOtV7oajhXlYcXp
	g4NuehpRpQA==
X-Google-Smtp-Source: AGHT+IG/L8wfV8J+ckgrkT+kb7TWIc9uNlSseJshUzk1fQYWWvGgp/ovT6W4Pa0aDHCOn4arQ2uxbLWCwwft
X-Received: from pjber8.prod.google.com ([2002:a17:90a:f6c8:b0:32b:6136:95b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7d0:b0:338:2c90:1540
 with SMTP id 98e67ed59e1d1-3382c90186cmr5122050a91.20.1759172926884; Mon, 29
 Sep 2025 12:08:46 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:07:55 -0700
In-Reply-To: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929190805.201446-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-6-irogers@google.com>
Subject: [PATCH v6 05/15] perf capstone: Remove open_capstone_handle
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

open_capstone_handle is similar to capstone_init and used only by
symbol__disassemble_capstone. symbol__disassemble_capstone_powerpc
already uses capstone_init, transition symbol__disassemble_capstone
and eliminate open_capstone_handle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index dd58e574aa52..01e47d5c8e3e 100644
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
2.51.0.570.gb178f27e6d-goog


