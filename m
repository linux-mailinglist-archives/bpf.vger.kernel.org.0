Return-Path: <bpf+bounces-59395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C8AC97B7
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 00:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EA3A41521
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 22:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CFC283FD8;
	Fri, 30 May 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VA3ZhUKj"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4954652;
	Fri, 30 May 2025 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748644036; cv=none; b=skW7eQHL0u0gdsK0zlO42hQqOnMLVmyPjAs2b89PgYyE0un7OqOs9wONNXK+Y7Lg4DAmE4HeSxu1vnTT1DePM6VAxQHxbcnCMRiSOpNsNjXlk3aZZUJXmfODRbk4FsUIYf1JM5b4l4yDmMoBGESNmSPVZtveqpc/9zLIVKIGQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748644036; c=relaxed/simple;
	bh=5QZPWjXnrmkvng3Wp1U7UF4UUY9zdCBwzsZKLrfIHwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l6WY48LhFcCDUPUjpkiA9iOlWj5832pnK6EGegXeXWZv945NOgGw2RvhmU7HfIXs97lGirkvCcTFJRKGUqvXTTjGUSSkwrjVPDJgUw17Nn8j0UzEmN4Ofdc33zNrRwcArpV2Y+DlWrMqdbagSPiUYqnBtUc0CAU3oMW9pmRkhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VA3ZhUKj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 158A5210C329;
	Fri, 30 May 2025 15:27:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 158A5210C329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748644033;
	bh=eITWxPRYeGjbHklL07LcBxsMgKFodRKBIo9Q8PG8axQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VA3ZhUKjSycmnbrl4qDZqqSxRSujU1L8U5Zv8o/+A20t2Sg1lAAeD/ejAV7AxeiH2
	 y46R/FB6dtkJPX2UMvS6L2nA3Pgm9p/opucYdlsEod0aGzbZB/Dd/F2RG+exxg2lbF
	 E5ouzB4CbuKxLvZADt1fjJuyUN7NyoIr42dc5kYo=
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
In-Reply-To: <CACYkzJ4ondubPHDF8HL-sseVQo7AtJ2uo=twqhqLWaE3zJ=jEA@mail.gmail.com>
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
 <87iklhn6ed.fsf@microsoft.com>
 <CACYkzJ75JXUM_C2og+JNtBat5psrEzjsgcV+b74FwrNaDF68nA@mail.gmail.com>
 <87ecw5n3tz.fsf@microsoft.com>
 <CACYkzJ4ondubPHDF8HL-sseVQo7AtJ2uo=twqhqLWaE3zJ=jEA@mail.gmail.com>
Date: Fri, 30 May 2025 15:27:09 -0700
Message-ID: <878qmdn39e.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KP Singh <kpsingh@kernel.org> writes:

