Return-Path: <bpf+bounces-45918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BD29DFC0D
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5FBB2151D
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0201F9F5B;
	Mon,  2 Dec 2024 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkELEJw+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B81F9EB0
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128702; cv=none; b=gm4yycDx9cwhrnMxMpRUhp2eiSvBxLwxbd6ZOYjSaflA0Xo2tUM1j5B40B4kWW9/gpj3d4q6O9Sm/SnkybuCs4PaYcNcoQfRizZDZ3ohNdmXoO0XEMwdDSr/qzYTvAxX8ggmTIFySKUDIeixp3nTEVXrikP4cUrHATRJh9AH+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128702; c=relaxed/simple;
	bh=6hBaUCoLMQRT9OMYIV/E4fQ+WFggaHezKACaBhUmbxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAufY5w1ad3uo6lUjiZ6wpeIbHTU0xsaU9fMwtLZOPQK1MN783U02XApiGR/vjl/STMIGcdVmDpxhDxc1g6lLbU8k3t3f9sFmHugVfyxVH9cXoNH3vY4E+aAOOF/dibiFpAvnHtaFi2NYILKvyPCCzaGqy9ucjC+vsAxUtt0pC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkELEJw+; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso4159708e87.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 00:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733128699; x=1733733499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBuWEvdApgxP5Q2IqHCQIxx5djraKO4paNwwTeZrtNI=;
        b=MkELEJw+PkEarNGnnhUOW4fZkj7+GcRq9h8DE+YVDLZA3Pcvb/GDLBnxXVPN4b8cCB
         q85AyK3gVx0uo9YZXNJngxjvxvJCX0uTEwZVwcwH9LoMNLZI5tklpbzeiNieclkwphWG
         Vqnv1uuSyFQVhvrapDFtRKWmrfZWMZNe3Zkx4FcJBXs2pN+dA4mn0h9fiC7Lkt7KG+Ve
         6NXbo/iHKvA0N/zcKJRtVZSUFBF7sXDjLKQDvKoMt/SNw7yX0n44s6iz671QW+c1joQD
         9TAoUelJh20oflB9mLaVDg2YQwLDV+qQFf9wQhMc3QZ7s9o6Xs55pusBhTT5Lx0vHDQP
         Qb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128699; x=1733733499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBuWEvdApgxP5Q2IqHCQIxx5djraKO4paNwwTeZrtNI=;
        b=ie4GS65fnw8JaQAsOpJ9FRnnHyYaWqNQxcLMydPibUVRLsqTRYoXW6sFs5tnUkv5vg
         l+tDVD6QUJYDeFaqcHQQTvKLxsBVOaTTSrnNNmhdXOTbDmvfpbyFLn2lPVrv90UKfITl
         Nxx7YnaQTcmdpnyKi1Mdzz0hUV24Y9LYgf2jJT3j2XNKZzIXf7dv87vvh0BfFX+nSGAM
         fA5Y/xLZvrJpQjwzOWLjgumxGmSfIEWc8xJSvfwdTj4+62GijfYiR61hSxlA4br0mXKY
         S4jE9rao75JeSMpuZT9U8aUMEeiZEXTfzikvaKBlQ6VvPYmMRY9tRYXrHp4liDVb8pC4
         ZE6Q==
X-Gm-Message-State: AOJu0YyAngdO336Mrve4vUvbaUzhf1LyrzkTazuT83evmKBczwhfak85
	sJz0eEQhDyA4D9r/bclnZzGY19jxp6PmOLbcnbWFo5uj8P6uIrlvGqUQI7IXv4w=
X-Gm-Gg: ASbGnctmMJ6aTU3BS3/L9T/0E87byTwoGDsWXcrRtLw3BgJcpCFnqUet1wDQzINV5sW
	zSlGjEQdi9XAOX0IOg9J3X799GI8H/HG/A08GESKsVRukKibi6CqXEMOpVJJrFeihPOS/y+Z1Eq
	v12zDtVt8yVUMNTdiw0XT1KwxpGw9oq/yqOSQvjpYack6imime1s194jc9uLGphoKt83lSFcS4a
	uHgrHxlH9w94W7B6XH24XiqjI1G90kN2WCzPT5fBOBQusqczBa8ICSX37amVsOlJ0gaUxEYT9WH
	Kg==
