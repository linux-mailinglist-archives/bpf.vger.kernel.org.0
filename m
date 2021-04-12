Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8042935B99B
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 06:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhDLEsP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 00:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhDLEsL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 00:48:11 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E079DC06138D
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 21:47:53 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id i22so5202101ila.11
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 21:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=DOfJyQBfc5o+WHTNRfhhNX3Hma18tSVcM7b4i5K5Lng=;
        b=F7A/QiTqTS4tChu7OmgCi+mM8F8XYqAVtgyOFcI1qRnwdU09MsaYbJFAhl3tjpZqUU
         Q5lw31qwSJXh45+64zhnO0FSxtIkJAAVoKVJXCvW8RckFUkqYkzwwPaodeN6CC91Rpv6
         3oVdllwClmiGdPRfDZUzQDQFO28tKmZly83AwVDNcR2RUunl8sP+D1eeVAYczNlM1Xac
         alhuCxz8QjffpyeAFbbeqXPHcOjT4cFC0mUa1iE2R22iAXa7B3z8oWm2Icas1H26Kmfb
         XTim+L4AEWInH0eI8m5zkRbQCeS82qwZ6D66KiLnsP7Y6wFbcl2xun+fuU6b3yUt0eKa
         CeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DOfJyQBfc5o+WHTNRfhhNX3Hma18tSVcM7b4i5K5Lng=;
        b=RO/WaCfiAtJhrlIYKj9CtccuHoN3PBQcOe89G3nU+245Mo+AkWtQTP9T0DdLHmCH5U
         VYeVkEScB7noB6QhPdbI2RLgn9lg6AjsMYEctEDMZJlJYWPqN8c6hoz8z/QrnvV3QTOI
         wOR+j0IyV6a2y0EZ+FYlgf37vFvGzacTlcnWs1UqNlzGj4Xorcj+fn1zLEiNlZgRelZE
         BPOxouKzz0F+yq0BouK5EwcNIo3Ys4cAX5BFmd6LGzoYpXf7x1kWO3PsdA71UL+XwFY/
         wDTph7KKB0+6v/6fF3Ka7/b596MSkRxdEIsL7KnwFPfgUsVXGm7RbkeTdbDiJY1pj5j6
         t1jw==
X-Gm-Message-State: AOAM532WvGU5HyMaAzybZHT7YRLZJyFSfIgTc3TnqVdTtgIBk+BUX7jp
        bmSQtVUkr0PTvv5+6lI/VeJyNPXycs+IxTk5P7w=
X-Google-Smtp-Source: ABdhPJwimgXlI5K9OzRxGPlmycQrGQPmYDwRbq6iKazE+z/44Dw+ty5x82qdxdHSN5a2uJn3M/dlUd0rfO/+Ry7y2Bg=
X-Received: by 2002:a92:dc44:: with SMTP id x4mr2030670ilq.209.1618202873266;
 Sun, 11 Apr 2021 21:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com> <20210410164940.770304-1-yhs@fb.com>
 <CA+icZUXzCpHWk8Vm5D4ZcCbdd9gqipVD5ALCw6SGTFbYfdJZiA@mail.gmail.com>
 <7c82c0f5-2a96-7a5c-b090-f26c9351786c@fb.com> <CA+icZUWwSg4Nd+AzAMx8Os4iAfs=40zeoYn0eVKg3Cy7fB5Cow@mail.gmail.com>
 <3f224f2c-bb7e-accc-b095-7fee8210861b@fb.com>
In-Reply-To: <3f224f2c-bb7e-accc-b095-7fee8210861b@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 12 Apr 2021 06:47:19 +0200
Message-ID: <CA+icZUVPQT9WNona7xdmZP+2nS=xLn6hssd1wmLSeVNBzsOqTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: fix test_cpp compilation
 failure with clang
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 11, 2021 at 9:08 PM Yonghong Song <yhs@fb.com> wrote:
[ ... ]
> > BTW, did you check (llvm-)objdump output?
> >
> > $ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep core_extern
>
> This is what I got with g++ compiled test_cpp:
>
> $ llvm-objdump -Dr test_cpp | grep core_extern
>    406a80: e8 5b 01 00 00                callq   0x406be0
> <_ZL25test_core_extern__destroyP16test_core_extern>
>    406ab9: e8 22 01 00 00                callq   0x406be0
> <_ZL25test_core_extern__destroyP16test_core_extern>
> 0000000000406be0 <_ZL25test_core_extern__destroyP16test_core_extern>:
>    406be3: 74 1a                         je      0x406bff
> <_ZL25test_core_extern__destroyP16test_core_extern+0x1f>
>    406bef: 74 05                         je      0x406bf6
> <_ZL25test_core_extern__destroyP16test_core_extern+0x16>
>

What is the output when compiling with clang++ in your bpf-next environment?

- Sedat -
