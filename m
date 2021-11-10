Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B45B44BA66
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 03:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhKJCl2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 21:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhKJCl2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 21:41:28 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44961C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 18:38:41 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id a129so2524131yba.10
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 18:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmfYb2YkSWWZBb5FwITsY/5QUaX6Zww1kSa4wQon1UM=;
        b=WPaidh944mfWEz2DkHHx8j58VTdsLLNqcy+5WOAJrKhKxSl5/XYvLWy16BCJwIOXDS
         jpnAPknpJOBC987wy27zmNvUQFQf+wKVRO3g/KeJzI113VfKHsybfyoIcsh4WDcfuZpN
         nUImmcJNYtWSnEvySFY78qcQI+f/YqPN36xiUkagTPlHoHvp7nb5CLcazRLxr4yeoIgk
         HFS7Tg+wFcPevDUoZ64xhIPguyKJJSy1OPy2QMIi6jd0nGLGQyuobDk7jMW5EK9CCMG0
         gO78x9QtTF1ZHa1EVHNGu3D8RC34UK1vdEIgzVT6lCPdVryKcVejkL/s7Tp+twIvEuYG
         q3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmfYb2YkSWWZBb5FwITsY/5QUaX6Zww1kSa4wQon1UM=;
        b=SoUhW2GWhTIGbSTpckHcI8jiZq4WDMXTLrsf2KeICZe+7tZvnAQwdqh65O2jC+jDM8
         KPgq1J2XgS4EvCWYWtom0D6rsOEBEXlOIeVOzpsYhuRT5lp0Ob2GSrH8JqtxLzt3a8wp
         zZvKAI+AelpiAYWfJzX6O4wvRWHcVCG82GzVOOuhk2hf25npBJFLFQGAeRzE4KFYdyMz
         mBgxyKydRf1p/dkBp2TmhiVJlSNZnoGTjcpXeA85JdJVFMhEA2HhTKy4eU5x1v23Jx0j
         NR6EIGK22i8eL+G8XQx/CUR6kSKIKV61Gn5H/CHY3JZlAkSWxmgqEHwVJZ02C02g0fLR
         I9yg==
X-Gm-Message-State: AOAM531w4rnjNC6nI74yNmrmoRjsKoHV6rwobzhaiPsf9YUzP62Zpg6d
        BVRjRpRbFxarz+l5qM1irVxXoHLsRs4y3MQ9A/OEnVcdTB4=
X-Google-Smtp-Source: ABdhPJx+Qp/pYQGjWBFGzPDPCIJwqMDR3IrOTMNwROGFjhcDDdlijqpRxXx/0VuHzHAuW9jZ9o6kqReLnUl3XT54yiQ=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr14277426ybf.114.1636511920546;
 Tue, 09 Nov 2021 18:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20211103220845.2676888-1-andrii@kernel.org> <20211103220845.2676888-11-andrii@kernel.org>
 <CAADnVQKZf+k0=+Yees92nuWQa4NKxMR_XrfRDvuCOUYUZ3p0dQ@mail.gmail.com>
In-Reply-To: <CAADnVQKZf+k0=+Yees92nuWQa4NKxMR_XrfRDvuCOUYUZ3p0dQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 18:38:29 -0800
Message-ID: <CAEf4Bzaq1FUjQPt1_rrBvG=X8o+2YRSN+DR56_Tu18Vte4UsTQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/12] selftests/bpf: merge test_stub.c into testing_helpers.c
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

On Tue, Nov 9, 2021 at 5:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 3, 2021 at 3:09 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Move testing prog and object load wrappers (bpf_prog_test_load and
> > bpf_test_load_program) into testing_helpers.{c,h} and get rid of
> > otherwise useless test_stub.c. Make testing_helpers.c available to
> > non-test_progs binaries as well.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ...
> > -int extra_prog_load_log_flags = 0;
> > -
> > -int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
> > -                      struct bpf_object **pobj, int *prog_fd)
> > -{
> > -       struct bpf_prog_load_attr attr;
> > -
> > -       memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
> > -       attr.file = file;
> > -       attr.prog_type = type;
> > -       attr.expected_attach_type = 0;
> > -       attr.prog_flags = BPF_F_TEST_RND_HI32;
> > -       attr.log_level = extra_prog_load_log_flags;
> > -
> > -       return bpf_prog_load_xattr(&attr, pobj, prog_fd);
> > -}
>
> > +int extra_prog_load_log_flags = 0;
> > +
> > +int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
> > +                      struct bpf_object **pobj, int *prog_fd)
> > +{
> > +       struct bpf_object *obj;
> > +       struct bpf_program *prog;
> > +       int err;
> > +
> > +       obj = bpf_object__open(file);
> > +       if (!obj)
> > +               return -errno;
> > +
> > +       prog = bpf_object__next_program(obj, NULL);
> > +       if (!prog) {
> > +               err = -ENOENT;
> > +               goto err_out;
> > +       }
> > +
> > +       if (type != BPF_PROG_TYPE_UNSPEC)
> > +               bpf_program__set_type(prog, type);
> > +
> > +       err = bpf_object__load(obj);
> > +       if (err)
> > +               goto err_out;
> > +
> > +       *pobj = obj;
> > +       *prog_fd = bpf_program__fd(prog);
> > +
> > +       return 0;
> > +err_out:
> > +       bpf_object__close(obj);
> > +       return err;
> > +}
>
> Andrii,
> That part of the commit broke verbose output in the test.
> -v and -vv no longer work for tests that use bpf_prog_test_load()
> because extra_prog_load_log_flags are ignored.
>
> Please fix.

Ah, right, sorry, I should have used bpf_object__load_xattr() and
passed those extra_prog_load_log_flags to it. I'll fix it.

How important are BPF_F_TEST_RND_HI32 flags, btw? We need a
bpf_program__set_extra_flags() to be able to set them, I'll add that
as well. "extra" because they will be |'d with whatever the flags are
determined by SEC_DEF().
