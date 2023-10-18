Return-Path: <bpf+bounces-12591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD17CE5D8
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 20:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C61F23838
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 18:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862593FE49;
	Wed, 18 Oct 2023 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdRv5InT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B30C14F
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9552C433CA;
	Wed, 18 Oct 2023 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697652284;
	bh=W/noW4qsXFizQrutL2uPhzSsE/kupdIpomu1G4TLw+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdRv5InTyy+nZLAKmeN//T2w+bwIgEuyLGyzTxYWcAF3f3tWHGidTcRhrdxtdVg6T
	 /W/xm8eEmYRD6g0YzDFCXmmMiDBXn00TCT+AUpYTnzIwX2F0urEn/e1871d4UanxeH
	 jPoX+2hENwFbiSnKbsOlTjwipQlxPmnMd4RdfanFj4xRnPSbxKJnUJVaZRC7DZK/+i
	 THSuiy2xM1M0AVlx8oE4BJTuKDVE7H0d5oAyHVaK6URdJlSEd/+zw5FeE3IISwFsYO
	 dFKma1PXja0+/Zwv6q/QguvNTniAMrh8/XHr63RCRAPx7dDhwget3r7nYHYWWLlDWZ
	 sFAo62PTKFiVQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 bpf-next 4/7] bpf, x86: Adjust arch_prepare_bpf_trampoline return value
Date: Wed, 18 Oct 2023 11:03:33 -0700
Message-Id: <20231018180336.1696131-5-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018180336.1696131-1-song@kernel.org>
References: <20231018180336.1696131-1-song@kernel.org>
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


