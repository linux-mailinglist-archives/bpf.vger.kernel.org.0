Return-Path: <bpf+bounces-55876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B7A88848
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1539D174901
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105062820AF;
	Mon, 14 Apr 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfw7dkOA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626027FD75
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647296; cv=none; b=EefeXmcfZY5B9iCm4iSXjQDLFZgapS44coz+ZvFzsERAAvMngsSYhAZY6c8b5UfROBiSUOgL9cNklDOS78CtjVbS8NvmVoYL/jwReE/9e8YLNeqZou37EL6vdtgyI0nEvZZTLpfnejcFUlWmib703BrXYjntEuvFyj/Mk9N5iMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647296; c=relaxed/simple;
	bh=JD5q9vfOrpgQmYODS7ZBmHE1gP1l1BBtVlbIaIw/wy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIK7e33r5RIRd93TY5p7ZLJeDWA58LsOtM1pKnoDgIdSATo85dyFb2QSpXgcVmm8uUGbVWrdRlA9NLIdQqhH8h1tA/b6UKGQ1LBoj4M3DaB0/QR8BtJeiCZX2MjJZxx8zwabzzlKHXHTwitH1ZFsPSgT8H5Jue33MqodmX3pwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfw7dkOA; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43d0782d787so32612445e9.0
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647293; x=1745252093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6Q1f0ARyVLlIWFFPfKeT9Xpp+1lPyuPBV3IFiXPr9I=;
        b=kfw7dkOAimOU3tTelDMZOW+yzLUQdwYQiJNfxTiwV4AIppYL1EdSNfMgVBSIb6jNXd
         pdf4kbCS/PxMkAErtEvRfTlgm6iOt2G6VqZ/FkDMOG/dUTkkYumpznRra6Rb+AXvVMPH
         9x6+nn92tk8dKzFFjQsleicPg8pf4UCFon6cOWW74+cxEruTARKLHXJ1ABkFpBJW+VV8
         NP74jRrBdSGgRiS78vPj8AzIhtcuBiXZqudaISGsnMoFLZnqoreBelxSwYmgX7oS91vu
         jmYKU4+T2TguNu70bPNVbTjooV+ozUtJT0xNgqxmCZ1IEN7PZjU54LYENXN67wCDk/Ng
         E8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647293; x=1745252093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6Q1f0ARyVLlIWFFPfKeT9Xpp+1lPyuPBV3IFiXPr9I=;
        b=j+Cok7ujTSJ2RoTwPwByChIff4/EVUTXIisc8PZ326i22ohv3HAk2uAYGWnSuR5nKc
         Ot208W9jwYpIT1F5xWPWEoUA/FShL04l5NbEaYO127KngOt3d0eXnmRzVeVVvQh05CNS
         5CtyZnCurOCWPEIynm3xZXp9qVM0/OV2Y5vr6YVN/3s/dHjcvwhUAN0augVfdR8/p6Rw
         W3rw1LWcoFHDUWaEUV4Ps2RCsIcaewV6EaWzf1L0lT+5SMvZmF2mt4vbqiZ/sYvvHIeQ
         TT7c8UEoR9ez/TcsUg47H4DoeXzt9FIySkg1tacmg+txqRZdzFHVMpYq0jgVtl6HRfRx
         xKgw==
X-Gm-Message-State: AOJu0YzrFnKE+bg2bai9LnubQ7wK8Z/zwL1uCtFs3MmIVFuQI24L4XMC
	v+G0eVMXAIo/fYkXaSxf3Mb0HKRDQo8Z1jwl3wXd0COOhwJOHI5ZaBEOzBYHp8I=
X-Gm-Gg: ASbGncs621yVG7+lEcr2naY0BdSFZ6pPMYiBnmKfzVi7YV1Kg4vwyHEfoB+RuAdutnS
	liRyW3FlXDD+EBnmm0BdX9zz3LoeDCYMT01XPO3LDG229HS5vL4ky+vx0R6/TZ32GBiIzg7fC/8
	Svu7LUNlYa2Bw5+PHjYrK1hn2LaYyJ0XC5q6eIMzZzygA/WYenqPCIdiRLVMnjg9Uqbp3nJeeb3
	g84yOglAc/PcLfkxD/m5JwKtD0Y4lRPauZTy7N1ya0wqOy3IeOAQoFmJIcxq5ZybLpVJ4zmGldd
	R2Zfsn5MEUE+e06PmVlwjjjrWHh2ZA==
X-Google-Smtp-Source: AGHT+IE0Oxl9MHFn3jhgpg9LARaWHHUW4E5Pwg56DUJrtD5wI4UtM8c2YAFDhnECEa+OyiI3uCJ6XQ==
X-Received: by 2002:a05:600c:83c6:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-43f3a7db13dmr127139435e9.0.1744647292713;
        Mon, 14 Apr 2025 09:14:52 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:6::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c8224sm178984555e9.22.2025.04.14.09.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 06/13] bpf: Introduce bpf_dynptr_from_mem_slice
