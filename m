Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E8E4598F7
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 01:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhKWALq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhKWALo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:11:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B83C061714
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:08:37 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gt5so15157756pjb.1
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZR6Ao4RLGixmxbUccPgLB1l5tsOaxtCOa9SyDc/pS0=;
        b=AYAu2u3PC4vy500pmIbDhYCrfEMYPvLJto9rmQCyD4XI4USN5f5+W8eJy2pMjWkgym
         rE8M74KF7QHEQEntto4v4tmFeYI939RIpfjibiCBoqn/GEPXuJcYODheq88NWYLDnokI
         wNsIV57fI8pKJYZYL07uLtLWNSVxhmkj7HHVS1BEZejQkGTvqIFvKkuysijduS0dh+zu
         4o9E0AOEVcM7tKIkJCmdSX318K8abIi/YY5BekB/3zdiYCatPZYnPwiaE7QlvqEc2EU6
         BPyZFGivVyZY5I32GehOYh+EdglGf7tZfubzZokd5KgJJrxCc3UWq0oHNJp50AyDJ4To
         2pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZR6Ao4RLGixmxbUccPgLB1l5tsOaxtCOa9SyDc/pS0=;
        b=YHlC5ig1t83rZKH0dy8n+ydXphxgWhY8RFOSJqvlmqubS4DasKXZ9MWexZd8wBnqtm
         qkCQpakZT2KY/v0kF2Cpfx7MgpGwzK6Rs8dnjXcNbn9XjVjA4NMvMbmoa1xfzf6HtZrk
         Tau8sOixeNue7F256YBDZiu1N+Ee9WXcKABisXH1zE4dVIgRSleM6RONox++LsOcOGqw
         LkTbprfVwZ7xvkb24LmH5uNffyX+Ky09FGyDowrAqYUtUDq1vVEokYNDyvvLu+ghcA7C
         vrhAB+1krz9ty4KusQZavarLbJO0Z1yyWuIWRBJV6ydQOJLZRGxfgWUt4o68ZTdo3zWt
         CYrg==
X-Gm-Message-State: AOAM530FrWuMbLGMl/s7cHvmS+wZ9mOr3Ysi6fjdHD6k5BLVWMTWAFTM
        mhpB4N320l435gH5cFnPWWX9aAvngF3KFCS1BANciD8O+yw=
X-Google-Smtp-Source: ABdhPJwjdRTLs/Q6vlTN4rUcDoXVhIg4bsNhQp4AnvN0IK8w4l2sJfzXIe2PkCsez+A/OYPjE3MyFADfsPIyoGfc7FQ=
X-Received: by 2002:a17:902:d491:b0:142:892d:a89 with SMTP id
 c17-20020a170902d49100b00142892d0a89mr1518249plg.20.1637626116575; Mon, 22
 Nov 2021 16:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-8-alexei.starovoitov@gmail.com> <CAEf4BzYXO_T7rLSs3aReF+oLfdjgd6WEzw9WNUynom7UOwtyNw@mail.gmail.com>
In-Reply-To: <CAEf4BzYXO_T7rLSs3aReF+oLfdjgd6WEzw9WNUynom7UOwtyNw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 22 Nov 2021 16:08:25 -0800
Message-ID: <CAADnVQ+W5YNrhk=1C41LTtuEHGR4yDZL6sXvK3d98u-gOqxAnA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 07/13] libbpf: Use CO-RE in the kernel in
 light skeleton.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 4:04 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Without lskel the CO-RE relocations are processed by libbpf before any other
> > work is done. Instead, when lskel is needed, remember relocation as RELO_CORE
> > kind. Then when loader prog is generated for a given bpf program pass CO-RE
> > relos of that program to gen loader via bpf_gen__record_relo_core(). The gen
> > loader will remember them as-is and pass it later as-is into the kernel.
> >
> > The normal libbpf flow is to process CO-RE early before call relos happen. In
> > case of gen_loader the core relos have to be added to other relos to be copied
> > together when bpf static function is appended in different places to other main
> > bpf progs. During the copy the append_subprog_relos() will adjust insn_idx for
> > normal relos and for RELO_CORE kind too. When that is done each struct
> > reloc_desc has good relos for specific main prog.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/lib/bpf/bpf_gen_internal.h |   3 +
> >  tools/lib/bpf/gen_loader.c       |  41 +++++++++++-
> >  tools/lib/bpf/libbpf.c           | 108 ++++++++++++++++++++++---------
> >  3 files changed, 119 insertions(+), 33 deletions(-)
> >
>
> [...]
>
> >         if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
> > @@ -5653,6 +5679,9 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
> >                 case RELO_CALL:
> >                         /* handled already */
> >                         break;
> > +               case RELO_CORE:
> > +                       /* will be handled by bpf_program_record_relos() */
> > +                       break;
> >                 default:
> >                         pr_warn("prog '%s': relo #%d: bad relo type %d\n",
> >                                 prog->name, i, relo->type);
> > @@ -6090,6 +6119,35 @@ bpf_object__free_relocs(struct bpf_object *obj)
> >         }
> >  }
> >
> > +static int cmp_relocs(const void *_a, const void *_b)
> > +{
> > +       const struct reloc_desc *a = _a;
> > +       const struct reloc_desc *b = _b;
> > +
> > +       if (a->insn_idx != b->insn_idx)
> > +               return a->insn_idx < b->insn_idx ? -1 : 1;
> > +
> > +       /* no two relocations should have the same insn_idx, but ... */
> > +       if (a->type != b->type)
> > +               return a->type < b->type ? -1 : 1;
> > +
> > +       return 0;
> > +}
> > +
> > +static void bpf_object__sort_relos(struct bpf_object *obj)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < obj->nr_programs; i++) {
> > +               struct bpf_program *p = &obj->programs[i];
> > +
> > +               if (!p->nr_reloc)
> > +                       continue;
> > +
> > +               qsort(p->reloc_desc, p->nr_reloc, sizeof(*p->reloc_desc), cmp_relocs);
> > +       }
> > +}
> > +
> >  static int
> >  bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
> >  {
> > @@ -6104,6 +6162,8 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
> >                                 err);
> >                         return err;
> >                 }
> > +               if (obj->gen_loader)
> > +                       bpf_object__sort_relos(obj);
>
> libbpf sorts relos because it does binary search on them (see
> find_prog_insn_relo).

exactly.
After co-re relos were added the array has to be sorted again.
find_prog_insn_relo() will be called after this step.
