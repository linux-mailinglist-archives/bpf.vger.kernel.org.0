Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C7F300460
	for <lists+bpf@lfdr.de>; Fri, 22 Jan 2021 14:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbhAVNkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jan 2021 08:40:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727732AbhAVNkN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Jan 2021 08:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611322726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ESMRBdLtLFOd2qHl0je6Tr9Gz6IEnLeR4LgTJSk019A=;
        b=gRxj9LHmUmO/20yCBbIBDoTK/LXxpSjHeLc6DVzPEKAZR3PJBMIKqj3yGhsQF2lbgoLYdZ
        XR+LuMadpyqcanGKrJQza6N30DRIB4U1Yh7djZGYvhuTxtELq8a1JL//urhk1M+lykfwit
        3AtpG0S5vfcsnNf55897fcMBI6I1BuM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-523vuH0bOiW1NKHbunA0Cw-1; Fri, 22 Jan 2021 08:38:43 -0500
X-MC-Unique: 523vuH0bOiW1NKHbunA0Cw-1
Received: by mail-ed1-f70.google.com with SMTP id m16so2899037edd.21
        for <bpf@vger.kernel.org>; Fri, 22 Jan 2021 05:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ESMRBdLtLFOd2qHl0je6Tr9Gz6IEnLeR4LgTJSk019A=;
        b=XAQOhoMxr6YgIPTBJpAaWgpxgIqTLJ/4zfe3mBQilBMHEQIMINS4SAue397HXAIUJj
         ZibL1/SWTy1CHV8zpc8BgtPB/DEaHnobAuGUyZz4fRg3cnw03EIGCjLNV3zvumMl6xf7
         AtuovTL8rq5jx7ZP5ehe9KDTgrCEMX0utLuchYBPQeiWXiPjv7LLcPpP+a681cNuh/CI
         kVmwuMwNa86/NlQVMI5stcskbURKK3wprM6Knrvz1Wx0ygGCvrn17tDCw2dkLj8ElLiC
         7Qqbx/fzVpJeiaXnztraRSUu1n6F6etqacKSJTigKur85w9nnvYwxQMNeLvgeG4GZnwZ
         bSNA==
X-Gm-Message-State: AOAM532n9CdmIgEGcxsa3M5yrgtyewVtlF05OEau07hM3DZ761jVNnkR
        41V1jRumatAipqs0J9uO6QttJwnw2P+p74tfkY5+zYjF1Ts9QDTIQr8VRXAKJxjcuVarKLkjRcT
        o/Ff7B/e9j3q4
X-Received: by 2002:a17:907:1050:: with SMTP id oy16mr2959964ejb.424.1611322722031;
        Fri, 22 Jan 2021 05:38:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMpPv+tIe1M9NE6Ex0CyBdStk7i10KJ3VgAOz0T2MNNUK+KH2fR3Cgl2br6+BX74LNLHVW0A==
X-Received: by 2002:a17:907:1050:: with SMTP id oy16mr2959945ejb.424.1611322721831;
        Fri, 22 Jan 2021 05:38:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f13sm4433836ejf.42.2021.01.22.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 05:38:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AC9AA180338; Fri, 22 Jan 2021 14:38:40 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCHv16 bpf-next 1/6] bpf: run devmap xdp_prog on flush
 instead of bulk enqueue
In-Reply-To: <20210122105043.GB52373@ranger.igk.intel.com>
References: <20210120022514.2862872-1-liuhangbin@gmail.com>
 <20210122074652.2981711-1-liuhangbin@gmail.com>
 <20210122074652.2981711-2-liuhangbin@gmail.com>
 <20210122105043.GB52373@ranger.igk.intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 22 Jan 2021 14:38:40 +0100
