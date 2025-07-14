Return-Path: <bpf+bounces-63247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98065B048CD
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 22:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2851A65B2F
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C556238C2A;
	Mon, 14 Jul 2025 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWBQ3uQt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22691341AA
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526018; cv=none; b=BT6mHLF/3GATO9ngqQ5IKtjpqUTjEggFaOfLhw4YhpL6CKIfywJdxa77v0+5otrA5yL1mlzJtGGqV2qLqMcgDvXa5kkg84F/ct4YVPUjILFChDBF4ciAMMgAIc/gSMf//nHWGWWl02jKxmF1ls/UbjkSrZugsqye6sUcWYgpy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526018; c=relaxed/simple;
	bh=W2rQstUrICSDnWxjPFCFbI19N4qAECcX/JEzYb+Ni84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoT4IpGu7VN8fdCdfDt+atSKPPP/VHyEk9T6yxPW3vGtfBspG5MByR1lIrqOPC9bCP8IkaWZDcFUZDky2xDmPRvu3p9Rlttp35wMFLWJwZeEuHNUhvOKXXUZy5N7/9SId8gji0xbS4IjccsA6NmmBSAX1HnH41+MG5qpvOJOp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWBQ3uQt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3135f3511bcso4008679a91.0
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752526016; x=1753130816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEC2S1tg5ToMSLoJuWnhgw6IyieSs5HzboJbcBJo09g=;
        b=HWBQ3uQtMhD9QaTRr/PcI/VzSiX7n2pBCrVLDpDketowDf2Ma7QoMCIEGDKDO3RPPm
         m2aAdivBkMNLuhgqWZliHTdu6mzBuFKVJ/cLH9oHN0x6clCOwkMLA7hNsyFKsdB4ESJP
         bYm1aNIdMdUamEJrLeuR7qBNbUbwiEyiqt+lwS9geNWBLoAkgbYiWQasKpTCBIqmU9OW
         6JaAn8nuOJulwNCCuEjgzcBi8moB5QCb+56uWuwTP2ShgEKulSvH7pl/BbFNaK+G7hCW
         Gjpzf8RVei3MBZIGlJr7A40zDtkm4NtfiWoxOC5W95+h54I9v5IHERuvQ6xkfAIo0GxF
         PJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752526016; x=1753130816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEC2S1tg5ToMSLoJuWnhgw6IyieSs5HzboJbcBJo09g=;
        b=mgfV07qerygUa3hoWB1aJ27J3zvtkXt/A6/NJ3OdPvPLIkfgWZnm1QREcohq7U8FOf
         KrZx4lnWrEfki5iJK35bTNZf0PZPVwkVV9e7fXJPiusoyCGkx/6F+C6vuo8hRLbwf8PF
         HW6p6KruPDy4uI5lzzvWt2yhq4slGEV9IenUOc36eQHUHztxNmMm1pa+Z3uYyE1ymUUK
         pi3J7t9IWuCUZAgMOsMQuUynHxeA67jMJbr96792jaHW0G57/PCUJqazQuujh2JPatVN
         9ntyEMRm8FcNy0tjsoFW765kI521qTZ1BEzyeKzlLKex0bc0fvohzON8Zp2psYlXrbpA
         Ofgw==
X-Forwarded-Encrypted: i=1; AJvYcCU+DwCcpKJSHhOcGBGhOaJLQxSddU4i2pl2xr+2vjMtilRcnvllc4l6dMUEWIMfED4NRp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoA6LxHr0jv9pUucc7vq7wB2ac4Jow7Pqsm0WhBkqq/qTbwmC9
	k1f8IY988QIBjABMFNnoTydga7cle+zDKKiEurtwkKJkpRoC0rreSWCh/uYR1QSKtyOgEohao12
	VhrC3L2kAsPl5+Mo+qaLpwa2nqeZRxrg=
X-Gm-Gg: ASbGncsdp6S+sm4WGW4zDgGqRtysClzXhijsMREVxoEgNu1cCVyaUh3G4edtH0G0xbw
	IQ42oVH6ThayedmM19FyHGja/mi6L9CJ8hyerBpqXce1vjtIXzAo1blJkH6PoxUo7CXd6r+wvcu
	2ZLKSsvXz2UYL6YSAWOeLJViGLkP1jZEg7cv90052WAx7+imR9AZi1HJs6U5EIRPDn69tDr2MOk
	pwlmGqc/NRSdH/ID7xHXBE=
