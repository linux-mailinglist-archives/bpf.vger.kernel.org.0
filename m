Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946593B7330
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhF2NaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 09:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233990AbhF2NaQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 09:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624973269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nczz8X1siL1+c3qyqLl/TT5YtAYj63uoWHD9w3sl1A4=;
        b=gHCWD9gO2x+DbbS24WtEN2M/r0+WGfmZqhdDkqGibSOZFoEcIkezJ+p6yFLJB3c+3r5arh
        /hYc1m8BjhsUL4LI4MqBMaRhFn0mYJ/DyH9E411B0knEn9ohzdLyBao1iOuw1HOU8wLUh4
        i2UtmkWOlCR52+iY4n2qmEDlBPW6ChU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-vbpk6CgiMomQSBpEakwB2w-1; Tue, 29 Jun 2021 09:27:47 -0400
X-MC-Unique: vbpk6CgiMomQSBpEakwB2w-1
Received: by mail-ej1-f70.google.com with SMTP id w22-20020a17090652d6b029048a3391d9f6so5767683ejn.12
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 06:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nczz8X1siL1+c3qyqLl/TT5YtAYj63uoWHD9w3sl1A4=;
        b=Hq6blIV2vHzx68IJz6np23pFihh9XuMiFiMKTCJExVO4HDNdap3nEGmWzM6c9DwApg
         J0GfzCF79Beq8c3rzQ3DXS/OSUbE2bTAr3XU41IhQ8qZcTOydrcFkS88mKHAMP7caMnV
         2S955rwtVJdU6ENDZ1vdSbJnMLILVM4XKzfa1I9z31ZuYKllOUvb2o0g7eZGKN92K+Ap
         lMhilFfLOPi6Z4N0tGWDod7rH4c6+Sq+gM+CGMjYcBiyprSSqTUDSv8uW37YN//PyJZO
         7X8LouH4vy+c4Snqa1Nhc7yAjlHNTVsuLIdKNZBZHNZy0YPC3lo/3IAECl3gocqWfADT
         jXRg==
X-Gm-Message-State: AOAM53084bFrpSQO7S5ffCLibaTWEzC1ggFCkRxTHNhlwS/oFDygzc78
        pz39GwN/OdIhgOQm3InxhNVr3It2QxoC4rnOoo1ogBNJmE9euTBKszvxKgnBzr9obM8/k3jP5/K
        hRral4BljGs05
X-Received: by 2002:a17:906:240d:: with SMTP id z13mr29753197eja.118.1624973266105;
        Tue, 29 Jun 2021 06:27:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjgNv7lDlTUXuqwp06iQd8jCAaBQ53E/TTKV/u/DQbic9dlDsQgxUyc/2KLrYkDww66bPigQ==
X-Received: by 2002:a17:906:240d:: with SMTP id z13mr29753137eja.118.1624973265503;
        Tue, 29 Jun 2021 06:27:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id hx18sm8269915ejc.82.2021.06.29.06.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:27:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4860E18071E; Tue, 29 Jun 2021 15:27:43 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Eelco Chaudron <echaudro@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        sameehj@amazon.com, dsahern@kernel.org, brouer@redhat.com,
        jasowang@redhat.com, alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v9 bpf-next 08/14] bpf: add multi-buff support to the
 bpf_xdp_adjust_tail() API
In-Reply-To: <YNsdyD6OBXcf5mUa@lore-desk>
References: <cover.1623674025.git.lorenzo@kernel.org>
 <863f4934d251f44ad85a6be08b3737fac74f9b5a.1623674025.git.lorenzo@kernel.org>
 <60d2744ee12c2_1342e208f7@john-XPS-13-9370.notmuch>
 <4F52EE5B-1A3F-46CE-9A39-98475CA6B684@redhat.com>
 <60d495a914773_2e84a2082d@john-XPS-13-9370.notmuch>
 <YNsdyD6OBXcf5mUa@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 29 Jun 2021 15:27:43 +0200
Message-ID: <874kdgkdgw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> Eelco Chaudron wrote:
>> > 
>> > 
>> > On 23 Jun 2021, at 1:37, John Fastabend wrote:
>> > 
>> > > Lorenzo Bianconi wrote:
>> > >> From: Eelco Chaudron <echaudro@redhat.com>
>> > >>
>> > >> This change adds support for tail growing and shrinking for XDP multi-buff.
>> > >>
>> > >
>> > > It would be nice if the commit message gave us some details on how the
>> > > growing/shrinking works in the multi-buff support.
> [...]
>> > Guess this is the tricky part, applications need to be multi-buffer aware. If current applications rely on bpf_xdp_adjust_tail(+) to determine maximum frame length this approach might not work. In this case, we might need an additional helper to do tail expansion with multi buffer support.
>> > 
>> > But then the question arrives how would mb unaware application behave in general when an mb packet is supplied?? It would definitely not determine the correct packet length.
>> 
>> Right that was my conclusion as well. Existing programs might
>> have subtle side effects if they start running on multibuffer
>> drivers as is. I don't have any good ideas though on how
>> to handle this.
>
> what about checking the program capabilities at load time (e.g. with a
> special program type) and disable mb feature if the bpf program is not
> mb-aware? (e.g. forbid to set the MTU greater than 1500B in xdp mode).

So what happens when that legacy program runs on a veth and gets an
mb-enabled frame redirected into it? :)

-Toke

