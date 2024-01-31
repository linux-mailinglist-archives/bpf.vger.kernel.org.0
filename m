Return-Path: <bpf+bounces-20793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF526843A8D
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 10:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D78E28E5E9
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ED867E97;
	Wed, 31 Jan 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P85JyqGO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A11467C51
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692344; cv=none; b=cm7er8RxRvxTEyEaWbsArlN0JEBRJj4U2g3zFRmTzbv3ZMDI3dVdqTumkrqJ31lb0B2WxvJy8JDY1R1mXE03vuo+QR9/F6KI85Xnmd7SYUIlkC8rfUbfMIXDmAf9f4Jc4KXgWYZc5vH244EBY/R6HF+iYKhN2BQvYz7Ldu5QmOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692344; c=relaxed/simple;
	bh=F+LXEdvariXw6k3eT3r4qbtwZoi+V/LnKUO9+lO8CbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/Yp4tMc+SsjDImdktrlivN7PKEKtF9KDMLrMJInHJomXeul0pz0rINevOe3mWwIoLb0IkFV/5HvIDHe45sw36IbXnKKUDnXUXp/sLTYoNlNNbKE+HpVMAW36H+UEypoiLNFkYGc6Zhk7IINCWqyQ1BPOgMf4q0kxmH45O/z+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P85JyqGO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=;
	b=P85JyqGO18V/9vsqEqCm/9ejvbQdIHCQJSBKRW3ZRgonG2DHOWk4IHAg8AzvoHhjfeCFLe
	kfBcBPbpUXAIPKowmIrY8ww/PF0gGFBEWS9ODtN/XC/bVHS2uhx/vft2qS3gh2rW8U94VO
	hmNCFTcozZEfggsdNOjRhwl8FhBkpU0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-OhXqI-97PwiCTFwD-fpvjg-1; Wed, 31 Jan 2024 04:12:20 -0500
X-MC-Unique: OhXqI-97PwiCTFwD-fpvjg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6dfc22e98ccso545731b3a.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 01:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692339; x=1707297139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=;
        b=IO4JDjRvrF8RamjOOLhkOVnKmQqMVnnNFJRVnyEuHA8UKenQimRIS/fN2pAviSxfjn
         4AjSemnDAJdeH0nMvw7vnAvnpMCGmp1/4k+lLW5TyjQnC4nmxrlayATA9EjvlOhDjkzA
         G7cyBBUepwpf3a6ZLuESwMxcxl25m7oK81LasHR+6rE6N3F531fKi9spb6uhgbl+m1iM
         VhcnVL/MxuUu11WRtMqhcjD1/fmrmKUs2bsMcnZRd3wKez4CvTBnLRfua5V9sF1bqQHr
         FOTBRUbbP7sSZNBPdHLeQFcREUzLpe0TwZHdPfYKFX7gCooFEpT2upCswaMoq8gd0VgX
         79+Q==
X-Gm-Message-State: AOJu0YwTQ+Nuqarp8xlW6/DamVWnWx0KWOHRbMwBiJsl1Tpxy0NMV+Ck
	gviOzfiV1ZEZKcLhkg5agXqn9n2THt3lVUAStiVNHxQqgl6f94rXyOeOjv+elTCUEBJ4z+P3JlI
	53UQ4y1rRMGecu3xErDLL3lH2PCmzevN80s7clxCiZGSxYhJDxxJHLnKz0FEarqpiMKAlzBIOLc
	xsxfomV8KhUChReeOCy3Y0zTjE
X-Received: by 2002:a05:6a20:9c97:b0:19c:93ee:b0ad with SMTP id mj23-20020a056a209c9700b0019c93eeb0admr1177487pzb.31.1706692339190;
        Wed, 31 Jan 2024 01:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmM479Cl5hy9Rh2S2MeFkPZK97XeCIQ/W+WuJDw6bc/3YGrYz5ABB3TPxpsK6OFnyn5gpDGlLKohRyPGIa5F4=
X-Received: by 2002:a05:6a20:9c97:b0:19c:93ee:b0ad with SMTP id
 mj23-20020a056a209c9700b0019c93eeb0admr1177464pzb.31.1706692338808; Wed, 31
 Jan 2024 01:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:07 +0800
Message-ID: <CACGkMEsi4B7Rz7Uu-3sTEH=9XRBRDmNSacZkVt6zxaC-FbYqhg@mail.gmail.com>
Subject: Re: [PATCH vhost 01/17] virtio_ring: introduce vring_need_unmap_buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> To make the code readable, introduce vring_need_unmap_buffer() to
> replace do_unmap.
>
>    use_dma_api premapped -> vring_need_unmap_buffer()
> 1. false       false        false
> 2. true        false        true
> 3. true        true         false
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


