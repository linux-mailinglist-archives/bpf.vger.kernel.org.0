Return-Path: <bpf+bounces-34073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A4A92A179
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 13:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D011F21FA1
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553277E761;
	Mon,  8 Jul 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmQl/e1R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6777113;
	Mon,  8 Jul 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439293; cv=none; b=BCcwdjF8VY5hafAj9wHI/RqK1rbYsyUJ3mqa0X95PHybh3GRVuyL8JXQXuJFqyK+ZG9Npy0cJYXpDhv1LZS0uIfgL1FcCMbXW2zo9z2pL7+C23DHM6DRZSIrZmNauYqbmYR+B1L30ki8LkeysMDtzNFwe3RxzDAM5c7qio2DLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439293; c=relaxed/simple;
	bh=i5ILsQ9VoVlBo8l39ZX3010d75/Wg1BHVm9GReTAJtc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=PNxIOzIt9vK1ybm/dgzFhvhzEYprHixuw7OsKZ0C3i/sx2CmK0C7GWoOxZ8oVrTBPFqwaUU6xJlqiTHDJSofNM31aTcYXFTeAWvP/G7p6jX0ZKBJVd/48vR8HWroQc4MJkPS1ow6lIGjDjklSCzA1/uo1viRlON51pxBLifo4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmQl/e1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EB1C3277B;
	Mon,  8 Jul 2024 11:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720439293;
	bh=i5ILsQ9VoVlBo8l39ZX3010d75/Wg1BHVm9GReTAJtc=;
	h=From:To:Subject:Date:From;
	b=mmQl/e1REfBdTnDJ7gFM+PDLEOQN7XIWFhY4QuDQxRro6Qm3MqA7xLpfL/KVXc6kb
	 3J43StFsu22DFaNUb7OQeT1Zxyd5XE4cZpiikOjgvEu8CwHM9fvGS6A1raSmL3Cacr
	 YgsNHkV8Vt2FRt6cuGdxEniYCAw3AypKV27wTSTpS0SjvGek3kbt6sGi+Xeb1zHraA
	 0y4jkTCNmymZBY0n3m8KVNzGFyGWwQLtS/Hyu+oz8yUY8AJNYpT7h2XVOoXb9DeDVR
	 3eGtIzIpCAmpf2i+CIoB4sgYhS5JWCJxo13b0yANfNo1Z9iJxylAVFdR2nqyYHFBYF
	 9W/pCY/LCQ19g==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] riscv, bpf: Optimize stack usage of trampoline
Date: Mon,  8 Jul 2024 11:47:58 +0000
Message-Id: <20240708114758.64414-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When BPF_TRAMP_F_CALL_ORIG is not set, stack space for passing arguments
on stack doesn't need to be reserved because the original function is
not called.

Only reserve space for stacked arguments when BPF_TRAMP_F_CALL_ORIG is
set.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 685c7389ae7e..0795efdd3519 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -892,7 +892,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	stack_size += 8;
 	sreg_off = stack_size;
 
-	if (nr_arg_slots - RV_MAX_REG_ARGS > 0)
+	if ((flags & BPF_TRAMP_F_CALL_ORIG) && (nr_arg_slots - RV_MAX_REG_ARGS > 0))
 		stack_size += (nr_arg_slots - RV_MAX_REG_ARGS) * 8;
 
 	stack_size = round_up(stack_size, STACK_ALIGN);
-- 
2.40.1


