Return-Path: <bpf+bounces-66512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86769B35560
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D673163EFB
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC902F83D7;
	Tue, 26 Aug 2025 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufp3fze6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907A2D0629;
	Tue, 26 Aug 2025 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192831; cv=none; b=sc1eifZlne4IrTaI3YjH8S7Inv+RpdZ7CabcJPe9c3sQJaHwPZYLXlpsUbsPN5kmao4LG4EbPDrCc+VQTo5QgaIpvhxM/VTbentxr6xNW/vrTlkwCdhhF2SDFGytMIQM5X+gIzJBnXuoSkc+hTgK3CfmMTjT8qeuJTjs5m4no9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192831; c=relaxed/simple;
	bh=pBmfOQYqR5GoiJGzttL5PWoZxuJCympE4hkWjCt90Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZF/a/paCswIcMATm9iHhog7t8qtDwgfoF8IgS9vRap0qUB7JoNm6JiYvUxKblhodB6dRlgrALd/vRLzLqWBeeshNMu3/QgwntRJ3i+Na4+2IYIBv6cB/PcGkP+dfhMPSYmx8N/TqmmHyucvTislfPErkBXAyER+nEZsSvlqqCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufp3fze6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso1943260b3a.2;
        Tue, 26 Aug 2025 00:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192829; x=1756797629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZyjms1M5tN1pPNdDlz1+TFH0zZdP2UKJkjfIDOKjTc=;
        b=Ufp3fze6C9wZnIw4qQzS0Ndu2WpfPFWNNTIGpxyaI0+cF77Db4OWQ0Pk5gysDd5LfS
         Fl7Gai2lP0tVP5KYMnT3X3GGC/IfIIuE3QtF35wW0YbSHeYyMnYjf34RXiJDia6w/RZ2
         yx8lkS4eXGCAL+MqpJLrZLkLhP7kvR1ntdqbx3ldA+Z8WtwyQeKJdOO70IZzqfXAhPfS
         r5oqN373rMpHu1qhQ35LWKvSfVzkdpFu+ULXPlojC9j0WUdT+mmQZZ6gxDtbmbInpXxe
         4M74ZD5jieRtN5ErOwQGHeyVrhR+eisxcVv3t6ecSBt8jkgDzjOb2X1uYUs2/ZK86zDu
         Go7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192829; x=1756797629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZyjms1M5tN1pPNdDlz1+TFH0zZdP2UKJkjfIDOKjTc=;
        b=MBWuAPQV7fKga/W6HEgBfzWeYLFXuhh/FaqDhR+9RhEFqdxBW04zAGm2TITxFR3Nf7
         HhsXnn+EmeWOzbvNIW/PmWPtzB3vElJsMlv7sNauvExNSNIywt5+rwAgeLiDkA98ygT2
         QP7Jf3+FUuryRErmYwXURZglr3VvHLI8Z8NxZ1dyFbZcWHlYsMKJ5vwcjEkqo28vDCTW
         yg29nsfHgu2TAU/j1rcRJMw+dhRC8PDgbRPT/oFjy8FVq3FHg+VwmUDqTU7QKJtVFHpS
         AVf8Ev3PUUDb70zHtb1Aq2w/bEDkL8hdrSfwsb8PtHOo0p4rKgrjplpCDone54dWEUCU
         n2MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWZtPel4iTqls8nVyNODwotthvfuHijWU570zwTZo59AiUOt7HlxJxi3xWynvZKPv2G5m26JZWW6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkg0/KmZW8yGOn9SHBGGMeHIWvt6EOueJd32mpeL7CsnJeeocR
	SnA/+poAekNoLlhgBZwiXXoRbfjJuOG3XWYSL1TQqNWSEZ32R5o3t8Ta
X-Gm-Gg: ASbGncvxIs+nJ83nGVvWAmz2g1QAQz8lxECmAWm5C1g1XqHA3qKzT91duKm1XO4ezWf
	IYb8+P/rhHNDch3CiCOoqQ5DBlUSPbWHweb0B+gWlJ9eyb1n05E1agEq5Tp/emjpoHXQUR3n/PW
	2IBMqQc1AmIo/Yu/bnMBvviVbWAd+TDlp4tvm6vpIrnHfIuYe0EX1LHYc8euX3+VFgVlE7y2mPC
	kUA5bDrl6FCz6kO6SWq46ZEE+iBuVgRbsQ0WRLiuz6hWxVxMTCpWVFymR6Gy9T30gggjy031qkh
	wvvhVtjm2qXtQ2+OIX4o/YTvg14x0KXImYoqLGcreYztXAbiqm9g+8yacOo05hKWolbpPR1v0gk
	eN+G4YNWYJUvVrXWh7d1o4smTQasoi5TJ4NubaafQ/4z7tQSAQQvbnAcppklswuNys3cBu2mz33
	WvCyaPnJCULOBu/g==
X-Google-Smtp-Source: AGHT+IELeMvTBuFc+TaBjK2AkNjBALICozxBATcJD0661qeFTUzyU9eZrPl2Q2DPfPKQw+cNM5rcmQ==
X-Received: by 2002:a05:6a20:4a27:b0:243:7379:539a with SMTP id adf61e73a8af0-24373798730mr6415010637.12.1756192829094;
        Tue, 26 Aug 2025 00:20:29 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm9686052b3a.75.2025.08.26.00.20.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 00:20:28 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 mm-new 02/10] mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
Date: Tue, 26 Aug 2025 15:19:40 +0800
Message-Id: <20250826071948.2618-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250826071948.2618-1-laoar.shao@gmail.com>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will utilize this new kfunc bpf_mm_get_mem_cgroup() to retrieve the
associated mem_cgroup from the given @mm. The obtained mem_cgroup must
be released by calling bpf_put_mem_cgroup() as a paired operation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/bpf_thp.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
index fbff3b1bb988..b757e8f425fd 100644
--- a/mm/bpf_thp.c
+++ b/mm/bpf_thp.c
@@ -175,10 +175,59 @@ static struct bpf_struct_ops bpf_bpf_thp_ops = {
 	.name = "bpf_thp_ops",
 };
 
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_mm_get_mem_cgroup - Get the memory cgroup associated with a mm_struct.
+ * @mm: The mm_struct to query
+ *
+ * The obtained mem_cgroup must be released by calling bpf_put_mem_cgroup().
+ *
+ * Return: The associated mem_cgroup on success, or NULL on failure. Note that
+ * this function depends on CONFIG_MEMCG being enabled - it will always return
+ * NULL if CONFIG_MEMCG is not configured.
+ */
+__bpf_kfunc struct mem_cgroup *bpf_mm_get_mem_cgroup(struct mm_struct *mm)
+{
+	return get_mem_cgroup_from_mm(mm);
+}
+
+/**
+ * bpf_put_mem_cgroup - Release a memory cgroup obtained from bpf_mm_get_mem_cgroup()
+ * @memcg: The memory cgroup to release
+ */
+__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
+{
+#ifdef CONFIG_MEMCG
+	if (!memcg)
+		return;
+	css_put(&memcg->css);
+#endif
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_thp_ids)
+BTF_ID_FLAGS(func, bpf_mm_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
+BTF_KFUNCS_END(bpf_thp_ids)
+
+static const struct btf_kfunc_id_set bpf_thp_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_thp_ids,
+};
+
 static int __init bpf_thp_ops_init(void)
 {
-	int err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_thp_set);
+	if (err) {
+		pr_err("bpf_thp: Failed to register kfunc sets (%d)\n", err);
+		return err;
+	}
 
+	err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
 	if (err)
 		pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
 	return err;
-- 
2.47.3


