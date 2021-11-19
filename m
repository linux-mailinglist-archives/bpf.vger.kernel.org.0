Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D8645761F
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 18:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhKSSCf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 13:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhKSSCd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 13:02:33 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00DC061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 09:59:31 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v64so30480834ybi.5
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 09:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ik2XUQfPi0evvS5yBHycIb0rqRIiOyREiEl6DXW1EjU=;
        b=O2yGj2jGzlXJFkjyssgoNL0ZDC29cE9tiTrNEG4g+cY3E2eEYufuYV8q5XCrVdTKsf
         n8jdPP7H1/0PciKAkztXgHws25NkWvSV/mwgn6qQOBh7BZro/BLu8XaizY08aFmWQJ7l
         z1jxowplZTP/FvnzhYM3le4/FU40LlMRZZIIwryKP5z5NwLjZRHsbuBMu/LJA40RBs1z
         Hf8XMdc4wD7YiOW36n/1YWr2D4UmAZLyi7drZ2XfCRhGA+RMlucAWDlIH1rtEeh5/Mm0
         Fd83R4628KN30mCpNgKba4lKDwfkLl7Z+ixW1g6WegHsMFHndgoyRRzFnd8/JtM1c2B+
         L1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ik2XUQfPi0evvS5yBHycIb0rqRIiOyREiEl6DXW1EjU=;
        b=MkEmz6SOxfSNbHgbySsG12K0i4DRVnTAqZgUYVx1bxtxCudVahsZOlgHfkKsOEFqoX
         hX6yFq9P1pfIDBAiZarpo+i3NOEOkf1kgbjbGHCsdmQVT2vMkTqMs9uVUSMkWJUhK653
         eDBkB5/XbXvA3quUnDSP/9LCrF1R1d4RblNxa9tvhBgzJvlmxJTOkdW5UMYdDfNBbiGl
         XWzyBB5mhjgzPlwXQc5mxPZ1wra9NSQHvjhgj8Qk5cLcpQBWRDzyhkTUxR9SXKrJ6U3O
         Ghd6pG8OjcnBW45/C20KxhnG5D1Gc6ErufkRS2wCOkCgb0aRUTMJCdnC1QBtxSXBGfG4
         B71A==
X-Gm-Message-State: AOAM533E4lQXRNL2JSfMnzktDmCrG00dypT9gCYswYDnXKwKvLsvniMg
        ZQUlrX49hNA/vWMibYLdTl/DLpxXXePTogqWwJM=
X-Google-Smtp-Source: ABdhPJwFiZ0s9DInUkQ6bFcdqD40Y+TjefVycDjZTIvAw2sfMKM1LRlbqYLrHlMm1qWqXZGppwEo+8uHvn+zI80Mn2c=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr39564176ybe.455.1637344770969;
 Fri, 19 Nov 2021 09:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
 <20211112050230.85640-8-alexei.starovoitov@gmail.com> <CAEf4BzZwgvN1Qdoukr-KxBQ_GFP9Fj=wYe16_qdZxJ-oummguA@mail.gmail.com>
 <20211119035755.zmidy2lvklmuy7n3@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211119035755.zmidy2lvklmuy7n3@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 Nov 2021 09:59:19 -0800
Message-ID: <CAEf4BzZcVoEcxd3FZD9xDfLg2vqgXqkO22SgVgy=WOYgAwSBjw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/12] libbpf: Use CO-RE in the kernel in
 light skeleton.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 18, 2021 at 7:57 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 16, 2021 at 07:45:47PM -0800, Andrii Nakryiko wrote:
