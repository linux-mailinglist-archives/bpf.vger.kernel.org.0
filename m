Return-Path: <bpf+bounces-51856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB9A3A69D
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF77A2DCD
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E31E520D;
	Tue, 18 Feb 2025 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfnhE322"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827251E51FA
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905282; cv=none; b=MMmik3dd0TLDeY8Ndqcr+hivFRaRb43ijFLyhI1XVDWE2SZUnsEVYZR41rcKORseT/DG0kkXA3rpmRhXFqnqhzFBeffmvbNBLOSWcF+GVuFk1fDgKehyBwJE3WqIrsTUd/x+plECu+4lW7xeH47NcRvOZ/nYDbBGUKUfycRoFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905282; c=relaxed/simple;
	bh=/KO58R/FvOp9YExYAtt6OPYUWEo6tpHei1LCLwXioVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6Q2Fdy8n9inrGD5BAUn0AkTFKFzlljP+zzRN/cV3hcCnYCs6xvhxLvWT31sExQXVtcn1vxCfK0YNd6tH0RTMoCjqhTyj4OQgsDkfr/DzbCMFAD3J5xfJzDUo3ows0y1iWkBYVdGvPmm21fKSQokjZWmNZ/oxlqEsTxa5XkUS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfnhE322; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso10803489a12.3
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739905279; x=1740510079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80pbILOgzGHV0Da0sUpN8NRJXtYU0fPH3X9MdbtcP8w=;
        b=CfnhE322dASjp10tnuvHLlHv8u5DqzOX3R9NQ6iNYh9O/Zk7unHgsIBOX7KGPK9e3V
         lkodbD5BrihhVk8yVO6cZANYqyKkdaIDU8eH5avyiOZ/kB8PakLs48Is9pjNjbTShCMn
         EeebLo2VGV6UUN14tKhRXpsR8BsLOa0Kepu1uhKhtzLoXyPxuYHJN5paChFsR80l8tGg
         a8N789LppYQknvqApRey/Hk7rDIbDfmZClT2egQs085YzUOH3VtN9E1WkfDWkbouWbTa
         X4wqRBsYXcj+zinIACdJt/ZXNmEDVWeHblYcp/ixar2CVR+ljbYQRWaKsdkYzcCmAp+/
         +2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905279; x=1740510079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80pbILOgzGHV0Da0sUpN8NRJXtYU0fPH3X9MdbtcP8w=;
        b=IbdEuLv3xfFpkH4R0wZCi+IQB07PkeHd0WacwdLOOzY611qvjR3c65VkHL9j8SRQXd
         Xk2o2AH1zbRkbXt9BehCrXG2g5QrwdM/C3P/fhQfPBFpHdC5T8k9/1dnWMrx/O4kk7SP
         gNNEtoa/PL2EHEU8BPnXnZgXlY3WNxYFnMgM9kmJTvGK64cxJGZwuDW0/D6ENaYSaQV2
         +g+3lB/FcUguNJrt7bX1JNGGiZn+bvbnCJQSjMSG2GzcKtr3TikwMDEXXOZvYRYLPiUk
         HcDeZLXkCSCY3W9VFvGCPqMdj8/D3SUbtxdiofWV+PdBxAfcXDmQFgOFA2MGh0DzQzBS
         zZKw==
X-Gm-Message-State: AOJu0YwoBB7LNtIbuGm3h8gO5EtT5vB1SyJmKVBCEzULqbkomL6XifYM
	LQy4V4HuBnARWeU8HrpNliTld4hsM20plnvpOVAmhBl5MV2NO9zkU+x1Yg==
X-Gm-Gg: ASbGncsng+G9QjRWmRsZw05LSXO9/iFbB1nXmsfPGykYaHBUexw4jmZtAPTTnJwdaqS
	cCPTD3tDMmYt0KgXEbbFeGQ9HwX9RYFBSjgHBiQlQFAqx+dp1nS5nUkzH2CpSpTCTHRt/IjEGI9
	nCH2zNwKcUtwL7K0IIFqt0uloFJTy7OPbg7VXpkZE1rsqd2p0KqlYP3u1MlAuTHfMDkSUAJzxwR
	fRcop2DnosAXHuHG4Vee/GTitlj0pJuGikt1DXB1G67yr/rW3ESN9aRXfiLQCFlQRftssTClW3v
	+k4xDilZ7N9BXpHCKSPtwX1ZBt9FYw==
X-Google-Smtp-Source: AGHT+IExHUCJyVzfct4PFKkWp6VB5P7e7PmKmTROmp7T2iKYeZqClC6ZVW6NlmLkaSESCwqn4R0p3A==
X-Received: by 2002:a05:6402:3589:b0:5e0:82a0:50d9 with SMTP id 4fb4d7f45d1cf-5e082a0580dmr1527858a12.25.1739905278477;
        Tue, 18 Feb 2025 11:01:18 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::4:4cdf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e02ebeaaa1sm6248540a12.5.2025.02.18.11.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:01:17 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 2/3] bpf/helpers: introduce bpf_dynptr_copy kfunc
Date: Tue, 18 Feb 2025 19:00:26 +0000
Message-ID: <20250218190027.135888-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
References: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introducing bpf_dynptr_copy kfunc allowing copying data from one dynptr to
another. This functionality is useful in scenarios such as capturing XDP
data to a ring buffer.
The implementation consists of 4 branches:
  * A fast branch for contiguous buffer capacity in both source and
destination dynptrs
  * 3 branches utilizing __bpf_dynptr_read and __bpf_dynptr_write to copy
data to/from non-contiguous buffer

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c  | 37 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2833558c3009..ac5fbdfc504d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2770,6 +2770,42 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
 	return 0;
 }
 
+__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
+				struct bpf_dynptr *src_ptr, u32 src_off, u32 size)
+{
+	struct bpf_dynptr_kern *dst = (struct bpf_dynptr_kern *)dst_ptr;
+	struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
+	__u8 *src_slice, *dst_slice;
+	int err = 0;
+
+	src_slice = bpf_dynptr_slice(src_ptr, src_off, NULL, size);
+	dst_slice = bpf_dynptr_slice_rdwr(dst_ptr, dst_off, NULL, size);
+
+	if (src_slice && dst_slice) {
+		memmove(dst_slice, src_slice, size);
+	} else if (src_slice) {
+		err = __bpf_dynptr_write(dst, dst_off, src_slice, size, 0);
+	} else if (dst_slice) {
+		err = __bpf_dynptr_read(dst_slice, size, src, src_off, 0);
+	} else {
+		u32 off = 0;
+		char buf[256];
+
+		if (bpf_dynptr_check_off_len(dst, dst_off, size) ||
+		    bpf_dynptr_check_off_len(src, src_off, size))
+			return -E2BIG;
+
+		while (err == 0 && off < size) {
+			u32 chunk_sz = min(sizeof(buf), size - off);
+
+			err = err ?: __bpf_dynptr_read(buf, chunk_sz, src, src_off + off, 0);
+			err = err ?: __bpf_dynptr_write(dst, dst_off + off, buf, chunk_sz, 0);
+			off += chunk_sz;
+		}
+	}
+	return err;
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -3174,6 +3210,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_dynptr_copy)
 #ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7bc74171c99..3c567bfcc582 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11781,6 +11781,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
+	KF_bpf_dynptr_copy,
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
@@ -11819,6 +11820,7 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_dynptr_copy)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
@@ -11857,6 +11859,7 @@ BTF_ID_UNUSED
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_dynptr_copy)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
-- 
2.48.1


