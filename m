Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5646A1A6
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 17:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhLFQsW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 11:48:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231340AbhLFQsV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 6 Dec 2021 11:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638809092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lgY0HVFZeOXKmCy6byafdaHTQFAJuWUaBogLAJPCPQ=;
        b=CVacVWx1urLT3Nip2ETtmhLC6Dxf3i0te8vZNp2sCraKBfbDcClK5XOp4Q281fjzKCxLwe
        FOfvq7oEyPruBG+0zoMmmMAUycDFBsF5T7sillGcRxwxldi0VLkFSFkje2t9o+I4/vdGsw
        8yJiuUWqAxcRUH/hY3v0bfCf2/Jge1s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-k2XTdmvKPAe8WfaYblitJA-1; Mon, 06 Dec 2021 11:44:51 -0500
X-MC-Unique: k2XTdmvKPAe8WfaYblitJA-1
Received: by mail-ed1-f71.google.com with SMTP id v22-20020a50a456000000b003e7cbfe3dfeso8838885edb.11
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 08:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=0lgY0HVFZeOXKmCy6byafdaHTQFAJuWUaBogLAJPCPQ=;
        b=xLsJsFO6NWPtWDjxQcUbD9xbYGxLcJDNGczcOwv2O+CSkY4Y17Q2l+WYymdHb972KC
         /wMx3wWCQC5pZQ0mbJcem5ST/M91ELHYnHcz8K2nrKS1v5WibxX0RaIJFaPuDe+hiHZu
         N2aSo/cd+hKv0doQyS/TBeW2+Qxoyl6ka9uPcQYfWEmHn2uAsPcZI3hmxksNWqLEWUXl
         95sr9QH/2DrlflUadb40oIi99D6s1YeyXt3kLkXwyYQlYkytrMu5lGzPQehfjMuJHHOa
         EGMD5liNXJGW6ekMzePs3ssXIRoxW+CTj0BcGGloPw8qMUBRyjbXgYbH2m7l+J0Tu1Jr
         PY+w==
X-Gm-Message-State: AOAM5336rx/evaU8owU88aRlCrJ1aUP5AwMC2R8Mj0fICp9sn6nz+YYm
        8V6NNLy99AAAlTKZKntQdX54KW4hFU6eNByNZL2m3t4DCflaAO+c18mmjqBHomqeCW2U/zVNp+9
        ZBpqVV/iU5cKV
X-Received: by 2002:a17:907:7da0:: with SMTP id oz32mr45896859ejc.176.1638809090281;
        Mon, 06 Dec 2021 08:44:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyw7d9z2kId4Cz9cF1J22OiD9Y+cMhaFzCclOQCnPX81VauO2rCY/xrJ6GffWV09i5l93Rpww==
X-Received: by 2002:a17:907:7da0:: with SMTP id oz32mr45896819ejc.176.1638809090061;
        Mon, 06 Dec 2021 08:44:50 -0800 (PST)
Received: from [192.168.2.13] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id qz24sm6912817ejc.29.2021.12.06.08.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 08:44:49 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <58a75230-917d-709d-074a-7553f8e76307@redhat.com>
Date:   Mon, 6 Dec 2021 17:44:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, Emmanuel Deloget <emmanuel.deloget@eho.link>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH RESEND 1/1] net: mvpp2: fix XDP rx queues registering
Content-Language: en-US
To:     Louis Amas <louis.amas@eho.link>, Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Matteo Croce <mcroce@microsoft.com>
References: <20211206162051.565724-1-louis.amas@eho.link>
In-Reply-To: <20211206162051.565724-1-louis.amas@eho.link>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 06/12/2021 17.20, Louis Amas wrote:
> The registration of XDP queue information is incorrect because the
> RX queue id we use is invalid. When port->id == 0 it appears to works
> as expected yet it's no longer the case when port->id != 0.
> 
> When we register the XDP rx queue information (using
> xdp_rxq_info_reg() in function mvpp2_rxq_init()) we tell them to use
> rxq->id as the queue id. This value iscomputed as:
> rxq->id = port->id * max_rxq_count + queue_id
> 
> where max_rxq_count depends on the device version. In the MB case,
> this value is 32, meaning that rx queues on eth2 are numbered from
> 32 to 35 - there are four of them.
> 
> Clearly, this is not the per-port queue id that XDP is expecting:
> it wants a value in the range [0..3]. It shall directly use queue_id
> which is stored in rxq->logic_rxq -- so let's use that value instead.
> 
> This is consistent with the remaining part of the code in
> mvpp2_rxq_init().
> 
> Fixes: b27db2274ba8 ("mvpp2: use page_pool allocator")
> Signed-off-by: Louis Amas <louis.amas@eho.link>
> Signed-off-by: Emmanuel Deloget <emmanuel.deloget@eho.link>
> Reviewed-by: Marcin Wojtas <mw@semihalf.com>

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

Instead of "RESEND" please add a version number, so we can keep track 
which is the latest patch, IMHO this should have "V3".
You also forgot to mention in subj what git-tree this is targeted 
towards. See netdev-FAQ[0]

Track your patch progress here:
  https://patchwork.kernel.org/project/netdevbpf/list/?series=590985

In what I consider "V2" you also got an ACK from John:

Acked-by: John Fastabend <john.fastabend@gmail.com>


> ---
>   drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 6480696c979b..6da8a595026b 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -2960,11 +2960,11 @@ static int mvpp2_rxq_init(struct mvpp2_port *port,
>          mvpp2_rxq_status_update(port, rxq->id, 0, rxq->size);
> 
>          if (priv->percpu_pools) {
> -               err = xdp_rxq_info_reg(&rxq->xdp_rxq_short, port->dev, rxq->id, 0);
> +               err = xdp_rxq_info_reg(&rxq->xdp_rxq_short, port->dev, rxq->logic_rxq, 0);
>                  if (err < 0)
>                          goto err_free_dma;
> 
> -               err = xdp_rxq_info_reg(&rxq->xdp_rxq_long, port->dev, rxq->id, 0);
> +               err = xdp_rxq_info_reg(&rxq->xdp_rxq_long, port->dev, rxq->logic_rxq, 0);
>                  if (err < 0)
>                          goto err_unregister_rxq_short;

[0] https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html