> > On Thu, Nov 11, 2021 at 9:02 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Without lskel the CO-RE relocations are processed by libbpf before any other
> > > work is done. Instead, when lksel is needed, remember relocation as RELO_CORE
> >
> > typo: lskel
> >
> > > kind. Then when loader prog is generated for a given bpf program pass CO-RE
> > > relos of that program to gen loader via bpf_gen__record_relo_core(). The gen
> > > loader will remember them as-is and pass it later as-is into the kernel.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  tools/lib/bpf/bpf_gen_internal.h |   3 +
> > >  tools/lib/bpf/gen_loader.c       |  41 +++++++++++-
> > >  tools/lib/bpf/libbpf.c           | 104 +++++++++++++++++++++++--------
> > >  3 files changed, 119 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
> > > index 75ca9fb857b2..ed162fdeecf6 100644
> > > --- a/tools/lib/bpf/bpf_gen_internal.h
> > > +++ b/tools/lib/bpf/bpf_gen_internal.h
> > > @@ -39,6 +39,8 @@ struct bpf_gen {
> > >         int error;
> > >         struct ksym_relo_desc *relos;
> > >         int relo_cnt;
> > > +       struct bpf_core_relo *core_relo;
> >
> > this is named as a singular pointer to one relocation, core_relos
> > would be a more natural name for an array?
>
> I had it with "s" at the beginning, but it was forcing core_relo_cnt variable
> to be called core_relos_cnt to be consistent.

Not really. In English it's "number of arguments" (plural), but
"argument count" (singular). There is some English term for these
"compound nouns". We use this naming quite consistently in libbpf code
(with some very early exceptions of sometimes calling arguments
"insns_cnt", which is actually wrong). You can even see this
consistency with relos and relo_cnt. So in this case it would be
core_relos + core_relo_cnt and that would be proper from English POV.

> And later it spills this "consistency" into uapi core_relos_cnt in bpf_attr.
> But here it conflicts with line_info_cnt and func_info_cnt.
> Once I realized that I went back and got rid of this "s".
>
> >
> > > +       int core_relo_cnt;
> > >         char attach_target[128];
> > >         int attach_kind;
> > >         struct ksym_desc *ksyms;
> > > @@ -61,5 +63,6 @@ void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
> > >  void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum bpf_attach_type type);
> > >  void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
> > >                             bool is_typeless, int kind, int insn_idx);
> >
> > [...]
> >
> > > @@ -6581,6 +6623,16 @@ static int bpf_program__record_externs(struct bpf_program *prog)
> > >                                                ext->is_weak, false, BTF_KIND_FUNC,
> > >                                                relo->insn_idx);
> > >                         break;
> > > +               case RELO_CORE: {
> >
> > This is not an extern, it doesn't make sense to have it here. But I
> > also don't understand why we need to add RELO_CORE and extend struct
> > relo_desc in the first place, just to pass it as bpf_core_relo into
> > gen_loader. Why can't gen_loader just record this directly at the
> > place of record_relo_core() call?
>
> Sorry. I should have explained it in commit log.
> The normal libbpf flow is to process CO-RE early before call relos happen.
> In case of gen_loader the core relos have to be added to other relos to be
> copied together when bpf static function is appended in different places to
> other main bpf progs.
> During the copy the append_subprog_relos() will adjust insn_idx for
> normal relos and for RELO_CORE kind too.
> When that is done each struct reloc_desc has good relos for specific main prog.
>

Yeah, I recalled that when thinking about BTFGen. Ok, this makes
gen_loader's life easier. But I'm uncomfortable with two things, which
should be easy to fix.

1) all these added fields to the relo_desc to record bpf_core_relo
struct fields. It's both unnecessarily open-coding bpf_core_relo and
increasing the memory usage. There could be tons of relocations for
big apps, so I'd like to not bloat memory unnecessarily. Good thing is
that we don't need to copy anything, we can just store the pointer to
bpf_core_relo (which is pointing to internals of struct btf_ext, so
will survive till bpf_object__close()). So I have something like this
in mind:

struct reloc_desc {
    enum reloc_type type;
    int insn_idx;
    union {
        struct {
            int map_idx;
            int sym_off;
        }
        const struct bpf_core_relo *core_relo;
    };
};

So reloc_desc contains type, instruction index, and additional
relo_type-specific info. We can later improve organization and naming,
if necessary, but for now it should be ok with anonymous union and
struct.

2) Given we need RELO_CORE only for gen_loader, we probably should
append those only if (obj->gen_loader). No need to do extra
allocations unnecessarily. Plus we can always change that in the
future. BTW, I was thinking over this week whether there is some reuse
and unification between your changes and BTFGen use case, but I
concluded that they are substantially different to not use exactly the
same mechanism. But see the other thread for details, I proposed some
breakdown of CO-RE relo logic which might affect what you are doing
(in a good way, I think).

WDYT?


> Just noticed that 'insn_idx += prog->sub_insn_off;' in this patch is redundant.
> That was a left over of earlier debugging.
>
> Also in bpf_object__relocate_data() the comment:
>                 case RELO_CORE:
>                         /* handled already */
>                         break;
> is not correct either.
> It should read "will be handled by bpf_program__record_externs() later".
> Just before bpf_object_load_prog_instance().

Ok, but then let's rename it to more generic
bpf_program_record_relos()? Not just externs anymore.

BTW, not a strict rule, but I'm trying to not use obj__method() naming
for non-public API nowadays, I'm finding it quite confusing in
practice (always worry when reading code that it's exposed in public
API). Not enough to go rename everything, but for new stuff I'd stick
to bpf_program_something_something().
