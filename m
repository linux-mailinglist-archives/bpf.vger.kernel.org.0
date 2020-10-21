Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5400D295318
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 21:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410016AbgJUTrm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Oct 2020 15:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409957AbgJUTrm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 15:47:42 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2963AC0613CE;
        Wed, 21 Oct 2020 12:47:42 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id a12so2784279ybg.9;
        Wed, 21 Oct 2020 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KuyW4VzO5s/U3q6MO2b9Rl78kdgDabbPCNa9zyg0Usk=;
        b=gBh++grG7svXv3Afv/9QmDfIr/SS2JaFYasad2D3LC4OB7dl32/ZRNgyCriWjk0NLz
         f9of3MEN6y0CveO/+7Kky70dc4C0OjZQlgft4hQtagOVUesaf21acKbUbr1FGekfErFK
         0J3xqhSktExKvRAhA2L41u3ocFOz8gpoKrbhNj7e9QWrSFcC51hu+Slg71E9bAvYXAQS
         cXsb2XvdDBeHtHnLa3p2iQkbd6N17IQzTpH4CjP8Vks2BBNO+s6miFCBxwnPx5gtRomW
         rMMvWeeVmVVWA5Wcpbm634nMq6zskkvT6gqGrCEjr8Y6TTSo/C++3A+HtgK+UH/gwoaC
         Az7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KuyW4VzO5s/U3q6MO2b9Rl78kdgDabbPCNa9zyg0Usk=;
        b=tvJuGwOvhpVsUXWpvWX+jfXOPgCUHgWtaz5X7ljJ9ZvrVALOIQCfbceTaN5R/6mi33
         sDWxAg1s02Sxv7r7u0zL9JxFzVA1EAn3KHMytLs3NDUJxdSbtuVcm5S5lQ/MCudmhnDE
         l2G7roo91owD+xDvvX82ib8Rk+ToYgm6RQHE+OiXkD7PczNmP28GmmljXQkMPoIQjuGV
         W+/mtZx02kWKOsuIbLiiiXcHdaVf+BfJ/C8V6RX3t1YdEuyPocs++goMrF5viufidHvu
         d8IG78fEqH/HROCIo6y8ORLWXduI+UEsszZR8jwugjRdhT7hDLIWjccYtAcmIv+qmY3d
         jUig==
X-Gm-Message-State: AOAM533v1vvZzUxQZacQJFv6NwKpjMan9ylwp9O/XuipLRZ/NyeSCq0S
        RAG4B6BQv16EG23gezXZvPXNwo8dRLw7iIGv3NQ=
X-Google-Smtp-Source: ABdhPJxOYtn2E628QoXENycyL4Vn3OZaDcLBQP4/ktP8vlOhbrgleGlGLZewJAsOxaenI9+NIFFPtnB4rEVTAMotX4U=
X-Received: by 2002:a25:da4e:: with SMTP id n75mr5579900ybf.425.1603309661340;
 Wed, 21 Oct 2020 12:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201009192607.699835-1-andrii@kernel.org> <20201021192530.GS2342001@kernel.org>
