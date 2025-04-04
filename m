Return-Path: <bpf+bounces-55349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BBDA7C345
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A759189FE48
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD80820ADE9;
	Fri,  4 Apr 2025 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAlLqxfX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9949BE4A
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743791960; cv=none; b=Pls5cKZWlx8umhVGUS3kCjyt2Py8/B8Be0VyrYOJp9p50ueiUnE51TzM3fqPcZ/u14D7N6WN9K8U86b2O/9ItorfwaO/q1VXuwCeJ/FkoZo9DLrPXYr8qkciPaD15fwhHMQU98KmRQ9RW4fONsNt4M/aIfM7txhfkyW358mb5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743791960; c=relaxed/simple;
	bh=8b1BosOHjfrlEqCRpkpBqCKVzNVFUDbGSt86+5TeCGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9NLcp3UmjINAdKSOzkDdfvjd38LStjVMZj7tlhabuyEsBV6PojphY+Xn9GzLnLy/YdYKrheNnvUABcDR/FiSv1zc0535B5XoCXpFMN4wGWl3Slq3qnzV+DBD18aF/4JkmCVliTTpEfrMTuJXQds7nBnNfDKrF5B4i62yTIfTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAlLqxfX; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af5a4cd980dso1751975a12.1
        for <bpf@vger.kernel.org>; Fri, 04 Apr 2025 11:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743791958; x=1744396758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxLYjS9fXzO6HwHR/y/TIO3ME3BkG9wBTRmt7ZXPLJc=;
        b=nAlLqxfXdUHu8VIO+wzdTluuZ93NovGLRsPdmBOXNPO5QLlB4z9mJli/N3iA6B6Qr+
         YYHnjRd4+LQDqSMV1SX+BeNP+lr0nL4xrCZF4044Jg3irjN/3rf71z6EAquWwbzNRW6u
         tKsDMBw/XN2jhk15YTQtnKcG4087eZdOYLxAgPtems4DTpuYBhwpGnZOpmLWvrmm3HV9
         w0tqACSHcCkiGbtzz7cjrH+kNqpIhudclsEVC9xX60a1cqg/Dh6SSj/4sXdz4CPEB8Xe
         H6JSvr7SUEaeCn7b95EYHnxWuvwYocSzw/PMS/qIeNix4IeRzFTSW0kVX9qwmc2bcefa
         NMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743791958; x=1744396758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxLYjS9fXzO6HwHR/y/TIO3ME3BkG9wBTRmt7ZXPLJc=;
        b=lGyS5Oci3QBQBXEZQC1Gv3mpOWvFSKIh3mTLuGQfOtOK+sTxq0p1NrTEhJFDKUiC4e
         zbhJ1d4GrGf/kvoHeg26pwBnKC/ovqc7WVHQ1n2GLdImksqHY0xIkolOQ1rlIjmNXs1c
         8auA/TkUHCqXKB9UYQEmEMGVg1HfSULPSHrJ6cHjatupAOhqBjkRRGUNZdSbnPJdoVYz
         hYxSuAZnhen9NH9nn2E8+SLd7JRmvK8ncr4XKeBplq/6/Moxh1+Ks8LssJ6lEQwk4uKr
         jQ/3UyA+/feJx2amwWgZR/ekRmS86FBj3n1jLb/BTq9iJn1HOgueRyKbBUFsvPS8IOmo
         tGpQ==
X-Gm-Message-State: AOJu0YzJtbcs/Zoqtj6jYnWb7BZkn+irDYPuJHR2f3R2Zt4PSjnRklMa
	YX+hbhWISfHaV/ulEV5sZjqr2MbzdV1iamyj8gzl1XUV+QEFLEZ9AlCvT0s9786c8PbzHNUhNtT
	9NXbErhftYDwFea3xxTL9luAsjbcTwKMl
X-Gm-Gg: ASbGnctp3OWzfTdUeDjyj3xdRdcd2xgVUNE7qqzttktOtHMfcduzqc+gfAp5ZH4DQ6N
	6ztd8KMe5vYqATjsr9L1z30+AcqAtlwDnV9j9jJ3y5JJ6tNdCRhv2+iJMw4f0IjWp48YPso83WK
	5wt7HIQKuJtIRd84+OXM+wVdlwmSh7qVzK77xZ8DKf1w==
