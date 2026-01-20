Return-Path: <bpf+bounces-79562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B34D3C06E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3355354053D
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6150D36999B;
	Tue, 20 Jan 2026 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIpbwsK8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8253803F2
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892789; cv=none; b=Z22Rm54fm3ts1BQJ8XLG05PLh1UDUp13stsRx35wlgPlPVgilsddS0xn6o+NwxfjW99GjWNAPBJ4QhxeqHAgFJBOgQRKHe/iQQ3cZgTYPoVofPuBXdKSHVaetysWyX3eRAn5qo4XCSFtVkhp6Xd4SjUX40WitFZqWiU300PQUdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892789; c=relaxed/simple;
	bh=bkEnpN35ROgLb1TaATahFCU+nYmJUOdqiUA5VNDzRiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5qIdUcWJ4HHghd7TP4GzFCgte6+m/lsRN0kEAw43aj6IYiTi1mujIW+s+kpMiCnHezsPPm5mpLVjIoRiYKOMxOv1qg6nhTuAPQzJhOC4ZBr0bWVMyAV1W8vvuSEPi6P2G5Z2suAvlzfOyMBjpRW8z9bmw5+h3O8BVYgAyFlTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIpbwsK8; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a1388cdac3so34601375ad.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 23:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768892778; x=1769497578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoyD4uV9eCRwWiRSuwU/fXn0oAa1lUGxNCw5PqJhjBU=;
        b=BIpbwsK8IFYvCZ5UM6BF2qr/i7osYi3MA2+M0lEvSqHQZMB7VpEkGSrGTrqxQPMsVt
         xffOdLinNu8OWRhyJ02aZ2eDeS/nugwYSGWlw4KLjNsfPG8vynnNzWi66SIHDvK5V/GD
         /2qipx/jpeol5mIg1oe05eSfOmtJ45bAC/z/VQ8Gp0HSo6uDxpTIxoatzullIsxzb+0y
         tNRiF1E/KG/FwyJcNl2ZYpkv0fWN5hiYmV70w5qznyUqmZebvIb0OVjvsCVzPJkWLWeU
         7BWhuIjM7tT//vqyvXofo4qckw0DTktmhTr//XRKFRttrFkIDvbAEOFRL//2jm1/HV3e
         q23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768892778; x=1769497578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AoyD4uV9eCRwWiRSuwU/fXn0oAa1lUGxNCw5PqJhjBU=;
        b=ZygZ7FoSj9MD2UmryNHZsMp1wifWqa+Zz8f8xn5VyQCSRZh3j/qZ9pcOsGPO/O/Ced
         yBXQWvY9u7UB+MeCia7MwpzpQ38Xp/NLIjQgcfMFW7L7qglitbBxaGs8sMi7D1lVIfM4
         iTB5ZnwBPDgS+HaZjF5vJo3V2vsmsS0CEvpLD5rKRqOxM116MBLDS6kYT1FD3fXyKpkg
         M/MsMljzlfiBaYvMxRIansvUnsIcVSk2q6JzCRaIWA5h618jfeKOSbJECszeEeEEnCEC
         H98hzsR3LryI9W1i+2r+LVjFtaDzfBp5wD5cOmEgjezPJKkSzF7yqkyiwO42jJNPbYeZ
         /CGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUR5xt83XQO3mG+J1ccEljObTACU38AmVbi8g7PNVcG2UYzNcftWABfT0+QUoEAN+Pkzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4fz6+B/nMMt/i41Y6sr4VoVBGZiRfITFxwU+mKRUwlXjm08/S
	Yh4EA0WskS4lQYCperm4DVW0g9RvZhQeIhQJY+VZmYb/gKC+grgOb9/3
X-Gm-Gg: AZuq6aJ3k9NzfrZT9DesaklRbwOJDADkRZj/nP+0PUlT6yCGZWt1v1rKYmUXSROnbm0
	NHWEBOxxkSLPnytS9h9YRYdDzFoJx8OlBfuTGCa++MtRj0VpEwZmM2G7pzPStIoUna9xZd3SxzE
	uSUHmb9trA3TN/xxbqdNpP6JHsUZHrKOYEvoEI72ERPf70Tw/MVRPmXtvawfp8OSdixGK4ySnng
	CfcWhpKNDVqdEZ5v9uDu352hZtdNXSzT/dwegyYQKW0HrWiVpqTnj8RXswqhaQBNRwA1ux6Fc07
	Dxt2QBCd48EVF8wvQdTXOtNNMnUVKf1os55TBQcZoCvWNZWIIW0Oc1oUtFLN/ynSOxweb75KkN5
	yKnnJufXKr7HfUicSJlAB7GUeDw9CCkInrQ0zAoDVbBwIiV09xDwRxuufrOGqCN8PZGwydhPVZm
	713pnalisx
X-Received: by 2002:a17:903:1a2e:b0:298:6a79:397b with SMTP id d9443c01a7336-2a7176cc35bmr123268025ad.56.1768892778110;
        Mon, 19 Jan 2026 23:06:18 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce534sm111695665ad.27.2026.01.19.23.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:06:17 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Tue, 20 Jan 2026 15:05:54 +0800
Message-ID: <20260120070555.233486-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120070555.233486-1-dongml2@chinatelecom.cn>
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
v5:
- don't support the !CONFIG_SMP case

v4:
- handle the !CONFIG_SMP case

v3:
- implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
  x86_64 JIT.
---
 kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9de0ec0c3ed9..c4e2ffadfb1f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17739,6 +17739,10 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	switch (imm) {
 #ifdef CONFIG_X86_64
 	case BPF_FUNC_get_smp_processor_id:
+#ifdef CONFIG_SMP
+	case BPF_FUNC_get_current_task_btf:
+	case BPF_FUNC_get_current_task:
+#endif
 		return env->prog->jit_requested && bpf_jit_supports_percpu_insn();
 #endif
 	default:
@@ -23319,6 +23323,24 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			insn      = new_prog->insnsi + i + delta;
 			goto next_insn;
 		}
+
+		/* Implement bpf_get_current_task() and bpf_get_current_task_btf() inline. */
+		if ((insn->imm == BPF_FUNC_get_current_task || insn->imm == BPF_FUNC_get_current_task_btf) &&
+		    verifier_inlines_helper_call(env, insn->imm)) {
+			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&current_task);
+			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+			cnt = 3;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
 #endif
 		/* Implement bpf_get_func_arg inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
-- 
2.52.0


