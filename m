Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BA332C8FE
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 02:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhCDA7q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 19:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352661AbhCDADc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 19:03:32 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22EBC0617AA
        for <bpf@vger.kernel.org>; Wed,  3 Mar 2021 15:53:35 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id o3so28061520oic.8
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 15:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sJfUpwC5Q0AujFJkQ3bJRLWkfqFnVs4ZYKg21LJVuHE=;
        b=BFIWZ0u0+EF/YC1mA2Nchh2NeUUfh8mRSTWelXDcFLQm2vG0MPevPcPuTWmYwx4XeL
         1Xk+DQKrHnBz+sIjKI+ng4AK1/SgOuS6H+lXZPHBmnv0SNp8K6ZxJhG3ujg2ZeAJ2wwP
         d7F0hjQDdtCyevlcdjFr21rzFqYI/oWOvVzQ/mcUuAwV3ELOANllu1vNL2cwfRMCILdX
         1NKZHPNvRopqcWZD+RWrXQ9cw22ho6Mwsbg1ilG7UEz+4/MGONLMrpFxX+kz0LwJeJj2
         kZ7gUkarr8Usb0SLVN6UGeUgC2zXh+t4KgzmJD02xc4AwN5+e/9xJfZOFU7VpPwhA/Sk
         eJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sJfUpwC5Q0AujFJkQ3bJRLWkfqFnVs4ZYKg21LJVuHE=;
        b=iMGDfehrrQUEWbn1o9uC0BNPTVj34sw07nkfWfo7cyktKo1iDkomklEFbgpZ1h1nPx
         dq/Yi7jc/CHunKtyi5nabEA53ziQ+yq8fp+88OXnjqKAw0bSff9pCG2HFNu9zHevjlTr
         aQpy/pawgPqznsDik5oJtg0WEmgQm90vHo1kGkRxJpFpJe4rNrcBK84Mtl+KOd4MhUx6
         p6JuiNdhiNTZJFmlTP0kEFEWWbuocXm2xj39QAWZClT5tTz5uSHWir+VDIqc9BSrRKor
         LE2DWI0H2bq1BugcO0lAnyNIHabrzBuFbcIP0qMaSnz3NGF1K22iuPIBd5VXEQ0yyfMU
         zY4A==
X-Gm-Message-State: AOAM530aQdsvg8MbKbtWtIvvJy/QJFhnQnamhQ+ZMMS8W44NgADRwqDs
        5MeDxg87HVhwSfL2sVd59DIjfI2kaNalgLjyYQXE/A==
X-Google-Smtp-Source: ABdhPJxVhvbmRStq/JhsuTAFe5elO14d19je73tPaRLSxCTShXmLatgreMOoyRO4L0xaC9DGZmlwi8aJuYsRDzPNKKo=
X-Received: by 2002:aca:f50d:: with SMTP id t13mr1041539oih.89.1614815615117;
 Wed, 03 Mar 2021 15:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20210302171947.2268128-1-joe@cilium.io> <20210302171947.2268128-7-joe@cilium.io>
 <79954d84-ad75-8f91-118c-0ce2150a1c96@fb.com>
In-Reply-To: <79954d84-ad75-8f91-118c-0ce2150a1c96@fb.com>
From:   Joe Stringer <joe@cilium.io>
Date:   Wed, 3 Mar 2021 15:53:24 -0800
Message-ID: <CADa=RyzgsEsRpED34Bi141216de9ecbSUw7M+349wtDDKVy2dw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 06/15] bpf: Document BPF_PROG_TEST_RUN syscall command
To:     Yonghong Song <yhs@fb.com>
Cc:     Joe Stringer <joe@cilium.io>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 3, 2021 at 12:29 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/2/21 9:19 AM, Joe Stringer wrote:
> > Based on a brief read of the corresponding source code.
> >
> > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> > Signed-off-by: Joe Stringer <joe@cilium.io>
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   include/uapi/linux/bpf.h | 14 +++++++++++---
> >   1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index a8f2964ec885..a6cd6650e23d 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -306,14 +306,22 @@ union bpf_iter_link_info {
> >    *
> >    * BPF_PROG_TEST_RUN
> >    *  Description
> > - *           Run an eBPF program a number of times against a provided
> > - *           program context and return the modified program context a=
nd
> > - *           duration of the test run.
> > + *           Run the eBPF program associated with the *prog_fd* a *rep=
eat*
> > + *           number of times against a provided program context *ctx_i=
n* and
> > + *           data *data_in*, and return the modified program context
> > + *           *ctx_out*, *data_out* (for example, packet data), result =
of the
> > + *           execution *retval*, and *duration* of the test run.
>
> FYI, Lorenz's BPF_PROG_TEST_RUN support for sk_lookup program
> requires data_in and data_out to be NULL. Not sure whether it is
> worthwhile to specially mention here or not. The patch has not
> been merged but close.
>
> https://lore.kernel.org/bpf/20210301101859.46045-1-lmb@cloudflare.com/

Not sure how close either series is but I'm sure between Lorenz & I we
can figure out how to fix this up. If I need to respin the series and
Lorenz's one is in by then, I'll fix it up but it's not the end of the
world to send an extra dedicated patch for this.
