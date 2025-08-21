Return-Path: <bpf+bounces-66246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51388B301CB
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 20:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA686020D0
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 18:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A922343D62;
	Thu, 21 Aug 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPs8/ThM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF642E5B3C
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800083; cv=none; b=X/4uCcFZb2xprL2UOasEuO2Whg62dqrNI8a+pcPRo4uY5rsWXUPyaMjTiabah0UfZXN3tu6z2fJS9RyDOqXs1o7Xt3RBtRnALFg4CHDB4fL45GAwj6RpEEaFODVWkjI8mhA4Qv5MzXdf4xNNXZU8PwzeMGpKRI+WqrOrrKVWH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800083; c=relaxed/simple;
	bh=PwUBb9prIcSCTuZ8Hr2cFPnWxsJZOJ0heXwqbjjkzFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAuWNhEW97/6mGomjntWi2Wcb9zYqWLSg0Z2PdyofNP/n10aAYi96fNbNtGIUcFs/gL9RljF4sArL7Uk5+2GSpNSZwSFu0VvRWGYaTV+lEP3ddJi04bzPa3ipzSWbn6Wckp5zdWaKpdAufudpjH9AelZ0eQ7gAdOoc0z88NnKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPs8/ThM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-770305d333aso24821b3a.0
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755800081; x=1756404881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Us+7gy/zt+m43pLi00KRwUL0s0l9fCnY5mdIwvDBO/c=;
        b=NPs8/ThMDdxiwV7c55ElmGn08n3hAOVzVG24r0D0IZ63b50B1vrr2UZ7K3x6uk1KkT
         1a8cgowVXSE5rUohbPKDcidVK3Mvcw6zCnX1tRYMkRGn2MUTriYVGDp4tyYevDepSJwZ
         rYWNKOT39yTImjsDjRfQHrar6zkam41rzT8eLSdyQonLxLmmA7mQXV62zLuw3LC0j3gC
         3/WnHFpavwUe9Q68c+qY/o+DK/P1Op3Gy7Li2OPyfh3gJ82O40BygthMxB5D5f1sk6C0
         2N8iQiVo5VLGbUJzZnGRwrtFpOpog8QdG27uQBum08S67skU9ziNUqqKvAKSspr68q8W
         5blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800081; x=1756404881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Us+7gy/zt+m43pLi00KRwUL0s0l9fCnY5mdIwvDBO/c=;
        b=WPnjiXBzbdaM2arB/ctuX/wq4iwWweKe2LTdPTf8WXJcrb2be6FuTr4oGdt1Aodd+S
         EdoF7p64iC5cT3wHdpo1JE02upOuv5p6bNeZu+8lrywK4Y2OqE7rvxbJZ9H8TzqlIIx3
         o41Voz0ROJkAbDWCHuFta1DMCD1fC6bBQ3C/jXqvR+l22XIgHyxs0vz1zdI5lnvOKdLd
         Ji+aRY0vEqWlOu63QK0eozGPVZ6hd7zg19HSSoYh8ywb9YkwiRNAv59h5dDWFoHbpfyh
         0vONzkmdFFYmUluv7AT2NiwnsZwVGnna9AjbMLhwBe2bXfmX5kOYQ4SFA+x3++2zl4zp
         q0Vw==
X-Gm-Message-State: AOJu0Yw6G74UkAnBzwJb0+CcP1qVUNbH4yUGhqlVjaZ6g6obyQdaXu6B
	znXTuvwmc5Uai/xdHtVK/XKbns0RCnVZe6Ej8HLRyDGMzBPaxR/KF4DhnqqzYsqM0BFL0hUAOvO
	LO3zDxm6aP+dR2kZIX7yOqO6jp+oZPQ8=