X-Google-Smtp-Source: AGHT+IH3lbJeoCnfO6Xl8n4A7z2VyELvw66VVsu4BT6NyCIYT2PbHDBP8LCSFjqUQkGe6hTDen4x12+vc64EuOts4PQ=
X-Received: by 2002:a17:90b:33c8:b0:311:baa0:89ce with SMTP id
 98e67ed59e1d1-31c4ca84837mr23502487a91.12.1752526016062; Mon, 14 Jul 2025
 13:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708230825.4159486-1-ameryhung@gmail.com> <20250708230825.4159486-3-ameryhung@gmail.com>
 <68f4b77c-3265-489e-9190-0333ed54b697@linux.dev> <CAMB2axO3Ma7jYa00fbSzB8ZFZyekS13BNJ87rsTfbfcSZhpc6w@mail.gmail.com>
 <2d1b45f3-3bde-415d-8568-eb4c2a7dd219@linux.dev> <CAMB2axMDUr+s+f9K-4sj-5vSkPQV4RXHo8y73VH9V2JQbKZOxQ@mail.gmail.com>
 <CAEf4BzaUK0i7QFkKi800TQhAKw2WL+FyoG3eFP6nq_r-TUPBKw@mail.gmail.com>
 <CAMB2axONnVJ5BY-YOASWGUGpaZa-P64Yf5f6AbX+O8fjCiZNfw@mail.gmail.com>
 <CAADnVQJxu5hsDw0iCP68eRW3v2CXRBos8asfN1x9F=gVyGmqbw@mail.gmail.com> <CAMB2axMw0uEojfdq33KbjqZXAtRSJwR2=f1Y1S4ma01sWJFNfg@mail.gmail.com>
In-Reply-To: <CAMB2axMw0uEojfdq33KbjqZXAtRSJwR2=f1Y1S4ma01sWJFNfg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Jul 2025 13:46:40 -0700
X-Gm-Features: Ac12FXxHy1-E06iUw-Rrc65-gccdUTJgwMvtn__GdFZKdbGlViZSYuUstpBEiSE
Message-ID: <CAEf4BzaoUCapHxdVJj6vyx=Ai_tCO+HY3kaD2ZNK2v0R0zuTMw@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based
 struct_ops attachment
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 2:38=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Fri, Jul 11, 2025 at 1:21=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jul 11, 2025 at 12:29=E2=80=AFPM Amery Hung <ameryhung@gmail.co=
m> wrote:
> > >
> > > On Fri, Jul 11, 2025 at 11:41=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Jul 10, 2025 at 2:00=E2=80=AFPM Amery Hung <ameryhung@gmail=
.com> wrote:
> > > > >
> > > > > On Thu, Jul 10, 2025 at 12:47=E2=80=AFPM Martin KaFai Lau <martin=
.lau@linux.dev> wrote:
> > > > > >
> > > > > > On 7/10/25 11:39 AM, Amery Hung wrote:
> > > > > > >> On 7/8/25 4:08 PM, Amery Hung wrote:
> > > > > > >>> @@ -906,6 +904,10 @@ static long bpf_struct_ops_map_update_=
elem(struct bpf_map *map, void *key,
> > > > > > >>>                goto unlock;
> > > > > > >>>        }
> > > > > > >>>
> > > > > > >>> +     err =3D bpf_struct_ops_prepare_attach(st_map, 0);
> > > > > > >> A follow-up on the "using the map->id as the cookie" comment=
 in the cover
> > > > > > >> letter. I meant to use the map->id here instead of 0. If the=
 cookie is intended
> > > > > > >> to identify a particular struct_ops instance (i.e., the stru=
ct_ops map), then
> > > > > > >> map->id should be a good fit, and it is automatically genera=
ted by the kernel
> > > > > > >> during the map creation. As a result, I suspect that most of=
 the changes in
