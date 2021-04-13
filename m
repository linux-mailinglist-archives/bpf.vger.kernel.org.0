Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9838A35E8EC
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 00:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhDMWOH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 18:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239787AbhDMWOG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 18:14:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C3C061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:13:45 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l14so18234022ljb.1
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxcwQ9a5BCidy2dFa/9nps2Mc0FbsWt6S03lB71Vb3Q=;
        b=ZjqtP3fIiAnYZIl+Q5Uyrrma219zuNfWpU0gIwK6SNT3jkWKTvuc+9HHtNfxFnR8HS
         AzCPXGqB7k+qerRhdl/3tdQFaWYOVfBBjpk2b98litPJzocqaOKZMIw9/Mq7NOkn8JWn
         FXOJDs3WdWJYWPUTQEDjZNDPnkCxfOSjpfokgk4H4Qme6KpFTcMtzgM6TEzCCr6fGg1L
         u+tz5Sg5iNpmLWsir6G5rkMc8/kLMIbqrrb/24GR/eYh3Cm6gH/+hY31r6HiUnVVJs9T
         5DboOjY3z2op4O1GIzqozftKfMrMEyEH3DSmGcQXx3VkjZbfAuHHcw3GRRTU4VvhJixk
         caDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxcwQ9a5BCidy2dFa/9nps2Mc0FbsWt6S03lB71Vb3Q=;
        b=ampprvHeDrg3FNKXg0Fr955mFdYCY87wMDeOBHyut5gOtCNImUuRO8fP5wDdjdWeOK
         UVhH08Gy7zkizFotclXk6au8AQb4mfA8w4BT8HjmBZXXRQ4qWOwfOMDXZ50KO4SzmtX5
         +SHG3UgVITVaqdXZ43s3M+y1j1cwaKyTfvGr/p9nHprqsYlZYgxIN4DF0WYVqEQB+N1Y
         c8u2IqgchuhkV3mHSeCF5l1n8Wp8mgwfEIZ5/XFxhJ3+dIM3TSKpj6I5+ivcsY5f4eMa
         fYbFrj6iYXB0y/9z0VibP8O8qU9CDlL5+2WRnntmZ0LRkMdkaSUZQaslSF1mMSgcLFsa
         FiYg==
X-Gm-Message-State: AOAM5310H7giItKcePyY92MP/IzLs8VnmMslu+ZK8FySjo5EEIAJt73x
        U7kJy0cbqd46u0XSXVSdAWUeYLlDH0RRxE0nowGkSA==
X-Google-Smtp-Source: ABdhPJyJ0KY5EaHRpkS3+W2josI7PyHyDujky1DsThBPEWS8Gmr8LelH5YRWyPTg/dohjn6yWbKKlSS1pHaECQrhnoA=
X-Received: by 2002:a2e:3603:: with SMTP id d3mr22194759lja.495.1618352010372;
 Tue, 13 Apr 2021 15:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210413153408.3027270-1-yhs@fb.com> <20210413153413.3027426-1-yhs@fb.com>
 <CAEf4BzZM3bLp=zFJ99ZX6iyM1D5gfB6eyweurVjn6iVOLdsrow@mail.gmail.com>
In-Reply-To: <CAEf4BzZM3bLp=zFJ99ZX6iyM1D5gfB6eyweurVjn6iVOLdsrow@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 13 Apr 2021 15:13:19 -0700
Message-ID: <CAKwvOdnJYbBs=F2yZLqKvZX5_iHv_X_zCfQXSS3sv=iVDejL=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] selftests: set CC to clang in lib.mk if
 LLVM is set
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 3:05 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 13, 2021 at 8:34 AM Yonghong Song <yhs@fb.com> wrote:
> >
> > selftests/bpf/Makefile includes lib.mk. With the following command
> >   make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
> >   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1 V=1
> > some files are still compiled with gcc. This patch
> > fixed lib.mk issue which sets CC to gcc in all cases.
> >
> > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  tools/testing/selftests/lib.mk | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> > index a5ce26d548e4..9a41d8bb9ff1 100644
> > --- a/tools/testing/selftests/lib.mk
> > +++ b/tools/testing/selftests/lib.mk
> > @@ -1,6 +1,10 @@
> >  # This mimics the top-level Makefile. We do it explicitly here so that this
> >  # Makefile can operate with or without the kbuild infrastructure.
> > +ifneq ($(LLVM),)
> > +CC := clang
>
> Does this mean that cross-compilation with Clang doesn't work at all
> or is achieved in some other way?

Right, this probably doesn't support cross compilation w/ Clang.
Rather than invoke `$(CROSS_COMPILE) clang`, you'd do `clang
--target=$(CROSS_COMPILE)`.  Even then, cross linking executables is
hairy.  But at least this should enable native compilation, which is a
start.

>
>
> > +else
> >  CC := $(CROSS_COMPILE)gcc
> > +endif
> >
> >  ifeq (0,$(MAKELEVEL))
> >      ifeq ($(OUTPUT),)
> > --
> > 2.30.2
> >



-- 
Thanks,
~Nick Desaulniers
