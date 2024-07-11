Return-Path: <bpf+bounces-34575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C1E92EB88
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503E7283858
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706C154BE8;
	Thu, 11 Jul 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vod8Zieg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2FDAD39;
	Thu, 11 Jul 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711134; cv=none; b=jjtkAXjy/gb6hA9FbnV/1bAebLMwLENCR5yt0kYxcqiIJ04SCzRWc8s2iiJVJULIZ+W4MD426i/ga4s3Dtg19O7y/k8N5BIqTuB5d3Xmu6BL/z1mUb9piBjVO9J8bnEE7uY3k97NqNY7hN2rmICpVEwDp7ARZ5H1ntnFooaUkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711134; c=relaxed/simple;
	bh=lgCOm4ajbDC2WkfLf4CQCsarvwNbzKn4RzkwvqZn7DU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UsJYwcYYBmxZhlhbGlb4KLgNEuuyTaRRekGYhstN8PXjRMIRbUB536UNLaOfHN09lkTkQX0EzaqCzb4XNw+WDQiigBu9ARtGixVXdJT/6GChZ+4xSZNMljEjdgwfbUAMajrWRKv2PSowyhIlvK4Zf0pguURPAJ0zvz+OFT+k3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vod8Zieg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AF8C116B1;
	Thu, 11 Jul 2024 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720711134;
	bh=lgCOm4ajbDC2WkfLf4CQCsarvwNbzKn4RzkwvqZn7DU=;
	h=From:To:Subject:Date:From;
	b=Vod8ZiegXAS+eCiFiA43QsxWkAF/BzmyEwLYmS7RVWpJcK0w9RQdWpdiqFL8KaoV9
	 NEEGpnz7pdk9LnQyW0rLLbt4AZeTEP9fr3ZQLyYc7GsPfybfudZ1y+NIwNmKhkpoLK
	 IFXOGPBM+hySYlni/Cz56k8OQRr+yz9xU9FcfNF7cgXURK8AFxE5ZX0AhrSSmKFihf
	 crVzC9tGc5U3+HIqOBKco07HiYdRimdnv567fBWdvLBrIMXv/Cl18XkexN1B+umB1d
	 u16P4vzgQNPQqlMjLWNYGEn6VpH8wMuvQSdcExkwmgQj2Altc4g33pmIaSmqpYN9U0
	 Au8wWBr2wJAKg==
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, arm64: fix trampoline for BPF_TRAMP_F_CALL_ORIG
Date: Thu, 11 Jul 2024 15:18:38 +0000
Message-Id: <20240711151838.43469-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When BPF_TRAMP_F_CALL_ORIG is set, the trampoline calls
__bpf_tramp_enter() and __bpf_tramp_exit() functions, passing them the
struct bpf_tramp_image *im pointer as an argument in R0.

The trampoline generation code uses emit_addr_mov_i64() to emit
instructions for moving the bpf_tramp_image address into R0, but
emit_addr_mov_i64() assumes the address to be in the vmalloc() space and
uses only 48 bits. Because bpf_tramp_image is allocated using kzalloc(),
its address can use more than 48-bits, in this case the trampoline
will pass an invalid address to __bpf_tramp_enter/exit() causing a
kernel crash.

Fix this by using emit_a64_mov_i64() in place of emit_addr_mov_i64() as
it can work with addresses that are greater than 48-bits.

Fixes: efc9909fdce0 ("bpf, arm64: Add bpf trampoline for arm64")
Closes: https://lore.kernel.org/all/SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com/
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 720336d28856..1bf483ec971d 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2141,7 +2141,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
+		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_enter, ctx);
 	}
 
@@ -2185,7 +2185,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = ctx->ro_image + ctx->idx;
-		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
+		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_exit, ctx);
 	}
 
-- 
2.40.1


