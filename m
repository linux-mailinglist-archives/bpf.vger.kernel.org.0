Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC7449B75
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 19:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhKHSMC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 13:12:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234982AbhKHSMA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 13:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636394955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cEuhXaEuhD+GKL/lBmFj9KF6WCNj/n+YccNImJPdjg=;
        b=Qe0ArsfQZRCC0E6pJ6ixO+6pLcqxNtKHbsnYD/qAEUJ7HnZtXViJXUahRjR61wWklUI4UM
        0rXzSq4Kdvp24qmviX8PyYsySZWPax4OeG0IakHgbBNIJiGvvSa2+mnKIks2Gi99ILpAlD
        b1kMwdMu5EKO/BRF0sw8XqvHXFrhUnI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-eXrh2DszO5OmDgtXlGqmvg-1; Mon, 08 Nov 2021 13:09:14 -0500
X-MC-Unique: eXrh2DszO5OmDgtXlGqmvg-1
Received: by mail-ed1-f70.google.com with SMTP id f20-20020a0564021e9400b003e2ad3eae74so15599861edf.5
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 10:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1cEuhXaEuhD+GKL/lBmFj9KF6WCNj/n+YccNImJPdjg=;
        b=doGF79au3Q8uzSGSpveJNyCyS/mxC0R+rqLVHjphCCn+JJ9ydbQlpm9RatvYVN1wRQ
         /ui9gb0wSBmwAcDnJy60q9er6meFWLoaleN4Q5v5B2rldraykB0PpmDDJix2XKyvvahw
         MH+zh8xOWUX539iBcYhRquHZY8Y76R7THHS0HVs/Hgbi5pUdegRyvFkIKNBi83H6UKhY
         SznGdxp3vmlmMxhi+zHYMyXXYXQ0fS0KMLdilalIqgsR9eGO+pK+3GgUdhTQiW4VEANf
         9bzTd3NlKq/qdlByQgda4AqFqVAvkftrwVdXnkm89l2ToJVysTE13Zimp1xigmU+SS6p
         DPRA==
X-Gm-Message-State: AOAM532yFXSRNcS1meebtrwyd2R/3faRbVVZf2SXn7FsfXayMAqTtwFu
        GaNRDwaFgaso7a9IVKPoe6PB74kJ5ACNAzpeiNEVFzE65cRXmWXEVan5ELmHoEnaT9p/V+DdHpd
        l8pdet/tfPROr
X-Received: by 2002:a17:907:8692:: with SMTP id qa18mr1467266ejc.7.1636394950734;
        Mon, 08 Nov 2021 10:09:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyClv8tcSrI/UxXplWxRW76JXyVsa3nEi/pu2Ka0nP1mqXKVKeTujb2Aq2XU4+3KU1tY6N6lw==
X-Received: by 2002:a17:907:8692:: with SMTP id qa18mr1467121ejc.7.1636394949701;
        Mon, 08 Nov 2021 10:09:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id gn16sm8739933ejc.67.2021.11.08.10.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:09:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1A5BA18026D; Mon,  8 Nov 2021 19:09:08 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lukasz Czapnik <lukasz.czapnik@intel.com>,
        Marcin Kubiak <marcin.kubiak@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Netanel Belgazal <netanel@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        Guy Tzalik <gtzalik@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shay Agroskin <shayagr@amazon.com>,
        Sameeh Jubran <sameehj@amazon.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
        Vladyslav Tarasiuk <vladyslavt@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jian Shen <shenjian15@huawei.com>,
        Petr Vorel <petr.vorel@gmail.com>, Dan Murphy <dmurphy@ti.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 03/21] ethtool, stats: introduce standard XDP
 statistics
In-Reply-To: <20211108132113.5152-1-alexandr.lobakin@intel.com>
References: <20210803163641.3743-1-alexandr.lobakin@intel.com>
 <20210803163641.3743-4-alexandr.lobakin@intel.com>
 <20210803134900.578b4c37@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <ec0aefbc987575d1979f9102d331bd3e8f809824.camel@kernel.org>
 <20211026092323.165-1-alexandr.lobakin@intel.com>
 <20211105164453.29102-1-alexandr.lobakin@intel.com>
 <87v912ri7h.fsf@toke.dk>
 <20211108132113.5152-1-alexandr.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Nov 2021 19:09:08 +0100
Message-ID: <87cznar03f.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexander Lobakin <alexandr.lobakin@intel.com> writes:

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Date: Mon, 08 Nov 2021 12:37:54 +0100
>
>> Alexander Lobakin <alexandr.lobakin@intel.com> writes:
>>=20
>> > From: Alexander Lobakin <alexandr.lobakin@intel.com>
>> > Date: Tue, 26 Oct 2021 11:23:23 +0200
>> >
>> >> From: Saeed Mahameed <saeed@kernel.org>
>> >> Date: Tue, 03 Aug 2021 16:57:22 -0700
>> >>=20
>> >> [ snip ]
>> >>=20
>> >> > XDP is going to always be eBPF based ! why not just report such sta=
ts
>> >> > to a special BPF_MAP ? BPF stack can collect the stats from the dri=
ver
>> >> > and report them to this special MAP upon user request.
>> >>=20
>> >> I really dig this idea now. How do you see it?
>> >> <ifindex:channel:stat_id> as a key and its value as a value or ...?
>> >
>> > Ideas, suggestions, anyone?
>>=20
>> I don't like the idea of putting statistics in a map instead of the
>> regular statistics counters. Sure, for bespoke things people want to put
>> into their XDP programs, use a map, but for regular packet/byte
>> counters, update the regular counters so XDP isn't "invisible".
>
> I wanted to provide an `ip link` command for getting these stats
> from maps and printing them in a usual format as well, but seems
> like that's an unneeded overcomplication of things since using
> maps for "regular"/"generic" XDP stats really has no reason except
> for "XDP means eBPF means maps".

Yeah, don't really see why it would have to: to me, one of the benefits
of XDP is being integrated closely with the kernel so we can have a
"fast path" *without* reinventing everything...

>> As Jesper pointed out, batching the updates so the global counters are
>> only updated once per NAPI cycle is the way to avoid a huge performance
>> overhead of this...
>
> That's how I do things currently, seems to work just fine.

Awesome!

-Toke

