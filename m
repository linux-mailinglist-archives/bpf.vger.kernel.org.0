Return-Path: <bpf+bounces-53397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5FCA50D1D
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6473189148A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 21:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F0255E54;
	Wed,  5 Mar 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Qpj8V9Jy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041416426
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209167; cv=none; b=DQgBFlBJob3Xa2BIJhVxvNkw0nXJuiV/gcTY5oGRw9yQHdWaVQjWKeU5xQv2A66+e+3d/DvY9ckiEQR+8uql6q2z/1GIedPRenmu7rPxBvNPq7CpjRdYgcwPSFtnGn5mOnizvfiYeYxip+X6DNf4HwfPTm4M1lSOf8EgraR5aIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209167; c=relaxed/simple;
	bh=C21DKof42ArviOdYqXGiNPXIkzx61D5SRrwmr5MsZRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCbC5R8nZRpwTwCYeNknIslZdCX3xdPZ8P4xw9i0evD1KwCZTuyhGOBJL1aE3VkXar5b5PKGQpR26RMhMMMkhVDahDZkqWqCK746IvivVBDDeb19BCZgmJiS6ST6++nEBx/ncmHKWXb3zeTQklJtd2rYjmokL21qcBST/B08KMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Qpj8V9Jy; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4721325e3b5so61564641cf.0
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 13:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741209164; x=1741813964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2Yn1YOUIiLwYiCIsvkK6BnPw5MMb4a3IXIPOWbODOg=;
        b=Qpj8V9JyIqQly4XFJ2SPuTIJ22LK91W3AkvWmWquFDAec4qcXZPHgG1iMqhjiFmWxr
         nmBhTw0QEyY2SsRAzaR/FKsT84GKo5jXKKSEDPiLMQP/NlIgYJy4ttnk2PoYyiqUr8g8
         Q6ouPNisPj2iLKbSDdmP/JCs9T1NcYw+i5zEF1LkUllV2dYGxSSQdBDqnxANv5FA8jJd
         0Sq3GfsYimVGQh8bFwhBTYTREfWZgdFVW8u0pJNCo3mIJ6dOrALAdiq412lCXmtLcv0L
         1OsHhzocqwF122OxhFXBw+oU9soigya2DUS1YJ756XfMZX5xApChb3TFwqRjfGGPVuvM
         A4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741209164; x=1741813964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2Yn1YOUIiLwYiCIsvkK6BnPw5MMb4a3IXIPOWbODOg=;
        b=JSQynDGL1jE3I4Pej5I2JmtLiSO+CxEzDQVsRpDhz2TeuEhSyE/Dwy1ICD9eqT09/C
         cGo6JHtYJHgzOynK0OK+s1zxGKKZvsjZUnTkVn9+Brqei4C8k2ALiRDx3es5Th0RyAES
         Fpc04nL8rN3FTSl+JLZw2Hl03NpkCjHD5tQDUgeMo8SB91cykl2G1pbC1eEX/pM8PnvL
         ZwxiEl17/HufSzrkdYjTdRsvGHXVkLhUDGK2jS6si6zuUJ89jJ1IddXl44SSbKkfhGy6
         LYoGgzDfQSE2pjCraBhpGlhAIWL/Yct2rTdC4jJ3xduzvBHXmskOnK1ZYrBFnpT+Nbwq
         xk4A==
X-Gm-Message-State: AOJu0YxOgznhu8NJ+L3kqHiECSnsb7oR0tDvpUTRi9btc7P/A8DNsWKf
	3jSvINMJLyItD7HZpIMezIQ18svy371bzFjlArV+wQhZxlS/YC0sjvTfI/1rdr1fKsE4rPlYZR9
	zSqGu7A==
X-Gm-Gg: ASbGncsxhaCHrij4YrPkP/DEgeiu7zLQ4m0/R3BOv9l8ZUNIgNAvIes5lvmvxCDkI7r
	KX22F9D6a6V4YDGTeBS/USj09P0YJIFsgJgA1Mj9Jn6WkDYA/yIT1D+KtZHLTn2SZsahl10vVrb
	F0DgaLIokID79L0kxFEofD06kIKZMx9PeLyxdffu83wx1mAW9mbTMYWS2N0wSUiSWvNg0u2EGrS
	UG8ubVmMNhGUB3cctn4xrwG2wiMj5paw8rmCDUoVuMHTSOsBygfYTG28n63HdvS/5eh55rm52z0
	n+0jMC8kv82zDagml4NbMHAdxxwl+bXYwqZcOX4viQ==
X-Google-Smtp-Source: AGHT+IGKRIOhQCq0Fez4x5h9Jdis92n8d9c32gwmEN2lm7qZy8vVLNqsNWrOad7TjavSdmpzPlKqrQ==
X-Received: by 2002:ac8:5f46:0:b0:472:1399:2da7 with SMTP id d75a77b69052e-4750b448137mr65100311cf.17.1741209164515;
        Wed, 05 Mar 2025 13:12:44 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474eced9880sm43726851cf.17.2025.03.05.13.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:12:44 -0800 (PST)
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
Subject: [PATCH v4 1/3] bpf: add kfunc for populating cpumask bits
Date: Wed,  5 Mar 2025 16:12:33 -0500
Message-ID: <20250305211235.368399-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305211235.368399-1-emil@etsalapatis.com>
References: <20250305211235.368399-1-emil@etsalapatis.com>
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
 kernel/bpf/cpumask.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index cfa1c18e3a48..14080ca694b0 100644
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


