Return-Path: <bpf+bounces-54861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E89A74ED1
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C8F188CC58
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 17:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455D1DE2D8;
	Fri, 28 Mar 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvzcLega"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F6F1DC9B4
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181411; cv=none; b=FShY26Ze8VpYLFukQcCmNh6WNJpHpiGVoxGjFxXzEyCBVYGnjwAkEOGiKcO/nfreYKfpO0vC92N07zU+pIPhFjCkW41krY+5t4J6zCaxSBRfZuXH5iwUo4aWXy+vBW9wJPfKdAg+ZVdGTWw4ACcFYRxBHAU1L6igy7YwK6pZcpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181411; c=relaxed/simple;
	bh=RNUBkKFfqhKT8XNi/zHb1HajQYdZaLcVuBks4BdTk2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elKFlghiquaOKDyUyb/kiUQfPrRnNMQssA5oVJjBRBqDYWaFyG8cWpWe46tt7gEWTodbuFy/T7qtGoBXro/rT58Y+llZIGIwQYBDzmIGQQ6HiXrnLTwoQYo01IGL9+TTZRSiZ3XWxkjVQKt/C9hZZAUlee16UJsqlrdkTjvE2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvzcLega; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30332dfc821so3641848a91.3
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181408; x=1743786208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1h/JmscYeIO0jC3tVe4RzGbQ1H3aySpHBK0PG+QmPU=;
        b=cvzcLegaUlWfUPWiXzRQqYYnaHwkadoc8cKMWsmmCVd0A1w2MFbsVU21vQi9bTEYES
         BzGKS+MA67C0EK8ec+zRxG/u9ZoAel0wyNQw6EF0Kg65o0XBtBlvFrXwEA+D5UPBhZmO
         ObkE8uGlmpzr0kPvTU4OmUP5pzn1oOw0wrMXPwzhRjLt1yaH8P/sTfN3rNQzA2PrlYIY
         vyJJdv9oU11Zqb87SeZHSMYlXEETCE8NAqHxZMImnmesw9cExyjqhTf2B7fiOSdaA30X
         VoQVIx2ChvYszKKUZ7sX5c46AEg05mIpj7+udm+KlrPZv8yT+tN4brGlNag4T+l285XJ
         /oKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181408; x=1743786208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1h/JmscYeIO0jC3tVe4RzGbQ1H3aySpHBK0PG+QmPU=;
        b=q/Tzq5UpthG3b//IgqL9bRkk8v84qla23QyqFQpXgn5kN473Qph3LEKuTbQAqFIsdW
         H5KVCyN77YxW5/0Wi1M3PD1WwpJW/GNFM9VtaprMVfQhsKNG+Skr3WoQGSn8KLJH+xgO
         bfGnr+B5zORnVu03M9QWobAN8byt/HatWTUVftjwA07kc/vioRcC3KE6H1IZjYl8DVCR
         gz1uDx6L5dmASew8hdWZyYWf8zk0x7ycYXqb0LQ8dLM5IjTFxKUoSTQ5JFlVQUdrPKqZ
         kAS8ajlHqOVmkme3U1RmA7mSriPOa99z1+iBGHSHnp3IQGVkH8erpPozjTwF0tdsGKcm
         NFrg==
X-Gm-Message-State: AOJu0YxnZCBUzB7ZB5ryTzrtgHQOAAGg4Mop08V5Z5lGOFoU4RzBgSNs
	5+0rB0tmgskApz43FGJlvjjCJGB28gNAu982euQhFj0SNQVpe9UOpM13Xwq4Yo8U5ljvGS77O15
	MR9fep8eZm1ZXLtcO11JDluao15Q=
X-Gm-Gg: ASbGncsrkciWPcBRpOW06xXHvbykN0gBDXLbD7g4q6cFCO1uPvet5meCx/zWjEOHDSw
	uUBslUPyaoX9pXHm1cxSbfGfez/EgZ4iPqrDkOA2jpJwEkr1ccJcy8FczX+W8D2DGI6GKqHEF7a
	aw1uWPIWASsoPZujtqTaF2apGWZgSKkQfnAHhR/xOJ5g7NumXkCapC
X-Google-Smtp-Source: AGHT+IGErtb/It/C0g7PmwMt/Pixy8d1UWMTBoFxlP9i9GDPmbS5IYaEW6y8bF6nodxirvxPoZAd4Ni+JYY2iCx3Ids=
X-Received: by 2002:a17:90b:274e:b0:2fa:15ab:4df5 with SMTP id
 98e67ed59e1d1-303a916a5b8mr11508274a91.34.1743181408345; Fri, 28 Mar 2025
 10:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324123455.35888-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250324123455.35888-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Mar 2025 10:03:16 -0700
