Return-Path: <bpf+bounces-46300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF109E77D4
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C6A167420
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE001FFC64;
	Fri,  6 Dec 2024 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea5oPDXs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326182206A5
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508643; cv=none; b=NlJ9flvMoM4yPt27YZJw982EDRaea9pwHNUztVn/4k4SDdHYZ0hzYon69sNgIOu0lJyLOGRKFy4mrwTDaxSrplnhBGb/4cY4ZhwhlHOLuXjsAPmPLMpe8RmpeG1sQzkvRXmSCAo4vd6W6UAFObRN+tuFMughZ7qqFwKx5xwhzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508643; c=relaxed/simple;
	bh=kd3hdc87rVgATmji+Lp2eTw7AeuAGNSUgRGJP+Gc5dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9QbDsWzu9Lz4E4yW6GdSD/8o4wMwRyWizx4jpMPexI0O3vqqGTBZS/Zav9TcDAg8/zb9ap+XfgAhEL7ZkO+r7Mfdhz1Wkte1uT6UG8xsXmaoJDXSe27HgY4INXuNRLiH1ub2qYZINq3KESY757/S82XpHt/QlNWELJGJdu2Hmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea5oPDXs; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef6af22ea8so996602a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733508641; x=1734113441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGl0wgJOUHMI3X+KPzbqVUTQ/V6KKqJ9cW5u2uWbTcg=;
        b=ea5oPDXsDljpwb2e4PPisAm79zGiCVkYES5QGG7WR9ceNA5DwCRB/UcelicV5s7bPg
         xm03rkuB1Xn6jVR9pa8EfF9Lc9TpMB6nEFmmYlwq52/lwNeuRJ8tfZVZmCxrOidO3I4R
         qybRsVghEMJ6FekiGUQeKN6VjTTxI8KpU7jDVwl3KxXensx40QUToFHYjDC2R0cW6bQ2
         X4Iz8LFl2/YBEbaI5jUimKsw7Za0XU+dDq8bMCWNmZ8xO7AiemjH3sfFrui9IPD5p9fm
         ue5kgBATRVSH8Ej7z+PlnGlQbvr0mCoBVWMYa6DiZbHZIlLo1y9cAtfBD8xkOkHcWxx3
         stJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733508641; x=1734113441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGl0wgJOUHMI3X+KPzbqVUTQ/V6KKqJ9cW5u2uWbTcg=;
        b=TX98w9XsURfxBWuqNLsTdH1Mmu+9IpRpFV+E5J3jD218A7rssA6G1b3rl+EUHT/jNO
         nushc0DD6HCCcN2u3/hrHfNWzECSN/M+amf75DNj7PloyHezGg+Xdo8KY7LFw8dzvhFF
         gqg0SUL8Aat4DzWxYygBMfGSFDrctffG0YKlUIYqeO3Q+y8xwvAYytJHbU2e8nAeQVWj
         MVIjkWicw9fpAw48+WIDAofi6SEKv/LM4LtIPbFKhh+s0lWa5xYMgirTIJkoijKeP4+L
         EvQPLHgpZst3WitKyqPm+QMqAAHd48z27F4TW5uoZIQx9IGkcol15zqfOVcGdMU6ZRuP
         oIEw==
X-Forwarded-Encrypted: i=1; AJvYcCVBWY3Uv5LgHrVDt5LfZ0CoOCu6RkugNYBZbmcV9yCWnBGyc6CjLOiHSp1L7gxB14wi4fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77hGq/wNX9WFASzg9s7HRVKqFGQw5XmMlv1O1fFOwNPusLRad
	8ZkT1MvUYDmoZycD21pb7WpIZ88V58+91ZOKvO6KBvmaxUbgzAHHTimSgkteCdlGl3azmHyNiZC
	S8XlHOdHXbiR8CoG+Af2bPHWbKxs=
X-Gm-Gg: ASbGncuP0cuMOj5duwRlDJqrN1e8qG4kUkIe0gJeHH7c1DQVDHUgwAzBGPkGYxSDnyK
	NSMaBynReUxCWDXzxeEWkVPa1BpSycCWzqviRBYXQAKE0OOg=
