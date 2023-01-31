Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB64D682F67
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjAaOgw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 09:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaOgw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 09:36:52 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691A4136;
        Tue, 31 Jan 2023 06:36:49 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-50660e2d2ffso206040807b3.1;
        Tue, 31 Jan 2023 06:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSgtFPuqiMrunTYTZSW7dJGoh5ZM8Cdm1d5VizE8Y/I=;
        b=XG3CH9v3gt+Rn+U82ZQuY01SjlrY4/JAoWtZ0q5PNtVkx0s21Nq4z7HKAe5wcF96lq
         MyPr+0r/wqDchCjGrxyiOgqVPPrenUuOAjJjQWQPTEbrFFgQOGgGimgOZySyGRHPBKzl
         alwOOO5c47m1WGdPYM4KFLN4RrbKLxruDurMDbRGLZPxlr5Wdd/dWNXxeLvCBGiHL+aq
         wAajUrtc1RTCHKkI52koIXApz9WgPE6OhZdXWQg2ykve+LznivoRxMSIjRT1M8N64cKD
         NSN8PnrOI923/lZ4PCjgzsigNxcrBcUS2WSTQCdy+BLwprG7N5IOpU0cAtXXNhRJ+Je9
         Rn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSgtFPuqiMrunTYTZSW7dJGoh5ZM8Cdm1d5VizE8Y/I=;
        b=tUZgXm7oGtmY10/IVh6ba94I+i0KBJ751dvnpb+U4BaQk1YplaEm4uixvEBjMDPhNB
         nizH8XbTfyvXnFQVYMdbpljdN3lxKe6wLgcfm5FGQiNA98xNUcd9V8nLIrQ2sXcqXYGL
         tiKvA64/TzlEuAIaTbjHVsag32ZQ3XF1SIsFIo6crVrx0z1CIaaasRZsmjNAPEyy5H2S
         h4NvvD2lpuEoQ/khjnm8O31ObRDP4MGTyzh5g3MzhwHk7jCJGnKI1dLVNfcAl/OrkaMg
         uymkojsqZlO6amPFBkg0Mm1oEtxVIncXvf/DrRtar2IBrW7wJcwwE+ZgMUCYO/Kq9RYQ
         7VXA==
X-Gm-Message-State: AO0yUKW7NPvO3Jr2p9TgosDb4tXQ8xosF6hFsVBJfSPMDZoFdmVl4fjn
        FYU7m6UqyUEvFtQ5m5mR3kgIeo/iX13PXe4ESyM=
X-Google-Smtp-Source: AK7set9iMBR5qpNU3msKb9iw6D8YcH1Ti3QgIvonqkHjiR8rHwktn2I2f30kt+SZdZpmzgQgcfkZIPjl+xCRDkGAC3w=
X-Received: by 2002:a81:7097:0:b0:50a:22ba:cdca with SMTP id
 l145-20020a817097000000b0050a22bacdcamr3111922ywc.352.1675175808563; Tue, 31
 Jan 2023 06:36:48 -0800 (PST)
MIME-Version: 1.0
References: <CAADJU1032g+sNGN9AZKeVuMzZywXZ0BWpm3592XcGJdp4goCUQ@mail.gmail.com>
 <991b275a-4a44-a870-24e6-d6683bf69589@gmail.com> <877b57f5-77ba-805b-ed5f-57e47fa83b16@gmail.com>
 <195ea485-1449-7ed8-5184-d00cf7e0dd5b@isovalent.com>
In-Reply-To: <195ea485-1449-7ed8-5184-d00cf7e0dd5b@isovalent.com>
From:   Zexuan Luo <spacewanderlzx@gmail.com>
Date:   Tue, 31 Jan 2023 22:36:38 +0800
Message-ID: <CAADJU11ei7KAv1c=f1Gj5TzipS9+yenEfDffznfftej14ESZkg@mail.gmail.com>
Subject: Re: Typo in the man7 bpf-helpers page
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        bpf <bpf@vger.kernel.org>, linux-man@vger.kernel.org,
        Alejandro Colomar <alx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My bad!

> No, I don't think there is anything wrong with that. I suppose you mean
bpf_get_socket_cookie_sock_(ad
dr|ops) (the functions you mentioned don't
exist), but the four variants of the helper just have the same name, and
take different objects for their context.

Yes! I made a mistake in the function names in the first email. Thank
you for pointing that out.

I am an eBPF newbie and I am learning it currently. AFAIK, language C
doesn't support function overriding via different parameters.
So how do these four functions co-exist?

