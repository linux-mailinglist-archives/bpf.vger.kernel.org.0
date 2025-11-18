Return-Path: <bpf+bounces-74956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A7C696E7
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4F754F2866
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CAE2EBBB0;
	Tue, 18 Nov 2025 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/FOs5sp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6D8336EDA
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469431; cv=none; b=oteEo4ZL9+y00PxMBAbFr4r7zd2Ru+wFG1566RJGCVw3Wk0Y2roAMaFjGLFr1EUYUKM1rMloqidOjxgEKO5X1/YM0F1xhZcllLRjs/7tPCCMotZCnso/3axJvPksJ1KYmwKTwIsODKfXYdndAIJy/IWlLTKU99nQ3oDAtqXH6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469431; c=relaxed/simple;
	bh=CuZzfhxpaY2RwGDUn1Vx9bQnsJNO8QHP2g34k19NaVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKj+iTpo168cQjwa6Kok7yQMm92K5pxAGIoTy/5QtS6dm5vhtMpAFCJYKFj79ksn68AI5K5zco8xARcaSGEiapyhZiYw5EwowzZsokWM2SLNETNtPfy6zpMBECV1Pny2oEm7sFVAb58oVh1gTaUEWONaDn4arpc7Ft78gR1hHl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/FOs5sp; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7b9387df58cso1716678b3a.3
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 04:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763469428; x=1764074228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr5zFCvf3ujgW8K/MBn3EvZvT1zNiYJuY8EfOcbbjUE=;
        b=F/FOs5spanaAWg1eMuStZ0swyfWqGCjFh3BNVwH8MObwzotT48DICKhvWuX+Yd1mhx
         jBpKQxxFcWEeFYDz/F8w/zLigNcE8//nXMsAH4q8mYl7AbZ7d7eUgLAEGG91QlVt7Kyl
         rkZTuk8KYu639iPWBf1hxj6vl42p70b90ds9++2VgJ6ZUfR8ZQmTbPnbUL3yz6gMZm3n
         FTtvTKe/ReebLrdyDvvS4Dw3/hGMX3sN4P56pYi9tFK0sXIZkiAxnKrzVoYHQUdnD4Lv
         d516NKodA0yCA+53y/w1XXIS8MHZylmkqq1ZpVYTGHjEENLNnB4lDrqRRfbE5s37Mwso
         UKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469428; x=1764074228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gr5zFCvf3ujgW8K/MBn3EvZvT1zNiYJuY8EfOcbbjUE=;
        b=VNZUiz9BSYhRoh5WaJlMp7Gc7rnd13VgBt5Ko58UoJCHsJnNnZKTnmC4/JDVR/BVek
         OcxcQ5ZCI2qn0NMtxRCjvuKeSMNxqmQWvAMBjI6ysnVuP1t0B7NH5q9TAP0ExkG8lg6p
         cKA9JL+EkXiDBNIz4/ouG13fVd5rev4SxoSDszit5ebKxo1xYWu+3ghwlgKC1DDO9pTm
         DyYxeez2yipa1++8vqId4bbmqFd8dIAxjV0zxJZnnWh4hGy+MhnsF0mhCtINVEtpTece
         yxi4x2qNzIw2pkzIlG4FLs5MEpogyIm0ZYUJTWLY9yvnuypkpC+qq08PLTnQXtL2PUNp
         yrAA==
X-Forwarded-Encrypted: i=1; AJvYcCXs+ZHjgidKi25J0EkTbh7Le4nwcf/XUB+IlxbEFeNzMFu+pzpjL7lutO6GEC/TbWr43O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvIQ2R6zB/hj9Rn1JIme9IQiWh7aM4U/fFqA3+Dl/exR4OErz
	hoOe+i4tCsVCH9TAfe5u22xxU+xOfMgXxrS3wzzcALmUQSlBA8xDosdX
X-Gm-Gg: ASbGnctTpJKfIWoVyaID2FCe5YAwottZnvLr5akyBUIlmsobecxssgC6dBFa29o0RUs
	+yFoNz+4b/pXQ4FaXCpH6gtqI0U4ZKRuWa1mwxAp7lM2rOaVVWaA35W9QCnwbiMdtaeq9WbSL6T
	uqEBfJvq3dAtzVX4IOt4s6iPmQcq0tiiIeUVUexq52tm6pMzJCqLMDg9wtHrlKv/vl+9tR6/3dO
	6lVIlGo/Rlxj407XkHuRYzcleoB3CX0sXIrQNRxeWDsC7+gs5WeiGANdJ9rib4VhPHPHWVMmZsF
	qEMT0Gfk3HrJZMejTK+qEj/ruWmLAj/+A2OvzfmHrMj+tRtQG1tiIZdQAmpSjKuL4ZrxMhMu+XP
	pTBeFPtBEY+rAd3aWkQe56mFBhIkpnQXw7qYrnV/uYPl7D1if9XJwgJkKJhRsig61da4OBbmzpA
	1fyQipsEmaRuI=
X-Google-Smtp-Source: AGHT+IH3lGATztfAevxX/+Crp6j/wkxIW4bZ1e3m6KQ8glDX3xAvYvs6wWCH2053VFn2llBG12hFJg==
X-Received: by 2002:a05:6a00:2408:b0:7a9:c21a:559a with SMTP id d2e1a72fcca58-7ba39bc0c02mr18696620b3a.8.1763469428198;
        Tue, 18 Nov 2025 04:37:08 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm16331496b3a.57.2025.11.18.04.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:37:07 -0800 (PST)
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
Subject: [PATCH bpf-next v3 3/6] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
Date: Tue, 18 Nov 2025 20:36:31 +0800
Message-ID: <20251118123639.688444-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118123639.688444-1-dongml2@chinatelecom.cn>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
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


