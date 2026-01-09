Return-Path: <bpf+bounces-78281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D210D07D03
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 09:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA4C230A2E25
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637CB33FE23;
	Fri,  9 Jan 2026 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKB6rXX9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87E33F39A
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947218; cv=none; b=YJR9p93yDBhkKVAiPZmRgv9b/PGdnAhtqx7GPbuNwDA1eXYLw41X/sSPP+8ioh72BoYupiSHic/of1dJ8UcHE0WFUgaYlet4BBoI1G7/kKGqJr/5t6ohchLTdSEwf37KrCaKWr4+L3AEvDERMVmaPDNcqhozktiCUpcCpCUpqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947218; c=relaxed/simple;
	bh=KRgennOchm4SecL+a0qWWX+iu4AtLOUYwMuL9asr6dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLoWEXtOGvIg73miyXaShrbuYNiARilmHYI+dxA7xhTJGWkGCI54Nm7wZLdCHIzRlzIoBK4Ry8bDpYNsVQoTFDYd23FeLccw0QERG62xfiQbZfeSbrqWZyZF5a86ceJL2DucRmDhrX3Z6z9tjy7mJdwHW3BBmGNOW0f2U7F6m/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKB6rXX9; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a09d981507so21726265ad.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 00:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767947212; x=1768552012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18MAnJO+sPEnlXXhWmkeZwsmbj02KmkQZndeRSrm91c=;
        b=PKB6rXX9kWPPSO0stUv3IdOetZz+q4+sOxD5CsBH9GiM/WZJRAdVZDjU5vKPtiWoTI
         8qO+qTkMg+oApGP3EdI/W6Ky9JvoTaI83oBAHkyE0tQzr/gDMdEnkqFNTJ/mL62xTnls
         wuORJQ6rDjUKxquAtLAF9OeD7VFYLApiKgHqj+dce/qnqPO0FEoTqIGCgRHj4Dq2Pid4
         4Ly8KAKxsyHl04esf0Vrk4vfuu2fLdDAZ+T1buTGOHqVqDz1XNFYMxaEZEOpnR8pkVhn
         ZydWlJugeC9fuukKWMt2efpNWv/jCskk9rh7wcLrCpWHl37EB31TeW3+xcGdHrxcPgkq
         ILDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767947212; x=1768552012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=18MAnJO+sPEnlXXhWmkeZwsmbj02KmkQZndeRSrm91c=;
        b=Z9B+5oVnNgWHirmNhNfYpFinqCIjaMJLVFRPuwg3yZ1BErmvN8pUyOsPm0VzQqy9mK
         +3WUIJQfffFJ6xshwu+uOzVZgVT990S5mbRBska1rwtXVVjH004eop25XbcshDJouLx2
         //1S3HIu8E6yIsD9pr0GgNr1Hu+FQayrkkm3p2Hu68snrOpOzKrxjbZ1Zuy3XW6u7cjm
         V7CRTVFfDEzAOfTZsZIFZjbJvvBYxYCd7cu7+oZoCHr2UDNJ+FJaI9QZfqrNuU5OWav4
         1fkKXnQLqc60SXo5vqNxOVr3q9eq40/AmksIIpDgzfWnz8D+JmhcfSLMi00igaYSMmCu
         KITA==
X-Forwarded-Encrypted: i=1; AJvYcCU3D3zqRqOqvPpInkOxQ+WZQSoIdXR5kOSmaIGFpxfV28/Bsxb+wEzJLR/DIgX1TYn5QcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuNWtv56aSP5ELItUUgDY81TLq9lFQQE0Va9fQ7oNnqo8kbpu
	IC/4LBsf86JAK8o8Ukyf0GN2R5sdrPkTXBTDmwbTU/qd1PDQOsG8b7G6
X-Gm-Gg: AY/fxX7r4w35nRRZbGPLJvyLcLezHzlEkr5mXErNL/4pYsZsIaesk8GTc/jZgEYH8d1
	uHlHX/Ep9HmXdYlKSN/IYXgxLfNhm4BLnKUyII7ERpIV9qoQxxWjEDgWGAVU5sJc63PQ8s31qzS
	Uc2mItq8b6yhwLDhD2R8EXKlXtl79wdA6EJ908ymSJunW/TYvhKI4aRx6eBiTjryrcAYv9EV81a
	XFAxcy4tL1fafuqNuQKKoVrsImm00jm525Ay0gFrpyl9JsLh1xCDwY5n45O32aGWCZhNPaf4qkj
	hURDcEWXgEoQQavXr70UH4dr8GzrOPO06FD76cr4NCNKvitlRsqM2ZhJkFux6LJgBZKQWJlWsqw
	oqj/k8HmHeHaYZT9SDJ/ahGmrVRS2OuprSowacdjiwCcSN609giWPhTvSUD82j9N7+dZQZO7xwR
	glB78+bM0=
X-Google-Smtp-Source: AGHT+IGf0QEF/d7jltyx6UG06B7MN/WN+LdN2dlUAM1K2IAl+ueP/PI0ghV05FaX8xFWfu2q1TFeJg==
X-Received: by 2002:a17:903:3508:b0:2a0:a33d:1385 with SMTP id d9443c01a7336-2a3e39d7c25mr126466485ad.17.1767947212170;
        Fri, 09 Jan 2026 00:26:52 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc7912sm100104695ad.67.2026.01.09.00.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:26:51 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/3] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Fri,  9 Jan 2026 16:26:29 +0800
Message-ID: <20260109082631.246647-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109082631.246647-1-dongml2@chinatelecom.cn>
References: <20260109082631.246647-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance.

In !CONFIG_SMP case, the percpu variable is just a normal variable, and
we can read the current_task directly.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
  x86_64 JIT.
---
 kernel/bpf/verifier.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d44c5d06623..520c413839ee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17688,6 +17688,8 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	switch (imm) {
 #ifdef CONFIG_X86_64
 	case BPF_FUNC_get_smp_processor_id:
+	case BPF_FUNC_get_current_task_btf:
+	case BPF_FUNC_get_current_task:
 		return env->prog->jit_requested && bpf_jit_supports_percpu_insn();
 #endif
 	default:
@@ -23273,6 +23275,24 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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


