Return-Path: <bpf+bounces-59397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AD3AC981E
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 01:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38F7A22A56
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFBB28C877;
	Fri, 30 May 2025 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G4TlvHte"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C404C92;
	Fri, 30 May 2025 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748647553; cv=none; b=Kch3eXTmdDtYO+lyu1FLTOGtICwC2kuv28OUG/d8s1O75KJdzN2rYTEWtcJujzPVREBS3Jpr1syLceRyPuI9EhxgkZOjZheWf/jOHUsC21QhibGYAwv2AfprAV9wBYEiZ+Pq9zzL12NWlWdTOsx9mHAsQlLeWg5dsZWwjrvh/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748647553; c=relaxed/simple;
	bh=e9/KL7iIIMMdPoJAORdRSxTpi9+VDp7lpr7bAzBJsSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L9i+oY+dQ5I+SH2M/nvOjAvVIDr/rAIkiN8G9E1j+CtYw5E2exyR1D/ZhVQ+qmmN9HNsdVgN1w86oJf/48XkdGXrG9NVKPy+uCS1IW85IwZ/5VjfaD4DyAipWA1T46PniKne4IhGGi+Xyx9KEZpadCAiLUlfAfnnjn0id4cLJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G4TlvHte; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9D2972078628;
	Fri, 30 May 2025 16:25:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D2972078628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748647551;
	bh=WzqNfe1GnGpsQ8RVdY7fw48SR7/dc9+exo+gpHYbDfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=G4TlvHteqGm9jqKaBCEIC/PidVB+9Ntv4dIRFYWHgDy7OcWeDxyKCRkTDr9Exfsu6
	 hVnkTjhdfq5YmUtU5TQApXPW+DD+vXUYpBF9ejuCyPOVrf3wMFP6GLlf55Rysclxnc
	 vUH+30uoDWuabKUc8CM6TgU4onHk5/nV/TLUUDN4=
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
In-Reply-To: <CACYkzJ6ChW6GeG8CJiUR6w-Nu3U2OYednXgCYJmp6N5FysLc2w@mail.gmail.com>
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
 <87iklhn6ed.fsf@microsoft.com>
 <CACYkzJ75JXUM_C2og+JNtBat5psrEzjsgcV+b74FwrNaDF68nA@mail.gmail.com>
 <87ecw5n3tz.fsf@microsoft.com>
 <CACYkzJ4ondubPHDF8HL-sseVQo7AtJ2uo=twqhqLWaE3zJ=jEA@mail.gmail.com>
 <878qmdn39e.fsf@microsoft.com>
 <CACYkzJ6ChW6GeG8CJiUR6w-Nu3U2OYednXgCYJmp6N5FysLc2w@mail.gmail.com>
Date: Fri, 30 May 2025 16:25:47 -0700
Message-ID: <875xhhn0jo.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KP Singh <kpsingh@kernel.org> writes:

> On Sat, May 31, 2025 at 12:27=E2=80=AFAM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> KP Singh <kpsingh@kernel.org> writes:
>>
>> > On Sat, May 31, 2025 at 12:14=E2=80=AFAM Blaise Boscaccy
>> > <bboscaccy@linux.microsoft.com> wrote:
>> >>
>> >> KP Singh <kpsingh@kernel.org> writes:
>> >>
>> >> > On Fri, May 30, 2025 at 11:19=E2=80=AFPM Blaise Boscaccy
>> >> > <bboscaccy@linux.microsoft.com> wrote:
>> >> >>
>> >> >> KP Singh <kpsingh@kernel.org> writes:
>> >> >>
>> >> >
>> >> > [...]
>> >> >
>> >> >> >
>> >> >>
>> >> >> And that isn't at odds with the kernel being able to do it nor is =
it
>> >> >> with what I posted.
>> >> >>
>> >> >> > If your build environment that signs the BPF program is compromi=
sed
>> >> >> > and can inject arbitrary code, then signing does not help.  Can =
you
>> >> >> > explain what a supply chain attack would look like here?
>> >> >> >
>> >> >>
>> >> >> Most people here can read C code. The number of people that can re=
ad
>> >> >> ebpf assembly metaprogramming code is much smaller. Compromising c=
lang
>> >> >> is one thing, compromising libbpf is another. Your proposal increa=
ses
>> >> >> the attack surface with no observable benefit. If I was going to l=
eave a
>> >> >> hard-to-find backdoor into ring0, gen.c would be a fun place to ex=
plore
>> >> >> doing it. Module and UEFI signature verification code doesn't live
>> >> >> inside of GCC or Clang as set of meta-instructions that get emitte=
d, and
>> >> >> there are very good reasons for that.
>> >> >>
>> >> >> Further, since the signature verification code is unique for each =
and
>> >> >> every program it needs to be verified/proved/tested for each and e=
very
>> >> >> program. Additionally, since all these checks are being forced out=
side
>> >> >> of the kernel proper, with the insistence of keeping the LSM layer=
 in
