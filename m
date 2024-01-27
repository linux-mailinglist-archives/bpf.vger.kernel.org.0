Return-Path: <bpf+bounces-20480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197383EEF4
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 18:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C4FB2279E
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F78C2C869;
	Sat, 27 Jan 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0pJFd5/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE028F1;
	Sat, 27 Jan 2024 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706375804; cv=none; b=LpKgwPgd5Jf6wnYs3oLNbUKpHmHFTOJE/Ozi0zQ9CKfi7gicRsp6IM5/vuqjRjZa1/gm3Ko+t3jkM1C4PDoxaT9o21oy9QfLRckXYj/Y+2yAryBdxaXAgVhpqNHG/UjDB2cxzQvnwyFK5/btSo1xZwLt3cDJid3ZkSonNLzjnDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706375804; c=relaxed/simple;
	bh=acwMSsV+BIR9hyLFitq87kqodiG+FRm654GOucmVCbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LS/cLaepBmS/u6m54p0USsngcBU2FWKjElxDuwbQwMEbqJBWQIE3lnSJVLMO6Ft4eqbrMb6SqOrpABbEocWIWH4EZr7heMgN+0dU4APsFgMEpyrfnsNPLYqAGXlRi+WQiSYZBd5dfOi3A1JawD1ycTUaO8qV+OQl+Xs3/HnfTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0pJFd5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF65C433C7;
	Sat, 27 Jan 2024 17:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706375804;
	bh=acwMSsV+BIR9hyLFitq87kqodiG+FRm654GOucmVCbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d0pJFd5/Ogi3PYIzIdOfS+uXGLLhXwNmFvODpGYYHNd0ZRdWnZMSNftcaoja1+UJ/
	 WNlYbyrSatfTW6jnUqJg5L8eYFf/abJkI1/gQbij0fZzVMAyprj6oosOxSWMm1MdiC
	 rafss5up2RjIJI/XX80bU03wVJUimUHRhEWSLAEm3cOErp7V4yoW8K4kjETTtVfAZs
	 4wVszg/b5fLO1SJwlRVnhBF+OvD/yj/sYoCix3aC9npoV+6i74W3cbj7Xjlg6u+wbp
	 3c1eNuwxcEjO+4cCJzAo7/F/BmmHkis7BJE3aLuqnuj+UE8Fhmnp9ZlO4dQqRVgliI
	 x/HAiCRJPZVkA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH RESEND bpf-next v3 4/6] riscv, bpf: Add necessary Zbb
 instructions
In-Reply-To: <20240115131235.2914289-5-pulehui@huaweicloud.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <20240115131235.2914289-5-pulehui@huaweicloud.com>
Date: Sat, 27 Jan 2024 18:16:41 +0100
Message-ID: <871qa2zog6.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Add necessary Zbb instructions introduced by [0] to reduce code size and
> improve performance of RV64 JIT. Meanwhile, a runtime deteted helper is
> added to check whether the CPU supports Zbb instructions.
>
> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bit=
manip-1.0.0-38-g865e7a7.pdf [0]
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index e30501b46f8f..51f6d214086f 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>  	return IS_ENABLED(CONFIG_RISCV_ISA_C);
>  }
>=20=20
> +static inline bool rvzbb_enabled(void)
> +{
> +	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(R=
ISCV_ISA_EXT_ZBB);

Hmm, I'm thinking about the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) semantics
for a kernel JIT compiler.

IS_ENABLED(CONFIG_RISCV_ISA_ZBB) affects the kernel compiler flags.
Should it be enough to just have the run-time check? Should a kernel
built w/o Zbb be able to emit Zbb from the JIT?


Bj=C3=B6rn

