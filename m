Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A29567D4C
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 06:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiGFE2T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 00:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGFE2S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 00:28:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2711BE86;
        Tue,  5 Jul 2022 21:28:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e40so17735964eda.2;
        Tue, 05 Jul 2022 21:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uqyqT94WS21Gw93BlqOE1L/JzxKY54UCcw8Zx9s0xrM=;
        b=gAI79+p9Zd3Ex55vdDA8oFYo3qm4ae/v4FnW3VJr3ANDUhQg2wS/I1Pq6o/kWuVSuc
         DVjTRAZZxc6amoPPz8HFw8Aey+NtSkvz+WCeF42zsJvE+0MzMY2JhjwrwmwEWL6xJeRx
         aX8Kv42OUukBB8tbZknVNIYAshiHK+L4FC8UXJtp+W9sH3oo1HJn7dPaPHhWDcXqaDrP
         0uq80wyCuDkrdqy3/TT7pCq3EJD1VtuMkKqxcb1+22fTI1/6NMP2wRNwGaE9KBGEfVr3
         HcwZTrFtx8rKAB1IHQQB5HLOvsLsiPLe/5yheyr1d2+WOWjIqfgB/NqYRkCdSvcEBiAW
         uklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uqyqT94WS21Gw93BlqOE1L/JzxKY54UCcw8Zx9s0xrM=;
        b=Pr+AR/gB64CeYufIXgvJwPzYnRp5tnYL92hT9y/ZnSzuz1HXlyPOsLk2HIrlSpmhtT
         KPPuHFN7tQ/ikQq/m2gaygHv5upFvLnAQ9WVGa1loHsAx9L+K/a/GB7Ov+EpYG6mgkgl
         ayu2TrBHSI0/Wb8pvzNsdHsXXHSvoKtzsGZF1+xxu1hJiVlkRanoHinytFqwcXwuFfCH
         QEb8PhaJ8KSmtgg7zY48rVqJWjOlNqo6HeMk0r7zKowu5q4g8UtPYU0vYM8nC8a/5CVs
         KwpDp9u1EzXwdzEP9wVQ5tifPbOpmYGU0EQ+iOEYh5W42jRpI1TRNvhUveGFbt+m1gE0
         u2+w==
X-Gm-Message-State: AJIora/WXqRtbwMAjOe5O5wQ6T1MHDZgdAoV67bM1mTS2j9eBdDISf4O
        UV9LvqWM+9qDYXT/6oaQZYjPWWa25UMyrpYVAtA=
X-Google-Smtp-Source: AGRyM1sm6k9MmAxuxUfOUFLpfDQIfa8VKarDA0sRyree4lUGu+U5YIoB4uLavuC5+0JOmQjhxeJ0qQhFlHoWcTdvh6k=
X-Received: by 2002:a05:6402:3514:b0:435:f24a:fbad with SMTP id
 b20-20020a056402351400b00435f24afbadmr49362815edd.311.1657081696353; Tue, 05
 Jul 2022 21:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220615230306.851750-1-yhs@fb.com> <YrrPOFzYAGHm0oht@krava>
 <Yrx+Ehpc71/6WHVT@kernel.org> <YryELT6OadpiJki/@kernel.org>
