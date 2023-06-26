Return-Path: <bpf+bounces-3506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F94173EEB4
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 00:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732021C20A01
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013131C17;
	Mon, 26 Jun 2023 22:38:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE315AC4;
	Mon, 26 Jun 2023 22:37:59 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7753E71;
	Mon, 26 Jun 2023 15:37:57 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6a675743dso16661111fa.2;
        Mon, 26 Jun 2023 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687819076; x=1690411076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGKAFHbZC4cH7Ih+qJbRUkOpVmcOgEOXjYwSvJ4Lvgg=;
        b=RIHDV327WnntGMoaDhWBjriya4erCYEhKRMDZ3sfrt3BHDrbRQ3BffTu4o9n0T6GPn
         pOCD5xfUyCNqY6kQ4Vu+RS5cWBoWwOoqVDCGlzyLhJ681wmaLwC33uLl1HRQLfHiEEML
         huXx1LWRIC9Q8UmilKW0VXPASR0cq1xirBubEC7Ev4wWtafdKK3NxRfg9rugsi1GX/hF
         SH8bhjQKUgGL2Do8N73Gxes7cH2rVTNpG6r/IEbYuwlURk8iBe8/xD4JCqAMvoO8MU9f
         VaOZtzXOmLpnE1ija/PUj1BD+3VBEGfqf+/fODv5/jfABkBNd/43XLLB04IFBlqMvsqx
         q48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687819076; x=1690411076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGKAFHbZC4cH7Ih+qJbRUkOpVmcOgEOXjYwSvJ4Lvgg=;
        b=BMvFE8ltqjHUZb3eEF+Bbjqjg8BTmHOgdYVNQpwiOSYe29DHn25fvYkY55U6DyHLlI
         N40o3lGaMHnnt+HJt03jKNegIWlCP85vyoOy2x6yOreiQPRi+GyzSJB/RM2tezauXDEm
         0gTbzQIIvTJJzNSMNedBef73JlqGxRTNafEYikqQV+h01mIp604h06s4D9ljydF5nsgs
         hTGwv4V/3tblPoaCGTDF0ewkZp9umCXJKtxjMo13O59heWU6zQuNTopnXxERTP2Glnj/
         X/WVhLBtIR0VqsPWICaBGSJH3PGutY/V69/isS2ZSIAXM5X4U2br2wn+7t7CoMLkH8Ng
         t9Tg==
X-Gm-Message-State: AC+VfDz0v/FDPnfBgENTbkqrNS1R+YzfTpVPysBCrml8JJJswrd1iSe1
	7YzCNAFozB8rgf+WTBwF4VQoqnkSIYpA7brQiUg=
X-Google-Smtp-Source: ACHHUZ7ock+asetNFMgH9r8OM4sh2UOfPQXFq8CTlan1/hLD/+e4P19VDE1hXlakS5yYw6WVOJvaZ2hKGTum/mMY8K0=
X-Received: by 2002:a2e:9a8e:0:b0:2b6:a52b:24ac with SMTP id
 p14-20020a2e9a8e000000b002b6a52b24acmr2383951lji.22.1687819075481; Mon, 26
 Jun 2023 15:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
 <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
 <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com> <649637e91a709_7bea820894@john.notmuch>
 <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
 <20230624143834.26c5b5e8@kernel.org> <ZJeUlv/omsyXdO/R@google.com> <ZJoExxIaa97JGPqM@google.com>
In-Reply-To: <ZJoExxIaa97JGPqM@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 26 Jun 2023 15:37:44 -0700
Message-ID: <CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
To: Stanislav Fomichev <sdf@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Donald Hunter <donald.hunter@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 2:36=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> > >
> > > I'd think HW TX csum is actually simpler than dealing with time,
> > > will you change your mind if Stan posts Tx csum within a few days? :)

Absolutely :) Happy to change my mind.

> > > The set of offloads is barely changing, the lack of clarity
> > > on what is needed seems overstated. IMHO AF_XDP is getting no use
> > > today, because everything remotely complex was stripped out of
> > > the implementation to get it merged. Aren't we hand waving the
> > > complexity away simply because we don't want to deal with it?
> > >
> > > These are the features today's devices support (rx/tx is a mirror):
> > >  - L4 csum
> > >  - segmentation
> > >  - time reporting
> > >
> > > Some may also support:
> > >  - forwarding md tagging
> > >  - Tx launch time
> > >  - no fcs
> > > Legacy / irrelevant:
> > >  - VLAN insertion
> >
> > Right, the goal of the series is to lay out the foundation to support
> > AF_XDP offloads. I'm starting with tx timestamp because that's more
> > pressing. But, as I mentioned in another thread, we do have other
> > users that want to adopt AF_XDP, but due to missing tx offloads, they
> > aren't able to.
> >
> > IMHO, with pre-tx/post-tx hooks, it's pretty easy to go from TX
> > timestamp to TX checksum offload, we don't need a lot:
> > - define another generic kfunc bpf_request_tx_csum(from, to)
> > - drivers implement it
> > - af_xdp users call this kfunc from devtx hook
> >
> > We seem to be arguing over start-with-my-specific-narrow-use-case vs
> > start-with-generic implementation, so maybe time for the office hours?
> > I can try to present some cohesive plan of how we start with the framew=
ork
> > plus tx-timestamp and expand with tx-checksum/etc. There is a lot of
> > commonality in these offloads, so I'm probably not communicating it
> > properly..
>
> Or, maybe a better suggestion: let me try to implement TX checksum
> kfunc in the v3 (to show how to build on top this series).
> Having code is better than doing slides :-D

That would certainly help :)
What I got out of your lsfmmbpf talk is that timestamp is your
main and only use case. tx checksum for af_xdp is the other use case,
but it's not yours, so you sort-of use it as an extra justification
for timestamp. Hence my negative reaction to 'generality'.
I think we'll have better results in designing an api
when we look at these two use cases independently.
And implement them in patches solving specifically timestamp
with normal skb traffic and tx checksum for af_xdp as two independent apis.
If it looks like we can extract a common framework out of them. Great.
But trying to generalize before truly addressing both cases
is likely to cripple both apis.

It doesn't have to be only two use cases.
I completely agree with Kuba that:
 - L4 csum
 - segmentation
 - time reporting
are universal HW NIC features and we need to have an api
that exposes these features in programmable way to bpf progs in the kernel
and through af_xdp to user space.
I mainly suggest addressing them one by one and look
for common code bits and api similarities later.