X-Gm-Gg: ASbGnctpVXGu63Hb4qpm9UBiCChN5GQm2JsiD8T9qN+UwjXxXPIP8oYgBq1cDnwvwc1
	sRLEqmPBnTUbgpAyHIq58MAchb5ezRpoKOBrmk9SHNEK/HisZcxEjwXcBP6WZsS9CPpKu8VjyUt
	auQPc5Ur3BA56SNcVnQ8rTeiQxrMs29r9fYlTuvXLi1Comwr2A3DlP0w8MO+dfEtSgboYgurYTw
	mXLeCQpjkGgGOTqEg5mDkwfivClfdLVCw==
X-Google-Smtp-Source: AGHT+IH+29Bq+YywDJ7tFIykKJZ1vpKLozs0Z5r/DH9gWxacA9nDJPWx+vg7uQyFjkU4ODsAYl7hL7pPd7oyW2ovi80=
X-Received: by 2002:a17:903:2ad0:b0:246:e91:cf16 with SMTP id
 d9443c01a7336-2462ee54995mr4280845ad.21.1755800080817; Thu, 21 Aug 2025
 11:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
 <20250816180631.952085-11-a.s.protopopov@gmail.com> <CAEf4BzaZxoz+=_uycH=6rO3U548TF7K8v5zKukDSJjWUgEXSSw@mail.gmail.com>
 <aKcZlBD+Mojmf+6P@mail.gmail.com>
In-Reply-To: <aKcZlBD+Mojmf+6P@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Aug 2025 11:14:26 -0700
X-Gm-Features: Ac12FXxJnwXwP5w4Z6kGZabImDhoizc6gSK5U5C6z67gQKL6SLZWtzkdlbJPwLY
Message-ID: <CAEf4Bza7G1Ypbg3XcB_i71HYUuySXyaPX9rMGtHN3t7YCpRY2Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 10/11] libbpf: support llvm-generated indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 6:00=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/08/20 05:20PM, Andrii Nakryiko wrote:
> > On Sat, Aug 16, 2025 at 11:02=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > For v5 instruction set, LLVM now is allowed to generate indirect
> > > jumps for switch statements and for 'goto *rX' assembly. Every such a
> > > jump will be accompanied by necessary metadata, e.g. (`llvm-objdump
> > > -Sr ...`):
> > >
> > >        0:       r2 =3D 0x0 ll
> > >                 0000000000000030:  R_BPF_64_64  BPF.JT.0.0
> > >
> > > Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
> > >
> > >     Symbol table:
> > >        4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.=
0.0
> > >
> > > The -bpf-min-jump-table-entries llvm option may be used to control
> > > the minimal size of a switch which will be converted to an indirect
> > > jumps.
> > >
> > > The code generated by LLVM for a switch will look, approximately,
> > > like this:
> > >
> > >     0: rX <- jump_table_x[i]
> > >     2: rX <<=3D 3
> > >     3: gotox *rX
> > >
> > > Right now there is no robust way to associate the jump with the
> > > corresponding map, so libbpf doesn't insert map file descriptor
> > > inside the gotox instruction.
> >
> > Just from the commit description it's not clear whether that's
> > something that needs fixing or is OK? If it's OK, why call it out?..
>
> Right, will rephrase.
>
> The idea here is that if you have, say, a switch, then, most
> probably, it is compiled into 1 jump table and 1 gotox. And, if
> compiler can provide enough metadata, then this makes sense for
> libbpf to also associate JT with gotox by inserting the same map
> descriptor inside both instructions.  However now this doesn't
> work, and also there are cases when one gotox can be associated with
> multiple JTs.

Ok, and right now we'll basically generate two identical BPF maps? If
we wanted to optimize this, wouldn't it be sufficient to just reuse
maps if relocation points to the same symbol?

