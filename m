Return-Path: <bpf+bounces-3587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CCE7402E7
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13FE281124
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2741ACBE;
	Tue, 27 Jun 2023 18:10:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D89F19BB9
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 18:10:55 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24C42976
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56ff81be091so67558987b3.0
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889453; x=1690481453;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7W0MHDI7A/36EtneRiQenQbjO4j0vMg3AtMW+Ct7r1E=;
        b=ic/uUxLDADiZsinLV836FUMBjwA4clCXnO3zJoz5EXIbi1vzujUI7YnlBalxEbY6Jr
         oqhuE44GRUbA4YFRItPjtnPNSZuGMpJY9cWyu337SnIqlkVYBY5tkzuNXyemUTtSYVHt
         cNI7pK1ELHaNon/Rt/uVBWz7LE0T5sn3ehHrsxsszZdh281296bZCIqTty4DYVCxyiCC
         uNP6M/icy39rmPwQ6ZT3VPDbg6zPgPf2Mb48GH+v+ZQBFpzujICXAoMqvkgqEy7yfEXc
         o+tAAOK4eg4U6a5bS/MlqRtXVyGY08LppDGk/vKjm904GInymr/HLFPu4RcwYJYP8A36
         9bSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889453; x=1690481453;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W0MHDI7A/36EtneRiQenQbjO4j0vMg3AtMW+Ct7r1E=;
        b=dF1vrOMez0tfcTanLfhqZoJ/nbG6aEe2vVWAH2mjavFfAjb4DNpqrlS+fDer6BbhjT
         9+wUKT8OIACTwDA4YFQabe7Rjy77M6hOs8q8yksiqJ8OSL/xFu5NLf8mZf6tsJbmqBu6
         tPMttQg7dKEsozQmDsDhC89g/J3Jgix9RrHw/10U6Jmaa5oDWSLvwysVjynPku/GFgLt
         zXZZSrIO2Jk9VO98LOcAy6PyMvnAx5f0MU+d4g0y/Q47Wb5fhbb983XLw3I9KHvczODE
         XQhw63EK/2qUzt50JuiBOIz07LvbxMNNt7Rz0O6qdCL4+rchpsw9v0iPxGT/mQZblbc8
         hnhg==
X-Gm-Message-State: AC+VfDw9uRRBK+uQLLLa8k8Ll/R+hnLrpTtD+/8BTJO/i3LoV0A6jU2x
	/VNg6wI/Xfc5L3cFOtn5J10nsdq9m+kI
X-Google-Smtp-Source: ACHHUZ7WMEj53/YOTC5fQeFqG+pKB8WUM8Wqp5CfW3X6NRJuJ5eUfxUuqqXvmD68sSI7ABQ2xhJFPv4Y3STK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a81:441b:0:b0:576:b244:5a4e with SMTP id
 r27-20020a81441b000000b00576b2445a4emr3880646ywa.10.1687889453097; Tue, 27
 Jun 2023 11:10:53 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:10:22 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 05/13] perf parse-events: Avoid regrouped warning for wild
 card events
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

There is logic to avoid printing the regrouping warning for wild card
PMUs, this logic also needs to apply for wild card events.

Before:
```
$ perf stat -e '{data_read,data_write}' -a sleep 1
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'system wide':

          2,979.16 MiB  data_read
            410.26 MiB  data_write

       1.001541923 seconds time elapsed
```
After:
```
$ perf stat -e '{data_read,data_write}' -a sleep 1

 Performance counter stats for 'system wide':

          2,975.94 MiB  data_read
            432.05 MiB  data_write

       1.001119499 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5dcfbf316bf6..0aa4308edb6c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1722,6 +1722,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 							  auto_merge_stats)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
+					parse_state->wild_card_pmus = true;
 					ok++;
 				}
 				parse_events_terms__delete(orig_head);
-- 
2.41.0.162.gfafddb0af9-goog


