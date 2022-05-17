Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA46352AEA1
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiEQXcs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiEQXcr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:32:47 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB1D31217
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:32:46 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id o190so491736iof.10
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dx6lGZzTGB8uYxeYvb7ZapC9/8AhVekHkJRPp5HmZrA=;
        b=Ri9U4HloOU6gouUGX8ymnnkZc84GIfpBJFpOkbZLEt47l3i8pxfQy3pipjla/a+nZJ
         EB9Oo5GElXHy/KFD13Br2jOcve7aLZBo6D7/lIx1e5Mc7CaBoFR1TlIb/WQIUIPYKnQG
         NgiF8RHojFuQXxfK7rVJbjTmz9ug1z3B/dsYVo+1BsElrsrJGCQmuBPj6PIgux7xvCyG
         G4y5qie2ColASCASOiDJvZHYUKS7NF2VdLkPGjE+Lium5k/s6E72h/dVX7RGxuV3fMO9
         +6gIbvSEOT6OSD5VSmDzD91O/d83p7HnGp/et9ckNP/KlggsG+Tv0YChm7jwStDkX9tA
         TOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dx6lGZzTGB8uYxeYvb7ZapC9/8AhVekHkJRPp5HmZrA=;
        b=lV47nVi01YOklwR6d9se5Q0bg5HmoJxq/3rcYi/trdpCUCmPS4nBlcgqmy9np2WrQo
         NTnztzvFLS0uodRHqohgq6Bzq6SeEYCnpeuHIl97RYldeIAJv3FUkOLufh4UtmmJPLSs
         CC/IaSyQjEIOWfOaRNvl9D5rpVnYerFFrzy77/ZOKTpL8fwgrQ8IJhil8uz327tqStpt
         r6zrgquFHa1MAZFd9KFI2FNpk76FUaLUshFqd6+JQFqxo9rWOwWn2JcqDYkO85oBue8O
         pgv4m5M0LrhY/nrRssx6HL4r2qDQF6mmBY+jgoi4lFP5mIrNZJtELvmnaRQrhNxcmZpt
         rcXw==
X-Gm-Message-State: AOAM53041Z0SwM+j8J/ccPG30tz1jJ4pIiPu7OLH4wfbYz9/BQEjeNZs
        TazLwcc4CAPcQZA48zr9YUnhYUCAUxY5XcShpug=
X-Google-Smtp-Source: ABdhPJyA1Clk20EWFsOb30qzBuRRL2Z03gwtPOoWMJwoRJZrRZsVNOje/Bpo7QS4XVuhhtWQ13UAOgRrWA9VkHUQ4tk=
X-Received: by 2002:a05:6638:468e:b0:32b:fe5f:d73f with SMTP id
 bq14-20020a056638468e00b0032bfe5fd73fmr13562969jab.234.1652830365583; Tue, 17
 May 2022 16:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031314.3244410-1-yhs@fb.com>
In-Reply-To: <20220514031314.3244410-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 16:32:34 -0700
Message-ID: <CAEf4BzarwX0idepo1nA8QvyirRYQ-hZL3ZxKh3H=HWP=8P-=LQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 10/18] libbpf: Add enum64 relocation support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> The enum64 relocation support is added. The bpf local type
> could be either enum or enum64 and the remote type could be
> either enum or enum64 too. The all combinations of local enum/enum64
> and remote enum/enum64 are supported.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.h       |  7 ++++++
>  tools/lib/bpf/libbpf.c    |  7 +++---
>  tools/lib/bpf/relo_core.c | 49 ++++++++++++++++++++++++++-------------
>  3 files changed, 44 insertions(+), 19 deletions(-)
>

[...]

>         memset(targ_spec, 0, sizeof(*targ_spec));
>         targ_spec->btf = targ_btf;
> @@ -494,18 +498,22 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
>
>         if (core_relo_is_enumval_based(local_spec->relo_kind)) {
>                 size_t local_essent_len, targ_essent_len;
> -               const struct btf_enum *e;
>                 const char *targ_name;
>
>                 /* has to resolve to an enum */
>                 targ_type = skip_mods_and_typedefs(targ_spec->btf, targ_id, &targ_id);
> -               if (!btf_is_enum(targ_type))
> +               if (!btf_type_is_any_enum(targ_type))

just noticed this discrepancy, can you please rename
s/btf_type_is_any_enum/btf_is_any_enum/ so it's consistent with
btf_is_enum and btf_is_enum64?

>                         return 0;
>
>                 local_essent_len = bpf_core_essential_name_len(local_acc->name);
>
> -               for (i = 0, e = btf_enum(targ_type); i < btf_vlen(targ_type); i++, e++) {
> -                       targ_name = btf__name_by_offset(targ_spec->btf, e->name_off);
> +               for (i = 0; i < btf_vlen(targ_type); i++) {
> +                       if (btf_is_enum(targ_type))
> +                               name_off = btf_enum(targ_type)[i].name_off;
> +                       else
> +                               name_off = btf_enum64(targ_type)[i].name_off;
> +
> +                       targ_name = btf__name_by_offset(targ_spec->btf, name_off);
>                         targ_essent_len = bpf_core_essential_name_len(targ_name);
>                         if (targ_essent_len != local_essent_len)
>                                 continue;
> @@ -681,7 +689,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
>                 break;
>         case BPF_CORE_FIELD_SIGNED:
>                 /* enums will be assumed unsigned */

we don't have to assume anymore, right? let's use kflag for btf_is_any_enum()?

> -               *val = btf_is_enum(mt) ||
> +               *val = btf_type_is_any_enum(mt) ||
>                        (btf_int_encoding(mt) & BTF_INT_SIGNED);
>                 if (validate)
>                         *validate = true; /* signedness is never ambiguous */

[...]

> @@ -1089,10 +1097,19 @@ int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *s
>
>         if (core_relo_is_enumval_based(spec->relo_kind)) {
>                 t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
> -               e = btf_enum(t) + spec->raw_spec[0];
> -               s = btf__name_by_offset(spec->btf, e->name_off);
> +               if (btf_is_enum(t)) {
> +                       const struct btf_enum *e;
>
> -               append_buf("::%s = %u", s, e->val);
> +                       e = btf_enum(t) + spec->raw_spec[0];
> +                       s = btf__name_by_offset(spec->btf, e->name_off);
> +                       append_buf("::%s = %u", s, e->val);
> +               } else {
> +                       const struct btf_enum64 *e;
> +
> +                       e = btf_enum64(t) + spec->raw_spec[0];
> +                       s = btf__name_by_offset(spec->btf, e->name_off);
> +                       append_buf("::%s = %llu", s, btf_enum64_value(e));

nit: we do have a sign bit now, so maybe let's print %lld or %llu
(same for %d and %u above)? btw, please cast (unsigned long long) here

> +               }
>                 return len;
>         }
>
> --
> 2.30.2
>
