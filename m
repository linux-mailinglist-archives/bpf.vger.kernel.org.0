Return-Path: <bpf+bounces-49986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C6A2145A
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 23:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBAA3A10C3
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 22:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3FC1F03F2;
	Tue, 28 Jan 2025 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pZ6UXDKp"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC091E1A23
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103548; cv=none; b=SFebycvuj8gMfCGQQRYepno73llaiEKGWJr4dPucx2RiQS0gVdfsEzhLqOtPONkA1iyYBbRb3XPy9urdsnWmW2Rljy2GsrK2MYVoZrbOiWFjvj7CigVxEtP+puCywDafZV71BU06EyyoSJWywPooG3hM1efntwZYWQ6jdIIUYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103548; c=relaxed/simple;
	bh=13gY/uKEqRsQYCZpysdMc8uwllBXq7fM/vFQUxsae8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QNIu8oioXYvS80DOaqGV8T7QcRL8Q5qL4fAsJub7WdfupKLg3ig6t2qAwlqIOms4J7qBUonNrDk+ryJtmxlizRNrgLlHsuAHMNXqYnRkmUokML0RdB7DY5CTDq+ms/HIzjNM2m5HWB7zx5RSHe8V9NdcP5parJtP7aGElHjRqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pZ6UXDKp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id E06402037193;
	Tue, 28 Jan 2025 14:32:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E06402037193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738103545;
	bh=gGFrJ9EdvQaJncPUtrPv8buz8OjErRRwSuM9hKZ2Nm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pZ6UXDKpAvk6hiY3fmdoUHTqlL9et43+UqrQ59Zc6woTlv8RD2dme/kq1ngAIJODZ
	 5vvIN9iXSJ9h42s4dWkYlGdc+RPrgBMH1ahb3BiWRNPKtdeGjyePi9mGubZ1M/tSii
	 I0JqAccY56YoYGG7wsjZ/BPgkxpelI+UUd5q9u8M=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, nkapron@google.com, Matteo Croce
 <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Moore
 <paul@paul-moore.com>, code@tyhicks.com, Francis Laniel
 <flaniel@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: bpf signing. Re: [POC][RFC][PATCH] bpf: in-kernel bpf
 relocations on raw elf files
In-Reply-To: <bqxgv2tqk3hp3q3lcdqsw27btmlwqfkhyg6kohsw7lwdgbeol7@nkbxnrhpn7qr>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
 <CAADnVQLxgD_7GYWZZ49aY2LqVYOy4uGvK2ikm7MJ1Cj60VPNaw@mail.gmail.com>
 <87ikqm45da.fsf@microsoft.com>
 <CAADnVQLYeV8-nJ-=_4p8U=xax99-i5QavJrQ=hnKS0EK1ZjecA@mail.gmail.com>
 <87sepl5k4z.fsf@microsoft.com>
 <CAADnVQJtbMCVJ4WfNk44QEh0oVRTYqUMBn3zFAgrVP469k7v2g@mail.gmail.com>
 <bqxgv2tqk3hp3q3lcdqsw27btmlwqfkhyg6kohsw7lwdgbeol7@nkbxnrhpn7qr>
Date: Tue, 28 Jan 2025 14:32:16 -0800
Message-ID: <877c6efu33.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Fastabend <john.fastabend@gmail.com> writes:

> On 2025-01-23 21:08:14, Alexei Starovoitov wrote:
>> On Tue, Jan 14, 2025 at 10:24=E2=80=AFAM Blaise Boscaccy
>> <bboscaccy@linux.microsoft.com> wrote:
>> >
>> > It looks like they are done in the kernel and not necessarily by the
>> > kernel? The relocation logic is emitted by emit_relo* functions during
>> > skeleton generation and the ebpf program is responsible for relocating
>> > itself at runtime, correct? Meaning that the same program is going to
>> > appear very different to the kernel if it's loaded via lskel or libbpf?
>>=20
>> Looks like you're reading the code without actually trying to run it.
>>=20
>> > >> Would it be amenable to possibly alter the light skeleton generation
>> > >> code to pass btf and some other metadata into the kernel along with
>> > >> instructions or are you trying to avoid any sort of fixed dependenc=
ies
>> > >> on anything in the kernel other than the bpf instrucion set itself?
>> > >
>> > > BTF is passed in the lskel.
>> > > There are few relocation-like things that lskel doesn't support.
>> > > One example is __kconfig, but so far there was no request to support=
 that.
