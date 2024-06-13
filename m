Return-Path: <bpf+bounces-32036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2242D906213
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81CF1F2241D
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C251512BF3D;
	Thu, 13 Jun 2024 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QjPistp0"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D5823BC;
	Thu, 13 Jun 2024 02:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246633; cv=none; b=SjSdfA891PthxYro7aFFHtGhNR8PerQ+/oga/rM2L4OmQu0IvZOjYi9e2kOpIZnWlWpXJGNkUzIGqlmqamrqa9klbrq+vUIgvi5aLi9K/F3a9a086nFIN1a0vL8v3jQopc9FgmC1TgB6AKCgac8YaLRP1ZcAosLM6oRi2gr3hvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246633; c=relaxed/simple;
	bh=BDOXNzHXw+WuokEZ6kz3twY7cl1UDbpPEkiQevs+WeM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=avICxbpJVm0MtKQ8S06A6s6ko2M2yoQJcuBcEzCGCWtAovuIBx55sLAGN6KVV4vnDreMSMcIut2+LWsVC+pcJwggoi0s5JMGPjJwKNPvFkUCJKuKxEpd1h8slAfyRMznDtZ4+tQHjyuK2DRpQlk9lgfMI/ohd2w8yUxZHpjcbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QjPistp0; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718246628; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=A6kTS9MeNeE2aZqwYJxigHp7EW8wWCd16SY6nb69V+Y=;
	b=QjPistp07K4f6A23Qlio9p5NPQNgC9INpSLh+G0JmQpGyODiHNdmbHt8DHHCmMHYUiWnmwovFH4TgtZw9DJQPcxiAwd5WZQpmdeJn3A4bVuDXl6eCs9fXvuJukltCNh/w5VJmKsgKFGyg0QhLA46GrzHmb0LBudCN9QxU1j5nnA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8MIj2n_1718246627;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8MIj2n_1718246627)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 10:43:47 +0800
Message-ID: <1718246617.4811053-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 11/15] virtio_net: xsk: tx: support xmit xsk buffer
Date: Thu, 13 Jun 2024 10:43:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
 <20240611114147.31320-12-xuanzhuo@linux.alibaba.com>
 <20240612162505.2fa3e645@kernel.org>
In-Reply-To: <20240612162505.2fa3e645@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 12 Jun 2024 16:25:05 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 11 Jun 2024 19:41:43 +0800 Xuan Zhuo wrote:
> > @@ -534,10 +534,13 @@ enum virtnet_xmit_type {
> >  	VIRTNET_XMIT_TYPE_SKB,
> >  	VIRTNET_XMIT_TYPE_XDP,
> >  	VIRTNET_XMIT_TYPE_DMA,
> > +	VIRTNET_XMIT_TYPE_XSK,
>
> Again, would be great to avoid the transient warning (if it can be done
> cleanly):
>
> drivers/net/virtio_net.c:5806:9: warning: enumeration value =E2=80=98VIRT=
NET_XMIT_TYPE_XSK=E2=80=99 not handled in switch [-Wswitch]
>  5806 |         switch (virtnet_xmit_ptr_strip(&buf)) {
>       |         ^~~~~~


Will fix.

