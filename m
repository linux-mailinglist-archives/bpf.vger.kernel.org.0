Return-Path: <bpf+bounces-61377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A42AE6998
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB30A4E55CB
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E512D662D;
	Tue, 24 Jun 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqKAuJL8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07F2D4B55;
	Tue, 24 Jun 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775803; cv=none; b=VLxaZ6ng8DvpevW47mjbqn++gHZ9GBPlG2QUHipjTKBTHayCNQaHwDZKjjQNSvC+1LwvpYY2v2+3lNY6jNhobvwNexYBzmZOE1nbGLRuDodDSlZlnFU7bEfaQp9AHI+KRt0FZBOF+ZTb5rmkOcmpGu2vyuzKIxPt41W7MQXvX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775803; c=relaxed/simple;
	bh=cGvID7iNjFw3hCX2Q3UbTMYpmXpoJ9L97AGMCmURFBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUyO20NSCzRya7/C9wlbrMz32GUpa2CAVfsFFAwOY+i4OFSsZitGUPsVjemlIFtaeMJAqjhxdEVKuO1VtIFi0SfYzxop8HrODsyRDm91/NDAo+4Kv+PtQv/0xGviYGC/mpwgXeOVeAur7uhLiCFhGm1JYJNM5wURYHgfdgD0ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqKAuJL8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso629524a91.3;
        Tue, 24 Jun 2025 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750775801; x=1751380601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTVh9NYfR7GuqBMwngWQvuBj18Bm8G+r3At4Sh1jKm4=;
        b=iqKAuJL8FUSbhwZurIa11DcRuPpGUo7Y9cDFyBj1A1uhgNHjkdMKZkN5UTPunmuGMt
         Q0FGXs+sOxnrzfdDssyolAlgn8WDfz/IlW6rPaZ8dI6vCA44lrpkh0VUfjrEpna3h7rr
         TwVAjeYleGBfvqIUstlRZxO7fDGLgzSUSNc85S3GMb1AnUxxVLAFJD+paO4Y4j5VoF7L
         de/2r8ibM6UjPZFIjugcTL59KQ/+KDTjjqvRxQKsn222SVKjH/KDROEYIyxNvSW5kT8Z
         S+FjqDrD0e43IrVYiOBpamdM2P1BjvdnURgbbQ9VpkBnO3KAAhFi4r2wmDTT08y41i8V
         9lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775801; x=1751380601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTVh9NYfR7GuqBMwngWQvuBj18Bm8G+r3At4Sh1jKm4=;
        b=ZUK5dM8ChkLE+DsxuXPi02KCGQQOlTwbnjOYnL+6fRYtuhJ50HxbIn3Meyo0ZTJe+e
         0LRr5tEmFz2LUZD5Ym5n4p+7ayCXdX3DVknEIqZiqNQeFh7ogpEMIKCiareFlHhF92hU
         xvm7eF9stDOKF+6HbyU3auk+reklg8Dh2bgCqICkuaznapXQANMD9Czqxvxxsjv3VgFC
         of5X06HXlyFVJDJLhL8B55hjDO0jbPS04gkibM3M1GMgJoxJwyIXqnVb52bcQ6as7zmb
         Nan4qDFcDSLBe6E6/nDDrkFbnGw375FC92Pjw0lhpb/1fuT/6qPuuxX0y/7og7BZgoQH
         sKnA==
X-Forwarded-Encrypted: i=1; AJvYcCUoaj0ZnB+vlQ8wOoTuRl/O6vqdMGAEQ3osET4v7CG/uMp9b5V7DHjrAplrOttbE2lydUA=@vger.kernel.org, AJvYcCWbHbjlNwK71pl1nicsExZ89oDikCk5Y2JpJhbP06BSIAAZ5ve28ubixWB1sKn6kgVI0sGhphO5@vger.kernel.org, AJvYcCX0aTObQ1ZhztYQWnVhezKJCugn57Ew0lDonFKJsf8VwwrJT6ccV+p2uSM1DWA/2jKZQvXc1n6je+yHy9mG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+VUT2nk0BjfwQqKo8XwJx+id1OZjWe/BXLhkaAuBCYdYfVlfj
	M59YYcCVPZqHXlbEDB1Fh7dmMJpuH7FjawdWaSUmOao6b2okfAXRBUN1
