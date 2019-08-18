Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171B091549
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2019 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfHRHKp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Aug 2019 03:10:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfHRHKo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Aug 2019 03:10:44 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 383AC3DBC2
        for <bpf@vger.kernel.org>; Sun, 18 Aug 2019 07:10:44 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id g125so355372qkd.7
        for <bpf@vger.kernel.org>; Sun, 18 Aug 2019 00:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pG67TpAucqj+QXErTkQVEhnyrRaRpklq4dlSH5XWxbY=;
        b=uU7Xi/nwQo4ImnzV0sP3BCg5Ck6I376ZeUXrMU5GV285IE9OeXUnwV/a6Y/t/3eBYM
         O0kjRfWxOtpT16j1uoUodvIPjgXSW99spVf5ZzLnxjhRkWJr37fixagj+au2rVragmaR
         896I8jTwazLHECoqzbclpARxJyZuq5r43T6fporQ2+iunxPXGXf4LY8MbF5sFc8/wNA+
         V+mD4hPXMx3CyO9pNRIjLfy/Rt+UYB4J4H02wBRiS308iOhZyhhzUKphfjSmK27F3GZH
         rDuMN5a5920mKBw3RqAHXH8y5tU81Csqzl4uubnkE/bduUddLitZMV0Ia1FNpqhQMhSj
         TkxQ==
X-Gm-Message-State: APjAAAUMZ72L0XRFOityUlKe8Q/e51d3kgJgtmK8CxguqLigy7q0uifV
        LEyUnphDS9Xk9bn3cvvc6e7elX60EIdxN6woCka3s1/WhFmDc/hFN/icwTeKL0UWVEe69pcca0v
        olzZtmK70NA7T
X-Received: by 2002:a37:a013:: with SMTP id j19mr16437438qke.401.1566112243570;
        Sun, 18 Aug 2019 00:10:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+lwpHXPdpc20v/W4ahvahjXp7xvnN6kcPiBu5Jkb2fdOBr/0eK82rKArgosyck6pKhjs7pA==
X-Received: by 2002:a37:a013:: with SMTP id j19mr16437415qke.401.1566112243373;
        Sun, 18 Aug 2019 00:10:43 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id h4sm4900625qtq.82.2019.08.18.00.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 00:10:42 -0700 (PDT)
Date:   Sun, 18 Aug 2019 03:10:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     ? jiang <jiangkidd@hotmail.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "jiangran.jr@alibaba-inc.com" <jiangran.jr@alibaba-inc.com>
Subject: Re: [PATCH v2] virtio-net: lower min ring num_free for efficiency
Message-ID: <20190818030410-mutt-send-email-mst@kernel.org>
References: <BYAPR14MB32058F4B2AD162F5421BB9B4A6AC0@BYAPR14MB3205.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR14MB32058F4B2AD162F5421BB9B4A6AC0@BYAPR14MB3205.namprd14.prod.outlook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 15, 2019 at 09:42:40AM +0000, ? jiang wrote:
> This change lowers ring buffer reclaim threshold from 1/2*queue to budget
> for better performance. According to our test with qemu + dpdk, packet
> dropping happens when the guest is not able to provide free buffer in
> avail ring timely with default 1/2*queue. The value in the patch has been
> tested and does show better performance.
> 
> Test setup: iperf3 to generate packets to guest (total 30mins, pps 400k, UDP)
> avg packets drop before: 2842
> avg packets drop after: 360(-87.3%)
> 
> Signed-off-by: jiangkidd <jiangkidd@hotmail.com>

To add to that:

Further, current code suffers from a starvation problem: the amount of
work done by try_fill_recv is not bounded by the budget parameter, thus
(with large queues) once in a while userspace gets blocked for a long
time while queue is being refilled. Trigger refills earlier to make sure
the amount of work to do is limited.

With this addition to the log:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0d4115c9e20b..bc08be7925eb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1331,7 +1331,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  		}
>  	}
>  
> -	if (rq->vq->num_free > virtqueue_get_vring_size(rq->vq) / 2) {
> +	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>  		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
>  			schedule_delayed_work(&vi->refill, 0);
>  	}
> -- 
> 2.11.0
