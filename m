Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B2E53AF27
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 00:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiFAVyK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 17:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiFAVyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 17:54:09 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79B5F33
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 14:54:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 1so3392853ljp.8
        for <bpf@vger.kernel.org>; Wed, 01 Jun 2022 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SuaapL0Q76FBQl3M4eXy12kJLwhsS+avsGho6pNF6uA=;
        b=MlO1yruvhjBbxh+yZSqpDhQAMxCPcFNmSJCVPYNq2/y29k0ZnThPGcDeWXGEe2zhEa
         PcjYbJhGbdO6ggsQrT293hGVS5UdyCVw7nrMHQSyqIG6FSuan4vN49C9hD+GIu9XYvmQ
         M/hwndr73HOKqol8EmQ6j9wYFN8zEytW5dP4bdNnLpKY+SWDY3NpwS/UotXUX2tBe8Gd
         QMfBMb9SJYot6d4OjF3Pvgw27Qcu65JsZnQ0kTxk3hCUpI0ilX6b6l2vczhOAPnPejKF
         gJc0h6ZpkkXUQUAYrHG22hqyswjNaA+S+nlDvjyqjmymKKgTSQxuJacGcp1PIp8iJ//x
         +I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SuaapL0Q76FBQl3M4eXy12kJLwhsS+avsGho6pNF6uA=;
        b=sLewjVNZ+StYlYRwXCLUSEUqXPzzen3V6hHL0bGa3q/Xf0Hgsi95QaTXbqUVkVolkm
         ElBywMvxC3c6FW7zN+pEAtLGZ6Wo5MhbKWHSI9CF90aoi2CsiQONSIctsLg3iSLr+gvm
         pX3TcnZVS9o0di7l72JFyAtGyHbZfxNKi+MeSoMWLpvWkA62mxGm1EGUmVB7T34nW0YF
         VLFXdqoZ7sG+NxVqBKDdX5aVfH7K3VU1faFGVSPi1MSo6R4d2tbkz3S7oAm8BOEcW9X+
         pwmcjh/hJS/4TFvDd3bUY/yHF3AGPWPCjbzk8pnYMLXVQ0U3cNXTcaUxqeyjxTMQbXLx
         jHWg==
X-Gm-Message-State: AOAM531dNQLNHj7YqhFUeGhMDivEgZOzcxyFvksxMaT4iWPEqXQoyFUO
        Akh5O7jlxHLNY8pC3OMAQ7chbPv1nGS+0kvaN6tAHR8q
X-Google-Smtp-Source: ABdhPJx05cubcj+XTphZu3hXh/Z6YOVRUgorcF7+zaIvB+2T5PMRHe3XHJIn+XpSunDXwTUManlqPYRUGy/1oikqKMs=
X-Received: by 2002:a05:651c:994:b0:253:c449:12f with SMTP id
 b20-20020a05651c099400b00253c449012fmr39956816ljq.413.1654120446006; Wed, 01
 Jun 2022 14:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220526185432.2545879-1-yhs@fb.com> <20220526185524.2550356-1-yhs@fb.com>
 <CAEf4BzYp=9pntdwgc40RF5-1RhwgJqPyQ8B7svaX_TzfO+joag@mail.gmail.com> <442f83af-70dd-da94-5cd6-5098c173cd35@fb.com>
In-Reply-To: <442f83af-70dd-da94-5cd6-5098c173cd35@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Jun 2022 14:53:54 -0700
Message-ID: <CAEf4BzYREChWD7bmB1MddhLQC-UgAAouuivew3nBKBds=omZiQ@mail.gmail.com>
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

