Return-Path: <bpf+bounces-55633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E01A83A33
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 09:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3925B3B0C45
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 07:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EAC2046A4;
	Thu, 10 Apr 2025 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0thslPk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839A204C39;
	Thu, 10 Apr 2025 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268558; cv=none; b=llGr8MhASjSiU2S+PbQtfyrTThTNduveuwCjJlgqvSEi9fwvRQHaSF5bVTwgZer1pSaZ0ArC//RU58ADNuuTSA2vWIAX5gskH8lBA4vaggGk3TX5CvIgo2tjiJR7QtHHQL7HUpERZeqYnSQNQEXCIH9G//ZnQcrzJkGNVari4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268558; c=relaxed/simple;
	bh=2TX+VQKkEDPh4jVMYOB8FirTibI+S3VlTt0lpJQiw1M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fWCxR/LrJjYopo5j0fsl0DyS0Q3t6OQJAHJQmKi9/JKESauVUQp9sbxIiJpKtO7EnPpMtir1JiE6dnxE8lM49wdFlC18BWu8N5ooO+pQMrjftyYbTX0g4HadionfxYe9TnLv4PluH4FEqG64eoSqivA59mOksHwqGfWP1HzjY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0thslPk; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so425168b3a.1;
        Thu, 10 Apr 2025 00:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268556; x=1744873356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NK6DKsleLDedEDUoOJ6FfHyENnTO114saQVV2MVI27k=;
        b=W0thslPku+e69RSl8BIUJnJnmfGMkZFxvDxhXDoIQ6Wwf6R7YO4mmW/zhhYHKEqV6f
         QELLOp2tl1JSuhHSQSUaW9iv6eti068/1TqqNoU+eoofv3E7p8EuW8id1JLRYuMfj1AO
         s6mtpxD5cJV7hf0YdZ+0AJcVQVcdZtnQLP0djbvWu7ZHzHJvDquhlOLviJgbeeyfS723
         nEHHInDc1Z3NJ6dBsBX9UVeH+K75u4z1j4uN4PesUBv/zSLEy3MIUIGgyXm/nZwti2e7
         t47Q8Bd/n4CI9uTvw/gcpKI70fEA2tNMZ87vlXvu3Ei8UMEM7RyKLpF1onENZ+eNj6yM
         +lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268556; x=1744873356;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NK6DKsleLDedEDUoOJ6FfHyENnTO114saQVV2MVI27k=;
        b=qYdpO0+ChCk2BOiKXks+T4YMKkUNuQFLgbHOUg0Fr3WceT1O3bTmswdRCqHqfnhncq
         l7yEsgNT31Oc8IZaQstP+Xi6cgzsk759Z+liVpHZVaeneAWKoX/6wB7lG1YTC8U/drDh
         gkXxQm5iFaxJs5HTjFE7DEgB7MJWe8iwYZXnmROD95O3/9+bNFr/xIof5rd4OvmLlDGG
         wMz5rP+kOOicC1FShIpPT2+a/QCz6x5dbzQnTuS8rxBBnHSov05nzNzamgAdBmj/cUBp
         Kd1/Od0q9N261g6SCnVusbo/PKZX/0G/xNgls7x3VH8gOtpfWa9hVI+BFel6RmgKGbUa
         1n+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAO99zT5NqvZaEoWKGAKi0pDkh4JVgtOVQ401pwDaCrDvNr12v0H2yfpdH2izE46BZ+5/nT2sdpeRCRL3c@vger.kernel.org, AJvYcCXIrXYr3H7pwZ9LMLmTaFjwn8m1mQ6rlJv/bNqTKzHloWSVOZtGe2nM1igOWdtC7qZB97/HDvKY@vger.kernel.org, AJvYcCXcq38UwLXmm9Rsk6bm+UwnETysxRhSaAF4aMdHUbqzoh2mquxPBvFWPvBIlozLo6Ttlp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhKf2NWV723cB2/JWa/FKqSSxO6/iYEoxwDmoehpqNNxDot1m
	6IbF6HDroVCBaDuGM17eOz+cpoTCveCIu9xrQJ28HePI9IYmTY/3
