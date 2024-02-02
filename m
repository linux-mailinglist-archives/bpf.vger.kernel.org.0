Return-Path: <bpf+bounces-21114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CDC847D51
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 00:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5F01C20D65
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0BB133298;
	Fri,  2 Feb 2024 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcg4W7LX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B413246F
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917285; cv=none; b=p6oYulZR4R92WAuTM3jRKNp2Naa9gjDZzWhwH3VE33SLIAkMJKEuNmcixLmQuelTjNf1crbZQiXSz+B7SwtIeJltNsFzzrg9LXIsa2AcFjkkZ3thdWc8koJ7LbtHrI0zrSVssc+JoRD6Jmanaw87nKuq//gq9cYE41lWE5iw0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917285; c=relaxed/simple;
	bh=0FiaP31PDhjVbhEu1bCl/SbTIvgKTkMX5fOyfQItO7k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cPdlq5ZfeuXRqUfHCzv8JfHd7EOfZ+lADlR10213G1ZLeGPdOOuVZDr7ujuQkcpnOkX10RMVE85sqMgxYd6ZKl4C9VxuCqXgM/LtM5rxaQxwZP7zauu0y9wsRh7IhJTVRo/ZH7aM4ldWDpvQRr/X5Dur/vQOgIhOWZtnLSrs7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xcg4W7LX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60403a678f2so44279787b3.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 15:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917283; x=1707522083; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jm6+rGnwaR5/dop0r40XD+HXuvjfQ9BLsYsO2f1XDQM=;
        b=xcg4W7LXC/Lm4VGyXDbJWnjemFnNierLSmeKZwGDaq3FvGbLOZhjL6RBHwSmrdg4LN
         4J/YBgwjz3bsuDcyhPgpfadd5FHgi9N4n5s/f2wq5JNeVjpZuA6HhlGVvNAmOHG4ss2v
         2h6xH4iBi4gCpxIRixZVuXLwUGNIYdeDf9Q7hXNnlDlouj/WdZKoHZhgnuuG8BjnxU7l
         cASRrINfBVW5Yhob+Ry4VRjch4EP2OdQAI1+4ZrcY+ngfS1xjJXTIYJoAPbevkdWeAqp
         1WF1sk3zSgoBMJfV7/jT/PSA4p8XTVayJ+EkOCCyPrY8MWn7L7+u3C9qQilaklEgpf6f
         g2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917283; x=1707522083;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm6+rGnwaR5/dop0r40XD+HXuvjfQ9BLsYsO2f1XDQM=;
        b=fBfKvO1jFLgGp31+cm5x2V4jqoSzDaPFSOgzPyNJSFm+XjF8tVjxxqNnxqdf3+ci9w
         vXKVRqcgrtGPcA1usYD0sS17unC9ElgO44qQi1NONLXq8XcpbJF11Z06xC1019J0cbSu
         JENYDTyfRzYR9bUObNKQWOpb1iHAmFS4q0A9HHly2K5Z1pmoCXDjERSqw71wOK0EIl3u
         HC6NpsnAYhx4pwMYSWg91kG0Lfk9mN6UDdYr91BTmXgrBVMje/zFsGpREmsBNrQxARaR
         py4Ul+AlRQSr2Y0FxTMQZu5TqqU1JyQdEMuQaqff09ldbVX5b3cBboB4yWSrsZRzbV/l
         EafA==
X-Gm-Message-State: AOJu0YxQHA3WvH5Uz8luEn5ASWPJsF3dWmnP9dbqFutNA3TR0mfHGI6w
	dwdVyjRCpgyKpO0acgIkvlfpFEK3ScyO2MEfqBt5lHNNmUKfZOlTMWErWbxa9ryfH8FyKIi1N+X
	ScUC1fg==
X-Google-Smtp-Source: AGHT+IEIf9VK/cffpyCYFMB/1zS7sPl9WTUUnXn9QcSaGnk7G6TAqWm/KHwq9Yo8DYBPsZvSFAYyXv5pPTH8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a81:994c:0:b0:5ff:dac0:6524 with SMTP id
 q73-20020a81994c000000b005ffdac06524mr2160038ywg.3.1706917283080; Fri, 02 Feb
 2024 15:41:23 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:55 -0800
In-Reply-To: <20240202234057.2085863-1-irogers@google.com>
Message-Id: <20240202234057.2085863-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 6/8] perf arm64 header: Remove unnecessary CPU map get and put
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

In both cases the CPU map is known owned by either the caller or a
PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/header.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 97037499152e..a9de0b5187dd 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -25,8 +25,6 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 	if (!sysfs || sz < MIDR_SIZE)
 		return EINVAL;
 
-	cpus = perf_cpu_map__get(cpus);
-
 	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
 		char path[PATH_MAX];
 		FILE *file;
@@ -51,7 +49,6 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 		break;
 	}
 
-	perf_cpu_map__put(cpus);
 	return ret;
 }
 
-- 
2.43.0.594.gd9cf4e227d-goog


