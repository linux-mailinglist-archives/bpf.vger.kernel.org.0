Return-Path: <bpf+bounces-8681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E20788F0B
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 20:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B3D281625
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096618B0F;
	Fri, 25 Aug 2023 18:59:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1905EEC1
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 18:59:48 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F792135
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:59:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so2744326a12.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692989981; x=1693594781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhcTRX6TZoqWcemK+NQ0sZ1eISlUPtVPprLueKkLihg=;
        b=YzDjJvwptHaTKn7VVackfAk4CjmA+1PtrVmo5QEOdsE8w5Iv5WJH2KQSwUaHT8dOEQ
         chsrxHZdypxd4yHr6xMJOu5qy38y33T6cuQ+zqwaoiBHVDlppeehpsA0jOZsujDVBkCW
         Pxak5JSF380Hs3dRgfKN0m/V+CZ1BBQduijoGz6ExAg3uUmzsJueTbIZtxushdT9t4vJ
         fok+WZDKDjB1zyT6R+NpEDYtAwqv58gaMamm9AcuqZh+1j1PkFcvPFecJSEa6X7vjNZq
         /BOtG+4LnHRigxMpp3C+ZXY2TJrcGNlJHFUSMhy1R4fV/PBIHhXkxF98MoaPSoG3bXNt
         ZZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692989981; x=1693594781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhcTRX6TZoqWcemK+NQ0sZ1eISlUPtVPprLueKkLihg=;
        b=kqoCwzRC0xDe/+nTn+JZZM4tGJaiKASGvYzTK3+mT9AApcaefLENk7haCI9SaeVPak
         K2MLXheIz6Mi1/+xkbeJ11ZhBqFOeAW6NUV31SsNI3lyHI+MZt064MFPx1PhhaCKTXbA
         +2rEoNc0WYtYJs6qUoiNBMpIhgHsBnhcco3pzJLsi4qj6QLUbloPoVfTmVz2Y9s3Qj86
         XBzxz6Otr+tVBUxFLe1hGyuoaIwTbAgaU68o+h2MHGuhup6lIqYTDE/JinLE/sj1Bz6I
         rk1Ykh6eY8noePPGdUn+6uPveBlOKKDf8m/G9vKTKzXeZAqIFDN7nYsPK/Xd6+2eolQG
         S2HA==
X-Gm-Message-State: AOJu0YyHjQuXhaakzQSxbvVKiU2jr0AgWOdEtz9ZtiVDMaTRXbbS5rlV
	1CkCQVYy9tZbAELjrOEGqhYak+94PkLcrr140nw=
X-Google-Smtp-Source: AGHT+IGiFEXd9KI0iBOLC1SSsJiOT2EW7m95hWPsUaFZYBv3gDHkdcf0pzrn43wdrPf0+hgvBPir0U799bwrw/aVMNY=
X-Received: by 2002:aa7:d985:0:b0:52a:38c3:1b4b with SMTP id
 u5-20020aa7d985000000b0052a38c31b4bmr8857085eds.15.1692989980764; Fri, 25 Aug
 2023 11:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824201358.1395122-1-andrii@kernel.org> <5af91869-61ff-c3cf-c292-c8f10accd4fc@oracle.com>
In-Reply-To: <5af91869-61ff-c3cf-c292-c8f10accd4fc@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Aug 2023 11:59:29 -0700
Message-ID: <CAEf4BzZYKg-VgDHLmr3zncwGMN6-voQGQh8gD81=LL+ryFgM=g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: add basic BTF sanity validation
To: Alan Maguire <alan.maguire@oracle.com>
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

On Fri, Aug 25, 2023 at 1:46=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 24/08/2023 21:13, Andrii Nakryiko wrote:
> > Implement a simple and straightforward BTF sanity check when parsing BT=
F
> > data. Right now it's very basic and just validates that all the string
> > offsets and type IDs are within valid range. But even with such simple
> > checks it fixes a bunch of crashes found by OSS fuzzer ([0]-[5]) and
> > will allow fuzzer to make further progress.
> >
> > Some other invariants will be checked in follow up patches (like
> > ensuring there is no infinite type loops), but this seems like a good
> > start already.
> >
> > v1->v2:
> >   - fix array index_type vs type copy/paste error (Eduard);
> >   - add type ID check in FUNC_PROTO validation (Eduard);
> >   - move sanity check to btf parsing time (Martin).
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
>
> few small suggestions that could be in followups if needed, so
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> > ---
> >  tools/lib/bpf/btf.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 148 insertions(+)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 8484b563b53d..28905539f045 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -448,6 +448,153 @@ static int btf_parse_type_sec(struct btf *btf)
> >       return 0;
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
>
> might be worth having a self-reference test here to ensure ctx_id !=3D id=
.

I mentioned in the commit message that determining "structural sanity"
is on TODO list, and this would be a very simplistic partial case of
that. So instead of adding extra check here, I'll postpone it until
proper check is added, if that's ok?

>
> > +     t =3D btf__type_by_id(btf, id);
> > +     if (!t) {
> > +             pr_warn("btf: type [%u]: invalid referenced type ID %u\n"=
, ctx_id, id);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > + > +static int btf_validate_type(const struct btf *btf, const struct
> btf_type *t, __u32 id)
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
>
> would it be worth doing an additional check here that t->type for
> BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO? I think that's the only case where
> BTF mandates the kind of the target is a specific kind, so might be
> worth checking. I initially thought passing an expected kind to
> btf_validate_id() might make sense, but given that there's only one case
> we have a specific expectation that seemed unnecessary.
>

yep, checking for FUNC -> FUNC_PROTO makes total sense, I'll add that
in the next revision, thanks!

>
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
> > +             err =3D btf_validate_id(btf, a->type, id);
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
> > +                     err =3D err ?: btf_validate_id(btf, m->type, id);
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
> > +static int btf_sanity_check(const struct btf *btf)
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
> >  __u32 btf__type_cnt(const struct btf *btf)
> >  {
> >       return btf->start_id + btf->nr_types;
> > @@ -902,6 +1049,7 @@ static struct btf *btf_new(const void *data, __u32=
 size, struct btf *base_btf)
> >
> >       err =3D btf_parse_str_sec(btf);
> >       err =3D err ?: btf_parse_type_sec(btf);
> > +     err =3D err ?: btf_sanity_check(btf);
> >       if (err)
> >               goto done;
> >
>
> While we usually load vmlinux BTF from /sys/kernel/btf, we fall back to
> a set of on-disk locations. Specifically in btf__load_vmlinux_btf(), for
> the case where the array index > 0, it might be worth sanity-checking
> BTF there too.
>

So I added this btf_sanity_check() into btf_new() which is used from
all the variants of btf__parse, btf__load_from_kernel, btf__parse_raw.
So I think this is already covered?

> Thanks!
>
> Alan

