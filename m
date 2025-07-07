Return-Path: <bpf+bounces-62543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1196AFBA1F
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 19:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49743B35F5
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C44D262D27;
	Mon,  7 Jul 2025 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="divXgdqM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED722A7E5
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910677; cv=none; b=YBrBkSc3IBrkCYvaAJn5+5XuTauEXR7voD4OWBsZ93vr+Nzhkr6iuPIPxYdP0QzBVzGIAhGWRAUsLGmLWTLLSTDCNH3Uxb34flmV++RBxgz7upA2V7mNqn1q/3NKFlk9ih/0zyY+jsSyi/IBtFampnnNyhxa3+ipz5YvbOwnV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910677; c=relaxed/simple;
	bh=F+JhJDxpwPRwb3AqPuIfoAmEkRG3+2v7psK5Sz3fQtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cGyHvx+HdgbyQs7bjwnEcuslZv7K2LhrHW3xQVgbgHTBaue7bizU4y+ctPkLkUOBgGHX7MgPg3JyAXuovx5TIorT2bfUlXmhtqAeWAVo7PxgBXP5o6lCbBaIF7NLgMdyNQIYMesg/l4YMBSw4sO0VgIleQ1wrkdFs6Y5/aADFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=divXgdqM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so5702562a12.3
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751910674; x=1752515474; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAn8TiUso0gO9RetRg400m8uB5tG55kojEKoa6j8nuQ=;
        b=divXgdqMCYAD89ccasze23KPBr4ER1WSBazVrHBLvQXgG5vnurU65dXgPuFI9CK+3J
         BpVCnzbNA40QzaP6XsdbANM29bRw8am2SDmin5Fpj/hv3NCU4joSxzuvam5P8Ws2Kxyn
         yicbrt9e4yJWlIXT8rlPCcuxE0R3xuL5o7Lc98XbD6DRHFDa38ldtvr88ClcNjXXCoGt
         OHazWOuGwVQJb0ntdi/1Trxv4wV1EkFUdSjiR5niJGpYQs9tY4zCCriKYFCjRgSzKH3j
         Q2yUJ94CHtpfHR3rmr8EQEzHj3Y1msXfFsMLEa9/ziRI8YlGrFHTzT1/z6m/iSorP1y6
         UnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751910674; x=1752515474;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAn8TiUso0gO9RetRg400m8uB5tG55kojEKoa6j8nuQ=;
        b=D16LdFrfuXiAKLmqtG/z8RqAU57tZ/d+U4IpxI798d+MNk8ErASVdK7BpqJwKrwX2s
         Wrhl/+aJosuvoEGUKulCvr45HU/XT+ysPf0PZ+Z3zpPtEo1kgj+YCco5BDvkHeevYgfo
         O2/4uuPaNmyL7WFL4N7ANwttdC8eHrZgkh11s0j84Y8qMQOJhukMyKD6c6rzghKzQd/G
         1gHdv/TLHRUb1YWmk0UkRJZz2P7mgt9q/gQn35Unj4xiP5Z1hHOczLknoIb/CdLMMMkN
         Xv7mH8qjjqMA8LNywJdKlcmJ9YrxczcYKtJdgqYlWAayC0WdVs1a0R2czUnE0DLPh6mx
         ZStA==
X-Forwarded-Encrypted: i=1; AJvYcCVtHpkkmjlsgKr5mW1N8NoMnS19fX43ZDJZGdQGsRn9matdXmblqgyxqOno7RCddSj1Xf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweSo3gyhVA/szt7xyMCZBnisOZ2qufyEPciVUDoFcRZkBEVzF+
	Gn0JLdDkQv61rov08K37dmrX097+JP7nl+oC7MR3dQRO8nlOLBdDyrmfNnTJoAeSr6VXCyQwLbC
	wjvW0
X-Gm-Gg: ASbGnctzMe6Oms4OMo991nNIyvxoC+oqPiRLiJaPy6pCXy432SQRQS2jeElC8zc0FIF
	7fQdQumJfhdJk4/4Z5aPDxd6RjdklCLWPjD3i/vqAX1x0oUEPavO3+Ikj+2Wq+Sitr4IGpU62G0
	c7sJhPy+gjrT3+hbfemHXzlWtaQ/LL1cGLOx3tPkzbVJgFL4onoUyFq5lNtaICIuhc7khOkx/rj
	/WnmOX1Nuuua9kHZ8dX4Py36mUCwZTlAB0SMkrCNehCSMi4DjLjFmyRZPHy6i6WGJr12qtxec5e
	zHMrofnNoAg2jT1U56uLXrPKvcyLFVPXE+Sn11BXmw3KCFjLFaf8cuA=
