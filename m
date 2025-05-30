Return-Path: <bpf+bounces-59396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C7AAC97D6
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 00:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E6F17F427
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 22:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B823228AAFC;
	Fri, 30 May 2025 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1FWsg4t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6727A454
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748645244; cv=none; b=j2r1a/ph2u+/w9oFtIDaDMPdE1jkqCCT7C5gmWchALRQpO/tvyYMcAR741Xk2NAc/cESQkr1tco9fw+E1Rnpe/gaE7jn2R/whRAM4pnvR0HUI03lrBYzjIjXBBAx2GaAIFlVygJ7i9+jreSIQdFPGH2HCgNQB2XiY1BNYHINyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748645244; c=relaxed/simple;
	bh=HHG2788MAfzLv6FpNbSS2PT5GiBzIy9/XDiczvd4Vls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3PrQoY+ApDvkhDPCpkHv9aIayaClF/7eUjl79U3WTUKbEaFGnBAiLy6m3ns8bQJYDMef+f9qQ6dtwud0NNsFFojY1OlYc5OSiRoEuPTjeBgEB8Is6f07mwzwT+YnHAbB8ALr46aQSnL3KOwxbewTF6Mjp7ptxypebIRxSTFqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1FWsg4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B894DC2BCB0
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748645243;
	bh=HHG2788MAfzLv6FpNbSS2PT5GiBzIy9/XDiczvd4Vls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l1FWsg4tKRnT/+vxnW+s7WAje5WmMWUZwWWJwgmrze6OL8JCQRd2AsEPi0qy/q2RC
	 ieMtxazaCgd4f/seXGhloWLSUi32DKh51gLbujFVpLiJvM7oq6upiGJ/KbjEisTHDV
	 aECAHKirIPKQsJS9/FCXcZup+dlv+HZfaw4bcLnrRUO3s3etaFvwaLB+kjgQVbHjRb
	 +2Xd1vQFTbNTGUO3RsGNPnvKCR4ONlY89hqqi6zfKGesSGGNg3Mk9vWC9cA1uiHUCS
	 ERtmBtxatMMKGmI1uSuOSkByb3uO5OxQA1ApDrEEYesHc6w1iQtVqh/SBDAbh3PLA2
	 0ykWFNEWnpAwQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604630fcd3aso3373740a12.1
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 15:47:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUnuLy7Ur3Kmq3r3Gi2UrAEnhBJ2V/prX3oT98iB1oT4iNn8a3FixeDXFYI+9gtudjtJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2npbWsxy65GIq1uU7gvl+dxKYInGZpJCFD0VSK/IH6LY4Dpr
	O70plXNey6VU7BDZMPvySD/7aJgoBNw9jgEBifprRwurzXsqaqgVxTGbOpMLruNDA7vcQMi6IBN
	y7jwg34pIGFGKQM8IEIHIr1DRHjS41iwDjvK09zw4
X-Google-Smtp-Source: AGHT+IFYxnUR608wUuerbDE05DFFV1ug2zC4oLVRvqWuBJ5505E/XEYgfXCYPZcgaF6AS2m1jiZPgriYTwhKBizbrzM=
X-Received: by 2002:a05:6402:268c:b0:5fa:f7ed:f19c with SMTP id
 4fb4d7f45d1cf-6057c1a98f4mr3487149a12.4.1748645241501; Fri, 30 May 2025
 15:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
 <87iklhn6ed.fsf@microsoft.com> <CACYkzJ75JXUM_C2og+JNtBat5psrEzjsgcV+b74FwrNaDF68nA@mail.gmail.com>
 <87ecw5n3tz.fsf@microsoft.com> <CACYkzJ4ondubPHDF8HL-sseVQo7AtJ2uo=twqhqLWaE3zJ=jEA@mail.gmail.com>
 <878qmdn39e.fsf@microsoft.com>
In-Reply-To: <878qmdn39e.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 31 May 2025 00:47:10 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6ChW6GeG8CJiUR6w-Nu3U2OYednXgCYJmp6N5FysLc2w@mail.gmail.com>
X-Gm-Features: AX0GCFvje4fvKUf4y96Q3VqXMLTB0Y_ktvXyo16G-5-1AcLf8dXPpXsGOmvMgcg
Message-ID: <CACYkzJ6ChW6GeG8CJiUR6w-Nu3U2OYednXgCYJmp6N5FysLc2w@mail.gmail.com>
Subject: Re: [PATCH 0/3] BPF signature verification
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, jarkko@kernel.org, zeffron@riotgames.com, 
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com, code@tyhicks.com, 
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com, 
	James.Bottomley@hansenpartnership.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Ignat Korchagin <ignat@cloudflare.com>, Quentin Monnet <qmo@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Anton Protopopov <aspsk@isovalent.com>, Jordan Rome <linux@jordanrome.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Matteo Croce <teknoraver@meta.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 12:27=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> > On Sat, May 31, 2025 at 12:14=E2=80=AFAM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> KP Singh <kpsingh@kernel.org> writes:
