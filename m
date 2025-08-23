Return-Path: <bpf+bounces-66342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E06B325E9
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 02:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB2A625A94
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D5A1FCFF1;
	Sat, 23 Aug 2025 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7J1V0/B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC0C1F428F
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909175; cv=none; b=nQ013YZ4fivL8Y9BM3swkzWkLk6zw/wdOjDYvRb9Q8ndIcy/8gD7lcW7mXElf9xLWVytklf/pTtWGyz6/tUi2CQsSJTXNfwElnYi2vJ1Y7nGIAChM+olqmVt0tCa0odnff+74ISnGThV1SAG5uxSZaKfOH50XWWf5o6zeHPTfmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909175; c=relaxed/simple;
	bh=Fd29IYX/xpHAqMQkc8EyODPN9XEe5UxH0NFcKN/ROns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YJ0Q9+6lm2lciYZWzd8OPobz5gp4/ezUeSrc2xMaPpuAGT33JtUvzcDd6kqgPfQ9F8WmHYwz7xZh0jy6US4jdl4rw10PjvS+1q14wb4zTTSanquNo7KP2OOboa9IdizJPEztWjRboCb80RcrQ/ssW+wrKfs8vLu/XMsdy5yetpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H7J1V0/B; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458027f67so58169235ad.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909173; x=1756513973; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrnABPnhnjLPpde8R8ZKcXd7aM+wSVwyXCweNa59YQ0=;
        b=H7J1V0/Bp12ff7OSD+bmvjEZQmhx5i7dN11ZlPldtnznuAVfhfNo6Ga2mJB1hwW3PA
         nTyiH8BGRtSga+niQoM3c998YG531EoNnrGmVpRUA3901rBH0ns/OuQKi4iX8GRTJeuk
         xZQBnm1QqE9R0f2cTugLVRmthEWKFD2vNX9LC0t1Pbod1dCGAJnSTd1SXv1ZP7kt1qzD
         iV5GqQlv73tZCohzsdZoY6+uqE2FMb431i3/ZGiQvNSG/61HYlkEXk327JnFgwqntaPu
         rSm6owa+veH2t0JUlLHw6Iu6uMtGT0J15SgXy+qTrBRH/hy7xHM+i/N7OwhFARXCQ0/y
         FXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909173; x=1756513973;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrnABPnhnjLPpde8R8ZKcXd7aM+wSVwyXCweNa59YQ0=;
        b=sZw4wQCaqXFj4YIT1DgLb2++aF2z06EJyWQjikBagz7FOwWBK6OTdH5v47nUGIuAiH
         HfuNoefUCpOQD6f9RQddAp8AMAX+uiMFymHZ90HcMK4iRlyEVs/Z8wPW7u6yQbQsQh3l
         fuTnQbkCme5Qwe3Uj2vxCc0yFZtYZIxVIQuD4d/ysocvnsJQUmyOL7IkpMMjwyZ+GZrD
         ugUVFyDx8Z2fMFVLsGwquFn1MxPk8ycVz20TTXtFPD6F+8w/cck7o1ZgQU4h0xbbYEaJ
         PHErKExoBIOJSxGq9Y9kAaXxMRJdo0Z65EhYRA5QRoobP5v8Ujd5Vth7T1Me3uh7r3M9
         AZjg==
X-Forwarded-Encrypted: i=1; AJvYcCVT/PXEV7G0/uyUzM4iijpeTF7glC6/HeKMoxp6vBPYqSd9GRXWtdCm78DblY3uto4t07c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwk1eDjuNDSS8DypTSRyyGNGKevAxnOG0APf5PWqeqS1D4VTP
	1iRgYvlGBZtcQRFhOgTqeDowBdxIE1DFHTF1NmiZz+9TW+buKlmPaxfHA6xJlwnoWv7eUUAw5/b
	FVRVl1yasIA==
X-Google-Smtp-Source: AGHT+IGAPuABV5wfdKDsaJ74CXJ2o+DPzp2QEHBI9R/mhtkFS1teUu4D5SJTofX9u3uOZBKi8+3TSgReDnK6
X-Received: from pljc15.prod.google.com ([2002:a17:903:3b8f:b0:243:31a:f8e2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc6:b0:243:485:26a5
 with SMTP id d9443c01a7336-2462eeb70abmr66268945ad.34.1755909172541; Fri, 22
 Aug 2025 17:32:52 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:07 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-12-irogers@google.com>
Subject: [PATCH v5 11/19] perf llvm: Disassemble cleanup
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

Move the 3 LLVM initialization routines to be called in a single
init_llvm function that has its own bool to avoid repeated
initialization. Reduce the scope of triplet and avoid copying strings
for x86.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/llvm.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a0774373f0d6..a28f130c8951 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -244,6 +244,17 @@ static void perf_LLVMDisasmDispose(LLVMDisasmContextRef context)
 #endif
 }
 
+static void init_llvm(void)
+{
+	static bool init;
+
+	if (!init) {
+		perf_LLVMInitializeAllTargetInfos();
+		perf_LLVMInitializeAllTargetMCs();
+		perf_LLVMInitializeAllDisassemblers();
+		init = true;
+	}
+}
 
 static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
 				    int num_frames)
@@ -339,7 +350,6 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	u64 buf_len;
 	u64 pc;
 	bool is_64bit;
-	char triplet[64];
 	char disasm_buf[2048];
 	size_t disasm_len;
 	struct disasm_line *dl;
@@ -352,27 +362,25 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	if (args->options->objdump_path)
 		return -1;
 
-	perf_LLVMInitializeAllTargetInfos();
-	perf_LLVMInitializeAllTargetMCs();
-	perf_LLVMInitializeAllDisassemblers();
-
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
 		return -1;
 
+	init_llvm();
 	if (arch__is(args->arch, "x86")) {
-		if (is_64bit)
-			scnprintf(triplet, sizeof(triplet), "x86_64-pc-linux");
-		else
-			scnprintf(triplet, sizeof(triplet), "i686-pc-linux");
+		const char *triplet = is_64bit ? "x86_64-pc-linux" : "i686-pc-linux";
+
+		disasm = perf_LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
+					       /*get_op_info=*/NULL, symbol_lookup_callback);
 	} else {
+		char triplet[64];
+
 		scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
 			  args->arch->name);
+		disasm = perf_LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
+					       /*get_op_info=*/NULL, symbol_lookup_callback);
 	}
-
-	disasm = perf_LLVMCreateDisasm(triplet, &storage, 0, NULL,
-				       symbol_lookup_callback);
 	if (disasm == NULL)
 		goto err;
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