X-Gm-Features: AQ5f1Jo3klT-Z3LSWljYB35tztcSxhVV5_bZqxZGblns5RssxqNJ6AkV112PCLw
Message-ID: <CAEf4BzYhD=kEUfA-_mQS4=5LETvGOtgAe2zLKEaU6f5dY14dHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: support struct/union presets
 in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 5:35=E2=80=AFAM Mykyta Yatsenko
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
>  .../selftests/bpf/progs/set_global_vars.c     |  39 +++++
>  tools/testing/selftests/bpf/veristat.c        | 141 +++++++++++++++++-
>  4 files changed, 178 insertions(+), 8 deletions(-)
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
> index 9adb5ba4cd4d..0259d290d5f2 100644
> --- a/tools/testing/selftests/bpf/progs/set_global_vars.c
> +++ b/tools/testing/selftests/bpf/progs/set_global_vars.c
> @@ -24,6 +24,42 @@ const volatile enum Enumu64 var_eb =3D EB1;
>  const volatile enum Enums64 var_ec =3D EC1;
>  const volatile bool var_b =3D false;
>
> +struct Struct {
> +       int:16;
> +       __u16 filler;
> +       struct {
> +               __u16 filler2;
> +       };
> +       struct Struct2 {
> +               __u16 filler;
> +               volatile struct {
> +                       __u32 filler2;
> +                       union {
> +                               const volatile __u8 var_u8;
> +                               const volatile __s16 filler3;
> +                       } u;
> +               };
> +       } struct2;
> +};
> +const volatile __u32 struc =3D 0; /* same prefix as below */
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
> @@ -43,5 +79,8 @@ int test_set_globals(void *ctx)
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
> index a18972ffdeb6..4fb52767ea73 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -23,6 +23,7 @@
>  #include <float.h>
>  #include <math.h>
>  #include <limits.h>
> +#include <linux/err.h>

this is kernel-internal header (not UAPI), so we won't have it in
Github; let's avoid adding this

>
>  #ifndef ARRAY_SIZE
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> @@ -1486,7 +1487,124 @@ static bool is_preset_supported(const struct btf_=
type *t)
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
> +const struct btf_member *btf_find_member(const struct btf *btf,
> +                                        const struct btf_type *parent_ty=
pe,
> +                                        const char *member_name,
> +                                        __u32 *anon_offset)
> +{
> +       struct btf_anon_stack *anon_stack;
> +       const struct btf_member *retval =3D NULL;
> +       __u32 cur_offset =3D 0;
> +       const char *name;
> +       int top =3D 0, i;
> +
> +       if (!btf_is_struct(parent_type) && !btf_is_union(parent_type))

we have btf_is_composite() which does exactly this

> +               return ERR_PTR(-EINVAL);
> +
> +       anon_stack =3D malloc(sizeof(*anon_stack));
> +       if (!anon_stack)
> +               return ERR_PTR(-ENOMEM);
> +
> +       anon_stack[top].type =3D parent_type;
> +       anon_stack[top++].offset =3D 0;
> +
> +       do {
> +               parent_type =3D anon_stack[--top].type;
> +               cur_offset =3D anon_stack[top].offset;
> +
> +               for (i =3D 0; i < btf_vlen(parent_type); ++i) {
> +                       const struct btf_member *member;
> +                       const struct btf_type *member_type;
> +                       int member_tid;
> +
> +                       member =3D btf_members(parent_type) + i;
> +                       member_tid =3D  btf__resolve_type(btf, member->ty=
pe);
> +                       if (member_tid < 0) {
> +                               retval =3D ERR_PTR(-EINVAL);
> +                               goto out;
> +                       }
> +                       member_type =3D btf__type_by_id(btf, member_tid);
> +                       if (member->name_off) {
> +                               name =3D btf__name_by_offset(btf, member-=
>name_off);
> +                               if (name && strcmp(member_name, name) =3D=
=3D 0) {

let's assume valid BTF and not do these unnecessary name !=3D NULL
checks, we don't do it in many other places anyways

> +                                       *anon_offset =3D cur_offset;
> +                                       retval =3D member;
> +                                       goto out;
> +                               }
> +                       } else if (btf_is_struct(member_type) || btf_is_u=
nion(member_type)) {
> +                               struct btf_anon_stack *tmp;
> +                               /* Anonymous union/struct: push to stack =
*/
> +                               tmp =3D realloc(anon_stack, (top + 1) * s=
izeof(*anon_stack));
> +                               if (!tmp) {
> +                                       retval =3D ERR_PTR(-ENOMEM);
> +                                       goto out;
> +                               }
> +                               anon_stack =3D tmp;
> +                               anon_stack[top].type =3D member_type;
> +                               anon_stack[top++].offset =3D cur_offset +=
 member->offset;
> +                       }
> +               }
> +       } while (top > 0);
> +out:
> +       free(anon_stack);
> +       return retval;
> +}
> +

