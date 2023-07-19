Return-Path: <bpf+bounces-5239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BE1758C00
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 05:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6BC1C20EF6
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 03:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868F43D8B;
	Wed, 19 Jul 2023 03:21:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B13D61
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 03:21:56 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168BC1BF3
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 20:21:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5216f713f8bso6679588a12.2
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 20:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689736912; x=1692328912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6nGe3/14lsIlAFKvEfl97Na5N58gbsjqham6f34LTI=;
        b=Wv+4+oXQl7HjDsiJtgHXbRji7FkiAndbYjBdgI+lOTSTnCWTHSki+QPrxMg/vtOvSh
         r0iVYBxIjy3Wga8epsor/VmNiFFJfTXP91/upI7QJ6eJAQP/0Hw1HIJ0gpgAlpCrutQS
         sDkFj3Jo4/KxP8goc1v6ulCxpyCWDxYCc/Do0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689736912; x=1692328912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6nGe3/14lsIlAFKvEfl97Na5N58gbsjqham6f34LTI=;
        b=MHD9WhyzbfnJrN30soNO0qO5g5+sq92R6XKhF4kE9SJ4GZzydatR7Vmksk3H8bbPFz
         UFv6TqCljChRTErz+oq0RDFrbRKy6uPNagTvuzeboTBSfZmAuW7J6/SJaUdt1/lr77bF
         mmNv9eFigmjeYJYiVe2rf/Gf+x2DJ+qadfLII3vPHsZMmmnWbWdG+VCJwr3HjmbrmEEp
         WsWqeeIrC+h1iQWWGw7Rk91gDf/xio9m3SwPbmM2Ntdyz9dVOfTnoezYPFRvA0pQuqbU
         lb3MVOKUgsTZzkcpePmpaRr99+NXGlOBxjIlrbH8Sph9K5CFw9SRln9bnEQloluaWX1Z
         aPVA==
X-Gm-Message-State: ABy/qLYkUyvvFpnlbL8MlCNAjBBoA15ZByeiZA5rYN8qvxf2w52KkaA/
	xonNYMPnkp2m6qiGv8odkDm/9K4MBCjEtwaX+qy2/A==
X-Google-Smtp-Source: APBJJlFF1zPR6RZhoXb9k5Shx2JBKFy+oeMXucMQtDZCRUaNOkXMNH9jV9AG0eGzaVc4G/xOkyyTsTlw1zqedF1qjZE=
X-Received: by 2002:aa7:d384:0:b0:51e:309:2e11 with SMTP id
 x4-20020aa7d384000000b0051e03092e11mr1453872edq.36.1689736912402; Tue, 18 Jul
 2023 20:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZLbYdpWC8zt9EJtq@debian.debian> <CAKH8qBsZeqchfcYm-pNKjafYwFzGnwzcXDgHfj3Omkm0yWd31A@mail.gmail.com>
In-Reply-To: <CAKH8qBsZeqchfcYm-pNKjafYwFzGnwzcXDgHfj3Omkm0yWd31A@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 18 Jul 2023 22:21:41 -0500
Message-ID: <CAO3-PbqF_JMyHK2hE=MH9cF3i2xVQ-vpQhdZ7HG4uVM7jan4xw@mail.gmail.com>
Subject: Re: [PATCH] bpf: lwt: do not return NET_XMIT_xxx values on bpf_redirect
To: Stanislav Fomichev <sdf@google.com>
Cc: "open list:BPF [NETWORKING] (tc BPF, sock_addr)" <bpf@vger.kernel.org>, kernel-team@cloudflare.com, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:BPF [NETWORKING] (tc BPF, sock_addr)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Jordan Griege <jgriege@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 3:29=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On Tue, Jul 18, 2023 at 11:22=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wr=
ote:
> >
> > skb_do_redirect handles returns error code from both rx and tx path.
> > The tx path codes are special, e.g. NET_XMIT_CN: they are
> > non-negative, and can conflict with LWTUNNEL_XMIT_xxx values. Directly
> > returning such code can cause unexpected behavior. We found at least
> > one bug that will panic the kernel through KASAN report when we
> > accidentally redirect packets to a down or carrier-down device at lwt
> > xmit hook:
> >
> > https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48
> >
> > Above bug is hit because NET_XMIT_CN is returned by noop_qdisc of the
> > down device, and it propagates from dev_queue_xmit all way to the lwt
> > logic. Although skb has been freed by the qdisc, it still continues to
> > neighbor subsystem and triggers the bug.
> >
> > This change converts the tx code to proper errors that lwt can consume.
> >
> > Reported-by: Jordan Griege <jgriege@cloudflare.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> >  net/core/filter.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 06ba0e56e369..c9cc501ecdc0 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2129,6 +2129,11 @@ static inline int __bpf_tx_skb(struct net_device=
 *dev, struct sk_buff *skb)
> >         ret =3D dev_queue_xmit(skb);
> >         dev_xmit_recursion_dec();
> >
> > +       // We should not return NET_XMIT_xxx here since it will conflic=
t with
> > +       // LWTUNNEL_XMIT_xxx values. Convert the return value to errno =
instead.
>
> C++ comments; should be /* */. But, also, maybe they are not really neede=
d?
>
*facepalm* yes I think we can remove them since the commit message
already covers it...

> ret =3D dev_queue_xmit(skb);
> if (ret)
>         ret =3D net_xmit_errno(ret);
>
> We have a bunch of places with the pattern like this, so probably can
> do the same here?
>
Personally I like an explicit name better, since not all the return
codes use 0 to signal success, e.g. XDP_PASS, TC_ACT_PIPE. But I'd
leave that for future improvements now that all other places use 0 on
this.

thanks
Yan

> > +       if (unlikely(ret !=3D NET_XMIT_SUCCESS))
> > +               ret =3D net_xmit_errno(ret);
> > +
> >         return ret;
> >  }
> >
> > --
> > 2.30.2
> >



--=20

Yan