X-Google-Smtp-Source: AGHT+IG1tNP4StDCMG4g6g7LF2lggkO7mUVU2/MdB6rvjG5teWxlng0i59YEXn+a5vSaoIJ65mAtUQ==
X-Received: by 2002:a17:907:3d05:b0:ae3:a604:b1fe with SMTP id a640c23a62f3a-ae6b069f406mr4937666b.38.1751910674228;
        Mon, 07 Jul 2025 10:51:14 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:7a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02f23sm750799766b.118.2025.07.07.10.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 10:51:13 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Zijian Zhang <zijianzhang@bytedance.com>,  netdev@vger.kernel.org,
  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zhoufeng.zf@bytedance.com,  Amery Hung <amery.hung@bytedance.com>,  Cong
 Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v4 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
In-Reply-To: <aGdWhRi/0KLTFL8k@pop-os.localdomain> (Cong Wang's message of
	"Thu, 3 Jul 2025 21:20:21 -0700")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
	<20250701011201.235392-5-xiyou.wangcong@gmail.com>
	<87ecuyn5x2.fsf@cloudflare.com>
	<509939c4-2e3e-41a6-888f-cbbf6d4c93cb@bytedance.com>
	<87a55lmrwn.fsf@cloudflare.com> <aGdWhRi/0KLTFL8k@pop-os.localdomain>
Date: Mon, 07 Jul 2025 19:51:12 +0200
Message-ID: <87cyabhotr.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 03, 2025 at 09:20 PM -07, Cong Wang wrote:
> On Thu, Jul 03, 2025 at 01:32:08PM +0200, Jakub Sitnicki wrote:
>> I'm all for reaping the benefits of batching, but I'm not thrilled about
>> having a backlog worker on the path. The one we have on the sk_skb path
>> has been a bottleneck:
>
> It depends on what you compare with. If you compare it with vanilla
> TCP_BPF, we did see is 5% latency increase. If you compare it with
> regular TCP, it is still much better. Our goal is to make Cillium's
> sockops-enable competitive with regular TCP, hence we compare it with
> regular TCP.
>
> I hope this makes sense to you. Sorry if this was not clear in our cover
> letter.

Latency-wise I think we should be comparing sk_msg send-to-local against
UDS rather than full-stack TCP.

There is quite a bit of guessing on my side as to what you're looking
for because the cover letter doesn't say much about the use case.

For instance, do you control the sender?  Why not do big writes on the
sender side if raw throughput is what you care about?

>> 1) There's no backpressure propagation so you can have a backlog
>> build-up. One thing to check is what happens if the receiver closes its
>> window.
>
> Right, I am sure there are still a lot of optimizations we can further
> improve. The only question is how much we need for now. How about
> optimizing it one step each time? :)

This is introducing a quite a bit complexity from the start. I'd like to
least explore if it can be done in a simpler fashion before committing to
it.

You point at wake-ups as being the throughput killer. As an alternative,
can we wake up the receiver conditionally? That is only if the receiver
has made progress since on the queue since the last notification. This
could also be a form of wakeup moderation.

>> 2) There's a scheduling latency. That's why the performance of splicing
>> sockets with sockmap (ingress-to-egress) looks bleak [1].
>
> Same for regular TCP, we have to wakeup the receiver/worker. But I may
> misunderstand this point?

What I meant is that, in the pessimistic case, to deliver a message we
now have to go through two wakeups:

sender -wakeup-> kworker -wakeup-> receiver

>> So I have to dig deeper...
>> 
>> Have you considered and/or evaluated any alternative designs? For
>> instance, what stops us from having an auto-corking / coalescing
>> strategy on the sender side?
>
> Auto corking _may_ be not as easy as TCP, since essentially we have no
> protocol here, just a pure socket layer.

You're right. We don't have a flush signal for auto-corking on the
sender side with sk_msg's.

What about what I mentioned above - can we moderate the wakeups based on
receiver making progress? Does that sound feasible to you?

Thanks,
-jkbs

