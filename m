Return-Path: <bpf+bounces-8493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622FC787528
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 18:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1771C20EB1
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5958314AA1;
	Thu, 24 Aug 2023 16:22:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E1100C1
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 16:22:05 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDED1BD2
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 09:22:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so134084a12.0
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692894121; x=1693498921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrHZX+nCTUd4GHtskLQ8SGJtG4GZBehDClrr3iIUQm4=;
        b=K0/QK5e23KJ/WENr/lOTV8WTSQkMoCEdiSCYJ1C4EWDbxXUixg7lN1iIE4V9ZeB7U2
         U8pei3SoZGVZpGOD4rqZB/uB6A07BXmqKGjV9WnzBg97yTuOmm23iwyjquGC/qoYhbta
         wkmkYlDR170DeQ6tosWmDsXFpI2Yrv77vVe23Q2CCzRYAg9QFaCkLEyl2te5Ex7ZNlG2
         AjrUbGkcRLAnEqSmBTMR5V7/bjrJz/NopCc90YBe0HC1+YH0HDWkoIyV1WufyZk8bUjd
         WUt9I/T7D+fmM0aMOoCyK9gazXwQyXrZpg4v0j8MiWu8pP9Bf1LZhiJeEXsyZcTnwyWh
         +jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692894121; x=1693498921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrHZX+nCTUd4GHtskLQ8SGJtG4GZBehDClrr3iIUQm4=;
        b=BMdGYheO7ZgCbEs/u0JtNM7OeNT4SOPqUlZEsdaDepubOnoGdFIQMqRHwLHU8VVJG4
         z2H3qfodylzmvyOAk0Tzye4PhRQWYu804tVVSnpfqcCJmzxQHzABDTuEIDpKajEmNsdz
         p4oFnfiY9EUmzkqIylj5tYEMAfLPVTZeqndiBJBpEAPXYWjPkVQcDmzpXlMWf0tK+Bjr
         r0x8dRxufpzNxVfuzYuLhw+C8+iPNong96BwvvhNeYyzNvUu4C4A+f3H2n3R8S0heUgx
         cutYeVGXwZwg8855LYbKtpe1/3BLpQ4OTtc1zImZ0XxdSlpz5W2xWp/5qVt2x8mTga5V
         1emw==
X-Gm-Message-State: AOJu0Yw+jw6L6PkM/uxA0tiZczu/mj6xQs15DQJ2ux0fvcuy4R6xgii7
	YfsKZ8tl1K97HcBZddNyLUPSFkEw3v1cEPVzdJ0=
X-Google-Smtp-Source: AGHT+IG9NSdIO1Zed6Fsux/39A4wiOXtpCWjWbK18x+e4CquN4EkM20xmD4wdFYcpHScwsg63RZ7ZMakHxT77IaQJBc=
X-Received: by 2002:aa7:d4cc:0:b0:522:2711:863 with SMTP id
 t12-20020aa7d4cc000000b0052227110863mr12550536edr.1.1692894121103; Thu, 24
 Aug 2023 09:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823234426.2506685-1-andrii@kernel.org> <a4da3e50153720d8ba437182f66050910d669f05.camel@gmail.com>
