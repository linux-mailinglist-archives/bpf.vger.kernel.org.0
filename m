Return-Path: <bpf+bounces-3528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5041273F37C
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA31C20A6E
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31CA1C3D;
	Tue, 27 Jun 2023 04:35:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4581859
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:30 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CD31716
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-576d63dfc1dso13989057b3.3
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840529; x=1690432529;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7W0MHDI7A/36EtneRiQenQbjO4j0vMg3AtMW+Ct7r1E=;
        b=GGhHei1HXQ2/eDuwm+x2TRZUoV9KBsZ+Y1XPf//HboZJ0pXVaXRqoxpqXkT4G2FLd4
         LaNiwn4Da8qGrPbQJ1SsadtrnJPqutB3BWihU34E3qtpBswwOq72yejdwQwXoWzMtPwt
         +y5uRhYhPOw4jHxwVvqqQuUT639J2WhZpb91636YlufXm9IF8Nl6uRQgVEhtSqBLlPRE
         dwCL25Cikuvdfs4zaLso7TKsY/bxhm/5gWCtqE7vN1Zzz/R07iXPDz8OV6DBJ++Y7LVz
         XXs2BcP9ujeoVCc34lFY+GmgRn8oIAVxueOaIiXXCf768u2txj0KvJkegEH5ngzuzd91
         yj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840529; x=1690432529;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W0MHDI7A/36EtneRiQenQbjO4j0vMg3AtMW+Ct7r1E=;
        b=J3ge3kHr0WEAW4xbD9M0Qvzzk0j4Exmf8krg1vKB64mfO3+Gp7CQfZqrREMKGekqp/
         QPtAmIIBCN6x2pjb6ZKD0ISrw0ITm8RTw4Lpcn4cvMY3DkPSlP6OpV0ASjpcgLGvWgOH
         DHryMo9sslIUMjh9ycW5GFcB6etBQOFXVocH1rbRp4Vb1pjf/EOf9r8p8I4u+1JkO7nH
         plMiwSwXkFpCOBGpw2VSOex5gBq4CKGeQOD5imCMsFvlRawI9P5qJe/AEzl+i44v8IgI
         xCfJva9aFyFtP5sa9KR12Z2fVCPxBzVdOnRkFpZSCfaxG07Emv8UZZFul/l75rzqyKBO
         EGFA==
X-Gm-Message-State: AC+VfDyQDdwmuvQB4xS2dLS1Xlmnm00z+y2OQqRgOEJjX/yrWXzmBN1+
	TsPlTvbhe570NQ79Ss0c2lxmr/Kq32Ov
X-Google-Smtp-Source: ACHHUZ6vOZIoR5CLG0J9dOgf3ZrdWfNkMBb9GwaJMfM09LU8pQxeBDqYATdE7/ljR1d1snX1nwvtdZ7/2vqK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a25:ca0b:0:b0:bcd:5dd5:848b with SMTP id
 a11-20020a25ca0b000000b00bcd5dd5848bmr6656602ybg.3.1687840529090; Mon, 26 Jun
 2023 21:35:29 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:50 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 05/13] perf parse-events: Avoid regrouped warning for wild
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
	autolearn=ham autolearn_force=no version=3.4.6
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


