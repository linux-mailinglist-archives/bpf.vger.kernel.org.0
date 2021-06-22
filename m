Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD5C3AFA29
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 02:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFVAbR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Jun 2021 20:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFVAbR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Jun 2021 20:31:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244EFC061574
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 17:29:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m21so33044442lfg.13
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 17:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LamixgIpkN3cuL3y9Lx9NI98VYIU6gjrvl7FF7/x0aY=;
        b=Y1nds71MCTmsOSLNIXO/ppbZnXu/UWcO7mo5NTwWhSkPdhLMbSsWSmoXh1/97T5sTu
         AlwoM9VTCqe5DLw6LWEV+AKF8k08QRhSu211ilybyYo5u3aPLqjsPirLGt5JBphYbXKL
         rB0YmfkeJrhV4ZjjbZ7ioi0Vz/poMYfzys6P+x5nS+ZXjGu49Dm5zzhfIKGES6InsdtV
         8AQYQDhtBpdOQVfqNg1bOHuGjq2n2TbPE0qhdWZEklH855ZgUAS63cJx+wjZAVp30E3J
         mWwLN29bZPxYyP5nKkSHGXKdouIhTlCHPQu6bKd+1K3y8YbLDaUz9CftfkKcz1zTOSxm
         hAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LamixgIpkN3cuL3y9Lx9NI98VYIU6gjrvl7FF7/x0aY=;
        b=sKtq3pAal1I5K8z6xer1J4aiOnnsvAyvUmtZTz9OPHaot1+wFG/ZKRBxs6DYV7YmaC
         9s5Nly3+riSspwZNwr4bSpRWggVaN7ESSaPH7cUXxz9v/9e/W/iph8M0JbFCc30BIvpd
         YXa78XwiJVLGLDa1Yl6kJ8p1viVb/peYqs0MwD61s9uCdx+7IClxFXzf8/dQ2qqohnPm
         byOx48rL6Ss3xUspDtyFcM5cxxCo07h75SwoCc9Qqqg/P+F4QsTlZVz9gMI716RG+HYr
         pXQtlXruXGtRp7rzOO81E5p7fSMyfCAcWAvLqHKHShhuwW5Vmyc+Qrg9nJpjv7jGlsE7
         Ywow==
X-Gm-Message-State: AOAM533a/9OawiOSWI+b70ODC1GqsA0Qv7pgPNcwqmEYl5jQ4k5dyiDu
        xCnUK/7uXNUoNs1a9wN6l7wqj2KoCGkj+rTp1O7oMFER
X-Google-Smtp-Source: ABdhPJywc4CO24vuCXw3xl+aAGwhqng/7nvtKaEeg7Ujv0fO6ng9aHCjGSMu5hrZUATeaeHUevv5AJ060hJhm0u5Ge0=
X-Received: by 2002:a05:6512:3f9a:: with SMTP id x26mr713500lfa.75.1624321739467;
 Mon, 21 Jun 2021 17:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <aaedcede-5db5-1015-7dbf-7c45421c1e98@ghiti.fr>
 <CAEf4Bzbt1wvJ=J7Fb6TWUS52j11k3w_b+KpZPCMdsBRUTSsyOw@mail.gmail.com> <30629163-4a65-43f6-c620-9611e45815c4@ghiti.fr>
In-Reply-To: <30629163-4a65-43f6-c620-9611e45815c4@ghiti.fr>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Jun 2021 17:28:48 -0700
Message-ID: <CAADnVQ+vcdO2SLnEeo5R4=8bTrkQiv-x2Ejcg08OsoZJJ4RXhw@mail.gmail.com>
Subject: Re: BPF calls to modules?
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 20, 2021 at 11:43 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi,
>
> Le 18/06/2021 =C3=A0 19:32, Andrii Nakryiko a =C3=A9crit :
> > On Fri, Jun 18, 2021 at 2:13 AM Alex Ghiti <alex@ghiti.fr> wrote:
> >>
> >> Hi guys,
> >>
> >> First, pardon my ignorance regarding BPF, the following might be silly=
.
> >>
> >> We were wondering here
> >> https://patchwork.kernel.org/project/linux-riscv/patch/20210615004928.=
2d27d2ac@xhacker/
> >> if BPF programs that now have the capability to call kernel functions
> >> (https://lwn.net/Articles/856005/) can also call modules function or
> >> vice-versa?
> >
> > Not yet, but it was an explicit design consideration and there was
> > public interest just recently. So I'd say this is going to happen
> > sooner rather than later.
> >
> >>
> >> The underlying important fact is that in riscv, we are limited to 2GB
> >> offset to call functions and that restricts where we can place modules
> >> and BPF regions wrt kernel (see Documentation/riscv/vm-layout.rst for
> >> the current possibly wrong layout).
> >>
> >> So should we make sure that modules and BPF lie in the same 2GB region=
?
> >
> > Based on the above and what you are explaining about 2GB limits, I'd
> > say yes?.. Or alternatively those 2GB restrictions might perhaps be
> > lifted somehow?
>
>
> Actually we have this limit when we have PC-relative branch which is our
> current code model. To better understand what happened, I took a look at
> our JIT implementation and noticed that BPF_CALL are implemented using
> absolute addressing so for this pseudo-instruction, the limit I evoked
> does not apply. How are the kernel (and modules) symbol addresses
> resolved? Is it relative or absolute? Is there then any guarantee that a
> kernel or module call will always emit a BPF_CALL?

Are those questions for riscv bpf JIT experts?
Like 'relative or absolute' depends on arch.
On x86-64 BPF_CALL is JITed into single x86 call instruction that
has 32-bit immediate which is PC relative.
Every JIT picks what's the best for that particular arch.
