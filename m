Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA0245C32
	for <lists+bpf@lfdr.de>; Mon, 17 Aug 2020 08:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgHQGBQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 02:01:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51095 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbgHQGBP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Aug 2020 02:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597644072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZqKLr61P/Ka9o/AMMcj9b5sk+jdGYs2raS2NdsAqbY=;
        b=hKDd1ApR5X7VFYSxWXkSqEtomWySUfZ5LPBft4bdFLp4HpbRBHDtiMZzPASnkZ2LXrRHld
        +BUaOIuVDPtyrfE4MWBZaQKhA7d/5NlpD16I0bydeFB/RCRtXHa0sXxxHk9AS/LkvmQx3T
        YFtdP2bCFyMhpvo6LfUgqm0B7K/Pk+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-d8Cyh5lDOOuycOHXiGRNbw-1; Mon, 17 Aug 2020 02:01:10 -0400
X-MC-Unique: d8Cyh5lDOOuycOHXiGRNbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14CC0100CF71;
        Mon, 17 Aug 2020 06:01:09 +0000 (UTC)
Received: from carbon (unknown [10.40.208.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6871756A8;
        Mon, 17 Aug 2020 06:01:03 +0000 (UTC)
Date:   Mon, 17 Aug 2020 08:01:02 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     Jason@zx2c4.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        brouer@redhat.com
Subject: Re: [PATCH net] net: xdp: pull ethernet header off packet after
 computing skb->protocol
Message-ID: <20200817080102.61e109cf@carbon>
In-Reply-To: <20200816.152937.1107786737475087036.davem@davemloft.net>
References: <20200815072930.4564-1-Jason@zx2c4.com>
        <20200816.152937.1107786737475087036.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 16 Aug 2020 15:29:37 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Date: Sat, 15 Aug 2020 09:29:30 +0200
> 
> > When an XDP program changes the ethernet header protocol field,
> > eth_type_trans is used to recalculate skb->protocol. In order for
> > eth_type_trans to work correctly, the ethernet header must actually be
> > part of the skb data segment, so the code first pushes that onto the
> > head of the skb. However, it subsequently forgets to pull it back off,
> > making the behavior of the passed-on packet inconsistent between the
> > protocol modifying case and the static protocol case. This patch fixes
> > the issue by simply pulling the ethernet header back off of the skb
> > head.
> > 
> > Fixes: 297249569932 ("net: fix generic XDP to handle if eth header was mangled")
> > Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>  
> 
> Applied and queued up for -stable, thanks.
> 
> Jesper, I wonder how your original patch was tested because it pushes a packet
> with skb->data pointing at the ethernet header into the stack.  That should be
> popped at this point as per this fix here.

I think this patch is wrong, because eth_type_trans() also does a
skb_pull_inline(skb, ETH_HLEN).

To Jason, are you sure about this fix?
How did you test this?


I usually test with:

 $ cd tools/testing/selftests/bpf/
 $ sudo ./test_xdp_vlan_mode_generic.sh 

But currently I get a build error on net-next in:
 net-next/tools/testing/selftests/bpf/tools/build/bpftool/pid_iter.bpf.o
So, I could not run this test.

- - 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

On Sat, 15 Aug 2020 09:29:30 +0200
"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 7df6c9617321..151f1651439f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4676,6 +4676,7 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
>  	    (orig_bcast != is_multicast_ether_addr_64bits(eth->h_dest))) {
>  		__skb_push(skb, ETH_HLEN);
>  		skb->protocol = eth_type_trans(skb, skb->dev);
> +		__skb_pull(skb, ETH_HLEN);
>  	}
>  
>  	switch (act) {

