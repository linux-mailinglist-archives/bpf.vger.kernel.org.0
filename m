Return-Path: <bpf+bounces-71321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F34DBEEC06
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DCB3BA873
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0471E2EC0B9;
	Sun, 19 Oct 2025 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpPEhhkW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B972E54CC
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904932; cv=none; b=NaVzkiiF5BOWtd07VIvenJIbwevLptgSb3MplJur2RIlODVMJ6yk+AgwlTYcx83TP0f/12Xe08dWzTzMjfppqy/cS/Qd008ufowNuJcHS6iDZ55J3fCmcqFeugqb3NwYPQ1P2ySX6fUv7KlIN1FwmWO1NdyWDKdMblAg1TNgaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904932; c=relaxed/simple;
	bh=ASbzZuolOLhqUhf38p/9Olm5jGU2wtJB+s3bgbzKwu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L1ens6P6vIGSwNpO+mXPeWd+u0jhdJ/mh3QUtZo8Gy5nFZ4mBL8/0NW0rbmIk3fVzfecjlb+KKB6gbmzzrzqDM3spa13esaPSx7s2Q3M6hcPP/88H2VBfafUypF2BHVwpjyE3C+LY5dJ6cEFZZhGrr0Vkph23RCaNqs2sfSwpek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpPEhhkW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47106fc51faso42958355e9.0
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904929; x=1761509729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngsoq6gTBwdBT4bEgLL6cRWC7lDOlMSTpZuvilHELjQ=;
        b=NpPEhhkWNrHzzpF9HDyQsfxCkB/bMRe1Xn2N/8zBYgtK17NPY+QRhRVoU9rzQ3SBtE
         yPSNWtYicp0gMwGeOUyzU3j2CU4y6lgrhV51poZw1oiReGIHsTY9JYk2h6pU6QL8jnFI
         GtyHju3ou6hSkGkkEc/yPL66X53HsjO47X8kHGblf+01igeH+1IxqtytSGbhhN/jHMNX
         IJJ93WpVINbO15MA3fDTT3CR7zh5TXaBT3dhMXUWL14r57oSimcVwjSIez43WAkWgkPi
         G3+lLlqNJqsdluCAl/NZcqBh1jUpG7tyn1w/U+8NG4vVayUtQfOXuL7TDWF3IM7Mzlkl
         ZYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904929; x=1761509729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ngsoq6gTBwdBT4bEgLL6cRWC7lDOlMSTpZuvilHELjQ=;
        b=JZyoB3BECIbO98rAkEl6TVpgQZrePEtmse1mprAcKHdLNpy154NCIyDHzagODKChA4
         nBsW+m0drnCk7rfcCVV7hdpXYmLPR07RPYLc4ptgJf2AhHUcNTPVHRDF9hfp6XbnU9AZ
         WVnzpepzT5v5EeRi5jm14nWkazoGJ6wqieP5iwAFsD/643ArXte5BKAn2Xq1SWM8Xz1V
         Nml/0ISWry8FobgiRsQx+mf9GThXJ0ZbcVdwNjME4ADWb92tsQGehKCv7wga2DRnWhT1
         FCRLEkxiqK5Zu+OoohTI5XJrFD9k9/UpPg0ewS/T7ExsNJxNnG8Qi8MjMPbFoeqNlscY
         zEXw==
X-Gm-Message-State: AOJu0YxwIcBl8/h6EfQIPlLU5WkRdrpEmWhru8yL7QKFIOm5T2OIAosr
	nbDy4MlVRLxVR9QM57zSQM3r5yiBMxH3aq5F5z4+Vo5E0D9tek2uivmNgj9SNQ==
X-Gm-Gg: ASbGncv+BR8kX/c449gkeOM8QpQUdLGBhM5t5d4fSLWmLQCChOLPXfpTj+k+kYB0gbv
	L7F9Q5Qm+Z+kpk1kXy+/5IpPuQEBA3GcfnF/lSnsSHMg2TpUBmcn43wDbGd4wqHiCNVwqBJFL5a
	3hp1HRxvmy7kEswWhwGlAPY8RhAf4Wwp1doqHhuzgUtqDW+5gEOxprowf0X2ea737/df1/PhLt6
	8h44KNtdCd9hB0L3UGGv7zfxczzwXdSNMRXRSTJJJ+l43EQC3EhgWvWNHszUMh0dv3qrl5T935c
	Iq8EmjJwcVp/9dgyrP1AkmZJHuV/4qrFAwyngZ4Mdvat8PYVrCP+0h+jPBVMvYb/Bnj74dbv5zO
	fU80WAYqsEXrPBzSgaZ71/tBGVNGsN/QybjBKYvcyQeMQEb3kEIeTu8l4ot1fcxUQycONZI9H4a
	R/46MZcmE9iWlyS8DlHqg=
X-Google-Smtp-Source: AGHT+IHby8MZ/tyb02p4kFs8L2nn95t/GhjSTZkFUcOZh+vLZJQGKUh+b7ULlEuFQMMsk5mHRtkVVQ==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr97748215e9.32.1760904928721;
        Sun, 19 Oct 2025 13:15:28 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:28 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 06/17] bpf: support instructions arrays with constants blinding
Date: Sun, 19 Oct 2025 20:21:34 +0000
Message-Id: <20251019202145.3944697-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
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
index b4ad1f836c76..4add3c778f02 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21574,6 +21574,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
+	int old_len, subprog_start_adjustment = 0;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
@@ -21648,7 +21649,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
-		func[i]->aux->subprog_start = subprog_start;
+		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
@@ -21702,7 +21703,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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


