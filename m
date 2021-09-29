Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EA41C3BC
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 13:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245070AbhI2Ltd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 07:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245179AbhI2Ltb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Sep 2021 07:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632916070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e0hiCZ6MaoVErEiOVWX40x+hKPGxbYz9tFHdifG89+s=;
        b=RV8nHISaJjmmKjnkoit2VDiGBNk4UP/TQGGmTz+cQOWgHo+kyo50gkmpKveumauXXvQMSt
        36JO/MmV3FvxrqrFaaNkq33swKsJcJQ9wAtPePsEAkb+LUDUz/I/5VkG7D4MBF9yHIbAex
        OFyiTnw+AmSqOvW4tPAPfCr6GS7uBkM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-ELgP6k34PpePqJLdk1zp2g-1; Wed, 29 Sep 2021 07:47:49 -0400
X-MC-Unique: ELgP6k34PpePqJLdk1zp2g-1
Received: by mail-ed1-f70.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so2129633edn.5
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 04:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=e0hiCZ6MaoVErEiOVWX40x+hKPGxbYz9tFHdifG89+s=;
        b=tUaGxFWwcJ79tfmLoXqji+JgdUk1wq7HIpD4XwJSZKWRtyWfd5ij6g22OY6A3kflx4
         gHD9G/zCTnb4bLwOGKEVOkFxMy9lPX1QrnL4diTmJUgLSoUKW86x3Vedk8g6OvCbst+X
         MkW+sAmxGVhoOMLMfLknOtZ+/+O5HTlENZopJEo+O9HFDyOB6MJa2W08Cqb3+RDNi3uk
         XSmJ2O/6N3e3hE3C/db/19EVYBM3Ui3wIoN3X/oejVxOAhcgC4pnehT8WZl6IK1/ovZ+
         RrZ8NjvecqQxvM6jM6tfOrbxdr0eddMY/fh42JTK8+2DPS54jmz0U+XW0godrVEME7IH
         WEpQ==
X-Gm-Message-State: AOAM532M2jdzeKHwzpJ/SzJwYL2ezh+C98qYuvx6P7ajRyxS93zbQyG+
        vE/5pPi5CImpMi2MDOYfru7cFDLDq7+gN4gmsDtzDjVN2Ee3fpbhb6EUj9f8vWmF+ZzOCUwpcC9
        jROeQdauubTDM
X-Received: by 2002:aa7:db13:: with SMTP id t19mr8255904eds.339.1632916067322;
        Wed, 29 Sep 2021 04:47:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyksUISkDtOs7VCvoVSP6Qe34qy0BStdrgy5t2ER1Ar/N/ffAzOJ2ryHd0gpvIeD/h7cTyIhQ==
X-Received: by 2002:aa7:db13:: with SMTP id t19mr8255876eds.339.1632916067060;
        Wed, 29 Sep 2021 04:47:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id lc2sm1261324ejb.21.2021.09.29.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 04:47:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 676A318034F; Wed, 29 Sep 2021 13:47:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Cong Wang <cong.wang@bytedance.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC Patch net-next v2] net_sched: introduce eBPF based Qdisc
In-Reply-To: <CAADnVQJSjbQC1wWAf_Js9h47iMge7O3L8zmYh7Mu8j4psMBf7g@mail.gmail.com>
References: <20210913231108.19762-1-xiyou.wangcong@gmail.com>
 <CAADnVQJFbCmzoFM8GGHyLWULSmX75=67Tu0EnTOOoVfH4gE+HA@mail.gmail.com>
 <CAM_iQpX2prCpPDmO1U0A_wyJi_LS4wmd9MQiFKiqQT8NfGNNnw@mail.gmail.com>
 <CAADnVQJJHLuaymMEdDowharvyJr+6ta2Tg9XAR3aM+4=ysu+bg@mail.gmail.com>
 <CAM_iQpUCtXRWhMqSaoymZ6OqOywb-k4R1_mLYsLCTm7ABJ5k_A@mail.gmail.com>
 <CAADnVQJcUspoBzk9Tt3Rx_OH7-MB+m1xw+vq2k2SozYZMmpurg@mail.gmail.com>
 <CAADnVQJSjbQC1wWAf_Js9h47iMge7O3L8zmYh7Mu8j4psMBf7g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 29 Sep 2021 13:47:45 +0200
Message-ID: <871r57k3ha.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Sep 22, 2021 at 6:49 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> At the same time Toke mentioned that he has a prototype of suck skb map.
>
> This is such an embarrassing typo :) Sorry Toke. s/suck/such/ in above.

Haha, managed to completely miss this; no worries, though, gave me a
good chuckle :)

-Toke

