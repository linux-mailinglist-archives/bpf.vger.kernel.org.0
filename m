Return-Path: <bpf+bounces-16942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A542807B8F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034862824BA
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638D328C1;
	Wed,  6 Dec 2023 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us1peJHG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C5328AC
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 22:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AD6C433C7;
	Wed,  6 Dec 2023 22:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701902511;
	bh=cm9e9xvBMClh5IRRQbU1b++94MoN/7tPBtGYUwAt8eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Us1peJHGBjOndG37JoOwXXyX38+SOdkEBvYup8Ji7bJCCTX7Pu0gm2vgK5/nqbLTy
	 j/cLNREBXF4MG3URMKCvFRo4DKBXhcngGtQSCCz6+KyhxFpWmNYz+PID6leqsleuel
	 GGNQfJdL2ULxs4ZfWm8dC7Aj9BtihtFxr1ySdkyCjKx4GgamU2gwIl6A/wPVddIFjz
	 hATTUX3Hpbr79EQaP7sehippO13SJJ2sBdrTpS3yzbST0x78zBx8TcLTe3mIh9Pqml
	 o99oTuwuALJo+3pngM/gwq9mSfCpUARXMb6nLfyYs9Y86io+XGSdXJMoDonpMqVnxN
	 pQoW4l+fEJNuQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v7 bpf-next 4/7] bpf, x86: Adjust arch_prepare_bpf_trampoline return value
Date: Wed,  6 Dec 2023 14:40:51 -0800
Message-Id: <20231206224054.492250-5-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206224054.492250-1-song@kernel.org>
References: <20231206224054.492250-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86's implementation of arch_prepare_bpf_trampoline() requires
BPF_INSN_SAFETY buffer space between end of program and image_end. OTOH,
the return value does not include BPF_INSN_SAFETY. This doesn't cause any
real issue at the moment. However, "image" of size retval is not enough for
arch_prepare_bpf_trampoline(). This will cause confusion when we introduce
a new helper arch_bpf_trampoline_size(). To avoid future confusion, adjust
the return value to include BPF_INSN_SAFETY.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9abc239..5f7528cac344 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2671,7 +2671,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		ret = -EFAULT;
 		goto cleanup;
 	}
-	ret = prog - (u8 *)image;
+	ret = prog - (u8 *)image + BPF_INSN_SAFETY;
 
 cleanup:
 	kfree(branches);
-- 
2.34.1


