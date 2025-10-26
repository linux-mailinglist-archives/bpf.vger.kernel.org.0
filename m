Return-Path: <bpf+bounces-72260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE7C0B115
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0F044EB0D3
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8FE2FE589;
	Sun, 26 Oct 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXJbzkv/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF912F9C39
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506444; cv=none; b=Y1SjkvZwq51P/75ejeAsdY5KR6CBmoqyf6LAZsC93sZo4g8/wbjkkBETEV0jbbFVkrom9NAwo7ukv9Tqf3Kys1EqZN9OPc2/G+MaQkCRpXQKO9Ls035985JgwhD+LAVfzDndHJKBau0mTZ5Z6Saqq+eE1yeaARo76LCJhJJlV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506444; c=relaxed/simple;
	bh=69oq/iI/3TJxc5VRD0UblQW8yrtZ5mR8DKwjA7X9a6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jxs5bzLJ6slqbNatheArVr7aOpxJ+oKepvAweyuyvM7ZKoTwRro6/OMh+LMBQBTKEQwJ6cezxX0+N3H1BzEnbKROEUPiR+vgFVgnPDtCYqQt8re2xi9t77KGU7VFWmwJ+pu1AtDhTeOx7BriFLL/x6WUIMiOxK6HMMjY3ET8g94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXJbzkv/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475d9de970eso15173595e9.1
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506441; x=1762111241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrKLZDRfWvbluPcygsQvBBxPhK2PIDJKRyS9/vvIlIA=;
        b=RXJbzkv/Zz231mWxZY6qMBFs09Zo1Qq5Us3wm7BN1jR3FBwmCVmZSwQGmCZ/7AH3Pw
         XFET7QlNfDryCt4KdYHMzrByTD7dnh0h5bR7NlRTwu3diK1oxnDIa2loD1GE5PY4PvlB
         ylYWsrWzYKegPcE9qFOANOZJfvJU1ZQWbJ1ZjixngtD2lbxYLKv3UT54NiehjE5rqr0n
         AO1WnW2LF9vycFKOSfGqH+jGSKYHhLwQqQXXfgJJeEjXQlPSMuRk8wKb3z7hF+02KgK+
         CSrbZcTOHjGGzVwxU5sF0A8wsyBGie1yzBJpuWy0C9UgsT7KnTqhCCetIA3rPw2bJKie
         6Qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506441; x=1762111241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrKLZDRfWvbluPcygsQvBBxPhK2PIDJKRyS9/vvIlIA=;
        b=s98LJXQ0w7EK6RGTO1JYu0UvtuyL6FlT47jRpLNat8/cE+Hk3INGyTBCSv3S6Oi523
         ZWWw+Fhb/eTeKmO3kIBAPzdEe7N5LTNV9R83IX9TAK2Ugpg/6F58vTgQOE2JtUfcOpcb
         XY9pJJIxTi3766rSI60Dyt+nRMfAjh7AFhG3tw3vp9DACWt57eMIZBHUsR7WUSQSqIEx
         WKevhhfIGuB4tedq51R4z8pArZvJjEEmODFCtddMsC1Op1Xh8S+Z1BHdvW/yjb8c+ca7
         t/AUfKc1tYCkuY/nrPl7TrDHO3isra/i2oZFtxH9fvrLWuBEs5onx01ZiNwVyLfUmfjF
         Bsaw==
X-Gm-Message-State: AOJu0YzickUgqA3TUC5CtDrNWmcOv2xAIl7b/QpTgyXOJybEbKTmwr9F
	Ss8FcwE7dUJEimcsbsq6wU1QCU7OIgXAPnSq+od6cB5KCJv+fyZA21LUBuBr7Q==
X-Gm-Gg: ASbGnctDV9xZtQsL4yGtlCr5bcuQQ2FJj6AZxsXU9UvepL0R9ZYQPPLzaB2/Y5IGSPu
	uHHXZpRHzDiVklUV3TTR+L5/xiuQ2YW0+voEFSJ8dVXntmgoJd1/+dJ0EsCLhOjnN16q2Yk1MEO
	pfwB4ZUnW2CiIqIcxni9sTiUdigpwrwVDBQJNuMxeQJmyZ5kYUR9dea0KxLIxjD8UB4GXB5r9aO
	kO+g2p0JgY0gYVQmKkmGCSHGau551JhAyxnPH5RkIkiwqWPHiPIJoaGe6NhZZEFq20mrSg5D5jL
	kJow1+bby9E8ACkC2clpzHsykEPxPctUKzHfqSo9YxhM2959R7mooh33L44Wi8Iy0F3KPtPaHU2
	TLHG9NhmbGHPl3MsJb2GHt0blL0MzE7aP9yoYMSj5p6sHz/wAIKkOb11s+n7kef2E0NOyWA0gjA
	l3q0/8UMy4ZkPeMGRGZOw=
X-Google-Smtp-Source: AGHT+IEFuTJn+PjuN5i9c4v1EDwRNiwZ7eGgsn4S7rea/0DC5FGYloCh/ZHWA3aNP680QhOSXBRjSQ==
X-Received: by 2002:a05:600c:1d9b:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-471178a7d96mr241680105e9.15.1761506439118;
        Sun, 26 Oct 2025 12:20:39 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm92434375e9.5.2025.10.26.12.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:20:38 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 03/12] bpf: support instructions arrays with constants blinding
Date: Sun, 26 Oct 2025 19:27:00 +0000
Message-Id: <20251026192709.1964787-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
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
index 5c3f3c4e4f47..ae017c032944 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21591,6 +21591,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
+	int old_len, subprog_start_adjustment = 0;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
@@ -21665,7 +21666,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
-		func[i]->aux->subprog_start = subprog_start;
+		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
@@ -21719,7 +21720,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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


