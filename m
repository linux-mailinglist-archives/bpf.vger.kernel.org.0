Return-Path: <bpf+bounces-70035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9478CBACE89
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 14:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64D91927A10
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431CD301493;
	Tue, 30 Sep 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdApPUmY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E02F546C
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236344; cv=none; b=uCeDWzVP/HUCnBwhCfFc8opLZlDoI803EC+ycDH13kJ3TyMhygULdK687Z6PB6/iOj8E4PvwgYpOc1cs8AOfMbm6gKiTkzjKTYoWcl0ln4ABoQiWxWkykh7Uph7YFkoDvS2IpX28Z9nc4wpF0tsTZcZ4VXmez3kI7MywUv+HboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236344; c=relaxed/simple;
	bh=axqyMPCZjxXuQxc3qJbk9Ax4VBWXCJSlOM3eguf+e9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PX8fz0KNMxfTEkXzf2hixXh9nOkLLpZ9dqtiiZiwH5oglSXNMn6VUV9opQw20+T+pjXheh7B86fnryv9Zoc9l4usQekRcc2QLwlYyiW88H8/sDwrad2K4BL4KUyyPtFsCNcHTSmcZJM3f4gQ0ytc3t2ELkbTsGqwDJsm6NCAVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdApPUmY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so34015725e9.0
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236341; x=1759841141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXQJyhWwfAMhPS4rhZJ8RV+eAR5RbDRvhYq/Yymwp/w=;
        b=UdApPUmYLk0VMlXaQmI0VnLU0mEZSUdrlNttwWFN5gP7DSOjsZ0IjM+hP+GSuRCc3B
         vvzOfxgIvRDRKsWUDTfmaqCm5E03LpEp4ek9yliPTPnlKTb0J+rQvBSICPMLXZl0yQOx
         bq9mr7NVuEbwUh3snc3B2nPcYc8ZZOInw6xNQP6MoDAVxzHTNBWE4yQNVJf3VQhVkBCX
         s5q7M9Am9jOtyLuELrL0yHg8A/FRyVts8+ooNBZvgLxqv0I1s0aOptcG8uD9uv8rGIaj
         ARcFqE7STs1M2JHQtavq36Q+fdTzSbB0dPDtXm5TMUmPSFVdTGCbmP1s8JtYigQGLKWa
         uE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236341; x=1759841141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXQJyhWwfAMhPS4rhZJ8RV+eAR5RbDRvhYq/Yymwp/w=;
        b=LZ3deucMVD6QS9h6mJekmSkSnOLtSAoutlaWat9Jck9aUGVDQcg7LcCQNJmIOhKi+Z
         RdiBMNJ4BiEVkwlOtcNUHYxLbUL5KWXzLi1w5SN8HHnWdfRfMEBolPwfIRPIe3DFuTsr
         hBPLh27/B1lLSmcpQJ0GhOOzQ4Y30LYXz9ZKp3+LuDJVlx5h4HQEw7xTx1Qggga+vKPz
         VLIkjdJcCOpWDLj3qIGANsm8NYLZ0HELeqxeKhY4KchAKyxqibSGayMKIfMPBBi8SHsl
         212DlAqDpnXx2U2wCGrxy/3Mh7/7Bw84YImSJbzmOLzCrcTTIZF+mS1WiDc/6/3SQ7NH
         OePQ==
X-Gm-Message-State: AOJu0Yy4CbxWmAWo3tBxna3vviznw50c26PNG+moqMqsK+vnbdz9T2YC
	0ORpiwrPLo4B1S5Wa/faatidSEE0It8ekjBCxbQpw7KDxVLBmIjLZfHz9Bo3kw==
X-Gm-Gg: ASbGncuLYfTHF3+ZA5oZaq6y850STp1nholf5QK5jvcS+3GPF/pE9sh5oOlxjo2l9kg
	v4VnMdfA592ae1jFzc8roOjImUaB6Wrl79+xiGyXmKP5yuGKxV1HsuElceEc6EF75K2PhY/ObPv
	WQrSyR+aome1sNDalcaOdtlExnVLtoykoyp15nu/iqi2RPc/S2J3U/unk1JIzNJrFL+O6c7XOFb
	F79d4d5gMZ0w2Y6NLbthTqpcwl3ezjC3Cbp97yL7wHn4g57qxWAAcDUwfcKlT/VlxqpW5AfCk8R
	9MjhhVjEWO+o4ByeY5MUnP3svokV5awhehCZf7ry54XJOLVrvNDDyUkMFQRRnKUBhfW+WFwv0Nz
	64C0ItvNJbrDlGZbfY91yhSpld+hpAj9573frm00lvyrWDOlVW5kRbwfj2/g0bK4cDICifOXc3E
	4w
X-Google-Smtp-Source: AGHT+IFF3AH+X4JK3y8/zVVkXfAkH8jCjePtlTWtNCqZZcmU1d49M/fbKKYQTgVm65N4v2CWKtxpMg==
X-Received: by 2002:a05:600c:4e14:b0:46e:48f9:a17c with SMTP id 5b1f17b1804b1-46e48f9a5acmr110069545e9.9.1759236340640;
        Tue, 30 Sep 2025 05:45:40 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm22392586f8f.59.2025.09.30.05.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:45:40 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v5 bpf-next 06/15] bpf: support instructions arrays with constants blinding
Date: Tue, 30 Sep 2025 12:51:02 +0000
Message-Id: <20250930125111.1269861-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When bpf_jit_harden is enabled, all constants in the BPF code are
blinded to prevent JIT spraying attacks. This happens during JIT
phase. Adjust all the related instruction arrays accordingly.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/core.c     | 20 ++++++++++++++++++++
 kernel/bpf/verifier.c | 11 ++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..4b62a03d6df5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1450,6 +1450,23 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
 	bpf_prog_clone_free(fp_other);
 }
 
+static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_map *map;
+	int i;
+
+	if (len <= 1)
+		return;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		map = prog->aux->used_maps[i];
+		if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY)
+			bpf_insn_array_adjust(map, off, len);
+	}
+#endif
+}
+
 struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 {
 	struct bpf_insn insn_buff[16], aux[2];
@@ -1505,6 +1522,9 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 		clone = tmp;
 		insn_delta = rewritten - 1;
 
+		/* Instructions arrays must be updated using absolute xlated offsets */
+		adjust_insn_arrays(clone, prog->aux->subprog_start + i, rewritten);
+
 		/* Walk new program and skip insns we just inserted. */
 		insn = clone->insnsi + i + insn_delta;
 		insn_cnt += insn_delta;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4704bbdea785..705535711d10 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21537,6 +21537,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
+	int old_len, subprog_start_adjustment = 0;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
@@ -21611,7 +21612,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
-		func[i]->aux->subprog_start = subprog_start;
+		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
@@ -21665,7 +21666,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
+
+		/*
+		 * To properly pass the absolute subprog start to jit
+		 * all instruction adjustments should be accumulated
+		 */
+		old_len = func[i]->len;
 		func[i] = bpf_int_jit_compile(func[i]);
+		subprog_start_adjustment += func[i]->len - old_len;
+
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
 			goto out_free;
-- 
2.34.1


