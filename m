Return-Path: <bpf+bounces-63085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FE2B0249B
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 21:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04324188EE44
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320E280A3B;
	Fri, 11 Jul 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFHhsniV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65A18DF6E
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262186; cv=none; b=gCnid/402VFsOB8GARSnKwhtJGLDdkwO7UfVNU26lDeRY/kER1CUtOHq32KVuppB98k9kZPM38q/Iv7Fek2H+Oq2NrY0JaBEbRBI7h75GXLvptXpqIdTdE/U2627n56MdVyoULnurlf9dCW70axm9h4zEgXKaTQr8TY07uj5TJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262186; c=relaxed/simple;
	bh=o6nGOQP7g0oq4FVHGUAj+sWB5EZEZo3wIy505L6vN5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoSo6Szj3uOso0FWZI9WIA2eXu1py3OTHt0w79cvTcVwDuOqAYdwz6NKx16ysQVN/SunvEYHUhjXUhMeaW5sQ2g1qcDnTAn0j8uqgeWxGdgkKLtqXytOFrE27jhkRLaSKcYJDIy07wYpFNIfYsLi/NHQNOAmplavXBbSxDq/2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFHhsniV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-714066c7bbbso26188467b3.3
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752262183; x=1752866983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQuIuaKlgBdgtcoqinkNXv6kBIHUL9DIsm6j5do0JXY=;
        b=SFHhsniVZtTxnaSKFuC+6c+3z92rjc5TLnju8ISNDBIA882rP9oeTtVahUwgyT5IJN
         h8SD7Z/ZnBpxsCW4tq3ZJN1TsvbVHUPXWRyAe9UZ89dKk8AXi7f8jCACljFZBttH17UJ
         w42hYB3J4jOHhmbLTmBOIOQ7B6wWkMyaPe1SWrmpgGWOdieO71YrzounBPhZkKbWvrOO
         8ullHO4QzLLWONZezHI4ug+3F5fP/Ir6uQ68xbGjV9Sx8LGJ4WDz1N8vBpAOZBncQSPE
         htYpMIerzPizP8aqfhk+zat9sZZ8oaapgMqYlfMZwHKP7LLLT59cbcjdvnQ0stab9CXA
         x/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262183; x=1752866983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQuIuaKlgBdgtcoqinkNXv6kBIHUL9DIsm6j5do0JXY=;
        b=ERTHd02ga1otX4tCp7ogu23vr0pnw5n3aGMGZaVlY28Wvo7CheB97l4HksB/rPwxEM
         CAQOBy2bQR4N12mMn8SDqyeLzr22jZ2etcIEwI/nG0XLsdpQpndSWK7RG8W0L498mH3E
         dKV3BXcxpQrOhm0KrRguWkcUx7uMoZvfHDILTLpUVc9QMbUIj2Ig5tOO7YxiOvJSjpkD
         rvV/9sw3Nuc/7zRuN/wyU1DB+hD1wiSFgh+8ZVHuHEHMyRS8/ops2e5ajL5clzLHPi8O
         +vhadVeZwizl1ay9/kNa0zhC6BmqUiM5yKTxLnL8znLZ/aw+okX3W85f43InnDAuzNA6
         JPXA==
X-Forwarded-Encrypted: i=1; AJvYcCXpeXCzkgIeDbxlXOhWrzw47VtwgrJndz7LA61gB+M0kZ2bf/MxCM3/rY5VSONpD5+d+cI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0tX1oWqKGZ4lnQap2ke4VKnuLSvSISyPdEE3uQ/o+rKRh+pJ
	BcP0lS9gkcu2WkRBWafyw//m1764C2hFXSjCEM1pY5gbXRX47TPgcfNP4SbOUNaEbSK7FNJlfS1
	KENE7OKqMeIwCQzNuMFmPDDr1VgvNujw=
X-Gm-Gg: ASbGncv8/xcSs/WliXebUXTa06zjN0VwkbpXsRpfX1cmB9ZAe7VySQdjoEJssw5REdv
	Rl5WYXFSk/v+RcHYOI0WY0tvMAxU31iC01FOnWVqOHecWquJZG7CN3BeOsTfju2BkHDmcNtbxsE
	uwAHSSaxtlDxH1Svus4CJ3kYRkai7OkqfgVix1cYBra1YhqJL1qCY9zHyAMTyy/6nCb9ROspbk/
	FRUzac=
