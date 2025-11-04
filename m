Return-Path: <bpf+bounces-73426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8EEC309B9
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 11:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BACE24F72E3
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804732DE6F1;
	Tue,  4 Nov 2025 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGuDfNkV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E42DAFAF
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253364; cv=none; b=bVxNFAWQqqgFzTzUwCQ2eUJxT6oN1b3zvk99lx3YkOZhf8GMlPDpT+4zo+0g925mnbd1HzMNu8otQBblbzD7m74SZtGScfhCGr+6wKM1PFYUOb7+DIHX48xlodfiurAAWRBUt15w9GNcz5FJ5Of53RitaVP04WjJO+zsC5DGXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253364; c=relaxed/simple;
	bh=gFtzIHzH+feMWJwo3pq+PvWg1fj4+2mq/x330+5X7j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qTgF0YUWODMoJ2IQjGjfKCuxNowWx9HJ44n9EN020wCs/4aYPNtI+4ZIW1gl98PN4Lo//p8CM0HcVXIafMex8JIHhsebVpAtQ4ittbZeIa05v0ZFNPbF2n95WWNvpGvjXXgEfu/YMDHQIdiujYu6weP3q7eGzaun3pooLPZJJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGuDfNkV; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-29586626fbeso22110675ad.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 02:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762253363; x=1762858163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mcG5rrfn0eYABeDV2UUy44PLYPKH9hFPkeHvBJGBvcA=;
        b=YGuDfNkV0XJ7aKEt+ZbGNAOHUz43yyx6DLn8Fo8O3TmtBmxQ/VOfAg7Fpuw1OMY1rU
         ZddPgHWMprdsge3+XHvpaFezmuX2HxEMZ0Ch2FKyH9+hCDUxeSKHfBRg/OJPn/uRrF4C
         S2ZVv6z/wgh6D3o9aSTqJ0BgNb3fPIbOgzyq3Ph69nDIKj3yCuEhLtyT9zoGXYYDkcQb
         YsAlZrWR0ULMW3Q/YSJZ04IIpzc00Vifi/xdaZA3vUAi1wYV/dfopPqpzvwAVbMEmB2m
         4frb3r4Mwur66S0it1Orf0peTJxcRdTDVV3iizXVbAAWgzy3OBBsTrwM0HdV8fjKCcUP
         JCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253363; x=1762858163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcG5rrfn0eYABeDV2UUy44PLYPKH9hFPkeHvBJGBvcA=;
        b=O4GgLbFBNJHMDILDNkkXBQuUSvEuCxCq0tx1fIV5ri5cxZNNRY+jUiF49v6qcMrn7H
         KMQjgCCNgrIhot3JJ4FkJljy9z3epwB9z+bMzWofJf7mGvZhiL5G0gqgBve7fcE51dB6
         e52TdBPaN4uJyQtx2n3fsHxYvGTeIFGDlltQYO0Qt2BTX/Q4NetsTpZO1hXhIqV1aVbF
         M7bixH0kNszowm5oBEEaJAsyuerXpTmdo8ONwFWOrHg0kBv+jMz32YlOk/Xdv5qr7lzQ
         gkKa7ZC8WTOXLih0LHGPQEak1vBp3utfyy7M9bO+kmy/qsNCvkELLq8DZQPOtUVzIZcQ
         4TxA==
X-Forwarded-Encrypted: i=1; AJvYcCWR8vyXQDAg+ZkbTj1iPJjEPIUzNSrlkpVe4nlFeGZ0pEoccyQvsS1CM/gY7c6FZlCDwLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhiumkHoUGpVD+jvt5LlV2CAkVJxLK0TKc35OaaZOegdmp9KHE
	uyIbofRF4ic9Ezp17dCXTb5Y8n1C8xUjOhfttAT6XgqkVUy4bEGCwjet
