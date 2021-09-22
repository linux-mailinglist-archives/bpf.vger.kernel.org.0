Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E6441532E
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 00:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhIVWIc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 18:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhIVWIc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 18:08:32 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBB0C061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 15:07:01 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q81so11449609qke.5
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 15:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpiuh4moabl3hDxZd90zt9HC9tlVM8R1WSNN3W1rx1A=;
        b=Ug+bhTQk1cScglK7PMVKks4SrywkkjVy7JG6oWv4Qb+FfTkhw+an3CoInfvqCXsSf5
         A8G0SkDNQuF8vxvZK3XMBUK9LfFXYIV7j1S1mXGyTblJgkXpoOnAfZBdNwmufM/Zd2fK
         +QVcMgeXlIyxdXltc8ZhEM5ZbEXSXKa3kAO4DKydNd+Y9zGq216BL1W95xkrQfY1gl6e
         HKgKOX90PDJONuJ8z8jzXZG74pos5t81vmVxotAPrKwivJS01KXfBuHXWMpd/RafZs89
         uF6MrPGF7UWgBs7OfO1ABFYPrCGSLxHiLHODYI2p/ii76ogvmViUoDvdcaF9hYgRkeVY
         XuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpiuh4moabl3hDxZd90zt9HC9tlVM8R1WSNN3W1rx1A=;
        b=YmHM2kUV8VC6MoT90U9+PIRM4eOU5aLYQaxuFyn4TvXJsJIn/dNEj7ixDGWYebIIEJ
         460WFgaWnJuSaTpFRdeBNz63h0rWIRxcpz6A2b0SvKZhtwnVBblRP/3UN7GGEESyCP3s
         qL122mvpL1LzbeSzg72oi4feG8yb1x7W9LdGBP/IKcg07pXDPOiSjYBX9ZT6meW1FEK6
         bKb7Zkd4/Io+pnbYJAGxjzyQ+0Xs6oD7Bbx5D5XiI9Bn1iQbQXVP4kdEkUS5jd2BUfsl
         /3RfbaUBns0KuCvjEXwgEcZgO+0pkPOFV++i+YNfIGdI/BqnBUPxLz1YTq5HOfTUZeP0
         IMuQ==
X-Gm-Message-State: AOAM530WtDFnVTaOZj1cWb9qfdwOY5+gvwJpt71R1xK5QBwaamKLRUIM
        TuLO3t/Vj3GvOu09BZWPnh+JdwSl9Fv8KTjxX0Rl/Mje
X-Google-Smtp-Source: ABdhPJwv3jCMD566K+qjOXLW7BrnFfiQupB4HETbaGFQhgCTbMXhhrRKfQFZHL9uOYaMEzIv+Y54PBUD0rIRaNS0xJk=
X-Received: by 2002:a25:fc5:: with SMTP id 188mr1626771ybp.51.1632348420683;
 Wed, 22 Sep 2021 15:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210920234320.3312820-1-andrii@kernel.org> <20210920234320.3312820-5-andrii@kernel.org>
 <2b9e2861-44ad-89bc-a2e9-04623f319a2a@fb.com>
In-Reply-To: <2b9e2861-44ad-89bc-a2e9-04623f319a2a@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Sep 2021 15:06:49 -0700
Message-ID: <CAEf4BzbS1=D678_N4jk-RtZgNkQE8NuLDbbojAjf-pXAt9MV+A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/9] libbpf: refactor internal sec_def
 handling to enable pluggability
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 5:42 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 9/20/21 7:43 PM, Andrii Nakryiko wrote:
> > Refactor internals of libbpf to allow adding custom SEC() handling logic
> > easily from outside of libbpf. To that effect, each SEC()-handling
> > registration sets mandatory program type/expected attach type for
> > a given prefix and can provide three callbacks called at different
> > points of BPF program lifetime:
> >
> >   - init callback for right after bpf_program is initialized and
> >   prog_type/expected_attach_type is set. This happens during
> >   bpf_object__open() step, close to the very end of constructing
> >   bpf_object, so all the libbpf APIs for querying and updating
> >   bpf_program properties should be available;
>
> Do you have a usecase in mind that would set this? USDT?

Don't have specific use case in mind, but this callback gives the
fully constructed `struct bpf_program` access to those custom
callbacks, so if there is any additional book keeping/feature
checking/whatever that needs to be done, this will be the earliest
point where some library/framework will discover the program. Felt
like an important addition, even if libbpf internally has no need for
it (because libbpf can always access struct bpf_program through its
own means).

>
> >   - pre-load callback is called right before BPF_PROG_LOAD command is
> >   called in the kernel. This callbacks has ability to set both
> >   bpf_program properties, as well as program load attributes, overriding
> >   and augmenting the standard libbpf handling of them;
>
> [...]
>
> > @@ -6094,6 +6100,44 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
> >       return 0;
> >  }
> >
> > +static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd, int *btf_type_id);
> > +
> > +/* this is called as prog->sec_def->preload_fn for libbpf-supported sec_defs */
> > +static int libbpf_preload_prog(struct bpf_program *prog,
> > +                            struct bpf_prog_load_params *attr, long cookie)
> > +{
> > +     /* old kernels might not support specifying expected_attach_type */
> > +     if (prog->sec_def->is_exp_attach_type_optional &&
> > +         !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
> > +             attr->expected_attach_type = 0;
> > +
> > +     if (prog->sec_def->is_sleepable)
> > +             attr->prog_flags |= BPF_F_SLEEPABLE;
> > +
> > +     if ((prog->type == BPF_PROG_TYPE_TRACING ||
> > +          prog->type == BPF_PROG_TYPE_LSM ||
> > +          prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
> > +             int btf_obj_fd = 0, btf_type_id = 0, err;
> > +
> > +             err = libbpf_find_attach_btf_id(prog, &btf_obj_fd, &btf_type_id);
> > +             if (err)
> > +                     return err;
> > +
> > +             /* cache resolved BTF FD and BTF type ID in the prog */
> > +             prog->attach_btf_obj_fd = btf_obj_fd;
> > +             prog->attach_btf_id = btf_type_id;
> > +
> > +             /* but by now libbpf common logic is not utilizing
> > +              * prog->atach_btf_obj_fd/prog->attach_btf_id anymore because
> > +              * this callback is called after attrs were populated by
> > +              * libbpf, so this callback has to update attr explicitly here
> > +              */
> > +             attr->attach_btf_obj_fd = btf_obj_fd;
> > +             attr->attach_btf_id = btf_type_id;
> > +     }
> > +     return 0;
> > +}
> > +
> We talked on VC about some general approach questions I had here, will
> summarize. Discussion touched on changes in patches 5 and 6 as well. I thought
> the pulling of these chunks into libbpf_preload_prog made sense, but wondered
> whether some of this prog-type specific functionality would also be useful to
> "average" custom sec_def writer even if it's not considered 'standard libbpf
> handling', e.g. custom sec_def writer whose SEC produces a PROG_TYPE_TRACING
> is likely to want the find_attach_btf_id niceness as well. So perhaps something
> like the ability to chain the callbacks so that sec_def writer can use libbpf's
> would be useful.
>
> Your response was that you explicitly wanted to avoid doing this because this
> would result in libbpf's callbacks becoming part of the API and stability
> requirements following from that. Furthermore, you don't anticipate libbpf's
> preload callback becoming very complicated and expect that the average
> custom sec_def writer will be familiar enough with libbpf to be able to pull
> out whatever they need.
>
> Response made sense to me, LGTM
>
> Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