Message-ID: <871red6qhr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Fri, Jan 22, 2021 at 03:46:47PM +0800, Hangbin Liu wrote:
>> From: Jesper Dangaard Brouer <brouer@redhat.com>
>> 
>> This changes the devmap XDP program support to run the program when the
>> bulk queue is flushed instead of before the frame is enqueued. This has
>> a couple of benefits:
>> 
>> - It "sorts" the packets by destination devmap entry, and then runs the
>>   same BPF program on all the packets in sequence. This ensures that we
>>   keep the XDP program and destination device properties hot in I-cache.
>> 
>> - It makes the multicast implementation simpler because it can just
>>   enqueue packets using bq_enqueue() without having to deal with the
>>   devmap program at all.
>> 
>> The drawback is that if the devmap program drops the packet, the enqueue
>> step is redundant. However, arguably this is mostly visible in a
>> micro-benchmark, and with more mixed traffic the I-cache benefit should
>> win out. The performance impact of just this patch is as follows:
>> 
>> Using xdp_redirect_map(with a 2nd xdp_prog patch[1]) in sample/bpf and send
>> pkts via pktgen cmd:
>> ./pktgen_sample03_burst_single_flow.sh -i eno1 -d $dst_ip -m $dst_mac -t 10 -s 64
>> 
>> There are about +/- 0.1M deviation for native testing, the performance
>> improved for the base-case, but some drop back with xdp devmap prog attached.
>> 
>> Version          | Test                           | Generic | Native | Native + 2nd xdp_prog
>> 5.10 rc6         | xdp_redirect_map   i40e->i40e  |    2.0M |   9.1M |  8.0M
>> 5.10 rc6         | xdp_redirect_map   i40e->veth  |    1.7M |  11.0M |  9.7M
>> 5.10 rc6 + patch | xdp_redirect_map   i40e->i40e  |    2.0M |   9.5M |  7.5M
>> 5.10 rc6 + patch | xdp_redirect_map   i40e->veth  |    1.7M |  11.6M |  9.1M
>> 
>> [1] https://lore.kernel.org/bpf/20210122025007.2968381-1-liuhangbin@gmail.com
>> 
>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>> 
>> ---
>> v16:
>> a) refactor bq_xmit_all logic and remove error label
>> 
>> v15:
>> a) do not use unlikely when checking bq->xdp_prog
>> b) return sent frames for dev_map_bpf_prog_run()
>> 
>> v14: no update, only rebase the code
>> v13: pass in xdp_prog through __xdp_enqueue()
>> v2-v12: no this patch
>> ---
>>  kernel/bpf/devmap.c | 136 ++++++++++++++++++++++++++------------------
>>  1 file changed, 81 insertions(+), 55 deletions(-)
>> 
>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>> index f6e9c68afdd4..c24fcffbbfad 100644
>> --- a/kernel/bpf/devmap.c
>> +++ b/kernel/bpf/devmap.c
>> @@ -57,6 +57,7 @@ struct xdp_dev_bulk_queue {
>>  	struct list_head flush_node;
>>  	struct net_device *dev;
>>  	struct net_device *dev_rx;
>> +	struct bpf_prog *xdp_prog;
>>  	unsigned int count;
>>  };
>>  
>> @@ -327,46 +328,95 @@ bool dev_map_can_have_prog(struct bpf_map *map)
>>  	return false;
>>  }
>>  
>> +static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
>> +				struct xdp_frame **frames, int n,
>> +				struct net_device *dev)
>> +{
>> +	struct xdp_txq_info txq = { .dev = dev };
>> +	struct xdp_buff xdp;
>> +	int i, nframes = 0;
>> +
>> +	for (i = 0; i < n; i++) {
>> +		struct xdp_frame *xdpf = frames[i];
>> +		u32 act;
>> +		int err;
>> +
>> +		xdp_convert_frame_to_buff(xdpf, &xdp);
>> +		xdp.txq = &txq;
>> +
>> +		act = bpf_prog_run_xdp(xdp_prog, &xdp);
>> +		switch (act) {
>> +		case XDP_PASS:
>> +			err = xdp_update_frame_from_buff(&xdp, xdpf);
>> +			if (unlikely(err < 0))
>> +				xdp_return_frame_rx_napi(xdpf);
>> +			else
>> +				frames[nframes++] = xdpf;
>> +			break;
>> +		default:
>> +			bpf_warn_invalid_xdp_action(act);
>> +			fallthrough;
>> +		case XDP_ABORTED:
>> +			trace_xdp_exception(dev, xdp_prog, act);
>> +			fallthrough;
>> +		case XDP_DROP:
>> +			xdp_return_frame_rx_napi(xdpf);
>> +			break;
>> +		}
>> +	}
>> +	return nframes; /* sent frames count */
>> +}
>> +
>>  static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
>>  {
>>  	struct net_device *dev = bq->dev;
>> -	int sent = 0, drops = 0, err = 0;
>> +	unsigned int cnt = bq->count;
>> +	int drops = 0, err = 0;
>> +	int to_sent = cnt;
>
> Hmm if I would be super picky then I'd like to have this variable as
> "to_send", as we spoke. Could you change that?
>
> With that, you can add my:
>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
> to next revision.
>
>> +	int sent = cnt;
>>  	int i;
>>  
>> -	if (unlikely(!bq->count))
>> +	if (unlikely(!cnt))
>>  		return;
>>  
>> -	for (i = 0; i < bq->count; i++) {
>> +	for (i = 0; i < cnt; i++) {
>>  		struct xdp_frame *xdpf = bq->q[i];
>>  
>>  		prefetch(xdpf);
>>  	}
>>  
>> -	sent = dev->netdev_ops->ndo_xdp_xmit(dev, bq->count, bq->q, flags);
>> +	if (bq->xdp_prog) {
>> +		to_sent = dev_map_bpf_prog_run(bq->xdp_prog, bq->q, cnt, dev);
>> +		if (!to_sent) {
>> +			sent = 0;
>> +			goto out;
>> +		}
>> +		drops = cnt - to_sent;
>> +	}
>> +
>> +	sent = dev->netdev_ops->ndo_xdp_xmit(dev, to_sent, bq->q, flags);
>>  	if (sent < 0) {
>>  		err = sent;
>>  		sent = 0;
>> -		goto error;
>> +
>> +		/* If ndo_xdp_xmit fails with an errno, no frames have been
>> +		 * xmit'ed and it's our responsibility to them free all.
>> +		 */
>> +		for (i = 0; i < cnt - drops; i++) {
>> +			struct xdp_frame *xdpf = bq->q[i];
>> +
>> +			xdp_return_frame_rx_napi(xdpf);
>> +		}
>>  	}
>> -	drops = bq->count - sent;
>>  out:
>> +	drops = cnt - sent;
>>  	bq->count = 0;
>>  
>>  	trace_xdp_devmap_xmit(bq->dev_rx, dev, sent, drops, err);
>>  	bq->dev_rx = NULL;
>> +	bq->xdp_prog = NULL;
>
> One more question, do you really have to do that per each bq_xmit_all
> call? Couldn't you clear it in __dev_flush ?
>
> Or IOW - what's the rationale behind storing xdp_prog in
> xdp_dev_bulk_queue. Why can't you propagate the dst->xdp_prog and rely on
> that without that local pointer?
>
> You probably have an answer for that, so maybe include it in commit
> message.
>
> BTW same question for clearing dev_rx. To me this will be the same for all
> bq_xmit_all() calls that will happen within same napi.

I think you're right: When bq_xmit_all() is called from bq_enqueue(),
another packet will always be enqueued immediately after, so clearing
out all of those things in bq_xmit_all() is redundant. This also
includes the list_del on bq->flush_node, BTW.

And while we're getting into e micro-optimisations: In bq_enqueue() we
have two checks:

	if (!bq->dev_rx)
		bq->dev_rx = dev_rx;

	bq->q[bq->count++] = xdpf;

	if (!bq->flush_node.prev)
		list_add(&bq->flush_node, flush_list);


those two if() checks can be collapsed into one, since the list and the
dev_rx field are only ever modified together. This will also be the case
for bq->xdp_prog, so putting all three under the same check in
bq_enqueue() and only clearing them in __dev_flush() would be a win, I
suppose - nice catch! :)

-Toke

