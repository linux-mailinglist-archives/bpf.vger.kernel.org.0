Return-Path: <bpf+bounces-73592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC6DC34A22
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D418618C6DA3
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9DD2F066D;
	Wed,  5 Nov 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJGpWmlr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C942EC57B
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333086; cv=none; b=WZUnLWv7o67UBadiL05ZaS4MIT38y0rSJurx41A0+g+EgxzR4KG8Gr0C5hAOaXF7pIuv08lhMWpsPK4I3KCALvTAlmucpu638QPZzvFKeEG4zAmHc2onPnmys6DnVAU5CD7TdDVhdXKEbFoR6phl8urHb4hQ23tG9LhikRVecT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333086; c=relaxed/simple;
	bh=GwKGKj7KPkMSTUEOdhMmgZ6ZxlXoKo1lpa+VXwQdt4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ln7AQR8iLb2BxSC+MWk0tQC8SLoMI89vmnvy/nmbGDGjFvYBXLjYMVh6AVeZBegQafc+ptYLJbEszA7BYrb2/UgjVTDpRhjxiwq29FGvN+CiceXn0VUfBBOpMZKvSn9Y4ujyAtfptyhUHpjmdepp/7LqUAQl7XD9F505khh0Y4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJGpWmlr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b719ca8cb8dso364803766b.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 00:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762333082; x=1762937882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWClHh9GT02vRGMJFYpBnAlsQFud+e6u8FbbNXu4mzU=;
        b=hJGpWmlrCdE3fk4CVeCR2qJDurUlIClZxDaaGTXqHBfCzFaKdtwjP3COjFoziGqSAz
         1GTB6QcQQYFniaVdOHZmb48UvdyvpRGA8oKUpvmWutI0ZRrSLKnpy5xFEJEqKJP70cX0
         uKU/triEY+MwF0Sn5jocjwRh3mU0V3D4VMWtnFKYQAWNLmdvz6i3Vex1HINyHnDjlZbF
         QUFKVXmjZgvbyhV9ljijGyiScLa9yKDHp4rQKQXWTFXxmYN40UfED9mDaRPoPE/dNstC
         yHtSjDrnX7NUg/AEiW39B5tkr+D76r+n3/iyJtgnVIVv4wty16bIzrEtxkCMjBokfTC/
         Jn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333082; x=1762937882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWClHh9GT02vRGMJFYpBnAlsQFud+e6u8FbbNXu4mzU=;
        b=qxNAviCmYWeWc2SM3T/wsMjpVbxzzB1o6nPi1TPl+GKFZhF75QtRBHybjEy5wTKp/J
         QAefHmFgWHp4+FQwnCRl8r2hoFU+kD6I2BeRCTrfXOiATroyMxKti8Zn8MsADaoPP0Vw
         H6SPQbY7s+eDKEGq00kAvWCRCnT97Az2aKjGeHPjVAJW8867YQZr1/LBZ4FhTLynbrEV
         iPjril3hrCheycoCw2N3TNG7hxTVvJU52bNjAIGMDEYqCkx/fnM55a38L27R8FMWy9Q8
         pDos2gJ61UPdOQHv11N4wyQ0s+SbOxRXNXfbbLRZ0iQEfk/Zm/AD7Q5NMec0+HqdnaH5
         f3fA==
X-Gm-Message-State: AOJu0YzwA40xAq8pjznPV5TWUJ0QCxQtZs+ufIZsWOdU5ecKCNn7wOJW
	xfgs8TQnDYYXk74cZqDhMSnWtZQ8Dj34ERUmHGsV4DAKWSSZYaFxXzMTA3cu6Q==
X-Gm-Gg: ASbGncuHGTKFwOyPsj7Kco97oqN7h+z4XeBtKKSyeMPxZFLdZfIpje3uHAqShGDR0iM
	I9DgMzrcusiXgpaG4/f/HqcTdQT+QjTecQ4JuU6YqMOn1MVtfXpiivNiX+uS/oj2zApwQVE/Bry
	KhvNct5fwTinvGR1Whwa5U4RR7d+BLy5QIf+iABjMpODFrMHIsKR/jkRHljJqlIC7wN5gtGUo7y
	w4NJ92DNXl1c7pw2pjBzWku4nFU3xfLbr2E77fjiyTiyLVrzvV7GSsXx4rzQDw/d9h1agqWi4FD
	qXkfkDatrphPBnGy+UjK1nSyA4DdqdF+1aCdN3uewmITeKK9YlIfUjAs42L3Urb9QKiCXrYh6ua
	2q5ICeoB2RckszrNnF1CwBGVpKeiPnDlPJnvFSyU8ZMWJyyJ+J6R4YIUlFA9I7DnSNltBCs8Smd
	Xa+8w6pv5TuHAOSPekDUZ3w5HhDy2Qyg==
X-Google-Smtp-Source: AGHT+IFhy+bQeL6yG/oRUjdR1f4OsESPrCchLLNajJML7wmyfCesVAkk3JpjNDpH3UDBnODZK08H+A==
X-Received: by 2002:a17:906:9fc4:b0:b47:de64:df1e with SMTP id a640c23a62f3a-b7265195d0cmr259850966b.4.1762333082398;
        Wed, 05 Nov 2025 00:58:02 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723db0fd12sm429685466b.32.2025.11.05.00.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:58:02 -0800 (PST)
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
Subject: [PATCH v11 bpf-next 05/12] bpf: support instructions arrays with constants blinding
Date: Wed,  5 Nov 2025 09:04:03 +0000
Message-Id: <20251105090410.1250500-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
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
index dfe5741812b9..781669f649f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21632,6 +21632,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
+	int old_len, subprog_start_adjustment = 0;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
@@ -21706,7 +21707,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
-		func[i]->aux->subprog_start = subprog_start;
+		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
@@ -21762,7 +21763,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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


