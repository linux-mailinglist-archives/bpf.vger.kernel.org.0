Return-Path: <bpf+bounces-48834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD19A10FF3
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 19:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91CE188AB21
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6391CDA04;
	Tue, 14 Jan 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TtgtMlKV"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2828A232456
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879073; cv=none; b=t2pAuxCr/rvocIxjlJEBj6WAJAdvxHtrDJgq2x/YTo6FzHcQYUASHYtzCM/6C/Mn0wFWGdeMHum2FuhX0y9G97ja921UtvCyj6Gqm56A/a/esuzfXnZ7Fq4UNGIjZ69uf99hTkfdGmMf/KxN286erR9lqHHv6clIuKGAaFwa9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879073; c=relaxed/simple;
	bh=+RaAVcRS0gyp2cusvdJVIpTEKcQtQ/TOebA6AlkSgik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jQNFGQW+fBgqDkPNdi3wReY5Hlj01CEIqpF89e6uq0YhiZiMcbsAGwQ6Fd75izNYwD+/RDdQGhBrm4PH5JmFYANdAG18E9mkiIh8b0lC9YHVk/J97Ghlvsk5h1aRgOzj7EimNpkRtmVKdqZVmM42DwIDKd1VWSS2CDq27E5OjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TtgtMlKV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4ABD72043F19;
	Tue, 14 Jan 2025 10:24:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4ABD72043F19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736879071;
	bh=o6k2fnz0OjegH7My+6DAync8uloFikrTkoNVFxOr/kk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TtgtMlKViqsSUWmkG706bYSTlCANYxB+HRu9O1KdO+V+SwK90eg2tHmJnnRD2hF3F
	 npAtqPAmkL6ElcCqxzhqlU32v++/nmOvDzmf/W9T2DRtn9B0HDBcwh7KUa+28549pS
	 RyiUHNzcic3SPs9PNn+ZxU3Ijbx2/A3jTNUwIyWA=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, nkapron@google.com, Matteo Croce
 <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Moore
 <paul@paul-moore.com>, code@tyhicks.com, Francis Laniel
 <flaniel@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>
Subject: Re: [POC][RFC][PATCH] bpf: in-kernel bpf relocations on raw elf files
In-Reply-To: <CAADnVQLYeV8-nJ-=_4p8U=xax99-i5QavJrQ=hnKS0EK1ZjecA@mail.gmail.com>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
 <CAADnVQLxgD_7GYWZZ49aY2LqVYOy4uGvK2ikm7MJ1Cj60VPNaw@mail.gmail.com>
 <87ikqm45da.fsf@microsoft.com>
 <CAADnVQLYeV8-nJ-=_4p8U=xax99-i5QavJrQ=hnKS0EK1ZjecA@mail.gmail.com>
Date: Tue, 14 Jan 2025 10:24:12 -0800
Message-ID: <87sepl5k4z.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Jan 10, 2025 at 3:27=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Thu, Jan 9, 2025 at 1:47=E2=80=AFPM Blaise Boscaccy
>> > <bboscaccy@linux.microsoft.com> wrote:
>> >>
>> >>
>> >> This is a proof-of-concept, based off of bpf-next-6.13. The
>> >> implementation will need additional work. The goal of this prototype =
was
>> >> to be able load raw elf object files directly into the kernel and have
>> >> the kernel perform all the necessary instruction rewriting and
>> >> relocation calculations. Having a file descriptor tied to a bpf progr=
am
>> >> allowed us to have tighter integration with the existing LSM
>> >> infrastructure. Additionally, it opens the door for signature and pro=
venance
>> >> checking, along with loading programs without a functioning userspace.
>> >>
>> >> The main goal of this RFC is to get some feedback on the overall
>> >> approach and feasibility of this design.
>> >
>> > It's not feasible.
>> >
>> > libbpf.a is mainly a loader of bpf ELF files.
>> > There is a specific format of ELF files, a convention on section names,
>> > a protocol between LLVM and libbpf, etc.
>> > These things are stable api from libbpf 1.x pov.
>> > There is a chance that they will change in libbpf 2.x.
>> > There are no plans to do so now, but because it's all user space
>> > there is room for changes.
>> > The kernel doesn't have such luxury.
>> > Hence we cannot copy paste libbpf into the kernel and make
>> > it parse the same ELF data, since it will force us to support
>> > this exact format forever.
>> > Hence the design is not feasible.
>> >
>>
>> Noted.
>>
>> > This was discussed multiple times on the list and at LSFMMBPF, LPC
>> > conferences over the years.
>> >
>> > But if the real goal of these patches to:
>> >
>> >> open the door for signature and provenance
>> >> checking, along with loading programs without a functioning userspace.
>> >
>> > then please take a look at the light skeleton.
>> > There is an existing mechanism to load bpf ELF files without libbpf
>> > and without user space.
>> > Search for 'bpftool gen skeleton -L'.
>>
>> Our goal is to have verifiable ebpf programs that are portable across
>> multiple kernels. I looked into light skels, it appears that all the
>> instruction relocations are calculated during skeleton generation and a
>> static instruction buffer containing those fixed relocation results is
>> passed into the kernel? For some relocs, those values would be
>> deterministic, making that a non-issue. For others that rely on btf data
>> or kernel symbols those might not be portable anymore.
>
> Specifically?
> lskel preservers CORE. BTF based relocations are done by the kernel.
>

It looks like they are done in the kernel and not necessarily by the
kernel? The relocation logic is emitted by emit_relo* functions during
skeleton generation and the ebpf program is responsible for relocating
itself at runtime, correct? Meaning that the same program is going to
appear very different to the kernel if it's loaded via lskel or libbpf?

>> Would it be amenable to possibly alter the light skeleton generation
>> code to pass btf and some other metadata into the kernel along with
>> instructions or are you trying to avoid any sort of fixed dependencies
>> on anything in the kernel other than the bpf instrucion set itself?
>
> BTF is passed in the lskel.
> There are few relocation-like things that lskel doesn't support.
> One example is __kconfig, but so far there was no request to support that.
> This can be added when needs arise.

Yes, I ran into the lskel generator doing fun stuff like:

libbpf: extern (kcfg) 'LINUX_KERNEL_VERSION': set to 0x6080c

Which caused some concern. Is the feature set for the light skeleton
generator and the feature set for libbpf is expected to drift, whereas
new features will get added to libbpf but they will get added to the
lskel generator if and only if someone requests support for it?
Ancillary, would there be opposition to passing the symbol table into
the kernel via the light skeleton?

I couldn't find anything tangible related to a 'gate keeper' on the bpf
mailing list and haven't attended the conferences.  Are you going to
shoot down all attempts at code signing of eBPF programs in the kernel?
Internally, we want to cryptographically verify all running kernel code
with a proper root of trust. Additionally we've been looking into
NIST-800-172 requirements. That's currently making eBPF a no-go.  Root
and userspace are not trusted either in these contexts, making userspace
gate-keeper daemons unworkable.=20