>
> > >
> > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > ---
> > >  .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
> > >  tools/bpf/bpftool/map.c                       |   2 +-
> > >  tools/lib/bpf/libbpf.c                        | 159 +++++++++++++++-=
--
> > >  tools/lib/bpf/libbpf_probes.c                 |   4 +
> > >  tools/lib/bpf/linker.c                        |  12 +-
> > >  5 files changed, 153 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/=
bpf/bpftool/Documentation/bpftool-map.rst
> > > index 252e4c538edb..3377d4a01c62 100644
> > > --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > > +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > > @@ -55,7 +55,7 @@ MAP COMMANDS
> > >  |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **=
xskmap** | **sockhash**
> > >  |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgro=
up_storage**
> > >  |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **=
ringbuf** | **inode_storage**
> > > -|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **c=
grp_storage** | **arena** }
> > > +|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **c=
grp_storage** | **arena** | **insn_array** }
> > >
> > >  DESCRIPTION
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > > index c9de44a45778..79b90f274bef 100644
> > > --- a/tools/bpf/bpftool/map.c
> > > +++ b/tools/bpf/bpftool/map.c
> > > @@ -1477,7 +1477,7 @@ static int do_help(int argc, char **argv)
> > >                 "                 devmap | devmap_hash | sockmap | cp=
umap | xskmap | sockhash |\n"
> > >                 "                 cgroup_storage | reuseport_sockarra=
y | percpu_cgroup_storage |\n"
> > >                 "                 queue | stack | sk_storage | struct=
_ops | ringbuf | inode_storage |\n"
> > > -               "                 task_storage | bloom_filter | user_=
ringbuf | cgrp_storage | arena }\n"
> > > +               "                 task_storage | bloom_filter | user_=
ringbuf | cgrp_storage | arena | insn_array }\n"
> > >                 "       " HELP_SPEC_OPTIONS " |\n"
> > >                 "                    {-f|--bpffs} | {-n|--nomount} }\=
n"
> > >                 "",
> >
> > bpftool changes sifted through into libbpf patch?
>
> Yes thanks. I think I've sqhashed the fix here, becase it broke
> the `test_progs -a libbpf_str` test.
>

libbpf_str test doesn't rely on bpftool, so fixing up selftest in the
same patch makes sense (to not break bisection), but bpftool changes
still make no change and should be done separately

[...]

> >
> > > +
> > > +       return -prog->sec_insn_off;
> >
> > why this return value?... can you elaborate?
>
> Jump tables generated by LLVM contain offsets relative to the
> beginning of a section. The offsets inside a BPF_INSN_ARRAY
> are absolute (for a "load unit", i.e., insns in bpf_prog_load).
> So if, say, a section A contains two progs, f1 and f2, then,
> f1 starts at 0 and f2 at F2_START. So when the f2 is loaded
> jump tables needs to be adjusted by -F2_START such that offsets
> are correct.

the thing I missed is that this isn't some sort of error condition,
it's just when offset falls into main program function

naming is also a bit misleading, IMO because it doesn't just return
instruction offset, but rather an *adjustment* to an offset in jump
table

[...]

> > where does .rel.rodata come from?
> >
> > and we don't need to adjust the contents of any of those sections, righ=
t?...
> >
> > can you please add some tests validating that two object files with
> > jumptables can be linked together and end up with proper combined
> > .jumptables section?
> >
> >
> > and in terms of code, can we do
> >
> > } else if (strcmp(..., JUMPTABLES_REL_SEC) =3D=3D 0) {
> >     /* nothing to do for .rel.jumptables */
> > } else {
> >     pr_warn(...);
> > }
> >
> > It makes it more apparent what is supported and what's not.
>
> Yes, sure. The rodata might be obsolete, I will check, and
> .rel.jumptables is actually not used. This should be cleaned up
> once LLVM patch stabilizes. Thanks for noticing this,
> this way it is for sure added to my checklist :-)
>

ok, thanks

> >
> > > +                                       pr_warn("relocation against S=
TT_SECTION in section %s is not supported!\n",
> > > +                                               src_sec->sec_name);
> > >                                         return -EINVAL;
> > >                                 }
> > >                         }
> > > --
> > > 2.34.1
> > >

