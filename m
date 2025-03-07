Return-Path: <bpf+bounces-53532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D4FA55F47
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 05:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B7F170F72
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 04:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9026E190696;
	Fri,  7 Mar 2025 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="HUM7hgu+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02992249E5
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741321065; cv=none; b=C/L2vKLZJ0T54dJQGisFvmM+reb6nE/Xo1QS6iAd8+YJ/uRMBRAhmaNwB0kIwLhQhssUBv8YlssFw9USoY/UHBLo5MwtTy+qduBEh82ON2SNe8fz69CxobMiUruBEmNe+y5+aoXTfiDrlutClh5BwqAJ16x+jFVstaiS4dQRwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741321065; c=relaxed/simple;
	bh=jWOUUt+7DEV91SW9usSGCPHzlJSQ5pKOyZ0xZWq+8ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7zo5QfrgnI47dJugvZTj/yjFs+ioGbnTBOKDvSGvzvfDGKGSwoo3HhZL1yTj8l28e8/YLwW5lKkRfDXz2pYiHYi0+i8KgZLa7+meY3IOq3j9++/jjZ3cxtCmUhPULbETM6E05/kT78hkC/V+5pafhH56nVPMDgJfiEA02ludP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=HUM7hgu+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c08fc20194so255623085a.2
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 20:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741321062; x=1741925862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOlPAt6QzAtIMcKAdCSiS4FyW9j3OpeK4f/Kfe5aLZ8=;
        b=HUM7hgu+qMPiFbgCB8e4gwnq0GMCir8NDWTh3O6MrzTv9wVdA5rquK2nJQasUl96wN
         x4GHp0vrFXB5xlscEEQxuhgGKZuMznxhq+o1/oG0KDyipm4iTBFDE1v3QMPk+YtHTR2Y
         hVRPBtgjRrz1uLXu6Y9QH+w3yeEd20JxsWjANn950yTprWl3Tzcw5JO15dXq4PIcTeXA
         9P5cnI+29r8X3HcXh9Lmz8sPekUmWbDZSu5grXNzMu56sglyTv+VsyEeKcWjEhu2pI13
         cq070mJVpdDdDYiIVdw+t9GtqTEJ/v4RzgMf0DM8TfW6dJo3IG78fuUAzLI8JXEdak2h
         TfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741321062; x=1741925862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOlPAt6QzAtIMcKAdCSiS4FyW9j3OpeK4f/Kfe5aLZ8=;
        b=UcxNpzBmK5LjFo4hwBfKt807v1A80oOR8OJ29pLPYpTxnrrMHpMJKwgP2C0bbYLBgT
         XnRT1L/VdOaKYC8ujpfGgX0+JrKa31NJUXdnHIlwLYkwU2biT8fyp4yB2M7IyAIZ+Ce6
         7vfkHOPJyF1S8jusiHNkLHrQ2e37ToAmVCGE0G33xE7aZ5hpCSb86AuT1kSmJolfPF71
         L1+3zEKgcRxm6RJTphJI4Gg05H8S46LVZZRHFNCWHi3pwfp1yEZ1tMb8yxoPfwK/J9Ya
         3yzZiKt1jU9k30CzCwKa4xdaYX9I50dtaNCosEvlarcYB0P37j+YLaPJ8KjOGLhQ6wjx
         QhJg==
X-Gm-Message-State: AOJu0Yy4Tpf9WwMDKb5wx4yJt2DyNutRChzv/YINrDvaG+cTQ8gFVuYe
	K7nG+Dxtul4aeiGBYvqlKbQN8rwJJ7JtuncSOy/+6dANNbx2kbfKXaEUq6JJM0gZB4XrK5Q9dNH
	8pcrHFA==
X-Gm-Gg: ASbGncvR8LNe8PA9a5EHMkS9/Cv0b1QpHk5U1oYp6fUkFv0RasbOMFgmLDQ0+SN8tvn
	eI4kjuhZlo8rDIzmNb283rw8usls6yVQJKMLjuXp82S18+AjI+NjpjlJr2WRAhu7NLuNdVf3X/e
	ahSjjnoimXuW7ehuZU6aBVXaDle1TdjcOsKzfv3nRwCPQvNjl2Gx+Ju9TWK3iE594CJ/oAnJPHR
	99Z9fuke1xs61E72S1Q7G5MeUH7zeN/St4s31WmO6pFZ1E2svnoPjW1ZwC2rJAxUn/0AvYE9c0u
	HXwyzPzBtRJgvimaUcOFEC4m2oT436Yf2GP7hXIOHQ==
X-Google-Smtp-Source: AGHT+IFqAFVMB9lROknniHCzNFkyEwEpNC2RIllmYtCGnN66Bv5yYXb3L4sISfmZGSwcOb43JcFa2w==
X-Received: by 2002:a05:620a:6884:b0:7c3:cfa6:d1e1 with SMTP id af79cd13be357-7c4e61ca08cmr291524585a.41.1741321061855;
        Thu, 06 Mar 2025 20:17:41 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534ba85sm186108085a.28.2025.03.06.20.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 20:17:41 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH v5 1/4] bpf: add kfunc for populating cpumask bits
Date: Thu,  6 Mar 2025 23:17:35 -0500
Message-ID: <20250307041738.6665-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307041738.6665-1-emil@etsalapatis.com>
References: <20250307041738.6665-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper kfunc that sets the bitmap of a bpf_cpumask from BPF memory.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
Acked-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/cpumask.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index cfa1c18e3a48..77900cbbbd75 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -420,6 +420,38 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 	return cpumask_weight(cpumask);
 }
 
+/**
+ * bpf_cpumask_populate() - Populate the CPU mask from the contents of
+ * a BPF memory region.
+ *
+ * @cpumask: The cpumask being populated.
+ * @src: The BPF memory holding the bit pattern.
+ * @src__sz: Length of the BPF memory region in bytes.
+ *
+ * Return:
+ * * 0 if the struct cpumask * instance was populated successfully.
+ * * -EACCES if the memory region is too small to populate the cpumask.
+ * * -EINVAL if the memory region is not aligned to the size of a long
+ *   and the architecture does not support efficient unaligned accesses.
+ */
+__bpf_kfunc int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t src__sz)
+{
+	unsigned long source = (unsigned long)src;
+
+	/* The memory region must be large enough to populate the entire CPU mask. */
+	if (src__sz < bitmap_size(nr_cpu_ids))
+		return -EACCES;
+
+	/* If avoiding unaligned accesses, the input region must be aligned to the nearest long. */
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
+		!IS_ALIGNED(source, sizeof(long)))
+		return -EINVAL;
+
+	bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
@@ -448,6 +480,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
+BTF_ID_FLAGS(func, bpf_cpumask_populate, KF_RCU)
 BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.47.1


