Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBBF4355C8
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 00:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhJTWSR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 18:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTWSR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 18:18:17 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE06C061749
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 15:16:02 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id l20so10019954vkm.8
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lECod4R5U76XtDGPrH95ZXDNaUdG9uyXME174JahyhA=;
        b=QwfGpOoSJIXN/Y+b5T/yi1Ma886ZT0Jn60uAIjwVB+Hk8FVHK1I7illsqTMPKvbLxS
         9RV2IK/h8oUyjChLAAJIxUHRoySbY3frLAJLKiuNpptHU2HFZZRlENxztXj14GNEhBiR
         fEw/cQtvbNR6pbe3R21bw6mAqcaYKOrn8C8bP3gtQLfY3++RPEq0ifi1Z9Y9fiJJK9IT
         3xVV+anQuS7M4NgMeKSntLYBrXOBOBxPDIl+HPVGxYornjdb4Y7FALfJPZQI3rZvJG5G
         vtSE3EbWVbhZyCgdXwC72yJS1fEhSCWoufmt3NiHQ8/yvYD4OwILKGDVNOd0EchQj3mQ
         QqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lECod4R5U76XtDGPrH95ZXDNaUdG9uyXME174JahyhA=;
        b=A+sc79oineMK2hmECT9x0sYKSNPpYuvPBzY433Mn9u48NKjUMs0fbihLPYZznHwFZJ
         xVd7kb7oBGWCFcqaveZFCI6wFJWoVlWTSncwIvUYW1Qr1hh1xcteXJOUL4UXndTXSAmn
         Ul4gLxBLIfj59CNijvPtL4MyA6XDczHsPoI1qLXK8sR7n/BeNfqcOaHBfKPhPj5HK1Ys
         /rpZQqvQ2TYYFXvAboF8tQViV/xe3P+AScJU4CveGrh8lUHscAP0bgKTL9uI2SnyE00j
         V0PADH7pdqvm61Nukag7SqZkuwqaOerKz+4kcULo8RFfBb4I+AKuyb6R3HZEYGngbhLM
         tZDg==
X-Gm-Message-State: AOAM532q6KQzbIADX/U7uR3xJQwP+6EaE8j+CS6RwnxvFbqPh/KDloFs
        OnLTtWLAxyeKwIWH4d+LCcY+jGEGKrlkCoPrsll56u2mXKo0xNz8
X-Google-Smtp-Source: ABdhPJyVmd+cm1qMWIqALoWKtgj3UtuUUAV9hlheXWIl4GiK9syweF/KHj7lx2MYNEVzDK22ypJ8wCP/9I1syIB18aY=
X-Received: by 2002:a05:6122:550:: with SMTP id y16mr2125425vko.18.1634768161157;
 Wed, 20 Oct 2021 15:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211011082031.4148337-1-davemarchevsky@fb.com>
 <20211011082031.4148337-3-davemarchevsky@fb.com> <CAEf4BzZk=fO8YNR9VQYUodSATp76XpRD6xd+pXMF90KummFwqQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZk=fO8YNR9VQYUodSATp76XpRD6xd+pXMF90KummFwqQ@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Wed, 20 Oct 2021 23:15:49 +0100
Message-ID: <CACdoK4LnHvpB2idD33R_gC3cn4C6Fw8W5zuikQu8OQqwXQJQGA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpftool: use bpf_obj_get_info_by_fd directly
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 20 Oct 2021 at 18:37, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 11, 2021 at 1:20 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > To prepare for impending deprecation of libbpf's
> > bpf_program__get_prog_info_linear, migrate uses of this function to use
> > bpf_obj_get_info_by_fd.
> >
> > Since the profile_target_name and dump_prog_id_as_func_ptr helpers were
> > only looking at the first func_info, avoid grabbing the rest to save a
> > malloc. For do_dump, add a more full-featured helper, but avoid
> > free/realloc of buffer when possible for multi-prog dumps.
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > ---
> >  tools/bpf/bpftool/btf_dumper.c |  40 +++++----
> >  tools/bpf/bpftool/prog.c       | 154 +++++++++++++++++++++++++--------
> >  2 files changed, 144 insertions(+), 50 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> > index 9c25286a5c73..0f85704628bf 100644
> > --- a/tools/bpf/bpftool/btf_dumper.c
> > +++ b/tools/bpf/bpftool/btf_dumper.c
> > @@ -32,14 +32,16 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
> >                                     const struct btf_type *func_proto,
> >                                     __u32 prog_id)
> >  {
> > -       struct bpf_prog_info_linear *prog_info = NULL;
> >         const struct btf_type *func_type;
> > +       int prog_fd = -1, func_sig_len;
> > +       struct bpf_prog_info info = {};
> > +       __u32 info_len = sizeof(info);
> >         const char *prog_name = NULL;
> > -       struct bpf_func_info *finfo;
> >         struct btf *prog_btf = NULL;
> > -       struct bpf_prog_info *info;
> > -       int prog_fd, func_sig_len;
> > +       struct bpf_func_info finfo;
> > +       __u32 finfo_rec_size;
> >         char prog_str[1024];
> > +       int err;
> >
> >         /* Get the ptr's func_proto */
> >         func_sig_len = btf_dump_func(d->btf, prog_str, func_proto, NULL, 0,
> > @@ -55,22 +57,27 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
> >         if (prog_fd == -1)
>
> please change this to (prog_fd < 0), see [0] for why
>
> we should check all the other places in bpftool to see if there are
> any patterns like this that would break on libbpf 1.0 (cc Quentin as
> well)
>
>   [0] https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#direct-error-code-returning-libbpf_strict_direct_errs

Hi! Looking at bpftool's code (looking for "-1"), I could find only
two occurrences of that pattern, one in btf_dumper.c as noted above,
and another one in struct_ops.c:

    fd = bpf_map_get_fd_by_id(id);
    if (fd == -1) {
        [...]
    }

Dave, are you willing to address it as well? I can send a patch later
this week otherwise.

Thanks,
Quentin
