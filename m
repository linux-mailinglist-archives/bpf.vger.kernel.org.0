Return-Path: <bpf+bounces-59376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 876D9AC96FC
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600C11C05C94
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E2280339;
	Fri, 30 May 2025 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NHVWqEld"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582581D7E42;
	Fri, 30 May 2025 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748639970; cv=none; b=RmWy7rFTQGjgDmWnVsF81NLzQz7Uht0+RlxnSS/UNTATyck9cYdlrLEiWpoDJVUUs8Ta0x7Ad0jWc3KtRdKAFJxdz10+mHYg62bN3Qf2QUvIbBy0yA5X9ldO0gZdyGm8djT3EfmxY5+XyzAlziOU37voXASwoJn3IumhKmMU/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748639970; c=relaxed/simple;
	bh=iBNKDTx8DCJklJr7P1xLJs/0HVc/KL187ghqaIj0y5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FMo3Pd8Iizn5Wiz/jGu5gMlFpVOb4htLVS4mw0C3mahEeUmmrruMcgpseNZmMk7vHjScEzgLZtPQhr/ammPypdpJ/fxLhpjyd7rUU7lD8UQXU+ZDFi5gQQnVRaWwJvR0H5VzmCd7hzudGNdd4t02CjxPxg5OOgypNtv6T+LzMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NHVWqEld; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id AF2632078637;
	Fri, 30 May 2025 14:19:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF2632078637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748639967;
	bh=Yi/L1evNbp/oOWb9EkOnldb8ZSyMBVNCYJXiU60dc/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NHVWqEldeWzDyXOpU5ERUBwC3tpAl4bw9qVSZiRAZd5xkCrjoXo6hBXtVW3CMdRIG
	 Fsgh35UUYAE/8z9gin5OIAm41Ikj5bWUZeIp5FZZ9UNqh8lBAtfx30MQoQL8xzthdM
	 IfbfKw8rrVEjqWS7riVD9IdHsfphxCD2zr23F9BU=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, jarkko@kernel.org,
 zeffron@riotgames.com, xiyou.wangcong@gmail.com, kysrinivasan@gmail.com,
 code@tyhicks.com, linux-security-module@vger.kernel.org,
 roberto.sassu@huawei.com, James.Bottomley@hansenpartnership.com, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Howells
 <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, Ignat Korchagin
 <ignat@cloudflare.com>, Quentin Monnet <qmo@kernel.org>, Jason Xing
 <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>, Anton
 Protopopov <aspsk@isovalent.com>, Jordan Rome <linux@jordanrome.com>,
 Martin Kelly <martin.kelly@crowdstrike.com>, Alan Maguire
 <alan.maguire@oracle.com>, Matteo Croce <teknoraver@meta.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kys@microsoft.com
Subject: Re: [PATCH 0/3] BPF signature verification
In-Reply-To: <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
Date: Fri, 30 May 2025 14:19:22 -0700
Message-ID: <87iklhn6ed.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KP Singh <kpsingh@kernel.org> writes:

> On Wed, May 28, 2025 at 11:50=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> As suggested or mandated by KP Singh
>> https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=3D-FmXz4=
6GHJh3d=3DFXh5j4KfexcEFbHV-vg@mail.gmail.com/,
>> this patchset proposes and implements an alternative hash-chain
>> algorithm for signature verification of BPF programs.
>>
>>
>>
>> This design diverges in two key ways:
>>
>> 1. Signature Strategy
>>
>> Two different signature strategies are
>> implemented. One verifies only the signature of the loader program in
>> the kernel, as described in the link above. The other verifies the
>> program=E2=80=99s maps in-kernel via a hash chain.  The original design
>> required loader programs to be =E2=80=9Cself-aborting=E2=80=9D and embed=
ded the
>> terminal hash verification logic as metaprogramming code generation
>> routines inside libbpf. While this patchset supports that scheme, it
>> is considered undesirable in certain environments due to the potential
>> for supply-chain attack vectors and the lack of visibility for the LSM
>
> The loader program is signed by a trusted entity, If you trust the
> signature, then you trust it to do the signature verification.

That's the whole point. I explicitly don't want to be forced, by you,
to trust unspecified third parties, BPF programs or the BPF virtual
machine/JIT to perform signature verification, when it's demonstrably
trivial to do this in the kernel, without precluding or limiting the
chain loader scheme that you wish to have for Cilium/bpftrace.

> This is
> a fairly common pattern in security and a pattern that we will be
> using in other signed bpf use-cases which can choose to depend on
> signed loaders.
>

And that isn't at odds with the kernel being able to do it nor is it
with what I posted.

> If your build environment that signs the BPF program is compromised
> and can inject arbitrary code, then signing does not help.  Can you
> explain what a supply chain attack would look like here?
>

Most people here can read C code. The number of people that can read
ebpf assembly metaprogramming code is much smaller. Compromising clang
is one thing, compromising libbpf is another. Your proposal increases
the attack surface with no observable benefit. If I was going to leave a
hard-to-find backdoor into ring0, gen.c would be a fun place to explore
doing it. Module and UEFI signature verification code doesn't live
inside of GCC or Clang as set of meta-instructions that get emitted, and
there are very good reasons for that.

