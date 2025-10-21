Return-Path: <bpf+bounces-71632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C05FBF8881
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8425820F4
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA8527B324;
	Tue, 21 Oct 2025 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAHUwPBz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4B265CDD
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077036; cv=none; b=o9tsZlzmzbDf/xhrQf6kruA2gpmSPp2uhKeY0ehkrJpCbq644oXX0TwmJtFiGEUQWKT+nB2ZqVwDCB9kvc4bj7685QdWwPsiGGPz9JHUqL19UqaDxucKI8OfwvVJyTgQ8rBFsp9P6uuC/ycz61Xu4fcM3qRUigYm5HsTSP3Miy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077036; c=relaxed/simple;
	bh=Hcgu/6KwX7dxCjxTT7vGkstRFqP4oGE1EbIB2keNmSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCGbmS8DNJltp/SB3mlIy0hH+nDn44sxQNQqg3O0PqK48uxT/NNUSlB4cNDIf9n5XrH01VQg/Bf0WCR+sA4Zz3DN0MUWNnvmbobAHrqsN6exiK5yhEaeZzJbCnU+radjPnMpMmbk8osOeYUDIY/joXihGGTcoMnDMlcd9c80kQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAHUwPBz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47106fc51faso71224375e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077033; x=1761681833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX1n3BP5Hu2Tpsmg37L6uX4wUeNtRQ6u5JPPI0MKjsY=;
        b=nAHUwPBz7IFoaFgfMuPob7ZEoXOjiit04QWWUkQWUVg6Oczr337MRTmntKffVTA9hT
         EKwddbUs+mNFvBo1C026brixkK7NwS7VBEIKIhmkJjLtPwI0+biurCl5EIOa2ulnU04f
         T56v0uabole+RgnZAv1xd9KdtTtrXHEvxAzglyU6FBfnyKzF4/NUyhRO+5+QvoAtKd3R
         TFu3w//NHeFiDFwAGURz22daj7/d8vEtzC5S9CLn+5nYV3CsgZwXJLAPGBvNmJaS9GpE
         3WOyFs+XJT7KxBOQEeaP9ofgPXx7QoFjGmaL/dctBZhZnulj9U6TfbOK7jLhJvkDNY1f
         QPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077033; x=1761681833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX1n3BP5Hu2Tpsmg37L6uX4wUeNtRQ6u5JPPI0MKjsY=;
        b=c9gTgn5i5pPU+urpYZAaPqgjJWwUTb6lt+jYOeVLc9CZYrMtBVYMqe0AvsacdnGkNB
         PYhEtHwS/DEWc5kwZ1BOYb+Qagrw34e68bbDOs0bOETq1h+JJ2w9E53QjJWXJRrNW+WO
         aSLmaGKCMUxp6A8kbrEIm8Tqnmw7IKAjKDU3nQ3+Q61bau2yAiYCHl6uRN30YR71dlP1
         Xnycdz0dvLHM2zA6oBBiUbVQIAQq3cfuRhKMXDu8an9hNIDWj9X5J93Brozv4d8UL5S6
         46km2PCEFWp9WEJJriRg5tq1NHTMqkuGIfoZPemEZsts9a2YPlunZF7SnkblSbpHohfw
         CI4A==
X-Gm-Message-State: AOJu0Yyq+m9490Wpi4s2xsFcvKKqB4YMrckAHlHHhTfm8XXALg7ZCCtm
	AdMr6MALBliFBSITM4Cl4ef0HdQyrwfv6kMNUbs/pPMdAO2OIkGB1BOJpS5GjA==
