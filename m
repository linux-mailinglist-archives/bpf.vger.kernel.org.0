Return-Path: <bpf+bounces-61083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB7EAE0871
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 16:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D03E3AD1DE
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02FE1F875C;
	Thu, 19 Jun 2025 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcWOWZ/p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F261386C9;
	Thu, 19 Jun 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342634; cv=none; b=cGqvM/c+l7GH065in4jnJ2u7Gd48HUZe0FbnZMg+AS0jU4bF23o8ko/WE6xunEVi4RiC2ScI3Uo64af3n0DjDkn3oyRGLO0UUuVqwco2OZuNS/nPOKeIjW0BBZtgMmKULKcUzCTJ5ir04a+KICDvj9wZjzaNqZGNm103T6gsO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342634; c=relaxed/simple;
	bh=1hirRnewnVTSaRWGgBit3cpzA+mUHqZUrx6XP1uGhbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YB4FJMbNU69DrhpwxcJXpjzINWwu2XHYg3Qy9h7kPfPpF4Al12f9y3NwWCkQ2NDDmHtmAQrFLzW6nWG0Q5sxmv7LVrvcUGmWs++k8rYQ5cyapqQsXVkgvqKA7nSM4Q3KDxwgzyKYbpAyOw/RcEaMfNqF76He7N4rZPy+cYPpJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcWOWZ/p; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234d366e5f2so11116895ad.1;
        Thu, 19 Jun 2025 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750342632; x=1750947432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hs5sTPL4UKP6A3I0eYJSr3E+nHFf8KogN1avtTdVl5M=;
        b=NcWOWZ/pIlootJttCZS4IvNqUcvWoBuEKqWmrPnRKmmCE4PmDbFeQWwvQA/5z0R/gb
         fFGNV7VSsX07G30xzBFWmkUqFzWcHiC6jPkXYKgoxHziT5rAkFZvA4u250VRCk/iDV2p
         Rii26RJlnJGKvPE81SluN8IScByS04wza0mU6xXbeWUY6lqVv/9r/8opGIjVTdatAFpP
         uMroSexi7n9sPG2rMilxN+PzmkUPtqVWGc0E3izwOwXz4jweQB8AOz7A2X7dXOPDukuc
         7r+y5RkiOKRq630Z69Wh/cE7L/e5dP1x8v/R2Fwj2aomnSCtqGWZesSTAnnajAR+QVKf
         gLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750342632; x=1750947432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hs5sTPL4UKP6A3I0eYJSr3E+nHFf8KogN1avtTdVl5M=;
        b=nJ18xCaxILh9PNFKBzCBNt5zrgY5K/DqtTyyF6HCRBeGtysglLxulXhvPUza01pPch
         AhKWScgc3fnLi2ixZeoUsRy6bgqY4oGN9VTZiIQ7XAtvW92kOmYTcRT9xbbmKwq2+7rr
         L/W0Ly9yImlSEjURaNnIoUnAEkL2z1D5ckjpctMsoHQ/NngMOu79QR6jZD3m3nLu6Krk
         aCIdjAHSX0vl3KjMTGaUXG4r4HMWl8kUCMJDixOKSMKOoJRLpaXAcrJ5fdf0JM3T+si8
         kY2TcnI9iFnUay4RloS5zRGLdLC5R0H2UBJi9LNaF/bQ2UYFvcSAG4DLEAOAQEIcnec4
         7w5w==
X-Forwarded-Encrypted: i=1; AJvYcCWj6ZfjNvhxRrKyiC/2DoyjNArtWLE7mDrJUcK1IudJHhqSlUmvjJ6A2RzlwfgS4euTB1X6hmolEJyZBEJR@vger.kernel.org, AJvYcCX9HChUpvcp1J8m48kST8xX8vLVBxAK1gIndmdTIzYLJi8J+oIr9WYDWg9mbvs6i8bUvMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqYXuLCTT3flh9hWeaTIHsZrMc1REHHPnl+ZpSjB/nze/dOtL
	fdnrV/HbdKFoN4OjXYSOVx+yipRaRAnPsWTYKQp1R7ydU8tcTwNeNbSK
X-Gm-Gg: ASbGncutmMLKd8xTDuTtP6zF4FDRq/88j9Eo0Js+YOxE+CSdGdvrofoUYJKG8eBMuB+
	ybNuYvjTcoL3H6abQqP1b3U9jRiFGD20Rea66X7iR7sINlvW4T6cODr14ks2Kac2gUyEwgEIL6T
	JdXS0ZdwUYJQSduT/mHfZkUuhBZST99ZeYb5pG5xoPFT28q8PlF5EYbRxfC1QPVgXCzcuBs4iaW
	IF/Dt0ddgqZz5iJ05ZbpUoyGSP1MLQXoBuhwx4b8B23826r1ceyy9M2DNLc51JIY9Vr9QG0Ln8n
	YUukUZ+ItKoowPAksdp9NTX/IKWZm9vxuZBQp0xPPw+R4eV0XfH8z3lUfssPzb14e63SB39XLaW
	AGmnG0XA0TB6NIktBKZVVWHv04YhpPchl4PoVtRUc
X-Google-Smtp-Source: AGHT+IFirRO1ynx4PNieJwh+/qxRIudXvdXESLhzB5PFfPGxqyne4FswnV3bsltUa6DtqhYDvrtYcg==
X-Received: by 2002:a17:903:b88:b0:234:9094:3fb1 with SMTP id d9443c01a7336-2366b3c2d82mr381111275ad.35.1750342632036;
        Thu, 19 Jun 2025 07:17:12 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:5502:31a7:8320:fc5a? ([2001:ee0:4f0e:fb30:5502:31a7:8320:fc5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a1f93sm120183875ad.79.2025.06.19.07.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:17:11 -0700 (PDT)
Message-ID: <9a38a134-3ce8-4c91-a7e7-2a162cbf3b7c@gmail.com>
Date: Thu, 19 Jun 2025 21:17:03 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] virtio-net: xsk: rx: fix the frame's length check
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250615151333.10644-1-minhquangbui99@gmail.com>
 <20250615151333.10644-2-minhquangbui99@gmail.com>
 <20250618191111.29e6136e@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250618191111.29e6136e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/25 09:11, Jakub Kicinski wrote:
> On Sun, 15 Jun 2025 22:13:32 +0700 Bui Quang Minh wrote:
>> +/**
>> + * buf_to_xdp() - convert the @buf context to xdp_buff
>> + * @vi: virtnet_info struct
>> + * @rq: the receive queue struct
>> + * @buf: the xdp_buff pointer that is passed to virtqueue_add_inbuf_premapped in
>> + *       virtnet_add_recvbuf_xsk
>> + * @len: the length of received data without virtio header's length
>> + * @first_buf: this buffer is the first one or not
>> + */
>>   static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
>> -				   struct receive_queue *rq, void *buf, u32 len)
>> +				   struct receive_queue *rq, void *buf,
>> +				   u32 len, bool first_buf)
> I think Michael mention he's AFK so while we wait could you fix this
> kdoc? I'm not sure whether the kdoc is really necessary here, but if
> you want to keep it you have to document the return value:
>
> Warning: drivers/net/virtio_net.c:1141 No description found for return value of 'buf_to_xdp'

I want to add kdoc to clarify that the @len must be without virtio 
header's length. I'll fix it in the next version.

Thanks,
Quang Minh.


