Return-Path: <bpf+bounces-73259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D15C296A4
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 21:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7A254E247F
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F281C860B;
	Sun,  2 Nov 2025 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcI7HNfO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21581EBA14
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762116717; cv=none; b=up/5iZFHnmEK7bhEoM84L8NyF8u2I8lArWVEZ4Mz1g/AKcXmjA/jeU/AoHaFPK6HLzh8GHvjJ7b3ffYhgZEBS+WtSyBRQQJrGOMnhEN6weDL/f9/rqFcvwk8QZBFpRaSfPx/7Lvz7wnP/Zq+cHxytATIXOJgwe8NmF+UQVfZNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762116717; c=relaxed/simple;
	bh=mi5vqdhvEQodKsnQFWMNDL4Z3vPP4LYvGIeqIfcW+TU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kq5C7IJDLJTVAbA8volt/8wBglXWD1+4Wx55golhw8SXsgAQzpeMng8qFgpqYy8xet/FZV2wdflxKmWOdYVeyIFf6FCbWCRNJKNW+GpeLuf/Sc1A0QsDwPey6fxe2mDEwg8AXDa/Dyg5ruJkjkvDccDOrgqB1mi6vgDgAphZOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcI7HNfO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b64cdbb949cso612122466b.1
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 12:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762116713; x=1762721513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJtpEOqqF8rVJaCraHcAZ7P2PQnvf38Tak1bs06w4sg=;
        b=VcI7HNfOmPlBCL6IHLPh2Gqd7nAXumj2KWy4mJnKq+8tNBrrRL2fQDEZpldNRJBdxz
         THjVDnyMGN2Tm4J9td/sn0MuJAsxIVgZJeUtpmphDXibSbw/Rkr264aunBRq84hoummu
         +cpxhuKxPc2+ieS9Pi7nI9if7gKNGruVUGVhu/T1uoNpRDvPOCLXO4CcJB10iQY1i8e+
         /MzYrk3hqn6WO7LLtm3PFb8JNtMhey8u/uiJ6Jer6msL0mfgMwFySl7/WNfjsO/WzRkc
         TboKQu6FewypGRJlsrqHOKpEfhoiPZ/Y+CCKWyzTko0SDQtxgBsEVB/yzmKyNFnDYtRO
         ui3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762116713; x=1762721513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJtpEOqqF8rVJaCraHcAZ7P2PQnvf38Tak1bs06w4sg=;
        b=BYbF1RozwpZyRF2tmCrvAkWzZn4e3OI+1ObOMGOpCaHiYjW+EDzPLJxjuKKEzCTaRx
         EzDuIJdw3OAWxPoBHZ+TsjMZx7GIQvirW5g5mgm73sZaMpZioa848CizhTbvevt0fDPg
         Tle3WmsFInUwLcC3zVU2dPMfBWiMju/xiNyK+11fxLNEilrmAbXfY8F8DqdPce1KiXhT
         WVhJEwBZYz26Kq6vLfSzzAuc5T9ptSD0jDaVrmdGajkx/3Y5FXi1miI2bNMuBGoEROGI
         MIwQnbS2UjDneZlC05fdEib5rlX1DNUYmBksb+F9jCe+ilK2V4Hvfu3m8TMnLB8OMB0d
         HlkQ==
X-Gm-Message-State: AOJu0Yzp9g1oTinx0SZ271BGjh/L/35FWsZ+rKOpy//sfnC6mXqohLRl
	GJrvEFbj450IMAe4AL4TbyRxxfKdnbi5nFbN3H8iATReNyftFS8Y+MegR8Y9qA==
X-Gm-Gg: ASbGncsyzrvQo4NzxP1SoLcOFUzVeU/UuF+9Wf4kLE9c+ksCL67p3wqhDdSgrPs1yz2
	xq/+Qh3ia24m3yYrov76oCiNCjD/Af3uB+1VxYRKTdXnyo12/phohkdwIJCFMAs9ty7zhDI5tRp
	WOnTFKWuCjaxuDZGix5IiLnQ8rYjiIqpAf+rPAqsekwAWaQIif8QGyvarB01d4qNHPuflzVQhui
	nSTJ7Bpa34EjYcQTdX5avIjqhljMXgGdMLa9C1PD3M1nryheSvx7msAVSe58+cdSbtcT7NjG+UW
	5j85iReGouz/j6erWC37vmfRLfvF8lGasSrSQ2PtEZvuAL7M6j3FzBElXzU7SZmtMgCsSqw2hDW
	hHwXTVroN5A+izmeDq9BvF8Vi5+iT5u7bogmjBRo8MNN2sCg537xggeElizSzpZVxRE9iD91mEP
	jvPyaugyZa1odrMGbQmeXdv8iIH80dNg==
X-Google-Smtp-Source: AGHT+IEVW5fn2QjwENjgCvZHdQsZKE5CievjCrbDhhsyLQq0dum811qVDJyBfRIB8Jl1P2SS30dOCA==
X-Received: by 2002:a17:907:60cd:b0:b40:c49b:710 with SMTP id a640c23a62f3a-b707061f133mr960035866b.47.1762116713393;
        Sun, 02 Nov 2025 12:51:53 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b71240c245bsm14029566b.10.2025.11.02.12.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:51:53 -0800 (PST)
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
Subject: [PATCH v10 bpf-next 03/11] bpf: support instructions arrays with constants blinding
Date: Sun,  2 Nov 2025 20:57:14 +0000
Message-Id: <20251102205722.3266908-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
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


