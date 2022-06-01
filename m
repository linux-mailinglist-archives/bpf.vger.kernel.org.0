Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23679539A47
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 02:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbiFAAHj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 20:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348807AbiFAAHQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 20:07:16 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C9D2A27B
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 17:07:15 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id w10so96012vsa.4
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 17:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TTTzTqZEz3OUgSIuH5xd86cbBnto47ggjBdeYvY/Ro=;
        b=dYWrVESkb1gU9ldZM1hdj03fgsCtP2gZBcGYwR2YIgRR0wthWx/ddQ/qypwHSngtg3
         MOWq1Bso7/nhu4OlcmdFFXqgOhIWKc3PmToMRsVevqi0Wjer/jeaaod78JbaU6Gl4JL6
         FinrNLOIKIOui4qDRQWeSAvnIT0k+NpyN893sFsV3WlBVhXLq5lUKZdnD3WdJbmcTA6P
         KRas8nd3FHzmbmiYz18iiBL3cgrhvao71SNtrMWHaJRYx395SHm9y4tDdCYkaK5kM3Uw
         L6fw5xvxfmP4eqHN0TLCXfF0tImvTuQXlmnT9aEIrdukQnkRHRjBfiSF/IrvgnE+HHVA
         KyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TTTzTqZEz3OUgSIuH5xd86cbBnto47ggjBdeYvY/Ro=;
        b=32Ifmbyxgzi0e56EqpQwKAQBNIYwFz2OShkr0hlipFF7hIvvOQruDUybNJNWK7Ekeh
         8FG094fo8xr3AOmUSE+658OYIfChteMpQl1Uip0nebuDzzaB65X64FZoGJ1rnLXr55fR
         zu5HiYynavUj67vhxeFAl0a545jwkwkVLJtelxk+mnv1daAA5/Swf0Wji+VDOV5AArSN
         dtcZmHfGEjrhEIoGjVT5WhGji18AW3Y8kvS5hqvnfN0QJyMA3xGEmI3CLlIKjaS2dnGu
         pcj6gHv5FgF3U35tgyhzFTqfmi8wzpz5cAaS5MDUjlUheydjkn6zGHRR9mp0vaWOq8aw
         2RVg==
X-Gm-Message-State: AOAM530CBVJiSNwS+GFh/ZBYApAO/bu7RD1t7xDuMU6opU/iR8CvcL6Y
        Pa+NbjJ0j2FbRWuKNE/xQRNAE+457VQbwwgoRvikFZHX
X-Google-Smtp-Source: ABdhPJyzcrOsjBHd9o+xp17JgvsQoMKD+TE6GBt29UhhtJcznx4Mwmw7HWQP2OjGUvb0xo8r/pnN4FAmZdvZxuFROLc=
X-Received: by 2002:a05:6102:370a:b0:333:c0e7:77e8 with SMTP id
 s10-20020a056102370a00b00333c0e777e8mr26780586vst.54.1654042034379; Tue, 31
 May 2022 17:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220526185432.2545879-1-yhs@fb.com> <20220526185524.2550356-1-yhs@fb.com>
In-Reply-To: <20220526185524.2550356-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 May 2022 17:07:00 -0700
Message-ID: <CAEf4BzYp=9pntdwgc40RF5-1RhwgJqPyQ8B7svaX_TzfO+joag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/18] libbpf: Add enum64 relocation support
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

On Thu, May 26, 2022 at 11:55 AM Yonghong Song <yhs@fb.com> wrote:
>
> The enum64 relocation support is added. The bpf local type
> could be either enum or enum64 and the remote type could be
> either enum or enum64 too. The all combinations of local enum/enum64
> and remote enum/enum64 are supported.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.h       |  7 +++++
>  tools/lib/bpf/libbpf.c    |  7 ++---
>  tools/lib/bpf/relo_core.c | 54 +++++++++++++++++++++++++++------------
>  3 files changed, 48 insertions(+), 20 deletions(-)
>

[...]

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
> @@ -680,8 +688,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
>                 *val = byte_sz;
>                 break;
>         case BPF_CORE_FIELD_SIGNED:
> -               /* enums will be assumed unsigned */
> -               *val = btf_is_enum(mt) ||
> +               *val = btf_type_is_any_enum(mt) ||

wouldn't this be more correct with kflag meaning "signed":

(btf_type_is_any_enum(mt) && btf_kflag(mt)) ||

?

>                        (btf_int_encoding(mt) & BTF_INT_SIGNED);
>                 if (validate)
>                         *validate = true; /* signedness is never ambiguous */
> @@ -754,7 +761,6 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>                                       __u64 *val)
>  {
>         const struct btf_type *t;
> -       const struct btf_enum *e;
>
>         switch (relo->kind) {
>         case BPF_CORE_ENUMVAL_EXISTS:
> @@ -764,8 +770,10 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>                 if (!spec)
>                         return -EUCLEAN; /* request instruction poisoning */
>                 t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
> -               e = btf_enum(t) + spec->spec[0].idx;
> -               *val = e->val;
> +               if (btf_is_enum(t))
> +                       *val = btf_enum(t)[spec->spec[0].idx].val;
> +               else
> +                       *val = btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
>                 break;
>         default:
>                 return -EOPNOTSUPP;
> @@ -1060,7 +1068,6 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>  int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *spec)
>  {
>         const struct btf_type *t;
> -       const struct btf_enum *e;
>         const char *s;
>         __u32 type_id;
>         int i, len = 0;
> @@ -1089,10 +1096,23 @@ int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *s
>
>         if (core_relo_is_enumval_based(spec->relo_kind)) {
>                 t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
> -               e = btf_enum(t) + spec->raw_spec[0];
> -               s = btf__name_by_offset(spec->btf, e->name_off);
> +               if (btf_is_enum(t)) {
> +                       const struct btf_enum *e;
> +                       const char *fmt_str;
> +
> +                       e = btf_enum(t) + spec->raw_spec[0];
> +                       s = btf__name_by_offset(spec->btf, e->name_off);
> +                       fmt_str = BTF_INFO_KFLAG(t->info) ? "::%s = %d" : "::%s = %u";

minor nit: btf_kflag(t) instead of BTF_INFO_KFLAGS(t->info)?



> +                       append_buf(fmt_str, s, e->val);
> +               } else {
> +                       const struct btf_enum64 *e;
> +                       const char *fmt_str;
>
> -               append_buf("::%s = %u", s, e->val);
> +                       e = btf_enum64(t) + spec->raw_spec[0];
> +                       s = btf__name_by_offset(spec->btf, e->name_off);
> +                       fmt_str = BTF_INFO_KFLAG(t->info) ? "::%s = %lld" : "::%s = %llu";
> +                       append_buf(fmt_str, s, (unsigned long long)btf_enum64_value(e));
> +               }
>                 return len;
>         }
>
> --
> 2.30.2
>
