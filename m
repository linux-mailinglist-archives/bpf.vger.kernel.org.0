Return-Path: <bpf+bounces-49445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D44A18BEE
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 07:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA177A4634
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 06:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3CF1C1F19;
	Wed, 22 Jan 2025 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyKVpYj7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F61B87F1
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527071; cv=none; b=ho1mNpQyTwHGuI0pfVYgngX1uhPv7OAxmkFgbOugsImTADrT4GhNeTmM1J44sISh9vi2+35YCvU5EOtVVhvsnFBfPosfqYnzFBeGzqBNlQT+DLLj/dMpncrDxp9lx0JtS1LDUWPBrBm9Dj1nhxW/o9O30NAmj5JDQayxL1bs/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527071; c=relaxed/simple;
	bh=ksmTITiwDHRKN7AM1iSFOtcCcIcP7GGHu1o6+CqXZco=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ifR9UP4ZotKlGH0dLdsSJSYbRM/Q3m2j1KBWTB9EeRJrFXkR7p/MOlkYAE3FsaS5jN/fi1Ni6AdW/Xa46QYjVSYKqwWlXgVcXpPDOVkULotfy+W0zUdf+Af2J6+0j+mK7V0uxPZZw0hC1bP9LMKomRKe9xPrM4EAzp5G5PKahPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TyKVpYj7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e399d4ef55cso16786425276.2
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 22:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527068; x=1738131868; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HtzTzHqLOrR4WcyKkQw1nPTI/K9PhaOnccVbKtmGOUc=;
        b=TyKVpYj70eRmTUWHD//d+KGPRiHo3IMzlkXgrMfmfr0HxaVQXKhrmOrg75yfZNgttk
         cAGWGss8N0WA0PhWdmGJTYUb1gvwi4oOZ8kzbfn6QU8BrQ/+DtSe7V6aTfwXEqAo3ZJR
         MhnOpbUdbuRKWJsKxZJ/5jij8M/AXY2iasXu85UzE1b1VEwde17l6z6ivTWNwD+KASDB
         G1UAaUfcFdiCjeCyAkxuqIGDTJVw68aQqJyFE6aKQyY30CKfFyj7TpfqWqb2u3eg++15
         XDTX/uIBKUKVNgeKoRTVczBsxgt7/bDsiw3o43nc/jxuIEvfC/w2Lfz6H7/v7+CEt2UN
         /dPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527068; x=1738131868;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtzTzHqLOrR4WcyKkQw1nPTI/K9PhaOnccVbKtmGOUc=;
        b=amgH3Ur3wo7b8aGTGkYIHiohXdptvW0s+ZYmY1SfQ/T3qPgqNJ8O9kimu+ZkOBCJdM
         pjGPj1tcGWUMPVjYvGjjvHjYL7KV3Hk8R9IqWvo+JCwRSg90cL/xpmvm3tNG0oBlq/7M
         aQrjAW/0IYWE0VmsGhWpZqkNEfp/jHYZFD7j/0To68D2VWawwpJS99o3jSFjoTVHBK8e
         7usXTaDfuddFt+ALlmOmZaWLhyn7+twISPTBOhgq0qGqnqyKmzQizRP3RAKK9zqDQ8xV
         zioNZQX3HpvzTQMzt25qkDR7+tr2zvkU+yXIGHFqiTG3Vo6XJw93dlZVGUAowHyCLFta
         kWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbDsQvH96tvuIwRHm0b/Khc08mjBp76eTTMS87wgFEuKgiCn77lq4Y2U8IACTKnME6SAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0c4h/kNvsM47PrsrDNv4gTyl8ozvxl9O2E/8daT67Xg+UtlAw
	jYlSRxV54zlCYwtzLip0vnC3t+baEFe1Bzbjj2mq0a4xxlNtPOEe/A+zvkYMl3nR5EaUon3PPBJ
	mFg1X+w==
X-Google-Smtp-Source: AGHT+IF4xW6MszewyE48AJoSmqv42vaUKpGWDsoNDMUd22FuA0iZtmjyorbaunxgqGCpQY+ff4Pe+DYCCOq9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f8c:b0:6ef:4ba2:6bfc with SMTP
 id 00721157ae682-6f6eb95f9eemr535417b3.5.1737527068640; Tue, 21 Jan 2025
 22:24:28 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:20 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 05/17] perf capstone: Remove open_capstone_handle
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
2.48.0.rc2.279.g1de40edade-goog


