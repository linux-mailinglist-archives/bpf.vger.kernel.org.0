Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF3D41947F
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 14:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhI0Mpk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 08:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234331AbhI0Mpj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Sep 2021 08:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632746641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCEkzTLMibk3xPIz3Pcj0fZ0+zGBST1JsRpoKv0nibs=;
        b=UzeozqdNPIzm1kXFMngeJJEs7nM3tWwdy0xnE9AmmSjmhk7DBxo5T3wj9FQuorKL0YtKK7
        wz+4wJPn7hymkffoj3+Qo8ik7klRgLMzu1HyI5uTM5lzp0bjKox9c4dWE7JlFLcpWoUoRR
        cF+/gaPJ/MNXMuwhpVq/OwMK+W6yki4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-ev1H1H8vP66OwPSxYa6UXA-1; Mon, 27 Sep 2021 08:44:00 -0400
X-MC-Unique: ev1H1H8vP66OwPSxYa6UXA-1
Received: by mail-lf1-f70.google.com with SMTP id r193-20020a19c1ca000000b003fc8f43caa6so15720692lff.17
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 05:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xCEkzTLMibk3xPIz3Pcj0fZ0+zGBST1JsRpoKv0nibs=;
        b=ijjbbW+W0NIcHMVU5mDi6BJYRBdiqpRnGKs7j4Bghzbjc9a3g/JX3iD/71w/Ttxh/5
         CE87/3yLVLymFHIbiZPNbU08NSYNrA/VqxWPco8ckYrUTab42HmOrUoGnPC1vUcgyzbM
         /hM0bcTXqO8ebi7xgNlQBY7yxaHl26riZxpngEsworjQgIxMjV28AVDWkcSiQ8663dcM
         AK6hFhRHSUJ2KVmhWMBEr+PHrB6Vt8OTMU6VVpjBPLIdxmJD7i1GO6/edjYCMsz31NWY
         NenKY9HRoEIIrct0ANMGCVhSlqtpdvhcYalPTl7iP+FB+EDtYXCWV/kb6UFhAbQfwIzd
         nAoQ==
X-Gm-Message-State: AOAM530E1BPfMksEfFIWMX4L7kWk9nJa/lWSPeKsS8sdrsE0skznCYrU
        j/G/9Yj2FwRFhNN5/XZpbq7ODrGqv4dGq4LKiLx4wGmE5xXF3FR4swe3mpDxweC1bQPrC1fxj9E
        qfjLuMx+sgqN/2jXG5+j4tGhsvrcGEMwMUVKDOfZ1xGvAv8A4c1BmHJHtFNHIFFQ=
X-Received: by 2002:a05:651c:150b:: with SMTP id e11mr29426739ljf.289.1632746638559;
        Mon, 27 Sep 2021 05:43:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvC/qpgu6RCW8/2TmGNJ1qj7w8OhMytXfe7vwWXFkcdU80AADG+PBuDJ1VeSLz4SjDTKMyAQ==
X-Received: by 2002:a05:651c:150b:: with SMTP id e11mr29426708ljf.289.1632746638285;
        Mon, 27 Sep 2021 05:43:58 -0700 (PDT)
Received: from [192.168.42.238] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id j1sm1592734lfr.248.2021.09.27.05.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 05:43:57 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Zvi Effron <zeffron@riotgames.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Lorenzo Bianconi <lbianconi@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Redux: Backwards compatibility for XDP multi-buff
To:     Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?= =?UTF-8?Q?sen?= 
        <toke@redhat.com>
References: <87o88l3oc4.fsf@toke.dk>
 <CAC1LvL1xgFMjjE+3wHH79_9rumwjNqDAS2Yg2NpSvmewHsYScA@mail.gmail.com>
 <87ilyt3i0y.fsf@toke.dk>
 <CAADnVQKi_u6yZnsxEagNTv-XWXtLPpXwURJH0FnGFRgt6weiww@mail.gmail.com>
 <87czp13718.fsf@toke.dk>
 <20210921155118.439c0aa9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87mto41isy.fsf@toke.dk>
 <20210923064634.636ef48a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <7e47e065-f9b2-4b98-923d-94f5a9484a83@redhat.com>
Date:   Mon, 27 Sep 2021 14:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210923064634.636ef48a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 23/09/2021 15.46, Jakub Kicinski wrote:
> Let me make a general statement that we can't build large systems
> without division of responsibilities. Device specific logic has to
> be left to the driver. It's up to veth to apply its extra rules.
> 
> As Zvi said, tho, this can be left for later. IMHO initial patches can
> drop all mb frames on redirect in the core, so we can make progress.

I agree that for *initial* patchset for REDIRECT (func calling 
ndo_xdp_xmit) it can drop MB frames on redirect in the core, when the 
drivers ndo_xdp_xmit doesn't support this.
BUT only so we can make progress.

As soon as possible (preferably in same kernel release) a follow-up 
patchset should make a serious attempt at updating all drivers 
ndo_xdp_xmit to support multi-buffer (MB).

As MB use the same/compatible layout as skb_shared_info, it should be a 
fairly small effort to update drivers, for *transmitting* multi-buff. As 
drivers already support this for normal SKBs.

It will be a larger effort to support XDP multi-buff on RX, as often the 
RX-loop need to be adjusted/reordered to "delay" calling XDP-prog until 
all fragments have been "collected".  And MTU check adjusted.

This imply that the driver net_device xdp_features need two feature bits 
for this MB feature.
IMHO it makes sense to detangle RX and TX, as IMHO we should allow MB 
frames to be TX redirect out a driver that have an old non-MB aware 
XDP-prog loaded.

--Jesper

