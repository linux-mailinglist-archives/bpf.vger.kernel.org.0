Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F765E59A2
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 05:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIVDd5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 23:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIVDd4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 23:33:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AF995E7A;
        Wed, 21 Sep 2022 20:33:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l65so7978698pfl.8;
        Wed, 21 Sep 2022 20:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=fb5Xlzk+Ju1SSjol7ebKFWrqD/KR95atg9Z+zltES68=;
        b=FWHT97Sg6Dy/QqulnN460qDxTZvnIM2Tqgw4xN9SW0BbJYmikhbRwNPsGEFtC+iCtN
         rUb0lKFFPq/nQFccjjmJNBwKqKYy5MTT0nQEyx8ugqKoS2Fggxd6xc/I2HINFr8dZwpN
         h7Z7Qvy25gtV8fro6Vtv6FnMwAhMwkIifqyl3lp2G1KvDK3FzgeqyKb+R7wr2OTHXP4S
         Ml2jL7Wn1HJsYcts0Pi2PWrPqApGv+LNQsYKRo8CV3Mmk1NGcP5e/oFIyVkoEJ7QEmgM
         wF8pnK/LHM114Z/qy05Sub3zn4lOFhsE+gRsrKmTjZj3h0dE5OhIVuOnETF0pzKfGrfr
         JIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=fb5Xlzk+Ju1SSjol7ebKFWrqD/KR95atg9Z+zltES68=;
        b=jfi8v7JHLeNOnzSJMjDVT6WrJcKw3rAWUxh7XJGVZRrZP4w6kj5Fyfzuvz5xvbArXH
         P5B8k3V99TS9ngF6AdDG5toLuWvFfJtv1Dl79O/IZRXdqkEPzuv8jS71lEW13iCtHLll
         KZIJaEsg+Bk9R6bMfJLD5X8cpbqnr0BetGHFsi+1Elh5tU8jakGcCyuJjCNw78hQH7Db
         Ht5lCZdKqzDEl/309+xahYViwTUq9V6tPbeMz2zIoDnBwnoZLP2STq8t8WAlp2LJeqJ/
         itvKnEYS9+lAVSGj8rVltlRUAPw9nN1cTulCIdtqfBAjYdauhGjcvb+3arxxi4v9HhB1
         hdFQ==
X-Gm-Message-State: ACrzQf3bN0WxtUGooAkd5JaiNnvpcbMFE2IoDZD+5tQ9eyExfmOaqcQJ
        YWXoxzRckGD5FrFF6lPLfpE=
X-Google-Smtp-Source: AMsMyM7xrhld8DTOE+i3LYztj0v+OuBuycUDippMl4TJq48r7K6rfB0CGrH08aqTyVAzbDBMNNMOfA==
X-Received: by 2002:aa7:8c4e:0:b0:54e:fa98:5031 with SMTP id e14-20020aa78c4e000000b0054efa985031mr1443441pfd.44.1663817634806;
        Wed, 21 Sep 2022 20:33:54 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:8bcd:ba5c:3c6b:4140])
        by smtp.gmail.com with ESMTPSA id i1-20020aa796e1000000b0053ab9c18d3csm3104149pfq.14.2022.09.21.20.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 20:33:54 -0700 (PDT)
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
Subject: [PATCH] perf stat: Get a perf cgroup more portably in BPF
Date:   Wed, 21 Sep 2022 20:33:49 -0700
Message-Id: <20220922033349.2908447-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
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

The perf_event_cgrp_id can be different on other configurations.
To be more portable as CO-RE, it needs to get the cgroup subsys id
using the bpf_core_enum_value() helper.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index c72f8ad96f75..35a8e38d3ee3 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -57,8 +57,10 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
 	__u32 *elem;
 	int level;
 	int cnt;
+	int perf_id;
 
-	cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
+	perf_id = bpf_core_enum_value(enum cgroup_subsys_id, perf_event_cgrp_id);
+	cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_id], cgroup);
 	level = BPF_CORE_READ(cgrp, level);
 
 	for (cnt = 0; i < MAX_LEVELS; i++) {
-- 
2.37.3.968.ga6b4b080e4-goog

