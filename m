Return-Path: <bpf+bounces-22229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374D38596B6
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 12:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5754C1C20AE0
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 11:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B907A6313A;
	Sun, 18 Feb 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU9qfU+M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDE2D781
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708256932; cv=none; b=nVV+a4xK38r0tPmS4OmxY/5Ttus3hVIpR2tP40XiPlrnAtl6ETNSz1/8niytzBmhVvFI9T3yYvajqCNffPZxyfrX4VuRJg7ibxomQdoVHew8UHaAGepttXp075+63Iq9Ravj/J3PqL+C9a3j0VIdQ1XsiibbNzjDgzFQQmkl4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708256932; c=relaxed/simple;
	bh=nChb07pOeK3EsX4BcusRj+XZ0FIXGLVJzOik27zHZLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKkRgP7kpFFxs1tHGlK+pubEelzMky7e3wRNd8hF7i2GSaArWrCO1LNjWlVCUXQQ1xjTHg/WMj4otAFBKP8DzEXOiPMEjmC2QPNUdIwFJOgyjOsuVEqkCvJrcZph9omHqOvQ0cldC85ybkuCLhbLYWW1HjkXWaX7O2Sqev9ZEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU9qfU+M; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c033809f4bso1680164b6e.2
        for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 03:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708256930; x=1708861730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ9hOlFaZS0Phz9aoHEeng0yjo+m6s3+02Ag/Yo2l5M=;
        b=GU9qfU+MhC0T3p/QctnHZWY8HP+8eh470lH8fOxvyQECxesVhpkeiItHQsRiNJvmhF
         yE0S5/TRTlHFMmb/guir3TuHkITRTu4TMZOw2jPy8hykUn0kknJ/PuomUf98drPmunS6
         SRbDiS+TkaATvV5oHbwNooxHSDQhuPm0M6m7cEkZtl27R2OFKqgkZnXMHCauZ6REjMVX
         pmHeng/qkmKsGgpL5Mzs+CW/59XTWyeN534GHBvlVH+Fy70bU0RPRRcwC3P1mg1g2InX
         5QPXyXaf/lxPl0XxvR01DXXlCIe74NQFRL3doXYVYyO5n94TAro/DZ41jHdmdTvmS4mt
         KCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708256930; x=1708861730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ9hOlFaZS0Phz9aoHEeng0yjo+m6s3+02Ag/Yo2l5M=;
        b=fO8yJYPQReOOqxr205vdW1iJMwPL0bLb8psqNaxLeS7sh0GXwnpTAOHiGRPFX81RkY
         haFnf+FpetZ9fM2qCPUmY9ZL+0aAWuSAt5ygOBK/tj0Cv4CGDsPPaXGqIE+1/FrFSFWs
         3T6aL40ebbMU/GCv5MAcnjefUkXgBDN7vcRWQsBFcEW1LyTxsnsIgfdcRCziz0AKKy78
         rGu935WUPsRBscKfUroitbDGd3WrjvsfYjk9sQnDOdVJO3mx3HAntC42BQBjvLg1cwzZ
         GQEepQ8thnx4PTcArudh65XE6wi4U0X3VJTOFpKVzVSl7XNPWfWa0zZl7NJ4BTcsmFM/
         IT8g==
X-Gm-Message-State: AOJu0YzsjJVR53ZZWQcXQOG/kBK4Vafm3wHqFX/3H/R+pnl7EaYmk+Dt
	bOD32hTqWy8gNOu4FX22r7pac0pOcxwSKduKCgczSm1N78kqYWHu
X-Google-Smtp-Source: AGHT+IEHL2NnG7Y0rcxCWiwdBNzXQa9dljcVOv7f78fEnY3DeLTH3RfwS2XazP93Z1Ip3htOADAzew==
X-Received: by 2002:a05:6808:656:b0:3c0:a25:bb4e with SMTP id z22-20020a056808065600b003c00a25bb4emr9475728oih.35.1708256929789;
        Sun, 18 Feb 2024 03:48:49 -0800 (PST)
