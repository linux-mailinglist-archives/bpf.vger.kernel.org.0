Return-Path: <bpf+bounces-62366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE6CAF8657
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 06:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F42367AA0CD
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 04:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404B189902;
	Fri,  4 Jul 2025 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5J2JWAO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81CC7F9;
	Fri,  4 Jul 2025 04:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751602825; cv=none; b=GuhSH50eVLorxsm4cYkVPRK3MB5fl53vnddtc9xFJFD7fzj+FU0yyRQE9W3OWvUXoqrTi+Ck71qV4uSxG2QJBBjAKEMYOTgdKRbAIHwjxiKuFWkyMnUQoEGa16CdrWHgkqI2NAaOXjjeOqsGIiQwrKJMQ+bl8rHW4XYkWxfUvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751602825; c=relaxed/simple;
	bh=x7SM63b8KQmpbjCmYSiUefEKaW16JcGJwkBkoU0SLnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlycGcRc0xPNKf4UQ9BcUvsGfauMX/yFdPeqDazAycij+hwILVMLYAPqWL40RG0pNLX8TA2H12rr/5NUwIM97lX+6OhQ/adpU5sNXYeKsasic9JjYGunKtAsFEpC9DS3PsxiZU5LmTtTIHZYqFzFh9J27s42Q0BJLbocW9mXSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5J2JWAO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234b440afa7so6690675ad.0;
        Thu, 03 Jul 2025 21:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751602823; x=1752207623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hhOHwcSI7KKOfLUHNfwEZ43vAqqpPQEYrNXVZKjCAZ8=;
        b=M5J2JWAOXvKy9b86KqPH9sbupbRXtYdNNTWIOvzTf+khuCdSUOqb9kL0yyMQLslFrx
         bohkT2t5slTbUHUfBIYCIIg9ZCqpXwJE5ZQwtwWZ7cFC2c5X5L6+dhgMQZV+gBNLWQlo
         /bYHIyc+/ocHn3hWF75xu9REw0/REUMxKtL35g+hOznX1lbAAL/o4ypuH51BJD7963Ea
         opDOQK52eV9RMSsojtQdDsu6Emiad5EfScOvrsvlrgMNbzLg4byGEltqkZuE6A9FF+uL
         a+pyImEPUCczS4jsIFbOa+gLyHh923LQ+tP+fclhvK99oRP8ffhY7dHTiQOQzc7dURCp
         NdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751602823; x=1752207623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhOHwcSI7KKOfLUHNfwEZ43vAqqpPQEYrNXVZKjCAZ8=;
        b=sdVlOuT5GEfK7+1HhLCmdlfuxRHgRIEVpE3LzUkmw4gpnOUYggJMBLe3ZE0I53URO3
         +MtH+LvNmG+O4sxw92LkbEdh4Bozji2YlaAy2fIl5TfsAwlOrGBQBvnYrC+A82yjhT97
         53hMb8kiDWMNPaigshXoBQQUgwfumckOqkh7BQfAd0i0T0OMjQKFed62UHVIhaRvyUfn
         28Yr5T34F8Q178Kwy4acVyQcCNKXcPvo2BpCizbc3ot6l6SQc5eVrjjkcNi7jidGfxPP
         ef0jky4pRVsPxSfJrk8rUCs2J/0K6nBzM4y37T+ITI0t2lrcBsNPxmOzbKutN7G5EvSh
         JpXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9IDfrUmttHk7JV1xF80mi+BiTBpjWvb2uflvOCnbypuhl+L1n11qo4jdu5RQnRUvq09g=@vger.kernel.org, AJvYcCVDz9A8Pw8SDIF9B3fNELdaHG/EmhT5EBzmFeRr6ASGCiKkubCfKj8hJ9nulLQdxk3T+5kN4L2s@vger.kernel.org
X-Gm-Message-State: AOJu0YyG/zhBCeD26M/P5t/5gYQF5Cv/xJQeVLT62j5ESVCGSWvuyPVU
	mjvCWT9P9XVEPR8nVVA+nOV4Img+Iy/fPiWrseHhjJeMTWvyKp5iu3T4
X-Gm-Gg: ASbGncumFzqQqAegAFyeTzntaGAFhrpldUkuYpUUuyGkQDpriYOaIhNl6wnwx+RUmMJ
	e4H/Ri28pTuBvFV+0jlZ3/TAzvK+iFZC7/zunJ0gR1eq0ECQojt70C+PJufL2pynnHy7rHDod5P
	MeHT0yKJclujtxbjC734zeT+kh6xu+sN8BtTh5sKtG5htpYpchevW11eum6SvKa0ga6CkV8wOEH
	BAIW1jD5WqLup6fjVih5CMNSPR/Pph/jt20dpCzacyt7mlNTY/0TP3KSf2m9z1nougoZEh0d3MX
	DSLFjbZYKdhpg7jj6eqJJTiAUhYZZwVIqWvmrllTraiSbqcsBWWaKoxwC3TgwZpMnx/t
X-Google-Smtp-Source: AGHT+IFspVM9gU7mkEm2eO0bOg31pGQHZiZrUt5OWxCj/JvEQnijuIy5rByG18YeGPiL51qGfnBiYw==
X-Received: by 2002:a17:903:291:b0:234:cb4a:bc48 with SMTP id d9443c01a7336-23c860d4fbfmr16355235ad.31.1751602822863;
        Thu, 03 Jul 2025 21:20:22 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:1aeb:7d0c:33d1:51f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431e15dsm9182205ad.36.2025.07.03.21.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:20:22 -0700 (PDT)
Date: Thu, 3 Jul 2025 21:20:21 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Zijian Zhang <zijianzhang@bytedance.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, john.fastabend@gmail.com,
	zhoufeng.zf@bytedance.com, Amery Hung <amery.hung@bytedance.com>,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v4 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
Message-ID: <aGdWhRi/0KLTFL8k@pop-os.localdomain>
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
 <20250701011201.235392-5-xiyou.wangcong@gmail.com>
 <87ecuyn5x2.fsf@cloudflare.com>
 <509939c4-2e3e-41a6-888f-cbbf6d4c93cb@bytedance.com>
 <87a55lmrwn.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a55lmrwn.fsf@cloudflare.com>

On Thu, Jul 03, 2025 at 01:32:08PM +0200, Jakub Sitnicki wrote:
> I'm all for reaping the benefits of batching, but I'm not thrilled about
> having a backlog worker on the path. The one we have on the sk_skb path
> has been a bottleneck:

It depends on what you compare with. If you compare it with vanilla
TCP_BPF, we did see is 5% latency increase. If you compare it with
regular TCP, it is still much better. Our goal is to make Cillium's
sockops-enable competitive with regular TCP, hence we compare it with
regular TCP.

I hope this makes sense to you. Sorry if this was not clear in our cover
letter.

> 
> 1) There's no backpressure propagation so you can have a backlog
> build-up. One thing to check is what happens if the receiver closes its
> window.

Right, I am sure there are still a lot of optimizations we can further
improve. The only question is how much we need for now. How about
optimizing it one step each time? :)

> 
> 2) There's a scheduling latency. That's why the performance of splicing
> sockets with sockmap (ingress-to-egress) looks bleak [1].

Same for regular TCP, we have to wakeup the receiver/worker. But I may
misunderstand this point?

> 
> So I have to dig deeper...
> 
> Have you considered and/or evaluated any alternative designs? For
> instance, what stops us from having an auto-corking / coalescing
> strategy on the sender side?

Auto corking _may_ be not as easy as TCP, since essentially we have no
protocol here, just a pure socket layer.

Thanks for your review!

