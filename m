Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1741751E006
	for <lists+bpf@lfdr.de>; Fri,  6 May 2022 22:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442174AbiEFUUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442119AbiEFUUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 16:20:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445FB6623A;
        Fri,  6 May 2022 13:16:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c11so8456877plg.13;
        Fri, 06 May 2022 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVPHxCseNXWYBUFBOD07R/7B+vT2nTqbIkg8OWHEgxY=;
        b=k3BfgdGXLvlI836C2542lBsuso+gNHop0YfdQoGdBSyqb5lWr1eiymoZDYsH1028CB
         42dsRyerDehiuFukTV3jL0QWwhWQJ6ez0QrcxGjyB6oBhOikjRUBASLg5ol5S6/cNF9X
         lGNUyyDdN8ZYohNytOA9DLqHsInm0FvdhaR58uD45nqxyKWH2oknRHYIy6glYxRdY8ap
         Wp6EPbejaNZC4uEMArbZf8TNgu+/VNR9Uy5044CC9Ino5NjIIY9yXaXTrwGHIEfouEvn
         qYtYknRT3OX0U32QXS86wgQFnwwB1tmF1LDg7e0dB23GfUTPPAZrUomRNocb8eXAJcDD
         ZM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xVPHxCseNXWYBUFBOD07R/7B+vT2nTqbIkg8OWHEgxY=;
        b=5HwYAxIExevki8WNH54nCk5VvbmDtALBknHUD6HXFtlp28UihixX09JfdQze8xtgkM
         QbOJA2yQbsiEXpMZ3JN2zikWKMyDTQRZzUgBbX/ByopjBquINZD4zkcjElCacNiu5Mq3
         kssukMgOSBmQqLuGLL0GuPzxUK9fBiDl1naBjaIfEn3s0tV3F3WvLYxh5XWK3mNO2MT7
         qBiZDXyk8io+yeLCpe/0zMRlwCpp4Gmc19v4XxtwUfYoJEe8/SqlX8dz6YCQHTbr8s/j
         BmwL5AilXq3pW/5+4/6TIZBsWQN10T1wrU3Fz82MoXniY9p4+gTAjptI0+k0Xr2qmnBl
         OOHg==
X-Gm-Message-State: AOAM533X9fV0+Nxw/nLnbtAf7WBKU/qPLfCu0qoYIm1G1ZlDQO49bwBa
        i1IMODckSpqVfIYKeJbVQzo=
X-Google-Smtp-Source: ABdhPJzC+86nnQZIwXKlv4YSRSEYK5NJoTg55E8ZuuucCCfZ1l8HnbpmcFRPNaaq9BVwmf5rkbAzVQ==
X-Received: by 2002:a17:902:c7d3:b0:15e:b2f1:15f4 with SMTP id r19-20020a170902c7d300b0015eb2f115f4mr5448403pla.39.1651868191795;
        Fri, 06 May 2022 13:16:31 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:a5d1:d7b7:dd61:c87b])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db8200b0015e8d4eb268sm2160156pld.178.2022.05.06.13.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:16:31 -0700 (PDT)
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
Subject: [PATCH 1/4] perf report: Do not extend sample type of bpf-output event
Date:   Fri,  6 May 2022 13:16:24 -0700
Message-Id: <20220506201627.85598-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220506201627.85598-1-namhyung@kernel.org>
References: <20220506201627.85598-1-namhyung@kernel.org>
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
index d38722560e80..63a8b832b822 100644
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
2.36.0.512.ge40c2bad7a-goog