>> >> >> the dark of the ultimate result, the only way to test that a progr=
am
>> >> >> will fail if the map is corrupted is to physically corrupt each and
>> >> >> every program and test that individually. That isn't "elegant" nor=
 "user
>> >> >> friendly" in any way, shape or form.
>> >> >>
>> >> >> >> subsystem.  Additionally, it is impossible to verify the code
>> >> >> >> performing the signature verification, as it is uniquely regene=
rated
>> >> >> >
>> >> >> > The LSM needs to ensure that it allows trusted LOADER programs i=
.e.
>> >> >> > with signatures and potentially trusted signed user-space binari=
es
>> >> >> > with unsigned or delegated signing (this will be needed for Cili=
um and
>> >> >> > bpftrace that dynamically generate BPF programs), that's a more
>> >> >> > important aspect of the LSM policy from a BPF perspective.
>> >> >> >
>> >> >>
>> >> >> I would like to be able to sign my programs please and have the ke=
rnel
>> >> >> verify it was done correctly. Why are you insisting that I *don't*=
 do
>> >> >> that?  I'm yet to see any technical objection to doing that. Do yo=
u have
>> >> >> one that you'd like to share at this point?
>> >> >
>> >> > The kernel allows a trusted loader that's signed with your private
>> >> > key, that runs in the kernel context to delegate the verification.
>> >> > This pattern of a trusted / delegated loader is going to be required
>> >> > for many of the BPF use-cases that are out there (Cilium, bpftrace)
>> >> > that dynamically generate eBPF programs.
>> >> >
>> >> > The technical objection is that:
>> >> >
>> >> > * It does not align with most BPF use-cases out there as most
>> >> > use-cases need a trusted loader.
>> >>
>> >> No, it's definitely a use case. It's trivial to support both a trusted
>> >> loader and a signature over the hash chain of supplied assets.
>> >>
>> >> > * Locks us into a UAPI, whereas a signed LOADER allows us to
>> >> > incrementally build signing for all use-cases without compromising =
the
>> >> > security properties.
>> >> >
>> >>
>> >> Your proposal locks us into a UAPI as well. There is no way to make to
>> >> do this via UAPI without making a UAPI design choice.
>> >>
>> >> > BPF's philosophy is that of flexibility and not locking the users i=
nto
>> >> > a rigid in-kernel implementation and UAPI.
>> >> >
>> >>
>> >> Then why are you locking us into a rigid
>> >> only-signing-the-loader-is-allowed implementation?
>> >
>> > I explained this before, the delegated / trusted loader is needed by
>> > many BPF use-cases. A UAPI is forever, thus the lock-in.
>> >
>>
>> Again, I'm not following. What is technically wrong with supporting both
>> signing a loader only and allowing for the signature of multiple
>> passed-in assets? It's trivial to support both and any path forward will
>> force a UAPI lock-in.
>>
>> Do you simply feel that it isn't a valid use case and therefore we
>> shouldn't be allowed to do it?
>>
>
> I am saying both are not needed when one (trusted loader) handles all
> cases. You are writing / generating the loader anyways, you have the
> private key, the only thing to be done is add a few lines to the
> loader to verify an embedded hash.
>

And I'm saying that they are, based on wanting visibility in the LSM
layer, passing that along to the end user, and wanting to be able to
show correctness, along with mitigating an entire vector of supply chain
attacks targeting gen.c.

So in summary, your objection to this is that you feel it's simply "not
needed", and those above risks/design problems aren't actually an issue?

> Let's have this discussion in the patch series, much easier to discuss
> with the code.

I think we've all been waiting for that. Yes, lets.

