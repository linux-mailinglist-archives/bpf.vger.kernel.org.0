Return-Path: <bpf+bounces-65823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ABEB28FFF
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 20:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C309FA26437
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66ED3019DB;
	Sat, 16 Aug 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChrcBLBG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500DA301498
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367329; cv=none; b=gsd1bb3DvDZt+WAMeVtzO0SLA8VQRWBRTrphOul3Hvu1zmzz5Y0WIit1LQU8C+/ZDpumCMzttgkoeFzNay/kkKYhImW+lq8AbdqXS7MN3TAcBstWKBn3krrDYNYArwm3mNDXYPXSK9QEuO3Znd77L0nS3vrpe49x9E6RL/+4sIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367329; c=relaxed/simple;
	bh=pGsCXLbdGGTsSaFpdd8/DMZeUoZ8ZR3WsHJhmSHQri8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBqVpdW3+auHX87Y6eXp5mKERtdQGlcRjBVjUViFz4csZwwJO4t9Eh/WEsWd7JqtGnJtj6ZDCNqNUJcFk0BEwQ3+HvIlVLxvKKIeIDZ4DRz0nBu0x6OmFfgIUqxfldIE5tFIXiohgWR84IVYxIkf6+hrkWl46GARB3wZSnzaCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChrcBLBG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0becf5so13561275e9.2
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755367324; x=1755972124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSdG2maZKT21zwZDLFHVm8O9AySrFID+XhBN31Fz/rg=;
        b=ChrcBLBGaQrPMxWiTKxl1O67XO7y4SkXJzwozRj/SfBckFpcKUPcixX98VmQgFxGRZ
         plkIbO9N9/r8GWtghXdKPtnozNFli3N+9TOSzFSEmaQKPXuC4Q3akv2WN/R6+qbepNjr
         WZxoyM2K/tIZZFIHHiwJBQ+wz97bgRQSO+xT4Z4S2qYEQihnbMJRBlxiP/ZJ8cdUmB49
         he7dmybrK2aSA0wTS+1VfUV3mBG+7IJGRhteygf5/djGykwl9JSxcxYzG65PIxMriole
         wmUYRI9cAeVBQkxGTrHCaTcqYmNcC+uhLwmQcAdee9cB1RislIzrho9nuMYy5J12dji+
         hPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755367324; x=1755972124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSdG2maZKT21zwZDLFHVm8O9AySrFID+XhBN31Fz/rg=;
        b=XSp2bIzE3rfjiBBLZ0+KkDhFrTiP0XD+uNvYhjDBiUFYmYl+2reC7L/59wp95Za+jT
         LIymvY7W6U1MzeGUeB9/OESDjKuZxMHcfIT4r7ocL9q+tS0WCjKWTuew1ZPikvBW2c/f
         AZ5FWZUJ9qeyg7TRNkRK+gYnzBrXxbq8axT/JkYON2hkCBzl85xpbpsx0T8Zqs1dCNhl
         L49/jyHpMOdbHUcD41nL7XNWHeWQcprHP4NbgmCmB9QMCHCstfA9ptwYezKqDqZgI7IZ
         l7Ev8lTcEHYiWrsweYDNSqHbMdccFpU2jjfweoFQ5TdHBf6dlurPjxPT1pTCJ6vq2blw
         dZhQ==
X-Gm-Message-State: AOJu0Yxlidb7NV6Omu0nnBk5XfaUReO8xqlHGzcY9uEERFbzWsuwMqmr
	h5kp/O44ORYE7rdlngPdNDdhVLH0UqCbOlL8M4QPAwFkODIga1EYRXfW6mcfiw==
X-Gm-Gg: ASbGncthiQylloEIBzDWtA2fl5lml14bs5eln1F2BssrqBV6msHtGykCAf1RkNhQxlE
	ckgiwlgHSH+UdvlmU33PRk5YcRjjjYFxt3dCSE9bZD3cyoOheFVRw1oCm+a6G2PiiQGhx5ch1s8
	tvdKM+zDSjbdzzNqxBElamfTmbobZCKGBWgEDePqLb0IAhad8rXFypoc2D848YzGyGX2HUTrO1o
	BlKkD2eXCRRe84LnlY0HHBB16mIWgajd6LrWZi++GSM77EjQj3kUKcqn7uFf9p7vGdpa4H3axYB
	nsNFrTXTNbgTN2RuCIYQSOekQxAQJnWG1xZO6dlOxs2XvCSMCnAgpEiIG0WUT7pJx2gkhPgoqtu
	ytMMHYnoeGEfJ4bWl6XpeJX6AhqZJrjlNYLLp+sUI8UQ=
X-Google-Smtp-Source: AGHT+IFFjBWioWEZA5GPCPr0LhJgT1NjLjyixjoh5Gfq2gDuaa0O2Xs6DsCRDgjBrFOb36UID5UmBA==
X-Received: by 2002:a05:600c:3baa:b0:458:bc3f:6a72 with SMTP id 5b1f17b1804b1-45a23d36b37mr45955845e9.4.1755367323932;
        Sat, 16 Aug 2025 11:02:03 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bd736b88besm1080193f8f.67.2025.08.16.11.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:02:02 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 05/11] bpf: support instructions arrays with constants blinding
Date: Sat, 16 Aug 2025 18:06:25 +0000
Message-Id: <20250816180631.952085-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816180631.952085-1-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
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
 kernel/bpf/core.c     | 19 +++++++++++++++++++
 kernel/bpf/verifier.c | 11 ++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5d1650af899d..27e9c30ad6dc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1482,6 +1482,21 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
 	bpf_prog_clone_free(fp_other);
 }
 
+static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
+{
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
+}
+
 struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 {
 	struct bpf_insn insn_buff[16], aux[2];
@@ -1537,6 +1552,9 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 		clone = tmp;
 		insn_delta = rewritten - 1;
 
+		/* Instructions arrays must be updated using absolute xlated offsets */
+		adjust_insn_arrays(clone, prog->aux->subprog_start + i, rewritten);
+
 		/* Walk new program and skip insns we just inserted. */
 		insn = clone->insnsi + i + insn_delta;
 		insn_cnt += insn_delta;
@@ -1544,6 +1562,7 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 	}
 
 	clone->blinded = 1;
+	clone->len = insn_cnt;
 	return clone;
 }
 #endif /* CONFIG_BPF_JIT */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e1f7744e132b..863b7114866b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21539,6 +21539,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
+	int instructions_added = 0;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
@@ -21613,7 +21614,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
-		func[i]->aux->subprog_start = subprog_start;
+		func[i]->aux->subprog_start = subprog_start + instructions_added;
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
+		instructions_added -= func[i]->len;
 		func[i] = bpf_int_jit_compile(func[i]);
+		instructions_added += func[i]->len;
+
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
 			goto out_free;
-- 
2.34.1


