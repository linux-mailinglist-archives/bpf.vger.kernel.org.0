Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B7D447F00
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 12:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhKHLkp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 06:40:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235453AbhKHLko (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 06:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636371479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zlpIDeohuxGJKr6/NQGxf0qdewWP/HeI2X9Zoct4WLo=;
        b=L9mv7Wzvbe42e1CbAnv05oCbj8xcueiPsoDNZRRpzHHeNz90zepp44MFDAB5Ig2c3VuFh2
        V2iePOr5/bQ6OyJrUh0fzeYi+Etn+LUBaymtZQoSoCcSWpeEqNfppdpXhuPnSceCrC7PJw
        FQX5XIZh1khAGao2jfLbVc3uYq60Ma8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-bIYJjf7-NJa6LCuy_AkcRQ-1; Mon, 08 Nov 2021 06:37:58 -0500
X-MC-Unique: bIYJjf7-NJa6LCuy_AkcRQ-1
Received: by mail-ed1-f70.google.com with SMTP id i9-20020a508709000000b003dd4b55a3caso14640125edb.19
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 03:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zlpIDeohuxGJKr6/NQGxf0qdewWP/HeI2X9Zoct4WLo=;
        b=g5HWjWI1pWji+E+zHT4btOsF/lTYrAQPJBIGmnGX6gXAgR2M+BLMOUHtVDf7LRYJUO
         4cbion4shO6vYpiFW2HxGlV8g9E7Tw4co5Chw1P/hBn+ukuB3n2zw3C90zJYdHEY9Qux
         Raw11mGGiPpHLr08vr5NcMbCm8cZbPKg4VBfmtBB3hTeTtAp4N7DoAmdUL11RFGc8HXn
         L0oCuy7rXGXqP4K+7An2ApfX/r5NT2A9O+txqyhsjgknHgUdhgGwDcXVi++Tgg1O9rMT
         GzK2AlviOGpHRyI7XQOIW+m+I7r3jpWfjika7xzkXBoJ/ci6WFeCCwVu5GeoNHV4QHKx
         3idw==
X-Gm-Message-State: AOAM530RW+0cpKKPUkN4TdK/jBl1MLZ26tFZT+kOSJ9udUSk3WkWgLz6
        xgDDeM/5tVR5PaAeq6wwsYLw8zIyoTE79UZR+7yLviFRh66qyymf7nByM7iKRFDl62NjvAeCvg9
        9T9RkkjLHAiMz
X-Received: by 2002:a50:ff07:: with SMTP id a7mr107385524edu.338.1636371476592;
        Mon, 08 Nov 2021 03:37:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6xBGQaHNOpSc3bDudxgiZ97suxKqVelKGBfKaraRJUbGpQNsgGOmD1+OdU/l8xcmlE13Mfg==
X-Received: by 2002:a50:ff07:: with SMTP id a7mr107385478edu.338.1636371476247;
        Mon, 08 Nov 2021 03:37:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id sb8sm6393735ejc.51.2021.11.08.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 03:37:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2E6B718026D; Mon,  8 Nov 2021 12:37:54 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Saeed Mahameed <saeed@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
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
In-Reply-To: <20211105164453.29102-1-alexandr.lobakin@intel.com>
References: <20210803163641.3743-1-alexandr.lobakin@intel.com>
 <20210803163641.3743-4-alexandr.lobakin@intel.com>
 <20210803134900.578b4c37@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <ec0aefbc987575d1979f9102d331bd3e8f809824.camel@kernel.org>
 <20211026092323.165-1-alexandr.lobakin@intel.com>
 <20211105164453.29102-1-alexandr.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Nov 2021 12:37:54 +0100
Message-ID: <87v912ri7h.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexander Lobakin <alexandr.lobakin@intel.com> writes:

> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Tue, 26 Oct 2021 11:23:23 +0200
>
>> From: Saeed Mahameed <saeed@kernel.org>
>> Date: Tue, 03 Aug 2021 16:57:22 -0700
>> 
>> [ snip ]
>> 
>> > XDP is going to always be eBPF based ! why not just report such stats
>> > to a special BPF_MAP ? BPF stack can collect the stats from the driver
>> > and report them to this special MAP upon user request.
>> 
>> I really dig this idea now. How do you see it?
>> <ifindex:channel:stat_id> as a key and its value as a value or ...?
>
> Ideas, suggestions, anyone?

I don't like the idea of putting statistics in a map instead of the
regular statistics counters. Sure, for bespoke things people want to put
into their XDP programs, use a map, but for regular packet/byte
counters, update the regular counters so XDP isn't "invisible".

As Jesper pointed out, batching the updates so the global counters are
only updated once per NAPI cycle is the way to avoid a huge performance
overhead of this...

-Toke

