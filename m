Return-Path: <bpf+bounces-3526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CE773F373
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835AE280FD7
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE94F1386;
	Tue, 27 Jun 2023 04:35:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2710EF
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:26 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2211726
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c17812e30b4so3269110276.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840524; x=1690432524;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3xFrkPN2+sT/sY0g+uTpgnQ+XoDit6j6d+F4zxTHTs=;
        b=4d3w3RvalUiNW3Mlb4z7HeI5eBjdXXDanREtvLdEKO0zQi97uPJqEAka6AkjE86nHr
         8XB9/kEFUBJi8AJsTHf+Le/uRRo4F8PlxgFfJ/QhHtx7RE1YA19aVI5CB6rteNYWMxzE
         6n6OGPHdPePP7cMhoRbGT+p3rmFQF+q1HJ/OOV86BQSDSr7Twmk6ZxkwKauuZj0TndZH
         TQKbHM17RL+GTOXnsmyZA/8cpIHv6l6wrAnczusUqxDxlMiVldoxXYrU57qaSOmxg6Fg
         /s+2yJNgYjpZZGOI1BVuzzUs54DDKCmy3GkSEGRjSZ290zx1wq0ulPCtK/hQ6mcu/Zh/
         VwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840524; x=1690432524;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3xFrkPN2+sT/sY0g+uTpgnQ+XoDit6j6d+F4zxTHTs=;
        b=PfsfQ4/A4/IZFJh7h2c0XF/OFG6+oB9Im21uYnBtl/bEhk2TWaKMGIORNxtnVpoCjS
         FLgVnYcNKhywlBRhDW6wTbBnzK8rNdyLtUD86R/uVwNo+MBNLsbq1NLg8tvCSiNB8UJ7
         x9FX2h5HiUyFKUA2NWtRveN7sY+vq/Pe0yGfu65PgCDMJQ1FdToqDvn8K7eZNNFuu1As
         oVaPPTQOIailiu5EndR/wamyVGRxQd0G/a13mddArBbFcq7iZfylRY66saLYbz4g11XF
         G0mY+OMgbPE7hmxgzmragZh25aqdZEcmbhhbzoLaAaH0lN/btDR0wp+1VddoKZow9Aix
         KPhQ==
X-Gm-Message-State: AC+VfDwHkl4NHCphKw82OWyLJrdx5cSO1G6pu+4TvrnakTp9l83kXtoL
	Jsjd8TDYuWPk2MHgAwfbKyUJrr02knwW
X-Google-Smtp-Source: ACHHUZ6g1UtttxcfnGpIgZXisAiPfloJoRAyLGmtDUzPqS7qoDZxsCECTY17v1QG6FMB/7F3Ug7qZRC3lipr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a05:6902:b13:b0:c17:4115:620a with SMTP id
 ch19-20020a0569020b1300b00c174115620amr2426866ybb.11.1687840524751; Mon, 26
 Jun 2023 21:35:24 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:48 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 03/13] perf parse-events: Remove two unused tokens
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The tokens PE_PREFIX_RAW and PE_PREFIX_GROUP are unused so remove them.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4ee6c6865655..b09a5fa92144 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -61,7 +61,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_BPF_OBJECT PE_BPF_SOURCE
 %token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
 %token PE_LEGACY_CACHE
-%token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
+%token PE_PREFIX_MEM
 %token PE_ERROR
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
-- 
2.41.0.162.gfafddb0af9-goog


