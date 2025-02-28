Return-Path: <bpf+bounces-52828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8668A48D72
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 01:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1393B7D10
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 00:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E47748F;
	Fri, 28 Feb 2025 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="SLjOX+Et"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20638BE7
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702826; cv=none; b=pwEJ25YN03H4l4HvlL8Duww6RAyQF4XaBVESYegoFCcw5RtTbGIwP2zYPe5NQKvIpDS7Azm/qo8LUJpyN7PmOfI1HFMj4fOIHd9JxwhJTNnzxOiVeeNPkiKGubl6Nno15u95OIvorx5Y87qdMQt+N0IadotPYJ1fjvdbY7QpzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702826; c=relaxed/simple;
	bh=czd0CByd+8HifzhjxvYqMMnpTsWQfVduvuLxjch2RVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAOZNEbItMnekviDFphfuvpzpFgZeOOlsO5f9jSCuLldq9kP95Lj0ZhNIpF2BYTm0++KxBoTZcDrL/7X32v5eMlthaA3PD0sMFKKqwGodFvbMMyqbm7A+8JejUuF4c8Z0+l2wFavW6dS1o94JBj7XpY6LQwfLaMqT0hGNHxMa1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=SLjOX+Et; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47208e35f9cso18490231cf.3
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 16:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1740702823; x=1741307623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIRIYcVb6AgPHTCemUirgFfxyD51WIA6BHz/E7hx2+4=;
        b=SLjOX+EtpMX17d5lwiBfoN7BAymP3D+Mf3azuaXzq1ORyVw/ts3FvU6Lm7yMBXiBds
         0HdQNpfaJSRxJCLe/5e0u3NB35c/8HI5MzbWW9CI09fMmeVW4jvjven4xFu9TRFTpac0
         YGg2vTD49FCcCE3JwzUUWIaBFiCfd8G8aSFkfwMwn3Q9AnPnp3669qEn5+l02kS7g6kR
         Wpuc3fZ9H1iCEg5V7BhiAAKrvfmOhK1rdClHuoO7IKJbxSCcrPiXjJwFRoUmDE0KK0+6
         GIy74Z1CsTank6lUesUJLNYJPbXyyrS8kj+XvPjz03RgYDtI0Obn904o0GkPX2Sxl/WW
         6Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702823; x=1741307623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIRIYcVb6AgPHTCemUirgFfxyD51WIA6BHz/E7hx2+4=;
        b=CUoamlHUeaLUXKy3BfX3axLDEaikGYmj+qP+juy5OePMIJ4zed9Lbq+vcQRatoU2yv
         vnPrO/tcLujt3fMMw4j7VDZL0iVqbVho2BaaEL0XD4E/lnX9+e5z/pEiW9PaMQaDTOzC
         0gmVZW/V44qFUb/FH6yOJFVthYNNcu778xzzumRuUVsWnoPOL3bqLqja4R8sGQdn5JEm
         T0WhG42MSrRS+NlZvJpoDMEjlxykG4C/ebRj68lmPOXYP5mpkj+8SjIfdz0WGP/q4qUE
         kpk7X5gThUsrmJ0ntP335lPOJPvgH7PmwKvcL0oCiP0Jx2nw1Gr8lM7CDFasOPCAJbov
         sQoQ==
X-Gm-Message-State: AOJu0YzMytEDnpTAI7/o0UonN6UcsQmr9BXLCYGGoa0PesB2aoYtLFKn
	C4/VSC3QlKlIffmYRWk+tbkO/3Ma/peiQ4OzXBoKtuCSSHj7vuOhUWYVBZ/jfejjt1NPdz1udPj
	xzlkvdQ==
X-Gm-Gg: ASbGncsnZ3UiUIqaeKLQ8GR9efA7Lm2GTLYvVZBwfaynxZXUUC5ZzniFciLcI+W8CAn
	iWnBiGo1+rO+mOhixgdL/WhgR+O3+sl/3sLgVTI5D+8fhoCHnYrcTlqIDCCT75uJBzydkRZn+jG
	idZp7DZxnZ8HjrW/8WaTJNQsWVKgZfzabiZYvP2nTyzZOGjBXR4vXbxLiYjy+vTpLj20FEWPw5U
	jRW2O5R36GIuFqGTocDbm9LcfgDtBM2jy9wB7BDdeIPvqMNGewn3Pjgrk7ryIwAPYOlVLyxC7n8
	nC6KJnzTmYr1r+EndAYiSTU=
X-Google-Smtp-Source: AGHT+IFHH0Hz/Yf8EvRrkbuAKgCdqbbbyTkPViAx7buhpnsBfHPB+Jjb4wcDTSWu2zFrVOLM7VwbZw==
X-Received: by 2002:ad4:5f0a:0:b0:6e6:5efa:4e01 with SMTP id 6a1803df08f44-6e8a0d04565mr23695806d6.20.1740702822704;
        Thu, 27 Feb 2025 16:33:42 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fef5beesm174769085a.32.2025.02.27.16.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:33:42 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.de,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 1/2] bpf: add kfunc for populating cpumask bits
Date: Thu, 27 Feb 2025 19:33:20 -0500
Message-ID: <20250228003321.1409285-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228003321.1409285-1-emil@etsalapatis.com>
References: <20250228003321.1409285-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper kfunc that sets the bitmap of a bpf_cpumask from BPF
memory.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 kernel/bpf/cpumask.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index cfa1c18e3a48..a13839b3595f 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -420,6 +420,26 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
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
+	/* The memory region must be large enough to populate the entire CPU mask. */
+	if (src__sz < BITS_TO_BYTES(nr_cpu_ids))
+		return -EACCES;
+
+	bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
@@ -448,6 +468,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
+BTF_ID_FLAGS(func, bpf_cpumask_fill, KF_RCU)
 BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.47.1


