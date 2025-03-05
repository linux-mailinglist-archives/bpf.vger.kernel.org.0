Return-Path: <bpf+bounces-53293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC65A4F8D9
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 09:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC91892720
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78781FC0F8;
	Wed,  5 Mar 2025 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LeiaTm3O"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09471D86F6;
	Wed,  5 Mar 2025 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163498; cv=none; b=a4Eps+8N7fPDSrMglk6UlV9zSQKvGdGBtPaVRg1g6w6pAuknGF8qXvuzaNEFmpRhaux8yvj+F/11WWEIJmOVZL0W4+M0KA5wopn6gP+fwGqKD7ovqnccbdUmf9TcrDGob8Xe0XeUyJAvSAOieVM0ju/kdpRyI9A5+UldpvFrNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163498; c=relaxed/simple;
	bh=iX8irvHRcmV+psqnPxftJmyB2TWBumGfxW6KaDH4gjQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ULoJJunvE21Wzx7viv337PHg2HGwsgAEesT1VuvDc9de/xTOaW1SW1aaSLR/U/mRmonlb/wQhDO3kRUZ+ncoCsD6Oste+0bTK5cBj/WqOKcOoF0qpUkWDJiJaU3MZfiV4+j7I1YzEL5Fu9z1gq6BfdL0uRAp8ThcnnFsknX2D/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LeiaTm3O; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5258Tkoa3044543
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 5 Mar 2025 00:29:47 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5258Tkoa3044543
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741163391;
	bh=blf/TiOtbprpDLJNtfD3y4oyxoUcu4XFE3PfFSXAZMQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=LeiaTm3OcHAce14jA4D/ZHWqu+UtBIS5XG4gqHwgcoOzbl/wq6Da6xdHQoGGKCoxT
	 T3qpHmrxIpG0bcDA6I70X/yc4/N2vxII+WdUGNdZqtRjvI+DwoW4wIIWyunlZACq+G
	 9zquu1aXuKa6nsC3gKEAsy4i71ZUY+DTROhGW5AYNx4DreuQOIzGdPJNEiIRvbGpuV
	 C+3uxcYgR6B4fnB9aO/wFsSNYbYXIadCnKQOFmN9g3/aC7I+zXDFaKe/7holtL9Fw4
	 4+ZYAI0WXO0BHMrZZISHmKY8LvwpM+KHvgo+hRJpKGyYlaRf75sjCoxIsvE+fa85Cy
	 VPWyvOwVfENvg==
Date: Wed, 05 Mar 2025 00:29:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Menglong Dong <menglong8.dong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
CC: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org,
        davem@davemloft.net, dsahern@kernel.org,
        mathieu.desnoyers@efficios.com, nathan@kernel.org,
        nick.desaulniers+lkml@gmail.com, morbo@google.com,
        samitolvanen@google.com, kees@kernel.org, dongml2@chinatelecom.cn,
        akpm@linux-foundation.org, riel@surriel.com, rppt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