why all this dynamic mem allocation for stack? this is user space
code, we have recursion, let's use the benefits of user space here

pw-bot: cr

> +static int adjust_var_secinfo_tok(char **name_tok, const struct btf *btf=
,
> +                                 const struct btf_type *t, struct btf_va=
r_secinfo *sinfo)
> +{
> +       char *name =3D strtok_r(NULL, ".", name_tok);
> +       const struct btf_type *member_type;
> +       const struct btf_member *member;
> +       int member_tid;
> +       __u32 anon_offset =3D 0;
> +
> +       if (!name)
> +               return 0;
> +
> +       member =3D btf_find_member(btf, t, name, &anon_offset);
> +       if (IS_ERR(member)) {

why using ERR_PTR approach here if you don't really propagate error code?

I'd say instead of returning btf_member, I'd return containing BTF
type ID and member index within it (plus the offset you are returning)

This way you can take advantage of btf_member_bit_offset() and
btf_member_bitfield_size() helpers provided by libbpf in btf.h

and given you have multiple outputs, it's probably easier to return
int error code (or zero on success), and then everything else as out
parameters by pointer (instead of all the ERR_PTR business)

> +               fprintf(stderr, "Could not find member %s\n", name);
> +               return -EINVAL;
> +       }
> +
> +       member_tid =3D btf__resolve_type(btf, member->type);
> +       member_type =3D btf__type_by_id(btf, member_tid);
> +
> +       if (btf_kflag(t)) {
> +               fprintf(stderr, "Bitfield presets are not supported %s\n"=
, name);
> +               return -EINVAL;
> +       }
> +       sinfo->offset +=3D (member->offset + anon_offset) / 8;
> +       sinfo->size =3D member_type->size;
> +       sinfo->type =3D member_tid;
> +
> +       return adjust_var_secinfo_tok(name_tok, btf, member_type, sinfo);

tbh, not a big fan of this recursion on tokenizer itself... Why can't
there be an outer loop to get tokens one at a time, and then recursive
btf_find_member() logic inside the loop to find offset and type
information?

Ultimately you need to find one offset and one type, corresponding to
the last member in the `a.b.c.d.e.f` chain, right? There is no
backtracking here, overall (the only backtracking will be hidden
inside btf_find_member due to anonymous fields), so the process is a
simple loop. There is no need to employ recursion, imo (unless I'm
missing some nuance).

Let's keep it simple(r).

> +}
> +
> +static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
> +                             struct btf_var_secinfo *sinfo, const char *=
var)
> +{
> +       char expr[256], *saveptr;
> +       const struct btf_type *base_type;
> +       int err;
> +
> +       base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, t->type=
));
> +       strncpy(expr, var, 256);
> +       strtok_r(expr, ".", &saveptr);
> +       err =3D adjust_var_secinfo_tok(&saveptr, btf, base_type, sinfo);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +static int set_global_var(struct bpf_object *obj, struct btf *btf,
>                           struct bpf_map *map, struct btf_var_secinfo *si=
nfo,
>                           struct var_preset *preset)
>  {
> @@ -1495,9 +1613,9 @@ static int set_global_var(struct bpf_object *obj, s=
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
> @@ -1530,7 +1648,7 @@ static int set_global_var(struct bpf_object *obj, s=
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
> @@ -1590,7 +1708,12 @@ static int set_global_vars(struct bpf_object *obj,=
 struct var_preset *presets, i
>                         var_name =3D btf__name_by_offset(btf, var_type->n=
ame_off);
>
>                         for (k =3D 0; k < npresets; ++k) {
> -                               if (strcmp(var_name, presets[k].name) !=
=3D 0)
> +                               struct btf_var_secinfo tmp_sinfo;
> +                               int var_len =3D strlen(var_name);

do this once outside of the loop, why recalculating on each iteration?

> +
> +                               if (strncmp(var_name, presets[k].name, va=
r_len) !=3D 0 ||
> +                                   (presets[k].name[var_len] !=3D '\0' &=
&
> +                                    presets[k].name[var_len] !=3D '.'))
>                                         continue;
>
>                                 if (presets[k].applied) {
> @@ -1598,13 +1721,17 @@ static int set_global_vars(struct bpf_object *obj=
, struct var_preset *presets, i
>                                                 var_name);
>                                         return -EINVAL;
>                                 }
> +                               memcpy(&tmp_sinfo, sinfo, sizeof(*sinfo))=
;
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
> 2.48.1
>