X-Gm-Gg: ASbGncsbGok7SO3XfLcEIFXqWD3OTlgIQ0OExpkQAITl2epALHCHYvs6Qd6oNlF3Pcy
	lK+mT9C1h9szPg5PEetFR2vIn4W0Oq7J69e6CXFZU4bvY/5nCTI1LWhVMbUHTqjX/twftCoKW4Q
	gXAijeLz5YaQ7gN/+DMQmgvh8r7tcaSTn1LPdmzYXzERJaGvbuU/DWn8Crq/HMv/6kO7ofz4xXS
	vwUh1HHXJ6qnyUiLoVi0D91bm9ZLnXt4P9Qjtlw4hKWntC68SaSIliz/ThEAbDdzpRmnfULBJXg
	8wpj8GnVh91I/YHdbWrweawrFh1MJ9qO08qeQk8c/GlE/92maA2ipUPTB9DaoKhpmcKofw2I2Pz
	WOk/Iv4lXfvZVaaG8+Fc=
X-Google-Smtp-Source: AGHT+IHR7wErMqs6toXfdLAhBSnptfh78wJMNtMX9vyDLNp19zuG+N7r2GGC3hWvA1EXN0f9XAM0vQ==
X-Received: by 2002:a05:6a20:1587:b0:1f5:8678:183d with SMTP id adf61e73a8af0-20169480c0fmr3203289637.14.1744268556356;
        Thu, 10 Apr 2025 00:02:36 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1? ([2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a12c9c05sm2342598a12.42.2025.04.10.00.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 00:02:35 -0700 (PDT)
Message-ID: <b7b1f5de-7003-4960-a9d1-883bf2f1aa77@gmail.com>
Date: Thu, 10 Apr 2025 14:02:27 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
 <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
 <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
 <4195db62-db43-4d61-88c3-7a7fbb164726@gmail.com>
Content-Language: en-US
In-Reply-To: <4195db62-db43-4d61-88c3-7a7fbb164726@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/9/25 13:44, Bui Quang Minh wrote:
> On 4/8/25 14:34, Jason Wang wrote:
>> On Mon, Apr 7, 2025 at 10:27 AM Bui Quang Minh 
>> <minhquangbui99@gmail.com> wrote:
>>> On 4/7/25 08:03, Xuan Zhuo wrote:
>>>> On Fri,  4 Apr 2025 16:39:03 +0700, Bui Quang Minh 
>>>> <minhquangbui99@gmail.com> wrote:
>>>>> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
>>>>> napi_disable() on the receive queue's napi. In delayed 
>>>>> refill_work, it
>>>>> also calls napi_disable() on the receive queue's napi. This can 
>>>>> leads to
>>>>> deadlock when napi_disable() is called on an already disabled 
>>>>> napi. This
>>>>> scenario can be reproducible by binding a XDP socket to virtio-net
>>>>> interface without setting up the fill ring. As a result, 
>>>>> try_fill_recv
>>>>> will fail until the fill ring is set up and refill_work is scheduled.
>>>> So, what is the problem? The refill_work is waiting? As I know, 
>>>> that thread
>>>> will sleep some time, so the cpu can do other work.
>>> When napi_disable is called on an already disabled napi, it will sleep
>>> in napi_disable_locked while still holding the netdev_lock. As a 
>>> result,
>>> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
>>> This leads to refill_work and the pause-then-resume tx are stuck 
>>> altogether.
>> This needs to be added to the chagelog. And it looks like this is a 
>> fix for
>>
>> commit 413f0271f3966e0c73d4937963f19335af19e628
>> Author: Jakub Kicinski <kuba@kernel.org>
>> Date:   Tue Jan 14 19:53:14 2025 -0800
>>
>>      net: protect NAPI enablement with netdev_lock()
>>
>> ?
>
> I'm not aware of this, will update the fix tags in the next patch.
>
>> I wonder if it's simpler to just hold the netdev lock in resize or xsk
>> binding instead of this.
>
> That looks cleaner, let me try that approach.

We need to hold the netdev_lock in the refill work too. Otherwise, we 
get this race

refill_work                                xdp bind
napi_disable()

                                             netdev_lock(dev)
                                             napi_disable_locked() <- hang
napi_enable() <- cannot acquire the lock


I don't like the idea to hold netdev_lock in refill_work. I will reply 
with the patch for you to review.

Thanks,
Quang Minh.