> > > > > > >> patch 1 and patch 2 will not be needed.
> > > > > > >>
> > > > > > > Do you mean keep using cookie as the mechanism to associate p=
rograms,
> > > > > > > but for struct_ops the cookie will be map->id (i.e.,
> > > > > > > bpf_get_attah_cookie() in struct_ops will return map->id)?
> > > > > >
> > > > > > I meant to use the map->id as the bpf_cookie stored in the bpf_=
tramp_run_ctx.
> > > > > > Then there is no need for user space to generate a unique cooki=
e during
> > > > > > link_create. The kernel has already generated a unique ID in th=
e map->id. The
> > > > > > map->id is available during the bpf_struct_ops_map_update_elem(=
). Then there is
> > > > > > also no need to distinguish between SEC(".struct_ops") vs
> > > > > > SEC(".struct_ops.link"). Most of the patch 1 and patch 2 will n=
ot be needed.
> > > > > >
> > > > > > A minor detail: note that the same struct ops program can be us=
ed in different
> > > > > > trampolines. Thus, to be specific, the bpf cookie is stored in =
the trampoline.
> > > > > >
> > > > > > If the question is about bpf global variable vs bpf cookie, yea=
h, I think using
> > > > > > a bpf global variable should also work. The global variable can=
 be initialized
> > > > > > before libbpf's bpf_map__attach_struct_ops(). At that time, the=
 map->id should
> > > > > > be known already. I don't have a strong opinion on reusing the =
bpf cookie in the
> > > > > > struct ops trampoline. No one is using it now, so it is availab=
le to be used.
> > > > > > Exposing BPF_FUNC_get_attach_cookie for struct ops programs is =
pretty cheap
> > > > > > also. Using bpf cookie to allow the struct ops program to tell =
which struct_ops
> > > > > > map is calling it seems to fit well also after sleeping on it a=
 bit. bpf global
> > > > > > variable will also break if a bpf_prog.o has more than one SEC(=
".struct_ops").
> > > > > >
> > > > >
> > > > > While both of them work, using cookie instead of global variable =
is
> > > > > one less thing for the user to take care of (i.e., slightly bette=
r
> > > > > usability).
> > > > >
> > > > > With the approach you suggested, to not mix the existing semantic=
s of
> > > > > bpf cookie, I think a new struct_ops kfuncs is needed to retrieve=
 the
> > > >
> > > > yes, if absolutely necessary, sure, let's reuse the spot that is
> > > > reserved for cookie inside the trampoline, but let's not expose thi=
s
> > > > as real BPF cookie (i.e., let's not allow bpf_get_attach_cookie()
> > > > helper for struct_ops), because BPF cookie is meant to be fully use=
r
> > > > controllable and used for whatever they deem necessary. Not
> > > > necessarily to just identify the struct_ops map. So it will be a hu=
ge
> > > > violation to just pre-define what BPF cookie value is for struct_op=
s.
> > > >
> > >
> > > We had some offline discussions and figured out this will not work we=
ll.
> > >
> > > sched_ext users already call scx kfuncs in global subprograms. If we
> > > choose to add bpf_get_struct_ops_id() to get the id to be passed to
> > > scx kfuncs, it will force the user to create two sets of the same
> > > global subprog. The one called by struct_ops that calls
> > > bpf_get_struct_ops_id() and tracing programs that calls
> > > bpf_get_attach_cookie().
> >
> > Can we put cookie into map_extra during st_ops map creation time and
> > later copy it into actual cookie place in a trampoline?
>
> It should work. Currently, it makes sense to have cookie in struct_ops
> map as all struct_ops implementers (hid, tcp cc, qdisc, sched_ext) do
> not allow multi-attachment of the same map. A struct_ops map is
> effectively an unique attachment for now.

Is there any conceptual reason why struct_ops map shouldn't be allowed
to be attached to multiple places? If not, should we try to lift this
restriction and not invent struct_ops-specific BPF cookie APIs?

From libbpf POV, struct_ops map is created implicitly from the
struct_ops variable. There is no map_flags field there. We'll need to
add new special APIs and/or conventions just to be able to set
map_flags.

>
> Additionally, we will be able to support cookie for non-link
> struct_ops with this way.
>
> This approach will not block future effort to support link-specific
> cookie if there is such a use case. We can revisit this patchset then.

It will create two ways to specify BPF cookie for struct_ops: (legacy
and special way) through map_flags and common one through the
LINK_CREATE command (and I guess we'd need to reject LINK_CREATE if
cookie was already set through map_flags, right?). Why confuse users
like that?

From what I understand, the problem is that currently struct_ops map's
BPF trampoline(s) are created a bit too early, before the attachment
step. How hard would it be to move trampoline creation to an actual
attachment time? Should we seriously consider this before we invent
new struct_ops-specific exceptions for BPF cookie?

