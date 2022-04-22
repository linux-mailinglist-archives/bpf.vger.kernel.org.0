Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8FF50BB17
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441901AbiDVPIK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 11:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449152AbiDVPIH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 11:08:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE28353E34;
        Fri, 22 Apr 2022 08:05:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j8so11419399pll.11;
        Fri, 22 Apr 2022 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqQRIgQO3ULhYUlV88GiQPjDyhm28U+v+Mde/WfWJ9Y=;
        b=BqbK74JSPzP6KIbaGsdg/rX1PeqFGdvvCjQ5fkfBU+YHhDjYPfJBJhsCX7I0OFh63M
         ArwrL5Mi+L30o72sLuQ7RfkmQH9KN3b6vjL/f18JpteylDgh1FuiIUA2F/N4VKdPkE2E
         FPFxq5tDWcDws/LfQW95RocuWVdwEGxpmDiF9wpVMyxdgYJHbz4K8b+yPX18CUdztIoK
         PVlqwMLouGkd/UGk8oP3hlP2Un9pwt/N13lKjJK8Vv9b0UeHeeDbWmpzlbuX9IrO+82d
         0STeRRJ1Ad2zi9I7/ggBQudity8kNdl+TpdCFDXovCTgtPzOr52HwS3aqpwLl26cXEyr
         QfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wqQRIgQO3ULhYUlV88GiQPjDyhm28U+v+Mde/WfWJ9Y=;
        b=EescU5Ahyw1tonGs6SpbL/T/MPcc97+UpNeQVqnWshpcvJc9Ny04bynJJEt8EH8KHc
         q8sN4nXuwnTQeva2q/ydLQQIdlddiBowVbjHf9n7qEMgPlzmW1pnTr4fQZU+PjfxFjxc
         H1QRtoXxPinGB0fHsTfVKEV7ObwMCj8h9NYJ0H0F0dwGdjfODOIUsJQ+Ie7HZiMQQV2v
         tt5qCypqMA1ntaAAA1LcxKGE4ud6rQP7hBhPzoKh4NJgix+U4wQe4JSatJIswzujserz
         mNyySab18RVsvKfXxFnHMieG4EL9QLJ+qF5xLltAqqjtSZak5UxtxOkh2Vns3ApL7o8r
         0Acw==
X-Gm-Message-State: AOAM530/6Na8XOecxrfs32R07lD8bn7hUcycnr2LlF7MfXtybuH38reB
        bcdAiiEbUh+lIHcjIewZdjs=
X-Google-Smtp-Source: ABdhPJzaxFg5a+d65TzZeCdDPAtNnJmv058PJW0I2F7Abc2d7ge99y9zpTxEJGT+crpH8DSIqc42zw==
X-Received: by 2002:a17:902:d2c5:b0:158:f839:4d82 with SMTP id n5-20020a170902d2c500b00158f8394d82mr5037189plc.17.1650639911299;
        Fri, 22 Apr 2022 08:05:11 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:5deb:57fb:7322:f9d4])
        by smtp.gmail.com with ESMTPSA id s11-20020a6550cb000000b0039daee7ed0fsm2390279pgp.19.2022.04.22.08.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:05:10 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 1/4] perf report: Do not extend sample type of bpf-output event
Date:   Fri, 22 Apr 2022 08:05:04 -0700
Message-Id: <20220422150507.222488-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220422150507.222488-1-namhyung@kernel.org>
References: <20220422150507.222488-1-namhyung@kernel.org>
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

Currently evsel__new_idx() sets more sample_type bits when it finds a
BPF-output event.  But it should honor what's recorded in the perf
data file rather than blindly sets the bits.  Otherwise it could lead
to a parse error when it recorded with a modified sample_type.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2a1729e7aee4..5f947adc16cb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -269,8 +269,8 @@ struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
 		return NULL;
 	evsel__init(evsel, attr, idx);
 
-	if (evsel__is_bpf_output(evsel)) {
-		evsel->core.attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
+	if (evsel__is_bpf_output(evsel) && !attr->sample_type) {
+		evsel->core.attr.sample_type = (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
 					    PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
 		evsel->core.attr.sample_period = 1;
 	}
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

