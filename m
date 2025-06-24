Return-Path: <bpf+bounces-61386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C800CAE6BEC
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 17:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D9A3A9283
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BBE299AA1;
	Tue, 24 Jun 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBLONcSP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6EA274B58
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780779; cv=none; b=i8YtP+JLwui3T1qudnLVXZ8GqhjuU3l68tydWtUGZfcrttwhBQPxUAgeHOVf+ocQirP+vAHY+vsQ0FmVyPnd7yjuQu3ElDxd8c1wgKykKpkkVlVkRe8ZVJD1CBltBiwpfy0NVVJ/7DK5l6R4ILDlH842pwLZ3ophzKJuXJVeePc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780779; c=relaxed/simple;
	bh=gLMlltYFxxl/Kfdw/zxRWtf/5ANAO3uJQIVLUcIhGXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gw+BIaua6NmOUgz8f4oeQVMsAx7MVdtfQ563z9gon9Ee3XhepSkoQGQkV9fJMUfszyuMhnkSYPrKd3thBQFOzj6hxR8G/EZnDTzbvVcnG7hyphR4XBFK8pofKtnVrhcRerKl/V8+V14+EZjLgZal/fDWQTmVLIhVAkzF3UjlPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBLONcSP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3135f3511bcso5732541a91.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 08:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750780777; x=1751385577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCiHksvSaQ1Sle5Nc1wPxHHUAN7Ev8neMYAwY4Nk1zY=;
        b=ZBLONcSPMxJHZCfeQPvl4hrT9eaY1JJc2qJKb5G/LaIQxLa+HMEhOZwfXccVhpWg7z
         n0TG5vfqbE3c52XXAKSlmhexv9wbSqFl3t6n5zA62BSWhciXuVZGWvKIWfpguELIUzU7
         pcST5suh7Zq7zLiga/oHDg0wVVcw/XFdv4xuq4mUiY3qYeW+rAqFq+dgXl4sb7caAM6R
         r3MG+FZ6xO7c+kkZ4PK+GELHvlcC43mBi71hP5h/DoYaI9N3XaiGcXq6MdU23t8ZpPn4
         eef7XfFSlpgNbyAg7voZKIPKJUTeFabKL7eevmRnnZWh78Sb4YIcVYxR2B36bIshkiFL
         AoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750780777; x=1751385577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCiHksvSaQ1Sle5Nc1wPxHHUAN7Ev8neMYAwY4Nk1zY=;
        b=O87sUa0Ng0Ojjl/EmwK0q5Vl/otP0KbCkMLIJ3Rew31EY63k5oY7VGAQoGFCb67Y53
         8bP/wdSWLKyLD3fwD6RA2yXB5606CcUqH++OUa3Q7996Z5qCQjr+LObSOc8HuovIccY5
         9UbfYDdq23ghG5c/gKTFUT09D3UoX4D1VA+7W2kGg7R5L9DD0NNwqgCtePLsQlZ/w0It
         6VR+EX6FOf5TrcCLINx7+fF5feZ7o64b9ABObCPduHe6XzEf12Y8VuBs2Kc44wr6Qk/K
         0kYyhoG0OwmHqE9eCO6We46kxNeENzG8GiqwRuWBGIdJR8X1ywdN24e5/4Y7y0DAScJj
         9S6A==
X-Gm-Message-State: AOJu0Yx7p0da8JHJpPbZ4mdeV5IEYhw6TeCJ75tfXZEDjL9070PjvWHa
	Fm6gf9lSf8Y7yeZNc8uihRLwvPZdyfc78EwrNIPbmHSEU1xarQ+92VENE4QlPgnp86W7WJ0secw
	eNM3SiGQbkIKQ/DdH87I3NjPYwVIVKGc=
X-Gm-Gg: ASbGncusPUg0wlF8P+RokbmTl8xTlKOpXybaL9pTIbgX7VIfzCZKaN9lUCCm9H7zzj/
	pusO/O4fRO7JU5Q2UHtkI/8Le5vMpuK3RXoKWk4CMWP12pbJW/zL9ZjhZO1yzXg0mstLNA64zv/
	l0RmI2oAwQNV4+Tm0kEtO8fY0vBV6ZosZIC3aH8sNp5Q9RLEjj+eEa
X-Google-Smtp-Source: AGHT+IHlK5+8geXXhLFrGwr10rhgGFk6s8RDzNHzQB4pviX/pzgye9Atgi7mx1z4nnbfNgQGI9+/dTM0GzOlhEUOa5Y=
X-Received: by 2002:a17:90b:55c8:b0:312:ea46:3e66 with SMTP id
 98e67ed59e1d1-3159d8c5e8emr23591478a91.21.1750780776866; Tue, 24 Jun 2025
 08:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com>
 <20250618203903.539270-3-mykyta.yatsenko5@gmail.com> <CAEf4BzY8zDf4oZL=manmc_KsZpL8meC_m1jvp4EZ8MKnpkvFgQ@mail.gmail.com>
 <c05071fd-3e41-43ac-b1ff-1c002a107b24@gmail.com>
