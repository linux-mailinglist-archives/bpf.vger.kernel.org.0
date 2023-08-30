Return-Path: <bpf+bounces-8993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B1A78D6F6
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 17:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D285628117E
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B546FD5;
	Wed, 30 Aug 2023 15:28:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3945680
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 15:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D00EC433C7;
	Wed, 30 Aug 2023 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693409298;
	bh=eJALBHCOH5TNLwcXGS4IHCmyippx6NMKrCvUKry2GQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nhzi6KfuNMLLKMLYQz+CTspkyOAHr2fx0TU1jDN91VvxBfExqgoAFaVBPFiX8D/67
	 rYU41bkX5HVHBttIchBMF59LrzrpFc8K5sCmi90Lu4j1JZ6IOwNCygdydITpM10OAS
	 Hsa0aKGFHX5qI3oXjjTMgR4sB6RPIRW/UNAiXa+hugcMKyOqCfvbQxKy0cQxF1uA2R
	 yFoXsNnRqULDYI8f7hdcnMrX9267Gl3x1vAK3xz6FLdQjns5eIvOp2zklWa/S5k+UH
	 gBrjdWt6gGY5/wo/mVxZAcmlsXFrlSs6ovwMv8VlOkeywrjn706gFRJhaejf5lbDVN
	 fql+08fXAs7jA==
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
In-Reply-To: <87zg2hse7m.fsf@all.your.base.are.belong.to.us>
References: <mhng-a2c88f43-3cf7-4caa-8e4a-b0fc9d7e4628@palmer-ri-x1c9a>
 <87zg2hse7m.fsf@all.your.base.are.belong.to.us>
Date: Wed, 30 Aug 2023 17:28:15 +0200
Message-ID: <87a5u85z3k.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Palmer Dabbelt <palmer@rivosinc.com> writes:
>
>> On Wed, 12 Jul 2023 11:11:08 PDT (-0700), bjorn@kernel.org wrote:
>>> Song Shuai <suagrfillet@gmail.com> writes:
>>>
>>> [...]
>>>
>>>> Add WITH_DIRECT_CALLS support [3] (patch 3, 4)
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> We've had some offlist discussions, so here's some input for a wider
>>> audience! Most importantly, this is for Palmer, so that this series is
>>> not merged until a proper BPF trampoline fix is in place.
>>>
>>> Note that what's currently usable from BPF trampoline *works*. It's
>>> when this series is added that it breaks.
>>>
>>> TL;DR This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS, which enables
>>> fentry/fexit BPF trampoline support. Unfortunately the
>>> fexit/BPF_TRAMP_F_SKIP_FRAME parts of the RV BPF trampoline breaks
>>> with this addition, and need to be addressed *prior* merging this
>>> series. An easy way to reproduce, is just calling any of the kselftest
>>> tests that uses fexit patching.
>>>
>>> The issue is around the nop seld, and how a call is done; The nop sled
>>> (patchable-function-entry) size changed from 16B to 8B in commit
>>> 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to half"), but
>>> BPF code still uses the old 16B. So it'll work for BPF programs, but not
>>> for regular kernel functions.
>>>
>>> An example:
>>>
>>>   | ffffffff80fa4150 <bpf_fentry_test1>:
>>>   | ffffffff80fa4150:       0001                    nop
>>>   | ffffffff80fa4152:       0001                    nop
>>>   | ffffffff80fa4154:       0001                    nop
>>>   | ffffffff80fa4156:       0001                    nop
>>>   | ffffffff80fa4158:       1141                    add     sp,sp,-16
>>>   | ffffffff80fa415a:       e422                    sd      s0,8(sp)
>>>   | ffffffff80fa415c:       0800                    add     s0,sp,16
>>>   | ffffffff80fa415e:       6422                    ld      s0,8(sp)
>>>   | ffffffff80fa4160:       2505                    addw    a0,a0,1
>>>   | ffffffff80fa4162:       0141                    add     sp,sp,16
>>>   | ffffffff80fa4164:       8082                    ret
>>>
>>> is patched to:
>>>
>>>   | ffffffff80fa4150:  f70c0297                     auipc   t0,-1502085=
12
>>>   | ffffffff80fa4154:  eb0282e7                     jalr    t0,t0,-336
>>>
>>> The return address to bpf_fentry_test1 is stored in t0 at BPF
>>> trampoline entry. Return to the *parent* is in ra. The trampline has
>>> to deal with this.
>>>
>>> For BPF_TRAMP_F_SKIP_FRAME/CALL_ORIG, the BPF trampoline will skip too
>>> many bytes, and not correctly handle parent calls.
>>>
>>> Further; The BPF trampoline currently has a different way of patching
>>> the nops for BPF programs, than what ftrace does. That should be changed
>>> to match what ftrace does (auipc/jalr t0).
>>>
>>> To summarize:
>>>  * Align BPF nop sled with patchable-function-entry: 8B.
>>>  * Adapt BPF trampoline for 8B nop sleds.
>>>  * Adapt BPF trampoline t0 return, ra parent scheme.
>>
>> Thanks for digging into this one, I agree we need to sort out the BPF=20
>> breakages before we merge this.  Sounds like there's a rabbit hole here,=
=20
>> but hopefully we can get it sorted out.
>>
>> I've dropped this from patchwork and such, as we'll need at least=20
>> another spin.
>
> Palmer,
>
> The needed BPF patch is upstream in the bpf-next tree, and has been for
> a couple of weeks.
>
> I think this series is a candidate for RISC-V -next! It would help
> RISC-V BPF a lot in terms of completeness.

Palmer,

The needed fix for BPF is now in Linus' tree, commit 25ad10658dc1
("riscv, bpf: Adapt bpf trampoline to optimized riscv ftrace
framework"). IOW, this ftrace series can be merged now.


Bj=C3=B6rn

