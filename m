Return-Path: <bpf+bounces-28456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C88B9E5C
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F742897F4
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405BD15DBC6;
	Thu,  2 May 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iznJJ4qb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914D15AAC5;
	Thu,  2 May 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666747; cv=none; b=apm2c7KdiTuLQZH1kRWyBGmf7oeybKYytl10KFChb1QIpj3lGKwxY/rdziHWKv9Q6c3w1/3s73C+GacZHtk2oXQ34CGFTleUPXObLBvfFlT+6T1LU7VLTOOQiNJd7vWMQW1pc8gcnK7Ngw9f4Mc1setsotluDiiI9k4hOjKSmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666747; c=relaxed/simple;
	bh=cfpd7jyzmkAweaa0hD3uTqGADQ0i4iCKVXcnU1BPD5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lEPNx2a9VFEKbq9MFGlVfX4vZPu7pHMttIiYmJwVfdzO75dP70usI3GJaD3shktR4d6YLLiWqgOziPtYK7dAHgevmc2zrZt/D/Hi93dEqBkFBHFv7Xab3q1fk+by3CqBdrZ9UlDUfOupcVFtQZHlvtsJy2wUuIVxOJVsWtPPYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iznJJ4qb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20565C113CC;
	Thu,  2 May 2024 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714666747;
	bh=cfpd7jyzmkAweaa0hD3uTqGADQ0i4iCKVXcnU1BPD5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iznJJ4qbBWR7NpsLRpKzCXcgRKLWAZYR171nJcG3Nespiw1EWNbUbDk87RXO15exq
	 QWyNqSgjM5+PIbIa2LpqoJdaumaWvVXIKuOm+d/vOR63qEsvpXRDS/27rFY6rdrWj/
	 VO2P/mcatsHtq9y+T7efokkMSu8CdwHGDVScWM+fdNFUgE7c/hOE1xBLfdcxPfBNHr
	 oKZQtD57RNlxH4L6Sgd+61BJzHbqPKocp+1+shNYIi1ufyJg2Ght67OrjYpfqFCGUu
	 +5azFcRRYEtKDPT8nGPqgaZRWIfMctYvcVwa+TBhT7egp6kFM8Q9KciRdKnySwQe2m
	 D+1lx2W9khUxA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Pu Lehui
 <pulehui@huawei.com>
Cc: puranjay12@gmail.com
Subject: Re: [PATCH bpf-next v2 2/2] riscv, bpf: inline
 bpf_get_smp_processor_id()
In-Reply-To: <20240430175834.33152-3-puranjay@kernel.org>
References: <20240430175834.33152-1-puranjay@kernel.org>
 <20240430175834.33152-3-puranjay@kernel.org>
Date: Thu, 02 May 2024 18:19:04 +0200
Message-ID: <87edakw5jb.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay@kernel.org> writes:

> Inline the calls to bpf_get_smp_processor_id() in the riscv bpf jit.
>
> RISCV saves the pointer to the CPU's task_struct in the TP (thread
> pointer) register. This makes it trivial to get the CPU's processor id.
> As thread_info is the first member of task_struct, we can read the
> processor id from TP + offsetof(struct thread_info, cpu).
>
>           RISCV64 JIT output for `call bpf_get_smp_processor_id`
> 	  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
>                 Before                           After
>                --------                         -------
>
>          auipc   t1,0x848c                  ld    a5,32(tp)
>          jalr    604(t1)
>          mv      a5,a0
>
> Benchmark using [1] on Qemu.
>
> ./benchs/run_bench_trigger.sh glob-arr-inc arr-inc hash-inc
>
> +---------------+------------------+------------------+--------------+
> |      Name     |     Before       |       After      |   % change   |
> |---------------+------------------+------------------+--------------|
> | glob-arr-inc  | 1.077 =C2=B1 0.006M/s | 1.336 =C2=B1 0.010M/s |   + 24.=
04%   |
> | arr-inc       | 1.078 =C2=B1 0.002M/s | 1.332 =C2=B1 0.015M/s |   + 23.=
56%   |
> | hash-inc      | 0.494 =C2=B1 0.004M/s | 0.653 =C2=B1 0.001M/s |   + 32.=
18%   |
> +---------------+------------------+------------------+--------------+
>
> NOTE: This benchmark includes changes from this patch and the previous
>       patch that implemented the per-cpu insn.
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

