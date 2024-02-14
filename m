Return-Path: <bpf+bounces-21934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1898540FE
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6085A1F27FD7
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE09E801;
	Wed, 14 Feb 2024 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gACx7tzh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79A372
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707872573; cv=none; b=QVzKyGgrl7I86JLDTQeFWB7XyV+3Yag50OHnguxxzSLus3mABZxn4tp8ghII+HOmsnCn84EnSTAuBt1JsvmHWZGrcBs8i19aXHGXymcXsxLBM0zTktEYvnehzZvep7rjZ7xP3qbsCauGyKcdsSGib06p5PrhewQPQwy7bz7fKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707872573; c=relaxed/simple;
	bh=ys+FQv4cHhRTNkKNZnsImn3WYfc3yYQguCKdDIqBhDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlgLZIIILyOZuchJ3hgxNv6ZpvtO0ZZMoLG4LlCpbRZbBBey/Q9WT6bskf107ruRBiG7gO56MNHL+6YfWYRuCTa0h+KC2H+VC0mO1ZdwmXkNHS/6bkjvAJ7npLr3Xh4k96I6yfMG916DeYmkuCimwLVKhGYATntJjJoL/NeHM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gACx7tzh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-411a5b8765bso1509315e9.1
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 17:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707872570; x=1708477370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys+FQv4cHhRTNkKNZnsImn3WYfc3yYQguCKdDIqBhDY=;
        b=gACx7tzhUvnQyhqGZpuhcaKDB29AMSlbGX76bgO+ygv+ccVbvF7xDIGTxUSOdh282k
         wj6aZ5Dn6sdHK5dB2r9Sy7KtCkgFGwF28ttBWOYiR6BK/cd6jQsD/9t2+69gZoMReYdm
         M0i6JeI+mHWnoSycUm9cNH8ZvqcCuLBCrMQaplNsXcNZrqkEC5+fz88xpyKT5/q9xHrY
         o/xs8OdkCRjY0bCAR21z6+sHMtqr258V1wwyHmdTY9BB76OY7MoXBA+4Pl8Jqzl8wqK8
         JxJlYwJ82hd2gbrwkK+O3mhHp8TJp+A60fJ3+mO5sGqwLSFEdcZgUIecdHuwGsYlu3a1
         WoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707872570; x=1708477370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys+FQv4cHhRTNkKNZnsImn3WYfc3yYQguCKdDIqBhDY=;
        b=a8bDO2aU5rQ+QJCP+KHDDPoXu8voq4OHbhc9CJYwe1xQNZ5+HkBYwhu57iEJgUE4DS
         DefEBNs/zVKb/kNOvVDJFvWFaUyzDFGSFk78B0+eKEg39mBQzVQ/KsEV2g5071ZJgd66
         rM/JX1qX/uq1kD09P1IbcwgItD5zY6ZiST4uQvqrsLGagNLkkR8STvyNQvvxcnnevjGC
         kOCPlUPZMsWWuYWKMcqSyGsMwhA3vr6phMSqUfYum8VsYkHtLPKU9Vi6pyuXYfGWEFkl
         VScKXcJediQxPevDNMgS0IpTSLGuAWyTjN1DpjeeRWfcXpt1IRbY3dvc8CnF7JDhDb9u
         Ix5w==
X-Gm-Message-State: AOJu0YxN5l0l7J36IE9mjvOlrToIt7qlx2xX2LGNUeb79weI+S7I5ieY
	HvKwxmsNRFIO9TEtgs6vsACs9lBbCTUX/ccptszT1rFq6dxDQQew+jm7XFan3VQRz4mPPQ1JBzL
	+PhrisgxwU7dVAC9Ft8S/bSu7LkA=
X-Google-Smtp-Source: AGHT+IHV+SVGA5NF/7QPEK4Ttn1/8o7VyqCtO5vXBmdGha6JCjy+FpATDjyvLQVHjcbRzgIle2TYS79aytqxb77ELV4=
X-Received: by 2002:a05:600c:5107:b0:411:c8a7:7b6e with SMTP id
 o7-20020a05600c510700b00411c8a77b6emr320022wms.10.1707872569949; Tue, 13 Feb
 2024 17:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-15-alexei.starovoitov@gmail.com> <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
In-Reply-To: <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 17:02:38 -0800
Message-ID: <CAADnVQ+jDLDK9TXCjRWsLg9SK4N1VHgiSLoqqdGfvtUpKbmLaw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:11=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-02-08 at 20:06 -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > LLVM automatically places __arena variables into ".arena.1" ELF section=
.
> > When libbpf sees such section it creates internal 'struct bpf_map' LIBB=
PF_MAP_ARENA
> > that is connected to actual BPF_MAP_TYPE_ARENA 'struct bpf_map'.
> > They share the same kernel's side bpf map and single map_fd.
> > Both are emitted into skeleton. Real arena with the name given by bpf p=
rogram
> > in SEC(".maps") and another with "__arena_internal" name.
> > All global variables from ".arena.1" section are accessible from user s=
pace
> > via skel->arena->name_of_var.
> >
> > For bss/data/rodata the skeleton/libbpf perform the following sequence:
> > 1. addr =3D mmap(MAP_ANONYMOUS)
> > 2. user space optionally modifies global vars
> > 3. map_fd =3D bpf_create_map()
> > 4. bpf_update_map_elem(map_fd, addr) // to store values into the kernel
> > 5. mmap(addr, MAP_FIXED, map_fd)
> > after step 5 user spaces see the values it wrote at step 2 at the same =
addresses
> >
> > arena doesn't support update_map_elem. Hence skeleton/libbpf do:
> > 1. addr =3D mmap(MAP_ANONYMOUS)
> > 2. user space optionally modifies global vars
> > 3. map_fd =3D bpf_create_map(MAP_TYPE_ARENA)
> > 4. real_addr =3D mmap(map->map_extra, MAP_SHARED | MAP_FIXED, map_fd)
> > 5. memcpy(real_addr, addr) // this will fault-in and allocate pages
> > 6. munmap(addr)
> >
> > At the end look and feel of global data vs __arena global data is the s=
ame from bpf prog pov.
>
> [...]
>
> So, at first I thought that having two maps is a bit of a hack.
> However, after trying to make it work with only one map I don't really
> like that either :)

My first attempt was with single arena map, but it ended up with
hacks all over libbpf and bpftool to treat one map differently depending
on conditions.
Two maps simplified the code a lot.

> The patch looks good to me, have not spotted any logical issues.
>
> I have two questions if you don't mind:
>
> First is regarding initialization data.
> In bpf_object__init_internal_map() the amount of bpf_map_mmap_sz(map)
> bytes is mmaped and only data_sz bytes are copied,
> then bpf_map_mmap_sz(map) bytes are copied in bpf_object__create_maps().
> Is Linux/libc smart enough to skip action on pages which were mmaped but
> never touched?

kernel gives zeroed out pages to user space.
So it's ok to mmap a page, copy data_sz bytes into it
and later copy the full page from one addr to another.
No garbage copy.
In this case there will be data by llvm construction of ".arena.1"
It looks to me that even .bss-like __arena vars have zero-s in data
and non-zero data_sz.

>
> Second is regarding naming.
> Currently only one arena is supported, and generated skel has a single '-=
>arena' field.
> Is there a plan to support multiple arenas at some point?
> If so, should '->arena' field use the same name as arena map declared in =
program?

I wanted to place all global arena vars into a default name "arena"
and let skeleton to use that name without thinking what name
bpf prog gave to the actual map.

