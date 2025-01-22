Return-Path: <bpf+bounces-49457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616CBA18C09
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 07:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D8216BF57
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 06:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9F31C3316;
	Wed, 22 Jan 2025 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EO4DABGB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D11B4F3E
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527171; cv=none; b=lUswtMJIaYpySLeFxQ+pwdRrEKuyPpk/+YUsEunlNAx3IG5JVOzpmad4fMAHctnlpTve7KWbLErCoQjKsfMri5Fe8NEAbU1KoiviLViJkAiaiNut7M271WbJhr2g+g/hyq7OI0SqoGbUYWFo15hanYCMMr+3JEVr7ELzDOIXgbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527171; c=relaxed/simple;
	bh=BfQOAR1G+at7pRYGYXzHQjPEnrcQ33cHSvtWSYC7XKw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JGvCcguSzaWaWEH5Qpy9rGyJ5EvBV3e1f8iwGPHQmfiHF3Nz3we0H+shHZg35yKFfv35zhb4jExaQLmm26laSNWGSmkpYJs1ZxnkE/r+yCYp8o3U/bfIor6SpG92OghzY42MRIoMt29EQJpo5iKjTDLQckKfobJ7Ucg1N/nycCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EO4DABGB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e54d9b54500so16407504276.3
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 22:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527169; x=1738131969; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgqdWXIgH31oO69HT02RtwzG7MxuXhHOOr55YpEQGAs=;
        b=EO4DABGB9M5LH0lBfxs+nYZ3Iz/nFBetOUEARsxxJEg0B5zbSzZFbJtoAlFcpiBhYq
         oYFGSwmYzsTv6D8qdQMVbyNC9DxM2RczL3JHXtwKOWP7cKZCdF1JkQOHNRpV126iKsoJ
         t5bTwlCVRZBd8wS6k5YJyjOB8qXRxI19JMH6MSYJKLBl6ZVEN8VRb2FRCYR95ih6F3A8
         s/FUteA9lJvOxpY9sd1HSFfVOam4PMTNiIm88FHrtvrClCKj3ITkY9JjKe1D+ydTV+5v
         aoxGxWH1/2l+0WxiAsM8iwWm3EmnnAInrLuOxH8UqixMeHMkwwC6z9EHeOdb3mwbvEo4
         BwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527169; x=1738131969;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgqdWXIgH31oO69HT02RtwzG7MxuXhHOOr55YpEQGAs=;
        b=TKtqNELTEdHPkp0G5lxEnhr0wiX1BNV2R8OpDd1up5t6MMeym1oJnvqnUw6ms+Vtd+
         pNJ3GtaKdMhhvZ1nFFeIyJrvWvMCfwc0mn7g+gLpqf7l0rzW8NolMaqtyI7nr7GfC4nA
         V8gVEpU8tAD9W0LOlQLAIDglaMqmgViXa63cO7p4r0B0s9YlsI+KSt2QpMrWdM2XlPyd
         1oWBerMrIL5Qff+QRjsQKb39f2TbAkan/si+HapXRLxg6hpSePck1cAXfp3Ng5PEOUkV
         ZtwwDLy3WH1HzQcx54XrsiTnhGZ0VVZCSYdDN0YStvtw2o22A6wTAnb4vHF579c8DOFd
         u4VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+K8txerWmHyim2bm8rH+gIey6L+Jf1ISq7N8rG83gTNZ7IHyDs8F+Co7z2XMl/SvB91E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd93up7CYQLRSNBvY1Kd7YVvvoftX1wqxJOyR796SNMDJn297X
	8TR1pJKwW/1GCU/jzKn5YzE7TFDKPEma7mOzc7vvugtzgM7Fj0Ug9qPuPgJxgWdfkMv8XM0BhBd
	3BT1Hfg==
X-Google-Smtp-Source: AGHT+IF6rwzVNy8tbQ12mHzbRHmKpJHEzsK35EPLx3KJfYalflkJcjMfzIoyWZyP5IcEbo2YvBdof+rOLPE0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:3005:b0:6e9:f188:8638 with SMTP
 id 00721157ae682-6f6eb9475efmr341777b3.7.1737527169492; Tue, 21 Jan 2025
 22:26:09 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:32 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 17/17] perf disasm: Make ins__scnprintf and ins__is_nop static
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

Reduce the scope of ins__scnprintf and ins__is_nop that aren't used
outside of disasm.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 6 +++---
 tools/perf/util/disasm.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index ebd86691acf8..b2dfd40588ef 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -246,8 +246,8 @@ static int ins__raw_scnprintf(struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
 }
 
-int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		   struct ins_operands *ops, int max_ins_name)
+static int ins__scnprintf(struct ins *ins, char *bf, size_t size,
+			  struct ins_operands *ops, int max_ins_name)
 {
 	if (ins->ops->scnprintf)
 		return ins->ops->scnprintf(ins, bf, size, ops, max_ins_name);
@@ -824,7 +824,7 @@ static struct ins_ops ret_ops = {
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
2.48.0.rc2.279.g1de40edade-goog


