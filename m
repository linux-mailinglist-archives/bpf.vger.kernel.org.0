Return-Path: <bpf+bounces-49408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FECA18365
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 18:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DC1169853
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260651F543D;
	Tue, 21 Jan 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LfPyl5rg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B31F55F3
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482142; cv=none; b=dzIwRlYUutrf3xHXJ7SzGHBqb7BzNn6Gx2TNVQzeweWQbmS33MPPgaWxqWBLEyHtWHUve3WE8Iw9jRzgQycxQUeQQjJKwMcLol+em2AWEr02ql9tRuqtxP6lMHPhozQAn60K5IH8fDcRSN5rSOXiAH0LwL3YYXSqB03b6VWmqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482142; c=relaxed/simple;
	bh=8MGMALB53GqE7pr90y8ipkSuziOt45gftdneWPyARRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU6P4KLLRpt48WLbn/v3k941PGqXtWu42Wd3piQ35e48BQDSof1ykfcEwc6gPP+qevbdw2swIOHz5IRjOylDXUQqM8Y1Z90+Kk+uMlaEc8IDnhbbjUwSDtB8yZdLbI9zqWw7ycmQKgXZtRZl0OnpAXJ0M4afzVrogy9gPu7BR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LfPyl5rg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216634dd574so69939965ad.2
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737482140; x=1738086940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMp+ss6Wwfurnp42doFXEAGvsTfQgZrzB8Da9TV6zaI=;
        b=LfPyl5rgsPvy6zXcO6D4C7EaWDhA3YsYUt5s3PmXTXQNUBvRwT3X6VN5NPePPiTGHJ
         AasTMOxnZ3uhqGgFewGs8aJB2Pog45H924AQ9tCP+SKgxuFzyK8Al7ttkNph7aMgdrE6
         iG4080X6bku/uhVNzbbnUrKRv4hyWQcsrSu44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482140; x=1738086940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMp+ss6Wwfurnp42doFXEAGvsTfQgZrzB8Da9TV6zaI=;
        b=wn8S4LUgKtjHnCFSfzaP4dlE/tctrWfz+Za7Vfde4ey/AUa2hoY+J6fWC/wUATK29d
         VYpITTEqBBN7uX7/7PgC/ZnJme60XWKos98LlRGGKwRlv0d5pvi5hGH2EcETQnJPJaJh
         oldjKmU8cztPdBuUIQIusI8yvOu2FsgxJcvKosAqzoPuu4OEB/zG1efDAej9kyqOzATf
         YOXauCuTNH/KRbeKnZP7ZGgaZI4fHyOMDRfLAZ8Q1UWooTntSOY1EheTITh30gOCKrQK
         AkhRTHuOlHoU2Qx49YSqYkAmpnkNNKBeOTqGFFKQY0BmvT1ZvYKHlx8eaNzFyGgZ0zIH
         F8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXPvwUD5i5sesmfOnTKxdB10q2UntKuKcE2Pv4VcnJo5iD3cmQ+y284lHLLpfEnzrUV62s=@vger.kernel.org
X-Gm-Message-State: AOJu0YznlnALg9IHvMUu47moYPLu8cm7A1n0Apv6PfqMCtSKChZdM15f
	fAMDf+vpHKLCKSAXc7JtphnxjAai7P7s5JXUUlAqercfUmrlksSFfOIzB7obyVw=
X-Gm-Gg: ASbGncvl7m1C2BChx5A7v14YShNkMZveIBIQwRhsZYBtqlGCYXdUAynxqqRP7SX7lEf
	NRC6JCpusLziV+R9sF0U5q0ewE4BY7oH0boq5/mX38uf6/mfGTpIklalF660GlM9ow6oL8DQgh3
	nfLFW0v5JI7bKq6e+XZvzkPYltROq+xPeFhTJoVmKxmM69w48WWlROmWJIm3QXxizMibp8zXCvb
	NCC6vLrHxBuLNnchMMgp5HEFvMg2kARSXfcnMOWgEi1eTJyFVWo+kx7szzw/1GqboGkSLc3BevB
	+uL9cHHbyjZmlvbRYETvBDPwMc/a4ANoldUh
X-Google-Smtp-Source: AGHT+IEBgJwx8lqhufWVr68uCZoTqch8S1RN/wzFz2PZOPH5Pq/W0Y7Zk8vLb/9NhhAf19hQTQLs0A==
X-Received: by 2002:a05:6a21:4a4b:b0:1e0:c3bf:7909 with SMTP id adf61e73a8af0-1eb215ec91amr27186626637.41.1737482140313;
        Tue, 21 Jan 2025 09:55:40 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f0693sm9466532b3a.10.2025.01.21.09.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 09:55:39 -0800 (PST)
Date: Tue, 21 Jan 2025 09:55:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, gerhard@engleder-embedded.com,
	leiyang@redhat.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
Message-ID: <Z4_fmIsLgs3nWvOm@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	netdev@vger.kernel.org
References: <20250116055302.14308-1-jdamato@fastly.com>
 <20250116055302.14308-4-jdamato@fastly.com>
 <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtaaScVM8iuHP7oGBhwCAvcjQstmNoedc5UTtkEMLRDow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtaaScVM8iuHP7oGBhwCAvcjQstmNoedc5UTtkEMLRDow@mail.gmail.com>

On Mon, Jan 20, 2025 at 09:58:13AM +0800, Jason Wang wrote:
> On Thu, Jan 16, 2025 at 3:57 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote:
> > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > can be accessed by user apps.
> > >
> > > $ ethtool -i ens4 | grep driver
> > > driver: virtio_net
> > >
> > > $ sudo ethtool -L ens4 combined 4
> > >
> > > $ ./tools/net/ynl/pyynl/cli.py \
> > >        --spec Documentation/netlink/specs/netdev.yaml \
> > >        --dump queue-get --json='{"ifindex": 2}'
> > > [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
> > >  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
> > >  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
> > >  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
> > >  {'id': 0, 'ifindex': 2, 'type': 'tx'},
> > >  {'id': 1, 'ifindex': 2, 'type': 'tx'},
> > >  {'id': 2, 'ifindex': 2, 'type': 'tx'},
> > >  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> > >
> > > Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> > > the lack of 'napi-id' in the above output is expected.
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  v2:
> > >    - Eliminate RTNL code paths using the API Jakub introduced in patch 1
> > >      of this v2.
> > >    - Added virtnet_napi_disable to reduce code duplication as
> > >      suggested by Jason Wang.
> > >
> > >  drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
> > >  1 file changed, 29 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index cff18c66b54a..c6fda756dd07 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> > >       local_bh_enable();
> > >  }
> > >
> > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > +static void virtnet_napi_enable(struct virtqueue *vq,
> > > +                             struct napi_struct *napi)
> > >  {
> > > +     struct virtnet_info *vi = vq->vdev->priv;
> > > +     int q = vq2rxq(vq);
> > > +     u16 curr_qs;
> > > +
> > >       virtnet_napi_do_enable(vq, napi);
> > > +
> > > +     curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > > +     if (!vi->xdp_enabled || q < curr_qs)
> > > +             netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
> >
> > So what case the check of xdp_enabled is for?
> 
> +1 and I think the XDP related checks should be done by the caller not here.

Based on the reply further down in the thread, it seems that these
queues should be mapped regardless of whether an XDP program is
attached or not, IIUC.

Feel free to reply there, if you disagree/have comments.

> >
> > And I think we should merge this to last commit.
> >
> > Thanks.
> >
> 
> Thanks

FWIW, I don't plan to merge the commits, due to the reason mentioned
further down in the thread.

Thanks.

