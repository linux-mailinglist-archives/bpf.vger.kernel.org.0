Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786D035D43C
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 02:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbhDMADL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 20:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhDMADL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 20:03:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6F4C061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 17:02:52 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l22so10064069ljc.9
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DeKVJLUvQCohP9LfngyRQ5irhln3paDr+f8+qaEeQRM=;
        b=p8Sn0ZB9gxu5gqHWuiRls56vDvjLEL+LT4aqiS0JuR0A2zhJJja3CN1Bz/Vi1rK9+I
         qAoUAhsa8zW7dpCCjNUCAebqzQipWEI6PQdYvcU/MQQ2/41sjuuflzKVM66/9XvlY/bM
         2HR0vaAQ+D7eIFcCt4ElnFyKotlaGX4NTuMd4NAhXTJAjdN2/XhRpxFA0frHwmTB0+29
         I/E/TGoRl3FVSibVV/3E3DdgTxP+5aAya6wUU4O4kiJ4z+9IpHdgYLWrUQud1ZzwosUe
         mBAewmjGdzGap1lLy6R7EZAtOvTKCeVbM6pUnljAEWgWi9FDN7L2b1zTmCO6wGVG1vpX
         ZJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DeKVJLUvQCohP9LfngyRQ5irhln3paDr+f8+qaEeQRM=;
        b=PDid7TWMwwZcJsNI3j7kSj0Jl8EtH3zivxQuYtXunBiinCR+W4ZB/sR2/BdSrDXOZS
         NheOH3x7SXLiCjQcqVO5NTQ9cWxbeUn+jEJnKhYr13YRnFLnpIlvbzOS9jft0wzcLpfG
         qochqd/EsA1+7BDUss79aTl4Fr0plDOFph/AHL9elJrzCyD/uLbUObHvnedWxf9d031+
         0JFsG9H6GoyqPEMxpn7mclxkdpgEXxQ3r7sXnbb446/PkMSWJCOB6GyHrf38kM6xYSpc
         4pnpg3pCWbOyJD4eRWVL/s8Dh5onF2O+tyqGlGUjmfCVKq5vipaAwqTOg0h/2Fi/fjyA
         tnhQ==
X-Gm-Message-State: AOAM531yKnaJlnaMjy3oMyNIex6/cZlkGmduW9mFG2pJ7N82WOnia8sl
        LCHZBxBpJjw5hEJsCleek/IV6v8ogV8HjmC2lgUHZFS/Qp5ocXsD
X-Google-Smtp-Source: ABdhPJx2Y8WPMEP5HQtql4/K2ZgQrr98FLXrlSoRFkTDdjTg15aeFRjqm95rWLAAVOPMtReHYS9YhYFoDvmL7URbs9E=
X-Received: by 2002:a2e:988a:: with SMTP id b10mr19683694ljj.341.1618272170162;
 Mon, 12 Apr 2021 17:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142905.266942-1-yhs@fb.com> <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
In-Reply-To: <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Apr 2021 17:02:38 -0700
Message-ID: <CAKwvOdkFWe76ggKrLeckS+mzmyQeq6eJBnkQM1bKgEGQBCspSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 4:58 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Apr 12, 2021 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
> >
> > To build kernel with clang, people typically use
> >   make -j60 LLVM=1 LLVM_IAS=1
> > LLVM_IAS=1 is not required for non-LTO build but
> > is required for LTO build. In my environment,
> > I am always having LLVM_IAS=1 regardless of
> > whether LTO is enabled or not.
> >
> > After kernel is build with clang, the following command
> > can be used to build selftests with clang:
> >   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>
> Thank you for the series Yonghong.  When I test the above command with
> your series applied, I observe:
> tools/include/tools/libc_compat.h:11:21: error: static declaration of
> 'reallocarray' follows non-static declaration
> static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
>                     ^
> /usr/include/stdlib.h:559:14: note: previous declaration is here
> extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __size)
>              ^
> so perhaps the detection of
> COMPAT_NEED_REALLOCARRAY/feature-reallocarray is incorrect?

Is this related to _DEFAULT_SOURCE vs _GNU_SOURCE.  via man 3 reallocarray:
       reallocarray():
           Since glibc 2.29:
               _DEFAULT_SOURCE
           Glibc 2.28 and earlier:
               _GNU_SOURCE

$ cd tools/testing/selftests/bpf
$ grep -rn _DEFAULT_SOURCE | wc -l
0
$ grep -rn _GNU_SOURCE | wc -l
37
$ ldd --version | head -n1
ldd (Debian GLIBC 2.31-9+build1) 2.31
-- 
Thanks,
~Nick Desaulniers
