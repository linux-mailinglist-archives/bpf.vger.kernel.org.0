Return-Path: <bpf+bounces-11496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33077BAF11
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 73FF12828D6
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224B43A91;
	Thu,  5 Oct 2023 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cC8v9htN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A33D43A94
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:28 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF99A11A
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8040b2ffso22553697b3.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547363; x=1697152163; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a3F7gnNpkmZUAErgbCdtUAHzB9Tx2qchcvlKXuBK3uQ=;
        b=cC8v9htN85xK0I6vqU1MDGWwZO5vyo1LQVqQFGFr4Z+FZr1tmDW/e6Tb1cPWIx9YIJ
         O+noGGselEBgl6GbGJfwA3fmN6vBWbaomnl6Wgv1VUKsTToE0PpGC5bAdNscgO2oL5+T
         8NUOYpDwRtBf4O1SsfFoz9p9nvFKH8yMP1ygZUi0DQTVgyebgZi0EPr+ibCbTQmX4o6J
         ejZx6+0vJse+jGHM9C7eWv6gxqEfgKzMhOIU9z0zQ0hB05axy2yT6ebgw4pWq5W5vjgw
         phylQWFgbwAty2EPxnYocLPs2NLT7vaxi/VD82NlHQc7tAF90KqPss+aSZWp8OdmZAuI
         8GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547363; x=1697152163;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3F7gnNpkmZUAErgbCdtUAHzB9Tx2qchcvlKXuBK3uQ=;
        b=euSwE3CZWsRgyJQMl4zc3KG6V8wCy/W3jq1xMiYJ2vmXkDeuxk/fi1zsKH76qPRol5
         yRfvVO+Szigog9K/XA5pgFgRGH0kc29visS9/VJlHRLF25sTln1LpeRL0p/EgMcRJ7vV
         KKIgk5M7JAoY6X3guRzRYnrnlrb70xmDmyNpYXcm7Mxsqs/5e22At5j5lvZyexnnh6mw
         bGZ61G6zlmo6Li0TczeztlIruV/GbMUIw9MxwOaKz+SgL/6Q1kijyxNbCKX5BLfi/QnG
         yvs+C4vlNtl/TuTDczlRAqGooYpVwd4UgV8TQQ9FsEG1tr4T2BkxZ2fOXYELQWbLHl9P
         uE5g==
X-Gm-Message-State: AOJu0YzYXSAahr+Mf0c+d7A1dqIaVKdrsNBAmBACxxSbZaFsynXuWg2+
	v/4c4JSC+XMRbILaHbWV4NBAy9s0LZEC
X-Google-Smtp-Source: AGHT+IHoFU+z5aCBXXTlJuMvUJucciH7eGrZGAnChgvuI/WO2miJm/u/BOXK9wZuLbh4UH+ko6EzN43c6WUR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a05:690c:fc9:b0:5a4:f657:5362 with SMTP id
 dg9-20020a05690c0fc900b005a4f6575362mr116930ywb.3.1696547363151; Thu, 05 Oct
 2023 16:09:23 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:44 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 11/18] perf hists browser: Reorder variables to reduce padding
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
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Address clang-tidy warning:
```
tools/perf/ui/browsers/hists.c:2416:8: warning: Excessive padding in 'struct popup_action' (8 padding bytes, where 0 is optimal).
Optimal fields order:
time,
thread,
evsel,
fn,
ms,
socket,
rstype,
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 70db5a717905..f02ee605bbce 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2416,12 +2416,12 @@ static int switch_data_file(void)
 struct popup_action {
 	unsigned long		time;
 	struct thread 		*thread;
+	struct evsel	*evsel;
+	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 	struct map_symbol 	ms;
 	int			socket;
-	struct evsel	*evsel;
 	enum rstype		rstype;
 
-	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 };
 
 static int
-- 
2.42.0.609.gbb76f46606-goog


