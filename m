Return-Path: <bpf+bounces-32460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014BE90DE4E
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F271F1C22C89
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A7D19DF71;
	Tue, 18 Jun 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUS/idte"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD92019D08D;
	Tue, 18 Jun 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745718; cv=none; b=ejAI06f+sOTJeGmdld+dE0cMrHoshmqEmJACfl4ptqAGtLkiukdiO3DhVCMlATNpykAt/Wo2QYJlwyu1+r3JjnKNghQHOgKksL+PuRDTaRhXvKS/1LgiPQJawQ0IeXYMXRok1zkAiJZH5m/BzWLvDOiVUog9/uhrh7S4DyNZLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745718; c=relaxed/simple;
	bh=fbrD6vMpgp7YF0DJ0bR9aCKBduXssNKVxLNydChdeEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbFneo9DcwRb7TGf9FVLgzUcWlJjdJUhTqK9PMoxd1c5JJW5w/STMImevrpPLgWxy9ibrNRqIo0RM9UbUzwdmihcd3w+PmfQ+3qxeb1XZX/xGiZaZGw1xYqHnoKpObp+xQ+iUSM6IGUYPd+YJjpMAbV0BuiEnPYVJ1VkPG3abfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUS/idte; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7061365d2f3so1604701b3a.3;
        Tue, 18 Jun 2024 14:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745716; x=1719350516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3Wda6bkV2oMHP6fWKneo/+xUVvmAhNC96uSijkfcHY=;
        b=IUS/idteWTVC5lcc2h3iPuFVuQ0PmbQplvi2PuhCXqjwQoRqjxOTb9b5op9+/xo8XV
         K/TGPQGtIsavBRmFj30DldSt/oiGh1pRbazXYX4WIJSrTZqk8EcELUfKOmkO9gHcnzzs
         6w71+gEHYQKatRvVe8fwcjWMf3UWkviczTabre+rDudl5WyyVkCYQf4jAjijSfL6KaTq
         XA38aMhgINo7pQd0uMXt5Q2Kk7HMmorUVqiwcarAHoyNtkk5Ii18N8KR/8CU9IA4NlaF
         pDM2BtO5UCezBrBklHGRshuL66lUdKM7tU+ZoSJVhgc6tdiFQBCvHuQXnIgJ2qT3OLt/
         QCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745716; x=1719350516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3Wda6bkV2oMHP6fWKneo/+xUVvmAhNC96uSijkfcHY=;
        b=DXu2zJlLEAXB0j+p/VxEo4CCTJBwWN5hGhLDu6YuSE3Xo3sBMbU4sMRHzvd/j9Nict
         PQJupp3fUgi/8WnpDQFkYC78zzhCkuvTEso1Q/a+ZiYsRhpcMvWhU7eB2bWgktCl0cqW
         C8aHotlJ1cdOhqNdjEanWAMnTLqPWRGEy9f4fdUWKDnEBiDSBEiVW8vNyTdzLoPRQSPH
         xIXHKgOISDEPgPu2MeQK6qPfuZpVX2/wed1g7dFA55yCKw+OFzMOvcb6wxY3tcI404d1
         PgdWoA8xaj7iUhhB9W1+CImTUUG0CL/abyATjyiAis7qJ9lMucfSP1apBZX+OTVzYyuL
         tpPw==
X-Forwarded-Encrypted: i=1; AJvYcCXMLxI5ibRCqIXAQ/+sVCLPE7x0/tti6GSfLdV16+w/R8v7TrEPQ/kteLLbIrK3m1tXrR4Wgcmn2+zb1B8SUQRs1H/m
X-Gm-Message-State: AOJu0YxFy78DKg3VzUyqW41B9MPFTdM3kzhgkhLeLefzvKu2D5/5TD2z
	378pG+7WoGUlRiXicj9oJb9Mg4A1RDkZ9Pd9A5uvG5SI08PhQMIh
X-Google-Smtp-Source: AGHT+IEMKC9vwHv36z2eWc/Evb293MLvP/8Wb7ni7AMy/g6hNaYgRKmUfCNGQNgMsuSwm8k2j3CDgw==
X-Received: by 2002:a05:6a20:7908:b0:1af:4faf:e4a8 with SMTP id adf61e73a8af0-1bcbb4561c5mr707211637.33.1718745715966;
        Tue, 18 Jun 2024 14:21:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769c8aesm13554282a91.39.2024.06.18.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:55 -0700 (PDT)
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
Subject: [PATCH 26/30] sched_ext: Bypass BPF scheduler while PM events are in progress
Date: Tue, 18 Jun 2024 11:17:41 -1000
Message-ID: <20240618212056.2833381-27-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
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
index 7c2f2a542b32..26616cd0c5df 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4825,6 +4825,34 @@ void print_scx_info(const char *log_lvl, struct task_struct *p)
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
@@ -5729,6 +5757,12 @@ static int __init scx_init(void)
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
2.45.2


