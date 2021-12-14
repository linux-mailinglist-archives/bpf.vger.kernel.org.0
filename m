Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435DA473BB7
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 04:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhLNDtq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 22:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhLNDtp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 22:49:45 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DF7C061574
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 19:49:45 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id n6so32816666uak.1
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 19:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wl+WzFLefhVOTvM1k8TvMp2OwB6CJA4EhHCy5Zfv6Nk=;
        b=dB4iSbIRgpt4S/0UrIkPWD9qGyaXlI77mUyUeDIkECzbxRgqUOAFH9a4OEedmcD4s2
         K5tQk+zwujTxP1yaqCpj+HQes9svPyL0W9TPcVs28QusZOsQrEgH83o1IIp5j4iciDDY
         b2Ifueznzdm87Qw2DeM0rpI43XSv+cuuNsNA3C7uZ4OcJsiD38fXAFkDe9j53ph3zwWd
         XABAwiTC6jyv+lLK0QpXACRZZNRgdO4t+8SGBs2PNXnAYwzMU9MPcPA7+fYdhILej3Em
         pBATr0T3qAY4DUf2FVyL/9ClCxB+q61fRyVgaZkse+LtrPIXONYnzjNlGlHsRlOaXYL1
         N97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wl+WzFLefhVOTvM1k8TvMp2OwB6CJA4EhHCy5Zfv6Nk=;
        b=WG9yi/G5ty85Yy+8c/NTvn58DCejQWih5TVHh5P9Ezqaiuiw/tdzxBKOGs+fQz2i3P
         /0ueSZRHHspJsphzGEa+Gk6KDGXijWwKetP5n5bBvQ8KU9ONaRIslGiBpRaiBx++yEBU
         bk3CRG2GSQUU5KjAx8K6Uy9WDcoAdxvNFOld7UXc4+Y8PhrNdi5Z/D15V/C2djwHvnZz
         sKAV2UHhD0xOaUMVoqLFv9u38jGdrHZkUdVslHnBBwZOTBEhMJ726vJqlxjc4eaiK/P0
         BEpP6a7nsKU+nPPtQbZfUQ/uI1xXlNirgpGrjApTgm0S5AMJdxObtfDbEEJSAcl/ES/5
         4LmA==
X-Gm-Message-State: AOAM531j4ULCXDoIPhAH7csX2iAhtzuoehoAAy3L0QIih2BI/4KHIRLK
        rWqVLE8EzAOgVcONM5a8nrvxos6AD6ecVSVe6/k=
X-Google-Smtp-Source: ABdhPJxxKTNnb9REwnSGNMn+C07ZeQ0xT2iePen+l/nTIgBnAxLi2+f6eneVwH6nKREAl5g0pHzEVfJcobwjTebLoec=
X-Received: by 2002:a05:6102:3ec9:: with SMTP id n9mr3543807vsv.67.1639453784778;
 Mon, 13 Dec 2021 19:49:44 -0800 (PST)
MIME-Version: 1.0
References: <CAO658oUqd5=B3zkDhm2jVQxG+vEf=2CE7WimXHqgcH+m0P=k_Q@mail.gmail.com>
 <CAEf4Bzb5TMHkct=uh2OHnDaTtnvyLwvHjueN1Lm8vqTF6BDaSw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb5TMHkct=uh2OHnDaTtnvyLwvHjueN1Lm8vqTF6BDaSw@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 13 Dec 2021 22:49:33 -0500
Message-ID: <CAO658oXGs3R=mQZo=aOEvRgG6O-obFbwR54V+QSn36uecF0+=w@mail.gmail.com>
Subject: Re: Question: `libbpf_err` vs `libbpf_err_errno`
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 13, 2021 at 6:15 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 13, 2021 at 3:10 PM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > I'm using libbpf and want to make sure I'm properly handling errors.
> >
> > I see that some functions (such as `bpf_map_batch_common`) return
> > error codes using `libbpf_err_errno()`. My understanding is that since
> > libbpf_err_errno() returns -errno, these function calls can just be
> > followed by checking the returned error code.
> >
> > Some functions (such as `bpf_map__pin`) return `libbpf_err(int ret)`
> > which sets errno and returns the error code. In this case, does errno
> > even need to be checked?
> >
>
> No it doesn't, checking directly returned error is enough. We set
> errno always for consistency with APIs that return pointers (like
> bpf_object__open_file(), for example). For the latter, on error NULL
> is going to be returned (in libbpf 1.0 mode), so the only way to get
> details about what failed is through errno.
>
> so doing:
>
> if (some_libbpf_api_with_error_return(...)) {
>   /* errno contains error */
> }
>
> is the same as
>
> err = some_libbpf_api_with_error_return(...);
> if (err < 0) {
>
> }
>
>
> But you only can use:
>
> ptr = some_libbpf_api_returning_ptr(...);
> if (!ptr) { /* errno has error */ }
>
>
> I plan to remove libbpf_get_error() in libbpf 1.0, btw. The pattern
> above will be the only one that could be used.

Thanks for the info! I think I have a couple instances of usage wrong
in libbpfgo. I will submit a patch to document this accordingly.

>
>
> > Why the inconsistency? I'd like to document this, so anything else
> > that you can add on error handling in libbpf is welcome. That includes
> > example usage.
> >
> > Thanks!
