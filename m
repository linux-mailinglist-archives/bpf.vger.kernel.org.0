Return-Path: <bpf+bounces-53585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679DA56C46
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 16:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0DB1659B6
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EE621CC7E;
	Fri,  7 Mar 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="2kdJmmvC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15521D3F3
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361935; cv=none; b=A9kKmG/PdnY36Whw2KOoUVmqR14Yt7caFVo5RE58IZCjjYNFn/WjqeYSg4zrdkaUjv072HhnTD/3upY+cXXy9JpqlkMPRCC/Ktf+OPszpQ/GT6axRSHz6SKvoDVtqASu4XYNrX1LA3ZHBEHzRCjTaKLKD7vzIjH3ceveDTy2MLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361935; c=relaxed/simple;
	bh=jWOUUt+7DEV91SW9usSGCPHzlJSQ5pKOyZ0xZWq+8ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h//NwJlC/QkD6S+MeD63I7jCb4Ht5UH1ziAp6LQ8iuzaFhg+aTqluGXeNVAuaPJZlNoHEgzNZF4QElqKKxVsDjNzacVBxFkPvGfJsKBI8hQ6BPO/pIw4urdXq99dLXWajHj4yIa+P+RW9OUWso8mI9nfU0RJwljwcsLyJs0gs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=2kdJmmvC; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3d9cdb0ccso372703085a.3
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741361932; x=1741966732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOlPAt6QzAtIMcKAdCSiS4FyW9j3OpeK4f/Kfe5aLZ8=;
        b=2kdJmmvClrhrvDsq0g38ORP+8mkWMCOo7c5g3V7P0HfcBuD85/o91rldBKtPOu2iK7
         6EXZ3FazRuisKvkFJPyX/YXCdpra4XfBtH1VImfrEwbkisRUGUMGIvbLHWhKHoGnQeXV
         41Md48A0uA1qVeDYv5jnNZEDVlPrqGalbON5agCQKsKMsrc/6cKzidjb5RaPafZGGDi+
         yg8eNYCi3M+D/0QpYFq0uch7jYqedDByzic1u/15+3I0VorVkK6V9bkYf3yJstWftj0S
         UIRvYtuRBFvtsdQWymAwM6dFasRFhiRWnJUJnkUdC8+NjOKcW7G7WwNZIA//5B/qkc2H
         UKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361932; x=1741966732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOlPAt6QzAtIMcKAdCSiS4FyW9j3OpeK4f/Kfe5aLZ8=;
        b=nCixtkSSOelwZZxtIo6HqG3VJw0vOVUZPbBxV0iTZEDi+kUloMm0elfpAVxMjHcLaR
         GVRXB8aPeaAyC6FADsjyk7EAwNKYJlanLTm6JRsGZ/bJMad2qolwglLFUnPzpoZT6nYJ
         e2Mbduyc1hc6DoYFRiZUaobsFQJ+o7b09AeuEQpyxGCbE3SD5JloNCYuJMPOLhAV3sIV
         EhF3q1Lk/nWLrwvwpIoV8XqG0C3/wC3Gn9KOXH3+W/8e+b435FVDK+2J9UCTXVWnesdo
         opgyWRSMsvsiikA3nnx1BGZw2rIlbIPkjhwCfMX+7TGhcfSEp2PhlRDyUZOrg9GubOJD
         HbGA==
X-Gm-Message-State: AOJu0Ywzxch2Akb3mlsQzHrmdfc+L8QIZUVLrN0R5gzAPqw5gM0qdL4m
	jEg6GUY38jt/pXZxEpCQuYi+EBeS6SLNenRN0S9yWLeaUOMdKu89f+2hHMZVZMJyWb6oPWw86/1
	P2bE7zw==
X-Gm-Gg: ASbGnct/av9U6G+bPR6JB3mhE+BgN6i9zQ0SdF3FBo0ZScvPoxTthdF63xU8L2h/RT4
	NmJuWdqi2uaNMV83V52ICxv1eu+OjfeuWQFsCmf9/HqcsUAuX+Uk0yDG9A/rTCI4gfs7gKgGWQ/
	0nP0Mry70FQVVSZ8ZlHMD9NdE9aw2JBubzEIWaNV5MS/JtdFyig/WL+1tRUV7JxjqazXiWDjEeE
	JQCgmpiaAX7Ki97/jPxCDedCtk+zYXD0Ij05AcX8WyoVEL7QgmAlEqjLXSeB5iyjvZAk9ntklBP
	weWPg6lb5o/PRxR/4Wv2FcdZDXbTiG64qYtCaddkvQ==
X-Google-Smtp-Source: AGHT+IFeRUSRXYHQo7jbSwV99tpBfQpe5sZKFGhY7vWuDudGhzYfzTSkDHIoYMKFrqGeLKI2l42LPA==
X-Received: by 2002:a05:620a:4393:b0:7c0:b76a:51de with SMTP id af79cd13be357-7c4e61eba80mr601954685a.51.1741361932422;
        Fri, 07 Mar 2025 07:38:52 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511c63sm253828585a.113.2025.03.07.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:38:52 -0800 (PST)
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
Subject: [PATCH v6 1/4] bpf: add kfunc for populating cpumask bits
Date: Fri,  7 Mar 2025 10:38:44 -0500
Message-ID: <20250307153847.8530-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307153847.8530-1-emil@etsalapatis.com>
References: <20250307153847.8530-1-emil@etsalapatis.com>
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


