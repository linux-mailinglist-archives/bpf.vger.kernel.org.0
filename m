Return-Path: <bpf+bounces-22649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDEB8629ED
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 11:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5E6B21230
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296ECF515;
	Sun, 25 Feb 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNEv5+Mm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08FEECC
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708855637; cv=none; b=B4vL6czRbBKWCxYeYFhjw9yDe3+iP/q9LeMp5eW84YpzFmsvqDxbrS+aNIcd+h/lXbn6Y4MXI25UgpURN3F0Ng/VUdVgSn4j7FkjZKJIOlFJqtiprqnSxhOfk9ZkTbXE58mKpcS30PptZ3x2x8R2qqldVl/UZNqMGQyomB6kVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708855637; c=relaxed/simple;
	bh=nChb07pOeK3EsX4BcusRj+XZ0FIXGLVJzOik27zHZLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fB8nEGF8L1GmUYKQ0gO+NvT88i1KYUmlPSdR49grD854AZwELzgGoWK7H0J8Fs0p5QhRexHqf3od/KAlSQzYwdcEosGkwoiQ4QsWz24l5wyDXoINc8CkMvW9GRXoEe8ZopkEgIvyZBxzs2Kz1ydf1rHS7P80jgW/nqmfwLHvyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNEv5+Mm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e4670921a4so1068820b3a.0
        for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 02:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708855635; x=1709460435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ9hOlFaZS0Phz9aoHEeng0yjo+m6s3+02Ag/Yo2l5M=;
        b=YNEv5+MmJM0twr8QYKy99a6x61UuOuIdMaao4XYQgE0UiVFFqkLTb1c3TW9uIweVNw
         rFB2XwUUNCaaXO2NlfPdwfKmiQ30Ga5xVIG2DuNLFcT07MYgjkmwZuqx231vcZTnIGBM
         tTMiKQBcjN0xmfvku8B5JY27mj0/BzoGpx7i5v30WCsOVtqGUzVutqjNbagDt5zpvVPx
         WMzEp1Dp48T3Zh/xNCt8oOjF1kSD0/8RPTOvbSW9FXBosu4+6Gaw63DKR7fEAS5Sdrhg
         su5S0wb29AeYxEt9HBR4vKShJt0vVTVt5knc5VBxwhvXAb4jSYL49M5007g3k44PDChP
         0XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708855635; x=1709460435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ9hOlFaZS0Phz9aoHEeng0yjo+m6s3+02Ag/Yo2l5M=;
        b=UYeSC9cpsnH8xSdyGUO/ZImXHZZtkESsSC+TfIIsV36K6fPoe3fPeZNvzpu5x/OsSR
         tnmWvpbBV3x/i86lfw0S2oV1MR+WgbsWP18Q8rAfPrNeCKBun2CZCKofUmWderE1Fw14
         Y3s4fuAw3d0+qyGhq/h9Wv+Fu3G4UlgHchL3K7bxeNjStYKrKZAM4L72gOI7jW8H8Ja5
         K0kS5eyjB5ZWrd42qCgMYmS3VOXFM359/2+UUHO/yKMHYyyfSoo0bWnbC0ATCx54UmKW
         xfxbA+Rrt1g/IazGgTHuzhibAjwBK/dfBgg3j01upFI6myumJk1Cvm5IqtODQjl1M4P4
         B55Q==
X-Gm-Message-State: AOJu0YxI+nfms0+UgzEaq45SXUY5/10/YE6Voa+Trq1ayA+IQNoNWMK5
	dRSXpkp8vAqFEad35n7SkFHzWNZo1cHOPL1GlAqjGtrAXztFhUBE
X-Google-Smtp-Source: AGHT+IHBcXcx2623M0whrWlzgiI3kQqCI25eENer+Z4CovcjDG3arP6UR+R6uyNsg3naH2Iai93MxA==
X-Received: by 2002:a05:6a00:1798:b0:6e5:dd3:b343 with SMTP id s24-20020a056a00179800b006e50dd3b343mr993035pfg.34.1708855635535;
        Sun, 25 Feb 2024 02:07:15 -0800 (PST)
Received: from localhost.localdomain ([39.144.104.176])
        by smtp.gmail.com with ESMTPSA id f26-20020aa79d9a000000b006e1464e71f9sm2119775pfq.47.2024.02.25.02.07.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2024 02:07:14 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 1/2] bpf: Add bits iterator
Date: Sun, 25 Feb 2024 18:06:36 +0800
Message-Id: <20240225100637.48394-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240225100637.48394-1-laoar.shao@gmail.com>
References: <20240225100637.48394-1-laoar.shao@gmail.com>
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


