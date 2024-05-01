Return-Path: <bpf+bounces-28363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1421C8B8CC1
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E2A1C22220
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC613957D;
	Wed,  1 May 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyjsO/GD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7391386B3;
	Wed,  1 May 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576467; cv=none; b=NezGwRGaPPJ6dsJ0dpPnXDh80UkNu4l8ScekgNJwuIZPsP3Aj3PlRuHvwcf+3BiXGaK0Cn3T1SCvEmDIVB0o4attleY3YN20StBO5fDxy5pL1r7yxad+wU9c/U4LAF6HKJ466FMKxGKYcI6GAvvrdLDdVq7YwaCg8bcK3kTXU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576467; c=relaxed/simple;
	bh=umSt+AwTmTH3qds/vMuDmtTqEDHwYJ61QQlaMccHss4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4Z98No5TG8KC7n2tCP/TzDh1RDfPrdj67mF3aUA6U9bN3FbpC86L0a0F2eOP6zwRJDt033gIyMQ7z+hCKDrPAGAlEzAvXKVh3+/Zg64xs/CPAfytwy8uSE3Cl/5qR8ypt7UpaeaDdHg2XMXLcgyJhRDSG3iRgoOT1Ld6U/i534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyjsO/GD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec4b2400b6so16273495ad.3;
        Wed, 01 May 2024 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576465; x=1715181265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6U8VsuI2Ijq8da5T1tolpsDpFMZrrIc0bnPL4ZEP/aU=;
        b=kyjsO/GDE7BuuZSIdOagCCGto7zGXZHvZdx8KGADrWxmVQuU3TKmcSzbAWoXdjpZlo
         CoKlg6WBDNbI2hXlESrtVDNbxHWEucoCSfjeEbS8dH6AGxVzsMffPFe3PK3DbURg4h0x
         tAvyUu/tZDDfm70CRYqGqZ6zN6YCmJhdmzI4pNiT8i5XvFvYGqtMZtAyrfIe2zeTP0ux
         6y9ejHvQ4aVI9jjE2XuzdJ2bO1aJfTIEnE/UO+XtEk0vlsrtDl8/gDuaDH+AAaSVLNth
         y49/5xmBwsO1muNWo+N758S9vGaa1PkL7LB6fPW9Wl9uWxof5HAnqPAjrUQqC9xDVqbT
         h0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576465; x=1715181265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6U8VsuI2Ijq8da5T1tolpsDpFMZrrIc0bnPL4ZEP/aU=;
        b=oiaA8X2V/QVVfzmiUEVJV3x0AjywgN23+QnDnZ0wCdYNvOd4Y04ZPEPCCnGx9jodME
         UPE90IbJnjbmyb2cY7v5o6uTSmggwouljueiPlIauEyyYo481uqvTlp8NGkWOM1IwOS2
         DlYjCTrmnLLw1ZeOprXrs6dKqs8qpfd+BEQY4OE6HuQSRsYbO7Zg05eDzR4ruVkj84d0
         nt8OaFbak5MvbVY8g2khLEmeUWyhiJYCoMCGmmXUJKJkLyS1n4FfvYUVL6Up1QLyGXCq
         F5ZTGVd+2xn2qe5asa2Wdrsv5kIxB9eJu+DK4ZtEbn+Eg3t/vQ8p2wqK5iypEB6SXbNE
         omJA==
X-Forwarded-Encrypted: i=1; AJvYcCXdM54/kIx91B6miJKh/SwT9iXorY6PuMl8nMDihk6ufshFhdZ19Dy7DtbDytWy/crwglNEjpCUg3g/PsRrPhtzEFgC
X-Gm-Message-State: AOJu0YzV10J4r2JiZro4y2iLUouT1jM34AMr6LdUbtLFMGYTGkkAtYAp
	lnp4n/mVdBUwz144clUJwdlN30IP3xRyOzVedRubE4SdvIPNwehdTGcfQAbf
X-Google-Smtp-Source: AGHT+IGYbCZRU0fe7g//BWK/50e+G/4RMAWBbtu4TTgcSYlBjpkoaWidVbeDmzFzCP4RW4+0cta0OA==
X-Received: by 2002:a17:902:b948:b0:1ea:5aff:c8ce with SMTP id h8-20020a170902b94800b001ea5affc8cemr2123423pls.29.1714576465112;
        Wed, 01 May 2024 08:14:25 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id e14-20020a170902cf4e00b001e259719a5fsm24284772plg.103.2024.05.01.08.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:14:24 -0700 (PDT)
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
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 33/39] sched_ext: Bypass BPF scheduler while PM events are in progress
Date: Wed,  1 May 2024 05:10:08 -1000
Message-ID: <20240501151312.635565-34-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM operations freeze userspace. Some BPF schedulers have active userspace
component and may misbehave as expected across PM events. While the system
is frozen, nothing too interesting is happening in terms of scheduling and
we can get by just fine with the fallback FIFO behavior. Let's make things
easier by always bypassing the BPF scheduler while PM events are in
progress.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 kernel/sched/ext.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ed2452d42862..619ae7e814be 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5010,6 +5010,34 @@ void print_scx_info(const char *log_lvl, struct task_struct *p)
 	       runnable_at_buf);
 }
 
+static int scx_pm_handler(struct notifier_block *nb, unsigned long event, void *ptr)
+{
+	/*
+	 * SCX schedulers often have userspace components which are sometimes
+	 * involved in critial scheduling paths. PM operations involve freezing
+	 * userspace which can lead to scheduling misbehaviors including stalls.
+	 * Let's bypass while PM operations are in progress.
+	 */
+	switch (event) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
+		scx_ops_bypass(true);
+		break;
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+	case PM_POST_RESTORE:
+		scx_ops_bypass(false);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block scx_pm_notifier = {
+	.notifier_call = scx_pm_handler,
+};
+
 void __init init_sched_ext_class(void)
 {
 	s32 cpu, v;
@@ -5902,6 +5930,12 @@ static int __init scx_init(void)
 		return ret;
 	}
 
+	ret = register_pm_notifier(&scx_pm_notifier);
+	if (ret) {
+		pr_err("sched_ext: Failed to register PM notifier (%d)\n", ret);
+		return ret;
+	}
+
 	scx_kset = kset_create_and_add("sched_ext", &scx_uevent_ops, kernel_kobj);
 	if (!scx_kset) {
 		pr_err("sched_ext: Failed to create /sys/kernel/sched_ext\n");
-- 
2.44.0


