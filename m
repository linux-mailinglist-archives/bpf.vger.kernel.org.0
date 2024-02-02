Return-Path: <bpf+bounces-21110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BF1847D45
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 00:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC24E28BC67
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DC712F382;
	Fri,  2 Feb 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyrvHKJj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27412F361
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917276; cv=none; b=VUqKWDyXeUHIZZPzzU1INHvUdv4lEbL+5ZEKSRIDm6Qxq2NzkQFyalWy0Q9QqNJ9MluK9+H+KldNzKO8WUU0pAdkW37bIdefCfReZyIr5eRWZPurE8gex0aFHvywrzvzRTWw5s32767sEI50y4UIoKKeQ7L7tYPpZ+4x6i66d7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917276; c=relaxed/simple;
	bh=R7HDLt+WXCKcw0UAraBcZnWD54QthkXyaQu13uOf35M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XKpmu8y8+udJTpwzDBGaVjNKVjon810ETvYveNdP+/AnoOJk2a3mIxJnJzBDWDqK8v4maTvtRkRh8h02fy7R/asCXEGuYtKTosbtF3pz+GDzdujeDAFwK4re7uxs+lhUTAL+C5jvMmxY0AifESMkpuy4pU5yx07MKZ4IqgMA5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyrvHKJj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60436130450so9478377b3.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 15:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917274; x=1707522074; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOc7/ot5clrlqkd/XVVApb41eylij+dgoGLfSlWPOp0=;
        b=AyrvHKJjjXcpTnTw4Q1Oh72rOi5vJrbZ3NSKSgFRcmHrdQ9urAxqzaDeeAWfqmw1CL
         V2OIprdiY9MJ0htwTWHjbjukLdw7GmjOkyqarwZWfqn2/8Nov6Ocp/QbJOAyaHPZqEhv
         hziwunHjYpud1MfPnxCijqL4At/8TCLcXP3ITG/sHjJf5dLMZBDCWVnSsVuJpt8WizXl
         wZDeqrqXusMSV10naS2Ovb/WYhlAqQRr2Xtbkc0txIShOu29QlZQm42MK7Ezu4CBW1H2
         OxpzDQzCpQwQLEealrpbXlNFI9Pleu4GOdpHUI3AnJSzmnPwCCL/ker674WkFBkQGxwz
         OW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917274; x=1707522074;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOc7/ot5clrlqkd/XVVApb41eylij+dgoGLfSlWPOp0=;
        b=JTMrIf7nBYwqIW4+FXBYjif7LWc5R0IauQvtLxhjmLU7L8wCFEdUnUw69d//GoydZn
         Bf8qWi6VB5SVBj8ctKn16NBGxZCPUsRuf5KhfXsk3wXdWQDmmwofkNgHGLJFJDb2DNg4
         SKMhi8BLd3vbjnY177MmAFm2NO3bnbIKTuhplk6CbJtN6sD+UXmG37/mfp2iRXW5O7Ga
         0WxkeOUVkG7ruz/p46OUnU3lovUV1Z6ENzqj+n9MjMTi8E9m/YEbPXRAQei7TBt+eK2/
         AJVTnQuL24Pu8QwwBgSfWO2/H15Po8rhsXRg0xGwPKltAc952lb9Z9j+TqZw2KveXo3C
         ZjKA==
X-Gm-Message-State: AOJu0Ywgw2TSQT0z/tsBVBw0TDo8Y4vMf33m+a3dyJ019Cm0c841USg0
	SvHy1gG/jHFtatFK4cybuXVgUpPC4rGyRMfy4RXtzl+TJ3qxbWaBoDxtx5ZXc4hHxho/yOLblnv
	4+ywgyw==
X-Google-Smtp-Source: AGHT+IHFL6+6WJT+TDjsN0v4AycgXqtEdFuE4PFoyenBnNnNjcCA2pFf3NUeukXxzibAja4cMAtIanSVNF3E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1b08:b0:dc2:398d:a671 with SMTP
 id eh8-20020a0569021b0800b00dc2398da671mr1024554ybb.10.1706917274174; Fri, 02
 Feb 2024 15:41:14 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:51 -0800
In-Reply-To: <20240202234057.2085863-1-irogers@google.com>
Message-Id: <20240202234057.2085863-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 2/8] libperf cpumap: Ensure empty cpumap is NULL from alloc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Potential corner cases could cause a cpumap to be allocated with size
0, but an empty cpumap should be represented as NULL. Add a path in
perf_cpu_map__alloc to ensure this.

Suggested-by: James Clark <james.clark@arm.com>
Closes: https://lore.kernel.org/lkml/2cd09e7c-eb88-6726-6169-647dcd0a8101@arm.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ba49552952c5..cae799ad44e1 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -18,9 +18,13 @@ void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
 
 struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 {
-	RC_STRUCT(perf_cpu_map) *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
+	RC_STRUCT(perf_cpu_map) *cpus;
 	struct perf_cpu_map *result;
 
+	if (nr_cpus == 0)
+		return NULL;
+
+	cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
 	if (ADD_RC_CHK(result, cpus)) {
 		cpus->nr = nr_cpus;
 		refcount_set(&cpus->refcnt, 1);
-- 
2.43.0.594.gd9cf4e227d-goog


