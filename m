Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D3252C690
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 00:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiERWrk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 18:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiERWre (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 18:47:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C616D4A5;
        Wed, 18 May 2022 15:47:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so7060470pjb.0;
        Wed, 18 May 2022 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5k+UAQBgaQSFvof05RgSIz5e6L+wrYZgJDsxYwQlz4Q=;
        b=hVxIHikvxUPAAmOD/wRvVA384X/YFMiIJbmleOFQvgg+XaXFD+Gc7ZBYbp9TsRSxtD
         mICvQ4a/8++UAcjAXI6j0qRZdX+Sty4ojBibKQtrqtj1lEQInKAMtgEcdrb07DPdmyFL
         c/pSl464X0I1gVYmLgYSVlHHUqbKhkTnd3ykN0WE6zG0rGattoiZP2h86CElaAZ6pY3n
         zrsNjJvN4Ju7YlguLgqe+nBMIiOQ+YDuYfCPnnnTXjob8C/qYOapoEZav8z68nbhQkK9
         EfvS1zGAAVJxAFYO7mPLEY/qtaSFadVVsxufAA/BZK/B+4tjG0pHxBJHhWppPgcgpNZ0
         lfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5k+UAQBgaQSFvof05RgSIz5e6L+wrYZgJDsxYwQlz4Q=;
        b=W5T5mfGJtE063d+Pn9pZz7eMi2x24OKOU19Phu9yulc5ZMKUmGY1EIE5GzkuHxoq/V
         efSchN2bDsxeoeb8YT3xJAq+Qwh3r02Fz8GeTTueLibHr/lQjJpZWil/vX22diCCRtXU
         a45+9uwskj+GBO4ar7mrAlJygGo2KieO+eKuRzEkKrlmfFNlU8pBmHA5NhzrpKJ9Qxdf
         YfSqpWX0NwaVfRLPACyh9GVcwaD7tahj8F+jtjor2Bc7cgDzEnpYTaw0ukLyUU8s0kmX
         YZ6sLgXHamZ3OMNyhSUuHghdIEXw7Pd/YnST4tSZZs9lV1HTRTPHkyLxXKbsGSR+E9SD
         J98w==
X-Gm-Message-State: AOAM533VJdg/dLPTXA4BykwFgelJcnmxt2/6doIxdlmv7n6o3tQ4Yfma
        /yId/hGoOR8mim/A5cSzb+k=
X-Google-Smtp-Source: ABdhPJzbYzjCT1gW3ilXdnX3/GctK0XISfQyTjracq66aaKXBPShW0zidNoWF2zkjNY+/uV2XEolKw==
X-Received: by 2002:a17:90b:17c1:b0:1dc:a6e6:ef26 with SMTP id me1-20020a17090b17c100b001dca6e6ef26mr2406476pjb.22.1652914048988;
        Wed, 18 May 2022 15:47:28 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:a718:cbfe:31cb:3a04])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902aa9700b0015e8d4eb2besm2214100plr.264.2022.05.18.15.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:47:28 -0700 (PDT)
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
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 1/6] perf report: Do not extend sample type of bpf-output event
Date:   Wed, 18 May 2022 15:47:20 -0700
Message-Id: <20220518224725.742882-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220518224725.742882-1-namhyung@kernel.org>
References: <20220518224725.742882-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
index 1cf967d689aa..d3c8ebdc6d43 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -296,8 +296,8 @@ struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
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
2.36.1.124.g0e6072fb45-goog

