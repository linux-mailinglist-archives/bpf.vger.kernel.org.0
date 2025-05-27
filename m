Return-Path: <bpf+bounces-59026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD3BAC5C52
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 23:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668E24A6DDD
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49982147ED;
	Tue, 27 May 2025 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buaean/f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE220551C;
	Tue, 27 May 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382092; cv=none; b=B2W0p5SfOmkoi2xKCsam5QjBRjHsJpZJsGWGF7eEzMvDlu6Vt/DxgpYD+bVHq9Zb40AtljJ5oiMZzU0niBv2ZiUMK7d462V2oSh8uznxPGOkCn2QjZBBRnmVfbdwEoaCYXDVL+DM9WKe7jLhDBecswg26XF2Ioai0dPr+W0aCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382092; c=relaxed/simple;
	bh=b37r62/PQ1+q3+JTGoZFirUufbRcbWMygWyJ42hBi4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j23zGqyfzggp0yBrqeJoSY3UU6UVa737Uzl6rc8Z7qRxM8M5h/JvTrxDFgqcdOmcr8RocuR+cIz/cIqPU4dJ89i7fv3PkAaqdkIaF3igpC9z+4zArkgpc5iLXStVVxi154pzE1R/S51azxrQQ86icy4/C0Ta5JyFpm6YIZF6c8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buaean/f; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31149f0393dso2157268a91.1;
        Tue, 27 May 2025 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748382090; x=1748986890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgRYyyw+a2/aWbP9YIIdfoRYj+7frEzMlZj8+mWk9XE=;
        b=buaean/f3JlOODeMckhp09gvuBNLxBSUOUFD6EpNrccF/ftyffCDMU/4dPv7gGVUXi
         eoVa/a5fEjLZmgM0ygxq6VOSSshvPcqqpasAmFUHV0KsrixH5eYikPPJJyX3aVPJZBYC
         jQgfoCcdKfxi+Uwvei1MW82N6po6S9cKTsgoH4JgU15q/1fFlQ1i6YwARRzb9f9llBtY
         vNNV42EhHDDYDyGaxPc8OTLvm4Oe4ipVB13/LCHGe5nnekkl8fqlu8+N3QGOc7scbLii
         Ph6VFbubWyZ4nh39kM0VsMvQsqxpk4bBpeFjayazWiaL4GWRAbfQmWIOCTEs+kYP0HJJ
         P5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748382090; x=1748986890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgRYyyw+a2/aWbP9YIIdfoRYj+7frEzMlZj8+mWk9XE=;
        b=fqZcB5OUEPibM4Zb0Y6tNiv78DD3Xvn+FTQ6E+ACoOiWLWS4HS9DECruqYw/pylyVw
         rdeXndgcCwjfRPkQwdJkMqV4ZJWRkMo/97cukvRHeJm2tm83nYHJR/wuh0ODOCp3pgFV
         aLCZ/aLzpioC7cbX4Z0LXrHmUjwVyePgnTYqtnV4HNcCORG0//DJs0if/2WzMPzGXNJQ
         wxyo2ZqD9EEzvN3P1Y+61KjdluuEcUJmOFWzdOpkwhY/Ss90NWzKT0witdbA+cwXkUBa
         Sl8ttR7S8I+n5kO0YvZxenOoEOCi/FczlpuqvNlIgbYVT5XO9xFeHpMzondQ63skIvDQ
         JeKA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ew63Ztjg2jUKJq7i5no92TrfAOwXRAdpqSf5CFLOtwvVn5XEPKxjj7MI4oJKAZHcASo=@vger.kernel.org, AJvYcCUElXOaz42DEpleodNz2kx9s+6aq5ydldD4J1TdKZGHtdObx5w94Joff5p10S0Ji0Ex/dPv6mnZUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+jkPz3IqVJfIKgZOCgskrqz4WwgVGSzWzYXsdakLLToejavps
	Gnq3NrTrkh9qLvntQ1+bonq+4/5cwKioHTUbYHGK2ax7/tOTEYJL2ne8Bdy1aA7jS5fh1RwKvKs
	4FDAlgR1C7/mZavi/CqCe7bdPe8GragRG2A==
X-Gm-Gg: ASbGncvJhlhIJj7Mb6pc8vAL6C+WHF1rdwZbWj1aHg7HEpmoTqyWTm4ACiRS8GOG5s+
	AlwnRfokqyRpaxoTDVVCp8xW4xsRqajfGzdT9fdg8aZQtrq0RXyJbW4pCffYEdbsXClxvc/wv30
	JNiJvM4gYY5djseIHxb0hEMhPSnKw5wATMLvBj26N84j1AA+FC
X-Google-Smtp-Source: AGHT+IHgyTusboXaQq9I7KVe+GnJiwTu5VJhQzZ97tPewDqcMLzflPIbc+VwJCRRimENfdcXtF3uLUWqThYJU0/DF3A=
X-Received: by 2002:a17:90b:5282:b0:311:df4b:4b8c with SMTP id
 98e67ed59e1d1-311df4b4d23mr736012a91.7.1748382089822; Tue, 27 May 2025
 14:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <d39e456b-20ed-48cf-90c0-c0b0b03dabe6@oracle.com> <09366E0A-0819-4C0A-9179-F40F8F46ECE0@meta.com>
 <CAEf4BzZxccvWcGJ06hSnrVh6jJO-gdCLUitc7qNE-2oO8iK+og@mail.gmail.com>
 <bfb120452de9d9ce0868485bc41fa8cf56edf4cf.camel@gmail.com>
 <530F1115-7836-4F1F-A14D-F1A7B49EF299@meta.com> <6428960b-a1a7-4b1f-8975-5a85e2b8697d@oracle.com>
