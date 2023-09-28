Return-Path: <bpf+bounces-11026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FC17B17FA
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 11:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 42446281A99
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA81F347CA;
	Thu, 28 Sep 2023 09:59:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823822E65C;
	Thu, 28 Sep 2023 09:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6806DC433C7;
	Thu, 28 Sep 2023 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695895168;
	bh=9srMMotEqbhbBuL+dYXb0BtYM8i9fxU6uHTLigNDg/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mu8PV3nmlz33FGq3etKSxi+cMml8leJ/Li1y7N5wrOdfIOj2FZyuUlbyHAa5ZeV4r
	 XTIhuq+zf4wUpLusnjDuPBc6IWKHEoZbWl5WSAUGep+xKmDMaHjFqNWcGDHAPqTt5I
	 e7s6grZP5ija4rCqRIpRPQVLMxv9MGdEI+FmiGBiZBS6vCm6ttVdBo5esxqIiPM84H
	 UAD6mfR9lHciesi4gxZbfAt1m6ICIjDv56CUolSFnUrMbLt2ObZjWKGMNDrn/JSEZx
	 EFRY1h9sSgOtEfbRMfYGH3vcrcl5xJSuhAGspGiK+ZZf//0LkU1WWWOpoydA10FxRE
	 VCWzYgOJBr2kw==
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
Subject: Re: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
In-Reply-To: <20230919035711.3297256-5-pulehui@huaweicloud.com>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
Date: Thu, 28 Sep 2023 11:59:24 +0200
Message-ID: <87lecqobyb.fsf@all.your.base.are.belong.to.us>
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
> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
> the TCC can be propagated from the parent process to the subprocess, but
> the TCC of the parent process cannot be restored when the subprocess
> exits. Since the RV64 TCC is initialized before saving the callee saved
> registers into the stack, we cannot use the callee saved register to
> pass the TCC, otherwise the original value of the callee saved register
> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
> similar to x86_64, i.e. using a non-callee saved register to transfer
> the TCC between functions, and saving that register to the stack to
> protect the TCC value. At the same time, we also consider the scenario
> of mixing trampoline.

Hi!

The RISC-V JIT tries to minimize the stack usage, e.g. it doesn't have a
fixed pro/epilogue like some of the other JITs. I think we can do better
here, so that the pass-TCC-via-register can be used, and the additional
stack access can be avoided.

Today, the TCC is passed via a register (a6) and can be viewed as a
"state" variable/transparent argument/return value. As you point out, we
loose this when we do a call. On (any) calls we move the TCC to a
callee-saved register.

WDYT about the following scheme:

1 Pickup the arm64 bpf2bpf/tailmix mechanism of just clearing the TCC
  for the main program.
2 For BPF helper calls, move TCC to s6, perform the call, and restore
  a6. Dito for kfunc calls (BPF_PSEUDO_KFUNC_CALL).
3 For all other calls, a6 is passed transparently.

For 2 bpf_jit_get_func_addr() can be used to determine if the callee is
a BPF helper or not.

In summary; Determine in the JIT if we're leaving BPF-land, and need to
move the TCC to a callee-saved reg, or not, and save us a bunch of stack
store/loads.


Bj=C3=B6rn

