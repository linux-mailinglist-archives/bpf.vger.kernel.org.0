Return-Path: <bpf+bounces-42316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80079A2625
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 17:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E896A1C21E1A
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80BC1DED44;
	Thu, 17 Oct 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcECLRmH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3321DE4D3;
	Thu, 17 Oct 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177867; cv=none; b=Smk5V1D3HOyhaBZhibvg90O3lhEP0n1E4EsOOvRAmn8l79kR03wX97HgULVPoOhSw91U+n8SRsvRYeLxWfWpM136l4+AlOAWzfqovSA8Y5Pi6NS9o+R943yc4mKHPxR6lnL/oe7WE6LId2OtnFDSH+RuoF3H+nuAFP2qFveq14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177867; c=relaxed/simple;
	bh=SnKuZN95QP+kG5D0ecNm9ncfwWOj/8URnLFsyyX28Wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbhV4vAH9FO1w2OlC9MTvO2/KaWRSr4owP5cQx9Wt9afmQ/mKFT+/zBAcwtjFnaPY1iYFzBRzhrjJWKoSno36XZsX8zc3YWCuOTlS8ZfHWQfPwIJMxghR9ZpSWg2IQb6Q1BYjDVDEith+qV2zO48LMZxPWYsHgIOUel/2WpVb1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcECLRmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5E5C4CEC3;
	Thu, 17 Oct 2024 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177866;
	bh=SnKuZN95QP+kG5D0ecNm9ncfwWOj/8URnLFsyyX28Wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rcECLRmHOHRc/9rUjRK95q5DTfCxfRY3bowCpKmhb7Zdj0b1zqTpt0FvAs0s3x1gu
	 rEfeey8eKtPWmUf5PN6sZl4PGnDfZKVbuB8sfdilOqT2PSPmaqztm6GsF4VC2FFnJ2
	 0fjLdn3z9DVqMsscFimh9Z1a2yt5MZAi8/vaMLLp8JnM03G6ru+Pr+KMFznsOyRx1H
	 +6IGNahTNugP15VA0DwJklm+lNxqqJdbii7K4H+7L4KF57HtnC5wZPwLvAoMnPnZ0q
	 DI4fPUF7QEtgtwU+0zclo4Df2Q4w7z28sZvhvi3wHpAkVTvmF823QiaOz7xkM0VT4+
	 4A++/tB7cQmDA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>, Andrea Parri
 <parri.andrea@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 pulehui@huawei.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, paulmck@kernel.org, puranjay12@gmail.com
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH] riscv, bpf: Make BPF_CMPXCHG fully ordered
In-Reply-To: <mb61piktqpz25.fsf@kernel.org>
References: <20241017143628.2673894-1-parri.andrea@gmail.com>
 <mb61piktqpz25.fsf@kernel.org>
Date: Thu, 17 Oct 2024 17:11:03 +0200
Message-ID: <87iktq7ojc.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks, Andrea!

Puranjay Mohan <puranjay@kernel.org> writes:

> Andrea Parri <parri.andrea@gmail.com> writes:
>
>> According to the prototype formal BPF memory consistency model
>> discussed e.g. in [1] and following the ordering properties of
>> the C/in-kernel macro atomic_cmpxchg(), a BPF atomic operation
>> with the BPF_CMPXCHG modifier is fully ordered.  However, the
>> current RISC-V JIT lowerings fail to meet such memory ordering
>> property.  This is illustrated by the following litmus test:
>>
>> BPF BPF__MP+success_cmpxchg+fence
>> {
>>  0:r1=3Dx; 0:r3=3Dy; 0:r5=3D1;
>>  1:r2=3Dy; 1:r4=3Df; 1:r7=3Dx;
>> }
>>  P0                               | P1                                  =
       ;
>>  *(u64 *)(r1 + 0) =3D 1             | r1 =3D *(u64 *)(r2 + 0)           =
           ;
>>  r2 =3D cmpxchg_64 (r3 + 0, r4, r5) | r3 =3D atomic_fetch_add((u64 *)(r4=
 + 0), r5) ;
>>                                   | r6 =3D *(u64 *)(r7 + 0)             =
         ;
>> exists (1:r1=3D1 /\ 1:r6=3D0)
>>
>> whose "exists" clause is not satisfiable according to the BPF
>> memory model.  Using the current RISC-V JIT lowerings, the test
>> can be mapped to the following RISC-V litmus test:
>>
>> RISCV RISCV__MP+success_cmpxchg+fence
>> {
>>  0:x1=3Dx; 0:x3=3Dy; 0:x5=3D1;
>>  1:x2=3Dy; 1:x4=3Df; 1:x7=3Dx;
>> }
>>  P0                 | P1                          ;
>>  sd x5, 0(x1)       | ld x1, 0(x2)                ;
>>  L00:               | amoadd.d.aqrl x3, x5, 0(x4) ;
>>  lr.d x2, 0(x3)     | ld x6, 0(x7)                ;
>>  bne x2, x4, L01    |                             ;
>>  sc.d x6, x5, 0(x3) |                             ;
>>  bne x6, x4, L00    |                             ;
>>  fence rw, rw       |                             ;
>>  L01:               |                             ;
>> exists (1:x1=3D1 /\ 1:x6=3D0)
>>
>> where the two stores in P0 can be reordered.  Update the RISC-V
>> JIT lowerings/implementation of BPF_CMPXCHG to emit an SC with
>> RELEASE ("rl") annotation in order to meet the expected memory
>> ordering guarantees.  The resulting RISC-V JIT lowerings of
>> BPF_CMPXCHG match the RISC-V lowerings of the C atomic_cmpxchg().
>
> Thanks for fixing this, I fixed all others in:
>
> 20a759df3bba ("riscv, bpf: make some atomic operations fully ordered")
>
>> Fixes: dd642ccb45ec ("riscv, bpf: Implement more atomic operations for R=
V64")
>> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>
> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

