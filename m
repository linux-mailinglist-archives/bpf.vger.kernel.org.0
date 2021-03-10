Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E650E333446
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 05:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhCJEPK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Mar 2021 23:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhCJEPC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Mar 2021 23:15:02 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83247C06174A;
        Tue,  9 Mar 2021 20:15:02 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id f4so16376225ybk.11;
        Tue, 09 Mar 2021 20:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yb+DAeXY8fjj3uVHSKBSmiEMZlKPIYdwOJEhkapNRLc=;
        b=YGqMS0jmXkDnRry5paNRJJDTaBWL4SlPRi5/jHDJdbr2m1hpyWfPHqLQFTFGyRZ9/X
         EVT3c4+u+nOkYYGwsw6tYhDodYp411jkinlVa1ZJq7Su2eJlIXpMJqCZ9JAhTAh1FDWg
         WpUD/HDia8MDqMd+njNzHfkcqaS3QqBe4vNjpiYG1r/T2w53tMkdeWb4dV+oglX4Curu
         wcmDsdPZc6HFA8gmCwITf0qlFALlz0/rwZNPj648CotNlUoT7sKuwynEwvEAHBBY67Kd
         Ei+b9bAvef3wCBdEi3Qdx+UlZwVcCFqzrfb7rDa7kHdsqOUIDg62DvrRH/Rx8ccGDKOJ
         Ls5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yb+DAeXY8fjj3uVHSKBSmiEMZlKPIYdwOJEhkapNRLc=;
        b=NHfuifmdgZdJx1dkMpHWxA3ae5qWB8sC4uN7oQuVXcwv9u+CE+L/TpJ55nRtWM5MGg
         9voA5lzUimq6mERAvl+r3pIzBUrX3uOnsI1qXipY2Gaqd3vxTfvOjSimvv1nLJOat8BZ
         6+VIyBqcFVvcLhsfsopCSUHzIlsP9sH6x0oa4xzh0AhlgxciKfnN5K2oZ5ViAtUEJ+DV
         V6E3aaBaO9Heq79F2FC5OYau8IDc6rnRzKRohSTqbtZdK7FBZM5RUOt7BeYeCSEiZafX
         aIBGWFqhb5yGJTQ3RQT5OewDMihjtXXIEqQJYk74e13jtGfLbykcvQxMK9xQ2Xz6l3cr
         84Lw==
X-Gm-Message-State: AOAM532fZQ8dSGsPil0nSFGCErh0VBhMtYEMVl61vJlbGwXy+07AxpwE
        SP2x1d6jfOl4i1r24FAlO9zYhTYuLXmtDCfJGwAkudAmAdg=
X-Google-Smtp-Source: ABdhPJxbfR3uYR/PUEB69L9RoKbqKjmI1ERhgBvrFSduRF56mH4AtstuP7BqSEF748LaB7aXXr0FXuETthTlyY0CmJM=
X-Received: by 2002:a25:7d07:: with SMTP id y7mr1506154ybc.425.1615349701685;
 Tue, 09 Mar 2021 20:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20210308235913.162038-1-iii@linux.ibm.com> <YEdglMDZvplD6ELk@kernel.org>
 <CAEf4BzaN0XwrAaTNe4TojT8UfStvGUfQSJuSQ8CcMtLAgOu9iw@mail.gmail.com> <051e4d6b000af07cc65a8dc70f4589fa3bd4be78.camel@linux.ibm.com>
In-Reply-To: <051e4d6b000af07cc65a8dc70f4589fa3bd4be78.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Mar 2021 20:14:50 -0800
Message-ID: <CAEf4BzZo4DJJgB57wrkDZCzBGf876ixZBjQrJE4XM_y7OTDKKQ@mail.gmail.com>
Subject: Re: [PATCH dwarves v2] btf: Add support for the floating-point types
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 9, 2021 at 1:57 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Tue, 2021-03-09 at 13:37 -0800, Andrii Nakryiko wrote:
> > On Tue, Mar 9, 2021 at 3:48 AM Arnaldo Carvalho de Melo <
> > acme@kernel.org> wrote:
> > >
> > > Em Tue, Mar 09, 2021 at 12:59:13AM +0100, Ilya Leoshkevich
> > > escreveu:
> > > > Some BPF programs compiled on s390 fail to load, because s390
> > > > arch-specific linux headers contain float and double types.
> > > >
> > > > Fix as follows:
> > > >
> > > > - Make the DWARF loader fill base_type.float_type.
> > > >
> > > > - Introduce libbpf compatibility level command-line parameter, so
> > > > that
> > > >   pahole could be used to build both the older and the newer
> > > > kernels.
> > > >
> > > > - libbpf introduced the support for the floating-point types in
> > > > commit
> > > >   986962fade5, so update the libbpf submodule to that version and
> > > > use
> > > >   the new btf__add_float() function in order to emit the
> > > > floating-point
> > > >   types when not in the compatibility mode and
> > > > base_type.float_type is
> > > >   set.
> > > >
> > > > - Make the BTF loader recognize the new BTF kind.
> > > >
> > > > Example of the resulting entry in the vmlinux BTF:
> > > >
> > > >     [7164] FLOAT 'double' size=8
> > > >
> > > > when building with:
> > > >
> > > >     LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --
> > > > libbpf_compat=0.4.0
> > >
> > > I'm testing it now, and added as a followup patch the man page
> > > entry,
> > > please check that the wording is appropriate.
> > >
> > > Thanks,
> > >
> > > - Arnaldo
> > >
> > > [acme@five pahole]$ vim man-pages/pahole.1
> > > [acme@five pahole]$ git diff
> > > diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> > > index 352bb5e45f319da4..787771753d1933b1 100644
> > > --- a/man-pages/pahole.1
> > > +++ b/man-pages/pahole.1
> > > @@ -199,6 +199,12 @@ Path to the base BTF file, for instance:
> > > vmlinux when encoding kernel module BTF
> > >  This may be inferred when asking for a /sys/kernel/btf/MODULE,
> > > when it will be autoconfigured
> > >  to "/sys/kernel/btf/vmlinux".
> > >
> > > +.TP
> > > +.B \-\-libbpf_compat=LIBBPF_VERSION
> > > +Produce output compatible with this libbpf version. For instance,
> > > specifying 0.4.0 as
> > > +the version would encode BTF_KIND_FLOAT entries in systems where
> > > the vmlinux DWARF
> > > +information has float types.
> >
> > TBH, I think it's not exactly right to call out libbpf version here.
> > It's BTF "version" (if we had such a thing) that determines the set
> > of
> > supported BTF kinds. There could be other libraries that might want
> > to
> > parse BTF. So I don't know what this should be called, but
> > libbpf_compat is probably a wrong name for it.
>
> BTF version seems to exist: btf_header.version. Should we maybe bump
> this?

That seems excessive. If the kernel doesn't use FLOATs, then no one
would even notice a difference. While if we bump this version, then
everything will automatically become incompatible.

>
> >
> > If we do want to teach pahole to not emit some parts of BTF, it
> > should
> > probably be a set of BPF features, not some arbitrary library
> > versions.
>
> I thought about just adding --btf-allow-floats, but if new features
> will be added in the future, the list of options will become unwieldy.
> So I thought it would be good to settle for something that increases
> monotonically.
>

BTF_KIND_FLOAT is the first extension in a long while. I'd worry about
the proliferation of new options when we actually see some proof of
that being a problem in practice.