X-Gm-Gg: ASbGncsjcafBBbA0m1B7c0ix3jgkFIuYdzs577pS4JB+hirAGsM0L+Nqq9K1EhP4GJt
	JZN6VcCmtW5DzbV1hA74InWKpz/LzfOJpPlv+ZdOA61tEgFzyikBheGA3BbCPE9gF1Q2MtxyLMs
	Zx4zeIZQMZ14c2QgC6KfI88r1Hcfd9/AUGDaLS753I113kGVSd2HDSCQavSad/wwCGUnGf47PI7
	xd9uhw10NjcmqBINB4QI17Nwzzhzp5fCiEXFXxtOOcvZ0+MGpdn9NaWoj84ficdrhs67aPL0NX4
	gQMDuTZEZdmWwJIWW+ZZVs6vvk+9BIADXhTcqG3sAf0THtlXqfMqeRAXGL7ZyjKKnueFmF2IdY+
	xu29z65GuQ7YsBVSB8tpzQ2mF3WJD4iFtYtbIYzo0
X-Google-Smtp-Source: AGHT+IHS9vDnuU2WNVX8FwC7SNF+yJeYaFCaub11naFV+gQ6pgp9/gLGfgnq2n1F7kLFckIWmcXERw==
X-Received: by 2002:a17:90b:4a86:b0:313:1e60:584d with SMTP id 98e67ed59e1d1-3159d636181mr26151303a91.11.1750775801107;
        Tue, 24 Jun 2025 07:36:41 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:1f60:cc25:9268:94fb? ([2001:ee0:4f0e:fb30:1f60:cc25:9268:94fb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159e07cedbsm11714380a91.42.2025.06.24.07.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:36:40 -0700 (PDT)
Message-ID: <88387a67-98a4-4179-b685-18c2098fcdda@gmail.com>
Date: Tue, 24 Jun 2025 21:36:32 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] virtio-net: xsk: rx: fix the frame's length
 check
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
 <20250621144952.32469-2-minhquangbui99@gmail.com>
 <5fb3c0e4-759c-4f56-8a78-e599c891f618@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <5fb3c0e4-759c-4f56-8a78-e599c891f618@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 17:02, Paolo Abeni wrote:
> On 6/21/25 4:49 PM, Bui Quang Minh wrote:
>> When calling buf_to_xdp, the len argument is the frame data's length
>> without virtio header's length (vi->hdr_len). We check that len with
>>
>> 	xsk_pool_get_rx_frame_size() + vi->hdr_len
>>
>> to ensure the provided len does not larger than the allocated chunk
>> size. The additional vi->hdr_len is because in virtnet_add_recvbuf_xsk,
>> we use part of XDP_PACKET_HEADROOM for virtio header and ask the vhost
>> to start placing data from
>>
>> 	hard_start + XDP_PACKET_HEADROOM - vi->hdr_len
>> not
>> 	hard_start + XDP_PACKET_HEADROOM
>>
>> But the first buffer has virtio_header, so the maximum frame's length in
>> the first buffer can only be
>>
>> 	xsk_pool_get_rx_frame_size()
>> not
>> 	xsk_pool_get_rx_frame_size() + vi->hdr_len
>>
>> like in the current check.
>>
>> This commit adds an additional argument to buf_to_xdp differentiate
>> between the first buffer and other ones to correctly calculate the maximum
>> frame's length.
>>
>> Fixes: a4e7ba702701 ("virtio_net: xsk: rx: support recv small mode")
> It looks like the checks in the blamed commit above are correct and the
> bug has been added with commit 99c861b44eb1f ("virtio_net: xsk: rx:
> support recv merge mode")???

AFAICS, the small mode has only 1 buffer per frame and that buffer is 
quite the same as first buffer in mergeable mode. That buffer still has 
virtio header (though it's smaller than in mergeable case), so the 
remaining space for data is only xsk_pool_get_rx_frame_size() not 
xsk_pool_get_rx_frame_size() + vi->hdr_len.

Thanks,
Quang Minh.

