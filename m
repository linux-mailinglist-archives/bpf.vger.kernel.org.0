Return-Path: <bpf+bounces-28285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9018B7FBC
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72942B231F1
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AF3190664;
	Tue, 30 Apr 2024 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlyM0NCy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2C184136;
	Tue, 30 Apr 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501826; cv=none; b=PwYvPQqZVdWWn1yVU+nyaV7tXKoseY/7K6nlN7Y13siuJyH3B9Ox5Klo/cMAbgoiSoCWeflX6OHXyLYPvUsxE0qmI8njHCH3p3ceX+7dCGKL9P0zGonbno6MrZ4dsyUizy7yLIA61wn6GIoiABnwYH4fedKJXBpWqYcL/eJdQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501826; c=relaxed/simple;
	bh=YKk+q5wpfcgO4cT/940xLYu20BMGSP13P8+EA5pUyzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=brYnWuT+TdCF3SzTwPtAE1x4+gWuhoHiZcMX7wjV2j4uTqjhVSfMBs6wxhtBKJVXyNZqTXRvEQyyJvQQ8xBg33P3mbC2Vfnskp8kemyM7nFePbTwkAloWsQ7Lc7vt1/mbwyaxKJsN05dlHMJpyKI+ddVs5WKlbDq3V44jj9STAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlyM0NCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B365C2BBFC;
	Tue, 30 Apr 2024 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714501825;
	bh=YKk+q5wpfcgO4cT/940xLYu20BMGSP13P8+EA5pUyzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LlyM0NCyagJPECT7y0W5DK3ucNL0vFsWJOR2yFT+4Gp0DgBVEWTkzE1RzWFKv0cdl
	 mBgYzNBa00DkY0IvipnuIGoPt9ku0wI8PF3JFKr4hfnusFVt1HRm0wqET4lXTxCBI6
	 1bnsI8ebGV6c4eiL5GJdChfiCZvuDuMO65FxwKAEaX4T0RmTCHYQB4zGp/lQ7A8NT0
	 omdVuHhHnQRgvR4Y3mVK8F4jt2vsnNzyUeDW8zoVNRJcxAgxhq92U8EfN0hU+DZ1rz
	 imIKnJGLWo93wb77VbH2BYdu+SoxRBWBWWBtuyadECPH11mH1oCVjatDUhm1rhERVx
	 UomSyyVX9pupA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai
 <xukuohai@huawei.com>, Florent Revest <revest@chromium.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] arm64, bpf: add internal-only MOV
 instruction to resolve per-CPU addrs
In-Reply-To: <CAEf4BzZejgfw=GiX_LTWVupRzrKVaX5Ky6L3wziSoquEFUju2w@mail.gmail.com>
References: <20240426121349.97651-1-puranjay@kernel.org>
 <20240426121349.97651-2-puranjay@kernel.org>
 <CAEf4BzbBBpsuCGgombEj1N8f97iKrMr2WXSoU8jOUfKSqLXnyw@mail.gmail.com>
 <mb61psez8vzbu.fsf@kernel.org>
 <CAEf4BzZejgfw=GiX_LTWVupRzrKVaX5Ky6L3wziSoquEFUju2w@mail.gmail.com>
Date: Tue, 30 Apr 2024 18:30:21 +0000
Message-ID: <mb61p34r23dqa.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Apr 26, 2024 at 9:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Fri, Apr 26, 2024 at 5:14=E2=80=AFAM Puranjay Mohan <puranjay@kerne=
l.org> wrote:
>> >>
>> >> From: Puranjay Mohan <puranjay12@gmail.com>
>> >>
>> >> Support an instruction for resolving absolute addresses of per-CPU
>> >> data from their per-CPU offsets. This instruction is internal-only and
>> >> users are not allowed to use them directly. They will only be used for
>> >> internal inlining optimizations for now between BPF verifier and BPF
>> >> JITs.
>> >>
>> >> Since commit 7158627686f0 ("arm64: percpu: implement optimised pcpu
>> >> access using tpidr_el1"), the per-cpu offset for the CPU is stored in
>> >> the tpidr_el1/2 register of that CPU.
>> >>
>> >> To support this BPF instruction in the ARM64 JIT, the following ARM64
>> >> instructions are emitted:
>> >>
>> >> mov dst, src            // Move src to dst, if src !=3D dst
>> >> mrs tmp, tpidr_el1/2    // Move per-cpu offset of the current cpu in =
tmp.
>> >> add dst, dst, tmp       // Add the per cpu offset to the dst.
>> >>
>> >> To measure the performance improvement provided by this change, the
>> >> benchmark in [1] was used:
>> >>
>> >> Before:
>> >> glob-arr-inc   :   23.597 =C2=B1 0.012M/s
>> >> arr-inc        :   23.173 =C2=B1 0.019M/s
>> >> hash-inc       :   12.186 =C2=B1 0.028M/s
>> >>
>> >> After:
>> >> glob-arr-inc   :   23.819 =C2=B1 0.034M/s
>> >> arr-inc        :   23.285 =C2=B1 0.017M/s
>> >
>> > I still expected a better improvement (global-arr-inc's results
>> > improved more than arr-inc, which is completely different from
>> > x86-64), but it's still a good thing to support this for arm64, of
>> > course.
>> >
>> > ack for generic parts I can understand:
>> >
>> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> >
>>
>> I will have to do more research to find why we don't see very high
>> improvement.
>>
>> But this is what is happening here:
>>
>> This was the complete picture before inlining:
>>
>> int cpu =3D bpf_get_smp_processor_id();
>> mov     x10, #0xffffffffffffd4a8
>> movk    x10, #0x802c, lsl #16
>> movk    x10, #0x8000, lsl #32
>> blr     x10 ---------------------------------------> nop
>>                                                      nop
>>                                                      adrp    x0, 0xffff8=
00082128000
>>                                                      mrs     x1, tpidr_e=
l1
>>                                                      add     x0, x0, #0x8
>>                                                      ldrsw   x0, [x0, x1]
>>             <----------------------------------------ret
>> add     x7, x0, #0x0
>>
>>
>> Now we have:
>>
>> int cpu =3D bpf_get_smp_processor_id();
>> mov     x7, #0xffff8000ffffffff
>> movk    x7, #0x8212, lsl #16
>> movk    x7, #0x8008
>> mrs     x10, tpidr_el1
>> add     x7, x7, x10
>> ldr     w7, [x7]
>>
>>
>> So, we have removed multiple instructions including a branch and a
>> return. I was expecting to see more improvement. This benchmark is taken
>> from a KVM based virtual machine, maybe if I do it on bare-metal I would
>> see more improvement ?
>
> I see, yeah, I think it might change significantly. I remember back
> from times when I was benchmarking BPF ringbuf, I was getting
> very-very different results from inside QEMU vs bare metal. And I
> don't mean just in absolute numbers. QEMU/KVM seems to change a lot of
> things when it comes to contentions, atomic instructions, etc, etc.
> Anyways, for benchmarking, always try to do bare metal.
>

I found the solution to this. I am seeing much better performance when
implementing this inlining in the JIT through another method, similar to
what I did for riscv see[1]

[1] https://lore.kernel.org/all/20240430175834.33152-3-puranjay@kernel.org/

Will do the same for ARM64 in V5 of this series.

Thanks,
Puranjay

