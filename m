Return-Path: <bpf+bounces-55739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE39A860AA
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D067B2E07
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 14:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12541F9F7A;
	Fri, 11 Apr 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diAdqXS6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71111F3B96
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381941; cv=none; b=lldAwu/ss4leDTwUE4fvTZseh3lS9x6BESSUAnlhAaY5c2hjHniccohoXuhZCnOV4Z8WHpIAkOE8aK6+zjQ4yXTZA/ThJQsHwYRZXzj6uiUgGEgsY3MX96hRf44ZeT29mFNFt/rOCyax7LnsOG89fLUOiEuXKUem5ubT6KJfgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381941; c=relaxed/simple;
	bh=ogKOlLxLstrDNpREjP0LoHeyE4RfcLXfkNGcGMtMsyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b39BlKKOKzI2jUNpppYXbEV3icOg88j6gsESBZOhmBLIJxOa1q2ZcZNA38Rx+7rPGI8vDubG6DaoQTIdZd/DURB/SCBjwi86IcvkNXI3bE3ox/DWiQn+LehxiBcfn5MT0a43QDimC4/5NNbHXzJTceXcseLBcNnVc97b51tB55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diAdqXS6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744381938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fz6GFXFZnIKZQSb26rL837+i67A+xrPzcPolFWojudw=;
	b=diAdqXS6Oe2Hgz6qcl/Y2OOTA2DyhBsSr6/ocunRoLbvDADhCNX+qldhgLNGW2xbLqlrR1
	i567O/Wy88fEkcO07/JMOM/P8kEGGEOf5SH/SXZeGCCLQ6tfX9FN3PcpPk5+NEdTTSKaMI
	tCbzH4dgfthHV/9l2rSHRXNrjBFsp94=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-FnUmqCkLNoiu0uTGibn1iQ-1; Fri, 11 Apr 2025 10:32:16 -0400
X-MC-Unique: FnUmqCkLNoiu0uTGibn1iQ-1
X-Mimecast-MFC-AGG-ID: FnUmqCkLNoiu0uTGibn1iQ_1744381935
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30bff0c526cso10696551fa.0
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 07:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744381935; x=1744986735;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz6GFXFZnIKZQSb26rL837+i67A+xrPzcPolFWojudw=;
        b=rmppAlHLLKs5b9ZvifD5mzDcHTJ3HQrF23Agn+TuQpgAQoJFiWhTKNVTwe0cA7+rkP
         G4CDW5pDNkRxyzePmOAGnDJ9K9helUAashwDqKZpSvzHDcuhC5ESt0k1TyPBdGzLN43S
         0Q9MzM5y8KbJbYnzKt1VEybMA6Dq7b0w+3GVP9Ql4P+d9zVSQ/Ekv1UzihgutY5Lsd7i
         0ZXvkfxamOBKivuMUXDRjLT/ecY17P3JEmM9dcJCDV/R6FP907575tDLM3fA3l92/cqp
         /gN2cuw2tXik6iu8un1N0h8pRXbgAiBphcgu7f1amqa/rDvgs91Rlw86vj78yuViu1ZT
         iYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj1eRWQfaVfQyZ3Byxvnrv3vzh4szlSnxv6AnDa+4rh02Uaxw5avDCLvDI990xY08FcN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUss9sqKM9PmHL4WKaRDEeQ1m7zP1ieCkdhqAaPNUyCiuBWd5
	cWJcKz3hNZ2vL8YJDUs7nMumo8kaXKW2Am9ggfZTn/CYA/3TgxdojAES/KFcI2c+/mz3H65YXdy
	QDh0dHi/Yj14ww5IZBmZEPDRQzCVVw0PbyvzkwUEOHpZo2dj7ag==
X-Gm-Gg: ASbGncuBFub5bJo9MHf8DCqJHV6aIPIKupjmAdXovnKgmWE3Zlfxz7SK2C8CDrVsPa/
	3qW6cnKLh2PfuL3XrdL4WnblQkR4zy9H8x8f1LZaPlFASZskKUS+3MB3MG/rxDgAb8cVLjqsIuO
	0VCbjwDNhdZOjIaAv1O5wNfVeLymchMUswz+dcnzn7RL6X+YP7jSw0L2hj686l63hhjSnYOSho4
	mi+EtbdG8EtLBlus7lytn5xLiDdN3WR6lid3UwmRWrdzcXTt1+2OovN0prFbJJNTd4d3DOaO8Po
	MX56gjoY/OT6fZpjZXRGQUfiv/5OJzUOI1H8
X-Received: by 2002:a05:651c:2122:b0:30c:1441:9e84 with SMTP id 38308e7fff4ca-310499d61b4mr9891531fa.13.1744381934618;
        Fri, 11 Apr 2025 07:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZEdv1p2UbYRzGrFH+3oBZh+dQ/krS7yGtQjggE9C5bv+e92JJKkVXa41yqFAMjhZ5jlycTw==
