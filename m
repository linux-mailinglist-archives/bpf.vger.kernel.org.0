Return-Path: <bpf+bounces-68756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C3B83CFF
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF177BC042
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB81B85F8;
	Thu, 18 Sep 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpn5AVw6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67622836AF
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187967; cv=none; b=e99V6jl4KhCIFEkmzaqodWBg1/dif5ftAi8lWphOSAuLDIlEvUQORFUqjxy8w9Z6rX9P1+KnwiQDlp0KbfjVnrmfsHUjEphhfGDQBhg+Ra4HVWOSe+UyoRDV8SjN1eETMep+RwDjKFv2ytPOqr930KbjeCjPI6m72TSRNgKpfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187967; c=relaxed/simple;
	bh=jI9nvt0YLSYULmP1D9RIgGNskKsGb8gxrLA2KqcUeTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJMK9IZv0zSzNL9jBitIA2EUzl3vkqpQv3apVzbGUIh8DWEvOdDJPFpZxplHPWJUxk4EPPH3RWuu+doEsLDNkZ+pCDV7mEesrQmt3trWKcPOgKmc13TaDLDJLnA/QTXOWUxDsRgay4792Hvf28fqZGRN7ndEzZgShxbuawF9vzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpn5AVw6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3eb0a50a4c3so451402f8f.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758187964; x=1758792764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80BWv7l1beWajQONzBYuEDZmZMQLcKkpw3+E47n/Fj4=;
        b=kpn5AVw6t3WTZzIzjOQ0eCqgun9E7dtOVTXvEsTAJ0hRzRgfSnUx/P5w/YwtBjoZsx
         KEuHTAO/NOxoQOR2DaNj+buSUMCuUTmoxhwSdThwhyC99QvETbvnoTxoj6bLKGjAon7r
         xP8GUjDtwpIs7UIFN2odHdbdz0Af2tldzdtsAuQCI6usxKdD8BEBMNd1Q1mib1IED7wB
         U4/y6kDGWNeIeqD7POzUHrdSS+ZotnI2u3g8MFKI1pyjpNNZqGeRK5ZnOgQFUEGIBx8J
         0/jW8o9hZGKE7gXQ9L3bc4J4dLhAf2yh2VsfhCoPWOIExPdJgZh2KkDul9IJtxlrhS78
         I0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187964; x=1758792764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80BWv7l1beWajQONzBYuEDZmZMQLcKkpw3+E47n/Fj4=;
        b=Q6lYQ4I9mqsdThXmOphBGnTifAhrnOzim97655dw4khndmtfzHhLnfTDvtWMQzAjSM
         4L27aZkAlccPOdJQjX9HtYz8H3clo0RCXdKf91O/vOR9DDgTP2hp70qit0OwTNJKzsSd
         GqRnpFpCrPHvo794vbGsug7lmy0HmlZrdbFeZ/F0VFLV8Owf21IM2CdTULzD7Kfd2V1V
         K6+qSR6M6ymw/tfPxZtQGw42IrSt7j77R/clIA7F78jtSM6yNxF74CyHjJH6YQxaygHB
         TZeix00Pf2tKW1pvQ2l/+4yBbxs28rhpqtzEk8caOyF+KrZh5qmGxQDAMK79ooSt7Zw4
         DQCA==
X-Gm-Message-State: AOJu0YxktEnGq+B0+WF/m+yHPuOMeARi2N27pc7mddpk4IC+dM9u/A98
	1JQnQ5SaaIVopnNx7FsxBSyOjGToBseqlauNTO0RGx5nOzvp/DxM34im65gh6w==
X-Gm-Gg: ASbGncsx+cJf7xlyATETkSRbbYoBagAA+NuJM454mAt8dbdemDdj8Vc98M6jL9v9giE
	3cGSZuN45oOsxA4DNTI4ZLuglND/fTQRttFdkuCH3fHsADxPFtkgsqdgFxUT5SOadYF2H/9or7k
	HszlIZlIm0nNZZu0aaSAU5kygDbvFuLkAc23zmbvKqUTQFd4hbWBwkhQlvzJCFpvXCAt2Vo7A9W
	3Yh1iiGBFC1Q95ww2a3a13WG9+NGIOORbFCJhYP6a2o5EZdocQFgTMBZJuIaFKaMst1k7b5HdqC
	Jf4H9opACBZeU1SqzadUx1qpgCN2kWQZ7aHlSqkNdlAauiAct7O3BxLHN3CrI4IV1hDV6BOGM/P
	WUnGPhYDXL3I+/OTCeYm4V8hojCUt1l6uWa2VHDpBlks3ijaFzMV2u4lEsK9Z
X-Google-Smtp-Source: AGHT+IFNPkEp3pdeYwDIHeoUY7Ay0Yk2BSxE8aJa8yjItu0fBDH6YN1Hf0YYP8uFGEdSKhfYjy5wpg==
X-Received: by 2002:a05:6000:2082:b0:3e7:492f:72b4 with SMTP id ffacd0b85a97d-3ecdfa32db4mr4454873f8f.42.1758187963389;
        Thu, 18 Sep 2025 02:32:43 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf0a4fsm2775026f8f.52.2025.09.18.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:32:42 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 05/13] bpf: support instructions arrays with constants blinding
Date: Thu, 18 Sep 2025 09:38:42 +0000
Message-Id: <20250918093850.455051-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918093850.455051-1-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
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
index 1cda2589d4b3..90f201a6f51d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1451,6 +1451,23 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
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
@@ -1506,6 +1523,9 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 		clone = tmp;
 		insn_delta = rewritten - 1;
 
+		/* Instructions arrays must be updated using absolute xlated offsets */
+		adjust_insn_arrays(clone, prog->aux->subprog_start + i, rewritten);
+
 		/* Walk new program and skip insns we just inserted. */
 		insn = clone->insnsi + i + insn_delta;
 		insn_cnt += insn_delta;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7ad4fe756da..5c1e4e37d1f8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21578,6 +21578,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
+	int old_len, subprog_start_adjustment = 0;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
@@ -21652,7 +21653,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
-		func[i]->aux->subprog_start = subprog_start;
+		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
@@ -21705,7 +21706,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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


