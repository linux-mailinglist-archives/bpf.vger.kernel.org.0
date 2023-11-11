Return-Path: <bpf+bounces-14821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF847E8867
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D80E0B20B7C
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062435678;
	Sat, 11 Nov 2023 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKJ/3dj7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4F53B1
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:48:59 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C913C3D;
	Fri, 10 Nov 2023 18:48:58 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5be24d41bb8so1019455a12.0;
        Fri, 10 Nov 2023 18:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670938; x=1700275738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nv8ktVFtT5nljla2sLNhAyXb8/ezoh4yZA6+2Ch4Es=;
        b=UKJ/3dj7ZiWdoNXKMaOsCSQX0MVnQbhefAMPnBRxbOdJdoPJU3cjnNoOA1yJliy/YE
         gmmemvAyItizUIjRTtnNNXhzo7yc/5T2Z9sm3NwhjSZDZYKr1v3wToUgyjkOzTGYP7IQ
         lbCRjyM3Bofe3ecc3VS9RuShH80bMr7Z0hV5PTZ6pKLNH102VGb1y5n30wKepNNny8Dg
         MCgGmZseeHloTlUwi/H7r0Vo3WXveCeujbsEEw4+AMNaCy2n+V5xJd2UFcUxgfRF2bk8
         6csPUjw7Ota5sc3qAaIiAdjcH1Ci1TbgJzWLOyTrZwDqAib4JWwHbJupowkkOcflM7S1
         SmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670938; x=1700275738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/nv8ktVFtT5nljla2sLNhAyXb8/ezoh4yZA6+2Ch4Es=;
        b=o8DJerKznHeqWL4QAdy8AQiWOtwbS61/jPXm6qL5FT8n8PzLJIT0SVMU0vRRPcjf4V
         wjPmY5D0w1QNVFL0W+jApPff4ynYojgaXfjJowOV5y6bRtdzIavsd6MpEplsW6k4bw8B
         2gJmBfCTPXCHcdNxom0gRdr4Ixi60XV1L4kJSPoHaDbnMM8g8+OxSi9pwcCE0DxeXur4
         SCAPp+9P2UX8k9izMENvuo/M6ULw+VOoubjMrczq3aJ6nFB68/03pVgYkGiwppmQkpHa
         vUV04NYs1DmrnBou7Z1ixHEqYn7yivAc0xH5NmhcB98fN3pY2f0dw8IkpZeVYDfwT620
         qPWA==
X-Gm-Message-State: AOJu0YzZw/8vjpmb0YenJZSB9grgw95+HFlyIt6cEILw7hFmW7L9Qo0g
	aebWx/cFzrBfsnsFObip7gk=
X-Google-Smtp-Source: AGHT+IGTi7fq51rfWo8dWJHa0yg1N7OXhznb/2hweYIXY2a1MONkkSOxqD3Ivk89RKAdE3EuX12V2g==
X-Received: by 2002:a17:90a:d34f:b0:280:6cde:ecc2 with SMTP id i15-20020a17090ad34f00b002806cdeecc2mr6434036pjx.11.1699670938290;
        Fri, 10 Nov 2023 18:48:58 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090a2a4400b00280c9ba1176sm473735pjg.48.2023.11.10.18.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:48:57 -0800 (PST)
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
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/36] sched: Restructure sched_class order sanity checks in sched_init()
Date: Fri, 10 Nov 2023 16:47:28 -1000
Message-ID: <20231111024835.2164816-3-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 3d7e2d702699..5c0ef271a31a 100644
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
2.42.0