> On Sat, May 31, 2025 at 12:14=E2=80=AFAM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> KP Singh <kpsingh@kernel.org> writes:
>>
>> > On Fri, May 30, 2025 at 11:19=E2=80=AFPM Blaise Boscaccy
>> > <bboscaccy@linux.microsoft.com> wrote:
>> >>
>> >> KP Singh <kpsingh@kernel.org> writes:
>> >>
>> >
>> > [...]
>> >
>> >> >
>> >>
>> >> And that isn't at odds with the kernel being able to do it nor is it
>> >> with what I posted.
>> >>
>> >> > If your build environment that signs the BPF program is compromised
>> >> > and can inject arbitrary code, then signing does not help.  Can you
>> >> > explain what a supply chain attack would look like here?
>> >> >
>> >>
>> >> Most people here can read C code. The number of people that can read
>> >> ebpf assembly metaprogramming code is much smaller. Compromising clang
>> >> is one thing, compromising libbpf is another. Your proposal increases
>> >> the attack surface with no observable benefit. If I was going to leav=
e a
>> >> hard-to-find backdoor into ring0, gen.c would be a fun place to explo=
re
>> >> doing it. Module and UEFI signature verification code doesn't live
>> >> inside of GCC or Clang as set of meta-instructions that get emitted, =
and
>> >> there are very good reasons for that.
>> >>
>> >> Further, since the signature verification code is unique for each and
>> >> every program it needs to be verified/proved/tested for each and every
>> >> program. Additionally, since all these checks are being forced outside
>> >> of the kernel proper, with the insistence of keeping the LSM layer in
>> >> the dark of the ultimate result, the only way to test that a program
>> >> will fail if the map is corrupted is to physically corrupt each and
>> >> every program and test that individually. That isn't "elegant" nor "u=
ser
>> >> friendly" in any way, shape or form.
>> >>
>> >> >> subsystem.  Additionally, it is impossible to verify the code
>> >> >> performing the signature verification, as it is uniquely regenerat=
ed
>> >> >
>> >> > The LSM needs to ensure that it allows trusted LOADER programs i.e.
>> >> > with signatures and potentially trusted signed user-space binaries
>> >> > with unsigned or delegated signing (this will be needed for Cilium =
and
>> >> > bpftrace that dynamically generate BPF programs), that's a more
>> >> > important aspect of the LSM policy from a BPF perspective.
>> >> >
>> >>
>> >> I would like to be able to sign my programs please and have the kernel
>> >> verify it was done correctly. Why are you insisting that I *don't* do
>> >> that?  I'm yet to see any technical objection to doing that. Do you h=
ave
>> >> one that you'd like to share at this point?
>> >
>> > The kernel allows a trusted loader that's signed with your private
>> > key, that runs in the kernel context to delegate the verification.
>> > This pattern of a trusted / delegated loader is going to be required
>> > for many of the BPF use-cases that are out there (Cilium, bpftrace)
>> > that dynamically generate eBPF programs.
>> >
>> > The technical objection is that:
>> >
>> > * It does not align with most BPF use-cases out there as most
>> > use-cases need a trusted loader.
>>
>> No, it's definitely a use case. It's trivial to support both a trusted
>> loader and a signature over the hash chain of supplied assets.
>>
>> > * Locks us into a UAPI, whereas a signed LOADER allows us to
>> > incrementally build signing for all use-cases without compromising the
>> > security properties.
>> >
>>
>> Your proposal locks us into a UAPI as well. There is no way to make to
>> do this via UAPI without making a UAPI design choice.
>>
>> > BPF's philosophy is that of flexibility and not locking the users into
>> > a rigid in-kernel implementation and UAPI.
>> >
>>
>> Then why are you locking us into a rigid
>> only-signing-the-loader-is-allowed implementation?
>
> I explained this before, the delegated / trusted loader is needed by
> many BPF use-cases. A UAPI is forever, thus the lock-in.
>

Again, I'm not following. What is technically wrong with supporting both
signing a loader only and allowing for the signature of multiple
passed-in assets? It's trivial to support both and any path forward will
force a UAPI lock-in.

Do you simply feel that it isn't a valid use case and therefore we
shouldn't be allowed to do it?

> - KP
>
>>
>> > - KP
>> >
>> >>
>> >> > MAP_EXCLUSIVE is missing and is required which prevents maps from
>> >> > being accessed by other programs as explained in the proposal.
>> >> >
>> >> > Please hold off on further iterations, I am working on a series and
>> >> > will share these patches based on the design that was proposed.
>> >> >
>> >>
>> >> So the premise here seems to be that people should only be allowed to
>> >> sign trusted loaders, and that trusted loaders must additionally be
>> >> authored by you, correct?
>> >>
>> >> When can we expect to see your patchset posted?
>> >>
>> >> >>
>> >> >> for every program.
>> >> >>
>> >> >>
>> >> >>
>> >> >> 2. Timing of Signature Check
>> >> >>
>> >> >> This patchset moves the signature check to a point before
>> >> >> security_bpf_prog_load is invoked, due to an unresolved discussion
>> >> >> here:
>> >> >
>> >> > This is fine and what I had in mind, signature verification does not
>> >> > need to happen in the verifier and the existing hooks are good enou=
gh.
>> >> > I did not reply to Paul's comment since this is a fairly trivial
>> >> > detail and would be obvious in the implementation that the verifier=
 is
