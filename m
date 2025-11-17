Return-Path: <bpf+bounces-74689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2415C62474
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 04:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DDC54EA486
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 03:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBBF2ED168;
	Mon, 17 Nov 2025 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQsrDH3T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41631576D
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351373; cv=none; b=VzQsTR61pU/J1uqboLLh5RB1dxRidMYOi3+fgvKAov+ghYKbwj6M6gJ7LZFChzIXfuNqEDhS97lL4OC1Fn1vJcHp2XFCHZaD6EMouXaA9xewZP9EBhzQSLfuhaoYf4OI+PFD/1qbuJT2Zlz9JoWQDeCfpAC3imYwQ6p1VL+J51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351373; c=relaxed/simple;
	bh=CuZzfhxpaY2RwGDUn1Vx9bQnsJNO8QHP2g34k19NaVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abGLP9vvBfYMy++hpsqhnHLF7p2RsMyUjiLgnr3sq/mca4XZs58FUEz8rPQjOdukOosf83FZFjY1SGJcXjU6Gi3Scqj4W0uIu4zbiO6iraYPSv9QNQqwMqmmzXg8zv3/Iidmxco2tkqHSE9cO/3rkmyaKZtnFXsrwSaqg6gE/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQsrDH3T; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so4091680b3a.2
        for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 19:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763351371; x=1763956171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr5zFCvf3ujgW8K/MBn3EvZvT1zNiYJuY8EfOcbbjUE=;
        b=UQsrDH3TOamJbHpZtRnA99ovxE1K3pPfoCmqViPWdqB4HAPDC0nO+Y4kS0jF7gt8K+
         8DxNUovN4945HxYrK/nkDAAUrkT305H1YHCteTmbjqejdCGtG4miGTD8RbvsFdczjp6k
         mq4P89LG+RBLIu2iSCBv9s/iWP5hnfHR+8b/D+ukcsVgnyTEEqe92zJy/rWZSgEpzkHW
         ULTZC8rzkZ8S6qYNNlMA+LgjjaBm96siPwUMHtmun0pvp5SH2kfZQ2cbCQtj5u+VASVm
         +Y3GcdYH2lPqFA7wWI8zoorKttncUBPE632qVmzIjHo9U6KJ7vokLgjeSmt0TGN4FZMc
         9Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763351371; x=1763956171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gr5zFCvf3ujgW8K/MBn3EvZvT1zNiYJuY8EfOcbbjUE=;
        b=P43PbrHu7wf0hDDta1qA3hTbpSUTo5Q5SgsH+k8EaMCBtGi+OgOdqA9u9f4dhVeL8Y
         GZYpgrIcjTx+kr3Hf1i/qQdwVIcGKxj1nVar0vaXOyd0vQHyFThiiM1j8kbPIaLDPRO+
         JcAWsT7wG1ho5NQOuRyY7DOiVjSH9FCR0ZoMr42WuZPlWY0WENVczaXV5nX8Nd12lHbE
         ovDgqgokhOc5wjChhQ8AEclaVFw+zk/VXITUwJx1OpDFgsz2OY1lsR5Ax4i8pW0F1U+w
         b7l1ElhuC3Wv3ZL+ZSBn2xUIuBk4qSp+n9yz3LbTCuKKZMpMBsyHd6zXsdDzKmc+XcFh
         qRlA==
X-Forwarded-Encrypted: i=1; AJvYcCU5KMpKbT7IGfpD7sOcvcIGj+gCwVLHHUclJwxS9xaTbV6dOUkXNioFNc25r0ZtwENlOv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpc9GoOJUm5+Tp/4OJhN7KCXqCca4UkHqyB1dc1KPHr4wI0l+x
	Y5WhiesPke5bcZmrtSBMLZ8K4sKjNkKL0XaIzrkvGPHVQN60UXlmC7i4
X-Gm-Gg: ASbGnct+j+B2S5I7TPDNABZrDrbYNk6m66oglmHkv/+b7Dg9y2GnzYLSvkTgER0uVWU
	vaJrEftk4KqaSJksvE1Qdq5U5NSWTpuJsMwH6gcSfJeYImboW1VqcCWL7mk8tmHH36kLDvTL78b
	OjUg5rK8YwsR/SbMcouw5UVptCTEQyQgSfgLJbJzqecQyn9asTgcT+9VAbEhpd4DlyOiUCU4JcN
	lEvoEDKE4sdo1aLcoE4yjzxrwZB/1lqhOpxC2bIeYgKZhpvnYo8V17NuTJucutXJMo5wkKt8Vb3
	TMxoyplA3m0sa5iRSNxHriJwWKJwqsV/uCEPITm42h8EqFGgG4c9RUDkSyiYEEFw/vtZscrKGU3
	1zSg9L19xtgBX3Z0AkyPstFZGiQa1oJDFvsEQPKSXVo+Jf6qFUwSlJ42taXOtSgYlMQ/3eXKPtA
	Se
X-Google-Smtp-Source: AGHT+IEsiDE6ta++Kmx6LtSUk5n6u7iPjxOL8FLATJIsjty7oKbw7jcSClMzSU49gt+/kqfQxb+meQ==
X-Received: by 2002:a05:6a20:244e:b0:33b:f418:c3e8 with SMTP id adf61e73a8af0-35ba259aaebmr12228233637.60.1763351371537;
        Sun, 16 Nov 2025 19:49:31 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37703a0d9sm10348179a12.31.2025.11.16.19.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 19:49:31 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/6] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
Date: Mon, 17 Nov 2025 11:49:03 +0800
Message-ID: <20251117034906.32036-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251117034906.32036-1-dongml2@chinatelecom.cn>
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some places calculate the origin_call by checking if
BPF_TRAMP_F_SKIP_FRAME is set. However, it should use
BPF_TRAMP_F_ORIG_STACK for this propose. Just fix them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 2 +-
 arch/x86/net/bpf_jit_comp.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 45cbc7c6fe49..21c70ae3296b 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1131,7 +1131,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	store_args(nr_arg_slots, args_off, ctx);
 
 	/* skip to actual body of traced function */
-	if (flags & BPF_TRAMP_F_SKIP_FRAME)
+	if (flags & BPF_TRAMP_F_ORIG_STACK)
 		orig_call += RV_FENTRY_NINSNS * 4;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 36a0d4db9f68..808d4343f6cf 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3289,7 +3289,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	arg_stack_off = stack_size;
 
-	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
 		 */
-- 
2.51.2


