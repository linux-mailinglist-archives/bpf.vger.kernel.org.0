Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBB846D418
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 14:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhLHNLT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 08:11:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232273AbhLHNLT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 08:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638968867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZ4qMbAXmeabCTHvbgEgD96448n1l1dfuiYBFx9k+lI=;
        b=P46waLdgnVA1wzefId2o6Ude9NRw0rPtHX7WUxBVdWrsNbBRDw6+leLOsXFaTCG5w80enE
        hhRNx/3gmcMMBPUYBn7Q4T0khNelE1i65LX/mWysYEGrsSHQ9mxdOAZHhTDQ0q+5/Ffswu
        ZNvB9qZ4x2KSS9Y6k+2DyVhySyOTlXY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-2-dnEIZSMrKouPv5LWkq_A-1; Wed, 08 Dec 2021 08:07:45 -0500
X-MC-Unique: 2-dnEIZSMrKouPv5LWkq_A-1
Received: by mail-ed1-f72.google.com with SMTP id w4-20020aa7cb44000000b003e7c0f7cfffso2092384edt.2
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 05:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WZ4qMbAXmeabCTHvbgEgD96448n1l1dfuiYBFx9k+lI=;
        b=V8WErCyxrT8cvhWISq/zztj1UnLmOOWhMBSzSL2IjR0pUCku2cazLj8Wm8GWsu5wcB
         0QbP9a7lpAvuH2f9CxAhYzweBQRJoZpG3pHn2b5JrAJiasLTCexzsdOeMml7/zMWCAI8
         nMD5P3VsORLLLormUArKLiZb1FaHE+2WgqsWqmptDUsbJcNOkq1u7Z/Z5E8FGk23HbVT
         MzuetUHkKuEK3kEpAcqdymKAjIuNBvbssdNT0JRBQ+yf1ByqWU//yuBza1obp39f77G1
         8V+BD3Caix6IoePA4tIZGamRdEnJWX9Xc6xBO9bLc9Kk9DbVlIrfIQCRa/QXKviAHnjC
         oEKg==
X-Gm-Message-State: AOAM530kcvLvzfonrhNpFwzkycwYGRx0e4ZNyEe0SQ8i4m0Cx6ZqxjG/
        po1IMseDEsphDcwxu22Ho6UP9ZXUYU6b0ZXTpJV98/Dme1HUz4jHaQV7isuBfACHHCyhz+vY3py
        zyOEuq5EZgt2d
X-Received: by 2002:a17:906:4aca:: with SMTP id u10mr7397032ejt.305.1638968863953;
        Wed, 08 Dec 2021 05:07:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLGTWtzqIz86k63en8xkyrd24lq8MrAX2dhh2Y1hgZTXXwopmFZg1z03jTCqp8uFJnAY2yrw==
X-Received: by 2002:a17:906:4aca:: with SMTP id u10mr7396805ejt.305.1638968862076;
        Wed, 08 Dec 2021 05:07:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e15sm1949569edq.46.2021.12.08.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:07:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 48C0E180441; Wed,  8 Dec 2021 14:07:40 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Zvi Effron <zeffron@riotgames.com>
Cc:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, brouer@redhat.com, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        shayagr@amazon.com, john.fastabend@gmail.com, dsahern@kernel.org,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v19 bpf-next 23/23] xdp: disable XDP_REDIRECT for xdp
 multi-buff
In-Reply-To: <Ya5srnSIkt+bgJaC@lore-desk>
References: <cover.1638272238.git.lorenzo@kernel.org>
 <df855fe05b80746fa7f657fce78b24d582f133cb.1638272239.git.lorenzo@kernel.org>
 <88f9b4e9-9074-a507-426d-7c947f1e2b13@redhat.com>
 <CAC1LvL1U1=Qb9Em5=uwC=RQw0pKPQ+dCdURgURbLgGAJkXm0eg@mail.gmail.com>
 <Ya5srnSIkt+bgJaC@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 08 Dec 2021 14:07:40 +0100
Message-ID: <87mtlbxn1f.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> On Mon, Dec 6, 2021 at 11:11 AM Jesper Dangaard Brouer
>> <jbrouer@redhat.com> wrote:
>> >
>> > On 30/11/2021 12.53, Lorenzo Bianconi wrote:
>> > > XDP_REDIRECT is not fully supported yet for xdp multi-buff since not
>> > > all XDP capable drivers can map non-linear xdp_frame in ndo_xdp_xmit
>> > > so disable it for the moment.
>> > >
>> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > > ---
>> > >   net/core/filter.c | 7 +++++++
>> > >   1 file changed, 7 insertions(+)
>> > >
>> > > diff --git a/net/core/filter.c b/net/core/filter.c
>> > > index b70725313442..a87d835d1122 100644
>> > > --- a/net/core/filter.c
>> > > +++ b/net/core/filter.c
>> > > @@ -4189,6 +4189,13 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
>> > >       struct bpf_map *map;
>> > >       int err;
>> > >
>> > > +     /* XDP_REDIRECT is not fully supported yet for xdp multi-buff since
>> > > +      * not all XDP capable drivers can map non-linear xdp_frame in
>> > > +      * ndo_xdp_xmit.
>> > > +      */
>> > > +     if (unlikely(xdp_buff_is_mb(xdp)))
>> > > +             return -EOPNOTSUPP;
>> > > +
>> >
>> > This approach also exclude 'cpumap' use-case, which you AFAIK have added
>> > MB support for in this patchset.
>> >
>> > Generally this check is hopefully something we can remove again, once
>> > drivers add MB ndo_xdp_xmit support.
>> >
>> 
>> What happens in the future when a new driver is added without (in its intial
>> version) MB ndo_xdp_xmit support? Is MB support for ndo_xdp_xmit going to be a
>> requirement for a driver (with ndo_xdp_xmit) to be accepted to the kernel?
>
> I think the optimal solution would be export the driver XDP capabilities (AFAIK
> there is an ogoing effort for this, but it is not available yet).

Until that materialises I think we can at least require new drivers to
check the MB flag and drop the frame if it doesn't know what to do with
it. A follow-on patch could also just update all the existing drivers to
do this and then remove this check...

-Toke

