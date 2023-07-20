Return-Path: <bpf+bounces-5412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0652575A483
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 04:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CC61C2114F
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0A610F7;
	Thu, 20 Jul 2023 02:48:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32967381
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 02:48:54 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1792F1BFC
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 19:48:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51f7fb9a944so321744a12.3
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689821330; x=1690426130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6WYVWYrbXb8iJtFoUKTJHuArrTvnYpoCUNdm9ArDBU=;
        b=vcpSq5efiWfRoeEuQ8DIpdemJ/kEyExu1pg4fGvQDP9AqI6EHLqRkrkvQ3LzqedoQ8
         +5eOgLm5sUSffZnSTGRjU1uQV80HONokEyIl5FocvTQvle3W0Ef6LmGvKPf1DRuqce6q
         NB/h5wq2mOhw1TW6bGfFARGLwoTv1d1x9oE90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689821330; x=1690426130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6WYVWYrbXb8iJtFoUKTJHuArrTvnYpoCUNdm9ArDBU=;
        b=E7M2TXfVzciB2Rd/EIje2NUOFnTCib3++115PUrmb3JobYO4KIcKWiYeYFFNrcf+s+
         DEykr4VA/5Le7VB+XjQri1GRh5EAuLFM3gTs3QLI9CuW3q3D+3zBgL/lSqPvyT2ZZ62z
         1SFV0ANYcrzWGBrfORdn+2lxqthOsAsIYORldzHRDKaR4tsgc5DNodjWkH2DHGbuVpqI
         rn+mmxHpJBIXyWMM6AWUIOnPW5FiBb9BBoBHK6EXgSx/c5/ex2T0BPTZns4BOglrTV4P
         EC50vCYqkIQtPvJ+mk0xtoESdqeQnQI5lOamyN2qcBWdKfEx/cuZc3hQVRkTih1z93SE
         3bfw==
X-Gm-Message-State: ABy/qLb0Ij6OFkRwFkHnEynofSzFNnS1ZaqQECyN58tjtkHaPgt9nRRU
	7YRoaSqPaPqoGzBoBE66EoE9SXVIGb7OYbIDuLsMfg==
X-Google-Smtp-Source: APBJJlE4lJbEWuicmvx7rTLzbS0AdQfZ0xYO09uqtILx/IgDEyJpnJ/Zj1jfL9NtM7jOdCNdJ9odgbHvUeY3HhKVqr4=
X-Received: by 2002:a05:6402:1295:b0:51a:3159:53c7 with SMTP id
 w21-20020a056402129500b0051a315953c7mr3643380edv.30.1689821330554; Wed, 19
 Jul 2023 19:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZLdY6JkWRccunvu0@debian.debian> <CAADnVQJNCEntFEh6pNY2HHwxoua0_2mRky2g2U5tj6XU2eoZog@mail.gmail.com>
In-Reply-To: <CAADnVQJNCEntFEh6pNY2HHwxoua0_2mRky2g2U5tj6XU2eoZog@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 19 Jul 2023 21:48:39 -0500
Message-ID: <CAO3-Pbr_S_1RYk0x4kHbnna=qcYVJ7u9zx9O-TGNcJz3oUQ0FQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] bpf: do not return NET_XMIT_xxx values on bpf_redirect
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Jordan Griege <jgriege@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 10:42=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 18, 2023 at 8:30=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > skb_do_redirect handles returns error code from both rx and tx path. Th=
e
> > tx path codes are special, e.g. NET_XMIT_CN: they are non-negative, and
> > can conflict with LWTUNNEL_XMIT_xxx values. Directly returning such cod=
e
> > can cause unexpected behavior. We found at least one bug that will pani=
c
> > the kernel through KASAN report when we are redirecting packets to a
> > down or carrier-down device at lwt xmit hook:
> >
> > https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48
> >
> > Above bug is hit because NET_XMIT_CN is returned by noop_qdisc of the
> > down device, and it propagates from dev_queue_xmit all way to the lwt
> > logic. The result is skb that has been freed by the qdisc continues to
> > neighbor subsystem and triggers the bug.
>
> I'm struggling to parse the above paragraph.
> Where bpf prog is installed?
> Is this lwt bpf prog that returns BPF_REDIRECT ?
> that redirects to netdev with noop_qdisc ?
> What is the topology?
>
Sorry for the confusion. Mentioning noop_qdisc is an explanation of
what happened. The actual trigger is simple: install a bpf program on
lwt route at xmit hook. It bpf_redirect packets to a device FOO. If
FOO is down or carrier-down, redirected packets will crash the kernel.

> Please add a selftest to make sure we don't regress.
>
> Also pls mark your patch as [PATCH v3 bpf] when you respin.
>
Ack

> > This change converts the tx code to proper errors that lwt can consume.
> >
> > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > Reported-by: Jordan Griege <jgriege@cloudflare.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> > v2: coding style fix; sent to netdev instead of bpf for bug fixing.
> >
> > ---
> >  net/core/filter.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 06ba0e56e369..8738c7a4701d 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device =
*dev, struct sk_buff *skb)
> >         ret =3D dev_queue_xmit(skb);
> >         dev_xmit_recursion_dec();
> >
> > +       if (unlikely(ret > 0))
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

