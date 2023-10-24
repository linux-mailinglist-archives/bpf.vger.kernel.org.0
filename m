Return-Path: <bpf+bounces-13181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E397D5E75
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 00:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A731C20D9A
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776803B7BF;
	Tue, 24 Oct 2023 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ5omFjM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00752D633
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 22:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1331EC433C7;
	Tue, 24 Oct 2023 22:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698187619;
	bh=W/noW4qsXFizQrutL2uPhzSsE/kupdIpomu1G4TLw+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQ5omFjMAgTKNfXnenkxByk/H5IaJiyzbGtX+ToJUTsihHmcDG3pgBrNtdCNkXySl
	 9kptHuWdj/Df82U8an4lci3e0opwXaVc5lzT4ILKhQVR599S3haAKhHKk9IMk9NzEm
	 kQfd5AU6Vc0oi1xQJFLld21G6JN7jpcc2q/bGn6yyaGfvYh0Aq5MN8HNpafyfVamLR
	 arlDfXocOnQYQ/eR7ypmW5gmjo7HEJ8j3HCV2R90BIoGelf/9Svsx5mNYYolMSif/G
	 x+CHeLgvb3x938cga8PqPAxVbU3M35J4w7nSPRPs3dg8mfNpu/AyUsiy/RW3yNjdVb
	 egHNtMDfmRR4A==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	bjorn@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com,
	iii@linux.ibm.com,
	jolsa@kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next 4/7] bpf, x86: Adjust arch_prepare_bpf_trampoline return value
Date: Tue, 24 Oct 2023 15:45:58 -0700
Message-Id: <20231024224601.2292927-5-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024224601.2292927-1-song@kernel.org>
References: <20231024224601.2292927-1-song@kernel.org>
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


