Return-Path: <bpf+bounces-74489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49953C5C4DE
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A568F35E203
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9B3306B2C;
	Fri, 14 Nov 2025 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrHL9VWt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88274305E38
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112316; cv=none; b=sqzS8pC81q2luH1KoQoQIe7lmccs9mtTbfn9Py5mDa+qEuTkNSVhV7qYA9ZLmaMEeOoKLM+XNTObvbdENSlhba+TS8Fz9+cZiU4s2woPuJ2o7VHiyTJBYQ2GoOF9TOAF8MmW1g1VQGwcpPfljSUTJj8+PNQt9eHgD195dXly/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112316; c=relaxed/simple;
	bh=13rTaiSsL0NTZ1YOaRxf6oSc1Dy8agBuYumvqKAnvQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4ICd22PwH2KEim8UwI/SdrSpg3aJkmU8JaMMb962zV3kyHJqH/DMkpEBj47V90TFsFRTO5BoBjUYuOizb6Yy1yPAJ0lDxMx4HtbrTDDx25GBFPun1jX2+8dksm7yL+uZx1FVhpITakmqdPCMuvhtPhRr6qjNp+cOQx7AdHQkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrHL9VWt; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2953ad5517dso20817445ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112314; x=1763717114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR4G2sTlGki2siCN1jOZFPTFr3TbudN4PF6c7ryHzjk=;
        b=KrHL9VWtE4O82KxpyXvhAlHSQMbpyLBZwKUcaF4AbRQCceK+D0jWXXwEcDe9XZa/o9
         wyE8FYRpIctdMJ7CAHP+l3qIBfo1b5cHCqcRWDzELndSENhLcw0ooW7g6Og4T6roba4r
         CaX90a2FMRbyAVPFARRBcCC4rrTFqE6SSBJYk88oUK1Fb5MHM8rGR66D8kUNsIyRIfkZ
         xQvX/uUFXgjuYlLocgrzDZKyzj4aoC4pg4yYkE3h/+lRVy4GZjpmNwsM7bYVTPbJN3wq
         PY1FDC2TnuVuNIEfteqFI9zr5zHORNi1i+y+IeQMf0yV5Hss7tyqxGcwlsQHGLud3r0s
         wSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112314; x=1763717114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CR4G2sTlGki2siCN1jOZFPTFr3TbudN4PF6c7ryHzjk=;
        b=F4D5E6ytT/4spJXOchbcpoyHCN5liAhIbXkWkb7+mpruKX8G9YeEdHXxlY7zbMRKkf
         nzLZUE31EXYpztWAMOPIZ6kKtxaQ2iuO6GkK+zfnWvG9f3ezYQ9W01RpMt6MdArCK4k5
         b1GZnIOdCvz7rbxRPIQGvzwdGDDdlGVhsykKiy8QlKfc5zynqu0+/N1sDsCJKSHn6yBg
         syaDG1QgPc2La8Bie6z4uxhMI1FpjaOUv32k7djGFfgxhcv/bOHkG2PReqUiWRxOWFp2
         5QEarWSx9xF+0qa0vpWlG2rmpIIxalT80OPAF0+DgdOnd6KPCxoyw2erTxDW/jUwDXNt
         Ekmw==
X-Forwarded-Encrypted: i=1; AJvYcCXKAce506opU1xAvenP/U7/z5jmu+fJx9TlChKkgLIeiBMDUNcdIUGsMKcxCpne837Mqn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5zIT6GdEya04owgWlz9N6HZt8jSV0WLKMN2B+KaXn5CJu4PV
	fWy1poJPhDw8emfiZsSPTUdHidjgaaTu4/Krj7iAE5MhuPuQBivxp4lL
X-Gm-Gg: ASbGncvVoSGLzswNkZ4ajIAGBizRsFtBEhs5WECowbv51jYmBIakeVZZVnvwoiXBgjY
	57QjzfeiE/+vDSlN0hL475nsOrr8n1dyd5Rh5u0uWU32a42c2BKwX5gLcqwHaKLW+NKPtMdJjwg
	phSP5vqp9TBakCmJz0HfocP5B76+YE8JCZWgBLCfmuus75NKwbPFgsAFgrkpTc+mQWgA7AnkFBq
	V5rzTtPhCVdh1GUk+tKVF5meJDoJIt4hsyCFSZ3SstYIOk4QFzWNrJ4C5TNBsYD9GHx88vFAzih
	ucSdyaHMvJGj3cJr0YT3lSULDWiny5SLTBvjUXd/ALT4QOhjs80Ly74Xq6qA4xIZmz7CvCJqVku
	C2Pvm/i3CwX+O9E/BL+p5T10IBD1gr1XCU+w8pZUxkPU+o+tyxzCdAEeEluNm5EX/kfIfdf0K6r
	E0uDSnMmw9MOo=
X-Google-Smtp-Source: AGHT+IHcncu3fCVBTRgs6cuHPXbsXwtrJ/13HcgbxbxqCj94e5Leoiq1IYCMd5ZzNeVgfN5DkjRaag==
X-Received: by 2002:a17:903:22c5:b0:295:2c8e:8e44 with SMTP id d9443c01a7336-2986a76bc1dmr29990775ad.59.1763112313782;
        Fri, 14 Nov 2025 01:25:13 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm50451525ad.7.2025.11.14.01.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:25:13 -0800 (PST)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 3/7] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
Date: Fri, 14 Nov 2025 17:24:46 +0800
Message-ID: <20251114092450.172024-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114092450.172024-1-dongml2@chinatelecom.cn>
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
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
index de5083cb1d37..2d300ab37cdd 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3272,7 +3272,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	arg_stack_off = stack_size;
 
-	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
 		 */
-- 
2.51.2


