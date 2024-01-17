Return-Path: <bpf+bounces-19704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD0682FEF0
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 03:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5A328A3DB
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 02:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272E328FC;
	Wed, 17 Jan 2024 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip0IpbJJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516261864
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705459804; cv=none; b=XTAU49oC9AKahvEHMcUGLhUBAJXR/MsddFpzzvk96iKYyhV6voCQgh682+sc73izlGaXv0xVtKcSNBoBI3Yo6Nvs8BZHQLhoAU9hMzK4A8fzxbN8rSpSACHHv+rpuqVHkDSvUTxg/8IIR/2yEDGpV9QrzrpE9d+q0xLZ7vdvw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705459804; c=relaxed/simple;
	bh=sns4upvS/ImrRuZRxHUeNfFchsy7KWnKMBINvsMe5fo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=op0q7UE/7HwqxC8p/gPdH3tg1LVYe1Xgwbfwgmw5TMGhEEFXn+wfEu8YH5lcrwaPq1+N1zvVnz06sUhhIySTHY4dc9WRSfTxcKi56aBY8zqfnIRJP3JDPbNPttf4Ci35qRNyEgAxQmruNKXIzReXmulSGwq6XyvlVqS0x/BusMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip0IpbJJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d427518d52so77402125ad.0
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 18:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705459803; x=1706064603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vo6OiK6NukgwPL8Xr1LaZYIb67om14Mx7V+qbJNR9bw=;
        b=ip0IpbJJkzn6pYrdVq7CP5y9BdbtsKQhF2ci3Gevgz0VQtr485FZ3W4sHytt1PRDXu
         LhQ3r2u9wqJuTEDcVk5RvrNQh1RaOWsz5NzWEp/4CYxSKzolpktvdCSDdI0vsH3gvn6l
         o+cmHFrzTkJqDc+kSrp0CzanjucKsskFO/cG22ZI3PxO5hvBNNGSKLY2e/WJMw+cJXpv
         cDWTTupFOEeEsZf0enCM1rcXinmhDPNWPo0l8vyYYW3QUQ6iwMn2K97LKTkpcSxm5Wpq
         b6TC+CsgqIU1ZaH4qrPgi/H2MdM08onD5SOJbMv2JA4H8pjJ3YlTTgefM614lA0lcVQh
         Ns/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705459803; x=1706064603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vo6OiK6NukgwPL8Xr1LaZYIb67om14Mx7V+qbJNR9bw=;
        b=ue0Jb9KFni1WwWN371V2caXiIjLIUbE9isvwmaDJbqN4/MVAN4AzYUxxTTDG4v6BBc
         Q43iw9zoZ0jtclsFc9TvKddd3QA0DkYC006ZlUIxif+owYNOgVEm55YPCSJTpOyupXwI
         6EucgQhH1qoc1M/h5Gthd9k6I9l77t8mwJ+6KdvMqk9eyODl8gu+rgiT9XbghtWEFFbs
         O5yRoWFB/DMXuM1BVM9r264/qP+owwu8JSCYhGvk3/3SYMiTtV588F8wfvOUDnGdasoU
         X4JTwrh44ZAtEYM7HLrzmK+vmvfXRJ8G+Nk8Uwoy27R2gdsf9K8VeYa9VM3mfkVsAt0S
         aBEg==
X-Gm-Message-State: AOJu0YzxnAB7RtV0MVz93HSc0AVWrDYFbEwpXF0GfWu0R4YdChOmvgHM
	KJP5H/lRMvqWKOz1uEk02I//R6TBJkdMBQ+DunFuaWG/rrQsOsG5
X-Google-Smtp-Source: AGHT+IH02AtcOLZd9J6bRaUfM93ac6cMptSN2IGSU0qYg+y9h/hnToNVuKX4KPTT41O0or/Gb2RCaQ==
X-Received: by 2002:a17:902:d683:b0:1d4:e024:f172 with SMTP id v3-20020a170902d68300b001d4e024f172mr204880ply.54.1705459802567;
        Tue, 16 Jan 2024 18:50:02 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac02:50f:5400:4ff:feba:a83e])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902c79200b001d0cfd7f6b9sm9996883pla.54.2024.01.16.18.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 18:50:02 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	lkp@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 1/3] bpf: Add bpf_iter_cpumask kfuncs
Date: Wed, 17 Jan 2024 02:48:21 +0000
Message-Id: <20240117024823.4186-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240117024823.4186-1-laoar.shao@gmail.com>
References: <20240117024823.4186-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three new kfuncs for bpf_iter_cpumask.
- bpf_iter_cpumask_new
  It is defined with KF_RCU_PROTECTED and KF_RCU.
  KF_RCU_PROTECTED is defined because we must use it under the
  protection of RCU.
  KF_RCU is defined because the cpumask must be a RCU trusted pointer
  such as task->cpus_ptr.
- bpf_iter_cpumask_next
- bpf_iter_cpumask_destroy

These new kfuncs facilitate the iteration of percpu data, such as
runqueues, psi_cgroup_cpu, and more.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/cpumask.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 2e73533a3811..1840e48e6142 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -422,6 +422,72 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 	return cpumask_weight(cpumask);
 }
 
+struct bpf_iter_cpumask {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_cpumask_kern {
+	const struct cpumask *mask;
+	int cpu;
+} __aligned(8);
+
+/**
+ * bpf_iter_cpumask_new() - Create a new bpf_iter_cpumask for a specified cpumask
+ * @it: The new bpf_iter_cpumask to be created.
+ * @mask: The cpumask to be iterated over.
+ *
+ * This function initializes a new bpf_iter_cpumask structure for iterating over
+ * the specified CPU mask. It assigns the provided cpumask to the newly created
+ * bpf_iter_cpumask @it for subsequent iteration operations.
+ *
+ * On success, 0 is returen. On failure, ERR is returned.
+ */
+__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const struct cpumask *mask)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(struct bpf_iter_cpumask));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=
+		     __alignof__(struct bpf_iter_cpumask));
+
+	kit->mask = mask;
+	kit->cpu = -1;
+	return 0;
+}
+
+/**
+ * bpf_iter_cpumask_next() - Get the next CPU in a bpf_iter_cpumask
+ * @it: The bpf_iter_cpumask
+ *
+ * This function retrieves a pointer to the number of the next CPU within the
+ * specified bpf_iter_cpumask. It allows sequential access to CPUs within the
+ * cpumask. If there are no further CPUs available, it returns NULL.
+ *
+ * Returns a pointer to the number of the next CPU in the cpumask or NULL if no
+ * further CPUs.
+ */
+__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+	const struct cpumask *mask = kit->mask;
+	int cpu;
+
+	cpu = cpumask_next(kit->cpu, mask);
+	if (cpu >= nr_cpu_ids)
+		return NULL;
+
+	kit->cpu = cpu;
+	return &kit->cpu;
+}
+
+/**
+ * bpf_iter_cpumask_destroy() - Destroy a bpf_iter_cpumask
+ * @it: The bpf_iter_cpumask to be destroyed.
+ */
+__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
+{
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(cpumask_kfunc_btf_ids)
@@ -450,6 +516,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU_PROTECTED | KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
 BTF_SET8_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.39.1


