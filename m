Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF94568D4
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 04:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhKSEA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 23:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhKSEA7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 23:00:59 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7401DC061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 19:57:58 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x131so8187254pfc.12
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 19:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=or6TYz8tlPsROowq+6JfpdDOPEjYoLZHIMobq29psv4=;
        b=kjyvHOoClh81K0aVBnBqUMV69ei6W6w6qQwoC6nXdtfVrvoajAogpIRznH7uk7iB66
         pdkl7iqgHEXfKHYVYTBbsATu8Q347RDnVI3prYfDo344VwH+Il1ZjwA7Z1H5T7trmBio
         ol51OtGvowBUM44r9KCcCQYr2O5yeQirVucJEcj+4lf2iGCw72EOpUpOScb78JVX5hQL
         Fv5d1cJbiU5CZHaxWFkKKpVBYD/fh/cw/XGgNjoM5qVh/uZqUJDxxVaJzx7wOyvbSpgL
         /O4yCiGr8X9XTpgb6N9u/ZG+5rh4mbzyxktuJEc616ZQacjMzJgiY+4Or74hv0WnR8kr
         TORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=or6TYz8tlPsROowq+6JfpdDOPEjYoLZHIMobq29psv4=;
        b=f/W6Jctovs8xRj9DDi2cqv/G+Z63OokNjGA4VJ4uFvx3DYlCv3xfJy+0Z8AwvnvWCS
         q5Jht7xz0rim9kVjsjgFka8HGQ56RhWI9m9NXbTlBYv99wW6SGMPn19h4JsQOXi6J5MO
         nzLfZ4aO0sRTorhVnzIz7MZLeIDuAo7xcU7k//UaxysTjKAwGJxDqQLGCyhML3L2h9Pw
         XGyPv6qIpBD05UczJtZdJ0/scS2JjzICtT3u4Z5CAdipozCdx7/xiIT/9veG3xZV2EjI
         QZlymme2QE2aPJ/jU49JE6MU80wTrW9MfAtO0epsBHDfAfRtMm6wZzA0KI9feFVI8IDO
         dyuA==
X-Gm-Message-State: AOAM533ni6QgMBN+c3AgqjpuEXVYRcaNL2M2b3gZNZlAk7MnOWJyvobJ
        MwevizmfNdI/IeBUVX7e6uE=
X-Google-Smtp-Source: ABdhPJwzjbHChNi8U7TyJj87hS66yrLQbuxwLrU53O0g/mFOHi5ovKyaWxm1KOAk48bzqeNCwJYovA==
X-Received: by 2002:a63:854a:: with SMTP id u71mr14902037pgd.428.1637294277929;
        Thu, 18 Nov 2021 19:57:57 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4e33])
        by smtp.gmail.com with ESMTPSA id h6sm1097878pfi.174.2021.11.18.19.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 19:57:57 -0800 (PST)
Date:   Thu, 18 Nov 2021 19:57:55 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 07/12] libbpf: Use CO-RE in the kernel in
 light skeleton.
Message-ID: <20211119035755.zmidy2lvklmuy7n3@ast-mbp.dhcp.thefacebook.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
 <20211112050230.85640-8-alexei.starovoitov@gmail.com>
 <CAEf4BzZwgvN1Qdoukr-KxBQ_GFP9Fj=wYe16_qdZxJ-oummguA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZwgvN1Qdoukr-KxBQ_GFP9Fj=wYe16_qdZxJ-oummguA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 16, 2021 at 07:45:47PM -0800, Andrii Nakryiko wrote:
> On Thu, Nov 11, 2021 at 9:02 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Without lskel the CO-RE relocations are processed by libbpf before any other
> > work is done. Instead, when lksel is needed, remember relocation as RELO_CORE
> 
> typo: lskel
> 
> > kind. Then when loader prog is generated for a given bpf program pass CO-RE
> > relos of that program to gen loader via bpf_gen__record_relo_core(). The gen
> > loader will remember them as-is and pass it later as-is into the kernel.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/lib/bpf/bpf_gen_internal.h |   3 +
> >  tools/lib/bpf/gen_loader.c       |  41 +++++++++++-
> >  tools/lib/bpf/libbpf.c           | 104 +++++++++++++++++++++++--------
> >  3 files changed, 119 insertions(+), 29 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
> > index 75ca9fb857b2..ed162fdeecf6 100644
> > --- a/tools/lib/bpf/bpf_gen_internal.h
> > +++ b/tools/lib/bpf/bpf_gen_internal.h
> > @@ -39,6 +39,8 @@ struct bpf_gen {
> >         int error;
> >         struct ksym_relo_desc *relos;
> >         int relo_cnt;
> > +       struct bpf_core_relo *core_relo;
> 
> this is named as a singular pointer to one relocation, core_relos
> would be a more natural name for an array?

I had it with "s" at the beginning, but it was forcing core_relo_cnt variable
to be called core_relos_cnt to be consistent.
And later it spills this "consistency" into uapi core_relos_cnt in bpf_attr.
But here it conflicts with line_info_cnt and func_info_cnt.
Once I realized that I went back and got rid of this "s".

> 
> > +       int core_relo_cnt;
> >         char attach_target[128];
> >         int attach_kind;
> >         struct ksym_desc *ksyms;
> > @@ -61,5 +63,6 @@ void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
> >  void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum bpf_attach_type type);
> >  void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
> >                             bool is_typeless, int kind, int insn_idx);
> 
> [...]
> 
> > @@ -6581,6 +6623,16 @@ static int bpf_program__record_externs(struct bpf_program *prog)
> >                                                ext->is_weak, false, BTF_KIND_FUNC,
> >                                                relo->insn_idx);
> >                         break;
> > +               case RELO_CORE: {
> 
> This is not an extern, it doesn't make sense to have it here. But I
> also don't understand why we need to add RELO_CORE and extend struct
> relo_desc in the first place, just to pass it as bpf_core_relo into
> gen_loader. Why can't gen_loader just record this directly at the
> place of record_relo_core() call?

Sorry. I should have explained it in commit log.
The normal libbpf flow is to process CO-RE early before call relos happen.
In case of gen_loader the core relos have to be added to other relos to be
copied together when bpf static function is appended in different places to
other main bpf progs.
During the copy the append_subprog_relos() will adjust insn_idx for
normal relos and for RELO_CORE kind too.
When that is done each struct reloc_desc has good relos for specific main prog.

Just noticed that 'insn_idx += prog->sub_insn_off;' in this patch is redundant.
That was a left over of earlier debugging.

Also in bpf_object__relocate_data() the comment:
                case RELO_CORE:
                        /* handled already */
                        break;
is not correct either.
It should read "will be handled by bpf_program__record_externs() later".
Just before bpf_object_load_prog_instance().
