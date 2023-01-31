Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5BC682F93
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 15:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjAaOp4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 09:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaOp4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 09:45:56 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C96B76B;
        Tue, 31 Jan 2023 06:45:54 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-506609635cbso206187127b3.4;
        Tue, 31 Jan 2023 06:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6P5ZAjVJPqsEbTCfWa0qRCESMIW/qWseWYeyJKs3uA=;
        b=mtYJc24tYCIOazg7sln6OTx+yRRuZ3Y2fqTNgC6v1y4SDwVKmMCsfhHlRVB0cPMEct
         O1SJtJVmblIUou+kO6gb7gMW0wszaq3Od/wRHh0wYr2kw3a9X13v+wi1y9FUu01iig1V
         C1kv+FP3W7WMRQBbkzwyPEPzxpiwccB9OOUUaG6wzay+dhFOxKrZtvg2VMyZilzkash9
         IxSoni/wrGoGKswhXWkS76TmhSCfvREyqJDLyK7kz0WaYqelceBh23r8OXw+f3vrf6fG
         9nMDLRgy/fvTfb5xIoTWfxfOUeoadvqIdYuXeDGkTjh3AT+2f03f6YeoHNPSGRfzcghc
         YCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6P5ZAjVJPqsEbTCfWa0qRCESMIW/qWseWYeyJKs3uA=;
        b=CConPimWA899+i9sigVCLW9KazoEywAuRZ+nEbMYDnQp1W0selCsGOH6xOHJsox45O
         N/bdtXx03zsbS6jVNnv67vQjLsfdyRItJB/Nkk4I9Jx+egWSjETyJPXY8TpYulyXr6tg
         0AMUlnta29Q14Uh5xmdtMdVp3xcfTU3/kXN//Q4bkAB3DE09zBvJYui/PotX83khTEXD
         KZPqWSOpBj/WGwXcI0cinhStdynkn0PlDoSudX3JlZdAMotvEKYdT4pKZ2wTOEq9KaOe
         MYcfVj7Qi4DPfqAh0Gaf0l5l9zC9KB065VBhoQ4K1uwjirfWEma8VWO2cfSAPtMDncDc
         +fzQ==
X-Gm-Message-State: AFqh2kq2J2WIKgS2wUMElp3nxYBkPlBlYOXGCIQto9oaLylAjsIRmE5G
        GA+P7j7Pth7wgQarwRW4RIhGIfIHwlNy6lNwukvWpN8IchLxDg==
X-Google-Smtp-Source: AMrXdXsf4BR4vFKFj9FSZ8ob5nIXom5dLpLbhEgQe3Om+9BiwUV6q8Zg7EjyJkzaxYYbr27/eVla1jZpwdhFj+TgeBI=
X-Received: by 2002:a81:d409:0:b0:502:a4c9:8953 with SMTP id
 z9-20020a81d409000000b00502a4c98953mr4736091ywi.151.1675176354066; Tue, 31
 Jan 2023 06:45:54 -0800 (PST)
MIME-Version: 1.0
References: <CAADJU1032g+sNGN9AZKeVuMzZywXZ0BWpm3592XcGJdp4goCUQ@mail.gmail.com>
 <991b275a-4a44-a870-24e6-d6683bf69589@gmail.com> <877b57f5-77ba-805b-ed5f-57e47fa83b16@gmail.com>
 <195ea485-1449-7ed8-5184-d00cf7e0dd5b@isovalent.com> <CAADJU11ei7KAv1c=f1Gj5TzipS9+yenEfDffznfftej14ESZkg@mail.gmail.com>
In-Reply-To: <CAADJU11ei7KAv1c=f1Gj5TzipS9+yenEfDffznfftej14ESZkg@mail.gmail.com>
From:   Zexuan Luo <spacewanderlzx@gmail.com>
Date:   Tue, 31 Jan 2023 22:45:43 +0800
Message-ID: <CAADJU11jyi03ex4ufVS+sXk9zz3XMqz4f78_7ianznjnZ7mQdw@mail.gmail.com>
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

Hi Quentin,
After reading https://github.com/torvalds/linux/commit/d692f1138a4b,
now I figure out that only BPF_FUNC_get_socket_cookie is exposed.
The same name (function id BPF_FUNC_get_socket_cookie) will be
resolved to a different function (bpf_get_socket_cookie_sock_ops and
the others) according to the scope.

Thanks for your explanation!