X-Gm-Gg: ASbGncshTB/d2cMXgUqlDqBLS4bmdafDmQeB62Mkp+C+0Jt7QYX4KGZ1/N1b09jaW0/
	MlxZCfxOFeI2+s9w09rxpBMTYuExI6RqRu3gC73fApNdXOCb9VHFEsu29slNPrz1QTYByfqRVNe
	ZusaDbz76b7CF24aI+udKeTfUAEa5Z8ii7L7I1n8XdtUwBKS/4GBxKSttkL/3zOWWltKLHBScfj
	UqO65zhvBcF+CtEdKlrKKxmEzag5A98xNqUg1dk25jUCh6e6PdCOiE9pErIqKTHAUhx0129LmqO
	LA3SB/gc52GdkkpVfS2qEq0LIksKVTyb8lmUn2lqea1DLPJ6UArCYwKX4xSXnXLNg1CCoTI3psE
	9YT3rzxLlcemL++i9je4cFzjVs3gIyE8U3V70JURmcX+IZAaiYGhLyJlpu35r
X-Google-Smtp-Source: AGHT+IFvcObtrlfNq0aHBSNiQkWoVm0wqfzQOacdd6ZuiJ1Z3JR2dEmneho8XbG6AFKdCUO0mEUMVg==
X-Received: by 2002:a05:600c:3e05:b0:471:16f3:e542 with SMTP id 5b1f17b1804b1-47117870720mr160103495e9.2.1761077033112;
        Tue, 21 Oct 2025 13:03:53 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496cf3b51sm22179335e9.9.2025.10.21.13.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:03:52 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 09/10] bpf: dispatch to sleepable file dynptr
Date: Tue, 21 Oct 2025 21:03:33 +0100
Message-ID: <20251021200334.220542-10-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

File dynptr reads may sleep when the requested folios are not in
the page cache. To avoid sleeping in non-sleepable contexts while still
supporting valid sleepable use, given that dynptrs are non-sleepable by
default, enable sleeping only when bpf_dynptr_from_file() is invoked
from a sleepable context.

This change:
  * Introduces a sleepable constructor: bpf_dynptr_from_file_sleepable()
  * Override non-sleepable constructor with sleepable if it's always
  called in sleepable context

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h   |  3 +++
 kernel/bpf/helpers.c  |  5 +++++
 kernel/bpf/verifier.c | 10 +++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b600230f8b07..604f174616f2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -670,6 +670,9 @@ static inline bool bpf_map_has_internal_structs(struct bpf_map *map)
 
 void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
 
+int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
+				   struct bpf_dynptr *ptr__uninit);
+
 extern const struct bpf_map_ops bpf_map_offload_ops;
 
 /* bpf_type_flag contains a set of flags that are applicable to the values of
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 99a7def0b978..930e132f440f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4336,6 +4336,11 @@ __bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struct bpf_dy
 	return make_file_dynptr(file, flags, false, (struct bpf_dynptr_kern *)ptr__uninit);
 }
 
+int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags, struct bpf_dynptr *ptr__uninit)
+{
+	return make_file_dynptr(file, flags, true, (struct bpf_dynptr_kern *)ptr__uninit);
+}
+
 __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)dynptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ea20ab1b00d8..0f07e26f9fbf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3126,7 +3126,8 @@ struct bpf_kfunc_btf_tab {
 
 static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id);
 
-static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc);
+static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc,
+			    int insn_idx);
 
 static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
 {
@@ -21861,7 +21862,7 @@ static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id)
 }
 
 /* replace a generic kfunc with a specialized version if necessary */
-static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
+static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc, int insn_idx)
 {
 	struct bpf_prog *prog = env->prog;
 	bool seen_direct_write;
@@ -21896,6 +21897,9 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	} else if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr]) {
 		if (bpf_lsm_has_d_inode_locked(prog))
 			addr = (unsigned long)bpf_remove_dentry_xattr_locked;
+	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
+		if (!env->insn_aux_data[insn_idx].non_sleepable)
+			addr = (unsigned long)bpf_dynptr_from_file_sleepable;
 	}
 
 set_imm:
@@ -21951,7 +21955,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
-	err = specialize_kfunc(env, desc);
+	err = specialize_kfunc(env, desc, insn_idx);
 	if (err)
 		return err;
 
-- 
2.51.0


