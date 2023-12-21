Return-Path: <bpf+bounces-18547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C3581BC8E
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 18:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1561C25D37
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA7659908;
	Thu, 21 Dec 2023 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU9C4gpH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0385822F;
	Thu, 21 Dec 2023 17:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA25C433C7;
	Thu, 21 Dec 2023 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178249;
	bh=AysrOZqlgDc9SH4JdkOPA/Ij/sFWqRmgvn05g9ch6eY=;
	h=From:Date:Subject:To:Cc:From;
	b=OU9C4gpHAmQFAZbNin+YimkeoUoRvhV1Q6ltOAIXJv2wZWB6QtXJvL9Chvz5lwTEa
	 dBE5zM/lmFKrIBj/GjYvdbKLSywpoJ9cj5IbqYzM7SAOh537K3FUyF5SEhzHH5/zA0
	 N3w4uz290mLGyKEZI5AUV7EIxZPF19FmJAK3kXbPaR+7tJHZxKvz7HVsyLNUTAEbzX
	 EYZDCR0ozA4ldOE4qwMskL0nGHxcaU2LurAab//q0+QhxHYZWF76ERp9gPooKZE187
	 7/VGKvzeZiswWWZudsFzVo3QKhBEIVcsmp3f/3icbSGXB9BwxNfmyZG3tZSHPGqWot
	 CpXQDFqGUI89g==
From: Simon Horman <horms@kernel.org>
Date: Thu, 21 Dec 2023 18:03:52 +0100
Subject: [PATCH bpf-next] bpf: Avoid unnecessary use of comma operator in
 verifier
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-bpf-verifier-comma-v1-1-cde2530912e9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPdvhGUC/x2MQQqAMAzAviI9W3AVFfyKeOhmpz04ZRMRxL87P
 QaS3JAkqiToixuinJp0CxlMWYBbOMyCOmUGqqg2RAbt7vHMjVeJ6LZ1ZWQnTOxsZ9sGcrhH8Xr
 90wE+P8h1wPg8LzZvRNluAAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 bpf@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.12.3

Although it does not seem to have any untoward side-effects,
the use of ';' to separate to assignments seems more appropriate than ','.

Flagged by clang-17 -Wcomma

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f13008d27f35..a376eb609c41 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9616,7 +9616,7 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 	callee->regs[BPF_REG_2].type = PTR_TO_BTF_ID;
 	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
 	callee->regs[BPF_REG_2].btf =  btf_vmlinux;
-	callee->regs[BPF_REG_2].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_VMA],
+	callee->regs[BPF_REG_2].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_VMA];
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_3] = caller->regs[BPF_REG_4];


