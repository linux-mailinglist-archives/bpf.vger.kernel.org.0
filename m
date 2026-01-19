Return-Path: <bpf+bounces-79425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD4D39F44
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 08:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 808013042773
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 07:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE332D2381;
	Mon, 19 Jan 2026 07:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpMmlL+3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9C283FF9
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806189; cv=none; b=tqbeCCYT2JMKW8QAskS9Dcikhbzxl7e584oxbAYDcrSm3la2kqmmExiF2lalQrXhanQRM3CThDvB8R9bjPduK9Wrp7h3qn2tWy/sBTebIzM9E4dvUuTtdWLDm8YG8Nq37r4tvU6lzVPZYpZJuqrz0OMVtbmKU3goliIafZ8cXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806189; c=relaxed/simple;
	bh=oYZy79n5OSjjTlrj54yqdATsU4yMrFm/rl00CpbxXBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3G+S7NDwyFm0bV+ivlnm1UkzR0SfEeEabRZuOIkpO1MVkxS0KwQVhI/PqZOIkuPJjZHOdEwAHv88oxho5pGyZ2Op87dBqlnLkRvJG9QHfhbL36nzLnZBTbMGhki53VL8Axb1BK/HunjgigtN7qsvj4q4zGLKt6l8v1/6EmjYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpMmlL+3; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34c213f7690so2520076a91.2
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 23:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768806187; x=1769410987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbzRpqckj4NQsnl95AKvf3X1E1Gz7eIXNEvtt8X/tco=;
        b=VpMmlL+3mMxGoX5bWrcaneTHcuw4TuJEiOdsIgELLbVEbGL4YDwKYTZNstR9AJemDG
         b68T/R2GkVjO2P7RjJTu6Lq9sNzTsrbBHtatox1ye/0EB4y811ndD3ok/Vimguq0/DDo
         bsr/t9DyEIvYfIeZvan7B0oMe5GpflThy7B++O6OIL/zpCRfXTSb+NoVnU5LIkcgIfAT
         FfrnPft9XyzGLxCKP93wNlXrjwfR6q5xkqQYsTDpgrDCvvbTYnKqJePVcrAvqSS5YXep
         fnzEfbXYAHyXbVGzlnoN3luBxGdzXtKkF6DHYdThjRiXL4qGuaEAhJD/LxezIXrt95vB
         QEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768806187; x=1769410987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AbzRpqckj4NQsnl95AKvf3X1E1Gz7eIXNEvtt8X/tco=;
        b=IMH81ZmZvqroIFlP4DcTnFRdqK5pkDDAYhfWZOAzNi4nVV7gCjkOfscaDVy8ylCgu4
         p19XnVKhSwXhqqQtn5+jYROGKvLIdYRQBP0tjxJ/35HicbUI1vD8CVqhDUlkraxUt0B9
         EWE4qCKJy3j6OVpVD++3jpBejtIv2bL4FoN4qCwsg2yOx8ELz+XxFRZ6pTwW0XcMo8Gk
         0pj6uiu86JRJ4dIeWqeoMdV1Qx0BoXBbi/O99LPwsJlp7zXqyDXeW/+TE6LPdnARYfSp
         b9mRUPQBnaZG4OnFtuscJ0eg/tLah8vrYV+dkGISK8Szmm+M9TAQgDeGuhsQWvoLvGXO
         /wjw==
X-Forwarded-Encrypted: i=1; AJvYcCWNiy0t/PtdHpwYRVu2MO06wRT5Vj3swM8XuGNW44ktcnIe9kbZEDMZvJjPDmOPTJqWkmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTN5StBgCUBwqk1XvAUjbI3Z52q3X51UGmctSCI5dN1mIee4aR
	26krFjys7VJY+A+DrdnTL8gU6ij/6z/N6vFnZeMT5qOzOAiGQJfhKLKs
X-Gm-Gg: AZuq6aLFKM8Qs8eTRQhN4qYXMO3bqhfDExUmwIj8G23Qt7CtgDeih6Zja0UaU8Qm5ox
	G091xeF891ZvpksirQ7C6gxvKm78MaNmRiISPraw7mUWHIpvqlTNCZLDkvultDNf6eGbzJGmYdM
	xPy1FjFEZmgSs+uW0+b17N3F1JY7bNdnf0a4+wgIvmAoKWujnP0Ye4V6TJyQxLMJZSg5uQ4i3eO
	3pZjkGV6fPi1ZOyzEOFDNhTpAkdzXgHjo1FbsMJRjtVOFHKsJJgruesz5+IvWZ5a0k6wCg6J9sl
	YsE2i9jZgjbxWAP9lFNaa2mjv40kb8Q4RUYdQcJcMForY9e1kI82W5Xl3Dd+G770Nian0NiH3th
	RdQMMdvRtHjdAECHZx2vlCJoUTiOM6CaIuEAhc8erUARvbhLRjXHdWo1Zu9LqJVK+4Pb/0NOkQr
	n1p9JEkZfy
X-Received: by 2002:a17:90a:ec86:b0:343:87b1:285 with SMTP id 98e67ed59e1d1-35272f6c412mr7433738a91.18.1768806187446;
        Sun, 18 Jan 2026 23:03:07 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677ec7dasm10772027a91.8.2026.01.18.23.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 23:03:07 -0800 (PST)
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
Subject: [PATCH bpf-next v5 1/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Mon, 19 Jan 2026 15:02:45 +0800
Message-ID: <20260119070246.249499-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119070246.249499-1-dongml2@chinatelecom.cn>
References: <20260119070246.249499-1-dongml2@chinatelecom.cn>
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


