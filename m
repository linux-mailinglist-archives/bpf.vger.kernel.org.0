Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEC32F62CF
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 15:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbhANOOK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 09:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbhANOOJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 09:14:09 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25FDC061575;
        Thu, 14 Jan 2021 06:13:29 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z5so11316426iob.11;
        Thu, 14 Jan 2021 06:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=fbtwZM+uKeBRUOgD7mvL1INeuyd+8TFMde/KmwBC0jY=;
        b=nsMgpBpB2BuEMBBvDhB4ISzRmWXJUH1soL35AhJHtAFfb1XdYFYqo6SZtXJ9X7bnqi
         mTCXJU+dnOGYtnKeXx8EzlT9bL2Iqj7oQbd6rRWU70NXDe+DBMgblMfl58gVeKh5J1Vl
         sgtiqjIDqG9qgGh1/94phAB0z0Otrjd9VsgDtCutBB4m4bWGV5MPOkiuFPwFoMfog82p
         hsR+CkzQWVoMqxbPmmkdVitb8VwwiKs3vnpl9aT2E2ftWXq/TsKxHSh35weSWn9iX7UT
         0ZbMC+biSljAUZME9aLX8RVFQ0aJBo0d5APqrMWIrg05MeG089Yxss8BqoN2ooNjQCZM
         X9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=fbtwZM+uKeBRUOgD7mvL1INeuyd+8TFMde/KmwBC0jY=;
        b=oAoBl6hiP3GUo7bVuXM2nXA7PNJwmQ/J/pMpxPFYngofbFQdvAKyTe+9GEgcHGVxyq
         0paNgRN7vbtNBl3BX9oXWiefGPMb8dDwdVJHoP1pv7uahAQ1WpLygVl38LwXIkf5Gw1o
         Q8yVymiNBJO1sqMH0uxsI3dhVIcKpz/4Wq2vlIJkxbsJOO7rRsVGJK9QUH/uHkaVD2u7
         Tg5fq8bGGl04Bhj9xkYypAv6RUoiR2T9gXWKCKSrhksLSJYkdp8XJsgUQmVIamt6sQzk
         sb1YdtZAbjP6M7d5Pes+SDZbIr8meUKdKakHXxp/P36eD4QgTOvtzbkG36p99fPkEQ7T
         oKFQ==
X-Gm-Message-State: AOAM531S/rfMOOQ5+qH1TtdyJt36njbd06EOtNWQeHjmiff+TUgQTZPb
        nHMd+w71qFZ9dBUdF6/588njic0by55wblc1/VA=
X-Google-Smtp-Source: ABdhPJx9R+87WqA2lLUol3MapdgzAdocSQI8+F0kw3wfU9ejIh3raCJFhJ331jeGBp6ycL6sTQsSW9+ZBP3GKRkMa/Q=
X-Received: by 2002:a05:6e02:eb0:: with SMTP id u16mr6683229ilj.209.1610633608924;
 Thu, 14 Jan 2021 06:13:28 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com> <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com> <20210111223144.GA1250730@krava>
In-Reply-To: <20210111223144.GA1250730@krava>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 15:13:18 +0100
Message-ID: <CA+icZUWaMktPBYy9P-gbgL-AD7EEPrrvS4jenahJ-3HkxOOC0g@mail.gmail.com>
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 11, 2021 at 11:31 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jan 11, 2021 at 10:30:22PM +0100, Sedat Dilek wrote:
>
> SNIP
>
> > > >
> > > > Building a new Linux-kernel...
> > > >
> > > > - Sedat -
> > > >
> > > > [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> > > > [2] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758026878
> > > > [3] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758056553
> > >
> > > There are no significant bug fixes between pahole 1.19 and master that
> > > would solve this problem, so let's try to repro this.
> > >
> >
> > You are right pahole fom latest Git does not solve the issue.
> >
> > + info BTFIDS vmlinux
> > + [  != silent_ ]
> > + printf   %-7s %s\n BTFIDS vmlinux
> >  BTFIDS  vmlinux
> > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > FAILED: load BTF from vmlinux: Invalid argument
>
> hm, is there a .BTF section in vmlinux?
>
> is this working over vmlinux:
>  $ bpftool btf dump file ./vmlinux
>

I switched to LLVM v12 from <apt.llvm.org> and saw the same FAILED line.

The generated vmlinux file is cleaned on failure.

+ info BTFIDS vmlinux
+ [  != silent_ ]
+ printf   %-7s %s\n BTFIDS vmlinux
 BTFIDS  vmlinux
+ ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
FAILED: load BTF from vmlinux: Invalid argument
+ on_exit
+ [ 255 -ne 0 ]
+ cleanup
+ rm -f .btf.vmlinux.bin.o
+ rm -f .tmp_System.map
+ rm -f .tmp_initcalls.lds
+ rm -f .tmp_symversions.lds
+ rm -f .tmp_vmlinux.btf .tmp_vmlinux.kallsyms1
.tmp_vmlinux.kallsyms1.S .tmp_vmlinux.kallsyms1.o
.tmp_vmlinux.kallsyms2 .tmp_vmlinux.kallsyms2.S .tmp_vmlinux.kallsyms
2.o
+ rm -f System.map
+ rm -f vmlinux
+ rm -f vmlinux.o

Dunno, how to suppress this.

- Sedat -

> do you have a verbose build output? I'd think pahole scream first..
>
> jirka
>
