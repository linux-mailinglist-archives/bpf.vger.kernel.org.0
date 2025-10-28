Return-Path: <bpf+bounces-72539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15BFC1521F
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F7560480
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D3336ED8;
	Tue, 28 Oct 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvEnCYgC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ADF335BA1
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660916; cv=none; b=kflye/xEiGzi405O03Tq+NzJUJzmPthATrUbVHvEq7iMZAId/ag1Wpmay4kEd8JkMIBSlTn+30VrQLtwKUw74b79h7r0A22TwnsZc6p6tIzLfK+Kp4Ue73GWZGcs5gte31OWC1qVU8sAuftVFHIYAcshUXbk4KEDwqWyLZJrXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660916; c=relaxed/simple;
	bh=mi5vqdhvEQodKsnQFWMNDL4Z3vPP4LYvGIeqIfcW+TU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgcbQ+bhj3M/IrCynzg2npX/v6RZZHNDHjjk36MqRqCGXey0fHTjvow4pdq6A4dxbSq3s4vbPpTCPF0pTOI9O35qZ7AizxT0spJIzewmjdj3R489wRsRzqf7Vb4Qu2TdCaptJoOs1To5v85RCBVJYG1msw0O+clQ3GwANc4d7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvEnCYgC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso45738465e9.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660912; x=1762265712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJtpEOqqF8rVJaCraHcAZ7P2PQnvf38Tak1bs06w4sg=;
        b=EvEnCYgCj/DGs59f+OyeFV29rtbPla01RPmVKqPbavDayxbwGNSXGdeIH8Gsnk3JSb
         XuIFlZL9c/rVU3iKkpLM48NZdEheOhyVx/7nYcGm+iLYHbRDFi9oX94L+ObWMILhN7Ea
         xLF7mSgpAyinDvSG36S80Suoxa5bd6hQ8E3HMXtdIQx1QdxJjgpzdRAc7SuwQMqO9MVR
         rtFTT7N0Ett+tkHwC3kbQH+r0sLasUUAO5w2/Pyfi1IIFRHB08dcN2Ks/Qyz+pU9pmHf
         Uz5M0EwbKkBbuEuZ6X7LRe3vDioHgxHn17xkp9+C9nwhWw0zggXYXF+bnj0pSZbLw5di
         CKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660912; x=1762265712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJtpEOqqF8rVJaCraHcAZ7P2PQnvf38Tak1bs06w4sg=;
        b=leK5UsawIlguZQld0/aq60+cSrBq8P+uCaqNEiaTNkBkLDevYWF1Fja3Ui4/RwIiar
         gcXWq6syd/F2SSYT3vGfO/tbFviAEiKN/55EcHp3Eim9ktYbP/xxz9R49+2m7jtl8Wjh
         1IUoQ/4oZoq6R19q4fpRCxnTVoPWDB20ifUf3CklFe472xmcwna0istZK/vSW0C4cFUH
         DZlcBvagFeHVXeLxnvlN+OP3q9E3HSgxQIv5oOv9NOeYOywAaJpLCSLh6gdaTaWfTsLZ
         Mr6Ft0cpqpiJyLzkWdq2zCb5qV1Eg2t0ZrKP0RuDVP1yl/OprKDFf5lqpo5stpYuxuX7
         6YiA==
X-Gm-Message-State: AOJu0YzV3IgjVlL/TWdzg7xhn/+mv+3RUiU5wF2O8uarkS+b4Q18zQ3w
	9Sh5HpUDcPKHN5jyvnspQzP3KGP/wt0GM4y4FvnRqxVlTdN6yQeofMd4+eCfcA==
X-Gm-Gg: ASbGnct/6rCC+u3wlmAEMrYGehTXZ70niVi4uouM3TncGJs9BtldPDlmTJkFb180gQg
	fOV04o/CBzqowaPt3vMUqnVZGXPat1klc7fa+84DyOU9MdnSnZSx6jPp9VaiwzDftKRmUglrwpo
	ub3D2wnELyYhb1lQwwBzaSaJT5bnuVnbD5QSQWHEZYWc1f3R1q+mbJlI2E++EW6RTSi31zYq4DO
	qHZ1gfAUBcOY+3ukMcmiSdPmHhp9HPE614HEThTqeH+b/4BLN88lG9b+o+WSrtOzeqHWGEupLJV
	UOrzDjhkxVEzsNIAScxBBXNc8wv0drjLyCUwsNWwSe611AI+37zH9sn1iRt8UT84riN2QjH3lGB
	+40u66Bs9XEJIZaK1tPZ0yhBs+NooxyBzjzCkLumJlyMvl5JQOtxdr2UYrn1FYUr7SsRDYqvjp0
	Mxt8imuA+N+aL2wpc1n8s=
X-Google-Smtp-Source: AGHT+IGajTIY6OJP6FQ09wZ29GxRFUfpsj17ZfdHbTYuWQUZJDzxy+omw046NIL+UJ2yVMit1s8H6Q==
X-Received: by 2002:a5d:5c8a:0:b0:429:8d46:fc40 with SMTP id ffacd0b85a97d-429a7e4f541mr3755449f8f.25.1761660911994;
        Tue, 28 Oct 2025 07:15:11 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm20867060f8f.21.2025.10.28.07.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:15:11 -0700 (PDT)
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
Subject: [PATCH v8 bpf-next 03/11] bpf: support instructions arrays with constants blinding
Date: Tue, 28 Oct 2025 14:20:41 +0000
Message-Id: <20251028142049.1324520-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
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


