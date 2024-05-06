Return-Path: <bpf+bounces-28650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25998BC63E
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 05:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8801728239A
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 03:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBF443ABC;
	Mon,  6 May 2024 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtNzA8dS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F93D967
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714966522; cv=none; b=ocRusaIRDJyklQlG9QbZqYl2lrUYDJge2gGjgp4lKZD9yaoNMK/9kWlIgPYh5oC8YY1LYecvepyu0wBaEUoxMnPJR8120vHczIBWfJQsdG4PhnCVFUZ6qYSoNWwuzpto2W2w3PAX1IiiEGnRKCcgpEqpgctDlAwetbcGGhJOjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714966522; c=relaxed/simple;
	bh=8JgLxe4FF8VWT99yRlmwEFdp1bakUQNZOmlV2krhXs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKFap2L1vzz/m0mM7I7NJyPVd39rjEUvdXM5wfr1wbZCidVf3RZ5F7UscC2C7CSuFwp9jVsXem66AebGL5SV6tGEt4xMzT2f9Gig7KbHL+TYuk3AYBK9eyQphrxuVYWRlsGk7KkF6Pj2wV7EidSsr//qDvFJJ5OfJ1lfDOJMK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtNzA8dS; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c963880aecso452338b6e.3
        for <bpf@vger.kernel.org>; Sun, 05 May 2024 20:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714966519; x=1715571319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7s/xylKbOObjev5dMW3NX3FOGC2ODYCJIgRjU7bz/4=;
        b=YtNzA8dS7xffzEb8LE4wNuPTgqfpsHhtHmoU2fFNBlTmRMEclC+2dvkA8mWD5xMA5u
         h1fI82Mh/YAwIq3RjsUxCREL2qLhmlZ7tDial1skO86sXJTUzVG2wITMhu83Ec/wHX6y
         GNkeZQJLPVoYQ8tuvCApxMAJ5DmId9uO0v0qjkwqPoadLVjaqhyM90wxwi0TFbAEyKqo
         NRZwLe/fxHi41uk5Y41eg7XkBi5qH7uG0ppx75jaYFRnP/D32q8c5MpKC5c+j4w6rukK
         zdQIdOp24GtNbCCwJjJibn2UcJN3LOaU44yaINm6qHKOmWay5itx2hEqPPkKq6O93WRB
         WHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714966519; x=1715571319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7s/xylKbOObjev5dMW3NX3FOGC2ODYCJIgRjU7bz/4=;
        b=qc+dVRFxjQiSKR0B228iPEgT/lCrFApjaLrNrqOyhlzMPcCB/Gd7w/nMQA0vJX3f+s
         UJ7Dxb2Dn5f1HNdSEqcPRLGZOGSHexx13Vh9WDM3GobVVoq4mYHZbxrh7oKbVzJb9sGq
         2CoqRDRDYQ7f06FBHNIxwLt0460XZ/6ijmgEC2xUIrxnW/uPUYUSx1jdIUujWEra3KN9
         cS/JcmvEFGapax01AQmLEtm6juQ6RjbMeGwk+nbTGihROkNy2l+U3vgAl/NnSF4ZVLbo
         8WC2XG1V+ecMu1NRqeQBT4hXyGst3c0t2rUo5ZuWH6MaFAG7zgrwQUas/xksa8PPxWCf
         1RtA==
X-Gm-Message-State: AOJu0YyjkOsjRWYBvoGDMFgHf+MCx4zGfB5wVJ8mbvNJM981h1zqvPWa
	goqKpegCUGOTQjDJ7bRrDSSUpX9ePCy343j+PyZ3rMmiaJ8M8SfL
X-Google-Smtp-Source: AGHT+IF+++HjCE+qYLcoq16PymHpq22f+xVuXptc2Vb8KQ5uISbNP8XqN1dgmjRKk8UmG8AE07CaBw==
X-Received: by 2002:a05:6808:4d3:b0:3c9:70eb:151b with SMTP id a19-20020a05680804d300b003c970eb151bmr572358oie.59.1714966519562;
        Sun, 05 May 2024 20:35:19 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.178])
        by smtp.gmail.com with ESMTPSA id g9-20020aa79dc9000000b006f33c0aee44sm6897539pfq.91.2024.05.05.20.35.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2024 20:35:19 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 1/2] bpf: Add bits iterator
Date: Mon,  6 May 2024 11:33:52 +0800
Message-Id: <20240506033353.28505-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240506033353.28505-1-laoar.shao@gmail.com>
References: <20240506033353.28505-1-laoar.shao@gmail.com>
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
 kernel/bpf/helpers.c | 140 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2a69a9a36c0f..83b2a02f795f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2744,6 +2744,143 @@ __bpf_kfunc void bpf_preempt_enable(void)
 	preempt_enable();
 }
 
+struct bpf_iter_bits {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_bits_kern {
+	union {
+		unsigned long *bits;
+		unsigned long bits_copy;
+	};
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
+	u32 words = BITS_TO_LONGS(nr_bits);
+	u32 size = BITS_TO_BYTES(nr_bits);
+	u32 left, offset;
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
+	kit->nr_bits = 0;
+	kit->bits_copy = 0;
+	/* Optimization for u64/u32 mask */
+	if (nr_bits <= 64) {
+		/* For big-endian, we must calculate the offset */
+		offset = IS_ENABLED(CONFIG_S390) ? sizeof(u64) - size : 0;
+
+		err = bpf_probe_read_kernel_common(((char *)&kit->bits_copy) + offset,
+						   size, unsafe_ptr__ign);
+		if (err)
+			return -EFAULT;
+
+		kit->nr_bits = nr_bits;
+		kit->bit = -1;
+		return 0;
+	}
+
+	/* Fallback to memalloc */
+	kit->bits = bpf_mem_alloc(&bpf_global_ma, size);
+	if (!kit->bits)
+		return -ENOMEM;
+
+	err = bpf_probe_read_kernel_common(kit->bits, words * sizeof(u64), unsafe_ptr__ign);
+	if (err) {
+		bpf_mem_free(&bpf_global_ma, kit->bits);
+		return err;
+	}
+
+	/* long-aligned */
+	left = size & (sizeof(u64) - 1);
+	if (!left)
+		goto out;
+
+	offset = IS_ENABLED(CONFIG_S390) ? sizeof(u64) - left : 0;
+	err = bpf_probe_read_kernel_common((char *)(kit->bits + words - 1) + offset, left,
+					   unsafe_ptr__ign + (words - 1) * sizeof(u64));
+	if (err) {
+		bpf_mem_free(&bpf_global_ma, kit->bits);
+		return err;
+	}
+
+out:
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
+	u32 nr_bits = kit->nr_bits;
+	const unsigned long *bits;
+	int bit;
+
+	if (nr_bits == 0)
+		return NULL;
+
+	bits = nr_bits <= 64 ? &kit->bits_copy : kit->bits;
+	bit = find_next_bit(bits, nr_bits, kit->bit + 1);
+	if (bit >= nr_bits) {
+		kit->nr_bits = 0;
+		return NULL;
+	}
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
+	if (kit->nr_bits <= 64)
+		return;
+	bpf_mem_free(&bpf_global_ma, kit->bits);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -2826,6 +2963,9 @@ BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
 BTF_ID_FLAGS(func, bpf_wq_start)
 BTF_ID_FLAGS(func, bpf_preempt_disable)
 BTF_ID_FLAGS(func, bpf_preempt_enable)
+BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.30.1 (Apple Git-130)