X-Google-Smtp-Source: AGHT+IG3gDpvLY/IJJ1hk3ts05DolTpGTZ2b6hio7vVTw8nvw0UOQEMsywAzbaGoB/6APhsYyTui2wtgFN1pGfjfCpw=
X-Received: by 2002:a17:90b:1a86:b0:2ee:c291:7674 with SMTP id
 98e67ed59e1d1-2ef69b3594amr6656487a91.14.1733508641432; Fri, 06 Dec 2024
 10:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
 <1f49e00de4e5a17740e4e04ddb77b60e5ff46526.camel@gmail.com>
 <CAEf4BzZ1239ec_J33jZj3Ji6-6W_PspVeKu05L6S729-_g6GMw@mail.gmail.com>
 <17abfd2c6dfc74fa4c1c2a45bf0c7b793963d5a1.camel@gmail.com>
 <CAEf4BzZJOxnm7z6QaxRr9PsfD_DTV5nSPP9TjiEMQxNMxzLFRA@mail.gmail.com> <fca94f90badf43ee16e2773faf35e136d551ec28.camel@gmail.com>
In-Reply-To: <fca94f90badf43ee16e2773faf35e136d551ec28.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 10:10:29 -0800
Message-ID: <CAEf4BzZCv+6H2bn_nrOFxw-rZcuO+rX+eXxw+qPCJBy7fDrDqA@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	andrii <andrii@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 9:58=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2024-12-06 at 09:46 -0800, Andrii Nakryiko wrote:
> > On Fri, Dec 6, 2024 at 9:29=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Fri, 2024-12-06 at 08:08 -0800, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > The tags would be that generalizable side effect declaration approa=
ch,
> > > > so seems worth it to set a uniform approach.
> > > >
> > > > > Please take a look at the patch, the change for check_cfg() is 32=
 lines.
> > > >
> > > > I did, actually. And I already explained what I don't like about it=
:
> > > > eagerness. check_cfg() is not the right place for this, if we want =
to
> > > > support dead code elimination and BPF CO-RE-based feature gating.
> > > > Which your patches clearly violate, so I don't like them, sorry.
> > > >
> > > > We made this eagerness mistake with global subprogs verification
> > > > previously, and had to switch it to lazy on-demand global subprog
> > > > validation. I think we should preserve this lazy approach going
> > > > forward.
> > >
> > > In this context tags have same detection power as current changes for=
 check_cfg(),
> >
> > You keep ignoring the eagerness issue. I can't decide whether you
> > think *it makes no difference* (I disagree, but whatever), or you *see
> > no difference* (in which case let me know and I can explain with some
> > simple example).
>
> In the context of the packet pointer invalidation I see no difference.
> Tags are as eager as check_cfg() traversal.

Goodness, Eduard...

static __noinline void maybe_trigger_pkt_invalidation(bool do_trigger)
{
    if (do_trigger)
       bpf_whatever_helper_triggers_pkt_invalidation();
    /* presumably do something useful here */
}

__weak /*global*/ int global_no_pkt_invalidation(void)
{
    maybe_trigger_pkt_invalidation(false); /* DO NOT trigger */
    return 0;
}

__weak /*global*/  __subprog_triggers_pkt_invalidation_and_I_mean_it
int global_make_pkt_invalidation_great(void)
{
    maybe_trigger_pkt_invalidation(true); /* DO trigger */
    return 0;
}

What does your check_cfg() say about global_no_pkt_invalidation()? Can
it trigger pkt invalidation or not?

>
> > > it is not possible to remove tag using dead code elimination.
> >
> > That's not the point of the tag to be dynamically adjustable. It's the
> > opposite. It's something that the user declares upfront, and this is
> > being enforced by the verifier (to prevent user errors, for example).
> > If the user wants to have a "dynamic tag", they can have two global
> > subprogs, one with and one without the tag, and pick which one should
> > be called through, e.g., .rodata feature flag variable. I.e., make
> > this decision outside of global subprog itself.
> >
> > > So I really don't see any advantages in the context of this particula=
r issue.
> >
> > See also my reply to Alexei, and keep in mind freplace scenario, as
> > one of the things your approach can't support.
>
> Some freplace related mark will have to be present after program verifica=
tion.
> It might be in a form of a tag, or in a form of an additional bit in
> an auxiliary structure. There would be code to check this with both appro=
aches.
>

tag vs check_cfg() is not about that aspect, in both cases we need to
recod whether subprog can trigger pkt invalidation or not.

It's about whether we derive this (and then where, in check_cfg() or
in proper verification pass), or whether the user declares it and we
enforce that in the verifier.