X-Google-Smtp-Source: AGHT+IHED0i29lmMfeR+ABBSZcqBGx7wAsIK7xIq/Gw6plT6qhZN79uJ8QK7pABl/Ex8ahd+ztSzqlNiAElh5owB1EI=
X-Received: by 2002:a17:90b:4d0b:b0:2ff:6bd0:ff26 with SMTP id
 98e67ed59e1d1-306af7b7889mr432613a91.34.1743791957663; Fri, 04 Apr 2025
 11:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331211217.201198-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250331211217.201198-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Apr 2025 11:39:05 -0700
X-Gm-Features: ATxdqUHW0yoYbxZm7xXTOWS3fGVEhYF_2gh1MNZuk0RTU-AWrgvUn62mAiXC2BI
Message-ID: <CAEf4BzbD1SP=fv0cG81HBS6Ld_v07f4RXgDDR_EMhEYAkHjx9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: support struct/union presets
 in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 2:12=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Extend commit e3c9abd0d14b ("selftests/bpf: Implement setting global
> variables in veristat") to support applying presets to members of
> the global structs or unions in veristat.
> For example:
> ```
> ./veristat set_global_vars.bpf.o  -G "union1.struct3.var_u8_h =3D 0xBB"
> ```
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../selftests/bpf/prog_tests/test_veristat.c  |   5 +
>  tools/testing/selftests/bpf/progs/prepare.c   |   1 -
>  .../selftests/bpf/progs/set_global_vars.c     |  40 +++++++
>  tools/testing/selftests/bpf/veristat.c        | 106 ++++++++++++++++--
>  4 files changed, 144 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/too=
ls/testing/selftests/bpf/prog_tests/test_veristat.c
> index a95b42bf744a..47b56c258f3f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> @@ -63,6 +63,9 @@ static void test_set_global_vars_succeeds(void)
>             " -G \"var_eb =3D EB2\" "\
>             " -G \"var_ec =3D EC2\" "\
>             " -G \"var_b =3D 1\" "\
> +           " -G \"struct1.struct2.u.var_u8 =3D 170\" "\
> +           " -G \"union1.struct3.var_u8_l =3D 0xaa\" "\
> +           " -G \"union1.struct3.var_u8_h =3D 0xaa\" "\
>             "-vl2 > %s", fix->veristat, fix->tmpfile);
>
>         read(fix->fd, fix->output, fix->sz);
> @@ -78,6 +81,8 @@ static void test_set_global_vars_succeeds(void)
>         __CHECK_STR("_w=3D12 ", "var_eb =3D EB2");
>         __CHECK_STR("_w=3D13 ", "var_ec =3D EC2");
>         __CHECK_STR("_w=3D1 ", "var_b =3D 1");
> +       __CHECK_STR("_w=3D170 ", "struct1.struct2.u.var_u8 =3D 170");
> +       __CHECK_STR("_w=3D0xaaaa ", "union1.var_u16 =3D 0xaaaa");
>
>  out:
>         teardown_fixture(fix);
> diff --git a/tools/testing/selftests/bpf/progs/prepare.c b/tools/testing/=
selftests/bpf/progs/prepare.c
> index 1f1dd547e4ee..cfc1f48e0d28 100644
> --- a/tools/testing/selftests/bpf/progs/prepare.c
> +++ b/tools/testing/selftests/bpf/progs/prepare.c
> @@ -2,7 +2,6 @@
>  /* Copyright (c) 2025 Meta */
>  #include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
> -//#include <bpf/bpf_tracing.h>
>
>  char _license[] SEC("license") =3D "GPL";
>
> diff --git a/tools/testing/selftests/bpf/progs/set_global_vars.c b/tools/=
testing/selftests/bpf/progs/set_global_vars.c
> index 9adb5ba4cd4d..187e9791e72e 100644
> --- a/tools/testing/selftests/bpf/progs/set_global_vars.c
> +++ b/tools/testing/selftests/bpf/progs/set_global_vars.c
> @@ -24,6 +24,43 @@ const volatile enum Enumu64 var_eb =3D EB1;
>  const volatile enum Enums64 var_ec =3D EC1;
>  const volatile bool var_b =3D false;
>
> +struct Struct {
> +       int:16;
> +       __u16 filler;
> +       struct {
> +               const __u16 filler2;
> +       };
> +       struct Struct2 {
> +               __u16 filler;
> +               volatile struct {
> +                       const __u32 filler2;
> +                       union {
> +                               const volatile __u8 var_u8;
> +                               const volatile __s16 filler3;
> +                       } u;
> +               };
> +       } struct2;
> +};
> +
> +const volatile __u32 stru =3D 0; /* same prefix as below */
> +const volatile struct Struct struct1 =3D {.struct2 =3D {.u =3D {.var_u8 =
=3D 1}}};
> +
> +union Union {
> +       __u16 var_u16;
> +       struct Struct3 {
> +               struct {
> +                       __u8 var_u8_l;
> +               };
> +               struct {
> +                       struct {
> +                               __u8 var_u8_h;
> +                       };
> +               };
> +       } struct3;
> +};
> +
> +const volatile union Union union1 =3D {.var_u16 =3D -1};
> +
>  char arr[4] =3D {0};
>
>  SEC("socket")
> @@ -43,5 +80,8 @@ int test_set_globals(void *ctx)
>         a =3D var_eb;
>         a =3D var_ec;
>         a =3D var_b;
> +       a =3D struct1.struct2.u.var_u8;
> +       a =3D union1.var_u16;
> +
>         return a;
>  }
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index a18972ffdeb6..727ef80a1e47 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -1486,7 +1486,89 @@ static bool is_preset_supported(const struct btf_t=
ype *t)
>         return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
>  }
>
> -static int set_global_var(struct bpf_object *obj, struct btf *btf, const=
 struct btf_type *t,
> +struct btf_anon_stack {
> +       const struct btf_type *type;
> +       __u32 offset;
> +};
> +

unused leftover

> +const int btf_find_member(const struct btf *btf,
> +                         const struct btf_type *parent_type,
> +                         __u32 parent_offset,
> +                         const char *member_name,
> +                         int *member_tid,
> +                         __u32 *member_offset)
> +{
> +       int i;
> +
> +       if (!btf_is_composite(parent_type))
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < btf_vlen(parent_type); ++i) {
> +               const struct btf_member *member;
> +               const struct btf_type *member_type;
> +               int tid;
> +
> +               member =3D btf_members(parent_type) + i;
> +               tid =3D  btf__resolve_type(btf, member->type);
> +               if (tid < 0)
> +                       return -EINVAL;
> +
> +               member_type =3D btf__type_by_id(btf, tid);
> +               if (member->name_off) {
> +                       const char *name =3D btf__name_by_offset(btf, mem=
ber->name_off);
> +
> +                       if (strcmp(member_name, name) =3D=3D 0) {
> +                               *member_offset =3D parent_offset + member=
->offset;
> +                               *member_tid =3D tid;
> +                               return 0;
> +                       }
> +               } else if (btf_is_composite(member_type)) {
> +                       int err;
> +
> +                       err =3D btf_find_member(btf, member_type, parent_=
offset + member->offset,
> +                                             member_name, member_tid, me=
mber_offset);
> +                       if (!err)
> +                               return 0;
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
> +                             struct btf_var_secinfo *sinfo, const char *=
var)
> +{
> +       char expr[256], *saveptr;
> +       const struct btf_type *base_type, *member_type;
> +       int err, member_tid;
> +       char *name;
> +       __u32 member_offset =3D 0;
> +
> +       base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, t->type=
));
> +       strncpy(expr, var, 255);
> +       expr[255] =3D '\0';

strncpy() isn't a great API, and compilers have problems
false-reporting non-zero-termination for them. I found that snprintf()
works better

snprintf(expr, sizeof(expr), "%s", var);

?

> +       strtok_r(expr, ".", &saveptr);
> +
> +       while ((name =3D strtok_r(NULL, ".", &saveptr))) {
> +               err =3D btf_find_member(btf, base_type, 0, name, &member_=
tid, &member_offset);
> +               if (err) {
> +                       fprintf(stderr, "Could not find member %s for var=
iable %s\n", name, var);
> +                       return err;
> +               }
> +               if (btf_kflag(base_type)) {

hm... doesn't kflag on, say, STRUCT, just mean that there are *some*
fields that are bitfields? If we don't reference those fields, it
should be fine, no?

So, instead, I think we should just check that
btf_member_bitfield_size() for that field is zero, and if not --
complain.

Can you please also add a test case where we have a struct with
bitfields, but we set only non-bitfield values and it all should work
just fine. Thanks.


pw-bot: cr

> +                       fprintf(stderr, "Bitfield presets are not support=
ed %s\n", name);
> +                       return -EINVAL;
> +               }
> +               member_type =3D btf__type_by_id(btf, member_tid);
> +               sinfo->offset +=3D member_offset / 8;
> +               sinfo->size =3D member_type->size;
> +               sinfo->type =3D member_tid;
> +               base_type =3D member_type;
> +       }
> +       return 0;
> +}
> +
> +static int set_global_var(struct bpf_object *obj, struct btf *btf,
>                           struct bpf_map *map, struct btf_var_secinfo *si=
nfo,
>                           struct var_preset *preset)
>  {
> @@ -1495,9 +1577,9 @@ static int set_global_var(struct bpf_object *obj, s=
truct btf *btf, const struct
>         long long value =3D preset->ivalue;
>         size_t size;
>
> -       base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, t->type=
));
> +       base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, sinfo->=
type));
>         if (!base_type) {
> -               fprintf(stderr, "Failed to resolve type %d\n", t->type);
> +               fprintf(stderr, "Failed to resolve type %d\n", sinfo->typ=
e);
>                 return -EINVAL;
>         }
>         if (!is_preset_supported(base_type)) {
> @@ -1530,7 +1612,7 @@ static int set_global_var(struct bpf_object *obj, s=
truct btf *btf, const struct
>                 if (value >=3D max_val || value < -max_val) {
>                         fprintf(stderr,
>                                 "Variable %s value %lld is out of range [=
%lld; %lld]\n",
> -                               btf__name_by_offset(btf, t->name_off), va=
lue,
> +                               btf__name_by_offset(btf, base_type->name_=
off), value,
>                                 is_signed ? -max_val : 0, max_val - 1);
>                         return -EINVAL;
>                 }
> @@ -1583,14 +1665,20 @@ static int set_global_vars(struct bpf_object *obj=
, struct var_preset *presets, i
>                 for (j =3D 0; j < n; ++j, ++sinfo) {
>                         const struct btf_type *var_type =3D btf__type_by_=
id(btf, sinfo->type);
>                         const char *var_name;
> +                       int var_len;
>
>                         if (!btf_is_var(var_type))
>                                 continue;
>
>                         var_name =3D btf__name_by_offset(btf, var_type->n=
ame_off);
> +                       var_len =3D strlen(var_name);
>
>                         for (k =3D 0; k < npresets; ++k) {
> -                               if (strcmp(var_name, presets[k].name) !=
=3D 0)
> +                               struct btf_var_secinfo tmp_sinfo;
> +
> +                               if (strncmp(var_name, presets[k].name, va=
r_len) !=3D 0 ||
> +                                   (presets[k].name[var_len] !=3D '\0' &=
&
> +                                    presets[k].name[var_len] !=3D '.'))
>                                         continue;
>
>                                 if (presets[k].applied) {
> @@ -1598,13 +1686,17 @@ static int set_global_vars(struct bpf_object *obj=
, struct var_preset *presets, i
>                                                 var_name);
>                                         return -EINVAL;
>                                 }
> +                               memcpy(&tmp_sinfo, sinfo, sizeof(*sinfo))=
;

isn't this just:

tmp_sinfo =3D *sinfo;

why memcpy?

> +                               err =3D adjust_var_secinfo(btf, var_type,
> +                                                        &tmp_sinfo, pres=
ets[k].name);
> +                               if (err)
> +                                       return err;
>
> -                               err =3D set_global_var(obj, btf, var_type=
, map, sinfo, presets + k);
> +                               err =3D set_global_var(obj, btf, map, &tm=
p_sinfo, presets + k);
>                                 if (err)
>                                         return err;
>
>                                 presets[k].applied =3D true;
> -                               break;
>                         }
>                 }
>         }
> --
> 2.49.0
>

