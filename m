Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A54934D507
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhC2QZh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 12:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231651AbhC2QZQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 29 Mar 2021 12:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617035114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbFIhCPku9MFTnIxaRhUC4X/zn411dNU5tYynxv/ZoU=;
        b=WhPsoVfvisbWKt6bR7N3aRexjIRmYKgpMU2qfakrx/wEb1lyu5iiDYJE34NW514ePNuac2
        7s20j+1lKTgN8rAowzSrTRrdy45+FICU1zNR68LVP885MJgD5R+CvX+4NetSuTDoSIw+mA
        cNxjq3f8Li5AtTahqlCUZJbzplDcmMM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-OlIfmV7yOmuqSnehU2C6Ag-1; Mon, 29 Mar 2021 12:25:11 -0400
X-MC-Unique: OlIfmV7yOmuqSnehU2C6Ag-1
Received: by mail-ed1-f69.google.com with SMTP id i19so8889355edy.18
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 09:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mbFIhCPku9MFTnIxaRhUC4X/zn411dNU5tYynxv/ZoU=;
        b=ogcYgXMG1MgUUJtaAQgm/ECbPSgsYN5CcxItqkIgB956yPnHuR7i23BbfbXl/Sxruv
         nCm5S2QqCosSUQz7vBcAsqAYacXy2XrDJkou23b+J2poP4Oxc783qYs/hRFTETPONSHs
         jumpLZpuRnF9Pchnb2bmiBjH+t4X1L1+ntYkknWVQFMf945o+7Glkuj72MH5fXxRTFQ4
         UdFMu5J7gKkXhXdi0H4YCU6nvO3MlBMrIAWLO42ts8bk+/EJ6caYf4sfXEUH7/8PnOJs
         iMVjoN4ZTCs63b928WUOXJ1iOwoBrVstRashHd80TjZjYnq9LGa7bx3Hw2DigTihW58N
         htgA==
X-Gm-Message-State: AOAM530m/AD/ilLM2ZHrdhmoc/x3Dn6sKPt2O29JF0EH8T/00qdCQJx4
        jjQHpkiO3InKr4mIirb0z2w8VYIskl7rp3ALLvb/wDOWvAPbcVO8lr6/RZMkDM5zTCbxHRhLqze
        oRWHL1XDfBgw6
X-Received: by 2002:a50:ec96:: with SMTP id e22mr29345937edr.385.1617035110011;
        Mon, 29 Mar 2021 09:25:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywYRxi7n5QniEJaNO6UMg08JtWmwcuPYfyG7Lv1dtxhDjfWqUvGzbcye9KyF5FRMcPYikhkQ==
X-Received: by 2002:a50:ec96:: with SMTP id e22mr29345921edr.385.1617035109876;
        Mon, 29 Mar 2021 09:25:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cw14sm9522115edb.8.2021.03.29.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:25:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AC9F6181B24; Mon, 29 Mar 2021 18:25:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc:     brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/1] xdp: fix xdp_return_frame() kernel BUG throw
 for page_pool memory model
In-Reply-To: <20210329170209.6db77c3d@carbon>
References: <20210329080039.32753-1-boon.leong.ong@intel.com>
 <20210329170209.6db77c3d@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 29 Mar 2021 18:25:08 +0200
Message-ID: <87lfa6rkpn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Mon, 29 Mar 2021 16:00:39 +0800
> Ong Boon Leong <boon.leong.ong@intel.com> wrote:
>
>> xdp_return_frame() may be called outside of NAPI context to return
>> xdpf back to page_pool. xdp_return_frame() calls __xdp_return() with
>> napi_direct = false. For page_pool memory model, __xdp_return() calls
>> xdp_return_frame_no_direct() unconditionally and below false negative
>> kernel BUG throw happened under preempt-rt build:
>> 
>> [  430.450355] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/3884
>> [  430.451678] caller is __xdp_return+0x1ff/0x2e0
>> [  430.452111] CPU: 0 PID: 3884 Comm: modprobe Tainted: G     U      E     5.12.0-rc2+ #45
>> 
>> So, this patch fixes the issue by adding "if (napi_direct)" condition
>> to skip calling xdp_return_frame_no_direct() if napi_direct = false.
>> 
>> Fixes: 2539650fadbf ("xdp: Helpers for disabling napi_direct of xdp_return_frame")
>> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
>> ---
>
> This looks correct to me.
>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
>
>
>>  net/core/xdp.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>> index 05354976c1fc..4eaa28972af2 100644
>> --- a/net/core/xdp.c
>> +++ b/net/core/xdp.c
>> @@ -350,7 +350,8 @@ static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
>>  		/* mem->id is valid, checked in xdp_rxq_info_reg_mem_model() */
>>  		xa = rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
>>  		page = virt_to_head_page(data);
>> -		napi_direct &= !xdp_return_frame_no_direct();
>> +		if (napi_direct)
>> +			napi_direct &= !xdp_return_frame_no_direct();
>
> if (napi_direct && xdp_return_frame_no_direct())
> 	napi_direct = false;
>
> I wonder if this code would be easier to understand?

Yes, IMO it would! :)

-Toke

