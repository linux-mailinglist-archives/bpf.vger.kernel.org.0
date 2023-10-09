Return-Path: <bpf+bounces-11759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095FC7BE9DA
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D9F28248B
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4A518E24;
	Mon,  9 Oct 2023 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXL+qmAY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3B1A701
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:40:01 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBEB113
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:39:54 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55afcc54d55so4380995a12.0
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876794; x=1697481594; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSqAvWdBbUtQxC7pnyJJtR4WVxr7hcg6OVnTaxh+F6M=;
        b=nXL+qmAYa1mUdOquFhy+XA/PWm93Ug1IW4cRgHg+EqS00GRLOom2nBJGffgxekuDXV
         wbrE1PmxDKYLYPPiT8kuXB2rEVLLXt/DZxHCItIPQ4PNJOTKSpTEDUswFBtWZma1i0BY
         7KYRrcsDRVikprlCDbpKoctnizhnSStoR7IoKOYjNZAjz6iKIN3z82prctEov4KWfVtO
         HADyYWdsJctr2SoudMqgxo9DL9CrlN97HTGEKFUfyuLjB5nCovyZ6PznLrZYcc61x+g0
         5L9e+C2vBdTcD44dUiDnoTG7dryyPmQ2gXGapHoSTv5mqU4L8r0GuakCTvSjh/h0conU
         4rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876794; x=1697481594;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSqAvWdBbUtQxC7pnyJJtR4WVxr7hcg6OVnTaxh+F6M=;
        b=pMzkECoBCaZnIN+cNwTeoqMxpSpOKcH+4n0wor0KVibPsr/ctIaTrCHqcfhBUd3mOG
         5rCAkRDeBbVUtfWqBkDfgc2GZph8/tmfZcIjNkkRu7QKQ3dhY3SmFQDnAGOJrdvXV29n
         qUoEQ/kqnZcUQIfREuNsU4AC1Rs67PfgwuoKoFeyl2xAGd8hZyoqIpaET78Bs+tXtxT1
         a19XkoHf00A0/KHIWC9Edg9KsJbrmnN1hPiveMI3fnk5pEHltMGfU8t2ahLruOw6wG3O
         g/8b0OavOY6erHtPOV0A+dUs2XvL/Ofsp9aQNvJFrCAHi+toKf0n8aRwY25trvIBV3EF
         lSTw==
X-Gm-Message-State: AOJu0YxnQRGnbt2zmuXnu6IGi66FTJ57m4YHXJN80ChT560B8nKjLHb+
	TNBUMbkbOgXJrpINtkmg1qtqVIdNvRHS
X-Google-Smtp-Source: AGHT+IGswY8IBRO4qisurfCsmW1G2owhcv59h934/6N9kUBhkSh8az8mizPfb84iHYV8EZ8p3euRKpw5IRrs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a17:90a:bc48:b0:277:d8:abd9 with SMTP id
 t8-20020a17090abc4800b0027700d8abd9mr318272pjv.0.1696876794049; Mon, 09 Oct
 2023 11:39:54 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:13 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 11/18] perf hists browser: Avoid potential NULL dereference
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

On other code paths browser->he_selection is NULL checked, add a
missing case reported by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f02ee605bbce..f4812b226818 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3302,7 +3302,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 							&options[nr_options],
 							&bi->to.ms,
 							bi->to.al_addr);
-		} else {
+		} else if (browser->he_selection) {
 			nr_options += add_annotate_opt(browser,
 						       &actions[nr_options],
 						       &options[nr_options],
-- 
2.42.0.609.gbb76f46606-goog


