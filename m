Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B478275F85
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 20:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIWSOF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 14:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWSOF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 14:14:05 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72534C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 11:14:05 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id x20so419231ybs.8
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFKTDgeMBTmPxnbmFuJX3u5z9nApJcHy8UwRyUNXX7M=;
        b=SHVCKg1HaaMNop1MySRl4+Tc+nKbTK4QKLFPn3UAak1Fdmd7gYThHB0xJouDm6ENKW
         W0lETrBqkF9QAsrNJJOxiYY8ub8jZjhfR2WVfzEaA6kmimHTSb3y6j9eW/QJNmUQmngZ
         G2WrTNLuWU3g+CTjtuynIJGKS6ExsYcuMQfkKSaaGmVvXdtR4JGBv+BtRS7pa//x80Oj
         5CjM9BQvzNvC6sd0U3xzUcmANYv2s6TwGUDomkiO7xKh4sM0UKrrpxAnYSIFSYo6uDXZ
         FOAYMeLq4wlqUJ5Wx8Br05RpolirAcQ06WFf/kasJj0KpDuOXVAndQ/XgpaLCLRlfp+I
         XAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFKTDgeMBTmPxnbmFuJX3u5z9nApJcHy8UwRyUNXX7M=;
        b=QXs6FxWN2ZWI1aXL2ftEgWAnPNe/Jqx6nrGB1yV9bC8PvHI9Z6SxoMT1zCL6l4HLfe
         IjCBtsgG89/rP+UpwK0s1E05dLixsMM6fcOTlyDJMe+qNIWw90pnWnsVWdi2b3AZ0+zo
         g/BPd8vO2zAIyhhmSnuhnuI0CqKrEHdGtumLtqWG/4SYhggaBrXw8i3g3G0yaAtkJ4n+
         1D6Nx6juopD/JKEm5oYQ8oVXIZyPDJPGj/TunIUhDMKNBAVJ7N8pBeZNWl0MR2TqtpNN
         Qq4mLuFbeafmonhXvRNEZXKAeE11qsdoosGcExhSqKBZb3BKdIvk/sQu/ODz4SzcOrDB
         z/NQ==
X-Gm-Message-State: AOAM530aXgxpKQAHPZU3t9kN2iWSKrUr4bx4L3euQRblag+doULbpnKC
        uV7mizW3Dk9Xe7UAsFD7cosTxWv313FLzikRFLg=
X-Google-Smtp-Source: ABdhPJx6vrrfKybZpwfkwT+Ki0dbY/jagAw3n/hLidY7uYDVi6z9rr8Y4l5PlhHLLyoDRa5xphFPII9r2KT2U9b/9yI=
X-Received: by 2002:a25:cbc4:: with SMTP id b187mr1833018ybg.260.1600884844544;
 Wed, 23 Sep 2020 11:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200921184219.4168733-1-iii@linux.ibm.com>
In-Reply-To: <20200921184219.4168733-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Sep 2020 11:13:53 -0700
Message-ID: <CAEf4BzbOrxP9a+hnAt7oDpcf=XV6WZW5E58vPTnzgitkPbFaKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Skip some verifier tests on
 BTFless kernels
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 11:42 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Mark seven tests as requiring vmlinux btf. Check whether vmlinux btf is
> available, and if not, skip them.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Ilya,

These changes look good to me, though kernel BTF has been a
requirement for successful BPF selftests run for a while now, so I'm
not sure if we want to do this... It will be up to Alexei and Daniel
to decide, I suppose. I'm fine either way.

But in any case, it seems like patchworks lost your patch, so please
resend it so that it's visible there and can go through normal patch
review workflow. Thanks!

>  tools/testing/selftests/bpf/test_verifier.c   | 24 +++++++++++++++++++
>  tools/testing/selftests/bpf/verifier/d_path.c |  2 ++
>  .../testing/selftests/bpf/verifier/map_ptr.c  |  4 ++++
>  .../selftests/bpf/verifier/map_ptr_mixing.c   |  1 +
>  4 files changed, 31 insertions(+)
>

[...]
