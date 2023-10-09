Return-Path: <bpf+bounces-11752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B49457BE9CC
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56271C20DA5
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24B818C20;
	Mon,  9 Oct 2023 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yJ7plmLe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1273358B0
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:39:41 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE21FD
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:39:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86766bba9fso6666542276.1
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876778; x=1697481578; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2XqQMJ0GkpZoKYBOeb+AHUkFWOwFAfTNDekNOfqFv8=;
        b=yJ7plmLe4lpsv+raN9xFF/rU7/DGO5wkyB71VErLaVEJqqPFzGWQmA4JONtB/J867G
         W60pawhGLCANJV9jhSoZt3DqwXzlvCm/0p7Clz84lfk0JOFiiAtkUKb3lV5G5WgQKPfX
         OWgp77Zs2c+ZO90MAfurYZUD+RINLwhHyAJ23aBWeacroCgeEC6I80dxnI3Pk+15o6XX
         rgyTB1WIqwDEneGrUOjs7qFxpVkA7oEHynZMTclaq4zZms7BXm3/Ef0rnQeVfA51sT5O
         dtOryD5Mh9C8II+5L8/3QFOP8+tVguAmgjp0l+lr9VoDJqeGqQ/lnjTUHLAWnX7naP4e
         X5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876778; x=1697481578;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2XqQMJ0GkpZoKYBOeb+AHUkFWOwFAfTNDekNOfqFv8=;
        b=uk7gUWC7hEUZ+AdT+5mUDkLPcVT02xK3BEFX6hbpO6tr8mL42HDHav2/++bdqgqagw
         mKBKNXW/1tRkv8c64XHFBLLLBzPC0t6ZvGe+yoRUnSBaD8ye8Ns65vJNpYNg1ZuDogME
         9M1SHMaoUo7W13nfZGutfLFSrWSIqcPcQn6AeNgSYflVX3qSFRK+OQD2SJhRIPRAj53x
         bTZJsscqEYNQwwOw5fxw69dpHFTSqdlToK1/NSgtGTB7ZZDq+zChsIw4nK2Nzy/7Ah74
         f+SRtcuC7i1XRXFWqcmQzkd/y87/WzcOo5THEaEkjcw8s+fmH5EuQ1/BmeTRkFph7vxQ
         cnug==
X-Gm-Message-State: AOJu0YwW7hE78FxEPzpyrdd9jsMOlyNLQsuN/ZTTrEPG19Os2VFphP8E
	1nVsb8p3tTmFop/VwRsNBfl2hIqyYJFJ
X-Google-Smtp-Source: AGHT+IFVQJ/rmIGeQNoKkkKpAugRtmgnX9tZ+jNylIGNTuhY5/8aroNIOiM/mRV+TG9ICzlWJvJ2+NMEzLcQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:bec9:0:b0:d9a:5349:4bdd with SMTP id
 k9-20020a25bec9000000b00d9a53494bddmr423ybm.8.1696876777869; Mon, 09 Oct 2023
 11:39:37 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:06 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 04/18] perf bench uprobe: Fix potential use of memory after free
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Found by clang-tidy:
```
bench/uprobe.c:98:3: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]
                bench_uprobe_bpf__destroy(skel);
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/uprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 914c0817fe8a..5c71fdc419dd 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -89,6 +89,7 @@ static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench)
 	return err;
 cleanup:
 	bench_uprobe_bpf__destroy(skel);
+	skel = NULL;
 	return err;
 }
 
-- 
2.42.0.609.gbb76f46606-goog


