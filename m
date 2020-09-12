Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F4267755
	for <lists+bpf@lfdr.de>; Sat, 12 Sep 2020 04:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgILC5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 22:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgILC5E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 22:57:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62FFC061799
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 19:57:03 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o28so2770808qkm.23
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 19:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tlUZFOaKJ5LE59ggiryY4frJEaxFxgx4ldifqmKiWLA=;
        b=vrRzme4mxyE5sgvckk7Y/j1HMCgj6vdjO3lKb7NEGoa6AnOs/PLWkSLu7VPdcd0/KZ
         3QZxraOTN2lzSzt+HhIZA6gErKzzixtBxjUjm2Vco6hRr/79FIcSJqX2+5oSy3n0c+0v
         EPhJobzAs9gBisTqfZJJ/UFyLYbHteWa9MAMqrUH2Zk+HZ8PAW3eHGJg8s5n7aBQbmH7
         nUFL+t1+QtqjJLljLczij2i3/h2yRXZ6VLVznZyk93lx6sjtdZNXxjbQIniBMX0jyLra
         MaOuAFrQnJ1HEm0HMi/2t38FI8N+PNApMcpE9xklBs8HLFsHl504rkuPt2AWr0kB9cHy
         C6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tlUZFOaKJ5LE59ggiryY4frJEaxFxgx4ldifqmKiWLA=;
        b=iltNdKRrCGWngTEZaEMkq/aALmaDhtJCSrTogxZOrz8uZoVCm8ZMznldnLDsRq2pFw
         bncDyWdkPCTiZx9GhWkYXuzzVrPOBisHEajakBUm9TRHSdLweRZKCsGAQoMfY8JCdlLF
         bMLy79Vd06F1Rkl3sg/tb7b0IbLng8dLczOA6otcQrr8tOW/kf3+Of1/LKJTvVUVOeLr
         0EHhwnjU3NnGm7TONZfHnRF220Jhk1+0rGsq4a3h49lN2L9/ujlFXzF4uvhPTyjYaC3/
         u2bhdajgCNoXckPTVJQo/08OeRZz0YXI30ssibQCANUj1hqV4DbHGQTsNO1EzVdec/UD
         Ay3g==
X-Gm-Message-State: AOAM530T1gj1duV2Pb5ZigklnzvTBUws4a9W9d1rG677RVJrAf3Lu52v
        eM7Jiawf4mh7waCrLLPwEGWbIU5h4xWp
X-Google-Smtp-Source: ABdhPJzwN2NTqtuyrq3jkjZseDDdYzyQAyQtx5se2QgH30k2etj5OZ0koctyixMjeqsFh7j6dPk+gP3+kzhd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:eeca:: with SMTP id
 h10mr4954039qvs.13.1599879420884; Fri, 11 Sep 2020 19:57:00 -0700 (PDT)
Date:   Fri, 11 Sep 2020 19:56:53 -0700
In-Reply-To: <20200912025655.1337192-1-irogers@google.com>
Message-Id: <20200912025655.1337192-3-irogers@google.com>
Mime-Version: 1.0
References: <20200912025655.1337192-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v3 2/4] perf record: Prevent override of attr->sample_period
 for libpfm4 events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Before:
$ perf record -c 10000 --pfm-events=cycles:period=77777

Would yield a cycles event with period=10000, instead of 77777.

This was due to an ordering issue between libpfm4 parsing
the event string and perf record initializing the event.

This patch fixes the problem by preventing override for
events with attr->sample_period != 0 by the time
perf_evsel__config() is invoked. This seems to have been the
intent of the author.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3e985016da7e..459b51e90063 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -976,8 +976,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 * We default some events to have a default interval. But keep
 	 * it a weak assumption overridable by the user.
 	 */
-	if (!attr->sample_period || (opts->user_freq != UINT_MAX ||
-				     opts->user_interval != ULLONG_MAX)) {
+	if (!attr->sample_period) {
 		if (opts->freq) {
 			attr->freq		= 1;
 			attr->sample_freq	= opts->freq;
-- 
2.28.0.618.gf4bc123cb7-goog

