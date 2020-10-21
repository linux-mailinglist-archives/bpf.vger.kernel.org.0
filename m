Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6532950E6
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503010AbgJUQiM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Oct 2020 12:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503008AbgJUQiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 12:38:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2792321D7B;
        Wed, 21 Oct 2020 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603298291;
        bh=sKDb+NXa1tgVKJb1me9HmWAbKfzQZxx2q4/FUQH/2Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZ6+g/u/4Wx3BI8ak73zGDTDX3xDfDl7x4PaXO5cjyskT7CbS/r+xXmGEd42tVmSZ
         h/BYhtXG8mnwmf+xNU+jTNtIKj5L1u59c7OVoyJpkpXu883VRrrJSL2hQb9FfkIBsp
         T71ZqjLtKCSo0hnV43BtRRbmRINpoSAdB0SCbo7Y=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 02D65403C2; Wed, 21 Oct 2020 13:38:08 -0300 (-03)
Date:   Wed, 21 Oct 2020 13:38:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH dwarves] btf_loader: handle union forward declaration
 properly
Message-ID: <20201021163808.GR2342001@kernel.org>
References: <20201009192607.699835-1-andrii@kernel.org>
 <CAEf4BzY4k4B5Pc93wSOWD-Hjw=_uoFjfByxc44uXAipV+PV96g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY4k4B5Pc93wSOWD-Hjw=_uoFjfByxc44uXAipV+PV96g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Oct 21, 2020 at 08:35:34AM -0700, Andrii Nakryiko escreveu:
> On Fri, Oct 9, 2020 at 12:26 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Differentiate between struct and union forwards. For BTF_KIND_FWD this is
> > determined by kflag. So teach btf_loader to use that bit to decide whether
> > forward is for union or struct.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> > N.B. This patch is based on top of tmp.libbtf_encoder branch.
> >
> > Also seems like non-forward declared union has a slightly different
> > representation from struct (class). Not sure why it is so, but this change
> > doesn't seem to break anything.
> > ---
> 
> Ping on this one, let's include it with upcoming pahole 1.19 as well?

I missed this one, but please consider providing concrete examples, can
you provide one so that its completely spelled out, like for a 4.9yo
kid? 8-)

- Arnaldo
 
> >
> >  btf_loader.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/btf_loader.c b/btf_loader.c
> > index 9b5da3a4997a..0cb23967fec3 100644
> > --- a/btf_loader.c
> > +++ b/btf_loader.c
> > @@ -134,12 +134,13 @@ static struct type *type__new(uint16_t tag, strings_t name, size_t size)
> >         return type;
> >  }
> >
> > -static struct class *class__new(strings_t name, size_t size)
> > +static struct class *class__new(strings_t name, size_t size, bool is_union)
> >  {
> >         struct class *class = tag__alloc(sizeof(*class));
> > +       uint32_t tag = is_union ? DW_TAG_union_type : DW_TAG_structure_type;
> >
> >         if (class != NULL) {
> > -               type__init(&class->type, DW_TAG_structure_type, name, size);
> > +               type__init(&class->type, tag, name, size);
> >                 INIT_LIST_HEAD(&class->vtable);
> >         }
> >
> > @@ -228,7 +229,7 @@ static int create_members(struct btf_elf *btfe, const struct btf_type *tp,
> >
> >  static int create_new_class(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
> >  {
> > -       struct class *class = class__new(tp->name_off, tp->size);
> > +       struct class *class = class__new(tp->name_off, tp->size, false);
> >         int member_size = create_members(btfe, tp, &class->type);
> >
> >         if (member_size < 0)
> > @@ -313,7 +314,7 @@ static int create_new_subroutine_type(struct btf_elf *btfe, const struct btf_typ
> >
> >  static int create_new_forward_decl(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
> >  {
> > -       struct class *fwd = class__new(tp->name_off, 0);
> > +       struct class *fwd = class__new(tp->name_off, 0, btf_kind(tp));
> >
> >         if (fwd == NULL)
> >                 return -ENOMEM;
> > --
> > 2.24.1
> >

-- 

- Arnaldo
