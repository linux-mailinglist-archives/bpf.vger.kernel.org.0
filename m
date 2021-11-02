Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DDB4425BF
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 03:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhKBCzf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 22:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhKBCzf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 22:55:35 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50626C061714
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 19:53:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v138so43980893ybb.8
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 19:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6kyf6zX9maWsAMQUG8SgWqnlHe5Zv6zFl96ef2EsVo=;
        b=eIEF2zGwc9FZNU8iuGu16QZoMqQQkzU3qr6Jw5dMnKGTUQvKRfOJsCYo1zRlRpJ6Hb
         4FDpFb9yBsGdXxiH5AYXYlV1oWumAIB1NeVS+U+DYeP3qi4UZbSsoEn29sT6SZ4+NpUi
         PTsajshLDOay2kgxzIg8WHMqGTIT68NUuyUwKrDrfQ7jNfqOO5WUyUaWDx/6yeE8z20l
         TAwhOm76aWtMAI3C7mkxlqn2ys+rDHsHyJVwHaOv0l0MUm8W9Lzz8gyostovhx9XEa5+
         QshgIP+EhAEHP4PbnmJoeTqQ6AjT0729koabtNlEtbmoEou0gILbs7GxiTgo0fyBmhff
         D8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6kyf6zX9maWsAMQUG8SgWqnlHe5Zv6zFl96ef2EsVo=;
        b=45JEQx+1EzUYzb3q+xFt8StQTDYGd7zgSeD0NGub70lsjhPwL1f+vWDIowVbJsWwK7
         W/eZZudgmkR1URf2w/GpCyBuuea/Q2PYi+KPFjl+D1cvfgkgxJkHWcg0UCSfxaBUoFGF
         RNS1kGoHEcO4nLVm2vbf6TuAMN/jOrMNlPOGOx2HCF4eZSGJxtHb5ROOJ3xiksxyTq/e
         M38bK4nISKK3c7ghKXZw4juH6+7iMBfEbaqmEP/WcwmI39+7OBfdC20+cEIWKiblnNZO
         zHEDL99lrHu/FO62duHEOZgygIeGo2WzDcY2zPXA/jwLD/g7Bd8g3LjHOSaKSXivgzzU
         hK+Q==
X-Gm-Message-State: AOAM53102BwIdGB81FOhgCqiu0dbW8diVLWyNcH7jTSM8vewxhSI7XGs
        fv8eN3ETupNmjSk4D+tUhFLyQUwgiOpcZ4xsnnw=
X-Google-Smtp-Source: ABdhPJxZ1U8JOw83zfqoKqCCAqrzIVq2IzGMpEWsOBt+6kZTAzkalRFL18PkHQ+5St0nasSSnZ4A533hjdRRe449qug=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr34854489ybf.114.1635821580528;
 Mon, 01 Nov 2021 19:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211030045941.3514948-1-andrii@kernel.org> <20211030045941.3514948-6-andrii@kernel.org>
 <20211102023322.6nelw3v7hxplq6lu@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211102023322.6nelw3v7hxplq6lu@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Nov 2021 19:52:49 -0700
Message-ID: <CAEf4BzYC0r_ye=dDP704qNnrVmeAMYFSL-J7MmQhmo1Dge99_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/14] libbpf: unify low-level BPF_PROG_LOAD APIs
 into bpf_prog_load()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 1, 2021 at 7:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 29, 2021 at 09:59:32PM -0700, Andrii Nakryiko wrote:
> > -int bpf_prog_load(const char *file, enum bpf_prog_type type,
> > -               struct bpf_object **pobj, int *prog_fd)
> > +COMPAT_VERSION(bpf_prog_load_deprecated, bpf_prog_load, LIBBPF_0.0.1)
> > +int bpf_prog_load_deprecated(const char *file, enum bpf_prog_type type,
> > +                          struct bpf_object **pobj, int *prog_fd)
> ..
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 43580eb47740..b895861a13c0 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -395,6 +395,8 @@ LIBBPF_0.6.0 {
> >               bpf_object__next_program;
> >               bpf_object__prev_map;
> >               bpf_object__prev_program;
> > +             bpf_prog_load_deprecated;
> > +             bpf_prog_load;
> >               bpf_program__insn_cnt;
> >               bpf_program__insns;
> >               btf__add_btf;
>
> Is it really LIBBPF_0.0.1 ? or 0.6.0 ? which one is correct.
> Maybe I'm misreading what COMPAT macro will do.

I followed very closely what was done for xsk_umem__create. Original
bpf_prog_load was introduced in LIBBPF_0.0.1, so COMPAT_VERSION has to
use that version. And then a new bpf_prog_load is added in
LIBBPF_0.6.0, so DEFAULT_VERSION is referencing that one.

What this should mean in practice is that if someone specifically
requests bpf_prog_load@LIBBPF_0.0.1 (which should be everything that
was compiled with libbpf v0.0.1 through v0.5), they would use old
6-arg version of bpf_prog_load. Anything compiled starting from v0.6+
will use bpf_prog_load@LIBBPF_0.6.0. If anyone just references
bpf_prog_load (not sure how to do that with C, tbh), they will default
to bpf_prog_load@LIBBPF_0.6.0.

And then when someone compiles against libbpf v0.6+ and indeed uses
old bpf_prog_load w/ 6 args, they will be actually compiling against
bpf_prog_load_deprecated@LIBBPF_0.6.0 due to the ___libbpf_overload()
magic.

But this is certainly confusing, I've spent a bunch of time staring at
xsk_umem__create().
