Return-Path: <bpf+bounces-53274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C0AA4F474
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F71316D58D
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DFC15252D;
	Wed,  5 Mar 2025 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="UMGhfMzi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714C82C60
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140657; cv=none; b=B2ln4pouzw/fP1U7hdt95vEPOMbtgMzcNx8dwSBpMhkFmfhj4gyxWX6NdK/a8qdsRQ72YXbSfII+D0TE2xShO/f3wjZSvfBlEY72RwCbA+zBz8A4de6mosdmCXh6RaIhkSyb18BFLkWuukSN4JPr4bZkHyOIyRAp/uo4AkRGhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140657; c=relaxed/simple;
	bh=fPE36zi4HDhVZWGvt5TTqMelXwXkXruejuOdtOrc/uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhC7ncekZeFUByYKE/UDNXA0rXK6zfz/7HKb04FaHk0+al7e5gbowQnuTs9wWDBgIfKZ5L8wIFOWUBBK0a1FuEPbbqvZNgZUVHpVDTBlOSsjrTHzwK07hYTc9Ix39BYkwaHbwUQIgo4msVPVL80OQWARaVHEZCvWiGt018M82J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=UMGhfMzi; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e89ccbbaa9so43070386d6.2
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 18:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741140654; x=1741745454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LJJ9TkMMtG+JcTbPxMAH1S803r5HpZUYa5k1kptojY=;
        b=UMGhfMziEkk9PctXOznxZ1HW7O+O+2q1yAJ1g3gKutMWlFdBhFoucZJKpxJ56a9o5/
         niHVvsbv2NAeijEoh7Z40HGTrkLEmtYQXTGvVgWZbqGqIAYj7Ij8m7xlD1325dOMiZRg
         CnRyxY80IxvAlG3dwb5TLiP6RVse4hYcqnc/IMJCCxW/T9iwdRB1BApcq952MBxr8Zqw
         an2CUkTl/RZbXTkfdwCRlAfwFyCdyXvsRLRTxDUkFgzbDq+tye1M5z8kX3UvGmOiVwB1
         TGwIWnRcIIImD6A7Zb/SLpjQHhVsFVO6Db/lEIUZHWNANGOc+bZ/V0PJj/syo36yzpC4
         bgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140654; x=1741745454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LJJ9TkMMtG+JcTbPxMAH1S803r5HpZUYa5k1kptojY=;
        b=peqHuYufjyxaDNsciUt+xDZJ6DYJ96Iq4FT+ZUHTDur2evRUsbiTfE14SPBAuUkFer
         ar6dm06skoNIXY0UwdImiJwstJu7SCXQ+sFZex3Ur1tTmihHS5FCBA66LFJ+WYihl3yf
         lcIytp2uB/eXx+AGZuabEx78V1xUuZ+47ZaJbzuENEgoIJ8y9RcXr52KCGVJkdqxU99o
         ZyEcSqJwHVvUQfGEyuPuSmzVXyp2KPI/PLSQs5b7MsrSJfedjdW+A2LSvvXrsV5K39wv
         sy6QnzxykO9klIy+sHdz69/JIeCsSxtZzOXbVwXVluveVREQ+cXKz1ZIK2cj0KrUWnQB
         tA1A==
X-Gm-Message-State: AOJu0YzV08+apqT5WL/+GG9S0ARdaTFQd3oNNAc/6vZrFoVxKlyfXAgL
	IFjmBGtC7piexXLo96XJJTsfD3ISA4JGKTgx2qUZY9+xpBfobk5RaMr5sE0W7q5ZZQEHZE9IGAj
	D8bOKxQ==
X-Gm-Gg: ASbGnctqeTiP7wOtIF59VxBZ7ApbqSG/72P2ci0+NKpfmzbBikGMfRwr+mNnpogFx6h
	XZ3eQUS2LPYqNbvjXHQn6SCglCYoz/9ZITWS63pFu72b3aLl9hoNoUjioZYKJ+thQm7qYvz1s8N
	G4SKVdcjOJUI4CHGpLILH+b62/vOIQuUGO/fcsALPTxpT4Zn4UvM8eZMnDRxjd+pkCNS2OkykUc
	pn8Ho3+kDjSaHIHwXm/gGFEpgr/7DJyGqKwi/iogSKvqpwX4wWR1uS89CdB51Wtnke+Wg1CRiTk
	Gkql+KIRpwE2cMh9EkAlJV7FRqTbCLlVI87prAOTbw==
X-Google-Smtp-Source: AGHT+IEHLuHra7L7Wb4hw4FW5gUD5kabnJ7Kna4xg+ZNXC7Y8ehcoRwg8Ld0Ot8DzLDFgqM3X7KF8g==
X-Received: by 2002:a05:6214:e87:b0:6d8:ada3:26c9 with SMTP id 6a1803df08f44-6e8e6ccf943mr26926926d6.10.1741140654477;
        Tue, 04 Mar 2025 18:10:54 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec158sm73622826d6.119.2025.03.04.18.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:10:54 -0800 (PST)
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
Subject: [PATCH v2 1/2] bpf: add kfunc for populating cpumask bits
Date: Tue,  4 Mar 2025 21:10:19 -0500
Message-ID: <20250305021020.1004858-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305021020.1004858-1-emil@etsalapatis.com>
References: <20250305021020.1004858-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 kernel/bpf/cpumask.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index cfa1c18e3a48..e4e4109b72ad 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -420,6 +420,32 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
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
+	/* The input region must be aligned to the nearest long. */
+	if (!IS_ALIGNED(source, sizeof(long)))
+		return -EINVAL;
+
+	bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
@@ -448,6 +474,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
+BTF_ID_FLAGS(func, bpf_cpumask_fill, KF_RCU)
 BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.47.1


