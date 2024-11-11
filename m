Return-Path: <bpf+bounces-44536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1579C4544
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 19:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD027B2B066
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 18:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D0F1AA78A;
	Mon, 11 Nov 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUioYOnQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C571A2567
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350494; cv=none; b=ZmC0+i3XtpQQN/0rqmv0U1iq9QcK8HIIXHtHvjTpEOgHuoUmVHxEKJBMDbRmu4pZVG3+TSyY2MOnnK0T2uglmndVhnN7cgntlbDHUYAkmYVPpD2TViNgo8JIWhXPWbxNLUksmpipIMnQnV9cNe7MtuOk6kzuFymrCCKa2yJnu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350494; c=relaxed/simple;
	bh=6KSIMkKy5Sk+ZrBZwzLsPt1x6NxAHnXIC2fzBbKlGJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tYcYHh8IAHvb/NqT/F+7/oV7TEqyaeUqtoh9o/QZdf+xOBkz5mCl+wyMLmBKtuMQstHTBnFN9RyobTtosahiK6+KNLnnUf8aa5+8D11fBTp253nIExh0SMpoDmd87/PIZjDivWPTx1ex54WPItIpqTJgQVST7Ju7ijnbnuLhpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUioYOnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D5FC4CECF;
	Mon, 11 Nov 2024 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350493;
	bh=6KSIMkKy5Sk+ZrBZwzLsPt1x6NxAHnXIC2fzBbKlGJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SUioYOnQOYHjqhbhDZJloVEjR5xbuBY/fVl6wC85pNU814aeBBjYAczW8ryN27EQG
	 Yimvpy0tDqfbMnyXxozbzkNojbXupk+gti1cKhxWEQFQl2PrrKbiSgegOINrWmBPM/
	 8jR0mcb/aygxIPw7OzCZULLWqNL4xN+g9laYe1J37Gw3ps2VF7MibXRCar/dH1CT6o
	 suA/RGsDQxRlr4WfZZ5gQVSSm4fChZQ5q2KwjXTNC8ELyqZ1Kxqh723vEm8G0EB4yw
	 elHrylS29O88QTEyx0JOWhpzFA0Hf52ypMFkubuvYI4/jM7q3UcPozJPCTauqwgI/z
	 WX2h4y0AkAXbw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 061CE164CC9B; Mon, 11 Nov 2024 19:41:31 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, memxor@gmail.com
Subject: Re: [RFC bpf-next 03/11] bpf: shared BPF/native kfuncs
In-Reply-To: <1ab081f87a60bacb563f4a55d02fa7749aaaeaf9.camel@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
 <20241107175040.1659341-4-eddyz87@gmail.com> <87ses15udm.fsf@toke.dk>
 <1ab081f87a60bacb563f4a55d02fa7749aaaeaf9.camel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Nov 2024 19:41:30 +0100
Message-ID: <87r07h4nqd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Fri, 2024-11-08 at 21:43 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Eduard Zingerman <eddyz87@gmail.com> writes:
>>=20
>> > Inlinable kfuncs are available only if CLANG is used for kernel
>> > compilation.
>>=20
>> To what extent is this a fundamental limitation? AFAIU, this comes from
>> the fact that you are re-using the intermediate compilation stages,
>> right?
>
> Yes, the main obstacle is C --clang--> bitcode as for host --llc--> BPF p=
ipeline.
> And this intermediate step is needed to include some of the header
> files as-is (but not all will work, e.g. those where host inline
> assembly is not dead-code-eliminated by optimizer would error out).
> The reason why 'clang --target=3Dbpf' can't be used with these headers
> is that headers check current architecture in various places, however:
> - there is no BPF architecture defined at the moment;
> - most of the time host architecture is what's needed, e.g.
>   here is a fragment of arch/x86/include/asm/current.h:
>
>   struct pcpu_hot {
>   	union {
>   		struct {
>   			struct task_struct	*current_task;
>   			int			preempt_count;
>   			int			cpu_number;
>   #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
>   			u64			call_depth;
>   #endif
>   			unsigned long		top_of_stack;
>   			void			*hardirq_stack_ptr;
>   			u16			softirq_pending;
>   #ifdef CONFIG_X86_64
>   			bool			hardirq_stack_inuse;
>   #else
>   			void			*softirq_stack_ptr;
>   #endif
>   		};
>   		u8	pad[64];
>   	};
>   };
>
> In case if inlinable kfunc operates on pcpu_hot structure,
> it has to see same binary layout as the host.
> So, technically, 'llc' step is not necessary, but if it is not present
> something else should be done about header files.

Right, makes sense. Do any of the kfuncs you are targeting currently use
headers that have this problem? If not, could a stopgap solution be to
just restrict the set of kfuncs that can be inlined to those that can be
compiled with `clang --target=3Dbpf`? That may require moving around some
code a bit, but there are other examples where all the kfuncs for a
subsystem are kept in a separate .c file anyway (IIRC, netfilter does this).

>> But if those are absent, couldn't we just invoke a full clang
>> compile from source of the same file (so you could get the inlining even
>> when compiling with GCC)?
>
> Yes, hybrid should work w/o problems if headers are dealt with in some
> other way.

But couldn't a hybrid approach be used even in the case of GCC
compilation? I.e., compile it both with GCC (for inclusion into
vmlinux/.ko file) and once with clang (in host mode) and then pass it
through LLC to generate BPF?

-Toke