> >>
> >> > On Fri, May 30, 2025 at 11:19=E2=80=AFPM Blaise Boscaccy
> >> > <bboscaccy@linux.microsoft.com> wrote:
> >> >>
> >> >> KP Singh <kpsingh@kernel.org> writes:
> >> >>
> >> >
> >> > [...]
> >> >
> >> >> >
> >> >>
> >> >> And that isn't at odds with the kernel being able to do it nor is i=
t
> >> >> with what I posted.
> >> >>
> >> >> > If your build environment that signs the BPF program is compromis=
ed
> >> >> > and can inject arbitrary code, then signing does not help.  Can y=
ou
> >> >> > explain what a supply chain attack would look like here?
> >> >> >
> >> >>
> >> >> Most people here can read C code. The number of people that can rea=
d
> >> >> ebpf assembly metaprogramming code is much smaller. Compromising cl=
ang
> >> >> is one thing, compromising libbpf is another. Your proposal increas=
es
> >> >> the attack surface with no observable benefit. If I was going to le=
ave a
> >> >> hard-to-find backdoor into ring0, gen.c would be a fun place to exp=
lore
> >> >> doing it. Module and UEFI signature verification code doesn't live
> >> >> inside of GCC or Clang as set of meta-instructions that get emitted=
, and
> >> >> there are very good reasons for that.
> >> >>
> >> >> Further, since the signature verification code is unique for each a=
nd
> >> >> every program it needs to be verified/proved/tested for each and ev=
ery
> >> >> program. Additionally, since all these checks are being forced outs=
ide
> >> >> of the kernel proper, with the insistence of keeping the LSM layer =
in
> >> >> the dark of the ultimate result, the only way to test that a progra=
m
> >> >> will fail if the map is corrupted is to physically corrupt each and
> >> >> every program and test that individually. That isn't "elegant" nor =
"user
> >> >> friendly" in any way, shape or form.
> >> >>
> >> >> >> subsystem.  Additionally, it is impossible to verify the code
> >> >> >> performing the signature verification, as it is uniquely regener=
ated
> >> >> >
> >> >> > The LSM needs to ensure that it allows trusted LOADER programs i.=
e.
> >> >> > with signatures and potentially trusted signed user-space binarie=
s
> >> >> > with unsigned or delegated signing (this will be needed for Ciliu=
m and
> >> >> > bpftrace that dynamically generate BPF programs), that's a more
> >> >> > important aspect of the LSM policy from a BPF perspective.
> >> >> >
> >> >>
> >> >> I would like to be able to sign my programs please and have the ker=
nel
> >> >> verify it was done correctly. Why are you insisting that I *don't* =
do
> >> >> that?  I'm yet to see any technical objection to doing that. Do you=
 have
> >> >> one that you'd like to share at this point?
> >> >
> >> > The kernel allows a trusted loader that's signed with your private
> >> > key, that runs in the kernel context to delegate the verification.
> >> > This pattern of a trusted / delegated loader is going to be required
> >> > for many of the BPF use-cases that are out there (Cilium, bpftrace)
> >> > that dynamically generate eBPF programs.
> >> >
> >> > The technical objection is that:
> >> >
> >> > * It does not align with most BPF use-cases out there as most
> >> > use-cases need a trusted loader.
> >>
> >> No, it's definitely a use case. It's trivial to support both a trusted
> >> loader and a signature over the hash chain of supplied assets.
> >>
> >> > * Locks us into a UAPI, whereas a signed LOADER allows us to
> >> > incrementally build signing for all use-cases without compromising t=
he
> >> > security properties.
> >> >
> >>
> >> Your proposal locks us into a UAPI as well. There is no way to make to
> >> do this via UAPI without making a UAPI design choice.
> >>
> >> > BPF's philosophy is that of flexibility and not locking the users in=
to
> >> > a rigid in-kernel implementation and UAPI.
> >> >
> >>
> >> Then why are you locking us into a rigid
> >> only-signing-the-loader-is-allowed implementation?
> >
> > I explained this before, the delegated / trusted loader is needed by
> > many BPF use-cases. A UAPI is forever, thus the lock-in.
> >
>
> Again, I'm not following. What is technically wrong with supporting both
> signing a loader only and allowing for the signature of multiple
> passed-in assets? It's trivial to support both and any path forward will
> force a UAPI lock-in.
>
> Do you simply feel that it isn't a valid use case and therefore we
> shouldn't be allowed to do it?
>

I am saying both are not needed when one (trusted loader) handles all
cases. You are writing / generating the loader anyways, you have the
private key, the only thing to be done is add a few lines to the
loader to verify an embedded hash.

Let's have this discussion in the patch series, much easier to discuss
with the code.