Received: from localhost.localdomain ([39.144.106.222])
        by smtp.gmail.com with ESMTPSA id 203-20020a6302d4000000b005dc832ed816sm2857551pgc.59.2024.02.18.03.48.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Feb 2024 03:48:49 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Add bits iterator
Date: Sun, 18 Feb 2024 19:48:17 +0800
Message-Id: <20240218114818.13585-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240218114818.13585-1-laoar.shao@gmail.com>
References: <20240218114818.13585-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three new kfuncs for the bits iterator:
- bpf_iter_bits_new
  Initialize a new bits iterator for a given memory area. Due to the
  limitation of bpf memalloc, the max number of bits that can be iterated
  over is limited to (4096 * 8).
- bpf_iter_bits_next
  Get the next bit in a bpf_iter_bits
- bpf_iter_bits_destroy
  Destroy a bpf_iter_bits

The bits iterator facilitates the iteration of the bits of a memory area,
such as cpumask. It can be used in any context and on any address.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/helpers.c | 100 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 93edf730d288..052f63891834 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2542,6 +2542,103 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
+struct bpf_iter_bits {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_bits_kern {
+	unsigned long *bits;
+	u32 nr_bits;
+	int bit;
+} __aligned(8);
+
+/**
+ * bpf_iter_bits_new() - Initialize a new bits iterator for a given memory area
+ * @it: The new bpf_iter_bits to be created
+ * @unsafe_ptr__ign: A ponter pointing to a memory area to be iterated over
+ * @nr_bits: The number of bits to be iterated over. Due to the limitation of
+ * memalloc, it can't greater than (4096 * 8).
+ *
+ * This function initializes a new bpf_iter_bits structure for iterating over
+ * a memory area which is specified by the @unsafe_ptr__ign and @nr_bits. It
+ * copy the data of the memory area to the newly created bpf_iter_bits @it for
+ * subsequent iteration operations.
+ *
+ * On success, 0 is returned. On failure, ERR is returned.
+ */
+__bpf_kfunc int
+bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign, u32 nr_bits)
+{
+	struct bpf_iter_bits_kern *kit = (void *)it;
+	u32 size = BITS_TO_BYTES(nr_bits);
+	int err;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) != sizeof(struct bpf_iter_bits));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=
+		     __alignof__(struct bpf_iter_bits));
+
+	if (!unsafe_ptr__ign || !nr_bits) {
+		kit->bits = NULL;
+		return -EINVAL;
+	}
+
+	kit->bits = bpf_mem_alloc(&bpf_global_ma, size);
+	if (!kit->bits)
+		return -ENOMEM;
+
+	err = bpf_probe_read_kernel_common(kit->bits, size, unsafe_ptr__ign);
+	if (err) {
+		bpf_mem_free(&bpf_global_ma, kit->bits);
+		kit->bits = NULL;
+		return err;
+	}
+
+	kit->nr_bits = nr_bits;
+	kit->bit = -1;
+	return 0;
+}
+
+/**
+ * bpf_iter_bits_next() - Get the next bit in a bpf_iter_bits
+ * @it: The bpf_iter_bits to be checked
+ *
+ * This function returns a pointer to a number representing the value of the
+ * next bit in the bits.
+ *
+ * If there are no further bit available, it returns NULL.
+ */
+__bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
+{
+	struct bpf_iter_bits_kern *kit = (void *)it;
+	const unsigned long *bits = kit->bits;
+	int bit;
+
+	if (!bits)
+		return NULL;
+
+	bit = find_next_bit(bits, kit->nr_bits, kit->bit + 1);
+	if (bit >= kit->nr_bits)
+		return NULL;
+
+	kit->bit = bit;
+	return &kit->bit;
+}
+
+/**
+ * bpf_iter_bits_destroy() - Destroy a bpf_iter_bits
+ * @it: The bpf_iter_bits to be destroyed
+ *
+ * Destroy the resource associated with the bpf_iter_bits.
+ */
+__bpf_kfunc void bpf_iter_bits_destroy(struct bpf_iter_bits *it)
+{
+	struct bpf_iter_bits_kern *kit = (void *)it;
+
+	if (!kit->bits)
+		return;
+	bpf_mem_free(&bpf_global_ma, kit->bits);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -2618,6 +2715,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.39.1