In-Reply-To: <20201021192530.GS2342001@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 21 Oct 2020 12:47:30 -0700
Message-ID: <CAEf4BzaCXKYOeyTN74Zm1gbjyBSmBCi1XpgvqKn8-E+ZusrGeA@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_loader: handle union forward declaration properly
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 21, 2020 at 12:25 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Oct 09, 2020 at 12:26:07PM -0700, Andrii Nakryiko escreveu:
> > Differentiate between struct and union forwards. For BTF_KIND_FWD this is
> > determined by kflag. So teach btf_loader to use that bit to decide whether
> > forward is for union or struct.
>
> So, before this patch 'btfdiff vmlinux' comes clean, i.e. pretty
> printing from DWARF matches pretty printing from BTF, after it:
>
> [acme@five pahole]$ btfdiff vmlinux  | wc -l
> 1500
> [acme@five pahole]$
>
> One of the differences:
>
> @@ -117457,7 +117457,7 @@ struct wireless_dev {
>
>         /* XXX last struct has 1 byte of padding */
>
> -       struct cfg80211_cqm_config * cqm_config;         /*   952     8 */
> +       union cfg80211_cqm_config * cqm_config;          /*   952     8 */
>         /* --- cacheline 15 boundary (960 bytes) --- */
>         struct list_head           pmsr_list;            /*   960    16 */
>         spinlock_t                 pmsr_lock;            /*   976     4 */
> [acme@five pahole]$
>
> Looking at the source code:
>
> struct wireless_dev {
> ...
>         struct cfg80211_cqm_config *cqm_config;
> ...
> }
>
> Also:
>
>  struct nfnl_ct_hook {
> -       struct nf_conn *           (*get_ct)(const struct sk_buff  *, enum ip_conntrack_info *); /*     0     8 */
> -       size_t                     (*build_size)(const struct nf_conn  *); /*     8     8 */
> -       int                        (*build)(struct sk_buff *, struct nf_conn *, enum ip_conntrack_info, u_int16_t, u_int16_t); /*    16     8 */
> -       int                        (*parse)(const struct nlattr  *, struct nf_conn *); /*    24     8 */
> -       int                        (*attach_expect)(const struct nlattr  *, struct nf_conn *, u32, u32); /*    32     8 */
> -       void                       (*seq_adjust)(struct sk_buff *, struct nf_conn *, enum ip_conntrack_info, s32); /*    40     8 */
> +       union nf_conn *            (*get_ct)(const struct sk_buff  *, enum ip_conntrack_info *); /*     0     8 */
> +       size_t                     (*build_size)(const union nf_conn  *); /*     8     8 */
> +       int                        (*build)(struct sk_buff *, union nf_conn *, enum ip_conntrack_info, u_int16_t, u_int16_t); /*    16     8 */
> +       int                        (*parse)(const struct nlattr  *, union nf_conn *); /*    24     8 */
> +       int                        (*attach_expect)(const struct nlattr  *, union nf_conn *, u32, u32); /*    32     8 */
> +       void                       (*seq_adjust)(struct sk_buff *, union nf_conn *, enum ip_conntrack_info, s32); /*    40     8 */1
>
> Looking at the source code:
>
> struct nfnl_ct_hook {
>         struct nf_conn *(*get_ct)(const struct sk_buff *skb,
>                                   enum ip_conntrack_info *ctinfo);
>         size_t (*build_size)(const struct nf_conn *ct);
>         int (*build)(struct sk_buff *skb, struct nf_conn *ct,
>                      enum ip_conntrack_info ctinfo,
>                      u_int16_t ct_attr, u_int16_t ct_info_attr);
>         int (*parse)(const struct nlattr *attr, struct nf_conn *ct);
>         int (*attach_expect)(const struct nlattr *attr, struct nf_conn *ct,
>                              u32 portid, u32 report);
>         void (*seq_adjust)(struct sk_buff *skb, struct nf_conn *ct,
>                            enum ip_conntrack_info ctinfo, s32 off);
> };
>
> - Arnaldo
>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> > N.B. This patch is based on top of tmp.libbtf_encoder branch.
> >
> > Also seems like non-forward declared union has a slightly different
> > representation from struct (class). Not sure why it is so, but this change
> > doesn't seem to break anything.
> > ---
> >
> >  btf_loader.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/btf_loader.c b/btf_loader.c
> > index 9b5da3a4997a..0cb23967fec3 100644
> > --- a/btf_loader.c
> > +++ b/btf_loader.c
> > @@ -134,12 +134,13 @@ static struct type *type__new(uint16_t tag, strings_t name, size_t size)
> >       return type;
> >  }
> >
> > -static struct class *class__new(strings_t name, size_t size)
> > +static struct class *class__new(strings_t name, size_t size, bool is_union)
> >  {
> >       struct class *class = tag__alloc(sizeof(*class));
> > +     uint32_t tag = is_union ? DW_TAG_union_type : DW_TAG_structure_type;
> >
> >       if (class != NULL) {
> > -             type__init(&class->type, DW_TAG_structure_type, name, size);
> > +             type__init(&class->type, tag, name, size);
> >               INIT_LIST_HEAD(&class->vtable);
> >       }
> >
> > @@ -228,7 +229,7 @@ static int create_members(struct btf_elf *btfe, const struct btf_type *tp,
> >
> >  static int create_new_class(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
> >  {
> > -     struct class *class = class__new(tp->name_off, tp->size);
> > +     struct class *class = class__new(tp->name_off, tp->size, false);
> >       int member_size = create_members(btfe, tp, &class->type);
> >
> >       if (member_size < 0)
> > @@ -313,7 +314,7 @@ static int create_new_subroutine_type(struct btf_elf *btfe, const struct btf_typ
> >
> >  static int create_new_forward_decl(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
> >  {
> > -     struct class *fwd = class__new(tp->name_off, 0);
> > +     struct class *fwd = class__new(tp->name_off, 0, btf_kind(tp));

*FACEPALM*... This should be btf_kflag(tp) instead. I'll use btfdiff
on all my patches from now on, sorry about this!


> >
> >       if (fwd == NULL)
> >               return -ENOMEM;
> > --
> > 2.24.1
> >
>
> --
>
> - Arnaldo
