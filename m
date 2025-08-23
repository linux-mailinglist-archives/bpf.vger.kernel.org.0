Return-Path: <bpf+bounces-66348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B6CB325FE
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 02:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B607216914D
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027EA17B418;
	Sat, 23 Aug 2025 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7dYMps4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FAF22068A
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909188; cv=none; b=MfLUrDmWSmimrL059WWX+YKmgHoRct5pzDtNfEVurV3osrHnrUlYjoePVASK8NsaJxBf6ew66D/gvTLlr+3cEMgJU6wirwq6Kni50FLsrrWyWEU3IQSV2dxxJ+op5zLYsZImVaRtpB2rWYyemkfROk05X73nI7bv5cRUcWFzUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909188; c=relaxed/simple;
	bh=wLFpqbMmcTY/fllGJKa8e5RF+S6JWZUk148fLGz1+x4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Xy0RsCegzjI9Z66hVvjjjgJDQ1Rpo5bZXOlCEMaxdxr+shXS/fr59p3ilKlNcVcoTUiJjuAFcLlvD/NKHnerVMzlBy+//mjf/D0F36L0BrnU3esPj+e3fdTJb9VAU860b+UGpQnYRAcxCPqQsX2ekkti73TDZ5TAhb3kB3W0u40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7dYMps4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244570600a1so31490225ad.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909186; x=1756513986; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZd+KViNkgPk6uGWtqta6gYv6vqzzqK5gvrF3dTKFc0=;
        b=k7dYMps4YgRIHvEOcltYLVx4vGdtB0lla/ouyNECcHu3ItQi6ui53VZWFdznzXC8yE
         CcNIrqElboPubpjbOFgRYh1elsq6ibI4mOt+dhD0wuYsOtN2VitNTc9nsd6UR+xxbq6I
         jAe7pECtYccyoLVNqsCjhi/TAUs9iOyR7aK1jc1OtJLKQ0bayeslSG91nVWe/mIe8Kq5
         3mrvLlDLdGQRd5AVev2zv67f0Xuh8kM/eiek80mcCKCYDnFP1VgHACxdz7VFX7mwTb8t
         QxZG8fPYSEnYtP3qJQXn9Pj6ZgzcI2XNzrWeknUKeC0vVgiQss+WfMKGS6GFyv4JUstz
         KU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909186; x=1756513986;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZd+KViNkgPk6uGWtqta6gYv6vqzzqK5gvrF3dTKFc0=;
        b=FdAoKtNfLz71wXOOgTX1l4SoW7I6jZF9UnRpg0KZYCvpcviEz3+Exkqv42G+iZPeAj
         51j4Qsv2qWpuaBC2IiZvNNq8VjJ9CBWvH/yoK7cXeR1oOwAeNVT7FM+jrhr8dEWmXKnQ
         xHgYMyJkNZyRTF/4SHqaoCy9gyB+8fGUL+6Uciqn33XJXp4NmeuKCTCxqxNe1dtam+vz
         tQfLuk7Y6saH2E1mSltJRz2sVfMc0Y61akMG3/TtgPz9NqJjlrFCdVuzUAGZzChHoO3U
         17u85VtrJ5pR+aYrGoJfHmdzIkAgFJiH6xwIDawLSna9qSyLsOnk3NClRTt0zemv6ZyE
         5Mzw==
X-Forwarded-Encrypted: i=1; AJvYcCWaVbEuVum6X+lBnEbJ5taGy0N/cFMJG1SaF7h4Z/H++YYTWW8V9v4kLTJGbOg+X6fJOKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5ALLsct0W8KwRFaZn7xgzM2OPfvjRdHJyFjjlRZ4rcOd3o/Z
	TU1Xl8f6PODDxSrVqmwerEv4/C4wvRs93mxpFIyqAWwHCxuG/rEmPmZsdYoYAtarskjpJJZyxwy
	EQ2zQ8ZAWPw==
X-Google-Smtp-Source: AGHT+IEo4i1Oh6GMUczyU8oICZtsLUiYPNm/BnhXDlA+3OjsdkTKGwRPj2wnAswxCKoDGQjOWgRa+76VTakc
X-Received: from pjh3.prod.google.com ([2002:a17:90b:3f83:b0:325:23da:629b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a68:b0:233:d3e7:6fd6
 with SMTP id d9443c01a7336-2460248450emr103031885ad.19.1755909185922; Fri, 22
 Aug 2025 17:33:05 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:13 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-18-irogers@google.com>
Subject: [PATCH v5 17/19] perf disasm: Make ins__scnprintf and ins__is_nop static
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

Reduce the scope of ins__scnprintf and ins__is_nop that aren't used
outside of disasm.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 6 +++---
 tools/perf/util/disasm.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index f7bba5e1e15a..a5d06f63a59e 100644
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
2.51.0.rc2.233.g662b1ed5c5-goog


