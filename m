Return-Path: <bpf+bounces-71473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C140BF3E43
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1C534FE7B0
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52D2F25F6;
	Mon, 20 Oct 2025 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDGCeAFN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98F2F25E2
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999160; cv=none; b=KJt/Yx1JUGSJq2uuxw00W3hNGqKEW5eVv/9Hy5FjoqLsKi8oU/kX876TwBGZQ5RfAMV+WSVovGTt0tPbpOYV58T3LQGUjWp43CVTjpvsmULoZ0NQ1fCKX5V0LEQHgLiqVFu8ETpNgMDuiYUZT9K9ucgyMbWUCGaJJrJ5LgdQ3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999160; c=relaxed/simple;
	bh=evyqhWO+tIM5pgK2uq5UxWiCp1hE//reLRutZMCDYoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHv0uaKfOuMoZaFHmIekjUO3Ytlou3O3DYIKDskhENvJdP7muePJYx2T4Xr+YrecMOrurXaCFKzuTODq6l0X2Q8sGmpBsNivCvyuENwSwNosdRjCEMYK4pOe3dZi2n9bsBDzjlh0iJXgNENBkFLPf4pYxpDzzFF5L5SpoD9uKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDGCeAFN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-427091cd4fdso2226256f8f.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999157; x=1761603957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8XuFcJs2dccXDbIGxan5bz9wb3I/0WStGGpxFyxKQ4=;
        b=aDGCeAFNkg13sn1HUTwWWBW3xy9/V8NESgTphse6LJgPN8iorG1KWnV+qKDlUo2SLm
         zZRA0JMVI3l8XGnpKEbVLslU0D+38Jm4AIaUKT3UVUFQAdPd0QPVN5FT2PH3u3v6BB+c
         4T9T6FB0jjQ9Dd4Du+H2RaAZ/skJ1cuONn57KeEcKFEf5j447c3ORxGswbBHGZzBGa81
         RKs/WwZP0m1RxVq4fX4ZK73HQgobmNUE/+kZ7NeT2p3lOP3tJOYm//6fD1i+JMx1wJOX
         5sOvtPAXUByb872anSawbIlG3VKPaLHd2gx0crpjokkcUiCKqG94si7Tu908N9nlvRMl
         m3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999157; x=1761603957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8XuFcJs2dccXDbIGxan5bz9wb3I/0WStGGpxFyxKQ4=;
        b=pmER3BU9elIc97O3vHfO9IG4LSpw9NmECWSHI6lPGLMTHsvNLQTWXmQHvPkab7LQNp
         em+Hk5U2JQwQGdAJ0ndGmgvkbQeAjVbY4IF6nPCWwgVFWCzgiOrvzfknjm3V5ZehVOTb
         KsBYQlcvr+KP79C+pACcr5/DZ5lg6SZ13LnfEiz6ZozUoVJINPYqmtyZbBWvFR//D3x8
         g+IIF7sVaePnDfLJgBG0/bVixCWkEdmpIEn89aRxBr2e20D9oeBQsExX9zK3OAzjt55a
         kMEr13ZMpmZjstQbPgDZXSBgmZ0rgye/raYbNi7R+UJ0C6A6K499LgiF3Rs9iSYcDthx
         OuEg==
X-Gm-Message-State: AOJu0Yw3Muhymm3eG2gLjFgfZrdlmrEtw1px6bujjBzYPu4n4doqJb0u
	WD8Z7eU8czer8pmSzRj2iQB7SF5eXd/z2jABeFpgqxeaFd9EuKiLTKVx6Jp0rg==
X-Gm-Gg: ASbGnctzJw8jl2V1iiMX08hTuPbS065MEr6z5rNSz/b+tYj1VwFUJwWlBaAHSoCKdCq
	coEWJ4RFIEpOW7cqM/WXwcm4Ls1TW0Dp9xhFE2VvBQi3kddLamY2Ba+mi9Ifa/cuHb8BeK8KBDG
	RUaGF6gvB1jlOW6yT6jx1hJBMg8xjlUyLg09VbNsl3ywFSTwL21CzYybYW16KonNaTqpBcHV8IV
	vKz0vqBoFH8J+Uf/pESvbnxhUGNyuqMhnocHT8m0YE6AyTuPyixe3HXmx4C+i/jAst0fV5p3Eff
	3mnJv5e54TSSs/GBa9XqZSwaXdiKAnmSMKzFGVbZ0iwX2x7RU6HPKYbEsqQeVd6L7ZuGjElwOY1
	DHd32U8zmX2oBu56FN5vLfV3JcJto0Z6lNT4y/IHIaWC0sNmWaqJxgX9KfQJ78q978WRL5A==
X-Google-Smtp-Source: AGHT+IEJCH7VkC5ugTM2Kf8Y9ra7MFQoRj/5c+49Ad03ll+Xt1xm6DF1U9Q9rPus/J1qMsF7sJQYNA==
X-Received: by 2002:a05:6000:22c6:b0:3eb:b80c:cea0 with SMTP id ffacd0b85a97d-42704d1452cmr8169818f8f.4.1760999156443;
        Mon, 20 Oct 2025 15:25:56 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:2617])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm15159633f8f.10.2025.10.20.15.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 09/10] bpf: dispatch to sleepable file dynptr
Date: Mon, 20 Oct 2025 23:25:37 +0100
Message-ID: <20251020222538.932915-10-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
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
index e4c0f39e9210..2175c745fca2 100644
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
index 64575f19d185..0418768d13e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3127,7 +3127,8 @@ struct bpf_kfunc_btf_tab {
 static int kfunc_call_imm(struct bpf_verifier_env *env, unsigned long func_addr, u32 func_id,
 			  s32 *imm);
 
-static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc);
+static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc,
+			    int insn_idx);
 
 static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
 {
@@ -21880,7 +21881,7 @@ static int kfunc_call_imm(struct bpf_verifier_env *env, unsigned long func_addr,
 }
 
 /* replace a generic kfunc with a specialized version if necessary */
-static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
+static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc, int insn_idx)
 {
 	struct bpf_prog *prog = env->prog;
 	bool seen_direct_write;
@@ -21916,6 +21917,9 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	} else if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr]) {
 		if (bpf_lsm_has_d_inode_locked(prog))
 			addr = (unsigned long)bpf_remove_dentry_xattr_locked;
+	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
+		if (!env->insn_aux_data[insn_idx].non_sleepable)
+			addr = (unsigned long)bpf_dynptr_from_file_sleepable;
 	}
 
 	if (!addr) /* Nothing to patch with */
@@ -21969,7 +21973,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
-	err = specialize_kfunc(env, desc);
+	err = specialize_kfunc(env, desc, insn_idx);
 	if (err)
 		return err;
 
-- 
2.51.0


