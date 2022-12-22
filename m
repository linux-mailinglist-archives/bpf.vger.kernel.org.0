Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717EC653E25
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 11:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiLVKTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 05:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiLVKTC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 05:19:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853AE64EB
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 02:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671704294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMIFNmVQLCxCjhW58FEDJV3uok6JlAmjxmbnkUxO/jM=;
        b=bar9y7mvr3AcTcaaw6daPY36QH89VODr36bOt6zuX+IV0daXvCqjnZ+cyU00DqhskdsY0A
        0buCCZ1LtjDsZb/eJUQEYeTxoqH1Zg73XvAg/2npu1/MwHaTsC9VGwIBUf7+jpwf34IcKt
        S+mH7M1GnTCjqFXA8Ms6HZS1QRfNpwo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-e3gTGx30Oa2pU5h-BI0CKw-1; Thu, 22 Dec 2022 05:18:08 -0500
X-MC-Unique: e3gTGx30Oa2pU5h-BI0CKw-1
Received: by mail-qv1-f71.google.com with SMTP id a15-20020ad441cf000000b004c79ef7689aso742180qvq.14
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 02:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMIFNmVQLCxCjhW58FEDJV3uok6JlAmjxmbnkUxO/jM=;
        b=N1kO7uDhCMCzah0N7gPqAxB/78rkC28a20TE95uUUKlzp5pF8xm43CDWmFF11IKnlM
         y10B8w35ERPnC5JCAUDk4QGJ+t4tBaeLCv9JgiXdkCXG0/jl6rYwxP+gmiBJl2DxFmls
         ydTJ4fjHOJO8WTZsPTkWB82cVUpnedCWZ/Ig9XYYL7fhFx8MGuH0q1oaRN90dM1ijmAL
         3jXCkTSU2UqUxdcOkRDrcAhTNsmirAQLdDi9j2IFFCsKmfeeeDz/oOvjonbu3aYzGPvs
         NYoPwfHAhqKJstT/jlXpeDSnH54S8YhkqS/A1FN/FFqQnHF4wCvWje2zrlr+5vok0y/m
         9kQw==
X-Gm-Message-State: AFqh2kpneE/N8ZXlLZfb3FRjYHAFLn7E1csLVS19yf6spFfwDTLi4Hia
        c9mY+lGj7WQyBFK21ZAHFmDttvf/88rXwXbt1IbMQIseC3gkrx66BT733+20tHIHpVpECkCmCnv
        jjCGZfDuOu6yj
X-Received: by 2002:a0c:ab59:0:b0:4c6:ea60:60ab with SMTP id i25-20020a0cab59000000b004c6ea6060abmr6144291qvb.32.1671704287580;
        Thu, 22 Dec 2022 02:18:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvP73sELA7lGy5qSWc9pG4Uc/DcYHvUQtpfX94+wrIqPYvFAVxQPF6cawKhioN0l3g200KhAw==
X-Received: by 2002:a0c:ab59:0:b0:4c6:ea60:60ab with SMTP id i25-20020a0cab59000000b004c6ea6060abmr6144273qvb.32.1671704287289;
        Thu, 22 Dec 2022 02:18:07 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id q29-20020a37f71d000000b006fb9bbb071fsm52742qkj.29.2022.12.22.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 02:18:06 -0800 (PST)
Message-ID: <e6b0414dbc7e97857fee5936ed04efca81b1d472.camel@redhat.com>
Subject: Re: [PATCH] veth: Fix race with AF_XDP exposing old or
 uninitialized descriptors
From:   Paolo Abeni <pabeni@redhat.com>
To:     Shawn Bohrer <sbohrer@cloudflare.com>, magnus.karlsson@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, bjorn@kernel.org,
        kernel-team@cloudflare.com, davem@davemloft.net
Date:   Thu, 22 Dec 2022 11:18:03 +0100
In-Reply-To: <20221220185903.1105011-1-sbohrer@cloudflare.com>
References: <Y5pO+XL54ZlzZ7Qe@sbohrer-cf-dell>
         <20221220185903.1105011-1-sbohrer@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-12-20 at 12:59 -0600, Shawn Bohrer wrote:
> When AF_XDP is used on on a veth interface the RX ring is updated in two
> steps.  veth_xdp_rcv() removes packet descriptors from the FILL ring
> fills them and places them in the RX ring updating the cached_prod
> pointer.  Later xdp_do_flush() syncs the RX ring prod pointer with the
> cached_prod pointer allowing user-space to see the recently filled in
> descriptors.  The rings are intended to be SPSC, however the existing
> order in veth_poll allows the xdp_do_flush() to run concurrently with
> another CPU creating a race condition that allows user-space to see old
> or uninitialized descriptors in the RX ring.  This bug has been observed
> in production systems.
> 
> To summarize, we are expecting this ordering:
> 
> CPU 0 __xsk_rcv_zc()
> CPU 0 __xsk_map_flush()
> CPU 2 __xsk_rcv_zc()
> CPU 2 __xsk_map_flush()
> 
> But we are seeing this order:
> 
> CPU 0 __xsk_rcv_zc()
> CPU 2 __xsk_rcv_zc()
> CPU 0 __xsk_map_flush()
> CPU 2 __xsk_map_flush()
> 
> This occurs because we rely on NAPI to ensure that only one napi_poll
> handler is running at a time for the given veth receive queue.
> napi_schedule_prep() will prevent multiple instances from getting
> scheduled. However calling napi_complete_done() signals that this
> napi_poll is complete and allows subsequent calls to
> napi_schedule_prep() and __napi_schedule() to succeed in scheduling a
> concurrent napi_poll before the xdp_do_flush() has been called.  For the
> veth driver a concurrent call to napi_schedule_prep() and
> __napi_schedule() can occur on a different CPU because the veth xmit
> path can additionally schedule a napi_poll creating the race.

The above looks like a generic problem that other drivers could hit.
Perhaps it could be worthy updating the xdp_do_flush() doc text to
explicitly mention it must be called before napi_complete_done().

(in a separate, net-next patch)

Thanks!

Paolo

> 
> The fix as suggested by Magnus Karlsson, is to simply move the
> xdp_do_flush() call before napi_complete_done().  This syncs the
> producer ring pointers before another instance of napi_poll can be
> scheduled on another CPU.  It will also slightly improve performance by
> moving the flush closer to when the descriptors were placed in the
> RX ring.
> 
> Fixes: d1396004dd86 ("veth: Add XDP TX and REDIRECT")
> Suggested-by: Magnus Karlsson <magnus.karlsson@gmail.com>
> Signed-off-by: Shawn Bohrer <sbohrer@cloudflare.com>
> ---
>  drivers/net/veth.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index ac7c0653695f..dfc7d87fad59 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -974,6 +974,9 @@ static int veth_poll(struct napi_struct *napi, int budget)
>  	xdp_set_return_frame_no_direct();
>  	done = veth_xdp_rcv(rq, budget, &bq, &stats);
>  
> +	if (stats.xdp_redirect > 0)
> +		xdp_do_flush();
> +
>  	if (done < budget && napi_complete_done(napi, done)) {
>  		/* Write rx_notify_masked before reading ptr_ring */
>  		smp_store_mb(rq->rx_notify_masked, false);
> @@ -987,8 +990,6 @@ static int veth_poll(struct napi_struct *napi, int budget)
>  
>  	if (stats.xdp_tx > 0)
>  		veth_xdp_flush(rq, &bq);
> -	if (stats.xdp_redirect > 0)
> -		xdp_do_flush();
>  	xdp_clear_return_frame_no_direct();
>  
>  	return done;