>> >> > not the right place to check the signature anyways as the instructi=
on
>> >> > buffer is only stable pre-verification.
>> >> >
>> >> >> https://lore.kernel.org/linux-security-module/CAHC9VhTj3=3DZXgrYMN=
A+G64zsOyZO+78uDs1g=3Dkh91=3DGR5KypYg@mail.gmail.com/
>> >> >> This change allows the LSM subsystem to be informed of the signatu=
re
>> >> >> verification result=E2=80=94if it occurred=E2=80=94and the method =
used, all without
>> >> >> introducing a new hook. It improves visibility and auditability,
>> >> >> reducing the =E2=80=9Ctrust me, friend=E2=80=9D aspect of the orig=
inal design.
>> >> >
>> >> >
>> >> > On Wed, May 28, 2025 at 11:50=E2=80=AFPM Blaise Boscaccy
>> >> > <bboscaccy@linux.microsoft.com> wrote:
>> >> >>
>> >> >> As suggested or mandated by KP Singh
>> >> >> https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=3D=
-FmXz46GHJh3d=3DFXh5j4KfexcEFbHV-vg@mail.gmail.com/,
>> >> >> this patchset proposes and implements an alternative hash-chain
>> >> >> algorithm for signature verification of BPF programs.
>> >> >>
>> >> >> This design diverges in two key ways:
>> >> >>
>> >> >> 1. Signature Strategy
>> >> >>
>> >> >> Two different signature strategies are
>> >> >> implemented. One verifies only the signature of the loader program=
 in
>> >> >> the kernel, as described in the link above. The other verifies the
>> >> >> program=E2=80=99s maps in-kernel via a hash chain.  The original d=
esign
>> >> >> required loader programs to be =E2=80=9Cself-aborting=E2=80=9D and=
 embedded the
>> >> >> terminal hash verification logic as metaprogramming code generation
>> >> >> routines inside libbpf. While this patchset supports that scheme, =
it
>> >> >> is considered undesirable in certain environments due to the poten=
tial
>> >> >> for supply-chain attack vectors and the lack of visibility for the=
 LSM
>> >> >> subsystem.  Additionally, it is impossible to verify the code
>> >> >> performing the signature verification, as it is uniquely regenerat=
ed
>> >> >> for every program.
>> >> >>
>> >> >> 2. Timing of Signature Check
>> >> >>
>> >> >> This patchset moves the signature check to a point before
>> >> >> security_bpf_prog_load is invoked, due to an unresolved discussion
>> >> >> here:
>> >> >> https://lore.kernel.org/linux-security-module/CAHC9VhTj3=3DZXgrYMN=
A+G64zsOyZO+78uDs1g=3Dkh91=3DGR5KypYg@mail.gmail.com/
>> >> >> This change allows the LSM subsystem to be informed of the signatu=
re
>> >> >> verification result=E2=80=94if it occurred=E2=80=94and the method =
used, all without
>> >> >> introducing a new hook. It improves visibility and auditability,
>> >> >> reducing the =E2=80=9Ctrust me, friend=E2=80=9D aspect of the orig=
inal design.
>> >> >>
>> >> >>
>> >> >> Blaise Boscaccy (3):
>> >> >>   bpf: Add bpf_check_signature
>> >> >>   bpf: Support light-skeleton signatures in autogenerated code
>> >> >>   bpftool: Allow signing of light-skeleton programs
>> >> >>
>> >> >>  include/linux/bpf.h            |   2 +
>> >> >>  include/linux/verification.h   |   1 +
>> >> >>  include/uapi/linux/bpf.h       |   4 +
>> >> >>  kernel/bpf/arraymap.c          |  11 +-
>> >> >>  kernel/bpf/syscall.c           | 123 +++++++++++++++++++-
>> >> >>  tools/bpf/bpftool/Makefile     |   4 +-
>> >> >>  tools/bpf/bpftool/common.c     | 204 ++++++++++++++++++++++++++++=
+++++
>> >> >>  tools/bpf/bpftool/gen.c        |  66 ++++++++++-
>> >> >>  tools/bpf/bpftool/main.c       |  24 +++-
>> >> >>  tools/bpf/bpftool/main.h       |  23 ++++
>> >> >>  tools/include/uapi/linux/bpf.h |   4 +
>> >> >>  tools/lib/bpf/libbpf.h         |   4 +
>> >> >>  tools/lib/bpf/skel_internal.h  |  28 ++++-
>> >> >>  13 files changed, 491 insertions(+), 7 deletions(-)
>> >> >>
>> >> >> --
>> >> >> 2.48.1
>> >> >>

