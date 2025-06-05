Return-Path: <bpf+bounces-59764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C35BACF3DF
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5601892087
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3E41F03D6;
	Thu,  5 Jun 2025 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Coh5xMBA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B5833062
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140057; cv=none; b=tLLBoG/nAKRR0DVPirPs6pNG4sd1b+CMDtGhXnwar3GsTVrQ1YSReOY/vfeAuGEkCR2GEY01CxIN3VB5pyae/T8TL51G4XxdsLJT0IiDIVeXFvDqcHdqzGzkAMtSsZDMPB9RRfsDPEw9BGcteC7uH3JYF3UjAbHo+rk3T6e3RTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140057; c=relaxed/simple;
	bh=IdQ430D5cDAmb+lVXjjoZuxeLfzoJEGxP+MmbYarROs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+W0iJyJ3nVVuPE88GSVHihBJlj8bbClpWTYe6/LrP8S6TmQn21wcmYZEljwLsi3aAF9FId/fTa6HBOkXnF10r7dsBl5S6CZa7fo/RApm1yBBZl+g74KlwanWvJGrW0j75x5NQvJGz+cZkCMNwhPnQEWrLH+4gjkMPBvWroFhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Coh5xMBA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c27df0daso1201909b3a.1
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749140055; x=1749744855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tLd2baN3clQD9xQ4RP9N5U7djxyCU7Z0TIlqeg4QNY=;
        b=Coh5xMBAjYFtwBLQN16/tUig7rGPsCr0R2V2x7oVny45whrYe5SXXdxwK7176UQrDL
         Rr1Wk4ZdobZBjQJug+KV59nZ9oZhYRqX8fVWXBHjAm/4tKhdB/XiriXXRO0GV80iaQWi
         BGW7LPMNB8Zva2ANxP4ypGZLQY7grav4L6SOeNaSo4xxrEaA8vQ5JS0xXWYQ2BwQzKN7
         iwUKaleGb4PaXA7uBcqodtRH/1FGqJ/Y9FiQ1EF5YxXpGtXqw23ns87rVGjG1PjOBMQL
         NDwnBE+9lzty2c4QhZ/mdvafLXKxLW07LL/XbLEQ4/MzO3nEtVTpJ7o09YsqCjKY+G66
         kbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749140055; x=1749744855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tLd2baN3clQD9xQ4RP9N5U7djxyCU7Z0TIlqeg4QNY=;
        b=d14rwo3mQyiAp+05wmVQeLhVja9uc8LNmp2s86vuCEVT42IrSnplMtz6bVK9+LTY3q
         o06zG6FrGvpYKxtCwKDdzI6+a0c4e7oWokUUTbd449fVqZ/KV6HoWRDjhq2R0fE2JIva
         byrvJdNoKtrTpRqrftoqupRaDiFu1HDD5Rb+1y1aPiyZlCvi5wTozTkpafm080hUNehm
         d+0FR1cny/HoB3KXV8tyi7eMpZSlYkBKcxVh3JkPeA3e5b6qgq0aSiZrE1gIV/HJcpuP
         TLVz4Ac1/z8ZwquwrObvynNEAb7WGx+XAGfTQwIlsH2tZCYvzawpG6Mt9f5rJFTxIR6y
         BVyQ==
X-Gm-Message-State: AOJu0YydlyVRsKVDkmDYGOV2InxZfmc4gSqXfRr9Sj1y4Bj0DBS1R/Ag
	HWxyTmB3Y6q21zyyeH+EpR8Hz9zm4UvO8s+VbMDcVx2z66C21ajioFRBb+UGrruXluruj+vvNuV
	KrWkLxQThQ196ACu+zTEP571gQSOY3fK0bA==
X-Gm-Gg: ASbGncvS+3rz2dMc3+xkv+hTpoA2UDWBerafNnsVOQ7bJj9rAFnN/8PnkfSXrPRXAJH
	rCrHqIgp0YU2tODXaGnT58l7f+Xwzy6c3i/wHqnlWh5H6PCYfJ9GWNvL0Fd0OxIjEVvib/IlAgD
	riqNQhwxMPEeUYeGuQ0WvpeGWnIfisJ7S6iYYZ3wAJdvO5dBys
