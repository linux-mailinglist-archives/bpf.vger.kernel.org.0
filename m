Return-Path: <bpf+bounces-10675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1847ABDEB
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B3AA61C2096B
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7FB7F9;
	Sat, 23 Sep 2023 05:36:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D581B
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:36:15 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BF10C1
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85fc6261ffso3681044276.1
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447361; x=1696052161; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KS6/0u50No3rQJjH5fZIjyCOWL67f6naMZwh43hSjoQ=;
        b=1cvJSG2D4zjG+nEiyFOhhr9uXalDS6UQkYMUKbK51HR7DxnH983zpiM3pheR+NTgj0
         3G77+KayBqt4kYsFEFxxzaXtFpJGhwwsmbfSJwnycGRFRJVPZokpYTjGCsTBJKh7zfyW
         e7u+G9O1RvKddrcNbO4nFc3LhEwSQpwKrYFWnU0ujSh9GQbLyRGqgHtneDdtpRestn5W
         k6Lpq2h1BM+2OucES/2Szki9Vq/cquG3SsnM6QUhsvH5IUL/v7iFbuPhVrEkuPrmsi9a
         CuqvZd9O2s2ZutPu4VWdWCSP8BIKML4jlg/S337z6YOWtvNlXAl15EVONKGfRyCgIj+v
         l0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447361; x=1696052161;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KS6/0u50No3rQJjH5fZIjyCOWL67f6naMZwh43hSjoQ=;
        b=f6EMmjq2KYRTzQuxAsckZniyoUjgjz8w1AjX/ub2LFywSt8kxsMs8Dln/Bg0JdhYdL
         amtOtQJq4SQ1mlLDvo56rZ9o82dG4hDJR6qmp5WQDQfngUA6IYA5f76LFfAVJA3kKWBf
         UsPuRIZRCK9QOV+306lGPEHeotsLCCeh3Lxq46LFjKenz18tb2+Sn+/TXeDegXcrAH62
         o1k6xub1IG2Cmi6YtL2pYaw5TazSZKrphcykBQScaLQTycxjQd+pzr2b6L3Zf6jsxpSe
         4Y2Y0au14af/AejWyGrQg3Nij/aQ5/EVwQq318EOiTPrXar6c9ez/BMecNoXXGNaJJZe
         Q9wQ==
X-Gm-Message-State: AOJu0Yx9g1mloGISTgeBG+uIgdmAw7t+UaQxUOHGOGZ3sj4MggLJkV9M
	4DwddMnBd6qvI8bDGs8AIZLM+vEab5yY
X-Google-Smtp-Source: AGHT+IECwTxHbmPoI1K04GORCbxem+8maRhSeJmf/Mja5259t/O6+9DbPUULMmgIJZReDHjnxiFQ+xTHxGuS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a05:6902:1105:b0:d81:6637:b5b2 with SMTP
 id o5-20020a056902110500b00d816637b5b2mr14388ybu.0.1695447361524; Fri, 22 Sep
 2023 22:36:01 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:08 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 11/18] perf hists browser: Reorder variables to reduce padding
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
2.42.0.515.g380fc7ccd1-goog


