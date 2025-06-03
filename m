Return-Path: <bpf+bounces-59553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243CACCEEB
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 23:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4395A16D074
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 21:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2E7225760;
	Tue,  3 Jun 2025 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbqzg7vr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD112C3259
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985870; cv=none; b=Ft+1fqE0mernwibaMkc01zTLTIl53BwI+KNWWcb6hue7KTHP3IKTXeSqC7/30zvoDUnykdELyT3XZjQujBoPw7ypj3Buh7Pmxb/E8UB7OnimerBKaJ3zPYTJXUqhpxE/cooptFa3onvNr8hGPe2v3bNgn7pwZdcrGTuwF2qRh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985870; c=relaxed/simple;
	bh=e/BaIciDiaDaEFSyBWXMTwIH4WAlS+9ctAjR7AtvGBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llEd63IkZgdt/B4nhefsuPlsBG55Y7GY9q3O23o+B9mM/tuBcYKawCeBWOi310ZChWXwUa3nlVGW8ajFS6xVZ7Q3u7JbtWAkGaF5n3Eb3Y/QSVF4NDuapzWyfHp4vyUuaVG42/0cAEaREed1aTeVV736x0xkgvB/CANGHu8l1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbqzg7vr; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2efa17ed25so273664a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748985867; x=1749590667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ICBtHCpFw0aZbHvd12EpgneOpRKGMMP818Ww0xlrgk=;
        b=nbqzg7vrafR3M+XrCd50pj4qaCv07pESRGIaJzTwOc+23oMTRx/oiZguxOPU1yqD9z
         MgBWJYBJSO0cjcaO/Jh5EtBTX4yYZKNIX05NiE1e+FGNWUfcXZsSHglKo2b80aBfLT1c
         gvXnsLWPwQt7oybyidAab0+IZZZhTtFVulegoM8AKLyNuA5gFrfDzdCJE3gJizKBLQiU
         8UC3IkRSs/g9aSbzR7d1nGQZRpcJ7dNbrPnWafwgRirMnD0Gog36sCT3W1ANQTnl3736
         E+BJZxNY/NY3PNU6uECGg0T09JxImZMWChhIIyxfOBCyY/UncQ/VrDfqNEnIEJmddyql
         rYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748985867; x=1749590667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ICBtHCpFw0aZbHvd12EpgneOpRKGMMP818Ww0xlrgk=;
        b=qd1B08vagsUuub4Ax6AgFzca3RasPLhTAdFaz460SRJmbeq0JIdPFUnF4pfYRc4ZbX
         dR6ymKm43aohigUFIjpj5b9Niff94zBqwtxEGXDSnbOvDB/GbHuqdJpXuWZSq7WnJNl4
         kPjOXESbQel1RyLV+QygvgUAGJ5m0RLfsU3DsS6vv8Q3O5A0iI6utQO9N8H7BXkjVs2f
         MiJfk++9ruqoEVQJezSSyQfNaJc1DdfnOIzrrtFhxYmSA6+gKrCW/nZ2NTnvJnN0q15t
         vMKkcqIvG+m8J40/0xsdgLviyZys/S3FWBQFoNz9JeTlvbqLzrB7O4GAijUHfGa6uLCV
         mqYA==
X-Gm-Message-State: AOJu0Ywr0YjwQRrxJ/+V0yoIiA+jiWcrNHY7Tu4UvoG98Lzj6zcW1jzL
	GpXZmnEc2xVRdK64kvnAo1TxlFers6hYByc5EWVat1r0zcihBT88ErOdF9OFNPFYjajZnsgJqec
	lHH8s4qTKB8VFpDmUrbdm+fT2px8LafjleA==
X-Gm-Gg: ASbGncsUCiHvwYM/DjXzSkufaKxazu3VobEKQVcRQ2xp9bkNc+qbwGjOH3QFEYzS36Z
	mTc00QOk8/n4IL4o+/vszrqNi7g5U5UvuUPJ781lt85lIhiD/8/jCflSm/g3h8ZN8AxUtAc1BhL
	wACnIKsJ39GIQ5nd7sX9sJIvgnhCFDNUvWXpdAio8THgtMzN5I+jjQrFPzJSw=
X-Google-Smtp-Source: AGHT+IFn9s7E4NaJgpuxu3GM6NxSSqkxVoziNHvRgEq6erpbAuh8kpRyGIUy9NL74ZPUBTje6kC8NP+Swoyj0BmgAq4=
X-Received: by 2002:a17:90b:51c3:b0:2ff:556f:bf9 with SMTP id
 98e67ed59e1d1-3130da33e3bmr611026a91.4.1748985867561; Tue, 03 Jun 2025
 14:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603141539.86878-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250603141539.86878-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Jun 2025 14:24:14 -0700