In-Reply-To: <c05071fd-3e41-43ac-b1ff-1c002a107b24@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Jun 2025 08:59:24 -0700
X-Gm-Features: AX0GCFuMz_CqK1szEIt9yrmi2AcIf-Q9xlFKOCZZ_IX3ZDqM_kWnkMTh1SmbohM
Message-ID: <CAEf4BzbGvceJoCsa_PjjVOPY-CQ=uDW0EK4Vgdc+uSBrh5gNGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: support array presets in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 5:00=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 6/23/25 23:10, Andrii Nakryiko wrote:
> > On Wed, Jun 18, 2025 at 1:39=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Implement support for presetting values for array elements in veristat=
.
> >> For example:
> >> ```
> >> sudo ./veristat set_global_vars.bpf.o -G "arr[3] =3D 1"
> >> ```
> >> Arrays of structures and structure of arrays work, but each individual
> >> scalar value has to be set separately: `foo[1].bar[2] =3D value`.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   tools/testing/selftests/bpf/veristat.c | 226 ++++++++++++++++++++---=
--
> >>   1 file changed, 180 insertions(+), 46 deletions(-)
> >>
> > [...]
> >
> >> +static int resolve_rvalue(struct btf *btf, const struct rvalue *rvalu=
e, long long *result)
> >> +{
> >> +       int err =3D 0;
> >> +
> >> +       switch (rvalue->type) {
> >> +       case INTEGRAL:
> >> +               *result =3D rvalue->ivalue;
> > return 0;
> >
> >> +               break;
> >> +       case ENUMERATOR:
> >> +               err =3D find_enum_value(btf, rvalue->svalue, result);
> >> +               if (err)
> >> +                       fprintf(stderr, "Can't resolve enum value %s\n=
", rvalue->svalue);
> > if (err) {
> >      fprintf(...);
> >      return err;
> > }
> >
> > return 0;
> >
> > ?
> >
> >> +               break;
> > default: fprintf("unknown blah"); return -EOPNOTSUPP;
> >
> >
> > I think I had a similar argument with Eduard before, so I'll explain
> > my logic here again. Whenever you have some branching in your code and
> > you know that branch's processing is effectively done and the only
> > thing left is to return success/failure signal, *do return early* and
> > explicitly ASAP (unless there is non-trivial clean up for error path,
> > in which case not duplicating and spreading clean up logic outweighs
> > the simplicity of early return code). Otherwise it takes *unnecessary*
> > extra mental effort to trace through the rest of the code to make sure
> > there is no extra common post-processing logic after that
> > branch/switch/for loop.
> >
> > So if we know the INTEGRAL case is a success, then have `return 0;`
> > right there, don't make anyone read through the rest of the function
> > just to make sure we don't do anything extra.
> I understand early returns, just in this case ditched it to make the
> code more compact.
> I'll change this.
> >> +       }
> >> +       return err;
> >> +}
> >> +
> >> +/* Returns number of consumed atoms from preset, negative error if fa=
iled */
> >> +static int adjust_var_secinfo_array(struct btf *btf, int tid, struct =
var_preset *preset,
> >> +                                   int atom_idx, struct btf_var_secin=
fo *sinfo)
> >> +{
> >> +       struct btf_array *barr;
> >> +       int i =3D atom_idx, err;
> >> +       const struct btf_type *t;
> >> +       long long off =3D 0, idx;
> >> +
> >> +       if (atom_idx < 1) /* Array index can't be the first atom */
> > can atom_idx be -1 or negative? If not, then do `if (atom_idx =3D=3D 0)=
`.
> > It's another small mental overhead that we can easily avoid, and so we
> > should.
> sure
> >
> >> +               return -EINVAL;
> >> +
> >> +       tid =3D btf__resolve_type(btf, tid);
> >> +       t =3D btf__type_by_id(btf, tid);
> >> +       if (!btf_is_array(t)) {
> >> +               fprintf(stderr, "Array index is not expected for %s\n"=
,
> >> +                       preset->atoms[atom_idx - 1].name);
> >> +               return -EINVAL;
> >> +       }
> > [...]
> >
> >> @@ -1815,26 +1938,29 @@ const int btf_find_member(const struct btf *bt=
f,
> >>   static int adjust_var_secinfo(struct btf *btf, const struct btf_type=
 *t,
> >>                                struct btf_var_secinfo *sinfo, struct v=
ar_preset *preset)
> >>   {
> >> -       const struct btf_type *base_type, *member_type;
> >> -       int err, member_tid, i;
> >> -       __u32 member_offset =3D 0;
> >> -
> >> -       base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, t->t=
ype));
> >> -
> >> -       for (i =3D 1; i < preset->atom_count; ++i) {
> >> -               err =3D btf_find_member(btf, base_type, 0, preset->ato=
ms[i].name,
> >> -                                     &member_tid, &member_offset);
> >> -               if (err) {
> >> -                       fprintf(stderr, "Could not find member %s for =
variable %s\n",
> >> -                               preset->atoms[i].name, preset->atoms[i=
 - 1].name);
> >> -                       return err;
> >> +       const struct btf_type *base_type;
> >> +       int err, i =3D 1, n;
> >> +       int tid;
> >> +
> >> +       tid =3D btf__resolve_type(btf, t->type);
> >> +       base_type =3D btf__type_by_id(btf, tid);
> >> +
> >> +       while (i < preset->atom_count) {
> >> +               if (preset->atoms[i].type =3D=3D ARRAY_INDEX) {
> >> +                       n =3D adjust_var_secinfo_array(btf, tid, prese=
t, i, sinfo);
> >> +                       if (n < 0)
> >> +                               return n;
> >> +                       i +=3D n;
> >> +               } else {
> >> +                       err =3D btf_find_member(btf, base_type, 0, pre=
set->atoms[i].name, sinfo);
> >> +                       if (err)
> >> +                               return err;
> >> +                       i++;
> >>                  }
> >> -               member_type =3D btf__type_by_id(btf, member_tid);
> >> -               sinfo->offset +=3D member_offset / 8;
> >> -               sinfo->size =3D member_type->size;
> >> -               sinfo->type =3D member_tid;
> >> -               base_type =3D member_type;
> >> +               base_type =3D btf__type_by_id(btf, sinfo->type);
> >> +               tid =3D sinfo->type;
> >>          }
> >> +
> >>          return 0;
> >>   }
> > Is there a good reason to have adjust_var_secinfo() separate from
> > adjust_var_secinfo_array(). I won't know if I didn't miss anything
> > non-obvious, but in my mind this whole adjust_var_sec_info() should
> > look roughly like this:
> >
> > cur_type =3D /* resolve from original var */
> > cur_off =3D 0;
> >
> > for (i =3D 0; i < preset->atom_count; i++) {
> >      if (preset->atoms[i].type =3D=3D ARRAY_INDEX) {
> >          /* a) error checking: cur_type should be array */
> >          /* b) resolve index (if it's enum)
> >          /* c) error checking: index should be within bounds of
> > cur_type (which is ARRAY)
> >          /* d) adjust cur_off +=3D cur_type's elem_size * index_value
> >          /* e) cur_type =3D btf__resolve_type(cur_type->type) */
> >      } else {
> >          /* a) error checking: cur_type should be struct/union */
> >          /* b) find field by name with btf_find_member */
> >          /* c) cur_off +=3D member_offset */
> >          /* d) cur_type =3D btf__resolve_type(field->type) */
> >      }
> > }
> >
> > It seems inelegant that we have an outer loop over FIELD references
> > (one at a time), but for ARRAY_INDEX we do N items skipping. Why? We
> > have a set of "instructions", just execute them one at a time, and
> > keep track of the current type and current offset we are at.
> >
> > Is there anything I am missing that would prevent this simple and more
> > uniform approach?
> yes, I think there is a small detail - `cur_type's elem_size`is not easy
> to get for multi-dim array.
> If we have 3 dim array `arr` of NxMxK, to find an index of
> `arr[x][y][z]` we calculate `(x*M + y)*K + z`
> This formula is tricky to integrate in the above loop an offset of the
> current element depends on the next
> `btf_arr`s. Though, I can see a couple of ways to do it:
> 1) Look forward for the next array dimensions to multiply with current
> index: `x*M*K +  y*K + z`.

does it really matter if it's multi-dimenstional array or
single-dimensional? In both cases you calculate the size of on array
element (which for multi-dimensional will be another array with
outermost dimension stripped, and in BTF that's a separate type
referenced by array->type BTF ID), and multiply it by the index.

So let's say you have

struct my_struct {int x, y;};

struct my_struct arr[10];

And trying to calculate arr[5] offset (without yet going inside
my_struct, one step only). You'll add 5 * sizeof(arr[0]) -> 5 * 8 =3D 40
bytes.

Now, let's say you have

int arr[10][20];

And you are processing the outermost array indexing step in arr[5][7].
Here you'll adjust offset by 5 * sizeof(arr[0]) -> 5 * sizeof(int[20])
-> 5 * 20 * 4 =3D 80 bytes.

In both cases you can just use btf__resolve_size() on
btf_array(cur_type)->type to get the size of the array's element.

Would that work?

> 2) Have a separate `array_off` variable, that will be multiplied with
> current dimension and then zeroed when atom is non-array index:
> ```
>    array_off =3D 0;
>    array_off *=3D N; array_off +=3D x;
>    array_off *=3D M; array_off +=3D y;
>    array_off *=3D K; array_off +=3D z;
> ...
>     off +=3D array_off; array_off =3D 0;
> ```
> I picked an option 2, but moved it into the separate function to make
> things a little bit simpler.
> >
> > [...]
>

