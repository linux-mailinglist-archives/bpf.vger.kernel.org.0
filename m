Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2635AF74
	for <lists+bpf@lfdr.de>; Sat, 10 Apr 2021 20:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhDJSMv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Apr 2021 14:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhDJSMv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Apr 2021 14:12:51 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EC2C06138A
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 11:12:36 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y12so6789348qtx.11
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o9A3MkSF7vbq5UcAcz2SLX1O7G0t/lr0VlIgIy1YGEY=;
        b=r/AUBYaK22wukmeMr7Np/v0YcIjWxwBJSCiY+wumfKCWxnLRswYZdLKgUTl4c/CTye
         2rB8srARW0oUhpGc1Y0iYTKmJcsoyGZbouHMZEdaKXYvN0ZMkzsLZ/5HuXkiPC3e7RuC
         O/paXXi50IzJmo5rQ8we8lm3Okkx1yNNCTn+HCMTXWKjxekC01TpqTxLuEjNukyFcsnb
         05Z9dY4zSaxnKlfpm7nvBjUijMT/UWEiHYx3ed3BXu4ox9T15zS5ARAAxNXZCOcjhn7O
         LN9QEutvjRWPrYNUI51L+3KzIk/Mc2UCL5UjF3IF4fgFe4WrmVZokbTcDrMHSvfOXU08
         3WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o9A3MkSF7vbq5UcAcz2SLX1O7G0t/lr0VlIgIy1YGEY=;
        b=MGnfktktiPj/a9gre0keJ1rtr9rVe3xhfzfpQ8QXtZKiv3HkwYrb3lOQ7DH85bCrru
         L9dhU11DVsmTFhkVsm5vCHvHuW1df+xSp/QHSKbCey0/SqtGnDMhSMuNF+UI/7SqVPd2
         q/MjBGNONlGn3q6/ZnlNlMXHANR/w2yKKu8xKBoEVwZUW08rlrpnwOzHgZO/g5CRU6wa
         AueR2K76fQrl2WIjeS9RttKscfpE43D0HptvxLCu4hNshyygmSOwM11n5/YDVqAVusqo
         Z6n5AfAwyiO3L4hnL1+JlZDzwLwRdW7TCYmsmTQfLr8kMEvIvy4qddOXjEqBAYC+v35T
         2hLw==
X-Gm-Message-State: AOAM530rj62hFoCbbFQ2vHW0gTTMjQq7FHuPBY2/QklILjbJCMwkKd4J
        RpoRj3IHUemamdBLJJ/2ghAJy2Tjn6JiE78l
X-Google-Smtp-Source: ABdhPJwMS2ixcj97nEYKk6WGCyrCdn20G9mszw0a8+YBl8ebWZciV2vpV1SkJkLYCayPg8Y+t96OGw==
X-Received: by 2002:ac8:5716:: with SMTP id 22mr18974985qtw.212.1618078344889;
        Sat, 10 Apr 2021 11:12:24 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id n2sm4166461qta.61.2021.04.10.11.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 11:12:24 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id o10so10239635ybb.10;
        Sat, 10 Apr 2021 11:12:24 -0700 (PDT)
X-Received: by 2002:a25:7612:: with SMTP id r18mr1704826ybc.172.1618078344178;
 Sat, 10 Apr 2021 11:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210302171947.2268128-1-joe@cilium.io> <20210302171947.2268128-7-joe@cilium.io>
 <79954d84-ad75-8f91-118c-0ce2150a1c96@fb.com> <CADa=RyzgsEsRpED34Bi141216de9ecbSUw7M+349wtDDKVy2dw@mail.gmail.com>
In-Reply-To: <CADa=RyzgsEsRpED34Bi141216de9ecbSUw7M+349wtDDKVy2dw@mail.gmail.com>
From:   Joe Stringer <joe@cilium.io>
Date:   Sat, 10 Apr 2021 11:12:07 -0700
X-Gmail-Original-Message-ID: <CAOftzPgK5=Y67NU5W+3tEemv4GkBPuYJ3neRUczqQLHYv2CZXA@mail.gmail.com>
Message-ID: <CAOftzPgK5=Y67NU5W+3tEemv4GkBPuYJ3neRUczqQLHYv2CZXA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 06/15] bpf: Document BPF_PROG_TEST_RUN syscall command
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
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

On Wed, Mar 3, 2021 at 5:38 PM Joe Stringer <joe@cilium.io> wrote:
>
> On Wed, Mar 3, 2021 at 12:29 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 3/2/21 9:19 AM, Joe Stringer wrote:
> > > Based on a brief read of the corresponding source code.
> > >
> > > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> > > Signed-off-by: Joe Stringer <joe@cilium.io>
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
> >
> > > ---
> > >   include/uapi/linux/bpf.h | 14 +++++++++++---
> > >   1 file changed, 11 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index a8f2964ec885..a6cd6650e23d 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -306,14 +306,22 @@ union bpf_iter_link_info {
> > >    *
> > >    * BPF_PROG_TEST_RUN
> > >    *  Description
> > > - *           Run an eBPF program a number of times against a provide=
d
> > > - *           program context and return the modified program context=
 and
> > > - *           duration of the test run.
> > > + *           Run the eBPF program associated with the *prog_fd* a *r=
epeat*
> > > + *           number of times against a provided program context *ctx=
_in* and
> > > + *           data *data_in*, and return the modified program context
> > > + *           *ctx_out*, *data_out* (for example, packet data), resul=
t of the
> > > + *           execution *retval*, and *duration* of the test run.
> >
> > FYI, Lorenz's BPF_PROG_TEST_RUN support for sk_lookup program
> > requires data_in and data_out to be NULL. Not sure whether it is
> > worthwhile to specially mention here or not. The patch has not
> > been merged but close.
> >
> > https://lore.kernel.org/bpf/20210301101859.46045-1-lmb@cloudflare.com/
>
> Not sure how close either series is but I'm sure between Lorenz & I we
> can figure out how to fix this up. If I need to respin the series and
> Lorenz's one is in by then, I'll fix it up but it's not the end of the
> world to send an extra dedicated patch for this.

I sent this out:
https://lore.kernel.org/bpf/20210410174549.816482-1-joe@cilium.io/T/#u