In-Reply-To: <6428960b-a1a7-4b1f-8975-5a85e2b8697d@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 May 2025 14:41:17 -0700
X-Gm-Features: AX0GCFsnKDVdX8xHE8GBgx5pnjms9tbaT5vkJ58CxchEr0UrFXN8sOPvKv-Y7vc
Message-ID: <CAEf4BzaG-GtJwVXNyZKqYnZFqq210uLFSHPArZYXyS+fab5Dmg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Thierry Treyer <ttreyer@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"acme@kernel.org" <acme@kernel.org>, "ast@kernel.org" <ast@kernel.org>, Yonghong Song <yhs@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>, 
	Song Liu <songliubraving@meta.com>, Mykola Lysenko <mykolal@meta.com>, Daniel Xu <dlxu@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 7:30=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 23/05/2025 19:57, Thierry Treyer wrote:
> >>>>  2) // param_offsets point to each parameters' location
> >>>>     struct fn_info { u32 type_id, offset; u16 param_offsets[proto.ar=
glen]; };
> >>>>  [...]
> >>>>  (2) param offsets, w/ dedup         14,526      4,808,838    4,823,=
364
> >>>
> >>> This one is almost as good as (3) below, but fits better into the
> >>> existing kind+vlen model where there is a variable number of fixed
> >>> sized elements (but locations can still be variable-sized and keep
> >>> evolving much more easily). I'd go with this one, unless I'm missing
> >>> some important benefit of other representations.
> >>
> >> Thierry, could you please provide some details for the representation
> >> of both fn_info and parameters for this case?
> >
> > The locations are stored in their own sub-section, like strings, using =
the
> > encoding described previously. A location is a tagged union of an opera=
tion
> > and its operands describing how to find to parameter=E2=80=99s value.
> >
> > The locations for nil, =E2=80=99%rdi=E2=80=99 and =E2=80=99*(%rdi + 32)=
=E2=80=99 are encoded as follow:
> >
> >   [0x00] [0x09 0x05] [0x0a 0x05 0x00000020]
> > #  `NIL   `REG   #5   |    `Reg#5        `Offset added to Reg=E2=80=99s=
 value
> > #                     `ADDR_REG_OFF
> >
> > The funcsec table starts with a `struct btf_type` of type FUNCSEC, foll=
owed by
> > vlen `struct btf_func_secinfo` (referred previously as fn_info):
> >
> >   .align(4)
> >   struct btf_func_secinfo {
> >     __u32 type_id;                       // Type ID of FUNC
> >     __u32 offset;                        // Offset in section
> >     __u16 parameter_offsets[proto.vlen]; // Offsets to params=E2=80=99 =
location
> >   };
> >
> > To know how many parameters a function has, you=E2=80=99d use its type_=
id to retrieve
> > its FUNC, then its FUNC_PROTO to finally get the FUNC_PROTO vlen.
> > Optimized out parameters won=E2=80=99t have a location, so we need a NI=
L to skip them.
> >
> >
> > Given a function with arg0 optimized out, arg1 at *(%rdi + 32) and arg2=
 in %rdi.
> > You=E2=80=99d get the following encoding:
> >
> >   [1] FUNC_PROTO, vlen=3D3
> >       ...args
> >   [2] FUNC 'foo' type_id=3D1
> >   [3] FUNCSEC '.text', vlen=3D1           # ,NIL   ,*(%rdi + 32)
> >       - type_id=3Dn, offset=3D0x1234, params=3D[0x0, 0x3, 0x1]
> >                                         #             `%rdi
> >
> > # Regular BTF encoding for 1 and 2
> >   ...
> > # ,FUNCSEC =E2=80=99.text=E2=80=99, vlen=3D1
> >   [0x000001 0x14000001 0x00000000]
> > # ,btf_func_secinfo      ,params=3D[0x0, 0x3, 0x1] + extra nil for alig=
nment
> >   [0x00000002 0x00001234 0x0000 0x0003 0x0001 0x0000]
> >
> > Note: I didn=E2=80=99t take into account the 4-bytes padding requiremen=
t of BTF.
> >       I=E2=80=99ve sent the correct numbers when responding to Alexei.
> >
> >> I'm curious how far this version is from exhausting u16 limit.
> >
> >
> > We=E2=80=99re already using 22% of the 64=E2=80=AFkiB addressable by u1=
6.
> >
> >> Why abuse DATASEC if we are extending BTF with new types anyways? I'd
> >> go with a dedicated FUNCSEC (or FUNCSET, maybe?..)
> >
> > I'm not sure that a 'set' describes the table best, since a function
> > can have multiple entries in the table.
> > FUNCSEC is ugly, but it conveys that the offsets are from a section=E2=
=80=99s base.
>
>
> I totally agree that we have more freedom to define new representations
> here, so don't feel too constrained by existing representations like
> DATASEC if they are not helpful.
>
> One thing I hadn't really thought about before you suggested it is
> having the locations in a separate section from types as we have for
> strings. Do we need that? Or could we have a BTF_KIND_LOC_SEC that is
> associated with the FUNC_SEC via a type id (loc sec points at the type
> of the associated func sec) and contains the packed location info?
>
> In other words
>
> [3] FUNCSEC '.text', vlen=3D ...
> <func_id, offset, param_location_offsets[]>
> ...
> [4] LOCSEC '.text', type_id=3D3
> <packed locations>

LOCSEC pointing to FUNCSEC isn't that useful, no? You'd want to go
from FUNCSEC to LOCSEC quickly, not the other way around, no? But I
also don't see the need to have a per-ELF-section set of locations,
tbh... One set ought to be enough across all FUNCSECs?

> ...
>

