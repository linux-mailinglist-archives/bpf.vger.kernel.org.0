Return-Path: <bpf+bounces-35252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A1F939393
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC3C1F21D82
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3B170849;
	Mon, 22 Jul 2024 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="K9k5PKf3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9416F29C
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672804; cv=none; b=SmsX7HeDJau1rjJnMMUfx3G3/IKTjj8XKJ0KIcEVZOomixzm4SETY0qLPuO/EV04QnMGaDLTMXFrOPUHu0vkxwV/l4+iozW91BV7mXWfFxnT9i31DNTFO32RJAtQNu8o4lMUtfyeC4hIduHBaGI/H8ucQvkD3S29QaJvdLOICgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672804; c=relaxed/simple;
	bh=/Nh0wjJ767d1KK/OMmJpj7/YnfgAxBifscTRqTXRU30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQJkVo1xrMnDAqlf3U2T2+bcT0BGr95EacccsUcC7yLjmlYzBky6VC2PnplA8PUqBOa5beXM+kcIMZiCP/J/0AS81QOh9XP6Cxkp+/lHBySm6nZDkJxNz3ZhY3hfZwDXZLtZqT3QPFerAhFNA1jbHilfXSQCtqCmGUGXOdyqpDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=K9k5PKf3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d153fec2fso1561137b3a.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721672801; x=1722277601; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9biYfsdlWUFfa2uPahdEjhFynqs7UpMUrewmhcvPcXA=;
        b=K9k5PKf3A7dMWifgWJ5RA3iUC40pPyjmeM/z+makPkiL0wa4mOrQP0Gavl58z/UVHj
         htwrL9x90+Qmt8SZt57oTYfv3IVu5wJYJJWJLBomeZULk7387LQa8qpP02C+kkXDMXEC
         7rWkLgWbZB7GZwi36/F5r+tQxl79VK86g/ycI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721672801; x=1722277601;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9biYfsdlWUFfa2uPahdEjhFynqs7UpMUrewmhcvPcXA=;
        b=ehfEMy/JfoDtpVqitZ/YDDEYs0ND1Bk0TpsdCzr9/ZNQTVEimbq7B5Va4zTiEHN9zu
         0IAqRYN3WA8rttixGtj6OapY0mLnV1gsLUN0MC8JfrRgdwmox3sPYC5ObxwwrueRleA0
         Kf6peZGlN0gCF8IXRHrn7Z0hjvjMG+ETRTpRkzh5Zh0zt8hrcVUKmg0xZ7V8CXVTcWVf
         SSniGtOASlT5yycuEzYeUp6dlnVWhad7JsSoAqDsHm5Kbn4/QIOVqA4shBY3v7TqY+Uy
         PkTc/IL887yUXvRK7hMHBX1DdiLuDk49Sc8gQHTFc+6AWpBw11+KmaDsmfLZXsm+jMsx
         2XCg==
X-Forwarded-Encrypted: i=1; AJvYcCXD8chG6hDCU/aGSSi2Lpr8KNY2177u1XH61yJUk6D8iB8F8Vig1JZ7gBK9Efdz7erNCxXetFzcASsHE3pUV19jSKZa
X-Gm-Message-State: AOJu0Yyi6awBu1DzD5D++dpQ/UW1cRWD/vEg6iDDUCf5qhk6qF4wJCsN
	uimSg14mJ+9/FdShLX5T5tb8j/RAl379ES2RPBb7HqYSd7W6ma+EZh3TYZLUDYI=
X-Google-Smtp-Source: AGHT+IHHHCDBMnxogaNQNY0v9bDW89ARG24TCy7ngJQcYGVhGfiHTIWN+aI+488Iott9h8yr0vfjFA==
X-Received: by 2002:a05:6a20:cfa7:b0:1c3:b239:83e2 with SMTP id adf61e73a8af0-1c4285b767bmr9863586637.12.1721672800827;
        Mon, 22 Jul 2024 11:26:40 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f48f3ffsm57826685ad.285.2024.07.22.11.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:26:40 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:26:37 -0700
From: Joe Damato <jdamato@fastly.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: daniel@makrotopia.org, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next RFC] net: ethernet: mtk_eth_soc: use prefetch
 methods
Message-ID: <Zp6kXQkiOOI2IPT2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Elad Yifee <eladwf@gmail.com>, daniel@makrotopia.org,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
References: <20240720164621.1983-1-eladwf@gmail.com>
 <Zp6GGzaJXhBcnGkC@LQ3V64L9R2>
 <CA+SN3soUH9dxAkKD8AB64Ay48T=Dj-QFftMoMLZfVGH+Q1mjzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+SN3soUH9dxAkKD8AB64Ay48T=Dj-QFftMoMLZfVGH+Q1mjzA@mail.gmail.com>

On Mon, Jul 22, 2024 at 09:04:06PM +0300, Elad Yifee wrote:
> On Mon, Jul 22, 2024 at 7:17 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Sat, Jul 20, 2024 at 07:46:18PM +0300, Elad Yifee wrote:
> > > Utilize kernel prefetch methods for faster cache line access.
> > > This change boosts driver performance,
> > > allowing the CPU to handle about 5% more packets/sec.
> >
> > Nit: It'd be great to see before/after numbers and/or an explanation of
> > how you measured this in the commit message.
> Sure, I'll add iperf3 results in the next version.

Thanks, that'd be helpful!

[...]

> > > @@ -2039,7 +2040,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
> > >               idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
> > >               rxd = ring->dma + idx * eth->soc->rx.desc_size;
> > >               data = ring->data[idx];
> > > -
> > > +             prefetch(rxd);
> >
> > Maybe net_prefetch instead, as mentioned above?
> This is the only case where I think prefetch should be used since it's
> only the descriptor.

I think you are implying that the optimization in the case of
L1_CACHE_BYTES < 128 is unnecessary because because the
mtk_rx_dma_v2 descriptors will be too far (i *
eth->soc->rx.desc_size) apart to get any benefit from prefetching
more data ?

If my understanding is correct, then yes: I agree.

> Thank you for your suggestions

No problem!

