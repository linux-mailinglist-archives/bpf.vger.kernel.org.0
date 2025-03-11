Return-Path: <bpf+bounces-53822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB5EA5C2FE
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 14:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517BD3B1673
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4581D47AD;
	Tue, 11 Mar 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KC15dZZJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494DB1CB9F0
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701000; cv=none; b=VB9nmfFSq1NH3son//BvjbuqL3+YT2ePkiJFdaOFRZu9Yl5SuX1beVHep4ml8i21XMe433rygeWQ2XQjqsJo+b1OaHTBOVww7JpYbDUAEJi8SILzh3rhmbUgdq8ccZsMdXpcjoUvUF/3KE/GlqZPWcd9/TPk/2IEaRzKgoqExlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701000; c=relaxed/simple;
	bh=t8KdbrMWsBJoQO4Ni60EZLRVIhCtaTA8841O4/7xuss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4mARZXFI8YEcW7MXwbxLJXumXeVyO9kmQ20asMirSPE540QRjqG0G20eCDFmi5knj4EjJFI9LQ/vuraHSSciQfyo3Xocp+1OftYcyZt+DNDSthBMY3xWhsoxtE7Z13WqGtmGnXG8sdoPkk1ziJX/zEYibJH7Dj5Z7ecWBkaVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KC15dZZJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741700998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgsr7jgTCRZ8U9QpOqMiuWp1S1JgO2ELwRf3Vztw4nc=;
	b=KC15dZZJC2OjLkoFS14Luw2DDOs07JLRNQ9sweNLGCk7brh5eDiTANrOfGZtp+JGXW6zUD
	249k5aUtSIPKtlTeivsNRkzKys2VbMopTEGka8QoF54QsGxryKXGXV+1yrbuWDIyPdloAA
	HIvqkLN+rXqeIePalVCy3OO9+V9kq7k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-4Kw_gfBfPcOibJZ9OVLkzQ-1; Tue, 11 Mar 2025 09:49:56 -0400
X-MC-Unique: 4Kw_gfBfPcOibJZ9OVLkzQ-1
X-Mimecast-MFC-AGG-ID: 4Kw_gfBfPcOibJZ9OVLkzQ_1741700995
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394040fea1so27288325e9.0
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 06:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700995; x=1742305795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgsr7jgTCRZ8U9QpOqMiuWp1S1JgO2ELwRf3Vztw4nc=;
        b=TuLx98TkZ/yuWkvgAhhLaQoLUp5pFZ5ML7Dr47JwzPN+L9Sty4KRklKcHWb/rufk6i
         gOdTL0I5nPp0Ip2NI6NN9IqXpi9sDHVCmM683fwXG1EtoiVKbeRV2gTxRBqN+QX0JORz
         590Ay8MYLlukYOeVzzJAmFV/uawAwQA+zLhggFG/jSWNa0PWL3HxGGKdyiDsF8nJND2q
         bFbhkgrWsVZ8uAGa3n16t7moYrfZW5wRdCK2BWJjwCSnDGfKvw1gXMAJ1QwLU2+gZ2cF
         xgCf9aKCuB2yCSE3jkbc3QwQI6kHuH2lDZ9vatGAb7fi5USeSsD4Me58fNeJZ0P2SmRz
         zT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4YZDzr1pAinfS/RplC42KJnXM9WedG6PUWlsMieXxb4xWNTXajlJgbWMTgzeVO2SLPPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO9fvT9AfjP5AzRRP5Viy5R0KXZ9BPs5rS1nXE1yR9X4tzEHX8
	bwp8opsbMLyKTJL/xE/GN3pp+vJ012iwWwe6najmzASpuKSE3gImjOWHzqSGLvXGjaykRKCJ69L
	kdeImqFs0NPziQm3QPmGWELqaEGt4XMiHEux/H6Q2E8wFarU8aA==
X-Gm-Gg: ASbGncuSEo+yANHSJv/16hy82VTwLlSjxhLLz3Ud0tT9NW5Pu/g9jeM0B4SYrkSpl/V
	mFfjKv4CgUTwcOaxUwC3hKVwuxQK0eMVo1lTiCO3uOXZEAEsXHVKQdiOT6pAf4gPHA3wUz+7+iS
	+EesMFqEyiwrmWPooTbBUkHLmRyrVQ480KikviJiCySMcAtNEHBoLdfT5MBE6rYpdNvBBqXKsjT
	dbuPTpG72XlbsbzsJ1bcrjvf7oLOWFGArvgTQ2zN7wDZUGhCmzxP9lByA/ebxlLPqvdQkUsRcdf
	/tgo3cuYOS3nz161WA==
X-Received: by 2002:a05:600c:4810:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-43d01d0b53cmr46484085e9.3.1741700995547;
        Tue, 11 Mar 2025 06:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Hv1NOnvAcp4QoD/nLfHVoFJo/dM1I2YUVp0fFSStDz79xkmC33u8lgWGfzJ/p17KRXTCmw==
X-Received: by 2002:a05:600c:4810:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-43d01d0b53cmr46483615e9.3.1741700994925;
        Tue, 11 Mar 2025 06:49:54 -0700 (PDT)
Received: from leonardi-redhat ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d020b7e5asm30877635e9.22.2025.03.11.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:49:54 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:49:52 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <4pvmvfviu6jnljfigf4u7vjrktn3jub2sdw2c524vopgkjj7od@dmrjmx3pzgyq>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>
 <vhda4sdbp725w7mkhha72u2nt3xpgyv2i4dphdr6lw7745qpuu@7c3lrl4tbomv>
 <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>

Hi Michal,

On Fri, Mar 07, 2025 at 05:01:11PM +0100, Michal Luczaj wrote:
>On 3/7/25 15:35, Stefano Garzarella wrote:
>> On Fri, Mar 07, 2025 at 10:58:55AM +0100, Michal Luczaj wrote:
>>>> Signal delivered during connect() may result in a disconnect of an already
>>>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>>>> been placed in a sockmap before the connection was closed. We end up with a
>>>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>>>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>>>> contract. As manifested by WARN_ON_ONCE.
>>>
>>> Note that Luigi is currently working on a (vsock test suit) test[1] for a
>>> related bug, which could be neatly adapted to test this bug as well.
>>> [1]: https://lore.kernel.org/netdev/20250306-test_vsock-v1-0-0320b5accf92@redhat.com/
>>
>> Can you work with Luigi to include the changes in that series?
>
>I was just going to wait for Luigi to finish his work (no rush, really) and
>then try to parametrize it.
>

Here[1] I pushed the v2 of the series, it addresses Stefano's comments.
I use b4 to send the patches, so one commit looks "strange". It is used 
by b4 and it contains the cover letter.

It would be nice to send both tests together, so whenever your patch is 
ready, feel free to open me a PR on github or send the series directly 
in the ML :)

Cheers,
Luigi

[1]https://github.com/luigix25/linux/tree/test_vsock_v2


