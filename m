Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B0351C6E
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 20:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhDASRd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 14:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238074AbhDASFX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 14:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617300322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YzublAd54jg8k1LXSyCAIIbMa3N1XeHCs+EWag/q89A=;
        b=Ys2i7cJwEHFpa5vxiB1NbQh/JgsELFeKxljYbffDiJg1SAYnNGx1OHpTGd2JNtLZS01VlA
        cWLkYrXOOgZaESK3yp2ePBV5my+RbfYRohGujYx+hPk95/sjXAQlZEMnamap1OHoK4+7w4
        jNj6OXLtF6Y2oi1sluALlMXdm8XtZ8Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-psNZ2kGbMcet1ofq_3LTVA-1; Thu, 01 Apr 2021 07:39:07 -0400
X-MC-Unique: psNZ2kGbMcet1ofq_3LTVA-1
Received: by mail-ed1-f69.google.com with SMTP id r19so2698456edv.3
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 04:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YzublAd54jg8k1LXSyCAIIbMa3N1XeHCs+EWag/q89A=;
        b=GSIBHvP5w9t9x3zmdFSJqgBZpU6mCeIEZTqfIZHtohLGu28SSIyTJQJVGNKG6RGa+O
         kDe3TXzteP3UACzqo0QkQhHObJI/Qjxn1hIJBp3SOrap46smU+Y86+wAJCyafgb+Er6p
         DwS2r1jLM4yFswNwlJD9udiaG5/dzrCmv+YasBH4F1J1n4GdCXphMdk42jHEfgLHgrSn
         Vp5SwZMOW3xWteybr+hpslDlXTp+kQJrtwc7Ns7vzUOpLhbQmwPPReAx9/yv7zl4uOcA
         v/qbeoBQrEE5xQimtSKUU8hgHqjdUc1los+ONVZyHKo7H7cp6DfAe4PGIEltvWxKa5RB
         OadQ==
X-Gm-Message-State: AOAM532w2UrUPfRYBKmTgY+3YhZf3kjeIs0euLxNKsVRYWWlWOvCs0zt
        4yaJkczNRyJVF9OMxlrOcLSb9QkGr+bl2CAAuFUuEie1C1KTWN/0d+BIjX+6xT7GxpzB6sVHESG
        PKA0on2uTljhE
X-Received: by 2002:a17:906:a413:: with SMTP id l19mr8654022ejz.421.1617277146784;
        Thu, 01 Apr 2021 04:39:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTRq0YLla4o1Pqqh6HjQ7Jl+GNQhIYu5f3XmU5O+wg98wmNGOXioOcuars8Zh98JDwgG+j5g==
X-Received: by 2002:a17:906:a413:: with SMTP id l19mr8653988ejz.421.1617277146536;
        Thu, 01 Apr 2021 04:39:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r17sm3369372edt.70.2021.04.01.04.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 04:39:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 33D4A180290; Thu,  1 Apr 2021 13:39:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next 9/9] net: enetc: add support for XDP_REDIRECT
In-Reply-To: <20210401113133.vzs3uxkp52k2ctla@skbuf>
References: <20210331200857.3274425-1-olteanv@gmail.com>
 <20210331200857.3274425-10-olteanv@gmail.com> <87blaynt4l.fsf@toke.dk>
 <20210401113133.vzs3uxkp52k2ctla@skbuf>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 01 Apr 2021 13:39:05 +0200
Message-ID: <875z16nsiu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Vladimir Oltean <olteanv@gmail.com> writes:

> On Thu, Apr 01, 2021 at 01:26:02PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> > +int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
>> > +		   struct xdp_frame **frames, u32 flags)
>> > +{
>> > +	struct enetc_tx_swbd xdp_redirect_arr[ENETC_MAX_SKB_FRAGS] =3D {0};
>> > +	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
>> > +	struct enetc_bdr *tx_ring;
>> > +	int xdp_tx_bd_cnt, i, k;
>> > +	int xdp_tx_frm_cnt =3D 0;
>> > +
>> > +	tx_ring =3D priv->tx_ring[smp_processor_id()];
>>=20
>> What mechanism guarantees that this won't overflow the array? :)
>
> Which array, the array of TX rings?

Yes.

> You mean that it's possible to receive a TC_SETUP_QDISC_MQPRIO or
> TC_SETUP_QDISC_TAPRIO with num_tc =3D=3D 1, and we have 2 CPUs?

Not just that, this ndo can be called on arbitrary CPUs after a
redirect. The code just calls through from the XDP receive path so which
CPU it ends up on depends on the RSS+IRQ config of the other device,
which may not even be the same driver; i.e., you have no control over
that... :)

> Well, yeah, I don't know what's the proper way to deal with that. Ideas?

Well the obvious one is just:

tx_ring =3D priv->tx_ring[smp_processor_id() % num_ring_ids];

and then some kind of locking to deal with multiple CPUs accessing the
same TX ring...

-Toke