X-Google-Smtp-Source: AGHT+IHz62OYbvADHuMRmH3bv+iwVzEsEoeRyfERdJsO0srw+4D64eZFvkdUkncSstPeBOyWLRoXfc1/y9d5HFEy448=
X-Received: by 2002:aa7:88c6:0:b0:746:298e:4ed0 with SMTP id
 d2e1a72fcca58-74827ff601fmr373613b3a.13.1749140054733; Thu, 05 Jun 2025
 09:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603141539.86878-1-mykyta.yatsenko5@gmail.com>
 <CAEf4Bzb3=brMXMBZ-AGj8xdr80XEs2Og0XeZ1zuiHnFNWWPJJQ@mail.gmail.com> <e4738330-e6e8-4950-9226-36a5090736a3@gmail.com>
In-Reply-To: <e4738330-e6e8-4950-9226-36a5090736a3@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Jun 2025 09:14:01 -0700
X-Gm-Features: AX0GCFvX8JAujO0C_24GpdyLQUCZUuIGdYehQSOcF3bSuVZBU7vbPcTLP25F6T4
Message-ID: <CAEf4BzYTdngAtJ0ro3yCsOyx5Bu=CmmZLNpKtUv5Gs7-Sb-wTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: support array presets in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 8:33=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 6/3/25 22:24, Andrii Nakryiko wrote:
> > On Tue, Jun 3, 2025 at 7:15=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Implement support for presetting values for array elements in veristat=
.
> >> For example:
> >> ```
> >> sudo ./veristat set_global_vars.bpf.o -G "struct1[2].struct2[1].u.var_=
u8[2] =3D 3" -G "arr[3] =3D 9"
> >> ```
> >> Arrays of structures and structure of arrays work, but each individual
> >> scalar value has to be set separately: `foo[1].bar[2] =3D value`.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   .../selftests/bpf/prog_tests/test_veristat.c  |  9 +--
> >>   .../selftests/bpf/progs/set_global_vars.c     | 12 ++--
> >>   tools/testing/selftests/bpf/veristat.c        | 63 +++++++++++++++++=
--
> >>   3 files changed, 70 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/=
tools/testing/selftests/bpf/prog_tests/test_veristat.c
> >> index 47b56c258f3f..1af5d02bb2d0 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> >> @@ -60,12 +60,13 @@ static void test_set_global_vars_succeeds(void)
> >>              " -G \"var_s8 =3D -128\" "\
> >>              " -G \"var_u8 =3D 255\" "\
> >>              " -G \"var_ea =3D EA2\" "\
> >> -           " -G \"var_eb =3D EB2\" "\
> >> -           " -G \"var_ec =3D EC2\" "\
> >> +           " -G \"var_eb  =3D  EB2\" "\
> >> +           " -G \"var_ec=3DEC2\" "\
> > What was the problem previously with not handling this case?
> %s consumes input until whitespace or end of string, so var=3Dval will be
> written to a single string.

Ah, makes sense. It was worth mentioning this separately (or even
doing it as a separate patch with Fixes: tag).

> >
> >>              " -G \"var_b =3D 1\" "\
> >> -           " -G \"struct1.struct2.u.var_u8 =3D 170\" "\
> >> +           " -G \"struct1[2].struct2[1].u.var_u8[2]=3D170\" "\
> >>              " -G \"union1.struct3.var_u8_l =3D 0xaa\" "\
> >>              " -G \"union1.struct3.var_u8_h =3D 0xaa\" "\
> >> +           " -G \"arr[2] =3D 0xaa\" "    \
> >>              "-vl2 > %s", fix->veristat, fix->tmpfile);
> >>
> >>          read(fix->fd, fix->output, fix->sz);
> > [...]
> >
> >> @@ -81,8 +80,9 @@ int test_set_globals(void *ctx)
> >>          a =3D var_eb;
> >>          a =3D var_ec;
> >>          a =3D var_b;
> >> -       a =3D struct1.struct2.u.var_u8;
> >> +       a =3D struct1[2].struct2[1].u.var_u8[2];
> >>          a =3D union1.var_u16;
> >> +       a =3D arr[3];
> >>
> > let's add tests for at least:
> >    a) multi-dimensional arrays
> >    b) arrays of pointers (that's unlikely to happen in practice, but
> > still, we should avoid just messing stuff up silently). We can also
> > explicitly error out on pointers, I suppose.
> >    c) what about using enums as indices?
> >    d) can we have some typedef'ed types both with array-based and
> > direct accesses (to validate we skipped typedefs where appropriate)
> Should we support multi-dimensional arrays?

