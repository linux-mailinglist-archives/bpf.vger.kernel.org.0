Return-Path: <bpf+bounces-11758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C61097BE9D6
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96B51C20F65
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED73358B0;
	Mon,  9 Oct 2023 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXbm260r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DC1A701
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:39:58 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3579106
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:39:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a1eb48d346so84340897b3.3
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876791; x=1697481591; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a3F7gnNpkmZUAErgbCdtUAHzB9Tx2qchcvlKXuBK3uQ=;
        b=MXbm260rnEHiPY2SYzvEO0hTE+cAPwD+GczDzsavIBFpHbm2YQEyW2nX/ki7WncJ10
         iFEkSHmUcPRnLm2YslotbhED70wdwyqrIsq7GiH10NnheniS8sQGeVW3CIxWppTru+Gh
         4m+6+yOVx3XkfNRGnmzyrtu5GVEf9HI19fwaDzcmYLwaEbLw3EEVbSr729cHApib/TwH
         Enr8jpEBhxZkFxQSsaieQ7ZdOYa0Ni2X2LuDX3dPNTaIRbxzu3b2aAPsWqhH6djUx3VQ
         4+OFeOffjtGYRMCmJy+ZxB/ZMI0l5J5d5vureUVF+5XsiloLhO4Uji8FLnaNNDNdljcG
         Q9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876791; x=1697481591;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3F7gnNpkmZUAErgbCdtUAHzB9Tx2qchcvlKXuBK3uQ=;
        b=wFzpVyRUE50W2mhNJOzFYsZ9gtWMi/iEAYGeNMnloTRsUi2XHZpHOUAeSAHnAjxwfs
         AiMlWZxRcecRk7RevX/nMwE8DAUPyxRSpg3qTL/dtWtwE4BJWPMpWOlwl6x78tq8GR2J
         8Ffxet0C6t6Ayo+0D8vXzviuzIyR9eePvKDxGsg4uD8c+9BEKI1RmMDOjIiOH6600y58
         k+Ge5mUDMq8dpYX+vQUhKkyNgf54Rz4LDAWZkfudGCqrt4fZZotZtwTgN2yXiVzjVfBc
         Y00leVV5Dnr5HcteYZuypBbrmptL132YFiNnc8XAfLIPdDr21sF7vePoT+1lNoxrDHRf
         QvIw==
X-Gm-Message-State: AOJu0YxoeL2Vt5wQaiWZ0vCpwe8R7eNX2+Im5kYHtgKVdPrhCcNt5diG
	s03Qycvg3sYCI261Hz/Wk0cgofxhhNh2
X-Google-Smtp-Source: AGHT+IFJYyKzaVJZa6OL3+dH3Iw7A/PwN/dNbmHDZ9SeFI6LX4XiAP/rf39SS/umzU7lUH+6FV2vZLeRvyST
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:f816:0:b0:d84:e73f:6f8c with SMTP id
 u22-20020a25f816000000b00d84e73f6f8cmr234275ybd.6.1696876791493; Mon, 09 Oct
 2023 11:39:51 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:12 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 10/18] perf hists browser: Reorder variables to reduce padding
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
2.42.0.609.gbb76f46606-goog


