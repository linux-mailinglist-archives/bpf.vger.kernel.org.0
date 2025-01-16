Return-Path: <bpf+bounces-49113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0F9A1433D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC783A7477
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4E9241681;
	Thu, 16 Jan 2025 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="I7OqsmYT"
X-Original-To: bpf@vger.kernel.org
Received: from mx13lb.world4you.com (mx13lb.world4you.com [81.19.149.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01AC236A64;
	Thu, 16 Jan 2025 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059301; cv=none; b=haAYmovAGh+bYTuwiI9OL/Cy5Pvf0hSgB1KPSixTRSYa72V/IoNotNqvGMqjh76lXtBu6IMlaK0ll2nXf6rX48KSJ19VnWCvnsQ2EqEAZvqE6NeB9qJ6C9fxqYTtGmBP/WKWCXl3tgoI3U3FPJOJHQQMpsJTOy8YsD53OJPhiH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059301; c=relaxed/simple;
	bh=nudOlvqSJ1aBhTQ2tX4dtnYAuDIsm35x9yhIVoUF/mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MTA9t8QchOzWpTO7rqt6hJwPnHOcLcDy4Am52Lg6LU+cxX1gLQ3o7DxxXdWVO7sxBfg0oi4JjLJ2SbTyKA14r3A9KOmOqi+vADJGYspnyJwSHzxXp/555/UcmfOvrhFRx/cQy/RfcykclprwBpf9mNcJP1DMxI0XSYWqAsp40Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=I7OqsmYT; arc=none smtp.client-ip=81.19.149.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ahuT/uI6m98g3xSc8Ha9OAIyv3omnEhaK7ihtInarV0=; b=I7OqsmYTo+0VcA+Ln2qQcokgSz
	OLyZ30zDmnP1fjgVzUgNx13Jf5RBmlYgfjjheUWk96EbXAUkIWdBwjeHv2T7WChrZ7XfEx2LYCHGW
	FRNBXzk6CEv45lziRZH+e8WYkCElbRz00SeNFQNo5n+xxJOFKXbhwu/3Ub/qqk3scpNY=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx13lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tYWTJ-000000006xn-2BtL;
	Thu, 16 Jan 2025 21:28:09 +0100
Message-ID: <f8fe5618-af94-4f5b-8dbc-e8cae744aedf@engleder-embedded.com>
Date: Thu, 16 Jan 2025 21:28:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20250116055302.14308-1-jdamato@fastly.com>
 <20250116055302.14308-4-jdamato@fastly.com>
 <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
 <Z4kvQI8GmmEGrq1F@LQ3V64L9R2>
Content-Language: en-US
Cc: "open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>, jasowang@redhat.com, leiyang@redhat.com,
 mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <Z4kvQI8GmmEGrq1F@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 16.01.25 17:09, Joe Damato wrote:
> On Thu, Jan 16, 2025 at 03:53:14PM +0800, Xuan Zhuo wrote:
>> On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote:
>>> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
>>> can be accessed by user apps.
>>>
>>> $ ethtool -i ens4 | grep driver
>>> driver: virtio_net
>>>
>>> $ sudo ethtool -L ens4 combined 4
>>>
>>> $ ./tools/net/ynl/pyynl/cli.py \
>>>         --spec Documentation/netlink/specs/netdev.yaml \
>>>         --dump queue-get --json='{"ifindex": 2}'
>>> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>>>   {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>>>   {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>>>   {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>>>   {'id': 0, 'ifindex': 2, 'type': 'tx'},
>>>   {'id': 1, 'ifindex': 2, 'type': 'tx'},
>>>   {'id': 2, 'ifindex': 2, 'type': 'tx'},
>>>   {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>>>
>>> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
>>> the lack of 'napi-id' in the above output is expected.
>>>
>>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>>> ---
>>>   v2:
>>>     - Eliminate RTNL code paths using the API Jakub introduced in patch 1
>>>       of this v2.
>>>     - Added virtnet_napi_disable to reduce code duplication as
>>>       suggested by Jason Wang.
>>>
>>>   drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
>>>   1 file changed, 29 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index cff18c66b54a..c6fda756dd07 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
>>>   	local_bh_enable();
>>>   }
>>>
>>> -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
>>> +static void virtnet_napi_enable(struct virtqueue *vq,
>>> +				struct napi_struct *napi)
>>>   {
>>> +	struct virtnet_info *vi = vq->vdev->priv;
>>> +	int q = vq2rxq(vq);
>>> +	u16 curr_qs;
>>> +
>>>   	virtnet_napi_do_enable(vq, napi);
>>> +
>>> +	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
>>> +	if (!vi->xdp_enabled || q < curr_qs)
>>> +		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
>>
>> So what case the check of xdp_enabled is for?
> 
> Based on a previous discussion [1], the NAPIs should not be linked
> for in-kernel XDP, but they _should_ be linked for XSK.
> 
> I could certainly have misread the virtio_net code (please let me
> know if I've gotten it wrong, I'm not an expert), but the three
> cases I have in mind are:
> 
>    - vi->xdp_enabled = false, which happens when no XDP is being
>      used, so the queue number will be < vi->curr_queue_pairs.
> 
>    - vi->xdp_enabled = false, which I believe is what happens in the
>      XSK case. In this case, the NAPI is linked.
> 
>    - vi->xdp_enabled = true, which I believe only happens for
>      in-kernel XDP - but not XSK - and in this case, the NAPI should
>      NOT be linked.

My interpretation based on [1] is that an in-kernel XDP Tx queue is a
queue that is only used if XDP is attached and is not visible to
userspace. The in-kernel XDP Tx queue is used to not load stack Tx
queues with XDP packets. IIRC fbnic has additional queues only for
XDP Tx. So for stack RX queues I would always link napi, no matter if
XDP is attached or not. I think most driver do not have in-kernel XDP
Tx queues. But I'm also not an expert.

Gerhard

