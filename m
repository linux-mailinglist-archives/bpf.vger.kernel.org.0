Return-Path: <bpf+bounces-53349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F11FA5044D
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6C416AA47
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF91250C06;
	Wed,  5 Mar 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="wpcqmQ1z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4D24EF7A
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191214; cv=none; b=h8H7B2Z3o1IVn6vkjLwtp9lzY9HzUpDtdcUe9VfM/4VfH5rlvRFiNLfbtSbysBLnaFteUxLsgh+ea/6qG2ZV4oNr0wvdorqhfX3s9Fbx60MSualkc+q6VMK6DR1t2bTDA9UGBcmHjKLKkwqnwejyeJNV5DkxQ1/ZuVsy6RWv84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191214; c=relaxed/simple;
	bh=W20VTxXokMzPaxnb7ujsLOPi2HgbzJCAJ41viUW2DhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQuLJ2uM6AFDt3sRAm907GMjutieYoOwC+ezQBCJJ/BizlXcfjD2TQ+wnOfkaSYP+MVDtuLqYRciavDpIOg6VfRUOe40ebRUg8+ZA/QN8Lkj0GAAp/2TkrnJqjmzIilwgyDc0h/SIfi1L+9Y+XYHMbmyGOv5a4lWePZfHc2Codc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=wpcqmQ1z; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3d1b78b93so132835585a.0
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 08:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741191211; x=1741796011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWEnOKEFrkHWQU2++5UZ8xawZX1cbqJWh9MfKPvDr8M=;
        b=wpcqmQ1zKY3B50lksKCOeq7vdn7RVgpfLa5RQGTZTza+Og1+Cn8MUg+k2HB/iA3iDV
         gNmMnycA848wgf1lPGNofvyFnryXnzsvcuj2SH/ze813dwcvUgKsMul0nclKqV+qCnbQ
         6gEq7yqJ0bbZk0R09tOLPtMSF0f1u3URt8AFFxskawD1gvQZp+h53XTLphyIRGEI16Bl
         LpCX2MwipEk6DI41oEDGRz5wqv41rYk5ON77EFh6EJmp1o2Kd6ReXRFDcQddZWmXbc8H
         J0e470asTDdNrIIQNpbGEDMnZ4JH+NMNIVd2LjT3kqQfFpyv+dBxuPGxE4xK6qe0tYfJ
         Zq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741191211; x=1741796011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWEnOKEFrkHWQU2++5UZ8xawZX1cbqJWh9MfKPvDr8M=;
        b=WLrkNd7JguoFdbkKetVGkylXK283AvVB++ct6U8Ez791Z/zIMyFdJmb5V05XQhC1XV
         zVFp0iJlJ5Ihhk4ZDdRBxiT7NlYh/cgzxQ9eEwO1rS1LmM94kLzwiKV0O39ERcE04qJl
         +ZX3z7dYTIReWRpdhJjKl2Z4TyGuTab+fJGqpPePSDwmYW755QMRhN44c4J5C/TP8as5
         dZhq7YEyDeHHuFVRobX6my03mOM+/Z9czx/reJ14sydKDl0jm/hfxjYxh1KL4JhL9roe
         412GeXuD+SvubiHrdfA8FX459/PfzeP+RUjJPyhQha68HSG2QlfYsblQURJhY2ra9rVx
         F7oQ==
X-Gm-Message-State: AOJu0YzJTDnTBwsgxmTSBLpb7hWMy1xcc0ZoLoo5mNr9/HMFizEaGITY
	o7QEI17je9ZAaBofhTq4qHoHs2dLBAu+kT67nZEc5LgE2c2xfdMyObbmrwofkyuaoBR4muu+PoJ
	zo6wmxQ==
X-Gm-Gg: ASbGncvGyUY18ipLwvqL3z3NdTA+XzTc8Ia3Rgl2bFQnXPCMcEAV4wnmXqNBZEGSpnT
	yW7bCN4kcWKFzy2BOFQLTxpiGc9wkFx3FN7WYHlXX0FblyeVlZSWP2Os2+jBI480MBk7Taa1ztU
	w1pvkFzNqn2cjXsZDNm0gIed1HrlmUdcqmpRL1ho4n1zHSyxr3dtUumzsZUzQpurE9Dm+Py4C/C
	8mkI48ZT+wP3bwzCR44uX5uTOhJrTJaK3DHBtDzADEZg/eBXaHmvaanUK29DCGoZPxFuHZ3im/U
	vHw9A9GsuF4QbGMmK1VNUSHwvstbRc/+fpkvEIf8vw==
X-Google-Smtp-Source: AGHT+IFLc3sGyEquF1eJ1juqwNRIqhnH4YMLnJ5MjJym0/ckSz74m+BPH49IJPva4kLM1JEHJyRhew==
X-Received: by 2002:a05:620a:6293:b0:7c3:d75c:cc45 with SMTP id af79cd13be357-7c3d8e46447mr579527485a.37.1741191211533;
        Wed, 05 Mar 2025 08:13:31 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c32aa5c6sm368393085a.48.2025.03.05.08.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:13:31 -0800 (PST)
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
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v3 1/2] bpf: add kfunc for populating cpumask bits
Date: Wed,  5 Mar 2025 11:13:26 -0500
Message-ID: <20250305161327.203396-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305161327.203396-1-emil@etsalapatis.com>
References: <20250305161327.203396-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper kfunc that sets the bitmap of a bpf_cpumask from BPF memory.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 kernel/bpf/cpumask.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index cfa1c18e3a48..2a0770544fc3 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -420,6 +420,33 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 	return cpumask_weight(cpumask);
 }
 
+/**
+ * bpf_cpumask_fill() - Populate the CPU mask from the contents of
+ * a BPF memory region.
+ *
+ * @cpumask: The cpumask being populated.
+ * @src: The BPF memory holding the bit pattern.
+ * @src__sz: Length of the BPF memory region in bytes.
+ *
+ */
+__bpf_kfunc int bpf_cpumask_fill(struct cpumask *cpumask, void *src, size_t src__sz)
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
@@ -448,6 +475,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
+BTF_ID_FLAGS(func, bpf_cpumask_fill, KF_RCU)
 BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.47.1


