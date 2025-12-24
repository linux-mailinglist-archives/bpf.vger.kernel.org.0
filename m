Return-Path: <bpf+bounces-77419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9FCDCE11
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 17:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF6330446AE
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53D1330D28;
	Wed, 24 Dec 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6Uiov8K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C9334C26
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766594612; cv=none; b=U72Ax1CM4uk/Ee7rm7alQlorE5zc1DrjGBQBAEIHNVvVMcky2+R51CC+9bmCPqoVKPfflG6wHfA83NdX172q3DqWAe4ZvebALp2SPiQ0CdCI7LickBcNvH2QXysfP9oRMJgns+9+OTzj1ZGarWSuLoo8wadWYczcbHtxUltLopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766594612; c=relaxed/simple;
	bh=2khFtyxoG8D3pvttVzE9sVaw7e+CdusfWtieJ8Un1NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwnPyWEUS+L8AmDNa3DPoPOkVdvQ9XK3gsfHfnZ/c7HpOQ24AyxiwdTqLTWOEPXjevyglZZxx6mXnz9/kv8VJlMuv0ey29gOZwzL2B4BC6NHQ5sJQHCizjjgv1yMOK4OAGyZNlvQM1Y8VNeUkiG5WlzPLN3UzXnGQScm2zevy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6Uiov8K; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso4967790b3a.0
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766594610; x=1767199410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwIk1nvhH1d/vdoQL7AOIOe4muNkhVEYe/P22V7V6vE=;
        b=F6Uiov8KrV1uXVywgYxGVViWHDKYBlDNCPFGcAghUuc/px803Mg7wNhjFsKRmB8/20
         EiNKkGTMOQ1mVtnXRQREredIrr0309uYby6mwzTkpwzXydrh2+xo0XhwbgbWg5W2c+qQ
         bCJcwsVPh3uLFdHdvb92z6NvT3Hmb8v5htS8yIp6zw9+9GkpEQRBseNGX6tOunQhN54j
         QdXssaPvr21K8fp/YnqpRUxr98qGo8pgqM/QLIEWQ4bDtK9cJx2o1IwHPHhprC/G48in
         cr0MUtFRlFwucKPHW95VEEjVzsDhwfh82i+QCR2fWxK04NalXABOl0KnhpJ2EpbUQpwa
         TTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766594610; x=1767199410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwIk1nvhH1d/vdoQL7AOIOe4muNkhVEYe/P22V7V6vE=;
        b=fiuWmAq+I9abjaGaS9V0I/agfCSco/2FkgtNIiDNedRyWBYQ43cTBzlZ2iZCDCxGx1
         JzafBj/KUqSNDSXOMnAr88T8RTae0CjiAkf5XTy78XR5iHlMqwCv60cJjCdMew8c+0Nt
         30wG4aNBD0BNNSCatk2d+9+wRw0uJw6G0XjwOAmzekSGH7b3/3MxMcuUDdHmVpBTaCfx
         +fKRf9BkToMUx0Ph9Ki3sUTmtuw2ldsmBH+ngUVgOnHNbaUo4BdwwWPUo3mPZXzypXdD
         moV5L4CIdGGlRbxX3OUXLwDAi3HSnsM14Ses/O2eCpYnniy2rypImFemxGh8wY1WPSE3
         OkSg==
X-Forwarded-Encrypted: i=1; AJvYcCW7A+7LB6UwOt9SAM73VaddYpPK7Bkx2r+08lZs45vVeiztIDj9hNi5kyTAERmksCI3GBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs4zmply2w3nGAlscFEihjgBiAdLZcTtbxM9FOD3gz6LIReXOY
	brbeEz8ah0YWF//fiSBJQP9VahqynD4RSxCTTdrfJbkVYwSXFy3nPAsV
X-Gm-Gg: AY/fxX5t17VqJUKQF3n9tn4g3V7DJy4d3Wcm0ryyOY2oSMK0rWIbQu70jfS9FAu2pis
	UH8Dq/H/gsD5jV/TfCG7hm4JOWg+IelxHvW8PUQhKCUzrGsHRQlvTWV/2xzlfJnCOXWw2j+EMY6
	ir4CrUb/hlsvMFwXrhdPVgD6iLkHsSONNGIkOKEfox3dHD6KatcuQS98KA1C+zRcAriRpxqdfYO
	c57d2tnFSa3TDKBdiOwbV+qs+Asloyt+rDxMs6FpHd0BkCZ2dC34/3eugT3Z6WJrftlc6FiHTwJ
	07HnYA3CFBrBMA4rToQ4w1LuQRhnrHGNOz9ZsuEufiGQpmaJ3tLKAlLiPx9QSu3YCvUEw39j5nT
	5hw1wN+imD6401I8Y/HNe7qup0F0n6Fy3tee35Gf+c4JH/lNXzrVpHJUDCdXmTJKjFtlC5O0QMV
	6P3XxRBZZ5oJTPn/uNIXT8lnHOReGNuQ3k8gh59GnFMbRHvZnJDe9lMQTXEA==
X-Google-Smtp-Source: AGHT+IESvaaiYDz0FQXnk+cOSP0Y3BphqGxvFTMbynES490LRlFZ6uF+ljLMEtDR9jmc0Xu4izDLEA==
X-Received: by 2002:a05:6a20:a107:b0:364:31e:2cb1 with SMTP id adf61e73a8af0-376a7af61c3mr17802942637.17.1766594609908;
        Wed, 24 Dec 2025 08:43:29 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c711:242:cd10:6c98? ([2001:ee0:4f4c:210:c711:242:cd10:6c98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f7d3sm19211220a91.4.2025.12.24.08.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 08:43:29 -0800 (PST)
Message-ID: <0c94aed3-bef9-4ae8-b9fa-bf2db113eee8@gmail.com>
Date: Wed, 24 Dec 2025 23:43:21 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/24/25 07:52, Jason Wang wrote:
> On Tue, Dec 23, 2025 at 11:27 PM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> Currently, the refill work is a global delayed work for all the receive
>> queues. This commit makes the refill work a per receive queue so that we
>> can manage them separately and avoid further mistakes. It also helps the
>> successfully refilled queue avoid the napi_disable in the global delayed
>> refill work like before.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
> I may miss something but I think this patch is sufficient to fix the problem?
>
> Thanks
>

Yes, this fixes the reproducer in virtnet_rx_resume[_all] but the second 
patch also fixes a bug variant in virtnet_open. After the first patch, 
the enable_delayed_refill is still called before napi_enable. However, 
the only possible delayed refill schedule is in virtnet_set_queues and 
it can't happen between that window because during 
virtnet_rx_resume[_all], we still holds the rtnl_lock. So leaving the 
enable_delayed_refill before napi_enable does not cause an issue but it 
feels not correct to me. But moving enable_delayed_refill after 
napi_enable requires the new pending bool in the third patch.

Thanks,
Quang Minh.