User-Agent: K-9 Mail for Android
In-Reply-To: <CADxym3busXZKtX=+FY_xnYw7e1CKp5AiHSasZGjVJTdeCZao-g@mail.gmail.com>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn> <20250303132837.498938-2-dongml2@chinatelecom.cn> <20250303165454.GB11590@noisy.programming.kicks-ass.net> <CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com> <20250304053853.GA7099@noisy.programming.kicks-ass.net> <20250304061635.GA29480@noisy.programming.kicks-ass.net> <CADxym3bS_6jpGC3vLAAyD20GsR+QZofQw0_GgKT8nN3c-HqG-g@mail.gmail.com> <20250304094220.GC11590@noisy.programming.kicks-ass.net> <6F9EF5C3-4CAE-4C5E-B70E-F73462AC7CA0@zytor.com> <CADxym3busXZKtX=+FY_xnYw7e1CKp5AiHSasZGjVJTdeCZao-g@mail.gmail.com>
Message-ID: <694E52E0-C9E5-49D2-A677-09A5EE442590@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 4, 2025 5:19:09 PM PST, Menglong Dong <menglong8=2Edong@gmail=2Eco=
m> wrote:
>On Tue, Mar 4, 2025 at 10:53=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>
>> On March 4, 2025 1:42:20 AM PST, Peter Zijlstra <peterz@infradead=2Eorg=
> wrote:
>> >On Tue, Mar 04, 2025 at 03:47:45PM +0800, Menglong Dong wrote:
>> >> We don't have to select FUNCTION_ALIGNMENT_32B, so the
>> >> worst case is to increase ~2=2E2%=2E
>> >>
>> >> What do you think?
>> >
>> >Well, since I don't understand what you need this for at all, I'm firm=
ly
>> >on the side of not doing this=2E
>> >
>> >What actual problem is being solved with this meta data nonsense? Why =
is
>> >it worth blowing up our I$ footprint over=2E
>> >
>> >Also note, that if you're going to be explaining this, start from
>> >scratch, as I have absolutely 0 clues about BPF and such=2E
>>
>> I would appreciate such information as well=2E The idea seems dubious o=
n the surface=2E
>
>Ok, let me explain it from the beginning=2E (My English is not good,
>but I'll try to describe it as clear as possible :/)
>
>Many BPF program types need to depend on the BPF trampoline,
>such as BPF_PROG_TYPE_TRACING, BPF_PROG_TYPE_EXT,
>BPF_PROG_TYPE_LSM, etc=2E BPF trampoline is a bridge between
>the kernel (or bpf) function and BPF program, and it acts just like the
>trampoline that ftrace uses=2E
>
>Generally speaking, it is used to hook a function, just like what ftrace
>do:
>
>foo:
>    endbr
>    nop5  -->  call trampoline_foo
>    xxxx
>
>In short, the trampoline_foo can be this:
>
>trampoline_foo:
>    prepare a array and store the args of foo to the array
>    call fentry_bpf1
>    call fentry_bpf2
>    =2E=2E=2E=2E=2E=2E
>    call foo+4 (origin call)
>    save the return value of foo
>    call fexit_bpf1 (this bpf can get the return value of foo)
>    call fexit_bpf2
>    =2E=2E=2E=2E=2E=2E=2E
>    return to the caller of foo
>
>We can see that the trampoline_foo can be only used for
>the function foo, as different kernel function can be attached
>different BPF programs, and have different argument count,
>etc=2E Therefore, we have to create 1000 BPF trampolines if
>we want to attach a BPF program to 1000 kernel functions=2E
>
>The creation of the BPF trampoline is expensive=2E According to
>my testing, It will spend more than 1 second to create 100 bpf
>trampoline=2E What's more, it consumes more memory=2E
>
>If we have the per-function metadata supporting, then we can
>create a global BPF trampoline, like this:
>
>trampoline_global:
>    prepare a array and store the args of foo to the array
>    get the metadata by the ip
>    call metadata=2Efentry_bpf1
>    call metadata=2Efentry_bpf2
>    =2E=2E=2E=2E
>    call foo+4 (origin call)
>    save the return value of foo
>    call metadata=2Efexit_bpf1 (this bpf can get the return value of foo)
>    call metadata=2Efexit_bpf2
>    =2E=2E=2E=2E=2E=2E=2E
>    return to the caller of foo
>
>(The metadata holds more information for the global trampoline than
>I described=2E)
>
>Then, we don't need to create a trampoline for every kernel function
>anymore=2E
>
>Another beneficiary can be ftrace=2E For now, all the kernel functions th=
at
>are enabled by dynamic ftrace will be added to a filter hash if there are
>more than one callbacks=2E And hash lookup will happen when the traced
>functions are called, which has an impact on the performance, see
>__ftrace_ops_list_func() -> ftrace_ops_test()=2E With the per-function
>metadata supporting, we can store the information that if the callback is
>enabled on the kernel function to the metadata, which can make the perfor=
mance
>much better=2E
>
>The per-function metadata storage is a basic function, and I think there
>may be other functions that can use it for better performance in the feat=
ure
>too=2E
>
>(Hope that I'm describing it clearly :/)
>
>Thanks!
>Menglong Dong
>

This is way too cursory=2E For one thing, you need to start by explaining =
why you are asking to put this *inline* with the code, which is something t=
hat normally would be avoided at all cost=2E

