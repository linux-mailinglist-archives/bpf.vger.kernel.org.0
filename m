Return-Path: <bpf+bounces-52524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586C0A444E9
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C6219C35DE
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 15:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958BA188724;
	Tue, 25 Feb 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RP8Lr4zM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378D17E015
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498463; cv=none; b=a819+Sf/6v4LvRlcwSk28exODzJW/qLrZ384g91UTd5Q5RhjZcQfYhIpUVVO0lvDtyd1pZ4q9eyFMNJBSSP7VlkkAEtoXpstM4/AvGxGBkP0YNiwBLsHJAYCzhFhvQesz/JvKkSJ5C9lfLGjUwBVc8jjd7FD+F6cX5RaUrRamIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498463; c=relaxed/simple;
	bh=+hpEQsksCM2iTh+r9a0lvGWAIMgAZlsCpvFGoIX1BJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YU/lQBqnQAZfKOHcrxSVnn/RUgXT1tek38p0sZxJOa3KqM/c9RfEE/XMpjxdZ8qL5gfoLKdJAvwScYkY6ciIO0+B6Sk0m+1jZ2k5bizGVUqqoVVDMuYkYd7Xz6BIMN8W4OrA+bl4g+Ua+uEbpJToAoofB+8hdr10cTGQxDPFhL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RP8Lr4zM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740498459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLowiaQXcPjBLLsqA2QJq9sdnqXz83Xdngu5wIHqeOs=;
	b=RP8Lr4zMaQQg5oq4FjgAp58GR2FrHqCLQgjkw2YMI5kfkOWc5U4ENg1ZnoVmGHXmUetIix
	BRArrrR/kWLqpOHBzNokoiowo1tu1rUQgw3Q7YBqlvUqwj3A6AS/wbavYT2UL0lF/709U+
	R4eCR+mWJDJqHGSf0dTGpux9i/4YxnM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-H4xT9BlkMuC8zmKkKtmiVQ-1; Tue, 25 Feb 2025 10:47:33 -0500
X-MC-Unique: H4xT9BlkMuC8zmKkKtmiVQ-1
X-Mimecast-MFC-AGG-ID: H4xT9BlkMuC8zmKkKtmiVQ_1740498453
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5ded4b4ff88so5478062a12.2
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 07:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740498452; x=1741103252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLowiaQXcPjBLLsqA2QJq9sdnqXz83Xdngu5wIHqeOs=;
        b=DyxBs6nHYz3FihWLLlvhjX0v4nsxzYcXCQCsELwn0a5CSsi5nqGU+fTESvMNhl4q7/
         A9lnNtRi/azDnTTjnDaDbJFZ3qR6nMY1QNm0S/ZaoOg+//BaYprIO7A5jXK0TO4aMEvG
         BbkIIEK3NDpHhalELJ6wdHdrXBA8vipKWJPdHzBJFTa0+m+VGHW+UnWfyOd4+t+CrN71
         c8vdt2AxP5MfuE2omXsKM8AK50PO9n9s9Is19uyAyy0ketzfW8vueCSApze2/dm6gbaD
         SNMLvH1mswdMmiHYbTwFbW+2v9qT9MKhBEi0kpcdiSEAa+sckegEAf1Z3/7GpqX4oQ8J
         VBRA==
X-Forwarded-Encrypted: i=1; AJvYcCVd2d679AsaajyeR68M9FbJMUhGhAYTyTTVCi0Ag0PBaZU9FAvDH76eS8YugbBM9cmwffo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk9q/1Bn8GOkascOen/jnTYhSjDtMx7D0hc0liulOJPK/dRCsU
	pmIGKezZjg38kxn70Hu2O7s/5Jr3PXoupUFAq9X/DcfxE6q5CzxCIa96EbiiQ77cnxSDXRgb0O1
	xqzNR2sXd/uYWkLtjAC4Iea4nYA846lw3tcP4CiEokMOcnUgkhbf98RzWNfOMyhasrLekOJ5sFK
	jkCsmX97QmeY2CdAUSDRExa2CA
