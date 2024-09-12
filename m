Return-Path: <bpf+bounces-39723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087F976BD1
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607FAB21269
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF21AD9CB;
	Thu, 12 Sep 2024 14:20:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BDE2209B;
	Thu, 12 Sep 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150802; cv=none; b=SOneohNmOVnNTL65LvlWscPcd3LReNCH7Dm3ttzsD4pIm/qSdH1a3yw5pk4MKWeaeWrK7aHQUNVCCVwc8UHOqJsLLoh0iroBCdwGSLimA97y4FYsZ9mauqMFnL6dDrcU3RUop0qYNNKyzfKzTs/+1R4M3EZ/D6cZYz21El0OwpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150802; c=relaxed/simple;
	bh=4/3k8eSBLVRxWjjDz4zpjcNLnIc/Iyi2JVGo4hJT5vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ij8bmPdsRu2RM6kKluGVTy3Ptk0AaQszzGLIHjDXbAOGaoBrAbUYt6cZK6wGyUo1rHIBKO7BUFUpytIgtk64GbdupxJimZf99SvXpCdKb44PeiUv2kMLETMIM2L3GEv/s3jqRFiTxLSJlOMuLnBoUcs8grq+j/3f5dkm5w/TLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d43657255so148753166b.0;
        Thu, 12 Sep 2024 07:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726150798; x=1726755598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMB0zTs8cLiRSiVrxlZ0xkuyxGcJBoqexzlsqpyjifc=;
        b=gkzLGv5AS5XT94Ijp47wL4CFu461GyaJyKBI77n0JY/mQw2J4PqgjYXNYABISBCqWT
         c0IhdU3Dz10PTLiLyTISfzwjn0tiai9xKJtPfQuBxxGM4zyNp4oPS4FV+uF64G+t3UN7
         4oCSwd8lENmjjPUWrqy7FPSd0KGlImbQLqQf4ubq8c2dfnzHGVfwwaCTd10Dlw4p1FBZ
         BwfyjJLLCtqrHuMsvkaKAT3e527d6CIwRGmd6Lkd3YzFKUTb8PGuq59rCIxVDJX6doqp
         H6lAyd+YH0HStG83x/+uccsakomx5wyRt85uKAoHEJZ3WLl/ks1D0YFkrXzze6+S4xZ3
         kwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/BoKm5jcV9jnJREiFpmKkeRgMa9lyUFAhKwGtlh14gdDmyfQ27cvhPD0xBI6t6aTfln8=@vger.kernel.org, AJvYcCVAV5AvfZy8Y+NI2zR2eYnAkaoJUEkFIzkUhWM9841dNHXBhx76GtnZjVPIoakW6zplebaL2LD1@vger.kernel.org, AJvYcCXrf+BlAGTTTv96N7LygtvV1Ev2R284hyfyrQTrxGQWgkrGRL7JmXdp0XssPL33BIC8rhbI9ibGjC31F9ly@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9jPRoIw5ouaVKjYesBjAstda3wwWcFOjYgZvs30V9hxJySrV
	WbR474t9xHJW4TqHQNl5SKFknIq9tf5pYVCuuJCLlkrU98ujn6hi
X-Google-Smtp-Source: AGHT+IGVJBZNSgTp+xRvrjPYefM1Zf0fuwu6vuda7SmUnzN9agjv/WRe7/dOg5spQ/6xxYY3rjbnHw==
X-Received: by 2002:a17:907:3e0d:b0:a86:b042:585a with SMTP id a640c23a62f3a-a902970d12bmr277494866b.57.1726150797582;
        Thu, 12 Sep 2024 07:19:57 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9013376712sm197716266b.53.2024.09.12.07.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:19:56 -0700 (PDT)
Date: Thu, 12 Sep 2024 07:19:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>, andrii@kernel.org, ast@kernel.org,
	syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240912-organic-spoonbill-of-discourse-ad2e6e@leitao>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
 <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
 <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>
 <20240912122847.x70_LgN_@linutronix.de>
 <20240912-hypnotic-messy-leopard-f1d2b0@leitao>
 <9a2a1cce-8d92-4d10-87ea-4cdf1934d5fb@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a2a1cce-8d92-4d10-87ea-4cdf1934d5fb@linux.dev>

Hello Vadim,

On Thu, Sep 12, 2024 at 02:32:55PM +0100, Vadim Fedorenko wrote:
> On 12/09/2024 14:17, Breno Leitao wrote:
> > @@ -72,6 +73,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
> >   	struct net_device *peer;
> >   	int len = skb->len;
> > +	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
> >   	rcu_read_lock();
> 
> Hi Breno,
> 
> looks like bpf_net_ctx should be set under rcu read lock...

Why exactly?

I saw in some examples where bpf_net_ctx_set() was set inside the
rcu_read_lock(), but, I was not able to come up with justification to do
the same. Would you mind elaborating why this might be needed inside the
lock?

Thanks for the review,
--breno

