Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A1C65CD44
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 07:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjADGoX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 01:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjADGoI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 01:44:08 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2392D1157;
        Tue,  3 Jan 2023 22:44:08 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id v3so21612939pgh.4;
        Tue, 03 Jan 2023 22:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp5Hj1uOMunUvWIMLUWPDJI/aB8Townrf00dqDCpqV0=;
        b=LkFL3IY5NRqL+oGa6Y7xnMopkhn4Ww6YfUfKJd8GzoypjwuYO2qNLNOOUS2sVoEtsV
         xxm96hfdketMDudUKLcqBH2Ufj3pLbhEjIkTA//n8RILprvvg8r1zrgPtYGnMk9//JLk
         XJzzcpoWg55qyInfWCpkWUB7ExANRRbI/0k/BFtT4mvBYnMCJeiV8P2KC0HOcUO88Q9u
         Ok1rrQXTqejGtiGFpFX6BEPVNnc2WHUU2OHhnwMOPELKTUhQzyDFMog8J6W+WWtpdzBZ
         8rxrRsLnYfS+lbARtTAvzd7ai4wwk4/80okYyF8WiPfzNADuIgFwIxhpLd4cO1/kcJrn
         uFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xp5Hj1uOMunUvWIMLUWPDJI/aB8Townrf00dqDCpqV0=;
        b=tMQCkbFwWVB62nIvaA1KElf8vm1z/LAQ88xrsPKS3YJtnujy6H3qHwK6OXNfPgRuCQ
         Tl6ITTiYy3bY0mCR20NUP5GRGUYIh/JWq3Xj9oOeaxHr2BfCWTJcCKeIeGDkMLMsXjRk
         cF2NOOFx2F3l0HuEIehQ0qkNYdB4HJVTDY4fkYa3OBHnlHW4I0tGI/jfBnAOGA09xCEO
         RCNEj69lqIM4YKtCKeeltBLO8BmeihPjUt+KR7fYy3+MHo6bdICuZq6BxeSBZBiasrh+
         vWMrykGHi3TVoQ2AvTiwDzinhA4IPX5LBNEwqrdStKMxxqrbv4oIHKzC7ftDzQJ+Us7P
         posA==
X-Gm-Message-State: AFqh2ko6jLEROWqa4l6VQzy0zEn5aIePlrcmOVq/ax39apJdX1W8AZHe
        P9ZBpEY/yrdbJHee7dECHco=
X-Google-Smtp-Source: AMrXdXuMSYqs+mlsHE72dr8FOqodIU8hNiVbIAv6Hd+MlQVf5sQ85f1sy6KZ2P9j3pxPnyN+D2E4ZA==
X-Received: by 2002:a05:6a00:1a45:b0:582:294d:f465 with SMTP id h5-20020a056a001a4500b00582294df465mr15550932pfv.13.1672814647626;
        Tue, 03 Jan 2023 22:44:07 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:d1f4:a47f:3a41:e1a2])
        by smtp.gmail.com with ESMTPSA id e28-20020a056a0000dc00b00576f7bd92cdsm11829257pfj.14.2023.01.03.22.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:44:07 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 1/4] perf bpf_counter: Add more error messages for bperf
Date:   Tue,  3 Jan 2023 22:43:59 -0800
Message-Id: <20230104064402.1551516-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230104064402.1551516-1-namhyung@kernel.org>
References: <20230104064402.1551516-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I found perf stat silently exits when it failed in bperf__load().
Let's add some error messages to notify users.

  $ sudo ./perf stat -a --bpf-counters -ddd sleep 1
  bpf_map_update_elem failed: err=-7

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_counter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index eeee899fcf34..7f5cc1aa4903 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -471,8 +471,10 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 
 	if (!all_cpu_map) {
 		all_cpu_map = perf_cpu_map__new(NULL);
-		if (!all_cpu_map)
+		if (!all_cpu_map) {
+			pr_err("failed to create all cpu map\n");
 			return -1;
+		}
 	}
 
 	evsel->bperf_leader_prog_fd = -1;
@@ -493,13 +495,16 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 	err = bpf_map_lookup_elem(attr_map_fd, &evsel->core.attr, &entry);
 	if (err) {
 		err = bpf_map_update_elem(attr_map_fd, &evsel->core.attr, &entry, BPF_ANY);
-		if (err)
+		if (err) {
+			pr_err("updating perf_event_attr map failed: err=%d\n", err);
 			goto out;
+		}
 	}
 
 	evsel->bperf_leader_link_fd = bpf_link_get_fd_by_id(entry.link_id);
 	if (evsel->bperf_leader_link_fd < 0 &&
 	    bperf_reload_leader_program(evsel, attr_map_fd, &entry)) {
+		pr_err("reload leader program failed\n");
 		err = -1;
 		goto out;
 	}
-- 
2.39.0.314.g84b9a713c41-goog

