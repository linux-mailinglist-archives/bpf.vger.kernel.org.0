Return-Path: <bpf+bounces-8413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AFD78614C
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 22:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2491C20D61
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4931FB5E;
	Wed, 23 Aug 2023 20:20:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F41C2E6
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 20:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241D6C433C7;
	Wed, 23 Aug 2023 20:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692822032;
	bh=mWRrjgHFVNoHHu7TMf8MhELzUccfckHf08+JQ0fi1HY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rzGG1dM52g4MHdoa6aYpybcEJRiKIpRWJetqVfvXZziL8fxVcLfuClRN3xvfmS08Q
	 PEJfGr8vY0P/r6fjTmlYk08L7Z7ABHQFXbbebRmMFX9HMU3dk6NsprEW0xIXoW25ap
	 RoOEc/THm8X55pF/mfkICeEMqJTrx0xl3lXV+/LtLrTLKT32LpKDBLPg9aGmVrTY2n
	 8WBi6z4ArceD/6dQ00OvAvx8ehYYYsOW9jdFfqxE2GaD7fkKYDKiSSS+3jn9JSYTHl
	 oUuLK0E+mYo/KsFzU7obBgUziCTXB3Zv9gCwV7NGooKCNkYzJnFx8MDReuvpi9pIDs
	 H0NSUe17Akmzg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: suagrfillet@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
 aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, guoren@kernel.org, suagrfillet@gmail.com,
 Bjorn Topel <bjorn@rivosinc.com>, jszhang@kernel.org, Conor Dooley
 <conor.dooley@microchip.com>, pulehui@huawei.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, songshuaishuai@tinylab.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH V11 0/5] riscv: Optimize function trace
In-Reply-To: <mhng-a2c88f43-3cf7-4caa-8e4a-b0fc9d7e4628@palmer-ri-x1c9a>
References: <mhng-a2c88f43-3cf7-4caa-8e4a-b0fc9d7e4628@palmer-ri-x1c9a>
Date: Wed, 23 Aug 2023 22:20:29 +0200
Message-ID: <87zg2hse7m.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Palmer Dabbelt <palmer@rivosinc.com> writes:

> On Wed, 12 Jul 2023 11:11:08 PDT (-0700), bjorn@kernel.org wrote:
>> Song Shuai <suagrfillet@gmail.com> writes:
>>
>> [...]
>>
>>> Add WITH_DIRECT_CALLS support [3] (patch 3, 4)
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> We've had some offlist discussions, so here's some input for a wider
>> audience! Most importantly, this is for Palmer, so that this series is
>> not merged until a proper BPF trampoline fix is in place.
>>
>> Note that what's currently usable from BPF trampoline *works*. It's
>> when this series is added that it breaks.
>>
>> TL;DR This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS, which enables
>> fentry/fexit BPF trampoline support. Unfortunately the
>> fexit/BPF_TRAMP_F_SKIP_FRAME parts of the RV BPF trampoline breaks
>> with this addition, and need to be addressed *prior* merging this
>> series. An easy way to reproduce, is just calling any of the kselftest
>> tests that uses fexit patching.
>>
>> The issue is around the nop seld, and how a call is done; The nop sled
>> (patchable-function-entry) size changed from 16B to 8B in commit
>> 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to half"), but
>> BPF code still uses the old 16B. So it'll work for BPF programs, but not
>> for regular kernel functions.
>>
>> An example:
>>
>>   | ffffffff80fa4150 <bpf_fentry_test1>:
>>   | ffffffff80fa4150:       0001                    nop
>>   | ffffffff80fa4152:       0001                    nop
>>   | ffffffff80fa4154:       0001                    nop
>>   | ffffffff80fa4156:       0001                    nop
>>   | ffffffff80fa4158:       1141                    add     sp,sp,-16
>>   | ffffffff80fa415a:       e422                    sd      s0,8(sp)
>>   | ffffffff80fa415c:       0800                    add     s0,sp,16
>>   | ffffffff80fa415e:       6422                    ld      s0,8(sp)
>>   | ffffffff80fa4160:       2505                    addw    a0,a0,1
>>   | ffffffff80fa4162:       0141                    add     sp,sp,16
>>   | ffffffff80fa4164:       8082                    ret
>>
>> is patched to:
>>
>>   | ffffffff80fa4150:  f70c0297                     auipc   t0,-150208512
>>   | ffffffff80fa4154:  eb0282e7                     jalr    t0,t0,-336
>>
>> The return address to bpf_fentry_test1 is stored in t0 at BPF
>> trampoline entry. Return to the *parent* is in ra. The trampline has
>> to deal with this.
>>
>> For BPF_TRAMP_F_SKIP_FRAME/CALL_ORIG, the BPF trampoline will skip too
>> many bytes, and not correctly handle parent calls.
>>
>> Further; The BPF trampoline currently has a different way of patching
>> the nops for BPF programs, than what ftrace does. That should be changed
>> to match what ftrace does (auipc/jalr t0).
>>
>> To summarize:
>>  * Align BPF nop sled with patchable-function-entry: 8B.
>>  * Adapt BPF trampoline for 8B nop sleds.
>>  * Adapt BPF trampoline t0 return, ra parent scheme.
>
> Thanks for digging into this one, I agree we need to sort out the BPF=20
> breakages before we merge this.  Sounds like there's a rabbit hole here,=
=20
> but hopefully we can get it sorted out.
>
> I've dropped this from patchwork and such, as we'll need at least=20
> another spin.

Palmer,

The needed BPF patch is upstream in the bpf-next tree, and has been for
a couple of weeks.

I think this series is a candidate for RISC-V -next! It would help
RISC-V BPF a lot in terms of completeness.


Bj=C3=B6rn

