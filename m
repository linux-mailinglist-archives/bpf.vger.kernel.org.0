Return-Path: <bpf+bounces-45740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D61D9DAD64
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FE7281E4A
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC24120309;
	Wed, 27 Nov 2024 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEdhIAew"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C168201113
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733504; cv=none; b=AxZsr/vEvZyOd1JSn7Y8IK/ZEJFITJcimLMlCH+OSit6k3qUuZ3ufngq0aMAi2dapRuRq/zNLP3+TN0j3g5vaLY9dMp8gpJzothHelya6hMlfJlI7G/h4PQQWdS4P17S/CJKAymL4J+4NolML+/LCxTwICwj3A5XII3eE+SzY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733504; c=relaxed/simple;
	bh=74rzKpRwL/eGKHdxgXp12BarXCS0xTMFX5QgJJZavQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CS0x8YrGNTe6h1Hum7kkI7qtgLKbWlyuntg5kLsVxXTN5SZWpUY154g2Dw8YFOghLmsiAKr/QPwtEhL7yUqvA2xwuDhZvue4f5iSVMsvStfE44hbPyR2OEcgQE2TKwXB/fLyOjIZDRmNIJ+0WcAQGvYG8YkMJ3tmA7X0k4khp/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEdhIAew; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso32689425e9.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 10:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732733500; x=1733338300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6PTl9q6lRBH3tqDgsxX3DlWVqzehzzOiqJYZ44e9sQ=;
        b=LEdhIAewyg8COquEhf6DLIyZL9sXesIZ2uRQtGly4Kjya486iaegiSiCC+172wNC7L
         zgJe1sP0cB7ZhZ+kPqHNv8dkYMPT8qIGJGInKsssAbBSvsOUFiEBHOawjoCUORn6x0nz
         JA2ZpBQrMjHMFVDlshyVoljUSbBvKcxEyGL3CnymGC8El7aYuTEMiDRfly7nlpRHvoYI
         r7fR/rU2bKAsxZ+MgF9OMTIKc9xL9MHNvMoDnk9Bjk3AGR2tatTdA3TVQBx49BALGuy7
         8NGayRd8IPEo6acOvF0sJqRSekG9oVS7zjkxcEEKfq4nOh8g+HV5FdXg9r3eJIes3z9N
         QsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732733500; x=1733338300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6PTl9q6lRBH3tqDgsxX3DlWVqzehzzOiqJYZ44e9sQ=;
        b=sUVTlxWNupbX0TpFz6Fsn5T9D5YdgLEoCKSVih1kQetStKKcQrYd7hNfGn8ZK8PnsY
         YCfAq9+KnY2vl6xN9zatj2a8MdtPq96GPKj0qRy848NyFCib2vXsNjE6CgnC9IzZVEys
         nCtUvQvADsclGLJYSP4f/tDUrnonHHFCs/bh+1RMS9yajxEJd8uRCmTMf5FW1Fc+ZogV
         ZtxqLQQRUO0CefMKFJMQB5+OEel4xT02Ykk9ZzjjNxu0yKMcfAb6OQi83nNt7oIwv05z
         qml9WUdEAiP2fuKfXdHQQ0y7tiThms4VIHYSvYJt+ytkkDrHyRkBbEZst0XRvtk2mfen
         g/KA==
X-Gm-Message-State: AOJu0YwVJdy233+ULFPYYdiVLrU4qLoMw07mtQvrUywUH4qu4iEiLgma
	DI1a+lRz1CpMtEE9aTLL1csu5GtOxMzG2ZXHA7AtAH3rxGd+cpow1efGJjEZYew=
X-Gm-Gg: ASbGncuNqN16pjOd7Irq9CbroY91mefDSUhq0N2FxYTHw/AIwCRnUZb8/XeY55D340D
	uCIz5SEKSfZfqa/trc+XoVD7UAWKiGAoVQ3YrVkwrs73QqAxtfpPFOD7EcMxgsALW5IVlnighGc
	TXlxQ9j4gtfOq2KgoRvNLfgjXOfeelEtVip+FpoK/dotwzAkW3SbgAYdSm2kqejto1Hy3e2Chpz
	ubUEdaKR5GOQLME7/snCiOyvrC1ai8lrx3TUOzxr/AdrozrPFJd03ubQ2jSEv42Du+3IxJyFd+4
X-Google-Smtp-Source: AGHT+IHWPwASK72zHfxe8uUWcapsOIUcUPeaw3jyZm7yn8boZiMukJKXSnIgWNAmjBGrhET23UV02g==
X-Received: by 2002:a05:600c:4587:b0:434:9e17:18e4 with SMTP id 5b1f17b1804b1-434a9d4926dmr41708335e9.0.1732733499991;
        Wed, 27 Nov 2024 10:51:39 -0800 (PST)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7b7917sm29386335e9.13.2024.11.27.10.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 10:51:39 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tao Lyu <tao.lyu@epfl.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v1 2/4] bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots
Date: Wed, 27 Nov 2024 10:51:33 -0800
Message-ID: <20241127185135.2753982-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127185135.2753982-1-memxor@gmail.com>
References: <20241127185135.2753982-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=memxor@gmail.com; h=from:subject; bh=VSaG2aEiYQUl4a9ZAUYAxytzW7sudkJfqBWXv3xLgKE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR2oy93ZwHlbiqdt8rLpZ2/Jb2u1TW6xfu9IN4Tm8 QtS3QOGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0dqMgAKCRBM4MiGSL8RykSyEA CK9ZSH5qAK6RFBvYOmB47H9KstRIy5eoYQKSFjRCME0lSpe9Gt0e64FrhF9MJcqE/nTvXOyxYGRbP7 wjiroGHczyxdyNfzGdD5iobg5F63V2tAj4GwnPNVr5cimHwRqAOv0D7iz7X01C4AAhznS28Q6Z0HyZ /rP3YhML7zq2/r8iuEdstHi2njSjMS+Q6dGIAAGIJbpocOxMbno41eHJr4WhtF6GVB/903FH6EyHZt +GmTmZCHY4Z/KOF+FQHGxZamXIb4jlugxMB3I6JC0+fbHbBQK3HbmkOtgxEhMADVoO8kf+hSnIuoV6 4a2MGRCA3Vmh+HsmoaSUe507drkVKVNtcUOS0HP28TBX+jzi89rv11bZCamMboP34l2XrB/BZxM90z FZKQi72WNLOLmxdjCQXIdxlKHxkLqPNGgc8kcwUVIzfjpPjCpRdhKjI+QqEzGogwaFRva4TDB9xOWH kjjOpV6qJtpEXfG/DPgExTe66s6VxaQNE7VheWO86qpYmGo+6QXWXKHIHxC+P8vZhfYW7iXuf/sbkI l+dqVffh74HZLz/3C07wp8iEYU66JDdUXRB+ZNj/Xcp89JrJ4lDJebylkYnKSUWvmIosoAHrnDHzzN Q55cvuVXozTyMelOVvDSDL9U5N5ZeqDUh+GUrKdDGtA/bFz35nEBx0R84ONg==
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
Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f9791a001e25..7fb3aa6561f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4700,6 +4700,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	 */
 	if (!env->allow_ptr_leaks &&
 	    is_spilled_reg(&state->stack[spi]) &&
+	    !is_spilled_scalar_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
 		return -EACCES;
-- 
2.43.5


