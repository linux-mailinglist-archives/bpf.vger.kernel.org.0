Return-Path: <bpf+bounces-63249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39309B048ED
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7890E4A19C5
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6181C23643E;
	Mon, 14 Jul 2025 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWBq2EN9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5DE5B21A
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526952; cv=none; b=YGowzqYtDU72VQk2K/liSNW0gCfIRAdD6C5tc93NiW7VMHBBJagc5SAWfvfHPFloQdhKUhdy+MYksqzA1zSPcZT9qEDc80WKyf9Hpjdk3qw3cSaGh2/kKvvecd/ZijR2xXQTQabtmvFSwkQoT5VyKKw/Z2oQd5iteuDEVUrWFQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526952; c=relaxed/simple;
	bh=bkDdbTNgW8hjA/1GG2l1MWwcviqf5fOJ/w4lRvkNdHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZhfIlyVeDvOjIGS1YSCzQ+y1Yx+iulp0eXluDrDY3ASVczS/w+z+VBjHpFSOZj5USR932YAKeNz/gvhGHuf0aa2VQ8pEpzR1c52YuIV5qQXA97KC9+i19/ePaX3u9RdtxuzwdgMAeWAN/yWBhWhO4YrbM0LmBhZR5uwVdLRngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWBq2EN9; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7170344c100so40555467b3.0
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 14:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752526950; x=1753131750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAAy7XnA5S6UCgECt8P2goo0hboFWcStzD/8p5tAKbM=;
        b=dWBq2EN9JWfPoFp4VPRoVD7lkUNjYAeqRXkQ4+HXD8jDw5iKzx96uSoLlxmWGUHCxP
         26raCV/u3N6+YUh315PMKAhjhcs1fH93oZVTewHC5NepEnCvZmFeQ/SYxbMq6Tv6RKW0
         DAj5D7ZECuTEGX4/SvqfUKDdCkt/iGPml1mBqnr/dLcnZmTNxkBbHlsMPb3OW6eQF6kp
         +hL2Tnky4ZaSgWX5+QxANdvrl+xlWZQbRFAbMV9w87bMU3D3o1OpW3cVNtGx2jSUN77N
         U6I/NsR8HbWzD3M43Gvhx0wZwa6haCeB1VCpb+zJT2XyzcgD9VEFbD/O6eBIAA+GrfAQ
         kLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752526950; x=1753131750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAAy7XnA5S6UCgECt8P2goo0hboFWcStzD/8p5tAKbM=;
        b=qZ0q3Fe1jpGamvwwCAA8PsWXuPrkR9f9ZtLPyDzUKUdQTSgjpNuk4c5i75EK+JYNrm
         TFQQljErGdN2US3Qu9exSMY/CTuxEC9k8lsYcLXos5MgUjWE+0FtfSygVA+VVgq9iUV/
         myx2O3MdX6Y1vDvltXo2OCxre2As5o1xvOJaHuhBNNPKXm3HUSzIxC55QH4S0lmQba11
         RbmSXx8iIQYeY61qkX+k1MSc0pUD2oKT1UZMNoYBDVJTPtCvbqThF1Pq3xZlG8BawEXc
         ygVetsA7YeLfx4DVO5civjZvZ6u5ylfQeCCzYba4t2QMbl406dF6yLSj8kxYUmH5OmTu
         ZOvg==
X-Forwarded-Encrypted: i=1; AJvYcCXAw7LWbcs/Uxwl7pDSbkjpcyZA8rZsEm9FaczeaSBs3CCytWt+2qOnV5hQO6JcXgLNsHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr2+5aiLqlYALcrmfYHZ0X3e19OOYaRZpVkKr5T6BM4haeD4jy
	6eYAcs/nDLs36jfonSjVz4iaN/87AhZDDgUWCyKhcHPVCt8bDURxTu66X9Py0VypDMu+kjysvgJ
	LEq6q+3QKBs2zWSl2prHgWbUVVBWZYcE=
X-Gm-Gg: ASbGncsxM/6DhaFs8OgyHAgImEVCbT1sPh9htK60BHH+Nl6JwendE/i6okYQVwR4HnH
	VvNfNUPV840xnRNAeew1Ip+ZP8SXp+ds8vPJzxgkraaWH/XZn3YS/NB/jl7sJ4y0TiW4gB1UQmQ
	1ooA4gLB6yCNdU0+KLTU2u9BlTt7bxZAdwh/cbW69X/FZvAC5RYQHjBNyFsWzPQi8E+ooTcoOuC
	FQTEj8=
