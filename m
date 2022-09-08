Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E233F5B28A6
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 23:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiIHVlL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 17:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiIHVlL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 17:41:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6A3B5A4C;
        Thu,  8 Sep 2022 14:41:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t3so7448ply.2;
        Thu, 08 Sep 2022 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=Cx155zhJoQZQUWzdh9NR2U3rudlWDBVhPxOXZDiL5yo=;
        b=P6Ur1qmON20NVvaQhIIM7UPGsLK5uwXwzma+SSwrHm9T7V3vM4jke4HwN+CDS5z1ms
         QMJbC9+qrUsXFTmKOlI/mLBlxU600k1Z3/IzItURVo7LXSZEGxZIEmFCr/laWzskjBHy
         tTefqpKNd6HuV/BRty3GJm9lo5w1HXh2DQfzL+7K2kw9n3O1fTN9POCoYFq9dYta28Ws
         nXVDtwzlxgWlyiUpjhJKR9vp9hPYFbn+SvR7zsejFUpK18kkdHQH2VSS5r2CGP1w9XBg
         zio3faDX3vpeKaIRTvzkU5+5ST7sqz0sFyfeY07KEatl5h1mr8ALOhtx9qwMH+zoiJMx
         tBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=Cx155zhJoQZQUWzdh9NR2U3rudlWDBVhPxOXZDiL5yo=;
        b=AG9jHZLmX969qYRoU9ZA33DuvCXciYe81zfrAgN2wf3zb3YRnCCD5wUnxjIXLLQDyl
         BVkzoxYtJaVtrZTIAill09SL8IygiigmxlvvJ7IQX9pWBHHKfsy2cWIaWd7r7eHQ0wcH
         Bb/VU5UVVMQnPvsPW21FJ9qb8hZgrsiFUfsw+I9c2g54Ie3GkmYjUKhQERHWCpCd5K2e
         dj6t8Dg0O+cVcFQ9KSRHe/PbJTZELafGhJQ1g3COR+1AK+dLoDqOKYomwRxgLGmLufC3
         X6ftuTRjnkXcOWNOTgdudRoPvmnxFc5clLhpGBChT3U1PWOqxEXZYrMRNG9DySu5PnZM
         u3lA==
X-Gm-Message-State: ACgBeo2+uw1bMHlk3M5+bQvNJ/PjconS3ivivkyjq65L0VZPzbz28orU
        BS6KqPhq7lMUKCgopAe6urI=
X-Google-Smtp-Source: AA6agR6WZQ+hqd5KwvMnBidkwAHqjo8ySag1qtBzmRxLHrSJyP6pymQkVYR23fR70Zgbmv1kXzB/2Q==
X-Received: by 2002:a17:90a:908:b0:200:14d8:1ff9 with SMTP id n8-20020a17090a090800b0020014d81ff9mr6160652pjn.16.1662673269388;
        Thu, 08 Sep 2022 14:41:09 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b77b:e812:1879:ec2f])
        by smtp.gmail.com with ESMTPSA id d28-20020aa797bc000000b00540d75197e5sm90435pfq.47.2022.09.08.14.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:41:08 -0700 (PDT)
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
Subject: [PATCH 2/3] perf/bpf: Always use perf callchains if exist
Date:   Thu,  8 Sep 2022 14:41:03 -0700
Message-Id: <20220908214104.3851807-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220908214104.3851807-1-namhyung@kernel.org>
References: <20220908214104.3851807-1-namhyung@kernel.org>
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

If the perf_event has PERF_SAMPLE_CALLCHAIN, BPF can use it for stack trace.
The problematic cases like PEBS and IBS already handled in the PMU driver and
they filled the callchain info in the sample data.  For others, we can call
perf_callchain() before the BPF handler.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/bpf/stackmap.c |  4 ++--
 kernel/events/core.c  | 12 ++++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 1adbe67cdb95..aecea7451b61 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -338,7 +338,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	int ret;
 
 	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
-	if (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
 		return bpf_get_stackid((unsigned long)(ctx->regs),
 				       (unsigned long) map, flags, 0, 0);
 
@@ -506,7 +506,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	int err = -EINVAL;
 	__u64 nr_kernel;
 
-	if (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
 		return __bpf_get_stack(regs, NULL, NULL, buf, size, flags);
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b8af9fdbf26f..2ea93ce75ad4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10003,8 +10003,16 @@ static void bpf_overflow_handler(struct perf_event *event,
 		goto out;
 	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
-	if (prog)
+	if (prog) {
+		if (prog->call_get_stack &&
+		    (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+		    !(data->sample_flags & PERF_SAMPLE_CALLCHAIN)) {
+			data->callchain = perf_callchain(event, regs);
+			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+		}
+
 		ret = bpf_prog_run(prog, &ctx);
+	}
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
@@ -10030,7 +10038,7 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
 
 	if (event->attr.precise_ip &&
 	    prog->call_get_stack &&
-	    (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY) ||
+	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
 	     event->attr.exclude_callchain_kernel ||
 	     event->attr.exclude_callchain_user)) {
 		/*
-- 
2.37.2.789.g6183377224-goog

