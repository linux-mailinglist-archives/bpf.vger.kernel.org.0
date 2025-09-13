Return-Path: <bpf+bounces-68298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EC5B562C6
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62A31B23170
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD919257422;
	Sat, 13 Sep 2025 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfikpdO5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886524A044
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757792027; cv=none; b=Oq5xe+K18tDmii4yGFvx/web5793yUXzsr8Nc9qaTFTaxi7PMSZnoSKpkFIm4XX2J9iTIhiTtijnx6AdmH6WkDCDxGQCRTrg+2kNdQEQHbga+GzPEGxOG14EocT1taqZdR54rzDPxXGyxNItYyKwSNIXy5lJnLcvOZ0G94E86Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757792027; c=relaxed/simple;
	bh=h8iwns1LrwvkJ3ubTAOGs3364tTKarV2je3T+ghDeK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIbZ0dAiHIQKMxxH1pZtqytOHMnEYlSIzgBWA/9ODIVWAwQwd73CG/EDEeArRFqXptPYNc4eFiVgFKLJqe3e7YdmCQ30JVKGmVVAxSgE/u9Tuw9NVCOBPrEO7BYTcr2XczZpGnGP+A9LTfFZoNdOFRFqW5D1nf7FaKW/kjjpVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfikpdO5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f2a69d876so578655e9.0
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757792023; x=1758396823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kxsqtGNDdnVEWzBbzI4OtBTodmhG0VZnIvInJ5vY6E=;
        b=SfikpdO5nTDZPzIIQopUabOlC5Jn/dYsb+jiFknsUBVMuaOFbZHIHqpGEhs+mnKyiM
         8NC0Jw0ZVKrJRMyqTwMYiTMSHXOOJS+8XAC9ZgS6/7Q2Xkt1Pe3Pk5G5p5h+IxpxXl10
         kip6Io8k6mrZcRT8Ouj4XxzgeyqU9IvVSaXP/ie9KP3PhD4BcGlf4vvO0U6UKxTU8Rs0
         7hu9p9apDS4x54GfMR1Opx5rB4spYufsSf+amavYa6HPGy9yl/LS06hr/a0xc466w9g1
         dlGJiruSjGgwgvbVQDOBbGfUeZIwrmr8I9p8bLpM/rkF1ZY7RuazemnaNE7Epe1xWplp
         /lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757792023; x=1758396823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kxsqtGNDdnVEWzBbzI4OtBTodmhG0VZnIvInJ5vY6E=;
        b=HBu2pWXCbAzyqHzz5JxfRdTSlGNVqb5UNLHiZyOhKiAgR/QibtKmoVzLfqhjNHHANf
         9AmpvEoLaNPqPsZkMYNsm9xLGdECtJS1lPwcoWNWwqp1aYf7Evgn3WLoKsA/UFlWPxFC
         DjQo7HnDn+UtUrrYSMITh/Ew+8C1kJcSNs7/L8xUTLQcQPQ3fTj6A29Z0BNpjnz96czT
         Mgji2U7MJqD4CEzB8Jyxmd9X5MCdp0NqAYh0HWpsidI15cg4YpdNtxj8OJCkt/c46l/5
         7n1v45PY8MO4/fBTAd/6n5ox+j90vsf8iwPaKOigSfkuLuPfM7cFtRChab2aqpJJbVjw
         i6YA==
X-Gm-Message-State: AOJu0YxaCC3c/MjCFQs0HB+8pTsUth7ghwB0v/qusLyXqawgmWXBw9gX
	woqNNzNUM3JYW3XM2WF3mVgN2fV+oW39hRO7FHixUEDDiBJWBaBgbUEEoi0Jbg==
X-Gm-Gg: ASbGnctXz24csleeBrPL+3WeaASw6pVi6LZe5tnJnbsICBracx+yvt89j/uDJlqRfQm
	qLwC/okMAAxfPXG5XdpXcxTTikr6tfSezGQECXcyLBy94ayRv6jCDjbPg/25Ahc76YMPkxox+bT
	Imd95vzfwij04NB/yBb7orvnb1JiBLicC3gBR8ZJGpqFA+yt8zBxkwt/IfPhU5T/H8U+MNktKZx
	3wAukw+2IJEU749KvmHxUgcOLzuyiMY++LZfBRnrdscwpfCkgjdcAuBirhKuCN8NpA7jUEOEDbd
	LTHnGHs5SBAKfdPIrEHhB05pKtOUR4wzjl5i8vnNMTGmfd9tl0372Bz4eUVSPId2TAF+FE3VjmY
	wf0MNGJKKgXlpDtZ8Zz2bXiCXgwdPnRkimQtTO5hC0F6PlFPHj+Do
X-Google-Smtp-Source: AGHT+IHCTuGhreh8rVUb/7CfKHWivxf2rUdJmjoGOgqOTY29AZEm3EY8KYl0EnAK3Vje2PxFlWMH2Q==
X-Received: by 2002:a05:600c:4443:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-45f211f7572mr58721095e9.23.1757792023320;
        Sat, 13 Sep 2025 12:33:43 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm4948753f8f.27.2025.09.13.12.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 12:33:42 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 05/13] bpf: support instructions arrays with constants blinding
Date: Sat, 13 Sep 2025 19:39:14 +0000
Message-Id: <20250913193922.1910480-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
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
index 1f1708fd76c4..4261486981a3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21564,6 +21564,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
+	int old_len, subprog_start_adjustment = 0;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
@@ -21638,7 +21639,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
-		func[i]->aux->subprog_start = subprog_start;
+		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
@@ -21691,7 +21692,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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