X-Received: by 2002:a05:651c:2122:b0:30c:1441:9e84 with SMTP id 38308e7fff4ca-310499d61b4mr9891391fa.13.1744381934129;
        Fri, 11 Apr 2025 07:32:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464cd9c9sm8360751fa.42.2025.04.11.07.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:32:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1D4ED19924C6; Fri, 11 Apr 2025 16:32:12 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, tom@herbertland.com, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, dsahern@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next V2 1/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
In-Reply-To: <ff5e6185-0dcb-4879-8031-bdb0b0edcec6@kernel.org>
References: <174412623473.3702169.4235683143719614624.stgit@firesoul>
 <174412627898.3702169.3326405632519084427.stgit@firesoul>
 <20250411124553.GD395307@horms.kernel.org>
 <ff5e6185-0dcb-4879-8031-bdb0b0edcec6@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 11 Apr 2025 16:32:12 +0200
Message-ID: <875xjau5ub.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 11/04/2025 14.45, Simon Horman wrote:
>> On Tue, Apr 08, 2025 at 05:31:19PM +0200, Jesper Dangaard Brouer wrote:
>>> In production, we're seeing TX drops on veth devices when the ptr_ring
>>> fills up. This can occur when NAPI mode is enabled, though it's
>>> relatively rare. However, with threaded NAPI - which we use in
>>> production - the drops become significantly more frequent.
>>>
>>> The underlying issue is that with threaded NAPI, the consumer often runs
>>> on a different CPU than the producer. This increases the likelihood of
>>> the ring filling up before the consumer gets scheduled, especially under
>>> load, leading to drops in veth_xmit() (ndo_start_xmit()).
>>>
>>> This patch introduces backpressure by returning NETDEV_TX_BUSY when the
>>> ring is full, signaling the qdisc layer to requeue the packet. The txq
>>> (netdev queue) is stopped in this condition and restarted once
>>> veth_poll() drains entries from the ring, ensuring coordination between
>>> NAPI and qdisc.
>>>
>>> Backpressure is only enabled when a qdisc is attached. Without a qdisc,
>>> the driver retains its original behavior - dropping packets immediately
>>> when the ring is full. This avoids unexpected behavior changes in setups
>>> without a configured qdisc.
>>>
>>> With a qdisc in place (e.g. fq, sfq) this allows Active Queue Management
>>> (AQM) to fairly schedule packets across flows and reduce collateral
>>> damage from elephant flows.
>>>
>>> A known limitation of this approach is that the full ring sits in front
>>> of the qdisc layer, effectively forming a FIFO buffer that introduces
>>> base latency. While AQM still improves fairness and mitigates flow
>>> dominance, the latency impact is measurable.
>>>
>>> In hardware drivers, this issue is typically addressed using BQL (Byte
>>> Queue Limits), which tracks in-flight bytes needed based on physical link
>>> rate. However, for virtual drivers like veth, there is no fixed bandwidth
>>> constraint - the bottleneck is CPU availability and the scheduler's ability
>>> to run the NAPI thread. It is unclear how effective BQL would be in this
>>> context.
>>>
>>> This patch serves as a first step toward addressing TX drops. Future work
>>> may explore adapting a BQL-like mechanism to better suit virtual devices
>>> like veth.
>>>
>>> Reported-by: Yan Zhai <yan@cloudflare.com>
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> 
>> Thanks Jesper,
>> 
>> It's very nice to see backpressure support being added here.
>> 
>> ...
>> 
>>> @@ -874,9 +909,16 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>>   			struct veth_xdp_tx_bq *bq,
>>>   			struct veth_stats *stats)
>>>   {
>>> +	struct veth_priv *priv = netdev_priv(rq->dev);
>>> +	int queue_idx = rq->xdp_rxq.queue_index;
>>> +	struct netdev_queue *peer_txq;
>>> +	struct net_device *peer_dev;
>>>   	int i, done = 0, n_xdpf = 0;
>>>   	void *xdpf[VETH_XDP_BATCH];
>>>   
>>> +	peer_dev = priv->peer;
>> 
>> I think you need to take into account RCU here.
>> 
>> Sparse says:
>> 
>>    .../veth.c:919:18: warning: incorrect type in assignment (different address spaces)
>>    .../veth.c:919:18:    expected struct net_device *peer_dev
>>    .../veth.c:919:18:    got struct net_device [noderef] __rcu *peer
>> 
>
> Is it correctly understood that I need an:
>
>    peer_dev = rcu_dereference(priv->peer);
>
> And also wrap this in a RCU section (rcu_read_lock()) ?

Just the deref - softirq already counts as an RCU section, so no need
for an additional rcu_read_lock() :)

-Toke