On Wed, Jun 1, 2022 at 12:14 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/31/22 5:07 PM, Andrii Nakryiko wrote:
> > On Thu, May 26, 2022 at 11:55 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> The enum64 relocation support is added. The bpf local type
> >> could be either enum or enum64 and the remote type could be
> >> either enum or enum64 too. The all combinations of local enum/enum64
> >> and remote enum/enum64 are supported.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/lib/bpf/btf.h       |  7 +++++
> >>   tools/lib/bpf/libbpf.c    |  7 ++---
> >>   tools/lib/bpf/relo_core.c | 54 +++++++++++++++++++++++++++------------
> >>   3 files changed, 48 insertions(+), 20 deletions(-)
> >>
> >
> > [...]
> >
> >>                  local_essent_len = bpf_core_essential_name_len(local_acc->name);
> >>
> >> -               for (i = 0, e = btf_enum(targ_type); i < btf_vlen(targ_type); i++, e++) {
> >> -                       targ_name = btf__name_by_offset(targ_spec->btf, e->name_off);
> >> +               for (i = 0; i < btf_vlen(targ_type); i++) {
> >> +                       if (btf_is_enum(targ_type))
> >> +                               name_off = btf_enum(targ_type)[i].name_off;
> >> +                       else
> >> +                               name_off = btf_enum64(targ_type)[i].name_off;
> >> +
> >> +                       targ_name = btf__name_by_offset(targ_spec->btf, name_off);
> >>                          targ_essent_len = bpf_core_essential_name_len(targ_name);
> >>                          if (targ_essent_len != local_essent_len)
> >>                                  continue;
> >> @@ -680,8 +688,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
> >>                  *val = byte_sz;
> >>                  break;
> >>          case BPF_CORE_FIELD_SIGNED:
> >> -               /* enums will be assumed unsigned */
> >> -               *val = btf_is_enum(mt) ||
> >> +               *val = btf_type_is_any_enum(mt) ||
> >
> > wouldn't this be more correct with kflag meaning "signed":
> >
> > (btf_type_is_any_enum(mt) && btf_kflag(mt)) ||
>
> Will fix.
>
> >
> > ?
> >
> >>                         (btf_int_encoding(mt) & BTF_INT_SIGNED);
> >>                  if (validate)
> >>                          *validate = true; /* signedness is never ambiguous */
> >> @@ -754,7 +761,6 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
> >>                                        __u64 *val)
> >>   {
> >>          const struct btf_type *t;
> >> -       const struct btf_enum *e;
> >>
> >>          switch (relo->kind) {
> >>          case BPF_CORE_ENUMVAL_EXISTS:
> >> @@ -764,8 +770,10 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
> >>                  if (!spec)
> >>                          return -EUCLEAN; /* request instruction poisoning */
> >>                  t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
> >> -               e = btf_enum(t) + spec->spec[0].idx;
> >> -               *val = e->val;
> >> +               if (btf_is_enum(t))
> >> +                       *val = btf_enum(t)[spec->spec[0].idx].val;
> >> +               else
> >> +                       *val = btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
> >>                  break;
> >>          default:
> >>                  return -EOPNOTSUPP;
> >> @@ -1060,7 +1068,6 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
> >>   int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *spec)
> >>   {
> >>          const struct btf_type *t;
> >> -       const struct btf_enum *e;
> >>          const char *s;
> >>          __u32 type_id;
> >>          int i, len = 0;
> >> @@ -1089,10 +1096,23 @@ int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *s
> >>
> >>          if (core_relo_is_enumval_based(spec->relo_kind)) {
> >>                  t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
> >> -               e = btf_enum(t) + spec->raw_spec[0];
> >> -               s = btf__name_by_offset(spec->btf, e->name_off);
> >> +               if (btf_is_enum(t)) {
> >> +                       const struct btf_enum *e;
> >> +                       const char *fmt_str;
> >> +
> >> +                       e = btf_enum(t) + spec->raw_spec[0];
> >> +                       s = btf__name_by_offset(spec->btf, e->name_off);
> >> +                       fmt_str = BTF_INFO_KFLAG(t->info) ? "::%s = %d" : "::%s = %u";
> >
> > minor nit: btf_kflag(t) instead of BTF_INFO_KFLAGS(t->info)?
>
> relo_core.c is used by both the kernel and libbpf. The btf_kflag
> is not available in kernel. That is why I am using BTF_INFO_KFLAG.
> I guess I can introduce btf_kflag in the kernel to avoid using
> BTF_INFO_KFLAG.

ah, in that case it's fine, nothing wrong with it per se, if it was
purely libbpf code btf_kflag() is a bit cleaner, but given it's shared
it's fine to keep it as is.

>
> >
> >
> >
> >> +                       append_buf(fmt_str, s, e->val);
> >> +               } else {
> >> +                       const struct btf_enum64 *e;
> >> +                       const char *fmt_str;
> >>
> >> -               append_buf("::%s = %u", s, e->val);
> >> +                       e = btf_enum64(t) + spec->raw_spec[0];
> >> +                       s = btf__name_by_offset(spec->btf, e->name_off);
> >> +                       fmt_str = BTF_INFO_KFLAG(t->info) ? "::%s = %lld" : "::%s = %llu";
> >> +                       append_buf(fmt_str, s, (unsigned long long)btf_enum64_value(e));
> >> +               }
> >>                  return len;
> >>          }
> >>
> >> --
> >> 2.30.2
> >>
