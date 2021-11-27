Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E4045FDC4
	for <lists+bpf@lfdr.de>; Sat, 27 Nov 2021 10:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353820AbhK0JyB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Nov 2021 04:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353395AbhK0JwA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 27 Nov 2021 04:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638006526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEZRRUY2qRLp/XgfnlzFFKKaoBe6Fu+wpZ3mu0VcdO0=;
        b=ULdJzNcjRU/lF5O/GKJtseqxdCzJcUIw5QE3xJ63kCX3c/ZlRwjHH3IlK7vp9nZ18rFl4r
        Jq/te96lr/1oS6tAr8empdKv9SC0DCKAz3KrKwctAaGRmMHYlKTJn3FJvHkNN3+N+lkfn6
        uRlNv9teezIQ0pv8nww1twrKwwftdYs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-WsyIpYWePgC_ICnbyl3atg-1; Sat, 27 Nov 2021 04:48:44 -0500
X-MC-Unique: WsyIpYWePgC_ICnbyl3atg-1
Received: by mail-wm1-f72.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so6776858wmb.4
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 01:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=WEZRRUY2qRLp/XgfnlzFFKKaoBe6Fu+wpZ3mu0VcdO0=;
        b=g8+6D+Ck2uLUn2IduaZccot/iypHYFlmuk/iCCICdVbp0/2v/zQJu60TbZ21cFs9kB
         VyTrbQJ2kZPhfYeg646Ma5y5XtPazPhXIlE6qunPOTLadM4x4S8WOJu0O3R/DoRDKrlQ
         lY5rugb/HVt4QYyPwzpU6FP4a4+/sKv0zCKNEud43cLvGyIo0MqjBIQ8v3ibtmv7kjkO
         aX0OM1+97uJReSl04+Fp97MUDo+JUiuo/dDBPjCBLGiCsFcTufUBbsh6Wp6tsGKMaxbG
         we5vUJCYjYlvkawUk89vVWNmLkZmVinttX7fKuvZGl7klbgtszpuYw4mtYyCQVLD5HgB
         bX6g==
X-Gm-Message-State: AOAM530UudhnkR9xlCz248xPFJujL+n7OJWg/1JRSERUEznWBR/Csu0g
        mKd36MgtfzJGYeFzbFi8B9FplFS4KUGaXUJTl9efwwA2PazFsj7nbv9Q/0BX4SkG8QUuZr92yYR
        kaFD0HGFn/SYO
X-Received: by 2002:a5d:5850:: with SMTP id i16mr20042141wrf.197.1638006523290;
        Sat, 27 Nov 2021 01:48:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXonZj16qxeAKe76v20uI9A1K9dFCqJ343M9mMgnBwQ15AtrmtjI+ouGtCUdCKm/ZOAG7ncA==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr20042118wrf.197.1638006523117;
        Sat, 27 Nov 2021 01:48:43 -0800 (PST)
Received: from [192.168.2.13] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id o4sm10163918wry.80.2021.11.27.01.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 01:48:42 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <80cf7ceb-b28a-0f8d-14f8-4b31eb06d6b2@redhat.com>
Date:   Sat, 27 Nov 2021 10:48:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, bjorn@kernel.org,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf-next 4/4] samples/bpf: xdpsock: add time-out for
 cleaning Tx
Content-Language: en-US
To:     Ong Boon Leong <boon.leong.ong@intel.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <20211124091821.3916046-1-boon.leong.ong@intel.com>
 <20211124091821.3916046-5-boon.leong.ong@intel.com>
In-Reply-To: <20211124091821.3916046-5-boon.leong.ong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 24/11/2021 10.18, Ong Boon Leong wrote:
> When user sets tx-pkt-count and in case where there are invalid Tx frame,
> the complete_tx_only_all() process polls indefinitely. So, this patch
> adds a time-out mechanism into the process so that the application
> can terminate automatically after it retries 3*polling interval duration.
> 
>   sock0@enp0s29f1:2 txonly xdp-drv
>                     pps            pkts           1.00
> rx                 0              0
> tx                 136383         1000000
> rx dropped         0              0
> rx invalid         0              0
> tx invalid         35             245
> rx queue full      0              0
> fill ring empty    0              1
> tx ring empty      957            7011
> 
>   sock0@enp0s29f1:2 txonly xdp-drv
>                     pps            pkts           1.00
> rx                 0              0
> tx                 0              1000000
> rx dropped         0              0
> rx invalid         0              0
> tx invalid         0              245
> rx queue full      0              0
> fill ring empty    0              1
> tx ring empty      1              7012
> 
>   sock0@enp0s29f1:2 txonly xdp-drv
>                     pps            pkts           1.00
> rx                 0              0
> tx                 0              1000000
> rx dropped         0              0
> rx invalid         0              0
> tx invalid         0              245
> rx queue full      0              0
> fill ring empty    0              1
> tx ring empty      1              7013
> 
>   sock0@enp0s29f1:2 txonly xdp-drv
>                     pps            pkts           1.00
> rx                 0              0
> tx                 0              1000000
> rx dropped         0              0
> rx invalid         0              0
> tx invalid         0              245
> rx queue full      0              0
> fill ring empty    0              1
> tx ring empty      1              7014
> 
>   sock0@enp0s29f1:2 txonly xdp-drv
>                     pps            pkts           1.00
> rx                 0              0
> tx                 0              1000000
> rx dropped         0              0
> rx invalid         0              0
> tx invalid         0              245
> rx queue full      0              0
> fill ring empty    0              1
> tx ring empty      0              7014
> 
>   sock0@enp0s29f1:2 txonly xdp-drv
>                     pps            pkts           0.00
> rx                 0              0
> tx                 0              1000000
> rx dropped         0              0
> rx invalid         0              0
> tx invalid         0              245
> rx queue full      0              0
> fill ring empty    0              1
> tx ring empty      0              7014
> 
> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> ---
>   samples/bpf/xdpsock_user.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
> index 61d4063f11a..9c3311329ec 100644
> --- a/samples/bpf/xdpsock_user.c
> +++ b/samples/bpf/xdpsock_user.c
> @@ -1410,6 +1410,7 @@ static inline int get_batch_size(int pkt_cnt)
>   
>   static void complete_tx_only_all(void)
>   {
> +	u32 retries = 3;
>   	bool pending;
>   	int i;
>   
> @@ -1421,7 +1422,8 @@ static void complete_tx_only_all(void)
>   				pending = !!xsks[i]->outstanding_tx;
>   			}
>   		}
> -	} while (pending);
> +		sleep(opt_interval);

Why/how is this connected with the 'opt_interval' ?

(Which is used by the pthtread 'poller' dumping stats)

> +	} while (pending && retries-- > 0);
>   }
>   
>   static void tx_only_all(void)
> 