X-Gm-Gg: ASbGncvGVKkfkpIS1pPFfqCC1fKaodJ0BRyoOeXg4buM2jojQO0Bq0uCVfwDbJOMVmA
	dt6knCzoCVQtRs2kNuDgP66qQC7Vmph645hd2ohtrK8/B2iQdWMEqIcj0B2ZZ7/ugEc5Yn3UafQ
	==
X-Received: by 2002:a05:6402:3885:b0:5e0:892f:89ae with SMTP id 4fb4d7f45d1cf-5e4a0d49316mr52491a12.4.1740498452557;
        Tue, 25 Feb 2025 07:47:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhU8dArcNz7knBUveuwkVPq5cd7umRsmFiecLgZ7/6k9imQABOaWyFK/dDNV1CGGBckyZTblMRAxsXXO5bzfo=
X-Received: by 2002:a05:6402:3885:b0:5e0:892f:89ae with SMTP id
 4fb4d7f45d1cf-5e4a0d49316mr52466a12.4.1740498452137; Tue, 25 Feb 2025
 07:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com>
In-Reply-To: <20250225020455.212895-1-jdamato@fastly.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 25 Feb 2025 23:46:55 +0800
X-Gm-Features: AQ5f1JrHeeMYwYVuWDy8wtDZfVYsR07ZW6D64o1AlnpiaZi6PVCbCyH5tDufmyA
Message-ID: <CAPpAL=w7e8F_0_RRhBuyM-qyaYxgR=miYf_h90j78HzR4dvQxg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] virtio-net: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> Greetings:
>
> Welcome to v4.
>
> Jakub recently commented [1] that I should not hold this series on
> virtio-net linking queues to NAPIs behind other important work that is
> on-going and suggested I re-spin, so here we are :)
>
> This is a significant refactor from the rfcv3 and as such I've dropped
> almost all of the tags from reviewers except for patch 4 (sorry Gerhard
> and Jason; the changes are significant so I think patches 1-3 need to be
> re-reviewed).
>
> As per the discussion on the v3 [2], now both RX and TX NAPIs use the
> API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
> commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
> correctly elides the TX-only NAPIs (instead of printing zero) when the
> queues and NAPIs are linked.
>
> See the commit message of patch 3 for an example of how to get the NAPI
> to queue mapping information.
>
> See the commit message of patch 4 for an example of how NAPI IDs are
> persistent despite queue count changes.
>
> Thanks,
> Joe
>
> v4:
>   - Dropped Jakub's patch (previously patch 1).
>   - Significant refactor from v3 affecting patches 1-3.
>   - Patch 4 added tags from Jason and Gerhard.
>
> rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@fas=
tly.com/
>   - patch 3:
>     - Removed the xdp checks completely, as Gerhard Engleder pointed
>       out, they are likely not necessary.
>
>   - patch 4:
>     - Added Xuan Zhuo's Reviewed-by.
>
> v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastly.=
com/
>   - patch 1:
>     - New in the v2 from Jakub.
>
>   - patch 2:
>     - Previously patch 1, unchanged from v1.
>     - Added Gerhard Engleder's Reviewed-by.
>     - Added Lei Yang's Tested-by.
>
>   - patch 3:
>     - Introduced virtnet_napi_disable to eliminate duplicated code
>       in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
>       refill_work as suggested by Jason Wang.
>     - As a result of the above refactor, dropped Reviewed-by and
>       Tested-by from patch 3.
>
>   - patch 4:
>     - New in v2. Adds persistent NAPI configuration. See commit message
>       for more details.
>
> v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fastly=
.com/
>
> [1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
> [2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
>
> Joe Damato (4):
>   virtio-net: Refactor napi_enable paths
>   virtio-net: Refactor napi_disable paths
>   virtio-net: Map NAPIs to queues
>   virtio_net: Use persistent NAPI config
>
>  drivers/net/virtio_net.c | 100 ++++++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 27 deletions(-)
>
>
> base-commit: 7183877d6853801258b7a8d3b51b415982e5097e
> --
> 2.45.2
>
>


