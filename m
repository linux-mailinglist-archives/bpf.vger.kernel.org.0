Return-Path: <bpf+bounces-11757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684847BE9D5
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F3B282128
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C7718E24;
	Mon,  9 Oct 2023 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRdA35YG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBAD347D0
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:39:55 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5042C18E
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:39:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7a6fd18abso9982307b3.1
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876789; x=1697481589; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Btc8+OmE4IzA7UOP/eGTa4MmLZMG3XazqMQBeE66ZYs=;
        b=SRdA35YGOoLAZL9O7PKWBNf2JQLBzTaG1UsHWDN0YNJOyeWnXFklTqJ8LfGovInDPq
         S1OCCbjXHolGeHnjnsHfSXHjwWsWYKFaev8MFgJoOMqVdc7w5Eeoxrxg7RYFhnvHkjSk
         4h2Qdn4hFlf38ZRwAxN6WIoUBZvxHGlnUMkD5TiJpTAbjDJinzlN+vp51u0Q8nom8aSy
         eGDGjaOQxExOs8pJrvIqbKaSc5GTt+PZtW9QWv3xdfAfsQywBsmHezeLcnZhmn8s8mSu
         CZyIYAWyiaGBDXGW+rjm+XBx5D6Vbf/Z5kCyVWWrjpYzQa0ZfhQQJmls6rbALsQGqB+x
         SaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876789; x=1697481589;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Btc8+OmE4IzA7UOP/eGTa4MmLZMG3XazqMQBeE66ZYs=;
        b=l4Vy2EhueSZ8r+kF/povhDgGL1Ejm5Y9tUID9KkAtI1QBvx8atSzH4cSf1hwsCKZVx
         /e4ezOoEAgikMJ0XHVWLQvpbYYATPdZGETrmCG10ULx3aLnjl1NaHiqYdoTA0y7J0G1e
         uIIU/OxV/hrvHV/p/QDAAmdu1hXHeu6tHuQuKcglZCW6CMdd22Ah4XjAFgWLzqMDzFvS
         4FFds0RrqqY0/5P4Vlqy8h6243QQe+5Ani5espFUcVga0Bg2Urg0907RyOV722c6p9x7
         Jr4HHI2efhCc+cWTsm41lL95g+06uPi4UcSWzfAqhacYvupiFSKgFdg5zQ6BvdXOFSbH
         79Nw==
X-Gm-Message-State: AOJu0YyRiRxZCMzMyaqE8D3PkbTmhpwLy0HBBjcC5BboMmNKZpz/vadC
	iizf1/HB1ssBNrFutQCpqb+h3TOQ82Qz
X-Google-Smtp-Source: AGHT+IEx3Hxc/LpzCERzTEobvjg4svKw6js0XFbWqMEIgj61DG4507hSvRf9frx3x/Ew/SETU4UYqOBaGS51
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a05:690c:70b:b0:565:9bee:22e0 with SMTP id
 bs11-20020a05690c070b00b005659bee22e0mr297980ywb.0.1696876789191; Mon, 09 Oct
 2023 11:39:49 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:11 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 09/18] perf dlfilter: Be defensive against potential NULL dereference
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
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
2.42.0.609.gbb76f46606-goog


