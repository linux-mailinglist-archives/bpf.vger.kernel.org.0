Return-Path: <bpf+bounces-71024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27714BDF979
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66D71886758
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10213375C9;
	Wed, 15 Oct 2025 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPLqIexB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FAE3375AD
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544727; cv=none; b=BagJbQZosEjSOjgJkWB8KEZiGf2l8iH0iQ1rwwl4p8j15FEVuStQ63YOQgVQv9sL2QiY9q67vsQgkyWCv7r0Klu7Zq+Km2oMUfcBMYOTVjd+nMqiKe1UiYz8g4BONRNwmvc2fbeITOYxnXIGwH1hHfsD4qiHFgGPqOcyE3EVKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544727; c=relaxed/simple;
	bh=z4ibGcMVB6BYWFI9vo3VyjDQBPO359diu4dV5sSzuIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4MXEZz2NWHnGmU4FB/Wasb2Xy7nBQhNewd6p/GkF9seOHC6cT8fhBNO7sKge2kgiscpyGYdbtsCHozfb4XdeHSA0Fplo0OYr1oSi1FRJLfI8sTKswhOxkOOawU53ibgXF8/6YXJT3H55cjk+C6E55GeoOu+ZiqTM2G9Bw9VSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPLqIexB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so77582455e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544724; x=1761149524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0ENkK4EjCaEwnhLWpPWMi4vHO6eokLoOt6X/fLzU0s=;
        b=LPLqIexB5Oyy4Zv+9YR/oUj5mrI+eFxlP8Z1EUqZ/w+79QVZg/4edLdds0QREpdADk
         vaUX8zJWnToNQ8O6iO7dDPfRhtZP3hbnYompJze966+q3oXdhH56ZBCE981dbnIiDISv
         XB2LCc67gZwU0Erh3HhKqh+XuNn4HAD8R9H/IXPlp6TvhUdY1JgIbsjYw2iZPo5eoeC2
         ys5N5Qh2W4cTO5TsAjf0feN3tb6Ba7fFytj8sWUiZDWZA3CQJ//pMxxIeUhvRCk+OxIR
         Aa0FS5zr9EIZuhtUGSu63gCJYK6uwg6F2MwTp/USxO6UrAHt5/MNvBidWr5DvczQvLOH
         GamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544724; x=1761149524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0ENkK4EjCaEwnhLWpPWMi4vHO6eokLoOt6X/fLzU0s=;
        b=jfr/4bB0s1Vfe83UZOAU6i5KzjGFdPNVsmf5a+UOrZtU5wS8A85zEYP4MJyBK+di4k
         lKm1tDE8nHLy8DXuG11zUT0+heWtpdcpWJkaBvaGvqYtX6xp9vvvioBZdY60BmwiImZD
         VKKgmVTi46qKsRq3Cj9BDJ5ifckB4HW/IDgELTGiNWEaJqnrgHXdY1M9x4Q8nrSt1RT6
         xpcJFxoBwur6P90Dwiy4G7f1b8UKz34vMpYxzaJjvUxOa4QFI+6vvu7Z9J439YksvVEM
         VSw4SvMRguTmxGuL6GeFL3pUpIBY3pK5KNj6rDLYE5G+OXkJo2+6OYVMROVi9IPWwFLx
         PkdA==
X-Gm-Message-State: AOJu0YyAqYwrbtsi51sz6U0Cd87lsHfa+pUV8r6uPXP8oVQFqjQKlAmh
	2UFrhfqdSbNjkSSYweCYcvvwGXguvuo8yDedy3nRifL42C80Ux9GASnTu3tHiQ==
X-Gm-Gg: ASbGncuc0BMmhipAavi1FA/12rpWG9PD32GrUvqWWciLk5CX3G8jYh0dopQUmq0gDu4
	ZNUMeE3iM7uTtRnTlgkvvWYW6epgCglkG9uxzGyj24rUs6lG4WwpcEGioRHoT7/FoijodNCAnp9
	+62zoBqSKdy4rCxL5go9rPtqCY8LhXhKOlgCb/E4Ot3Ejqd6yz9G+Rc2QX2gPQM08+6DVM1ePpe
	iMmjE9lnZTmKAt18+azLklf/yQA19VjY7sI+cWpM9TDnzxP8rL95yDtqbgQdkgB+ukbsWr1i092
	CYty+2YKojcevNHBn6tAVOwyF+0NkOqFpbJN8MFIXTyWiEPUMetkBkeW4eoPUg5jtCWgV72mlO7
	QHcLY5GqrsLIOVcoLiDYo65l9aKRoIqZm80DT44mf3dp5hqL8fyOfwrc=
X-Google-Smtp-Source: AGHT+IHTxC/Lm0d5afDtAlsmzyttXI4sbhoH5Vhl+aG+eEdx/nZk+p4wV3dMAw4T663W6Qvaklr0ng==
X-Received: by 2002:a05:600c:46cf:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-46fa9b02cebmr196002755e9.27.1760544723681;
        Wed, 15 Oct 2025 09:12:03 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb483c7e0sm304109835e9.7.2025.10.15.09.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:12:03 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/11] bpf: mark vm_area_struct as trusted
Date: Wed, 15 Oct 2025 17:11:50 +0100
Message-ID: <20251015161155.120148-7-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Mark vm_area_struct in bpf_find_vma callback as trusted, also mark its
field struct file *vm_file as trusted or NULL.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c                        | 8 +++++++-
 tools/testing/selftests/bpf/progs/find_vma.c | 6 ++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 528782835c84..a33ab6175651 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7102,6 +7102,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
+	struct file *vm_file;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7133,6 +7137,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
@@ -7143,6 +7148,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");
@@ -10859,7 +10865,7 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 	 */
 	callee->regs[BPF_REG_1] = caller->regs[BPF_REG_1];
 
-	callee->regs[BPF_REG_2].type = PTR_TO_BTF_ID;
+	callee->regs[BPF_REG_2].type = PTR_TO_BTF_ID | PTR_TRUSTED;
 	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
 	callee->regs[BPF_REG_2].btf =  btf_vmlinux;
 	callee->regs[BPF_REG_2].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_VMA];
diff --git a/tools/testing/selftests/bpf/progs/find_vma.c b/tools/testing/selftests/bpf/progs/find_vma.c
index 02b82774469c..75b85ba3ab6a 100644
--- a/tools/testing/selftests/bpf/progs/find_vma.c
+++ b/tools/testing/selftests/bpf/progs/find_vma.c
@@ -23,9 +23,11 @@ int find_addr_ret = -1;
 static long check_vma(struct task_struct *task, struct vm_area_struct *vma,
 		      struct callback_ctx *data)
 {
-	if (vma->vm_file)
+	struct file *file = vma->vm_file;
+
+	if (file)
 		bpf_probe_read_kernel_str(d_iname, DNAME_INLINE_LEN - 1,
-					  vma->vm_file->f_path.dentry->d_shortname.string);
+					  file->f_path.dentry->d_shortname.string);
 
 	/* check for VM_EXEC */
 	if (vma->vm_flags & VM_EXEC)
-- 
2.51.0