>> > > This can be added when needs arise.
>> >
>> > Yes, I ran into the lskel generator doing fun stuff like:
>> >
>> > libbpf: extern (kcfg) 'LINUX_KERNEL_VERSION': set to 0x6080c
>> >
>> > Which caused some concern. Is the feature set for the light skeleton
>> > generator and the feature set for libbpf is expected to drift, whereas
>> > new features will get added to libbpf but they will get added to the
>> > lskel generator if and only if someone requests support for it?
>>=20
>> Correct.
>>=20
>> > Ancillary, would there be opposition to passing the symbol table into
>> > the kernel via the light skeleton?
>>=20
>> Yes, if by "symbol table" you mean ELF symbol table.
>>=20
>> > I couldn't find anything tangible related to a 'gate keeper' on the bpf
>> > mailing list and haven't attended the conferences.  Are you going to
>> > shoot down all attempts at code signing of eBPF programs in the kernel?
>>=20
>> gate keeper concept is the sign verification by the kernel.
>>=20
>> > Internally, we want to cryptographically verify all running kernel code
>> > with a proper root of trust. Additionally we've been looking into
>> > NIST-800-172 requirements. That's currently making eBPF a no-go.  Root
>> > and userspace are not trusted either in these contexts, making userspa=
ce
>> > gate-keeper daemons unworkable.
>>=20
>> The idea was to add LSM-like hook in the prog loading path where
>> "gate keeper" bpf program loaded early during the boot
>> (without any user space) would validate the signature attached
>> to lskel and whatever other prog attributes it might need.
>>=20
>> KP proposed:
>> https://lore.kernel.org/bpf/CACYkzJ6xSk_DHO+3JoCYpGrXjFkk9v-LOSWW0=3D0KL=
wAj1Gc0SA@mail.gmail.com/
>>=20
>> iirc John had the whole design proposal written somewhere,
>> but I cannot find it now.
>>=20
>> John,
>> can you summarize how gate keeper bpf prog would work?
>
>

Hi John,

> Sure. The gate keeper can attach at bpf_prog_load time, note there is
> already a security hook there we can hook to with the bpf_prog struct
> as the only arg. At this point any number of policy about what/who can
> load BPF programs can be applied by looking at the struct and context
> its being called. For better use of crypto functions we would want this
> to be a sleepable program.
>
> Why it needs to be a BPF prog in this model is because I expect the
> policy may be very different depending on the env. We have K8s
> systems, DPUs, VMs, embedded systems all running BPF and each has
> different requirements and different policy metadata.
>
> With BPF/IMA or fsverity infra the caller can be identified by a
> hash giving the identity of the loader. This works today.
>

I'm assuming that you are referring to something akin to=20
https://github.com/isovalent/bpf-verity

> We can also check a signature of the skel here if needed. Maybe some
> kfuncs are still needed (and make it sleepable) I haven't done this
> part yet. I found binding identity of the loader to types of programs
> is a good starting point. A roster of all BPF programs loaded in a
> cluster is doable now. Anyways a kfunc to consume bpf_prog and key
> details to return good/bad is probably fine? Or break it down into
> the individual ops would be more flexible. This should be enough
> to solve the cryptographically verify BPF programs.
>

I think we can try to make something like that work.

> There is also an idea that we could provide more metadata about the
> program by having the verifier include a summary. One proposed example
> was to track helpers/kfuns in use. For example a network program that
> can inspect traffic, but not redirect it.
>

Sure, signature checks and policy checks are complimentary and not
mutually exclusive.=20

> End result is we could build a policy that says these programs can
> load these specific BPF programs. And keep those in maps so it can
> be updated dynamically on a bunch of running systems. I think you
> want the dynamic part so you can have some process to say I'm
> adding these new debug programs or new critical security fixes
> to the list of allowed BPF programs.
>
> Some other commentary:
>
> Also to be complete a way to load BPF programs in early boot would
> reduce/eliminate a window between launched trusted kernel and gate
> keeper launch.
>
> Either the gate keeper can ensure it can't be unloaded by also
> monitoring those paths or we could just pin a refcnt on it when a
> flag is set or it comes from early boot.
>

We would definitely be a supporter of early boot programs that can be
bundled into a kernel that can't be unloaded or detached. There is
probably some wider usage beyond this as well.

> Map updates/manipulation can also wreck BPF logic so you will want to
> also have the gate keeper track that.
>
> As a first step just making it sleepable and exposing the needed
> kfuncs would be realtively easy and get what you need I suspect.
> Added the gatekeeper BPF prog at early boot would likely be all
> you need?
>
> Thanks,
> John


-blaise

