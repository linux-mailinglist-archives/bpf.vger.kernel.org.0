Return-Path: <bpf+bounces-59393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84087AC9795
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 00:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993A59E8456
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 22:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21652820D7;
	Fri, 30 May 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rFVJi3e7"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E9B54652;
	Fri, 30 May 2025 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748643336; cv=none; b=a1m5DGYxUsu3npSuHL2qv2HK2WETfOMWc3aBf9U1ddjJXHD8cDQC2l4drfGPK0tXVLIwCx52VzluLN1DNTqAtGVl44aR8Hd6RtIpMVI2Ii2xdcd9H2natpO9t5EZXYF3K5wWjVv+mE+e0UEY1N7ufIkR0V4+wyUFXWSM3cUqxGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748643336; c=relaxed/simple;
	bh=qWW/ut/UdbdiTT7GgW1RVejqNZSvCp2yYbiqlEQzRFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YBhHhJqzDbKUo3T1ul2NIiI4/kQROwy00VkMfyy1vqTyMIQJJ0TaUYnrOXxaDyT++edw61AM06Y7QGsrl/rrVrvf+drAJPBO4DrJ+qeO5rd5hSYgfNHjAjFMJIK76hcrmDs5NQ4VZd26Ml1fvU2U2ZmmIL3RG1cMW5fg6rEIIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rFVJi3e7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7F4FA210C329;
	Fri, 30 May 2025 15:15:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F4FA210C329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748643334;
	bh=PampK0irpdPVY/9WSEWyN/qBokTo5BvSDc7E8lJlAUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rFVJi3e7X3BHT89GFB6whoYHk1zKyyOrJWoH8BoCBKB71oBxhnZfZLXcb3hEOIZ6Y
	 nhPVPPsUkBVEKkakvEEdZ9nKmqyrxiF60CZbSz9cYJDnsXvfmzdK9ZSvl2f6wPskDn
	 Zb48x6ctkiykWaScI2gnfZ3qQlpvkQ2KuY+Rj6xw=
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
In-Reply-To: <CACYkzJ4NR3bvrggV=AyNPhPyyLWPL40vw5eAyXons_9wwKAFfQ@mail.gmail.com>
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
 <87iklhn6ed.fsf@microsoft.com>
 <CACYkzJ75JXUM_C2og+JNtBat5psrEzjsgcV+b74FwrNaDF68nA@mail.gmail.com>
 <CACYkzJ4NR3bvrggV=AyNPhPyyLWPL40vw5eAyXons_9wwKAFfQ@mail.gmail.com>
Date: Fri, 30 May 2025 15:15:30 -0700
Message-ID: <87bjr9n3st.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KP Singh <kpsingh@kernel.org> writes:

> On Fri, May 30, 2025 at 11:32=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
>>
>> On Fri, May 30, 2025 at 11:19=E2=80=AFPM Blaise Boscaccy
>> <bboscaccy@linux.microsoft.com> wrote:
>> >
>> > KP Singh <kpsingh@kernel.org> writes:
>> >
>>
>> [...]
>>
>> > >
>> >
>> > And that isn't at odds with the kernel being able to do it nor is it
>> > with what I posted.
>> >
>> > > If your build environment that signs the BPF program is compromised
>> > > and can inject arbitrary code, then signing does not help.  Can you
>> > > explain what a supply chain attack would look like here?
>> > >
>> >
>> > Most people here can read C code. The number of people that can read
>> > ebpf assembly metaprogramming code is much smaller. Compromising clang
>> > is one thing, compromising libbpf is another. Your proposal increases
>> > the attack surface with no observable benefit. If I was going to leave=
 a
>> > hard-to-find backdoor into ring0, gen.c would be a fun place to explore
>> > doing it. Module and UEFI signature verification code doesn't live
>> > inside of GCC or Clang as set of meta-instructions that get emitted, a=
nd
>> > there are very good reasons for that.
>> >
>> > Further, since the signature verification code is unique for each and
>> > every program it needs to be verified/proved/tested for each and every
>> > program. Additionally, since all these checks are being forced outside
>> > of the kernel proper, with the insistence of keeping the LSM layer in
>> > the dark of the ultimate result, the only way to test that a program
>> > will fail if the map is corrupted is to physically corrupt each and
>> > every program and test that individually. That isn't "elegant" nor "us=
er
>> > friendly" in any way, shape or form.
>> >
>> > >> subsystem.  Additionally, it is impossible to verify the code
>> > >> performing the signature verification, as it is uniquely regenerated
>> > >
>> > > The LSM needs to ensure that it allows trusted LOADER programs i.e.
>> > > with signatures and potentially trusted signed user-space binaries
>> > > with unsigned or delegated signing (this will be needed for Cilium a=
nd
>> > > bpftrace that dynamically generate BPF programs), that's a more
>> > > important aspect of the LSM policy from a BPF perspective.
>> > >
>> >
>> > I would like to be able to sign my programs please and have the kernel
>> > verify it was done correctly. Why are you insisting that I *don't* do
>> > that?  I'm yet to see any technical objection to doing that. Do you ha=
ve
>> > one that you'd like to share at this point?
>>
>> The kernel allows a trusted loader that's signed with your private
>> key, that runs in the kernel context to delegate the verification.
>> This pattern of a trusted / delegated loader is going to be required
>> for many of the BPF use-cases that are out there (Cilium, bpftrace)
>> that dynamically generate eBPF programs.
>>
>> The technical objection is that:
>>
>> * It does not align with most BPF use-cases out there as most
>> use-cases need a trusted loader.
>> * Locks us into a UAPI, whereas a signed LOADER allows us to
>> incrementally build signing for all use-cases without compromising the
>> security properties.
>>
>> BPF's philosophy is that of flexibility and not locking the users into
>> a rigid in-kernel implementation and UAPI.
>>
>> - KP
>>
>> >
>> > > MAP_EXCLUSIVE is missing and is required which prevents maps from
>> > > being accessed by other programs as explained in the proposal.
>> > >
>> > > Please hold off on further iterations, I am working on a series and
>> > > will share these patches based on the design that was proposed.
>> > >
>> >
>> > So the premise here seems to be that people should only be allowed to
>> > sign trusted loaders, and that trusted loaders must additionally be
>> > authored by you, correct?
>> >
>> > When can we expect to see your patchset posted?
>
> I will try to get this out by the end of next week.

Wonderful, we look forward to seeing your patchset.

-blaise

>
> - KP
>
>> >

