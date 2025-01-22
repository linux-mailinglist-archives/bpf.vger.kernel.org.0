Return-Path: <bpf+bounces-49518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877A6A19801
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFA416D8AC
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7A421C19F;
	Wed, 22 Jan 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSV8wDVn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028C21C172
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567833; cv=none; b=h+3Ddj06basI7a1tAeH0NVS0QD5gnAfV+NDNy1158hAaPEEwmnRbohGxoF97cbt4i6Lx5QfbJA2szQMpNYkbUzis/ma2c5Cdd/2BD0TEXOm3HuZNcy3p7t3DFBRE9KIjQEaeDe0AAaprtq9RwOSdtsCD/J4dW6m3kwEhX8JaVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567833; c=relaxed/simple;
	bh=qYuXxLCF57TeMFaCU4NFh8p73KoL9Nl1rlMbdvZk9JQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QpZ4r5h2oFrletPG3B7CuYmIi9aC7YZdqW2qKOFIW1ZcAEGhGIz1CTQTVsIMrGsu404bsjWC6lWwZqHk/Y59Ia2/rtc4I6cNvxVhol+1L7xTX7bJcrxg7KUl/uvTamhKC/1YNtRVmH6xvKvChiKEp4TSPgqFTp/FIJsHoNcG844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RSV8wDVn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3988f71863so9230276.0
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 09:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567830; x=1738172630; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=haBR2TU+NQmXlaQPCGBZmJsdRZzJVYrdXgTgjxml9Fk=;
        b=RSV8wDVnZFobKB6QCXXO9GZSRg8/ZUicI1uaijME3lYFdIkQNkzsZF+GTxhqde4src
         H+a9gxSoK3rOYAz504Bxikdl+qgRncgp+0pRkNW7F6rAz0huFlZOpUs7jtKmIMh4Sofz
         drkBGqywQmaGKpNaI3sN2mmYqaBM0nCW061yeluA7NS5MNH/NNEgvJXJIZ2hjEkcJZr9
         49QFzWoOj0h2GCtyNgCmXjj+ImSgK1wC7T3KuzRPYD1C7uu7YlHor2ncrG1dMeSc/p7c
         P8BCEgLJUse6I/sUYvwg/QPFYwd6dSnjrQuCZhYxEwogCoYb+Z2jvIfRVJRlXWWd44Fp
         IHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567830; x=1738172630;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=haBR2TU+NQmXlaQPCGBZmJsdRZzJVYrdXgTgjxml9Fk=;
        b=ZXpkZgXqUcJNtfueolof1UhbAgVa3MjYoLa8LwYagjVdtG5cYObeKKHAWYj6ipR3A2
         vsd5CmSB8YsF9ChQl7Y7YoPj3yj4QSLqChjzD+teIcMkmYkli4XEqPm+ioA690JOQB/Q
         +HnBChjROjc8QpHtlghRD/YvFr7Pm0nyTKR43OICC31hJJv7DblOd8/POvbvzlzKrehG
         LFwjlgvAekWD82gDB+UxevnVXHzLfH5R1XTSCqonNQsvKJ9WJiOVOnhkxjbVoqmEWwXq
         GIm3RVgNEa9vUT/ID9TY5Ycy55F1FuJ38wE/cyFyV1yZ0pZ/z5dclWRFrhNy/S9xgvge
         p6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUgotE3oz159buY8qRga3ET6o3blDY3JMPoJVI0LkD5EvEFPjGS9xJ3SYFTD+gKNcQq2ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBp41NjTEU/FMe2GhZg6/feHoVr/NWI4LGeFnBtVI386JA+Vb
	Qxuwxpfquc+H3Xh2oAvWy5riE7UGaxE5bGKPXe1W9lM6xtI9f3FnI4Y6dswrBtpzzYUI/E0EyzW
	/A3S3mw==
X-Google-Smtp-Source: AGHT+IGJo7x2rI9e2t2V70cyAApaxwGRFhvDYsMitvoXzM7aW44S+AkLYf5FsMhLoQfA3mdS9KyAD+5IoZFM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:d3c2:0:b0:e53:b976:cee7 with SMTP id
 3f1490d57ef6-e57b103080amr40168276.2.1737567830426; Wed, 22 Jan 2025 09:43:50
 -0800 (PST)
Date: Wed, 22 Jan 2025 09:43:07 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 17/18] perf disasm: Make ins__scnprintf and ins__is_nop static
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
2.48.1.262.g85cc9f2d1e-goog