X-Gm-Features: AX0GCFtU_xFH70gN-10SVABIGXYYYjc7Fq0kB8nRKfYDrofQRXF73W2vl4hnQoc
Message-ID: <CAEf4Bzb3=brMXMBZ-AGj8xdr80XEs2Og0XeZ1zuiHnFNWWPJJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: support array presets in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 7:15=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Implement support for presetting values for array elements in veristat.
> For example:
> ```
> sudo ./veristat set_global_vars.bpf.o -G "struct1[2].struct2[1].u.var_u8[=
2] =3D 3" -G "arr[3] =3D 9"
> ```
> Arrays of structures and structure of arrays work, but each individual
> scalar value has to be set separately: `foo[1].bar[2] =3D value`.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../selftests/bpf/prog_tests/test_veristat.c  |  9 +--
>  .../selftests/bpf/progs/set_global_vars.c     | 12 ++--
>  tools/testing/selftests/bpf/veristat.c        | 63 +++++++++++++++++--
>  3 files changed, 70 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/too=
ls/testing/selftests/bpf/prog_tests/test_veristat.c
> index 47b56c258f3f..1af5d02bb2d0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> @@ -60,12 +60,13 @@ static void test_set_global_vars_succeeds(void)
>             " -G \"var_s8 =3D -128\" "\
>             " -G \"var_u8 =3D 255\" "\
>             " -G \"var_ea =3D EA2\" "\
> -           " -G \"var_eb =3D EB2\" "\
> -           " -G \"var_ec =3D EC2\" "\
> +           " -G \"var_eb  =3D  EB2\" "\
> +           " -G \"var_ec=3DEC2\" "\

What was the problem previously with not handling this case?

>             " -G \"var_b =3D 1\" "\
> -           " -G \"struct1.struct2.u.var_u8 =3D 170\" "\
> +           " -G \"struct1[2].struct2[1].u.var_u8[2]=3D170\" "\
>             " -G \"union1.struct3.var_u8_l =3D 0xaa\" "\
>             " -G \"union1.struct3.var_u8_h =3D 0xaa\" "\
> +           " -G \"arr[2] =3D 0xaa\" "    \
>             "-vl2 > %s", fix->veristat, fix->tmpfile);
>
>         read(fix->fd, fix->output, fix->sz);

[...]

> @@ -81,8 +80,9 @@ int test_set_globals(void *ctx)
>         a =3D var_eb;
>         a =3D var_ec;
>         a =3D var_b;
> -       a =3D struct1.struct2.u.var_u8;
> +       a =3D struct1[2].struct2[1].u.var_u8[2];
>         a =3D union1.var_u16;
> +       a =3D arr[3];
>

let's add tests for at least:
  a) multi-dimensional arrays
  b) arrays of pointers (that's unlikely to happen in practice, but
still, we should avoid just messing stuff up silently). We can also
explicitly error out on pointers, I suppose.
  c) what about using enums as indices?
  d) can we have some typedef'ed types both with array-based and
direct accesses (to validate we skipped typedefs where appropriate)

I'd suggest splitting selftests from veristat changes. They are in the
same selftests/bpf directory, but conceptually they are tool vs tests
patches, so better kept separate, IMO.

pw-bot: cr

