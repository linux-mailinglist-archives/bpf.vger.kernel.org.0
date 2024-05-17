Return-Path: <bpf+bounces-29902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0DC8C7FE7
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 04:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E1A1C2161B
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789EC8BEA;
	Fri, 17 May 2024 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSGMClTK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F828E6
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913060; cv=none; b=L3dl5wD/qV+t82rF/JkgOmaXPqykIMtQJMc032FJseH0GsZlBM45DaP49K5ygu5lzTPUd7yiWAl32FhVR89PnOXz+Yqacg6ULRionwcYhP9chE/0K+ZEUvunzfogbDvZqCMML/DTOHaLzoCuYMaP13Z1fRTIbbhuM2IiL/g+4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913060; c=relaxed/simple;
	bh=92aLiGf8kfdkM9vyJa7g6puXjUmQZ16F0PBTLI1kc2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mwQs/Nx4vEJT5wakbcDCcUNT3U7gxjQjIC6DnmeAjGXnrD9dPy7KFmWyNlcWwCUvySwY4bki+EkIJwCqDDr/KFU7rgYUA+KqbtAtsK+VOchr08UNmJI3gC5aTISoV+rN+3LK3BeRoa/kL7HB1JJz4DFSAAt0YNHQLnPm5kq21lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSGMClTK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f0537e39b3so1398605ad.3
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 19:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715913058; x=1716517858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL3n2lS1VAj94pwEXtzwpu5PuKucbyOD6le6sxUaYlg=;
        b=nSGMClTKgfxV2jCVWWcpnQXvasln0S82g0EBKgPr3Pjg931xrBIzg4enZ4Czf0HFG8
         PXc8Z07/E3K5U34fqF8TvS0WMqYm+wdNwGnzXWGHNmbPidX4yrJ+9YzCdWbn1vEIE/ZZ
         KZBfNoFgV2pKGivwr4pBfkAWMbdZ4O3S6dUhown1fzrN1HwJR5cUwr8azicaqJvLIeU3
         BFSoJKp+lWYTvAvZVS65f/xHrI7D4OUi8EQFQutfSfFGaeTkw+NdOdODsD3+4FpKclUM
         d6KuKthT/SxS/l4gbXmeAU0dytVGr3zyfL4gtT+wzzDx8zKcUWKrVPVFbx+sqt3LEkRp
         7zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715913058; x=1716517858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL3n2lS1VAj94pwEXtzwpu5PuKucbyOD6le6sxUaYlg=;
        b=KxvzHCOwfFFK20ptZt9JrKAcr98WivZHQGKI0bf6peaum2NYnIB4pyap4NJ5S8Mk1/
         WHPjItBCh1nsVdR1bGffodyVpMnc11y9OC1hI73M6evPWM/73SpckUiB0ossxRUd2EbS
         S5rGAaeg7HZZZyv3OV+dd0TyL//UGqPFuzys3F/oIBbgcNlCnnoVuQS+jBs89BWQLjkk
         Mpp6LFS4hdvzyLWnuN5LHgMc3SIxcGT7ssZSmKNkhwGqrFubNczrrWcSJLvPoOJnPTy4
         mOikVvE1Cm07bDRlR86lqa7NEhfIErNlIwrhXY9tte1dcABLcd5cngNGFc2kN+QE785H
         Buyg==
X-Gm-Message-State: AOJu0YwnpxFqpwpbh/yvp0l86V3XsjS1DIcKgF4Tqpu7zTR7KTHM3iL1
	ItxBVlt3hkWW3SNnfFutL4WwkQBGMukmYHgdzah5q+idRNk6EMUT
X-Google-Smtp-Source: AGHT+IHyjKpODi4bcVbVxRlZQ558bTxcomipxAIgPxNCSGymLH5QuJlIkl7enX8GOrnhPT616wh04Q==
X-Received: by 2002:a17:902:dacf:b0:1ec:c9e0:c749 with SMTP id d9443c01a7336-1ef440505a0mr245001125ad.48.1715913057877;
        Thu, 16 May 2024 19:30:57 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f093824c4dsm41361395ad.282.2024.05.16.19.30.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2024 19:30:57 -0700 (PDT)
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
Subject: [PATCH v8 bpf-next 1/2] bpf: Add bits iterator
Date: Fri, 17 May 2024 10:30:33 +0800
Message-Id: <20240517023034.48138-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240517023034.48138-1-laoar.shao@gmail.com>
References: <20240517023034.48138-1-laoar.shao@gmail.com>
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
  limitation of bpf memalloc, the max number of words (8-byte units) that
  can be iterated over is limited to (4096 / 8).
- bpf_iter_bits_next
  Get the next bit in a bpf_iter_bits
- bpf_iter_bits_destroy
  Destroy a bpf_iter_bits

The bits iterator facilitates the iteration of the bits of a memory area,
such as cpumask. It can be used in any context and on any address.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/helpers.c | 119 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2a69a9a36c0f..6f1abcb4b084 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2744,6 +2744,122 @@ __bpf_kfunc void bpf_preempt_enable(void)
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
+ * @unsafe_ptr__ign: A pointer pointing to a memory area to be iterated over
+ * @nr_words: The size of the specified memory area, measured in 8-byte units.
+ * Due to the limitation of memalloc, it can't be greater than 512.
+ *
+ * This function initializes a new bpf_iter_bits structure for iterating over
+ * a memory area which is specified by the @unsafe_ptr__ign and @nr_words. It
+ * copies the data of the memory area to the newly created bpf_iter_bits @it for
+ * subsequent iteration operations.
+ *
+ * On success, 0 is returned. On failure, ERR is returned.
+ */
+__bpf_kfunc int
+bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_words)
+{
+	struct bpf_iter_bits_kern *kit = (void *)it;
+	u32 nr_bytes = nr_words * sizeof(u64);
+	u32 nr_bits = BYTES_TO_BITS(nr_bytes);
+	int err;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) != sizeof(struct bpf_iter_bits));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=
+		     __alignof__(struct bpf_iter_bits));
+
+	kit->nr_bits = 0;
+	kit->bits_copy = 0;
+	kit->bit = -1;
+
+	if (!unsafe_ptr__ign || !nr_words)
+		return -EINVAL;
+
+	/* Optimization for u64 mask */
+	if (nr_bits == 64) {
+		err = bpf_probe_read_kernel_common(&kit->bits_copy, nr_bytes, unsafe_ptr__ign);
+		if (err)
+			return -EFAULT;
+
+		kit->nr_bits = nr_bits;
+		return 0;
+	}
+
+	/* Fallback to memalloc */
+	kit->bits = bpf_mem_alloc(&bpf_global_ma, nr_bytes);
+	if (!kit->bits)
+		return -ENOMEM;
+
+	err = bpf_probe_read_kernel_common(kit->bits, nr_bytes, unsafe_ptr__ign);
+	if (err) {
+		bpf_mem_free(&bpf_global_ma, kit->bits);
+		return err;
+	}
+
+	kit->nr_bits = nr_bits;
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
+ * If there are no further bits available, it returns NULL.
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
+	bits = nr_bits == 64 ? &kit->bits_copy : kit->bits;
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
@@ -2826,6 +2942,9 @@ BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
 BTF_ID_FLAGS(func, bpf_wq_start)
 BTF_ID_FLAGS(func, bpf_preempt_disable)
 BTF_ID_FLAGS(func, bpf_preempt_enable)
+BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.39.1