In-Reply-To: <a4da3e50153720d8ba437182f66050910d669f05.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Aug 2023 09:21:49 -0700
Message-ID: <CAEf4BzYiR5d_6g+6gsj1Fa_T8Zdan816wAk9OpALawsV=kXocg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add basic BTF sanity validation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-08-23 at 16:44 -0700, Andrii Nakryiko wrote:
> > Implement a simple and straightforward BTF sanity check when loading BT=
F
> > information for BPF ELF file. Right now it's very basic and just
> > validates that all the string offsets and type IDs are within valid
> > range. But even with such simple checks it fixes a bunch of crashes
> > found by OSS fuzzer ([0]-[5]) and will allow fuzzer to make further
> > progress.
> >
> > Some other invariants will be checked in follow up patches (like
> > ensuring there is no infinite type loops), but this seems like a good
> > start already.
> >
> >   [0] https://github.com/libbpf/libbpf/issues/482
> >   [1] https://github.com/libbpf/libbpf/issues/483
> >   [2] https://github.com/libbpf/libbpf/issues/485
> >   [3] https://github.com/libbpf/libbpf/issues/613
> >   [4] https://github.com/libbpf/libbpf/issues/618
> >   [5] https://github.com/libbpf/libbpf/issues/619
> >
> > Closes: https://github.com/libbpf/libbpf/issues/617
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/btf.c             | 146 ++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.c          |   7 ++
> >  tools/lib/bpf/libbpf_internal.h |   2 +
> >  3 files changed, 155 insertions(+)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 8484b563b53d..5f23df94861e 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1155,6 +1155,152 @@ struct btf *btf__parse_split(const char *path, =
struct btf *base_btf)
> >       return libbpf_ptr(btf_parse(path, base_btf, NULL));
> >  }
> >
> > +static int btf_validate_str(const struct btf *btf, __u32 str_off, cons=
t char *what, __u32 type_id)
> > +{
> > +     const char *s;
> > +
> > +     s =3D btf__str_by_offset(btf, str_off);
> > +     if (!s) {
> > +             pr_warn("btf: type [%u]: invalid %s (string offset %u)\n"=
, type_id, what, str_off);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int btf_validate_id(const struct btf *btf, __u32 id, __u32 ctx_=
id)
> > +{
> > +     const struct btf_type *t;
> > +
> > +     t =3D btf__type_by_id(btf, id);
> > +     if (!t) {
> > +             pr_warn("btf: type [%u]: invalid referenced type ID %u\n"=
, ctx_id, id);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int btf_validate_type(const struct btf *btf, const struct btf_t=
ype *t, __u32 id)
> > +{
> > +     __u32 kind =3D btf_kind(t);
> > +     int err, i, n;
> > +
> > +     err =3D btf_validate_str(btf, t->name_off, "type name", id);
> > +     if (err)
> > +             return err;
> > +
> > +     switch (kind) {
> > +     case BTF_KIND_UNKN:
> > +     case BTF_KIND_INT:
> > +     case BTF_KIND_FWD:
> > +     case BTF_KIND_FLOAT:
> > +             break;
> > +     case BTF_KIND_PTR:
> > +     case BTF_KIND_TYPEDEF:
> > +     case BTF_KIND_VOLATILE:
> > +     case BTF_KIND_CONST:
> > +     case BTF_KIND_RESTRICT:
> > +     case BTF_KIND_FUNC:
> > +     case BTF_KIND_VAR:
> > +     case BTF_KIND_DECL_TAG:
> > +     case BTF_KIND_TYPE_TAG:
> > +             err =3D btf_validate_id(btf, t->type, id);
> > +             if (err)
> > +                     return err;
> > +             break;
> > +     case BTF_KIND_ARRAY: {
> > +             const struct btf_array *a =3D btf_array(t);
> > +
> > +             err =3D btf_validate_id(btf, a->index_type, id);
>
> `a->index_type` should probably be `a->type` here, otherwise these two
> checks are identical.

copy/paste error, nice catch, will fix

>
> > +             err =3D err ?: btf_validate_id(btf, a->index_type, id);
> > +             if (err)
> > +                     return err;
> > +             break;
> > +     }
> > +     case BTF_KIND_STRUCT:
> > +     case BTF_KIND_UNION: {
> > +             const struct btf_member *m =3D btf_members(t);
> > +
> > +             n =3D btf_vlen(t);
> > +             for (i =3D 0; i < n; i++, m++) {
> > +                     err =3D btf_validate_str(btf, m->name_off, "field=
 name", id);
> > +                     err =3D err ?: btf_validate_id(btf, m->type, id);
> > +                     if (err)
> > +                             return err;
> > +             }
> > +             break;
> > +     }
> > +     case BTF_KIND_ENUM: {
> > +             const struct btf_enum *m =3D btf_enum(t);
> > +
> > +             n =3D btf_vlen(t);
> > +             for (i =3D 0; i < n; i++, m++) {
> > +                     err =3D btf_validate_str(btf, m->name_off, "enum =
name", id);
> > +                     if (err)
> > +                             return err;
> > +             }
> > +             break;
> > +     }
> > +     case BTF_KIND_ENUM64: {
> > +             const struct btf_enum64 *m =3D btf_enum64(t);
> > +
> > +             n =3D btf_vlen(t);
> > +             for (i =3D 0; i < n; i++, m++) {
> > +                     err =3D btf_validate_str(btf, m->name_off, "enum =
name", id);
> > +                     if (err)
> > +                             return err;
> > +             }
> > +             break;
> > +     }
> > +     case BTF_KIND_FUNC_PROTO: {
> > +             const struct btf_param *m =3D btf_params(t);
> > +
> > +             n =3D btf_vlen(t);
> > +             for (i =3D 0; i < n; i++, m++) {
> > +                     err =3D btf_validate_str(btf, m->name_off, "param=
 name", id);
>
> Maybe check `m->type` here as well?

of course, I suspected I missed something obvious :)

>
> > +                     if (err)
> > +                             return err;
> > +             }
> > +             break;
> > +     }
> > +     case BTF_KIND_DATASEC: {
> > +             const struct btf_var_secinfo *m =3D btf_var_secinfos(t);
> > +
> > +             n =3D btf_vlen(t);
> > +             for (i =3D 0; i < n; i++, m++) {
> > +                     err =3D btf_validate_id(btf, m->type, id);
> > +                     if (err)
> > +                             return err;
> > +             }
> > +             break;
> > +     }
> > +     default:
> > +             pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kin=
d);
> > +             return -EINVAL;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/* Validate basic sanity of BTF. It's intentionally less thorough than
> > + * kernel's validation and validates only properties of BTF that libbp=
f relies
> > + * on to be correct (e.g., valid type IDs, valid string offsets, etc)
> > + */
> > +int btf_sanity_check(const struct btf *btf)
> > +{
> > +     const struct btf_type *t;
> > +     __u32 i, n =3D btf__type_cnt(btf);
> > +     int err;
> > +
> > +     for (i =3D 1; i < n; i++) {
> > +             t =3D btf_type_by_id(btf, i);
> > +             err =3D btf_validate_type(btf, t, i);
> > +             if (err)
> > +                     return err;
> > +     }
> > +     return 0;
> > +}
> > +
> >  static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool=
 swap_endian);
> >
> >  int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz=
, __u32 log_level)
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4c3967d94b6d..71a3c768d9af 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -2833,6 +2833,13 @@ static int bpf_object__init_btf(struct bpf_objec=
t *obj,
> >                       pr_warn("Error loading ELF section %s: %d.\n", BT=
F_ELF_SEC, err);
> >                       goto out;
> >               }
> > +             err =3D btf_sanity_check(obj->btf);
> > +             if (err) {
> > +                     pr_warn("elf: .BTF data is corrupted, discarding =
it...\n");
> > +                     btf__free(obj->btf);
> > +                     obj->btf =3D NULL;
> > +                     goto out;
> > +             }
> >               /* enforce 8-byte pointers for BPF-targeted BTFs */
> >               btf__set_pointer_size(obj->btf, 8);
> >       }
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_int=
ernal.h
> > index f0f08635adb0..5e715a2d48f2 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -76,6 +76,8 @@
> >  #define BTF_TYPE_TYPE_TAG_ENC(value, type) \
> >       BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 0, 0), type)
> >
> > +int btf_sanity_check(const struct btf *btf);
> > +
> >  #ifndef likely
> >  #define likely(x) __builtin_expect(!!(x), 1)
> >  #endif
>

