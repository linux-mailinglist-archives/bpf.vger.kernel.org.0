Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2BE5B28A5
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 23:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIHVlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 17:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIHVlJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 17:41:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46738B5A4C;
        Thu,  8 Sep 2022 14:41:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t6-20020a17090a950600b0020063f8f964so4267019pjo.0;
        Thu, 08 Sep 2022 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=eGQY+H5WfxC+y557urS6FwwfOdBMAu7BMS1ieVjO4Iw=;
        b=D9gqSo+u4rtkE4LaC9xMiObjHRE7+M7KwYS/IULrCSngWrWOLBXmbdz0B86WaY8biw
         d1zCvVbup5nPOcneeXNavehLMLDJh1o9OGMax6tLOmtbXMAXV0fJZP6fI8EVn9p2tFar
         GJ5uJuiQD0jqw8HQAL95b5BQk9uFyKmq/PR+f8G6mG5vsQZmWSbqfSLSFZdmOaSE34w0
         1Stdgh1XhD2Hvk36W7jeP0d61a2nkz802LGkqG1MZHWXgcQgTMSsL054pxyWCpRJBHET
         04wkizfo8V/Pk5wS0L9SijaNujIYXJSxdi81b7f3mgvBojUoyAKYVlLqTLog5vLFPFw6
         ZBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=eGQY+H5WfxC+y557urS6FwwfOdBMAu7BMS1ieVjO4Iw=;
        b=dpim6einAgAef1suY8CZJaS5gxS8puQl6URmQfLpswHCGIFFBmf9R60wN2hMsCQ+At
         J9cgjr8C8+EEPswwHKxxIhN7BaAmJGMyFJ3Q0Zl40z5ri4xJ6Dddz5HOglwcSe2GJiIe
         To6FIuHSMzMgdbbMnRah7K7uG+bS9tiojEfaLelfGkY8fQtOh2fDufw8LTy0ZcjFpTWS
         viehzaH94RxNd7wOsV7oo9jSmHldU1u7XbpxrZDR+KBwhUABJgRmFmru0FhLgARd9ZpE
         bq/DpQd/7VvfmjHe4+P9HhNtIeyMlaSFuB602Jr0lRSpTbxJnaEhCQOvCs22Zv5BZC04
         FSOA==
X-Gm-Message-State: ACgBeo2e8WPMkCc/B8vN72Bjx8xOphAYQOXP09NSt/OvLh8VIcUdyK4i
        GoHkZB6DE24pevJcBmu/9y4=
X-Google-Smtp-Source: AA6agR7axbIBiSt0i7RCKzWxbQGsQIQu2g57+M1Rz8geiy9fntEr7K/FscLUAshqNh+IAofplRD/+A==
X-Received: by 2002:a17:903:248:b0:172:7520:db04 with SMTP id j8-20020a170903024800b001727520db04mr10897000plh.99.1662673267686;
        Thu, 08 Sep 2022 14:41:07 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b77b:e812:1879:ec2f])
        by smtp.gmail.com with ESMTPSA id d28-20020aa797bc000000b00540d75197e5sm90435pfq.47.2022.09.08.14.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:41:07 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 1/3] perf: Use sample_flags for callchain
Date:   Thu,  8 Sep 2022 14:41:02 -0700
Message-Id: <20220908214104.3851807-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
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

So that it can call perf_callchain() only if needed.  Historically it used
__PERF_SAMPLE_CALLCHAIN_EARLY but we can do that with sample_flags in the
struct perf_sample_data.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/amd/ibs.c  | 4 +++-
 arch/x86/events/intel/ds.c | 8 ++++++--
 kernel/events/core.c       | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c251bc44c088..dab094166693 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -798,8 +798,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	 * recorded as part of interrupt regs. Thus we need to use rip from
 	 * interrupt regs while unwinding call stack.
 	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
 		data.callchain = perf_callchain(event, iregs);
+		data.sample_flags |= PERF_SAMPLE_CALLCHAIN;
+	}
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a5275c235c2a..4ba6ab6d0d92 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1546,8 +1546,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		data->callchain = perf_callchain(event, iregs);
+		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+	}
 
 	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
@@ -1719,8 +1721,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		data->callchain = perf_callchain(event, iregs);
+		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+	}
 
 	*regs = *iregs;
 	/* The ip in basic is EventingIP */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 15d27b14c827..b8af9fdbf26f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7323,7 +7323,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
 
-		if (!(sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
+		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
 			data->callchain = perf_callchain(event, regs);
 
 		size += data->callchain->nr;
-- 
2.37.2.789.g6183377224-goog