X-Google-Smtp-Source: AGHT+IEoTZcszw6yw4eBNoY6gXVfTBfvp1Thapmx/iYT18RM0VKUrusiK73axE8Wjbl6OoDqA1CbyueLF1mTdgdjERI=
X-Received: by 2002:a05:690c:640e:b0:713:ff70:8588 with SMTP id
 00721157ae682-717d7a8e9c9mr220309057b3.36.1752526949904; Mon, 14 Jul 2025
 14:02:29 -0700 (PDT)
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
 <CAADnVQJxu5hsDw0iCP68eRW3v2CXRBos8asfN1x9F=gVyGmqbw@mail.gmail.com>
 <CAMB2axMw0uEojfdq33KbjqZXAtRSJwR2=f1Y1S4ma01sWJFNfg@mail.gmail.com> <CAEf4BzaoUCapHxdVJj6vyx=Ai_tCO+HY3kaD2ZNK2v0R0zuTMw@mail.gmail.com>
In-Reply-To: <CAEf4BzaoUCapHxdVJj6vyx=Ai_tCO+HY3kaD2ZNK2v0R0zuTMw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 14 Jul 2025 14:02:19 -0700
X-Gm-Features: Ac12FXxAQ5edGyIzngMVNzpe7ZyTHXEyo6q6ArcUf766AkAyOb6hw3eIfzzG4Rk
Message-ID: <CAMB2axNXLm2mWnSv4EL_YxexYa97_OnRD9Nj7ww9Qq_3dAp5hg@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based
 struct_ops attachment
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 1:46=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jul 11, 2025 at 2:38=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Fri, Jul 11, 2025 at 1:21=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jul 11, 2025 at 12:29=E2=80=AFPM Amery Hung <ameryhung@gmail.=
com> wrote:
> > > >
> > > > On Fri, Jul 11, 2025 at 11:41=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jul 10, 2025 at 2:00=E2=80=AFPM Amery Hung <ameryhung@gma=
il.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 10, 2025 at 12:47=E2=80=AFPM Martin KaFai Lau <mart=
in.lau@linux.dev> wrote:
> > > > > > >
> > > > > > > On 7/10/25 11:39 AM, Amery Hung wrote:
> > > > > > > >> On 7/8/25 4:08 PM, Amery Hung wrote:
> > > > > > > >>> @@ -906,6 +904,10 @@ static long bpf_struct_ops_map_updat=
e_elem(struct bpf_map *map, void *key,
> > > > > > > >>>                goto unlock;
> > > > > > > >>>        }
> > > > > > > >>>
> > > > > > > >>> +     err =3D bpf_struct_ops_prepare_attach(st_map, 0);
> > > > > > > >> A follow-up on the "using the map->id as the cookie" comme=
nt in the cover
> > > > > > > >> letter. I meant to use the map->id here instead of 0. If t=
he cookie is intended
> > > > > > > >> to identify a particular struct_ops instance (i.e., the st=
ruct_ops map), then
> > > > > > > >> map->id should be a good fit, and it is automatically gene=
rated by the kernel
> > > > > > > >> during the map creation. As a result, I suspect that most =
of the changes in
> > > > > > > >> patch 1 and patch 2 will not be needed.
> > > > > > > >>
> > > > > > > > Do you mean keep using cookie as the mechanism to associate=
 programs,
> > > > > > > > but for struct_ops the cookie will be map->id (i.e.,
> > > > > > > > bpf_get_attah_cookie() in struct_ops will return map->id)?
> > > > > > >
> > > > > > > I meant to use the map->id as the bpf_cookie stored in the bp=
f_tramp_run_ctx.
> > > > > > > Then there is no need for user space to generate a unique coo=
kie during
> > > > > > > link_create. The kernel has already generated a unique ID in =
the map->id. The
> > > > > > > map->id is available during the bpf_struct_ops_map_update_ele=
m(). Then there is
> > > > > > > also no need to distinguish between SEC(".struct_ops") vs
> > > > > > > SEC(".struct_ops.link"). Most of the patch 1 and patch 2 will=
 not be needed.