In-Reply-To: <YryELT6OadpiJki/@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Jul 2022 21:28:05 -0700
Message-ID: <CAEf4BzananDqBJyfu8n3VATNULd5ZgY2GrEYGvGSS_5dMW3mpw@mail.gmail.com>
Subject: Re: [PATCH] btf_loader: support BTF_KIND_ENUM64 was Re: [PATCH
 dwarves v2 0/2] btf: support BTF_KIND_ENUM64
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Jiri Olsa <olsajiri@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Jun 29, 2022 at 9:56 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jun 29, 2022 at 01:30:10PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > =E2=AC=A2[acme@toolbox pahole]$ pdwtags -F btf vmlinux-v5.18-rc7+ | gre=
p -B10 -A5 BPF_F_CTXLEN_MASK
> > BTF: idx: 4173, Unknown kind 19
> > BTF: idx: 4975, Unknown kind 19
> > BTF: idx: 6673, Unknown kind 19
> > BTF: idx: 27413, Unknown kind 19
> > BTF: idx: 30626, Unknown kind 19
> > BTF: idx: 30829, Unknown kind 19
> > BTF: idx: 38040, Unknown kind 19
> > BTF: idx: 56969, Unknown kind 19
> > BTF: idx: 83004, Unknown kind 19
> > =E2=AC=A2[acme@toolbox pahole]$
> >
> > Ok, I need to update pahole's BTF loader to support:
> >
> > lib/bpf/src/btf.h:#define BTF_KIND_ENUM64             19      /* Enum f=
or up-to 64bit values */
> >
> >
> > Working on it now.
>
> =E2=AC=A2[acme@toolbox pahole]$ pdwtags -F btf vmlinux-v5.18-rc7+ | grep =
-B5 -A5 BPF_F_CTXLEN_MASK
>
> /* 27413 */
> enum {
>         BPF_F_INDEX_MASK  =3D 4294967295,
>         BPF_F_CURRENT_CPU =3D 4294967295,
>         BPF_F_CTXLEN_MASK =3D 4503595332403200,
> } __attribute__((__packed__)); /* size: 8 */
>
> /* 27414 */
> enum {
>         BPF_F_GET_BRANCH_RECORDS_SIZE =3D 1,
> =E2=AC=A2[acme@toolbox pahole]$
>
> Quick patch here, please Ack, if possible:
>

two minor nits, but looks good overall:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/btf_loader.c b/btf_loader.c
> index b5d444643adf30b1..e57ecce2cde26e4e 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -312,6 +312,49 @@ out_free:
>         return -ENOMEM;
>  }
>
> +static struct enumerator *enumerator__new64(const char *name, uint64_t v=
alue)
> +{
> +       struct enumerator *en =3D tag__alloc(sizeof(*en));
> +
> +       if (en !=3D NULL) {
> +               en->name =3D name;
> +               en->value =3D value; // Value is already 64-bit, as this =
is used with DWARF as well
> +               en->tag.tag =3D DW_TAG_enumerator;
> +       }
> +
> +       return en;
> +}
> +
> +static int create_new_enumeration64(struct cu *cu, const struct btf_type=
 *tp, uint32_t id)
> +{
> +       struct btf_enum64 *ep =3D btf_enum64(tp);
> +       uint16_t i, vlen =3D btf_vlen(tp);
> +       struct type *enumeration =3D type__new(DW_TAG_enumeration_type,
> +                                            cu__btf_str(cu, tp->name_off=
),
> +                                            tp->size ? tp->size * 8 : (s=
izeof(int) * 8));

tp->size should always be valid, so this fall back to sizeof(int)
isn't necessary

> +
> +       if (enumeration =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < vlen; i++) {
> +               const char *name =3D cu__btf_str(cu, ep[i].name_off);
> +               uint64_t value =3D ((uint64_t)ep[i].val_hi32) << 32 | ep[=
i].val_lo32;

use btf_enum64_value() defined in libbpf's btf.h header

> +               struct enumerator *enumerator =3D enumerator__new64(name,=
 value);
> +
> +               if (enumerator =3D=3D NULL)
> +                       goto out_free;
> +
> +               enumeration__add(enumeration, enumerator);
> +       }
> +
> +       cu__add_tag_with_id(cu, &enumeration->namespace.tag, id);
> +
> +       return 0;
> +out_free:
> +       enumeration__delete(enumeration);
> +       return -ENOMEM;
> +}
> +
>  static int create_new_subroutine_type(struct cu *cu, const struct btf_ty=
pe *tp, uint32_t id)
>  {
>         struct ftype *proto =3D tag__alloc(sizeof(*proto));
> @@ -419,6 +462,9 @@ static int btf__load_types(struct btf *btf, struct cu=
 *cu)
>                 case BTF_KIND_ENUM:
>                         err =3D create_new_enumeration(cu, type_ptr, type=
_index);
>                         break;
> +               case BTF_KIND_ENUM64:
> +                       err =3D create_new_enumeration64(cu, type_ptr, ty=
pe_index);
> +                       break;
>                 case BTF_KIND_FWD:
>                         err =3D create_new_forward_decl(cu, type_ptr, typ=
e_index);
>                         break;
