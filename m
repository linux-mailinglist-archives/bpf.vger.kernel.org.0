Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D14B44BAA0
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 04:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhKJDeH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 22:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhKJDeH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 22:34:07 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4614AC061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 19:31:20 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g19so1367302pfb.8
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 19:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSi6d/3dkdOLTU33LFD1wVF1rR6+Yw8EKeKMLxyBr7g=;
        b=f8RquG7YphckPt49cOHG5UBX80SlDEObMnjbmjKNpvl+QMQXehyZOAu7gEiJV+GP4r
         ex3Bxob9RXW52XtyVGhv2L4CcrENP029Ym30sM2zDgxRlUMTf9sHV9CDaQV97DmGj9Mt
         S/6/eXIVcWBtwT70o85zQB6saVl+cHY/ORrzDB1Fx7/CTvwWbZO8Ll3aqn9xX97jBXJo
         DLAieZwbCQxkvWl0tB8U2tN6ZQL4w0xPv6jtrHX3ZlNcXXVwWkd7w9IqMi3o7oGRPX1i
         kcfVnWRGG75xlTRNYZneS4F/vYzT9xFhEL2J/JQtovm5Igbulb42ar/KVj/rpjx/8mfd
         ZCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSi6d/3dkdOLTU33LFD1wVF1rR6+Yw8EKeKMLxyBr7g=;
        b=01ZRPYBmyNDkzIo1wllFCWviedLCQLXK+HllMgravWRUka6dg4aa0kY6iESAQWlaNX
         aCvfi7AqKTHLrpfouSVb1+Hx1r/dz9hFlCiimliYUdAUAPDlyKMtW+f4wX1P8+vJHu2F
         ukh7X3C9l3mwaGe8D9KaIO5gVcvnLvcNBA3h4dhOuWNIDf39pBtwQI+UWT2a2dfwFuwm
         anmVZUSaNUzyI7jP5KuZrRzQeecxxFv8ujwxMQBZrWI31XlBc+wOO11XjtjT3Drv6P17
         N+IBpab3qlVEv37UlND+LuPYsNyCC8nDztzVRRyv5nDIURWIzX5xejJuXQX1L1XaJoCu
         JRQQ==
X-Gm-Message-State: AOAM533h/WimAi2T0EfsRZGfx8a6JCuk2viLcQQYucNSrZHfbMEUrC47
        45iAdyJLD8DT8tZecD2cAWjUh4VZP6UTTI05uy0mf/ht
X-Google-Smtp-Source: ABdhPJySPj2pbUHOtVssqqeXSmhOg/PmBEKZzD1ETHDui1+sDf0TDpVuEeM5Eg395rEz8Z3T8FUH/MhxYIuN35IVKlA=
X-Received: by 2002:a05:6a00:1310:b0:494:672b:1e97 with SMTP id
 j16-20020a056a00131000b00494672b1e97mr47373187pfu.77.1636515078752; Tue, 09
 Nov 2021 19:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20211103220845.2676888-1-andrii@kernel.org> <20211103220845.2676888-11-andrii@kernel.org>
 <CAADnVQKZf+k0=+Yees92nuWQa4NKxMR_XrfRDvuCOUYUZ3p0dQ@mail.gmail.com> <CAEf4Bzaq1FUjQPt1_rrBvG=X8o+2YRSN+DR56_Tu18Vte4UsTQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzaq1FUjQPt1_rrBvG=X8o+2YRSN+DR56_Tu18Vte4UsTQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Nov 2021 19:31:07 -0800
Message-ID: <CAADnVQKxfaGbbqSbJ3twR6So-=bNmau63+rqFySq+kt2pqASuQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/12] selftests/bpf: merge test_stub.c into testing_helpers.c
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 6:38 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 9, 2021 at 5:48 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 3, 2021 at 3:09 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > Move testing prog and object load wrappers (bpf_prog_test_load and
> > > bpf_test_load_program) into testing_helpers.{c,h} and get rid of
> > > otherwise useless test_stub.c. Make testing_helpers.c available to
> > > non-test_progs binaries as well.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ...
> > > -int extra_prog_load_log_flags = 0;
> > > -
> > > -int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
> > > -                      struct bpf_object **pobj, int *prog_fd)
> > > -{
> > > -       struct bpf_prog_load_attr attr;
> > > -
> > > -       memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
> > > -       attr.file = file;
> > > -       attr.prog_type = type;
> > > -       attr.expected_attach_type = 0;
> > > -       attr.prog_flags = BPF_F_TEST_RND_HI32;
> > > -       attr.log_level = extra_prog_load_log_flags;
> > > -
> > > -       return bpf_prog_load_xattr(&attr, pobj, prog_fd);
> > > -}
> >
> > > +int extra_prog_load_log_flags = 0;
> > > +
> > > +int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
> > > +                      struct bpf_object **pobj, int *prog_fd)
> > > +{
> > > +       struct bpf_object *obj;
> > > +       struct bpf_program *prog;
> > > +       int err;
> > > +
> > > +       obj = bpf_object__open(file);
> > > +       if (!obj)
> > > +               return -errno;
> > > +
> > > +       prog = bpf_object__next_program(obj, NULL);
> > > +       if (!prog) {
> > > +               err = -ENOENT;
> > > +               goto err_out;
> > > +       }
> > > +
> > > +       if (type != BPF_PROG_TYPE_UNSPEC)
> > > +               bpf_program__set_type(prog, type);
> > > +
> > > +       err = bpf_object__load(obj);
> > > +       if (err)
> > > +               goto err_out;
> > > +
> > > +       *pobj = obj;
> > > +       *prog_fd = bpf_program__fd(prog);
> > > +
> > > +       return 0;
> > > +err_out:
> > > +       bpf_object__close(obj);
> > > +       return err;
> > > +}
> >
> > Andrii,
> > That part of the commit broke verbose output in the test.
> > -v and -vv no longer work for tests that use bpf_prog_test_load()
> > because extra_prog_load_log_flags are ignored.
> >
> > Please fix.
>
> Ah, right, sorry, I should have used bpf_object__load_xattr() and
> passed those extra_prog_load_log_flags to it. I'll fix it.

Thanks. It's no rush.

> How important are BPF_F_TEST_RND_HI32 flags, btw? We need a
> bpf_program__set_extra_flags() to be able to set them, I'll add that
> as well. "extra" because they will be |'d with whatever the flags are
> determined by SEC_DEF().

I think it was useful in the past and recently RND_HI32 caused Martin
an extra day of painful debugging, but in the end, I think, it was
great that it was there.
Martin, pls correct me if I'm misremembering.
