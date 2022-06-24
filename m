Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2660855A371
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiFXV0G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 17:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFXV0F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 17:26:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D004F9C0
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:26:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t5so7232216eje.1
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j5WtB0hVGaBSRU+/L1nvjqWpUpNZLFF/U+XfE+dJWY8=;
        b=V5urOwdWiiuRfwazyg1e+Me2PQu+GW/69GPzFuYKcIOW8Zjm+fmCYMD0JQJM/mKzbt
         IkQ5uFSoOrqi7zBATe7oOnuomSkOUdKQT55dQQBYJ9T4Y3grWQFqmX1aauft/uOsU6t2
         52XW+PbuiN16Ec0e0juv1sYECA6LSc87DLEO7MUGxUNLPphbrHy9MLHFLTOZie9xiGTo
         Srx7juy4FUwckj9XkPuhEh70uqgHWnwqXqBnAdV+cxVQOFTLGIfBil4jtg+d6kpyg2hu
         51e2/zsVk3nSQ1YItNc8aHp9zN2JUROFksdCTWmdB9X+3uLbTggdI5tZHsrwtcKnGGFA
         TOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j5WtB0hVGaBSRU+/L1nvjqWpUpNZLFF/U+XfE+dJWY8=;
        b=Czt386MX8Na2kdPeJlV3xyJr2bC7gVXvHiFlHDTCsH1PmMsQqQZNt0ZsOdvEy3PH9N
         qY1SPrGxAa2bmWr/zzRZC1vKG6l/90Ouvhac6PfAOzi7nfJvBDd2jwKIBxciugxSLIJ+
         BfZm8OpnNJIJzt711HtFqq5Q1mWr7Xfd1cbeogVmoYpU1cQo/aCVSN90qgtD6u2kd3lY
         pE0OnD01IRB28s7wMANTbTrUPfaK6KUYpdtP5AVvoLY+r1zXqo14Un+3lqC938i25tJu
         yqEJvRZkr5UZvQI514xKoem03Ph9Tdb1LbTESmH0HR0f6RriJ9pwKk+35/xKK+s8WC6r
         IaIQ==
X-Gm-Message-State: AJIora+8+R0XjTNQHWAmH+qgWl1QnNcYSAFFAAwSLU16BWSXvXQWZBVO
        4NxR3mqmY892OyXxQ569ZRYwhkx8tT+byeJcFhE=
X-Google-Smtp-Source: AGRyM1s2ZX1xF6oJA0djTqnXrMdUwaljGrdWzVwuFZnPKVW5IZqzO3if7oxHdfKm/FAOrZzOnwGjPbYn8LZSdtvsH+M=
X-Received: by 2002:a17:907:980a:b0:722:f4a7:e00 with SMTP id
 ji10-20020a170907980a00b00722f4a70e00mr1060226ejc.114.1656105962064; Fri, 24
 Jun 2022 14:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220623212205.2805002-1-deso@posteo.net> <20220623212205.2805002-3-deso@posteo.net>
In-Reply-To: <20220623212205.2805002-3-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jun 2022 14:25:50 -0700
Message-ID: <CAEf4BzasPaUkz9=1NwUp7MSeCM28W-24BBB_jrO9WDeXXTtOeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/9] bpftool: Honor BPF_CORE_TYPE_MATCHES relocation
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

On Thu, Jun 23, 2022 at 2:22 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
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
>  tools/bpf/bpftool/gen.c | 107 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 480cbd8..6cd0ed 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1856,6 +1856,111 @@ static int btfgen_record_field_relo(struct btfgen=
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
> + * through a pointer. This way, we keep can keep BTF size in check while
> + * providing reasonable match semantics.
> + */
> +static int btfgen_mark_types_match(struct btfgen_info *info, __u32 type_=
id, bool behind_ptr)
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
> +                       err =3D btfgen_mark_types_match(info, m->type, fa=
lse);
> +                       if (err)
> +                               return err;
> +               }
> +               break;
> +       }
> +       case BTF_KIND_CONST:
> +       case BTF_KIND_FWD:
> +       case BTF_KIND_VOLATILE:
> +       case BTF_KIND_TYPEDEF:

BTF_KIND_RESTRICT is missing?


> +               return btfgen_mark_types_match(info, btf_type->type, fals=
e);
> +       case BTF_KIND_PTR:
> +               return btfgen_mark_types_match(info, btf_type->type, true=
);
> +       case BTF_KIND_ARRAY: {
> +               struct btf_array *array;
> +
> +               array =3D btf_array(btf_type);
> +               /* mark array type */
> +               err =3D btfgen_mark_types_match(info, array->type, false)=
;
> +               /* mark array's index type */
> +               err =3D err ? : btfgen_mark_types_match(info, array->inde=
x_type, false);
> +               if (err)
> +                       return err;
> +               break;
> +       }

[...]
