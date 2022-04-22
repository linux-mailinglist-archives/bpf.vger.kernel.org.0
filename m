Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD750AF8F
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 07:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiDVFkE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 01:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444170AbiDVFg6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 01:36:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44D4F448;
        Thu, 21 Apr 2022 22:34:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h12so4830011plf.12;
        Thu, 21 Apr 2022 22:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqQRIgQO3ULhYUlV88GiQPjDyhm28U+v+Mde/WfWJ9Y=;
        b=qqEoI8eo8BjZkhFVwnf33n6mNuwkFG3qjyshIpZsVXo8tMiLniU0/PIaAOXuFvRYSz
         8/vazd6OKW5VyOzzIi9NrRELj5I2osHK54ZJLG8EMuHZo6Ewn2tJyVW4UTzMlJEDmhE9
         piEzbIny8mf4BoAhdE9EB0tS58Kqq1Q56wkjVyRtGOCOqgbl3fHB/QZQHeRxLXtMCoDz
         LcUNK1m2KgZo3TigsdmMQyfNI0KYZyYF9uoh8xZ6AQxUUazZcaNxGRBZ+gomGK5A+kP1
         KTkHwvio0yar95EvFY5gjd173eXGR3xBi/sX3JijPVk5De/E+vR07UzO4I7U0lVVvFXq
         SpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wqQRIgQO3ULhYUlV88GiQPjDyhm28U+v+Mde/WfWJ9Y=;
        b=btpDOr/pmtQLDDh+dNA2XdzzN85ipT3VLGzg7kIdODNZN7lUAlFiByu11DoZsNIjpl
         u/xn6VBq+S5wYZqLdY4tCuDBk8e6UM6sTbINC7FoFnh2JVGsXAUDbYVsd4hJyPmyjczP
         hexAwQxh4zFbtdp/u2xMlMJl/sTqirsLjmxTV7ZBCyv6b9lCtjnGgaSJQV6wLtkqQi0a
         VY+TbDxwQHcj8PBkfx6opBWI9k6vH+mjOuFDmHgNe1hsu3fUdaoqwJjPYPsHJpRPuW1p
         5jYUMzEkILcNxgT4QGrGdCPRFp06veqvIKMVsyIjhMr9cZct1VZ4hA6HcgCCCDCW5jBa
         6lTw==
X-Gm-Message-State: AOAM532WwB1w1vyfqqTXXLGkYxBqxmTi9PcC1hVduXY0u6EIoXCj3Cce
        4BHEPJJoG9kae4VBhv82Cq0=
X-Google-Smtp-Source: ABdhPJypVPj6HGfH5oNbElSsizeqDJta0gc+MwCQmem8TojkAPYSmM/tpM+1C/+vd0S0fnuRaM2Onw==
X-Received: by 2002:a17:902:aa06:b0:158:f13b:4859 with SMTP id be6-20020a170902aa0600b00158f13b4859mr2812716plb.141.1650605645099;
        Thu, 21 Apr 2022 22:34:05 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:32e3:a023:46c1:80cd])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm886519pgc.50.2022.04.21.22.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 22:34:04 -0700 (PDT)
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
Date:   Thu, 21 Apr 2022 22:33:58 -0700
Message-Id: <20220422053401.208207-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220422053401.208207-1-namhyung@kernel.org>
References: <20220422053401.208207-1-namhyung@kernel.org>
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