Zexuan Luo <spacewanderlzx@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8831=E6=
=97=A5=E5=91=A8=E4=BA=8C 22:36=E5=86=99=E9=81=93=EF=BC=9A
>
> My bad!
>
> > No, I don't think there is anything wrong with that. I suppose you mean
> bpf_get_socket_cookie_sock_(ad
> dr|ops) (the functions you mentioned don't
> exist), but the four variants of the helper just have the same name, and
> take different objects for their context.
>
> Yes! I made a mistake in the function names in the first email. Thank
> you for pointing that out.
>
> I am an eBPF newbie and I am learning it currently. AFAIK, language C
> doesn't support function overriding via different parameters.
> So how do these four functions co-exist?
>
> Some naive search in the kernel code leads me to:
> https://elixir.bootlin.com/linux/v6.2-rc6/source/net/core/filter.c#L4919
> ```
> static const struct bpf_func_proto bpf_get_socket_cookie_sock_addr_proto =
=3D {
>     .func        =3D bpf_get_socket_cookie_sock_addr,
>     .gpl_only    =3D false,
>     .ret_type    =3D RET_INTEGER,
>     .arg1_type    =3D ARG_PTR_TO_CTX,
> };
> ```
>
> https://elixir.bootlin.com/linux/v6.2-rc6/source/net/core/filter.c#L4955
> ```
> static const struct bpf_func_proto bpf_get_socket_cookie_sock_ops_proto =
=3D {
>         .func           =3D bpf_get_socket_cookie_sock_ops,
>         .gpl_only       =3D false,
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_CTX,
> };
> ```
>
> It seems that the function definitions are quite real...
>
> Quentin Monnet <quentin@isovalent.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8831=
=E6=97=A5=E5=91=A8=E4=BA=8C 20:02=E5=86=99=E9=81=93=EF=BC=9A
>
> >
> > 2023-01-31 12:40 UTC+0100 ~ Alejandro Colomar <alx.manpages@gmail.com>
> > > [Resend with Quentin's right address, I hope]
> > >
> > > Hi Zexuan, Quentin,
> > >
> > > On 1/31/23 11:03, Zexuan Luo wrote:
> > >> Hello Colomar,
> > >>
> > >> I just found a potential bug in the bpf-helpers page.
> > >
> > > Thanks for reporting bugs :)
> > >
> > >>
> > >> Under the https://www.man7.org/linux/man-pages/man7/bpf-helpers.7.ht=
ml:
> > >
> > > This page is generated from the Linux kernel sources.  I've CCed Quen=
tin
> > > and the BPF list so they can check it there.
> > >
> >
> > Hi Alejandro, Zexuan,
> > Thanks for the report! Happy to take fixes, however, see below...
> >
> > > BTW, I'm refreshing the page now.
> > >
> >
> > Great, thank you!
> >
> > > Quentin, I realized in the diff that there is some inconsistency in t=
he
> > > number of spaces after a sentence-ending period.  Could you please us=
e
> > > two spaces for that?  It's especially important for groff(1), which w=
ill
> > > render it differently.   However, it's not a big issue, so don't feel
> > > urged to do that.
> >
> > Yes, you mentioned that in the past and this is on my list. As you can
> > see, I haven't felt urged so far indeed :). But it's still on my mind
> > for the next time I take a look at this doc for typos etc.
> >
> > >
> > > Cheers,
> > >
> > > Alex
> > >
> > >>
> > >> ```
> > >>         u64 bpf_get_socket_cookie(struct sk_buff *skb)
> > >>
> > >>                Description
> > >>                       If the struct sk_buff pointed by skb has a kno=
wn
> > >>                       socket, retrieve the cookie (generated by the
> > >>                       kernel) of this socket.  If no cookie has been=
 set
> > >>                       yet, generate a new cookie. Once generated, th=
e
> > >>                       socket cookie remains stable for the life of t=
he
> > >>                       socket. This helper can be useful for monitori=
ng
> > >>                       per socket networking traffic statistics as it
> > >>                       provides a global socket identifier that can b=
e
> > >>                       assumed unique.
> > >>
> > >>                Return A 8-byte long non-decreasing number on success=
, or
> > >>                       0 if the socket field is missing inside skb.
> > >>
> > >>         u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
> > >>
> > >>                Description
> > >>                       Equivalent to bpf_get_socket_cookie() helper t=
hat
> > >>                       accepts skb, but gets socket from struct
> > >>                       bpf_sock_addr context.
> > >>
> > >>                Return A 8-byte long non-decreasing number.
> > >>
> > >>         u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
> > >>
> > >>                Description
> > >>                       Equivalent to bpf_get_socket_cookie() helper t=
hat
> > >>                       accepts skb, but gets socket from struct
> > >>                       bpf_sock_ops context.
> > >>
> > >>                Return A 8-byte long non-decreasing number.
> > >> ```
> > >>
> > >> The function bpf_get_socket_cookie repeats three times. The second o=
ne
> > >> should be bpf_get_socket_cookie_addr and the third one should be
> > >> bpf_get_socket_cookie_ops.
> > >
> >
> > No, I don't think there is anything wrong with that. I suppose you mean
> > bpf_get_socket_cookie_sock_(addr|ops) (the functions you mentioned don'=
t
> > exist), but the four variants of the helper just have the same name, an=
d
> > take different objects for their context. There is no risk of collision
> > because they are each associated to distinct eBPF program types.
> >
> > Please see also commit d692f1138a4b ("bpf: Support bpf_get_socket_cooki=
e
> > in more prog types"): "It doesn't introduce new helpers. Instead it
> > reuses same helper name bpf_get_socket_cookie() but adds support to thi=
s
> > helper to accept `struct bpf_sock_addr` and `struct bpf_sock_ops`.".
> >
> > Thanks,
> > Quentin