X-Gm-Gg: ASbGncsMdKCDwKxmkbq+GEgJchY8ixXJFXd2OvAIVVk2wDjl4KbHF5Vg1HCdNTE32RG
	S3PKIwbHtQx7VPWaI9PhM62VjlrEBZ/Twr502V1v88935P+saAUgu5FHibSPN3nmWiH2k9B7jVH
	/R9fqIsfOv1CX5iC76iwqrj3SAq7fsM6cN0M8QbGMLT8YRDxaTzNGL34xC/rMjI/4rVRRmulToy
	iB+bxahl3ba/sTf4qF1+Fx5wg1jCUOU+OpQjBA++FNGO3bALKUJut8gZqqatHQUElz1Uq/jZn0Y
	dMA/6u/QnmIAwO7i5obpJ+oXsTpokDntPVsqprcnz5lSjcDQVeSBSyCvmMvg1zfnpRYxiq7bMkn
	9fnkoCdv/GcmFOEf2GH3//jAb1bFdo1IqZhjRFt8yoQyi4hijzGDykLamg14nfsNE+Os+zm85W7
	28
X-Google-Smtp-Source: AGHT+IG2P/n05n4+4su8LX8XiTIscuAXJnd0RPNxjz3hjGLueMGYITVK4o2vmRxxXfVfLg6HdxmH9A==
X-Received: by 2002:a17:902:e88e:b0:295:fe33:18bb with SMTP id d9443c01a7336-295fe331993mr35292535ad.14.1762253362602;
        Tue, 04 Nov 2025 02:49:22 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7c5b9sm22013605ad.112.2025.11.04.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:49:22 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jiang.biao@linux.dev,
	menglong.dong@linux.dev,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
Date: Tue,  4 Nov 2025 18:49:13 +0800
Message-ID: <20251104104913.689439-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In origin call case, we skip the "rip" directly before we return, which
break the RSB, as we have twice "call", but only once "ret".

Do the RSB balance by pseudo a "ret". Instead of skipping the "rip", we
modify it to the address of a "ret" insn that we generate.

The performance of "fexit" increases from 76M/s to 84M/s. Before this
optimize, the bench resulting of fexit is:

fexit          :   76.494 ± 0.216M/s
fexit          :   76.319 ± 0.097M/s
fexit          :   70.680 ± 0.060M/s
fexit          :   75.509 ± 0.039M/s
fexit          :   76.392 ± 0.049M/s

After this optimize:

fexit          :   86.023 ± 0.518M/s
fexit          :   83.388 ± 0.021M/s
fexit          :   85.146 ± 0.058M/s
fexit          :   85.646 ± 0.136M/s
fexit          :   84.040 ± 0.045M/s

Things become a little more complex, not sure if the benefits worth it :/

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4c93d9e73e4..a9c2142a84d0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3185,6 +3185,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	void *orig_call = func_addr;
 	u8 **branches = NULL;
+	u8 *rsb_pos;
 	u8 *prog;
 	bool save_ret;
 
@@ -3431,17 +3432,42 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
 	}
 
+	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
+		u64 ret_addr = (u64)(image + (prog - (u8 *)rw_image));
+
+		rsb_pos = prog;
+		/*
+		 * reserve the room to save the return address to rax:
+		 *   movabs rax, imm64
+		 *
+		 * this is used to do the RSB balance. For the SKIP_FRAME
+		 * case, we do the "call" twice, but only have one "ret",
+		 * which can break the RSB.
+		 *
+		 * Therefore, instead of skipping the "rip", we make it as
+		 * a pseudo return: modify the "rip" in the stack to the
+		 * second "ret" address that we build bellow.
+		 */
+		emit_mov_imm64(&prog, BPF_REG_0, ret_addr >> 32, (u32)ret_addr);
+		/* mov [rbp + 8], rax */
+		EMIT4(0x48, 0x89, 0x45, 0x08);
+	}
+
 	/* restore return value of orig_call or fentry prog back into RAX */
 	if (save_ret)
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
 
 	emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
 	EMIT1(0xC9); /* leave */
+	emit_return(&prog, image + (prog - (u8 *)rw_image));
 	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
-		/* skip our return address and return to parent */
-		EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
+		u64 ret_addr = (u64)(image + (prog - (u8 *)rw_image));
+
+		/* fix the return address to second return address */
+		emit_mov_imm64(&rsb_pos, BPF_REG_0, ret_addr >> 32, (u32)ret_addr);
+		/* this is the second(real) return */
+		emit_return(&prog, image + (prog - (u8 *)rw_image));
 	}
-	emit_return(&prog, image + (prog - (u8 *)rw_image));
 	/* Make sure the trampoline generation logic doesn't overflow */
 	if (WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
 		ret = -EFAULT;
-- 
2.51.2