>         return a;
>  }
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index b2bb20b00952..79c5ea6476ca 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -1379,7 +1379,7 @@ static int append_var_preset(struct var_preset **pr=
esets, int *cnt, const char *
>         memset(cur, 0, sizeof(*cur));
>         (*cnt)++;
>
> -       if (sscanf(expr, "%s =3D %s %n", var, val, &n) !=3D 2 || n !=3D s=
trlen(expr)) {
> +       if (sscanf(expr, "%[][a-zA-Z0-9_.] =3D %s %n", var, val, &n) !=3D=
 2 || n !=3D strlen(expr)) {
>                 fprintf(stderr, "Failed to parse expression '%s'\n", expr=
);
>                 return -EINVAL;
>         }
> @@ -1486,6 +1486,39 @@ static bool is_preset_supported(const struct btf_t=
ype *t)
>         return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
>  }
>
> +static int adjust_array_secinfo(const struct btf *btf, const struct btf_=
type *t,
> +                               struct btf_var_secinfo *sinfo, const char=
 *var)
> +{
> +       struct btf_array *barr;
> +       const struct btf_type *type;
> +       char arr[64], idx[64];
> +       int i =3D 0, tid;
> +
> +       if (!btf_is_array(t))
> +               return 0;

this shouldn't be called for non-array, no? if yes, then we should
either drop unnecessary safety check or error out

> +
> +       barr =3D btf_array(t);
> +       tid =3D btf__resolve_type(btf, barr->type);
> +       type =3D btf__type_by_id(btf, tid);
> +
> +       /* var may contain chained expression e.g.: foo[1].bar */

this feels a bit hacky that we re-parse those string specifiers...
maybe we should parse them once, prepare some structured
representation such that the rest of the code can easily check whether
each access is array or non-array, and have parsed index number for
arrays

> +       if (sscanf(var, "%[a-zA-Z0-9_][%[a-zA-Z0-9]]", arr, idx) !=3D 2) =
{
> +               fprintf(stderr, "Could not parse array expression %s\n", =
var);
> +               return -EINVAL;
> +       }
> +       errno =3D 0;
> +       i =3D strtol(idx, NULL, 0);
> +       if (errno || i < 0 || i >=3D barr->nelems) {
> +               fprintf(stderr, "Preset index %s is invalid or out of bou=
nds [0, %d]\n",
> +                       idx, barr->nelems);
> +               return -EINVAL;
> +       }
> +       sinfo->size =3D type->size;

hm... what if type is another array? we need to calculate the size
properly, not just take type->size directly. Or what if it's a pointer
type and type->size is actually type->type?

> +       sinfo->type =3D tid;
> +       sinfo->offset +=3D i * type->size;
> +       return 0;
> +}
> +
>  const int btf_find_member(const struct btf *btf,
>                           const struct btf_type *parent_type,
>                           __u32 parent_offset,
> @@ -1493,7 +1526,7 @@ const int btf_find_member(const struct btf *btf,
>                           int *member_tid,
>                           __u32 *member_offset)
>  {
> -       int i;
> +       int i, err;
>
>         if (!btf_is_composite(parent_type))
>                 return -EINVAL;
> @@ -1511,8 +1544,12 @@ const int btf_find_member(const struct btf *btf,
>                 member_type =3D btf__type_by_id(btf, tid);
>                 if (member->name_off) {
>                         const char *name =3D btf__name_by_offset(btf, mem=
ber->name_off);
> +                       int name_len =3D strlen(name);
>
> -                       if (strcmp(member_name, name) =3D=3D 0) {
> +                       if (strcmp(member_name, name) =3D=3D 0 ||
> +                           (btf_is_array(member_type) &&
> +                            strncmp(name, member_name, name_len) =3D=3D =
0 &&
> +                            member_name[name_len] =3D=3D '[')) {

It looks like you are trying to do too much here at the same time...
Why not handle array case separately and explicitly? And we can
provide a nice message if array vs non-array access is detected

Let's also restructure btf_find_member loop logic a bit to reduce nestednes=
s:

const char *name =3D ...;

if (name[0] =3D=3D '\0' && btf_is_composite(...)) { /* anon struct/union */
    /* recur btf_find_member in hope to find a match */
    ...
} else if (name[0] && btf_is_array(member_type)) {
    /* if member_name is *NOT* blah[something] - nice error, exit with
-EINVAL */
    ... new array element-specific logic
} else if (name[0]) {
    /* if member_name *IS* blah[something] - nice error, exit with -EINVAL =
*/
    ... old logic ...
}


BTW, we should probably use -ESRCH to specify "we didn't find match"
(and that's ok, we keep backtracking) vs -EINVAL due to array vs
non-array mismatch or bitfield usage. The latter are real error
conditions, while the former should be silently ignored.


>                                 if (btf_member_bitfield_size(parent_type,=
 i) !=3D 0) {
>                                         fprintf(stderr, "Bitfield presets=
 are not supported %s\n",
>                                                 name);
> @@ -1520,6 +1557,16 @@ const int btf_find_member(const struct btf *btf,
>                                 }
>                                 *member_offset =3D parent_offset + member=
->offset;
>                                 *member_tid =3D tid;
> +                               if (btf_is_array(member_type)) {
> +                                       struct btf_var_secinfo sinfo =3D =
{.offset =3D 0};
> +
> +                                       err =3D adjust_array_secinfo(btf,=
 member_type,
> +                                                                  &sinfo=
, member_name);
> +                                       if (err)
> +                                               return err;
> +                                       *member_tid =3D sinfo.type;
> +                                       *member_offset +=3D sinfo.offset =
* 8;
> +                               }
>                                 return 0;
>                         }
>                 } else if (btf_is_composite(member_type)) {
> @@ -1548,6 +1595,13 @@ static int adjust_var_secinfo(struct btf *btf, con=
st struct btf_type *t,
>         snprintf(expr, sizeof(expr), "%s", var);
>         strtok_r(expr, ".", &saveptr);
>
> +       if (btf_is_array(base_type)) {
> +               err =3D adjust_array_secinfo(btf, base_type, sinfo, var);
> +               if (err)
> +                       return err;
> +               base_type =3D btf__type_by_id(btf, sinfo->type);
> +       }
> +
>         while ((name =3D strtok_r(NULL, ".", &saveptr))) {
>                 err =3D btf_find_member(btf, base_type, 0, name, &member_=
tid, &member_offset);
>                 if (err) {
> @@ -1673,7 +1727,8 @@ static int set_global_vars(struct bpf_object *obj, =
struct var_preset *presets, i
>
>                                 if (strncmp(var_name, presets[k].name, va=
r_len) !=3D 0 ||
>                                     (presets[k].name[var_len] !=3D '\0' &=
&
> -                                    presets[k].name[var_len] !=3D '.'))
> +                                    presets[k].name[var_len] !=3D '.' &&
> +                                    presets[k].name[var_len] !=3D '['))
>                                         continue;
>
>                                 if (presets[k].applied) {
> --
> 2.49.0
>

