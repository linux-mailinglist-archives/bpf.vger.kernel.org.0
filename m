Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6F436058D
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 11:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhDOJWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 05:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229820AbhDOJWt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 05:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618478546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ivb2l1K0xVJH8oHqD6l0FmtySyvvWDd57IM+59E+dzM=;
        b=Y8tKSm8nxbS84QWWqnZFoHShYuZp4BwsShEIyYUHEDrMXoux0YzxBI/klh4tzBygytk01T
        JIb0eQm2weWObUCbKgerbuvFnu4pBBhUHNCgnkQXtEJu0jT9ZgtcsKxLfTkTN3Lhh70HAp
        8PAb7DGEUi8s9mRX5iSn4o9LVkcyO6E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-baUYRlR7NTOZRqvkR-_WHg-1; Thu, 15 Apr 2021 05:22:21 -0400
X-MC-Unique: baUYRlR7NTOZRqvkR-_WHg-1
Received: by mail-ej1-f69.google.com with SMTP id i10-20020a1709067a4ab029037c5dba8400so714753ejo.8
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 02:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ivb2l1K0xVJH8oHqD6l0FmtySyvvWDd57IM+59E+dzM=;
        b=U/2b4Tp+e+tr8k9OH+FnKc8QOdjJGYIqeBxmCtFLdkxmEtGfAnU/6h8ReP01NH3xUI
         S6fBb9JNz4mMXNfrRVauIaYBgvMPOwvFqVmrexS0CoTZB3E19y72bN5XZlIFdkwrQ9mS
         iilKH/mCCFeVc57VYzrpZSpj07YrEb5oHQYT0IMNR2xxXk8VmpnKAhl6e2cS/3CT59fg
         daX+9VoHdmX3toa4sfGREf7AoVQX8k/4fce5RDfyynV+3t7AKIpapxlfF1d5PFVpH8pC
         E4YcLJtBsXz4AFj7tkj3BGYUkidohDbcEDbOQFp2/2D6+lVmwYC3REqA/9bSEVJxKUOB
         4jvA==
X-Gm-Message-State: AOAM530BUGiWaRP0v54gY2qBFsyCbo5kYbADUlv+ep+kJqKhy+HIeA2a
        8NSi0XUJgNY0GLUKOprqCOAX1LevpOzRjjfsb4Z7O+DNzeW7IGNzHLtMi7a+vIyuqJeqBOf1YsO
        etWyj52FuP3us
X-Received: by 2002:a17:906:51d5:: with SMTP id v21mr2504830ejk.252.1618478540481;
        Thu, 15 Apr 2021 02:22:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfUVAs2dicRWqRdQPDoQNOoQHziSBKLoqiiAFb/A3v2yLBTpmKJwhyNtg4q4D1iwgwrQmxkw==
X-Received: by 2002:a17:906:51d5:: with SMTP id v21mr2504814ejk.252.1618478540279;
        Thu, 15 Apr 2021 02:22:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id bm13sm1487237ejb.75.2021.04.15.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:22:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 186061806B3; Thu, 15 Apr 2021 11:22:19 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>, Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?utf-8?B?QmrDtnJuIFQ=?= =?utf-8?B?w7ZwZWw=?= 
        <bjorn.topel@gmail.com>
Subject: Re: [PATCHv7 bpf-next 1/4] bpf: run devmap xdp_prog on flush
 instead of bulk enqueue
In-Reply-To: <20210415023746.GR2900@Leo-laptop-t470s>
References: <20210414122610.4037085-1-liuhangbin@gmail.com>
 <20210414122610.4037085-2-liuhangbin@gmail.com>
 <20210415001711.dpbt2lej75ry6v7a@kafai-mbp.dhcp.thefacebook.com>
 <20210415023746.GR2900@Leo-laptop-t470s>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 15 Apr 2021 11:22:19 +0200
Message-ID: <87o8efkilw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Wed, Apr 14, 2021 at 05:17:11PM -0700, Martin KaFai Lau wrote:
>> >  static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
>> >  {
>> >  	struct net_device *dev = bq->dev;
>> > -	int sent = 0, err = 0;
>> > +	int sent = 0, drops = 0, err = 0;
>> > +	unsigned int cnt = bq->count;
>> > +	int to_send = cnt;
>> >  	int i;
>> >  
>> > -	if (unlikely(!bq->count))
>> > +	if (unlikely(!cnt))
>> >  		return;
>> >  
>> > -	for (i = 0; i < bq->count; i++) {
>> > +	for (i = 0; i < cnt; i++) {
>> >  		struct xdp_frame *xdpf = bq->q[i];
>> >  
>> >  		prefetch(xdpf);
>> >  	}
>> >  
>> > -	sent = dev->netdev_ops->ndo_xdp_xmit(dev, bq->count, bq->q, flags);
>> > +	if (bq->xdp_prog) {
>> bq->xdp_prog is used here
>> 
>> > +		to_send = dev_map_bpf_prog_run(bq->xdp_prog, bq->q, cnt, dev);
>> > +		if (!to_send)
>> > +			goto out;
>> > +
>> > +		drops = cnt - to_send;
>> > +	}
>> > +
>> 
>> [ ... ]
>> 
>> >  static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
>> > -		       struct net_device *dev_rx)
>> > +		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
>> >  {
>> >  	struct list_head *flush_list = this_cpu_ptr(&dev_flush_list);
>> >  	struct xdp_dev_bulk_queue *bq = this_cpu_ptr(dev->xdp_bulkq);
>> > @@ -412,18 +466,22 @@ static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
>> >  	/* Ingress dev_rx will be the same for all xdp_frame's in
>> >  	 * bulk_queue, because bq stored per-CPU and must be flushed
>> >  	 * from net_device drivers NAPI func end.
>> > +	 *
>> > +	 * Do the same with xdp_prog and flush_list since these fields
>> > +	 * are only ever modified together.
>> >  	 */
>> > -	if (!bq->dev_rx)
>> > +	if (!bq->dev_rx) {
>> >  		bq->dev_rx = dev_rx;
>> > +		bq->xdp_prog = xdp_prog;
>> bp->xdp_prog is assigned here and could be used later in bq_xmit_all().
>> How is bq->xdp_prog protected? Are they all under one rcu_read_lock()?
>> It is not very obvious after taking a quick look at xdp_do_flush[_map].
>> 
>> e.g. what if the devmap elem gets deleted.
>
> Jesper knows better than me. From my veiw, based on the description of
> __dev_flush():
>
> On devmap tear down we ensure the flush list is empty before completing to
> ensure all flush operations have completed. When drivers update the bpf
> program they may need to ensure any flush ops are also complete.

Yeah, drivers call xdp_do_flush() before exiting their NAPI poll loop,
which also runs under one big rcu_read_lock(). So the storage in the
bulk queue is quite temporary, it's just used for bulking to increase
performance :)

-Toke