> > > > > > >
> > > > > > > A minor detail: note that the same struct ops program can be =
used in different
> > > > > > > trampolines. Thus, to be specific, the bpf cookie is stored i=
n the trampoline.
> > > > > > >
> > > > > > > If the question is about bpf global variable vs bpf cookie, y=
eah, I think using
> > > > > > > a bpf global variable should also work. The global variable c=
an be initialized
> > > > > > > before libbpf's bpf_map__attach_struct_ops(). At that time, t=
he map->id should
> > > > > > > be known already. I don't have a strong opinion on reusing th=
e bpf cookie in the
> > > > > > > struct ops trampoline. No one is using it now, so it is avail=
able to be used.
> > > > > > > Exposing BPF_FUNC_get_attach_cookie for struct ops programs i=
s pretty cheap
> > > > > > > also. Using bpf cookie to allow the struct ops program to tel=
l which struct_ops
> > > > > > > map is calling it seems to fit well also after sleeping on it=
 a bit. bpf global
> > > > > > > variable will also break if a bpf_prog.o has more than one SE=
C(".struct_ops").
> > > > > > >
> > > > > >
> > > > > > While both of them work, using cookie instead of global variabl=
e is
> > > > > > one less thing for the user to take care of (i.e., slightly bet=
ter
> > > > > > usability).
> > > > > >
> > > > > > With the approach you suggested, to not mix the existing semant=
ics of
> > > > > > bpf cookie, I think a new struct_ops kfuncs is needed to retrie=
ve the
> > > > >
> > > > > yes, if absolutely necessary, sure, let's reuse the spot that is
> > > > > reserved for cookie inside the trampoline, but let's not expose t=
his
> > > > > as real BPF cookie (i.e., let's not allow bpf_get_attach_cookie()
> > > > > helper for struct_ops), because BPF cookie is meant to be fully u=
ser
> > > > > controllable and used for whatever they deem necessary. Not
> > > > > necessarily to just identify the struct_ops map. So it will be a =
huge
> > > > > violation to just pre-define what BPF cookie value is for struct_=
ops.
> > > > >
> > > >
> > > > We had some offline discussions and figured out this will not work =
well.
> > > >
> > > > sched_ext users already call scx kfuncs in global subprograms. If w=
e
> > > > choose to add bpf_get_struct_ops_id() to get the id to be passed to
> > > > scx kfuncs, it will force the user to create two sets of the same
> > > > global subprog. The one called by struct_ops that calls
> > > > bpf_get_struct_ops_id() and tracing programs that calls
> > > > bpf_get_attach_cookie().
> > >
> > > Can we put cookie into map_extra during st_ops map creation time and
> > > later copy it into actual cookie place in a trampoline?
> >
> > It should work. Currently, it makes sense to have cookie in struct_ops
> > map as all struct_ops implementers (hid, tcp cc, qdisc, sched_ext) do
> > not allow multi-attachment of the same map. A struct_ops map is
> > effectively an unique attachment for now.
>
> Is there any conceptual reason why struct_ops map shouldn't be allowed
> to be attached to multiple places? If not, should we try to lift this
> restriction and not invent struct_ops-specific BPF cookie APIs?
>
> From libbpf POV, struct_ops map is created implicitly from the
> struct_ops variable. There is no map_flags field there. We'll need to
> add new special APIs and/or conventions just to be able to set
> map_flags.
>
> >
> > Additionally, we will be able to support cookie for non-link
> > struct_ops with this way.
> >
> > This approach will not block future effort to support link-specific
> > cookie if there is such a use case. We can revisit this patchset then.
>
> It will create two ways to specify BPF cookie for struct_ops: (legacy
> and special way) through map_flags and common one through the
> LINK_CREATE command (and I guess we'd need to reject LINK_CREATE if
> cookie was already set through map_flags, right?). Why confuse users
> like that?
>
> From what I understand, the problem is that currently struct_ops map's
> BPF trampoline(s) are created a bit too early, before the attachment
> step. How hard would it be to move trampoline creation to an actual
> attachment time? Should we seriously consider this before we invent
> new struct_ops-specific exceptions for BPF cookie?

Yeah...

I realized that while map_extra works, the cookie needs to be passed
to the kernel in map creation time and will create the confusion you
mentioned in libbpf.

I am fixing the patchset by moving trampoline and ksyms to
bpf_struct_ops_link. It shouldn't complicate struct_ops code too much
(finger cross).

