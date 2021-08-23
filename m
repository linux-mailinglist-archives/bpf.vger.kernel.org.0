Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493513F50FF
	for <lists+bpf@lfdr.de>; Mon, 23 Aug 2021 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhHWTF5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 15:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhHWTF4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Aug 2021 15:05:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943ABC061575
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 12:05:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u3so39161299ejz.1
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4pNZik/7MZ1gd1JMjWsqS/rZ8ho6j9+j+/Hbspf35bA=;
        b=iHx8CD8Wye8bC/pV3KnOX8WsN1O0/ZsD9s5qkVlx4CXLFFFB0DjSNrxQJHeaHF9SWX
         uHZ8DKyB9CK15kwdt1S4L6rlFNJGCV1qnQd4R6NluUWG9yil9cJ/T4xSX9r/CJEQiCpe
         94uUwp2QLjkeDY98+iZWSEid+VBxVfGr+5T+klB1/2lSGljACj4gVr2o9UqDLfea7/n4
         BPxAwRXwYnJYSVYjxK3px8/7SIpzpwWVVDZbpV4kSbjgZlb2yeqMn0wLpxD0jp/sUYzX
         Luf1yj61YBzI4niQ8V/4vesGAmnR2VIOOKG0p3ZT5NAIUhVas/O2kba8NxK6VHFGcg1e
         +COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4pNZik/7MZ1gd1JMjWsqS/rZ8ho6j9+j+/Hbspf35bA=;
        b=FyjIKSH2iuHWyfi85b0UwUhyqTBM4Ruk4XFLihCwnG5PonVTTQ4iZy5m0Jc20UMx1r
         u53ePo36yrFFFnG55I04bDjhlfFGQ8KW54tQRHxhGDnAN9hEDE/rMf4kUFEP+gqYjeBK
         pWm+tHK1lN587u09CrVl2atkRGDo8zGoI4EiuMwiYm03exhVqKkmCZ4FEsZFiPQfpwDb
         ockOLDJ4kgX8nK4H4BTa5L0/EM4WctERsyu6rhxx6k+ltXzaCOWQqpcIT7m+KmVvPqv4
         nbmf1Jk0bqwu6yBXFbTSD+xvfhFlJX9QP0hFUa7dna01MhHZAT7tmLlutjQ7TauUI9MF
         0xfw==
X-Gm-Message-State: AOAM531JwwEG1Jpue3jiscDAu8mR4DAuivKJ7HCcd0lAe2hhwVHNwC9w
        ObJvYKKRpGS91f/5HKut7XwZFI+5Yl3Qh6P6nuc=
X-Google-Smtp-Source: ABdhPJzEOoaklJodoN4hPwGj7k/Kxa2x1pIF4tvv/kL9eeENc5bQndIlRdOVL86MN3pQNDgWMkUcjhrwwGxPLHAUiyk=
X-Received: by 2002:a17:906:ca1:: with SMTP id k1mr7268477ejh.369.1629745511080;
 Mon, 23 Aug 2021 12:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZXTiaX9xzNi5aOavwsf+mziJ=w-EcHH2f=cJmCGr3EPQA@mail.gmail.com>
 <20210823155149.3jg7nizcxgxf4tfv@apollo.localdomain>
In-Reply-To: <20210823155149.3jg7nizcxgxf4tfv@apollo.localdomain>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Mon, 23 Aug 2021 22:06:03 +0300
Message-ID: <CAMy7=ZWQCO0rkW979v6cF56x06G_kmA_qTDm9_yumJyjrcg47Q@mail.gmail.com>
Subject: Re: libbpf: Kernel error message: Exclusivity flag on, cannot modify
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 23 =D7=91=D7=90=D7=95=D7=92=D7=B3 2021 =D7=91-18:51 =D7=9E=D7=90=D7=AA=
 =E2=80=AAKumar Kartikeya Dwivedi=E2=80=AC=E2=80=8F
<=E2=80=AAmemxor@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Mon, Aug 23, 2021 at 04:35:51PM IST, Yaniv Agman wrote:
> > Using the recently added libbpf tc API worked fine for us in v0.4.0.
> > After updating libbpf and syncing with master branch, we get the
> > following error:
> >
> > libbpf: Kernel error message: Exclusivity flag on, cannot modify
> >
>
> This message is harmless. The commit that adds NLM_F_EXCL is a bug fix. W=
ithout
> it, the kernel returns 0 when it should return -EEXIST. It's just that th=
e
> kernel complains loudly for the latter case through extack.
>
> User needs EEXIST to detect whether it installed the qdisc or not. To see=
 how
> this affects the system, run ./test_progs -t tc_bpf after installing clsa=
ct
> using:
>         tc qdisc add dev lo clsact
>
> Before this fix is added, it will remove the system qdisc as bpf_tc_hook_=
create
> returns 0, after the fix it detects the presence of the existing qdisc us=
ing
> -EEXIST and disables the bpf_tc_hook_destroy call before exit.
>

Got it, thanks!

> I would suggest handling the error explicitly, and using libbpf_set_print=
 to
> filter it out. See the example in tools/testing/selftests/bpf/test_progs.=
c.
>

Explicitly handling EEXIST solved the problem, however,
libbpf_set_print in my setup is already set to ignore any message that
is not LIBBPF_WARN.
so I'm not sure how to specifically filter this error out...

> > I found that commit a1bd8104a9f1c1a5b9cd0f698c886296749a0ce9 is
>
> You probably meant bbf29d3a2e49e482d5267311798aec42f00e88f3? I cannot fin=
d this
> commit.
>

Sorry, I should have mentioned that the commit ID is of the libbpf
mirror: https://github.com/libbpf/libbpf/commit/a1bd8104a9f1c1a5b9cd0f698c8=
86296749a0ce9

> > causing this problem, and removing the NLM_F_EXCL resolves the issue.
> > Is this the expected behavior and I'm doing something wrong?
>
> --
> Kartikeya
