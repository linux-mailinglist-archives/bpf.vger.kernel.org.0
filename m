Return-Path: <bpf+bounces-6113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEF9766098
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173A21C2170A
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 00:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818BD10E6;
	Fri, 28 Jul 2023 00:13:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DFECA
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 00:13:00 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F293594
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:12:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704995f964so16841847b3.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690503176; x=1691107976;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6neUT/Z5ZxqZSvjTzsd3t4vT8zLu+ilqjGFbF/BwHo=;
        b=p3UY5OrtqjoAHr4YStHKi65rVDwgAEV7PTWNIAzOHMRRHlj/Q7SO5SS/iWoKuNGKNQ
         q3KH8pM5awvIVnWOT63BFHtZwwa9Eg1ijQC251g+h0PH1+pOncYTEvnlR8HJPVc1e9Zw
         zy2Bs+axgBATCD+3uHBG/x3UhoysgCIiCEISgdeClzUhp3C4K/PSNQXAIfZ/egs9XtIc
         LNUaKQbzbgSGfpDnqiWt7O2TA6OSyg3VFwMTP/o3zYgJ1HL654KUYJIiINd3H+rL9i+4
         quOk3i/9iHtGRcOE3yKsB9jhMKECdvcp+GKr49ZFChLE+XmKDMnN3oxeiRt5QV5mIeUn
         dLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503176; x=1691107976;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6neUT/Z5ZxqZSvjTzsd3t4vT8zLu+ilqjGFbF/BwHo=;
        b=In/UNQICv53OoZqMOn0CwHslb7gKxCNmX3ADV3JILX8z7qZu3Guiqh6YV4Cy335UBP
         sjEir3RtW1c23/0b5wnXESZmIicmuzbY1WWhMfOw3gymfxS+nhAwBwh8r0qnqrkWh6zX
         4Y5sFMymn6vijJ863kvFWTgxlpv4yAtp8r3UDPaPt+gFnqeSXOHMAzswmvuvOxc+B1Hz
         cJuOg6v3/FMQ222oS+aGQuK44tkMJGQSRWg3Zr8eutUUASCD+rqZcm5EYShXxHHXUFNO
         xVs2j2W3DEXXZ5qZPNPrXo6V6Wa2WbuY9FW10i1y+cKKxa7YZpabF6ouIgs1Inq6X9KT
         4J1A==
X-Gm-Message-State: ABy/qLZuxEfpkuLBSIlo4cG+fllf6Nzn+Sry9u6WdBvMklWlQEBelSBj
	15vnvm7ZqjZxd7PUQWFZgGGCocfl+JdR
X-Google-Smtp-Source: APBJJlEt4iXxJP8WryqVeJzhMdGPpRqxcb6Ce1vKD99ePr2ibeCxFflRmitKYAp0ZponEC0d5cc+brXqHo0W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a05:690c:72b:b0:57a:118a:f31 with SMTP id
 bt11-20020a05690c072b00b0057a118a0f31mr1109ywb.7.1690503176098; Thu, 27 Jul
 2023 17:12:56 -0700 (PDT)
Date: Thu, 27 Jul 2023 17:12:10 -0700
In-Reply-To: <20230728001212.457900-1-irogers@google.com>
Message-Id: <20230728001212.457900-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728001212.457900-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 1/3] perf parse-event: Avoid BPF test segv
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Wang Nan <wangnan0@huawei.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, 
	YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

loc is passed as NULL in tools/perf/tests/bpf.c do_test, meaning
errors trigger a segv when trying to access. Add the missing NULL
check.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 926d3ac97324..02647313c918 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -758,7 +758,7 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 
 	return 0;
 errout:
-	parse_events_error__handle(parse_state->error, param.loc->first_column,
+	parse_events_error__handle(parse_state->error, param.loc ? param.loc->first_column : 0,
 				strdup(errbuf), strdup("(add -v to see detail)"));
 	return err;
 }
-- 
2.41.0.487.g6d72f3e995-goog


