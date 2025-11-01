Return-Path: <bpf+bounces-73228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEA6C27C4C
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 12:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CAF34E4C34
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6D2F25E6;
	Sat,  1 Nov 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5AJviVq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AA92F0C7E
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994869; cv=none; b=lCFkJR7KcL/P2zC3Jxj+3TofzaZ+Id0bYI1/EyKzCzKfBZIJZpaw3wUyqBRSW4beYqSn9tB6nAogjcxeh9hahSb1nXM0FeY+/7gqHNTNtHiJojyDp3lzd4Esc2Gk51jQU3hVqKwlwfZS+3gAS/SWPw/JP5b1hDIspbz/iZiUqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994869; c=relaxed/simple;
	bh=mi5vqdhvEQodKsnQFWMNDL4Z3vPP4LYvGIeqIfcW+TU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/+3J06HHtlat9O1g45FvdsUefiEdwjHBu+Wp2d2jq+00KmkgiVWPKcyWqQLpW/m8hiaHA5IfaP27lATotZXWs5OaTaRvRuZK3QwLK65jsrobLkFvsQqDl49dbegxm4ld1wf1CdYXVVRhwWThJ4o0cEBl35huy/wLTa1gUji2aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5AJviVq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso14923205e9.0
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994865; x=1762599665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJtpEOqqF8rVJaCraHcAZ7P2PQnvf38Tak1bs06w4sg=;
        b=B5AJviVqT1WMHDm1DDz+pZVtQI7KEFi5dCPCW4SYhTg7qkqJJN1ErxaBQqx1/MMV9j
         Gd1kQQNr6oKNH2p3DvmtRAbzrTRCnH8bjpmLP0Icfjzy57enSE8d9tp3YgIvxz5a3Vs0
         aQoDF26U5n2nol3nx17Dz9EqrBe0fLFYj1YjUe6eRZyyTl+jaSl3kKkj9/q+YiRSjPLF
         RcvvEIjvPmNWS8a+hjut4fSH5AEw2f1A8AGkZQffGkGm+R8wqSVfVreRRhzSfdplSZsf
         t6EuFSPHpSV5lbKDDEbrFupBREwXQ8m00uJB1GpvsIiZpOOR1nOg97qL/ebG8Mq9Rkfy
         cw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994865; x=1762599665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJtpEOqqF8rVJaCraHcAZ7P2PQnvf38Tak1bs06w4sg=;
        b=CAYamh7EfSWlIpXj4mXowCs65dHCg8dx5GWacgYP7xviGuXo1Ruu3WURTGaLh4YZ4j
         OHQKu0/Yj69VGxrF2MiXYWluy+jHiq2hyK4CljALK9C6me2GxfFLbpEWgXGFRIGiv5rK
         /j4E0Qzw71k4XtdeDFerXavgnZUtiI29BM49RIHJinhQIeEIagFdgFeUPZqMnALXW8/s
         +Z555uLYq8+7qo2mHt0Xy7DC0+gyG2Snv+J2k++Gnr+2BBFbFBYzhoWNMDcmIoZfE9vr
         dl2lW0nER3p4IUppyMLpy2KdhQnWQzeaEO2wTMx7qCenbK2IjvSkZnGft+/lNvtz62d5
         i+OA==
X-Gm-Message-State: AOJu0Yx7r1hbp5Ibx32eaw0dZrdFHPelM2JholpN643vZF5joKTGM1HR
	bNl5sT3HOfEC8glEpqWIvRHsl3e9Gthzlfu1Wd/XtvGSv6Ux3P3DLPr9Yx9nYw==
X-Gm-Gg: ASbGncvH1QxzrIed0IsiJQbo8daigyetMe7YQbkuYJGr/2lPEDveCUGXfiCKvaeAkb5
	dZu/III11hEV/O1R4/oYVtJAZbupG8jUllPYHHkv3EtuiBviN8LQYx0tckuT3f+jbAL5ZtrksmB
	tODu8DYY8zff/P05NipBS1cOVB5H5uK7NSbVVCUAOxhKASI5Hi2BL/bx46LeF1Pu4VP6ZYl6i3h
	TVPx9hyKqq10uNES+c3TUuQPVRe87ThwJVlHpky8/pMew0spiCUy0Z5FsK6behTuWPGrpnEQ6e3
	mz7nkZ68of4jrz0LKSuirX5rQ/7JyNnhpOSdKT+CFkoQ5pqhCtAI0KE8PgXbIic1WlATPn0yogG
	Zp+PQaMbmCj9YZGwJHmdvHfmh0vCSm15erP41YqmHLSPpxBYfq94lWcgn6iPImN2mk4XQbcernr
	4H2L1er4u7yjldijk2Ymo=
X-Google-Smtp-Source: AGHT+IFXRZuSrd9uTG2OVSCqA0a9NSgK+soiOGUAK8IaPdLSDAoIuRS9rAZOY9Q416G1XzjtVvc1Vg==
X-Received: by 2002:a05:600c:4ecd:b0:46e:4883:27d with SMTP id 5b1f17b1804b1-4773632e135mr42000955e9.30.1761994865315;
        Sat, 01 Nov 2025 04:01:05 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm38794005e9.6.2025.11.01.04.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:01:04 -0700 (PDT)
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
Subject: [PATCH v9 bpf-next 03/11] bpf: support instructions arrays with constants blinding
Date: Sat,  1 Nov 2025 11:07:09 +0000
Message-Id: <20251101110717.2860949-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
References: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
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
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
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
index dd597ea80d99..2b771e2bf35a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21601,6 +21601,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
+	int old_len, subprog_start_adjustment = 0;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
@@ -21675,7 +21676,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
-		func[i]->aux->subprog_start = subprog_start;
+		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
@@ -21729,7 +21730,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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


