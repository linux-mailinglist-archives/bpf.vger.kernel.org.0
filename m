Return-Path: <bpf+bounces-26522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A68A1554
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 15:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B66D2827C4
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD1214BFB4;
	Thu, 11 Apr 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFZV5mzU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CA22096
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841113; cv=none; b=et2YpHZj7VCJvcCmDEX6MeFcsvny+/I7byeExNM2pn6xDygD5k7PZ/3dvy7hqaaeChEUWXfzAZNb4KJ5gyTr+cjtphLXfmA36VGVvEUmrWMGE/7eBAygZ6Ruwiwf8yaIEP8HXUE/UDMZh7Ln+kQ/tmSTQqE/mcr3f2H0yarfo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841113; c=relaxed/simple;
	bh=8t3+NA1MiqWsEpVia0YVyDjNDaVILi/POD1mn1uddvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DjVK46sqCTP/Oupb3bREaDUiBwoB1VKWt232ioZNrD/9E5Td/NlagM9znWkUrPjJz+0kif2Da+2tmHOXmLuh67rgsBKUdTQOM0FuaPbMpiOD6T05T7Ni/KEOvLXKOA42UJWR3vPWt6lnXEvVTdQ+QPpsVtjehZyW4CRhhC8hTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFZV5mzU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29c14800a7fso5716342a91.2
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712841111; x=1713445911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEPACv/j9gp+llY6g4Uk7YBOEelxc9dqwKnxfycARCk=;
        b=cFZV5mzUrBAQ8Akzf2sJgJptfeF5UNQqSUdY3Mm8dY9u7TRgZ8C6a2GdtzkKxqBS5i
         6nUT9NjPAWSrYDYbWI2ENEhts5xnWb4vjezIkQwo0qZPiVRs53c0WLpWdhXPT64Og+xD
         tfhjCeodtqDxtYkQMk8hgLNEyQrsBx1Vx3w5lR0/UafzuK+xqdaZBhdJYa7WX/i+Sx0w
         p7ht36VH/Lb+bAFnbXj0uc4eT4+SZH2LsdifZXtI4xaMcdTHERmwo6PReJscY1akvkD9
         7CzBJBcbbIk7sSOKgIsOsRFyo5yrYqnthV4Ml8XMjFRJYtgtQx/hH0J8/GoJuhRARL3S
         0NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712841111; x=1713445911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEPACv/j9gp+llY6g4Uk7YBOEelxc9dqwKnxfycARCk=;
        b=S+mKIe+BB/RFcgev+GBc2rD2KaPBVbjS2a6/tP3RALTcBBk9MayMPsu98WitVllRJN
         UeRSHBtxGISSIB7D+Qa2v8FlmDplyERIoQ6AhGaynJpbPwfOH1l1jPIhkTsPTYJhqrUk
         7ZNEsa1T6g/sTZoShjibEByvPcjmKMKAtHtGAbWoo5jhJ4592HczE/bmSrg/+us2f2NP
         RFPtXy6mhZcWIC2AOwi11KTkUrAU0Fm1rY2Ub8JxgOjel3Glun7ed8T9+zHzBD0fM/Jp
         HOezof+h7TuVvBl/le2ug352pFGavDvOTdRr88+KBli4FO7UhwSy5VEGMP6iwWZm1I5Z
         eetQ==
X-Gm-Message-State: AOJu0Yy0jlouG183kzisp2Z3CgCibPutf5DHh0WqyxN4FCDH9/3F10hY
	QsfYaCBPwVc2+vfzzUZUoDMU1AqedOUPU2JXOfcG+1udCFYW8UA1
X-Google-Smtp-Source: AGHT+IEmgpApA1O0i1/hQTKXENtGurP0e0GQaAO5QiTpWOJn32rTW1dNgqr91hmKltkJWmyXlCmaBA==
X-Received: by 2002:a17:90a:4e08:b0:2a5:3399:b703 with SMTP id n8-20020a17090a4e0800b002a53399b703mr5482696pjh.11.1712841111262;
        Thu, 11 Apr 2024 06:11:51 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.192])
        by smtp.gmail.com with ESMTPSA id e10-20020a63aa0a000000b005dc5129ba9dsm1047654pgf.72.2024.04.11.06.11.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2024 06:11:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 1/2] bpf: Add bits iterator
Date: Thu, 11 Apr 2024 21:11:26 +0800
Message-Id: <20240411131127.73098-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240411131127.73098-1-laoar.shao@gmail.com>
References: <20240411131127.73098-1-laoar.shao@gmail.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/helpers.c | 120 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8cde717137bd..421e42663736 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2549,6 +2549,123 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
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
+	u32 size = BITS_TO_LONGS(nr_bits) * sizeof(unsigned long);
+	struct bpf_iter_bits_kern *kit = (void *)it;
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
+		err = bpf_probe_read_kernel_common(&kit->bits_copy, size, unsafe_ptr__ign);
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
+	err = bpf_probe_read_kernel_common(kit->bits, size, unsafe_ptr__ign);
+	if (err) {
+		bpf_mem_free(&bpf_global_ma, kit->bits);
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
@@ -2626,6 +2743,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
+BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.39.1


