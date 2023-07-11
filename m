Return-Path: <bpf+bounces-4664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D8674E317
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C661C20C32
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD727E0;
	Tue, 11 Jul 2023 01:14:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B0649
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:14:22 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB96106;
	Mon, 10 Jul 2023 18:14:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666e6541c98so4532595b3a.2;
        Mon, 10 Jul 2023 18:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038060; x=1691630060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7RtjXGm5xnMyjnXGW7dcrgh+Rp6Arbs/DH0rZ13xLA=;
        b=puk7YD5tokJD/WwBJMyAnENOR2GuNEDs2Im3bzhG6AVe3dehz7uehq8IFEBEKFSnkV
         XICBzrIdPuVSQRaEQ44zNQZqkS7RpYNdxyzgRMK93fleBW1HOaHoq1bI5lrFYg3fWD1P
         +hOBU55iEPCtY/1uGT4UUDJ+JX02zmSMn3csVPmC2RJ5NTVKYsmMfFZH21hRtXah1XEZ
         STj0IdqeO+ewB7ta1nQWB1Vs0bT1c0kRH5Esmy9hkKPv3/Uanhc4VFAyMjzx3xIPZ+PU
         hnE0SQ0ua5uIK65Uaq3XiaRsF1M7e78dju8HD/e3GvUhNbI98wfKfrNyfWNmCVd4Jde1
         ipAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038060; x=1691630060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7RtjXGm5xnMyjnXGW7dcrgh+Rp6Arbs/DH0rZ13xLA=;
        b=VQOCFhI8DpFfr+HjW8xH4X3OrKAaR91mttRB3kq6UhEPfoPxtAZ4FizubcmFbuhB1w
         jTw3cvP6blqxRmn4R3mZL+KDTbKyfCUE0GQMEdSitZ5foCQ2hytprIjZ7VwlKKWausHt
         q2U695wr91DAphwU4UuSDEIqSn/lSVsmFBe2l798QzZ/9eJgg8+jrai6CN0fe34BcFeR
         8EEZh2cUdq/5kv8fAGKCXeiFlrWPi6h9AyZYJxQTWZkbbfQOAZuMzYrQNiltnVD3q8yJ
         bz6eKqv/Ab4boWqIBZB7grIY5J94iNRz10NO0N4e0tTJOHYTOKLfj1P68HzhvjezASBE
         ik2Q==
X-Gm-Message-State: ABy/qLYw6d/j0VZ1EiaGawMgQfGe7w+0Z4KiNdcM7sUM1RtRjeiHSmlM
	jwISHkbWBdOIWJ07eAydmHc=
X-Google-Smtp-Source: APBJJlEoCpgo3RdatM+CU/hPhUokQD6g4dyMnVohIYQ4+hO0QetgyFS2YJgVsEbDXFEtxov0NpcIUg==
X-Received: by 2002:a05:6a00:841:b0:668:9fb6:b311 with SMTP id q1-20020a056a00084100b006689fb6b311mr18929468pfk.32.1689038060208;
        Mon, 10 Jul 2023 18:14:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id z21-20020aa785d5000000b00653fe2d527esm412766pfn.32.2023.07.10.18.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/34] sched: Restructure sched_class order sanity checks in sched_init()
Date: Mon, 10 Jul 2023 15:13:20 -1000
Message-ID: <20230711011412.100319-3-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, sched_init() checks that the sched_class'es are in the expected
order by testing each adjacency which is a bit brittle and makes it
cumbersome to add optional sched_class'es. Instead, let's verify whether
they're in the expected order using sched_class_above() which is what
matters.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 kernel/sched/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..173a42336d54 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9878,12 +9878,12 @@ void __init sched_init(void)
 	int i;
 
 	/* Make sure the linker didn't screw up */
-	BUG_ON(&idle_sched_class != &fair_sched_class + 1 ||
-	       &fair_sched_class != &rt_sched_class + 1 ||
-	       &rt_sched_class   != &dl_sched_class + 1);
 #ifdef CONFIG_SMP
-	BUG_ON(&dl_sched_class != &stop_sched_class + 1);
+	BUG_ON(!sched_class_above(&stop_sched_class, &dl_sched_class));
 #endif
+	BUG_ON(!sched_class_above(&dl_sched_class, &rt_sched_class));
+	BUG_ON(!sched_class_above(&rt_sched_class, &fair_sched_class));
+	BUG_ON(!sched_class_above(&fair_sched_class, &idle_sched_class));
 
 	wait_bit_init();
 
-- 
2.41.0


