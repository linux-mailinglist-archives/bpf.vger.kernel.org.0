Return-Path: <bpf+bounces-70407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1F8BBCC64
	for <lists+bpf@lfdr.de>; Sun, 05 Oct 2025 23:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3629D189582F
	for <lists+bpf@lfdr.de>; Sun,  5 Oct 2025 21:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8892B2C1597;
	Sun,  5 Oct 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0rfF4aoE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDFE2BE036
	for <bpf@vger.kernel.org>; Sun,  5 Oct 2025 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699357; cv=none; b=KN9EFXoklkcAsSwj/LJ5BUnt1LZzH/Not8EdT/J6WmwtvueNKxWRFVFugrDKCgOm98I8Bc4UecdLRzdDDqAnGFga6PwPsT6PS2M7sKxA1aMfhWi7GgCBG/tQmobIayFx+yM4f6hkP1dyaonhw1zpzA2kRuduXiV1fxlg6kOmt0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699357; c=relaxed/simple;
	bh=WlZay7JBScKarmUmUW5W4rt0ZQNci9N/og2V+ODkwEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kM7k5jHS7vaxEcvrRN96OKbx+h8kUXolEVGmyw7A99hP1dipiAVhJhtRmKQGJpiFyYwvQcD/oapptILAdiyJiBBPMNk8WhOewzFPh9H2Rmbl27v2JRLXtpY37mpFLyKoBmQ109/Ly7hs0llUc+cDZ86/uKIqCKGroC2XP5uP7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0rfF4aoE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso6416930b3a.0
        for <bpf@vger.kernel.org>; Sun, 05 Oct 2025 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699353; x=1760304153; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wulS2NGvKURng0Egd2IGwMyFIkt/Pg3ipSmNBN6RrB4=;
        b=0rfF4aoEG5vsKg6z2lCfbHy9iPfb3X2nhejGwhUaXIG+h+SpERjF6P3elhAr+nDhsJ
         EI+/RtNRXreFDg1y7vX6uhLARYWQ8i73rqKfCIdzaEGERKx4bzk9jM+PCiR8xyQcNLAj
         7OgXIMiGWKGxbBOcj1ojnO9rngadVW5aToVN0KJZCmMDqLNccZc669fZW1qrcJ5fNwQh
         YUaeI/XpU/eBqi+wJdyv+74rhGSWTduWYAXfpJ6NscnPSa2w28lLEk6RFiOY/37pRwBo
         lKHJaTxfFP5DrjF6+bpC+yk2eutH5/jeBPPsCoWzT+ASCGba4BQ8ghdT3zkzJn/xGZKu
         Ed4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699353; x=1760304153;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wulS2NGvKURng0Egd2IGwMyFIkt/Pg3ipSmNBN6RrB4=;
        b=i/DWxD6y8+9S7xGJg+nsyTr9OzIQVgJhwwVefyrcAbuHcx8hPpuIq3WQ295xqhHKi6
         0S42eSNZ2WMmDY83Q+5/bMA/IFQXimeJRiihX6bSidt/CaDDV3MO39XO1FAaaNwNJQ4j
         cNLcjjz4esu+C1iTOdBvsHKvXHSW03wiIv/yA6WC9M6UlsT0W7lk0tom4xYL75JAIcLy
         YQw9Q8xAasY3LLgi7yCfzWtyqRxCO6EbV25+MClcytRHaADK6Gq5D8M5kHkp4YNdd7Ek
         5m5HX8JuFGV/gZzGyzxTP7mAWF9CkMoDJHFC6xWm8y+Ia5vc07rjWsNdbFI+gj6cbJRv
         48SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJB3VYk7zTpX6DmHq36tvxCdLQPWi911buG+XRb9hddHepOXVdSr1xqWko+oNXUNuqP5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuuGUAQzwclOYvcqz2jAxCCUt5PPKh416l2au4mNJ/uXcqs89q
	zYhY3rnCjXITB2zVn6Q41BXRQGECcFY5aMspyu8aoLiyV9IeEYwepq+lP8cxMxUaPztyuvFgOKW
	A6RR15+w/BA==
X-Google-Smtp-Source: AGHT+IGisVDrX4jLxBH+/IAg/iMlAvXEniLcqb7zAD7YH4cEtUgSeVtwpZqI4UICoBZYGGFSpiSyYOt983pn
X-Received: from pgnr5.prod.google.com ([2002:a63:8f45:0:b0:b62:8092:7d58])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f90:b0:2c0:227b:13ea
 with SMTP id adf61e73a8af0-32b61e5c57emr14386613637.22.1759699353384; Sun, 05
 Oct 2025 14:22:33 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:07 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-7-irogers@google.com>
Subject: [PATCH v7 06/11] perf disasm: Make ins__scnprintf and ins__is_nop static
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

Reduce the scope of ins__scnprintf and ins__is_nop that aren't used
outside of disasm.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 6 +++---
 tools/perf/util/disasm.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index e64902e520ab..50b9433f3f8e 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -247,8 +247,8 @@ static int ins__raw_scnprintf(struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
 }
 
-int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		   struct ins_operands *ops, int max_ins_name)
+static int ins__scnprintf(struct ins *ins, char *bf, size_t size,
+			  struct ins_operands *ops, int max_ins_name)
 {
 	if (ins->ops->scnprintf)
 		return ins->ops->scnprintf(ins, bf, size, ops, max_ins_name);
@@ -828,7 +828,7 @@ static struct ins_ops ret_ops = {
 	.scnprintf = ins__raw_scnprintf,
 };
 
-bool ins__is_nop(const struct ins *ins)
+static bool ins__is_nop(const struct ins *ins)
 {
 	return ins->ops == &nop_ops;
 }
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 2cb4e1a6bd30..09c86f540f7f 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -110,13 +110,10 @@ struct arch *arch__find(const char *name);
 bool arch__is(struct arch *arch, const char *name);
 
 struct ins_ops *ins__find(struct arch *arch, const char *name, struct disasm_line *dl);
-int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		   struct ins_operands *ops, int max_ins_name);
 
 bool ins__is_call(const struct ins *ins);
 bool ins__is_jump(const struct ins *ins);
 bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
-bool ins__is_nop(const struct ins *ins);
 bool ins__is_ret(const struct ins *ins);
 bool ins__is_lock(const struct ins *ins);
 
-- 
2.51.0.618.g983fd99d29-goog


