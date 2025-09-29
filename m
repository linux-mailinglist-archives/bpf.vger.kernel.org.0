Return-Path: <bpf+bounces-69984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B25ABAA6E0
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A4E17601D
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 19:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B2299A9E;
	Mon, 29 Sep 2025 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJ4QBprE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51F28489B
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172960; cv=none; b=hPfaDkaoGOAhS1rwc8ankdIynqb1l10PUhuAqXtuc9FZHVot7MzDySQJbF+iKlKrFcWcLXRIQiJyY0aOciSk4LDoUbtUachZO0jOB1pUd3lVXaZ9mp30RjaT8XVIMTieJxpRjrdEc5QRljw4aOWJn8Svm+Q7V2MS87BBiWet/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172960; c=relaxed/simple;
	bh=QAMXMzzdI9MdutH7eQN4wd9SUdKYuTS3iFPzHIudd8c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GPXbMk51HkGK25T52IZq/+xNw2hSrSHVDzndHwj8U26Gg6WgX/Uaih8Tx5/jBvkEa/ULBwac88v3ArvdaVePJZ4lkQWcyAmRzNm4TZZn3R+Rd04LTRTjAOwU4sXHjKTPADJbkRlb1dBBVsRA/cwwcH1D/baqq/DLiaBuup06EkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJ4QBprE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28a5b8b12bbso33430975ad.2
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172956; x=1759777756; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdcK/lBU6rEBVQg0qeNeqiUObE1KDszjje3klwu/MCM=;
        b=jJ4QBprEh0GjwKLc355Pi1mY26EcEmTi7iCE4S00B6KaqGD5baYxXDwtc3AlPpkDVl
         vhrcV+InhA5v847pZKpVfvITBifN/MlDGr45BrM57H4RI3ZI7l8y6bhFrgXcI2yTrQTw
         59f2waLEANfJhi3Ze+xc8kMDy56U4D11MBobrRgm8KmDNPATx+7/T1RJ9jmOw9bk+Mlb
         p4G7ui5gq8o2CcZFWCpjsh1Zq+K5RUALYZ6NhtvbnmUk7KPeSzzE7kG5ZVqkhhRAEd9P
         KCjICOUJ3UutStHz3uxtH8o+d9wULCnKEpx6I37onzYNGyMP9SuXoSRa8ivC0huoi0dQ
         aB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172956; x=1759777756;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdcK/lBU6rEBVQg0qeNeqiUObE1KDszjje3klwu/MCM=;
        b=Rlj0HFnM9bSp5Nzin+zVrpBaDHXi/i6SVGOadYchN8b+yN0a85bZSiDvyIy2nFwzgH
         Gm1XesHz2U+BNeHct4zk6cim2/BONMlBwStVvIAGkJgO75z/FdlsuwgGJLMSl7yo/azG
         ea5h2FwgRwLwro0dDoEBqQJ8SmUsbPtCVJJnckb4xf43uRgzQ9ghLNTIUwn+ehGaXazy
         6J8V/p0ayO5fGVp0uPEEomEJ+/fbEJAdfpioxgQva6ZH34+WSBCITiuRYrPcLPt0D+qi
         WGPkXiNm4mNIJdzWiHlbB2LDbMQrS/GcCBj4VInwm1RyjOxAIaRbDzesRKJzXzgiDo/6
         IlKA==
X-Forwarded-Encrypted: i=1; AJvYcCW+BEG5iPIKD5CrLtMEEYUxK4IXsAe55vGhqy9IYG2A59JcitKJYLT3VOkz4Y2hy4EDOfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZG3x9crTWqRaQXSQVF6EHs09dvrvpHGFzceAwFAyqFLl0nSoP
	OgybNfVSfa3aBuJnN6VZYFbaFFGg66zmK5oxUQDex+8Lfv/otBAYw54CaDYJ4/3UD5oJ2bf0iDf
	6sCpSwjNzQA==
X-Google-Smtp-Source: AGHT+IEJX47iOtVtrshwBHm4+RSHE5OXtXWHjA4rxRxxI9/ipxBIUfnBsBl2AQARp8ZA4p+cWOFp5/eQGOfA
X-Received: from plko4.prod.google.com ([2002:a17:902:6b04:b0:234:c104:43f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0a:b0:24b:62ef:9d38
 with SMTP id d9443c01a7336-27ed49d2948mr197295705ad.19.1759172956552; Mon, 29
 Sep 2025 12:09:16 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:08:03 -0700
In-Reply-To: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929190805.201446-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-14-irogers@google.com>
Subject: [PATCH v6 13/15] perf disasm: Make ins__scnprintf and ins__is_nop static
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
2.51.0.570.gb178f27e6d-goog