X-Google-Smtp-Source: AGHT+IEEuGZhXzKxq+rPHMMAcYPFXjoBAj0XJjezKLHltLgs7NjLMR2HK9kOo+jm+7qOqPhnCkRXFQ==
X-Received: by 2002:a05:6512:224f:b0:53d:d3f1:13aa with SMTP id 2adb3069b0e04-53df00d1177mr11328366e87.20.1733128698479;
        Mon, 02 Dec 2024 00:38:18 -0800 (PST)
Received: from localhost (fwdproxy-cln-030.fbsv.net. [2a03:2880:31ff:1e::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bee2sm145354065e9.1.2024.12.02.00.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:38:17 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v3 2/5] bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots
Date: Mon,  2 Dec 2024 00:38:11 -0800
Message-ID: <20241202083814.1888784-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241202083814.1888784-1-memxor@gmail.com>
References: <20241202083814.1888784-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=memxor@gmail.com; h=from:subject; bh=zMweRPTEA82WhEH1Z7QTD3IVzZuxXUvMdTmeHQkETiw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnTXG0UdAHJwvnhgJJEdo0njXcQv4Aa9507/CwHytU UrfOov2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ01xtAAKCRBM4MiGSL8RytIID/ 0dbSx3x+Ask/7LXskTQQHKfyjKuKc2UUvfXbrRKR3cSfTcEhav2EL6pzwnB3sFVgYqWcS7s0MSHMQc PjglpqzLswHWBbFjrVl3RF922lcZEq5/y/LB9D7h+gRCwbqnqexDpTSnBYnfBsMAPqNxYxsZo6jtXM 22oJLMYLS2e6aUK3oHcAT4m5kEKODFxo7/zWsybmRmTzWpNucARmTA2tlcDOA8UM6JYHtTLbfKNlwi uZFNDOdaWznZ8Yyb2osIzcfI+9hfqwIq+zLeOxMfNzh7jnTGonAbSalETkRp5cZ/g9aGGvuomgvyeq Byvf/H83pGPGsgJ6hl/shY1q2lqWz2YNoBM6OYNhybrVUCENqUnnl060jk72+4zR5js8PI/z7AJnmh HHrlaG+Pl1pM8OrhI+GzksqnkAQliusUjfx6JRoXD+Z4LOP+ouNQ1E4HbT2uh9IODFdij1UBbtrocl qC1xNtU2fZcuw06ZnMDXVjEznf30RXgIk0y8qiwMQHC54LXQRenB/T0W0V0nGUUM/InRXco2/qW00M KMMJgLRJm4NfXKDgY8iy19OYKm1JBqJ2Qp0EtS33TOAvldIHTAFQqI8EW9c3MPRazmr0sszdQzXbX0 Rk88Ult4pC4hwfL+R0hfXk3lkRgWRTyyBqsxsij7GdvODWYWpgPZphgkTrHA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

From: Tao Lyu <tao.lyu@epfl.ch>

When CAP_PERFMON and CAP_SYS_ADMIN (allow_ptr_leaks) are disabled, the
verifier aims to reject partial overwrite on an 8-byte stack slot that
contains a spilled pointer.

However, in such a scenario, it rejects all partial stack overwrites as
long as the targeted stack slot is a spilled register, because it does
not check if the stack slot is a spilled pointer.

Incomplete checks will result in the rejection of valid programs, which
spill narrower scalar values onto scalar slots, as shown below.

0: R1=ctx() R10=fp0
; asm volatile ( @ repro.bpf.c:679
0: (7a) *(u64 *)(r10 -8) = 1          ; R10=fp0 fp-8_w=1
1: (62) *(u32 *)(r10 -8) = 1
attempt to corrupt spilled pointer on stack
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0.

Fix this by expanding the check to not consider spilled scalar registers
when rejecting the write into the stack.

Previous discussion on this patch is at link [0].

  [0]: https://lore.kernel.org/bpf/20240403202409.2615469-1-tao.lyu@epfl.ch

Fixes: ab125ed3ec1c ("bpf: fix check for attempt to corrupt spilled pointer")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c6a5c431495c..51f7a846d719 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4703,6 +4703,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	 */
 	if (!env->allow_ptr_leaks &&
 	    is_spilled_reg(&state->stack[spi]) &&
+	    !is_spilled_scalar_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
 		return -EACCES;
-- 
2.43.5


