Return-Path: <bpf+bounces-65997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C7FB2C025
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C577617D3D8
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E555A322DB8;
	Tue, 19 Aug 2025 11:20:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8B749620;
	Tue, 19 Aug 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602410; cv=none; b=AVWIHCY+lxjTnDkFvPyIaDEuE0xxSBS6nwPHd51GLeuNrnGODmBWqs2Jun3SAndyK61e5KvN9DxiQZH73OLOvGeLAYTrMywZRHX0q93BwqF0+5kqHO4KKPgz9wwSiBhgzecSdudaeeHSUQoPvg+4wrsO/O7h+i2pHCMbfEaca5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602410; c=relaxed/simple;
	bh=3iN1imWj6bQi5lTmvbgFFhxC24mms+RpMTKHbwO5Mo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AB/ebxAM+6++4ZuC9mpFU9kogTyaTNHAngfkOzHIHz+4VpKZXb4JNdrhlvD8YSVzNVSANHg0BGbNhtBzaBhZHWao3my/WzHLBvf5JDw4C9i007B5jOIjaODXevFL5YrLwuZJgvBzGxe9s2lR1UDDbfk56nF6tpkRjAwgjoEE85U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38288C4CEF1;
	Tue, 19 Aug 2025 11:20:07 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@gmail.com>,
	George Guo <guodongtai@kylinos.cn>,
	Chenghao Duan <duanchenghao@kylinos.cn>,
	loongarch@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] LoongArch: BPF: Fix uninitialized symbol 'retval_off'
Date: Tue, 19 Aug 2025 19:19:53 +0800
Message-ID: <20250819111953.3197428-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __arch_prepare_bpf_trampoline(), retval_off is meaningful only when
save_ret is not 0, so the current logic is correct. But it may cause a
build warning:

arch/loongarch/net/bpf_jit.c:1547 __arch_prepare_bpf_trampoline() error: uninitialized symbol 'retval_off'.

So initialize retval_off unconditionally to fix it.

Fixes: f9b6b41f0cf3 ("LoongArch: BPF: Add basic bpf trampoline support")
Closes: https://lore.kernel.org/r/202508191020.PBBh07cK-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index abfdb6bb5c38..a73f6ea4ed4a 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1504,11 +1504,10 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	stack_size += 16;
 
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
-	if (save_ret) {
-		/* Save BPF R0 and A0 */
-		stack_size += 16;
-		retval_off = stack_size;
-	}
+	if (save_ret)
+		stack_size += 16; /* Save BPF R0 and A0 */
+
+	retval_off = stack_size;
 
 	/* Room of trampoline frame to store args */
 	nargs = m->nr_args;
-- 
2.47.3


