Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61F63EFFA5
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhHRIzf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 04:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhHRIzf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Aug 2021 04:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629276900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Mh3RCcwqzsgQx5n6mOYP8qaEc3/zNsLw1ibiOhXN+A=;
        b=c/sz25/sMJT2QiiL+vrz61rKiG6OH5jL3+PBmhyI3DWF26BqzZwm/+SI6Hinb/SkiKHj2r
        sI/5e2r2AMQIOanwaU4rvyROOmsJ2A+UHKuYq89v4tcwfDWe7mTziJZyRLygK7uEt26d4v
        k6BnGikOIv4IZv8bJWjTUk8hy3Tjf1I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-tN5dnt7bPcCrblfzD-ZPOg-1; Wed, 18 Aug 2021 04:54:59 -0400
X-MC-Unique: tN5dnt7bPcCrblfzD-ZPOg-1
Received: by mail-wr1-f72.google.com with SMTP id q4-20020a05600000c400b00156d811312aso362625wrx.3
        for <bpf@vger.kernel.org>; Wed, 18 Aug 2021 01:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Mh3RCcwqzsgQx5n6mOYP8qaEc3/zNsLw1ibiOhXN+A=;
        b=iqXXsnm0/IydXgEwRP1BLRMLHuY8dlTS7C+3+92VJ4hcecXnIpDnjgrwk4HLGb++uP
         cyTF1WNXJ/c57VVrf9hIR4NCOcSMof5fSgcKa1UTrYTBK9O8lH9W8Vozsk6Kf9VUUlfN
         yH0mF8iE/g2RKsNYXj/8poIYhAFJwY4rLDvhe9R1GkwOtAlKYP85/Ddp2UVUgO0gmUbO
         py1OftcqYalxFkHxOlSGZuA9/SXNTWVtSl1r7VBcF8LegMQPIqtFqTr2zHj6vnB2ZGee
         0Vr9FkR1rIyyTj7oJHNxR/xB7YjeShFjd3MUsZ35E05sPj3vnxgbWBDYupd2pmv63N+B
         L9Pg==
X-Gm-Message-State: AOAM533ovz0tcSEGvai0XdG7AlHLEDUjeiiK5so9SxlVWuKHnLz97ri0
        C/BG0UQ7GS7D7HW9y03EWOdfrtumUVkDwcMSmv0Fcg0979aprDMtsMPkzsFWiZP0U5S8Cri+pKp
        bP4X0D6EF4SPF
X-Received: by 2002:a5d:5409:: with SMTP id g9mr9536484wrv.409.1629276897783;
        Wed, 18 Aug 2021 01:54:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMZ8FqWVCmSPbAA7DTxHBjBs1Scwu/cPC2p1bEVif94hlv7Lhz4JAhFK/A451DPgJFIOChHQ==
X-Received: by 2002:a5d:5409:: with SMTP id g9mr9536464wrv.409.1629276897616;
        Wed, 18 Aug 2021 01:54:57 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id d4sm5240621wrz.35.2021.08.18.01.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:54:57 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, Jithu Joseph <jithu.joseph@intel.com>
Subject: Re: [RFC bpf-next 5/5] samples/bpf/xdpsock_user.c: Launchtime/TXTIME
 API usage
To:     Kishen Maloor <kishen.maloor@intel.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, hawk@kernel.org, magnus.karlsson@intel.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20210803171006.13915-1-kishen.maloor@intel.com>
 <20210803171006.13915-6-kishen.maloor@intel.com>
Message-ID: <4ea898db-563c-851b-c3da-9389abcb83ac@redhat.com>
Date:   Wed, 18 Aug 2021 10:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803171006.13915-6-kishen.maloor@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 03/08/2021 19.10, Kishen Maloor wrote:
> diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
> index 3fd2f6a0d1eb..a0fd3d5414ba 100644
> --- a/samples/bpf/xdpsock_user.c
> +++ b/samples/bpf/xdpsock_user.c
[...]
> @@ -741,6 +745,8 @@ static inline u16 udp_csum(u32 saddr, u32 daddr, u32 len,
>   
>   #define ETH_FCS_SIZE 4
>   
> +#define MD_SIZE (sizeof(struct xdp_user_tx_metadata))
> +
>   #define PKT_HDR_SIZE (sizeof(struct ethhdr) + sizeof(struct iphdr) + \
>   		      sizeof(struct udphdr))
>   
> @@ -798,8 +804,10 @@ static void gen_eth_hdr_data(void)
>   
>   static void gen_eth_frame(struct xsk_umem_info *umem, u64 addr)
>   {
> -	memcpy(xsk_umem__get_data(umem->buffer, addr), pkt_data,
> -	       PKT_SIZE);
> +	if (opt_launch_time)
> +		memcpy(xsk_umem__get_data(umem->buffer, addr) + MD_SIZE, pkt_data, PKT_SIZE);
> +	else
> +		memcpy(xsk_umem__get_data(umem->buffer, addr), pkt_data, PKT_SIZE);
>   }
>   

I imagined that AF_XDP 'addr' would still point to the start of the 
packet data, and that metadata area was access via a negative offset 
from 'addr'.

Maybe I misunderstood the code, but it looks like 'addr' 
(xsk_umem__get_data(umem->buffer, addr)) points to metadata area, is 
this correct?

(and to skip this the code does + MD_SIZE, before memcpy)

One problem/challenge with AF_XDP is that we don't have room in struct 
xdp_desc to store info on the size of the metadata area.  Bjørn came up 
with the idea of having btf_id as last member (access able via minus 4 
bytes), as this tells the kernel the size of metadata area.

Maybe you have come up with a better solution?
(of making the metadata area size dynamic)

--Jesper