Further, since the signature verification code is unique for each and
every program it needs to be verified/proved/tested for each and every
program. Additionally, since all these checks are being forced outside
of the kernel proper, with the insistence of keeping the LSM layer in
the dark of the ultimate result, the only way to test that a program
will fail if the map is corrupted is to physically corrupt each and
every program and test that individually. That isn't "elegant" nor "user
friendly" in any way, shape or form.

>> subsystem.  Additionally, it is impossible to verify the code
>> performing the signature verification, as it is uniquely regenerated
>
> The LSM needs to ensure that it allows trusted LOADER programs i.e.
> with signatures and potentially trusted signed user-space binaries
> with unsigned or delegated signing (this will be needed for Cilium and
> bpftrace that dynamically generate BPF programs), that's a more
> important aspect of the LSM policy from a BPF perspective.
>

I would like to be able to sign my programs please and have the kernel
verify it was done correctly. Why are you insisting that I *don't* do
that?  I'm yet to see any technical objection to doing that. Do you have
one that you'd like to share at this point?

> MAP_EXCLUSIVE is missing and is required which prevents maps from
> being accessed by other programs as explained in the proposal.
>
> Please hold off on further iterations, I am working on a series and
> will share these patches based on the design that was proposed.
>

So the premise here seems to be that people should only be allowed to
sign trusted loaders, and that trusted loaders must additionally be
authored by you, correct?

When can we expect to see your patchset posted?

>>
>> for every program.
>>
>>
>>
>> 2. Timing of Signature Check
>>
>> This patchset moves the signature check to a point before
>> security_bpf_prog_load is invoked, due to an unresolved discussion
>> here:
>
> This is fine and what I had in mind, signature verification does not
> need to happen in the verifier and the existing hooks are good enough.
> I did not reply to Paul's comment since this is a fairly trivial
> detail and would be obvious in the implementation that the verifier is
> not the right place to check the signature anyways as the instruction
> buffer is only stable pre-verification.
>
>> https://lore.kernel.org/linux-security-module/CAHC9VhTj3=3DZXgrYMNA+G64z=
sOyZO+78uDs1g=3Dkh91=3DGR5KypYg@mail.gmail.com/
>> This change allows the LSM subsystem to be informed of the signature
>> verification result=E2=80=94if it occurred=E2=80=94and the method used, =
all without
>> introducing a new hook. It improves visibility and auditability,
>> reducing the =E2=80=9Ctrust me, friend=E2=80=9D aspect of the original d=
esign.
>
>
> On Wed, May 28, 2025 at 11:50=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> As suggested or mandated by KP Singh
>> https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=3D-FmXz4=
6GHJh3d=3DFXh5j4KfexcEFbHV-vg@mail.gmail.com/,
>> this patchset proposes and implements an alternative hash-chain
>> algorithm for signature verification of BPF programs.
>>
>> This design diverges in two key ways:
>>
>> 1. Signature Strategy
>>
>> Two different signature strategies are
>> implemented. One verifies only the signature of the loader program in
>> the kernel, as described in the link above. The other verifies the
>> program=E2=80=99s maps in-kernel via a hash chain.  The original design
>> required loader programs to be =E2=80=9Cself-aborting=E2=80=9D and embed=
ded the
>> terminal hash verification logic as metaprogramming code generation
>> routines inside libbpf. While this patchset supports that scheme, it
>> is considered undesirable in certain environments due to the potential
>> for supply-chain attack vectors and the lack of visibility for the LSM
>> subsystem.  Additionally, it is impossible to verify the code
>> performing the signature verification, as it is uniquely regenerated
>> for every program.
>>
>> 2. Timing of Signature Check
>>
>> This patchset moves the signature check to a point before
>> security_bpf_prog_load is invoked, due to an unresolved discussion
>> here:
>> https://lore.kernel.org/linux-security-module/CAHC9VhTj3=3DZXgrYMNA+G64z=
sOyZO+78uDs1g=3Dkh91=3DGR5KypYg@mail.gmail.com/
>> This change allows the LSM subsystem to be informed of the signature
>> verification result=E2=80=94if it occurred=E2=80=94and the method used, =
all without
>> introducing a new hook. It improves visibility and auditability,
>> reducing the =E2=80=9Ctrust me, friend=E2=80=9D aspect of the original d=
esign.
>>
>>
>> Blaise Boscaccy (3):
>>   bpf: Add bpf_check_signature
>>   bpf: Support light-skeleton signatures in autogenerated code
>>   bpftool: Allow signing of light-skeleton programs
>>
>>  include/linux/bpf.h            |   2 +
>>  include/linux/verification.h   |   1 +
>>  include/uapi/linux/bpf.h       |   4 +
>>  kernel/bpf/arraymap.c          |  11 +-
>>  kernel/bpf/syscall.c           | 123 +++++++++++++++++++-
>>  tools/bpf/bpftool/Makefile     |   4 +-
>>  tools/bpf/bpftool/common.c     | 204 +++++++++++++++++++++++++++++++++
>>  tools/bpf/bpftool/gen.c        |  66 ++++++++++-
>>  tools/bpf/bpftool/main.c       |  24 +++-
>>  tools/bpf/bpftool/main.h       |  23 ++++
>>  tools/include/uapi/linux/bpf.h |   4 +
>>  tools/lib/bpf/libbpf.h         |   4 +
>>  tools/lib/bpf/skel_internal.h  |  28 ++++-
>>  13 files changed, 491 insertions(+), 7 deletions(-)
>>
>> --
>> 2.48.1
>>

