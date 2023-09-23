Return-Path: <bpf+bounces-10674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E31207ABDEA
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9455F282D21
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E920EC;
	Sat, 23 Sep 2023 05:36:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF181B
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:36:09 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6E5E43
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c07ca1b44so52168407b3.3
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447359; x=1696052159; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCtwtK8xajC9XBojO6y6JASy5d+HVvOMNbjwUuJaLFE=;
        b=LuMU0brGoqbkQFRHLWzbeHkOnf3oP4GDDOl+7qXPmfKYVrlk40SXTvAm2tiyWpwMG6
         ucDNznBjD1+YC1tl0gUOp45nZ5ieMYQzr67TOZj5LsTc2ujuHnBQyEQQCPFJ4WekV3Pq
         JHImKHd4XVENfqcjl7a3EphJxFIv6idTtxzaPVxj1+D6Qn39ca5xLuIq+CaWfcDcLqFw
         F2d85dTEZ/0dM8E4R6Ue8ro02UZX/Wj873r8uEo7mf+DKMvy0rKjheX2hNgRBE8tj8Lm
         mJGkoXIepZDXXvgYxjOqWvDCOoU3lWiv7WIc7LUc/SVYBW+WKs1R2AxVSI2ZArEY4zoE
         xVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447359; x=1696052159;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCtwtK8xajC9XBojO6y6JASy5d+HVvOMNbjwUuJaLFE=;
        b=wdSTjUNjI5AP1Wi7hT8PtEcoHbcdobPnPisVeg711gMThSbF4qDZ1Y1+h5GRGtP6MC
         gMHFRuIA2QZ0siJBiFY5d6bg8DUbAQQL9RITyyAZ1VOZSjNWN8+638zDtkI+4NMpktx8
         o4NSmd4zMpwiMhNhTMgNsio15Cm6vMWAL22iIqFyx/93ARrkKtz9pTjyHRUZtiTmeSQV
         /unVkAkienoH0IzMXs6EICumFXrj8yhlbdyo5jYVjCnCPxuE65Bna+U48IXkjfwr617V
         4f5UAcEvunGjndoNd2epTL9shb1dWl+yIfQlF92myzUuGQ4y7a+Y6c5nWdwadW6sVFNv
         o1cA==
X-Gm-Message-State: AOJu0Yzi2467YBjww6B4F+AG+R/wlftjVq+X2kvY9T5LpbTXQIMtDpFx
	e5OenSE5aC3xRYSbjV5aUQnZEg8uEt96
X-Google-Smtp-Source: AGHT+IFb+mlhJVRkd55x1iEq/qHM5aF05s6yk09PvbU0fJIXBSHtgAy824hVDau+Ns2A4L4kX9JpuxpfL/T9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a25:d251:0:b0:d62:7f3f:621d with SMTP id
 j78-20020a25d251000000b00d627f3f621dmr13487ybg.11.1695447359056; Fri, 22 Sep
 2023 22:35:59 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:07 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 10/18] perf dlfilter: Be defensive against potential NULL dereference
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the unlikely case of having a symbol without a mapping, avoid a
NULL dereference that clang-tidy warns about.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dlfilter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 1dbf27822ee2..5e54832137a9 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -52,8 +52,10 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 		d_al->sym_end = sym->end;
 		if (al->addr < sym->end)
 			d_al->symoff = al->addr - sym->start;
-		else
+		else if (al->map)
 			d_al->symoff = al->addr - map__start(al->map) - sym->start;
+		else
+			d_al->symoff = 0;
 		d_al->sym_binding = sym->binding;
 	} else {
 		d_al->sym = NULL;
-- 
2.42.0.515.g380fc7ccd1-goog