Yeah, why not? That's where the more structured parsing of "accessor"
string would make sense. You can either have field reference or array
indexing, and go over this list one step at a time.

> How to implement enum indexes, iterate over all btf and check if the
> name equals?

Doesn't veristat already support using enums by name? Can we support
that here for indexing as well? Take symbolic enum value, find its
matching integer value, use that to index.

> >
> > I'd suggest splitting selftests from veristat changes. They are in the
> > same selftests/bpf directory, but conceptually they are tool vs tests
> > patches, so better kept separate, IMO.
> >
> > pw-bot: cr
> >
> >>          return a;
> >>   }
> >> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/se=
lftests/bpf/veristat.c
> >> index b2bb20b00952..79c5ea6476ca 100644
> >> --- a/tools/testing/selftests/bpf/veristat.c
> >> +++ b/tools/testing/selftests/bpf/veristat.c
> >> @@ -1379,7 +1379,7 @@ static int append_var_preset(struct var_preset *=
*presets, int *cnt, const char *
> >>          memset(cur, 0, sizeof(*cur));
> >>          (*cnt)++;
> >>
> >> -       if (sscanf(expr, "%s =3D %s %n", var, val, &n) !=3D 2 || n !=
=3D strlen(expr)) {
> >> +       if (sscanf(expr, "%[][a-zA-Z0-9_.] =3D %s %n", var, val, &n) !=
=3D 2 || n !=3D strlen(expr)) {
> >>                  fprintf(stderr, "Failed to parse expression '%s'\n", =
expr);
> >>                  return -EINVAL;
> >>          }
> >> @@ -1486,6 +1486,39 @@ static bool is_preset_supported(const struct bt=
f_type *t)
> >>          return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
> >>   }
> >>
> >> +static int adjust_array_secinfo(const struct btf *btf, const struct b=
tf_type *t,
> >> +                               struct btf_var_secinfo *sinfo, const c=
har *var)
> >> +{
> >> +       struct btf_array *barr;
> >> +       const struct btf_type *type;
> >> +       char arr[64], idx[64];
> >> +       int i =3D 0, tid;
> >> +
> >> +       if (!btf_is_array(t))
> >> +               return 0;
> > this shouldn't be called for non-array, no? if yes, then we should
> > either drop unnecessary safety check or error out
> >
> >> +
> >> +       barr =3D btf_array(t);
> >> +       tid =3D btf__resolve_type(btf, barr->type);
> >> +       type =3D btf__type_by_id(btf, tid);
> >> +
> >> +       /* var may contain chained expression e.g.: foo[1].bar */
> > this feels a bit hacky that we re-parse those string specifiers...
> > maybe we should parse them once, prepare some structured
> > representation such that the rest of the code can easily check whether
> > each access is array or non-array, and have parsed index number for
> > arrays
> >
> >> +       if (sscanf(var, "%[a-zA-Z0-9_][%[a-zA-Z0-9]]", arr, idx) !=3D =
2) {
> >> +               fprintf(stderr, "Could not parse array expression %s\n=
", var);
> >> +               return -EINVAL;
> >> +       }
> >> +       errno =3D 0;
> >> +       i =3D strtol(idx, NULL, 0);
> >> +       if (errno || i < 0 || i >=3D barr->nelems) {
> >> +               fprintf(stderr, "Preset index %s is invalid or out of =
bounds [0, %d]\n",
> >> +                       idx, barr->nelems);
> >> +               return -EINVAL;
> >> +       }
> >> +       sinfo->size =3D type->size;
> > hm... what if type is another array? we need to calculate the size
> > properly, not just take type->size directly. Or what if it's a pointer
> > type and type->size is actually type->type?
> Is type an another array in case of multidimensional arrays?

yep

> >> +       sinfo->type =3D tid;
> >> +       sinfo->offset +=3D i * type->size;
> >> +       return 0;
> >> +}
> >> +

[...]