Date: Mon, 14 Apr 2025 09:14:36 -0700
Message-ID: <20250414161443.1146103-7-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3796; h=from:subject; bh=JD5q9vfOrpgQmYODS7ZBmHE1gP1l1BBtVlbIaIw/wy4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOJHbB5Wcy2aRUy6PAsQeAkR8Ytj2xBxmZ0rUBl frJO5MCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0ziQAKCRBM4MiGSL8RymA6D/ 9yDzx7jQvWCctwaV8feEQKkuhLQRrd85NoRYinIegoRiS6wTwivxH6vsR+uelGh2Z0FhX4CEn18aLC p/oZqazyBw1gzS3oNjU3x5YD5j0h6dUSERAbYehfYeMdmLBBY4AlQouVCcUGOm/97sa+dGHU1tU4YM 4zAiVUORkeCI4/G1FNgxvX7GsrdkR2ErY9MsAX4FPX0BB4dOnJjJS8JBmWSe1Z8ziMZ1FDh9/iuZwt kOTzwmMagQln51E7Un87i+fm2pNOEF1JBx7CVU3i7uIy4lYPhTy9v1rPbcP+fqDgNxy85bgH5UfFvp YKDCeLtfhOCq3xe50VfEJ59tO6Zn3b7AuUJQBY518YROsLQ4TvHrinbPzdzbzRKxPzts0gW3mEQYMj XMOOGVk//iqCGjL3tVl1dzDn9tDhBNtpx3uJIAU+fMQOb2YFpKEMKi5cJNL0wl82cJe6Yu3ZjSUZ30 hcARemuY5wMqfoIlQVr6Pn868PaCKB/F8g+WMP60zbWOJy2FPLYt9DasN6wdUfj1UVPhvM+eiXniHV 4roK2Dr0eV/jE7tRVwgg+T2CdCLLQtXmy/owKGz/OmffcD1mM5/AT8mwoqzhLT7/yy3UieF0S24eW/ cKJbvdGrx1nvpUsOOZcEjVVWxphNbebRYxIQg/pi59+ObjFw9MWMLUGlI7cQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a new bpf_dynptr_from_mem_slice kfunc to create a dynptr from a
PTR_TO_BTF_ID exposing a variable-length slice of memory, represented by
the new bpf_mem_slice type. This slice is read-only, for a read-write
slice we can expose a distinct type in the future.

We rely on the previous commits ensuring source objects underpinning
dynptr memory are tracked correctly for invalidation to ensure when a
PTR_TO_BTF_ID holding a memory slice goes away, it's corresponding
dynptrs get invalidated.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   |  5 +++++
 kernel/bpf/helpers.c  | 32 ++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  6 +++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622..9feaa9bbf0a4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1344,6 +1344,11 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_XDP,
 };
 
+struct bpf_mem_slice {
+	void *ptr;
+	size_t len;
+};
+
 int bpf_dynptr_check_size(u32 size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..95e9c9df6062 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2826,6 +2826,37 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
 	return 0;
 }
 
+/**
+ * XXX
+ */
+__bpf_kfunc int bpf_dynptr_from_mem_slice(struct bpf_mem_slice *mem_slice, u64 flags, struct bpf_dynptr *dptr__uninit)
+{
+	struct bpf_dynptr_kern *dptr = (struct bpf_dynptr_kern *)dptr__uninit;
+	int err;
+
+	if (!mem_slice)
+		return -EINVAL;
+
+	err = bpf_dynptr_check_size(mem_slice->len);
+	if (err)
+		goto error;
+
+	/* flags is currently unsupported */
+	if (flags) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	bpf_dynptr_init(dptr, mem_slice->ptr, BPF_DYNPTR_TYPE_LOCAL, 0, mem_slice->len);
+	bpf_dynptr_set_rdonly(dptr);
+
+	return 0;
+
+error:
+	bpf_dynptr_set_null(dptr);
+	return err;
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -3275,6 +3306,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_dynptr_copy)
+BTF_ID_FLAGS(func, bpf_dynptr_from_mem_slice, KF_TRUSTED_ARGS)
 #ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7e09c4592038..26aa70cd5734 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12125,6 +12125,7 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_unlock,
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
+	KF_bpf_dynptr_from_mem_slice,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -12218,6 +12219,7 @@ BTF_ID(func, bpf_res_spin_lock)
 BTF_ID(func, bpf_res_spin_unlock)
 BTF_ID(func, bpf_res_spin_lock_irqsave)
 BTF_ID(func, bpf_res_spin_unlock_irqrestore)
+BTF_ID(func, bpf_dynptr_from_mem_slice)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -13139,7 +13141,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 			}
 
-			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
+			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_mem_slice]) {
+				dynptr_arg_type |= DYNPTR_TYPE_LOCAL;
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
-- 
2.47.1


