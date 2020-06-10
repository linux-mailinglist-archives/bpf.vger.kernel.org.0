Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFCF1F524F
	for <lists+bpf@lfdr.de>; Wed, 10 Jun 2020 12:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgFJK34 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Jun 2020 06:29:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60844 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728268AbgFJK3o (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Jun 2020 06:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591784982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GxKKu811+w7UaGJmYO5+6aGvvE5GsIhCJfPwnaN5ZHw=;
        b=JHSwFWrUGzvWmFq0+n6f0vM6wiF/M4oaR0FxtecIvohPlb784Gzq2pDgGatEKaHeqfyFQR
        6PF2ZcDz1obLAvSO8aqyzCtdh1tJvAeF0WXWHddQ64WyOsF0kDrxkDfQDoylr2x5LSFG7W
        +bzqLD7eiw4tRdnbybM5QtcWVmxHp+w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-7AO2qwmyOJKJci04x5QhNA-1; Wed, 10 Jun 2020 06:29:39 -0400
X-MC-Unique: 7AO2qwmyOJKJci04x5QhNA-1
Received: by mail-ed1-f69.google.com with SMTP id 92so501712edl.8
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 03:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GxKKu811+w7UaGJmYO5+6aGvvE5GsIhCJfPwnaN5ZHw=;
        b=fBt8oG3QNgt+3YCT7Y5AEIhG5XaqU25fRONBzQrJVTmHNuy9GKrZ+gEqCt86SAVKpG
         AeWwQJfQaXtKr/hlOw4SLEYJQ7DPt6BHE2kP0yYxciW05vZ2hxQ29F6Jh+7ZstjV4tqd
         k4FNxd+cjwU7lsuu5USZOqmi0sajikuud8DPGSXAK2IGwlWtFwwDulgRCTimeIJMAsnQ
         uT6ZztZ/OCScxP01VEZZgxak2Mvx3l5V3cS8d1yLQbITFISiS5+dSQxp7EiqtoxHTI+J
         XUiXh8SBqxj1M4SK6aFeEAdWdw2tjuhKg9+QaF8yK8E+Xke1cssNr6JPqfcMq/Kh/cIL
         VZ3A==
X-Gm-Message-State: AOAM5332gdBjPCZXSgBkI42eVHP8Hx5y/c38v76B9QYUAbsFaGXE/6y1
        ELv8hbJeYGVzvbNnUQqewMa0TrtL9DDqCRi6V4VmgG45f6k4bkn1XS4brR9ZqklW9hPk/j+p73b
        WJDHE0eLXj6Cy
X-Received: by 2002:aa7:c2c7:: with SMTP id m7mr1843695edp.148.1591784977995;
        Wed, 10 Jun 2020 03:29:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyONuhGdwEjNVp5/MHeIQq2YqTGeloLAyIipufJxm6fFunXScnoP/l40GwW3brG4O37+LwACQ==
X-Received: by 2002:aa7:c2c7:: with SMTP id m7mr1843684edp.148.1591784977690;
        Wed, 10 Jun 2020 03:29:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m2sm1072511ejg.7.2020.06.10.03.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 03:29:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4670C1814F0; Wed, 10 Jun 2020 12:29:35 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        brouer@redhat.com
Subject: Re: [PATCHv4 bpf-next 1/2] xdp: add a new helper for dev map multicast support
In-Reply-To: <20200610122153.76d30e37@carbon>
References: <20200415085437.23028-1-liuhangbin@gmail.com> <20200526140539.4103528-1-liuhangbin@gmail.com> <20200526140539.4103528-2-liuhangbin@gmail.com> <20200610122153.76d30e37@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 10 Jun 2020 12:29:35 +0200
Message-ID: <87d0678b8w.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Tue, 26 May 2020 22:05:38 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
>
>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>> index a51d9fb7a359..ecc5c44a5bab 100644
>> --- a/kernel/bpf/devmap.c
>> +++ b/kernel/bpf/devmap.c
> [...]
>
>> +int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
>> +			  struct bpf_map *map, struct bpf_map *ex_map,
>> +			  bool exclude_ingress)
>> +{
>> +	struct bpf_dtab_netdev *obj = NULL;
>> +	struct xdp_frame *xdpf, *nxdpf;
>> +	struct net_device *dev;
>> +	bool first = true;
>> +	u32 key, next_key;
>> +	int err;
>> +
>> +	devmap_get_next_key(map, NULL, &key);
>> +
>> +	xdpf = convert_to_xdp_frame(xdp);
>> +	if (unlikely(!xdpf))
>> +		return -EOVERFLOW;
>> +
>> +	for (;;) {
>> +		switch (map->map_type) {
>> +		case BPF_MAP_TYPE_DEVMAP:
>> +			obj = __dev_map_lookup_elem(map, key);
>> +			break;
>> +		case BPF_MAP_TYPE_DEVMAP_HASH:
>> +			obj = __dev_map_hash_lookup_elem(map, key);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +
>> +		if (!obj || dev_in_exclude_map(obj, ex_map,
>> +					       exclude_ingress ? dev_rx->ifindex : 0))
>> +			goto find_next;
>> +
>> +		dev = obj->dev;
>> +
>> +		if (!dev->netdev_ops->ndo_xdp_xmit)
>> +			goto find_next;
>> +
>> +		err = xdp_ok_fwd_dev(dev, xdp->data_end - xdp->data);
>> +		if (unlikely(err))
>> +			goto find_next;
>> +
>> +		if (!first) {
>> +			nxdpf = xdpf_clone(xdpf);
>> +			if (unlikely(!nxdpf))
>> +				return -ENOMEM;
>> +
>> +			bq_enqueue(dev, nxdpf, dev_rx);
>> +		} else {
>> +			bq_enqueue(dev, xdpf, dev_rx);
>
> This looks racy.  You enqueue the original frame, and then later
> xdpf_clone it.  The original frame might have been freed at that
> point.

This was actually my suggestion; on the assumption that bq_enqueue()
just puts the frame on a list that won't be flushed until we exit the
NAPI loop.

But I guess now that you mention it that bq_enqueue() may flush the
queue, so you're right that this won't work. Sorry about that, Hangbin :/

Jesper, the reason I suggested this was to avoid an "extra" copy (i.e.,
if we have two destinations, ideally we should only clone once instead
of twice). Got any clever ideas for a safe way to achieve this? :)

-Toke

