Return-Path: <bpf+bounces-11762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A558C7BE9DE
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7A228209E
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4500537C8D;
	Mon,  9 Oct 2023 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06hv2eld"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B5358AF
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:40:15 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DCBD50
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:40:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a23fed55d7so77429967b3.2
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876801; x=1697481601; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGxcidzGPRegna1u1K7BT077Nrlph2dhlmMJs3FQauY=;
        b=06hv2eld/xw44RWn1xr2U+JITsXhvfwVgHKkxYlHPQ2wasN7Ofou0pUc3CoXr40ImG
         qNR2LlZ8MvLg6cNPhr9P2c7dmwXgQmo9Nnfc1/DUy85azjOubC+p31Q14GZ0G9/Vtg+Z
         oPc8KxwtQcwOMXO6VFfVwWcDpeHCbd/2jOTjXg4xDBWzuMNHHXT4X09J9e3vpQlqh5MV
         gawWuoboJtTEerxO9qEZqgXvGwMXiZG6mxTFVkgdreC+sNzfqDhtevV1bD3L+k2gV1D7
         hyx4Ztm9+4LmZC7Ccs/auboXubItxm4aE+XkD0rkoHIcBeuLWs6ngFRxTVMMtRxuSmPh
         cQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876801; x=1697481601;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGxcidzGPRegna1u1K7BT077Nrlph2dhlmMJs3FQauY=;
        b=QiwCofQhRAmHe06EDs4cujPnMHxeR02/uDOfzqvpdgfxdR+x4ggV74gxeAGZV4PlVD
         YcSGUnOY8xuH4qu3yLdkjyvNU3PEMmRbKtlZ+c+kNPoijj46gN8cX5wQu2h/xuqNVjCi
         LExZqBzuLmoQS2ehlHIQDaybYXjBqPPSn9DhJm8NiWk7drAN5lW04b2aRCTKwgF+XP2d
         eRVrcvuZANZD9yrj/lJq2B330ifxEKKVtlSc4LOrP+fbsd0lys7SwJ2A3fqXZMu3zo+V
         +M572sZm/JKaFe4UhBuNzpbtz6XmPYwuYylVot+OaFSEEnLQHE2TWM6lIRgaiZ+93fdT
         Y9AQ==
X-Gm-Message-State: AOJu0YxABX+IyzKGr5jDZt4xT309PEl2LuRTBJAOuFTqTfm8liSqqaJU
	Tgb9d6bJ2LTPu6RVRgqpOamMs3E6sPwo
X-Google-Smtp-Source: AGHT+IHv/D+bxgRzhvH5SJtdaUWM0vtK5Kcw+aA2tiW8Y4QaDfmm5vLlI9ULokvCKbvDQyU/3LpdJsz6h2n6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a81:a849:0:b0:577:619e:d3c9 with SMTP id
 f70-20020a81a849000000b00577619ed3c9mr336831ywh.10.1696876801567; Mon, 09 Oct
 2023 11:40:01 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:16 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 14/18] perf parse-events: Fix unlikely memory leak when
 cloning terms
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

Add missing free on an error path as detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c56e07bd7dd6..23c027cf20ae 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2549,8 +2549,10 @@ int parse_events_term__clone(struct parse_events_term **new,
 		return new_term(new, &temp, /*str=*/NULL, term->val.num);
 
 	str = strdup(term->val.str);
-	if (!str)
+	if (!str) {
+		zfree(&temp.config);
 		return -ENOMEM;
+	}
 	return new_term(new, &temp, str, /*num=*/0);
 }
 
-- 
2.42.0.609.gbb76f46606-goog


