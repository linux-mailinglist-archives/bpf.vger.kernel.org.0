Return-Path: <bpf+bounces-12668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBBA7CF022
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7197281F36
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62026FD2;
	Thu, 19 Oct 2023 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kr2qbAmC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B8B46671
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 06:37:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED5410F
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697697423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7YGdF4c/ZFxSg9nV/ChxJMQEFQk8yK6EpVnN33SpoY=;
	b=Kr2qbAmCo4oHAF9mr+k25JCc1BdLnBLWcj+cy9SeYkkacigs/rudVGVUZrHBY0ibcOpwMr
	k747LVBkz6371kj1xg8fDY9+88lPUFVBLcv1Y1/l1ztEretf+3zE5Mj1sP8virmlP1SLlq
	cjMOuir0f6SNSxHJOr9trUh0STK/iTg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-bT1FNnUJPdmE3e46iW8EXg-1; Thu, 19 Oct 2023 02:37:01 -0400
X-MC-Unique: bT1FNnUJPdmE3e46iW8EXg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32d879cac50so4597672f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697697420; x=1698302220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7YGdF4c/ZFxSg9nV/ChxJMQEFQk8yK6EpVnN33SpoY=;
        b=WqTRtq8FR2gCfh1V28DwDNgwMlB1emiHtHvlXp8WX8fYUz1tAI/QD4kSfDeIMbE74/
         0I8LMwHRxNBKHaHz4lpT0lUrl+RIiq/f1ouf26s9MiAvUEH3KYprIZR8/vl5CtDIbiVH
         HpgTBTI6RfJ7XqiX3fE5D4U9ilUdro97sxjNKRXjqyCu7E+21Ljq684SGN4bjbmBRlci
         W4FrDbe4YDjloMZrG6E4dBYDr3mXb3V8nvyv9mxhnzY+Sv5mZYnkcYtV6eT7fdvel4og
         cWy1TfVU/3OET2SBT+TaWAiDFBZ3I+KXHjoOSo0kRBuiFpas29SN+JIaYJi1ZcqkKlys
         wyLw==
X-Gm-Message-State: AOJu0Yy8jnhaaEjiQKMQJfKyEdaCow65eOqB+xbhlS76CvnlpMB3TjTK
	8s8pYyZ1qbbEIrtZVVA8d3xyHh2cMTKyNnHmYPUjbBTUsKdXLheILUroJ+62sAVZ/1p2hY0avsa
	13RI9jEi8gZA9
X-Received: by 2002:a05:6000:1287:b0:32d:b081:ff32 with SMTP id f7-20020a056000128700b0032db081ff32mr625910wrx.38.1697697420033;
        Wed, 18 Oct 2023 23:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8iY58YnHTQToYzw01jGs6sEhJQ8nc4mS2k2A0gX5GvAr8vDJCYQUcwBMyolUVLl/6NSgiWA==
X-Received: by 2002:a05:6000:1287:b0:32d:b081:ff32 with SMTP id f7-20020a056000128700b0032db081ff32mr625899wrx.38.1697697419713;
        Wed, 18 Oct 2023 23:36:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
        by smtp.gmail.com with ESMTPSA id q7-20020adffec7000000b0031980294e9fsm3684591wrs.116.2023.10.18.23.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:36:59 -0700 (PDT)
Date: Thu, 19 Oct 2023 02:36:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v1 05/19] virtio_net: add prefix virtnet to all
 struct/api inside virtio_net.h
Message-ID: <20231019023548-mutt-send-email-mst@kernel.org>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEvQvyjxX7PKVtTjMMtQNX3PzuviL=sA5sMftEToduZ5RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvQvyjxX7PKVtTjMMtQNX3PzuviL=sA5sMftEToduZ5RA@mail.gmail.com>

On Thu, Oct 19, 2023 at 02:14:27PM +0800, Jason Wang wrote:
> On Mon, Oct 16, 2023 at 8:01 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > We move some structures and APIs to the header file, but these
> > structures and APIs do not prefixed with virtnet. This patch adds
> > virtnet for these.
> 
> What's the benefit of doing this? AFAIK virtio-net is the only user
> for virtio-net.h?
> 
> THanks

If the split takes place I, for one, would be happy if there's some way
to tell where to look for a given structure/API just from the name.

-- 
MST


