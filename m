Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD43567D02
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 06:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiGFERE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 00:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiGFERD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 00:17:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C11F2CD
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 21:17:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q6so24858724eji.13
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 21:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S6BC3ik4w2vl1Y6MeALLXABJk2DUS523iaPqHu0V4BE=;
        b=SBvLopoQYfzopBcMQQZTaCX7TQ4PH31tebjlJYPr/yafuAQq1CzqgVUnZzMgBthiSq
         fdLTJvqZU69/N8/0RwIUjpdpcANYQiYzuXj09sZZiWGjw1WcZOablnZA7/4y3Acz7KSI
         SaMQXtHIkg0o+Ypidb8TTia3m9h0uqGKredUEHQ0aag4WNAIdpPMX00bZr7wVzKXeQhQ
         ebN6oMVnP/2FGUNJEaS9Iul4GyoHMmndN1cJWCUGtUtLO1O/M6X36oxYjBOwPxvdknpb
         g+yI+zF36DU9VU2IlpV7xk5VedfEC79+J/pRcvJqtRui/xcPdzMArXH0aHtkUncBnkDB
         cj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S6BC3ik4w2vl1Y6MeALLXABJk2DUS523iaPqHu0V4BE=;
        b=D09Ghkh8d9CcdSMYkTc/3/BER5j8sqwDL1Z3mXcjvS5yNl3pXoGu3OvOA4gMOrXl8b
         BFhUMp+aWx0Hczr4SbVt/3USBMJIR2EvVevjD+ujatefTpEukegxRUkKbznUpDNnKieL
         uDore4vsGx6nnIqPM8Qoa27pObnxZoUuNzurTgZo031hOfpYOe0jtyDyv2BilcX4NMsa
         a5vL7aAFQSaZ8Km19kL2sw67QBc/V9FjTObjdVhiv7JjMaM0LyGGO+bv2ZopKQzscNQv
         XnmUAEVgup2Dflz9Dhu6IwZs44VywLDVZlwGXn6ceM7YFCHvUkWSHZOgxTQFdCBywIVn
         4mNA==
X-Gm-Message-State: AJIora/V47Sjie0NM1gsawalXB0oi8BMe2Kjq4iFRY0ZGxFXLSAMJt0F
        1kdbf9Z3hi8U9oiERvvZpSQiVML6Kzf6LW86AY4=
X-Google-Smtp-Source: AGRyM1vVX6xuEemt6smwWJYz8jpFXASc84E1bBzuQKLJ0C07KTinXUSmTkqD08KnxVJ6zxmOihbblKep32sI5jIW8kk=
X-Received: by 2002:a17:906:8447:b0:72a:f120:50cd with SMTP id
 e7-20020a170906844700b0072af12050cdmr3340649ejy.114.1657081020927; Tue, 05
 Jul 2022 21:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220628160127.607834-1-deso@posteo.net> <20220628160127.607834-3-deso@posteo.net>
In-Reply-To: <20220628160127.607834-3-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Jul 2022 21:16:50 -0700
Message-ID: <CAEf4BzbpnaQRuMRjKJwdCiVUDrEWOXKTuu0-xG2zs4hxjd7jCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/10] bpftool: Honor BPF_CORE_TYPE_MATCHES relocation
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 28, 2022 at 9:01 AM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> bpftool needs to know about the newly introduced BPF_CORE_TYPE_MATCHES
> relocation for its 'gen min_core_btf' command to work properly in the
> present of this relocation.
> Specifically, we need to make sure to mark types and fields so that they
> are present in the minimized BTF for "type match" checks to work out.
> However, contrary to the existing btfgen_record_field_relo, we need to
> rely on the BTF -- and not the spec -- to find fields. With this change
> we handle this new variant correctly. The functionality will be tested
> with follow on changes to BPF selftests, which already run against a
> minimized BTF created with bpftool.
>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  tools/bpf/bpftool/gen.c | 108 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 480cbd8..a30328c 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1856,6 +1856,112 @@ static int btfgen_record_field_relo(struct btfgen=
_info *info, struct bpf_core_sp
>         return 0;
>  }
>
> +/* Mark types, members, and member types. Compared to btfgen_record_fiel=
d_relo,
> + * this function does not rely on the target spec for inferring members,=
 but
> + * uses the associated BTF.
> + *
> + * The `behind_ptr` argument is used to stop marking of composite types =
reached
> + * through a pointer. This way, we can keep BTF size in check while prov=
iding
> + * reasonable match semantics.
> + */
> +static int btfgen_mark_type_match(struct btfgen_info *info, __u32 type_i=
d, bool behind_ptr)
> +{
> +       const struct btf_type *btf_type;
> +       struct btf *btf =3D info->src_btf;
> +       struct btf_type *cloned_type;
> +       int i, err;
> +
> +       if (type_id =3D=3D 0)
> +               return 0;
> +
> +       btf_type =3D btf__type_by_id(btf, type_id);
> +       /* mark type on cloned BTF as used */
> +       cloned_type =3D (struct btf_type *)btf__type_by_id(info->marked_b=
tf, type_id);
> +       cloned_type->name_off =3D MARKED;
> +
> +       switch (btf_kind(btf_type)) {
> +       case BTF_KIND_UNKN:
> +       case BTF_KIND_INT:
> +       case BTF_KIND_FLOAT:
> +       case BTF_KIND_ENUM:
> +       case BTF_KIND_ENUM64:
> +               break;
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION: {
> +               struct btf_member *m =3D btf_members(btf_type);
> +               __u16 vlen =3D btf_vlen(btf_type);
> +
> +               if (behind_ptr)
> +                       break;
> +
> +               for (i =3D 0; i < vlen; i++, m++) {
> +                       /* mark member */
> +                       btfgen_mark_member(info, type_id, i);
> +
> +                       /* mark member's type */
> +                       err =3D btfgen_mark_type_match(info, m->type, fal=
se);
> +                       if (err)
> +                               return err;
> +               }
> +               break;
> +       }
> +       case BTF_KIND_CONST:
> +       case BTF_KIND_FWD:
> +       case BTF_KIND_RESTRICT:
> +       case BTF_KIND_TYPEDEF:
> +       case BTF_KIND_VOLATILE:
> +               return btfgen_mark_type_match(info, btf_type->type, false=
);

this should have preserved behind_ptr instead of resetting it to false
(i.e. `const struct blah *` should be treated similarly to `struct
blah *`). I've fixed it up while applying.

> +       case BTF_KIND_PTR:
> +               return btfgen_mark_type_match(info, btf_type->type, true)=
;
> +       case BTF_KIND_ARRAY: {
> +               struct btf_array *array;
> +
> +               array =3D btf_array(btf_type);
> +               /* mark array type */
> +               err =3D btfgen_mark_type_match(info, array->type, false);
> +               /* mark array's index type */
> +               err =3D err ? : btfgen_mark_type_match(info, array->index=
_type, false);
> +               if (err)
> +                       return err;
> +               break;

[...]