X-Google-Smtp-Source: AGHT+IGXvyU5i7URvQXOsSViG41MQ4gEh2Xd/tCjVBHx64CeUev68MsAoR6fEDv7g6/UBEgHAXXb0zbZ9VVGeBC6P+E=
X-Received: by 2002:a05:690c:6108:b0:70f:83af:7db1 with SMTP id
 00721157ae682-717d5dc956emr77825977b3.19.1752262183154; Fri, 11 Jul 2025
 12:29:43 -0700 (PDT)
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
In-Reply-To: <CAEf4BzaUK0i7QFkKi800TQhAKw2WL+FyoG3eFP6nq_r-TUPBKw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 11 Jul 2025 12:29:32 -0700
X-Gm-Features: Ac12FXxC6XiRnbMT1xJ8O5S9X1eY06jKZmVYjNdGVrAhx91Pu6SOlzFZTgqQax8
Message-ID: <CAMB2axONnVJ5BY-YOASWGUGpaZa-P64Yf5f6AbX+O8fjCiZNfw@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based
 struct_ops attachment
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 11:41=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jul 10, 2025 at 2:00=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Thu, Jul 10, 2025 at 12:47=E2=80=AFPM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> > >
> > > On 7/10/25 11:39 AM, Amery Hung wrote:
> > > >> On 7/8/25 4:08 PM, Amery Hung wrote:
> > > >>> @@ -906,6 +904,10 @@ static long bpf_struct_ops_map_update_elem(s=
truct bpf_map *map, void *key,
> > > >>>                goto unlock;
> > > >>>        }
> > > >>>
> > > >>> +     err =3D bpf_struct_ops_prepare_attach(st_map, 0);
> > > >> A follow-up on the "using the map->id as the cookie" comment in th=
e cover
> > > >> letter. I meant to use the map->id here instead of 0. If the cooki=
e is intended
> > > >> to identify a particular struct_ops instance (i.e., the struct_ops=
 map), then
> > > >> map->id should be a good fit, and it is automatically generated by=
 the kernel
> > > >> during the map creation. As a result, I suspect that most of the c=
hanges in
> > > >> patch 1 and patch 2 will not be needed.
> > > >>
> > > > Do you mean keep using cookie as the mechanism to associate program=
s,
> > > > but for struct_ops the cookie will be map->id (i.e.,
> > > > bpf_get_attah_cookie() in struct_ops will return map->id)?
> > >
> > > I meant to use the map->id as the bpf_cookie stored in the bpf_tramp_=
run_ctx.
> > > Then there is no need for user space to generate a unique cookie duri=
ng
> > > link_create. The kernel has already generated a unique ID in the map-=
>id. The
> > > map->id is available during the bpf_struct_ops_map_update_elem(). The=
n there is
> > > also no need to distinguish between SEC(".struct_ops") vs
> > > SEC(".struct_ops.link"). Most of the patch 1 and patch 2 will not be =
needed.
> > >
> > > A minor detail: note that the same struct ops program can be used in =
different
> > > trampolines. Thus, to be specific, the bpf cookie is stored in the tr=
ampoline.
> > >
> > > If the question is about bpf global variable vs bpf cookie, yeah, I t=
hink using
> > > a bpf global variable should also work. The global variable can be in=
itialized
> > > before libbpf's bpf_map__attach_struct_ops(). At that time, the map->=
id should
> > > be known already. I don't have a strong opinion on reusing the bpf co=
okie in the
> > > struct ops trampoline. No one is using it now, so it is available to =
be used.
> > > Exposing BPF_FUNC_get_attach_cookie for struct ops programs is pretty=
 cheap
> > > also. Using bpf cookie to allow the struct ops program to tell which =
struct_ops
> > > map is calling it seems to fit well also after sleeping on it a bit. =
bpf global
> > > variable will also break if a bpf_prog.o has more than one SEC(".stru=
ct_ops").
> > >
> >
> > While both of them work, using cookie instead of global variable is
> > one less thing for the user to take care of (i.e., slightly better
> > usability).
> >
> > With the approach you suggested, to not mix the existing semantics of
> > bpf cookie, I think a new struct_ops kfuncs is needed to retrieve the
>
> yes, if absolutely necessary, sure, let's reuse the spot that is
> reserved for cookie inside the trampoline, but let's not expose this
> as real BPF cookie (i.e., let's not allow bpf_get_attach_cookie()
> helper for struct_ops), because BPF cookie is meant to be fully user
> controllable and used for whatever they deem necessary. Not
> necessarily to just identify the struct_ops map. So it will be a huge
> violation to just pre-define what BPF cookie value is for struct_ops.
>

We had some offline discussions and figured out this will not work well.

sched_ext users already call scx kfuncs in global subprograms. If we
choose to add bpf_get_struct_ops_id() to get the id to be passed to
scx kfuncs, it will force the user to create two sets of the same
global subprog. The one called by struct_ops that calls
bpf_get_struct_ops_id() and tracing programs that calls
bpf_get_attach_cookie().

> > map->id stored in bpf_tramp_run_ctx::bpf_cookie. Maybe
> > bpf_struct_ops_get_map_id()?
> >
> > Another approach is to complete the plumbing of this patchset by
> > moving trampoline and ksyms from map to link. Right now it is broken
> > when creating multiple links from the same map as can be seen in the
> > CI. I think this is better as we don't create another unique thing for
> > struct_ops.
> >
> > WDYT?
>
> I think that is a logical thing to do, because BPF link represents
> attachment, and trampoline should conceptually correspond to an
> attachment, not to the thing that is being attached (and might be
> attached to multiple places, potentially). We have this approach with
> the fentry/fexit program's trampoline, so it would be nice to move
> struct_ops to the same model.
>
> >
> > > For tracing program, the bpf cookie seems to be an existing mechanism=
 that can
> > > have any value (?). Thus, user space is free to store the map->id in =
it also. It
> > > can also choose to store the map->id in a bpf global variable if it h=
as other
> > > uses for the bpf cookie. I think both should work similarly.
> >