Some naive search in the kernel code leads me to:
https://elixir.bootlin.com/linux/v6.2-rc6/source/net/core/filter.c#L4919
```
static const struct bpf_func_proto bpf_get_socket_cookie_sock_addr_proto =
=3D {
    .func        =3D bpf_get_socket_cookie_sock_addr,
    .gpl_only    =3D false,
    .ret_type    =3D RET_INTEGER,
    .arg1_type    =3D ARG_PTR_TO_CTX,
};
```

https://elixir.bootlin.com/linux/v6.2-rc6/source/net/core/filter.c#L4955
```
static const struct bpf_func_proto bpf_get_socket_cookie_sock_ops_proto =3D=
 {
        .func           =3D bpf_get_socket_cookie_sock_ops,
        .gpl_only       =3D false,
        .ret_type       =3D RET_INTEGER,
        .arg1_type      =3D ARG_PTR_TO_CTX,
};
```

It seems that the function definitions are quite real...

Quentin Monnet <quentin@isovalent.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8831=
=E6=97=A5=E5=91=A8=E4=BA=8C 20:02=E5=86=99=E9=81=93=EF=BC=9A

>
> 2023-01-31 12:40 UTC+0100 ~ Alejandro Colomar <alx.manpages@gmail.com>
> > [Resend with Quentin's right address, I hope]
> >
> > Hi Zexuan, Quentin,
> >
> > On 1/31/23 11:03, Zexuan Luo wrote:
> >> Hello Colomar,
> >>
> >> I just found a potential bug in the bpf-helpers page.
> >
> > Thanks for reporting bugs :)
> >
> >>
> >> Under the https://www.man7.org/linux/man-pages/man7/bpf-helpers.7.html=
:
> >
> > This page is generated from the Linux kernel sources.  I've CCed Quenti=
n
> > and the BPF list so they can check it there.
> >
>
> Hi Alejandro, Zexuan,
> Thanks for the report! Happy to take fixes, however, see below...
>
> > BTW, I'm refreshing the page now.
> >
>
> Great, thank you!
>
> > Quentin, I realized in the diff that there is some inconsistency in the
> > number of spaces after a sentence-ending period.  Could you please use
> > two spaces for that?  It's especially important for groff(1), which wil=
l
> > render it differently.   However, it's not a big issue, so don't feel
> > urged to do that.
>
> Yes, you mentioned that in the past and this is on my list. As you can
> see, I haven't felt urged so far indeed :). But it's still on my mind
> for the next time I take a look at this doc for typos etc.
>
> >
> > Cheers,
> >
> > Alex
> >
> >>
> >> ```
> >>         u64 bpf_get_socket_cookie(struct sk_buff *skb)
> >>
> >>                Description
> >>                       If the struct sk_buff pointed by skb has a known
> >>                       socket, retrieve the cookie (generated by the
> >>                       kernel) of this socket.  If no cookie has been s=
et
> >>                       yet, generate a new cookie. Once generated, the
> >>                       socket cookie remains stable for the life of the
> >>                       socket. This helper can be useful for monitoring
> >>                       per socket networking traffic statistics as it
> >>                       provides a global socket identifier that can be
> >>                       assumed unique.
> >>
> >>                Return A 8-byte long non-decreasing number on success, =
or
> >>                       0 if the socket field is missing inside skb.
> >>
> >>         u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
> >>
> >>                Description
> >>                       Equivalent to bpf_get_socket_cookie() helper tha=
t
> >>                       accepts skb, but gets socket from struct
> >>                       bpf_sock_addr context.
> >>
> >>                Return A 8-byte long non-decreasing number.
> >>
> >>         u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
> >>
> >>                Description
> >>                       Equivalent to bpf_get_socket_cookie() helper tha=
t
> >>                       accepts skb, but gets socket from struct
> >>                       bpf_sock_ops context.
> >>
> >>                Return A 8-byte long non-decreasing number.
> >> ```
> >>
> >> The function bpf_get_socket_cookie repeats three times. The second one
> >> should be bpf_get_socket_cookie_addr and the third one should be
> >> bpf_get_socket_cookie_ops.
> >
>
> No, I don't think there is anything wrong with that. I suppose you mean
> bpf_get_socket_cookie_sock_(addr|ops) (the functions you mentioned don't
> exist), but the four variants of the helper just have the same name, and
> take different objects for their context. There is no risk of collision
> because they are each associated to distinct eBPF program types.
>
> Please see also commit d692f1138a4b ("bpf: Support bpf_get_socket_cookie
> in more prog types"): "It doesn't introduce new helpers. Instead it
> reuses same helper name bpf_get_socket_cookie() but adds support to this
> helper to accept `struct bpf_sock_addr` and `struct bpf_sock_ops`.".
>
> Thanks,
> Quentin
