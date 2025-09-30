Return-Path: <bpf+bounces-70015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC1BAC8E3
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A572D19245BF
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145132FB094;
	Tue, 30 Sep 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpVQtONs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91BE2F6193
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229393; cv=none; b=ImxLMNj+ps3SEfGb+y7FryBhrX3WdMUHRqJPwdT+gyBZpk1RENj0/l86V+wId/nXVIMXjJo90IVelso+fOkChpJKI+GkyL8JEGGnYkbOZCE14MEJTpyBH4BJi9WvTHXDET+dlyltXt3vsPqBr2ZVeCoDrkmXN4LtU/Ryc1qosvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229393; c=relaxed/simple;
	bh=c56A7qkTxJ7CJPdOXBaDqLapzOlhjvUr3fHSlf+sLdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxBCnU2P01L1VNl4c29lx30Qxlu2lB7qLhpAhUqJEVgGfEGzHXDcvdlF8KI3Xe1IG59kS7e3+DYSNTalbH1YO6fYWsotkejy0qCchFowgc+r0upDVkOQLr1RZARxJ6ClPcv3PR4bfjKW2Renii1cGpxrNjV8q+/39tcQzOPWpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpVQtONs; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so3427572f8f.3
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229390; x=1759834190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn01V68x50khz0B90yk7Bf4V11ow89Lnc/ou1bs7WLU=;
        b=ZpVQtONsvoOwE3mbH/riGPiLjGhAX5Q82eWuCusZmGXSZtHt7Vvhzz990detaYih1r
         C0nxBrVwblRVFn0Jv+YEAzQ+GYTyGjviNPVOo536/tEFqayC17hAyKdlEGyvnhnH9Mzk
         bacVvptkoLVxm4IKyPozeQGR2Y0CyNwlNn9AcSnIx6qhiYr4/LT5NyHDkz5+K0z/8l3z
         L10y2H4mVLhdrvvqTh2oCxrWk920P9NMxbPcixQFahPNNaFhe+pFP7BlvWxF+mplSP0b
         DI//D/Z4BIb8SFN5rV1tbjT2Brk/gwAIhXQfcen+7+iQKSY64GZSmDx/BVKZxLpAr/lk
         Axpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229390; x=1759834190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn01V68x50khz0B90yk7Bf4V11ow89Lnc/ou1bs7WLU=;
        b=ntbYX6LnPcRAVN0FqgaOCURLJE78H+kFho4RcEwu/HWYvuG+7zilR5FTpe1mz4JjBM
         C0Q7d76MbhbrzsRbi6tZmmfdWUm0ewfZhrdxBtJbFsYvIg2e16XwPEKBli/wCbi4UKsT
         WZbrG1bEcrJx5ezB3shmze2SkpW0voVrN9GELzFrHiChZuFsVmaKHIUZm2NySAqG9vXq
         Dy2SMGGDKHi52ay7VSpUgjMpf+cg/YHthbmwgagBGXJ6/8HSVzeTtdV1FO1fJ0m/JQlO
         dGdRbRG822MaAKX9VuzUtIRowtDzlCgnGYIHs1dEw19j1HzZGX7dO8EzN2b3si3NEpa7
         UpLA==
X-Gm-Message-State: AOJu0YxkXhEvWOOxjwHcCIEQv5QS/uDbTGULStDDOIg2UHsEQVeYNMqc
	X2hIbWgSLCL8Hp6iFB7tOJsdU5aYpUg0LKelilV9YaO7GotWH6JsuNvcd2oUhw==
X-Gm-Gg: ASbGnctwy54meBnPvF+Jj3QbXvTzfFB29lMtW9qd8SjZurmZmUSVvJNFa47PF9NCmoX
	8bZaO/0ZoT8J0T8gOGzL+XVMRxtO+GozReCO25CWZoqjnHvncCafWtXW98m0Pa+vbm9zojMnCbw
	NPXZVnzAP/Fu06YK4ef1D7nDlwZPizHZzD7jmcchB7o7d7gTiEYD8xlJW1bcOjRLOmDvcfademD
	r//MdLRudBMm3ZrbsBTMBszoPjEqXk6VKNFzBdqyU6SNLVUzItmKO2pu2Et7A3HlLO2atNeE7TS
	mDtIqSfAPGTn9mGq+QRNmbfywqE/7yUzXmm5P78BT4aYJRx0LE9n0XVyevB6PDSG0woX63xhhi0
	73oH48H4jiCQrNfX4RDNcEc1z0ZtKz/J9dGrqqMduFCM/s1IRbhFTh81sp9s/NtezYA==
X-Google-Smtp-Source: AGHT+IG6xTq+Ti1BUqrEDKLSalszTpJgii3rcX/efaK1Kd+8NUIHJjne8zsTGpXf7+Z0WZA7xSgA2w==
X-Received: by 2002:a05:6000:2385:b0:3ee:152e:676e with SMTP id ffacd0b85a97d-40e4477738dmr18834081f8f.11.1759229389502;
        Tue, 30 Sep 2025 03:49:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:48 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 06/15] bpf: support instructions arrays with constants blinding
Date: Tue, 30 Sep 2025 10:55:14 +0000
Message-Id: <20250930105523.1014140-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
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
index 9b64674df16b..f2bf248fc88e 100644
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
index 34a0d9b845d2..c7f2a1e97ff6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21391,6 +21391,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
+	int old_len, subprog_start_adjustment = 0;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
@@ -21465,7 +21466,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
-		func[i]->aux->subprog_start = subprog_start;
+		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
@@ -21518,7 +21519,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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


