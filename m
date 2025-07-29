Return-Path: <bpf+bounces-64594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33385B14A71
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B1A16A2FB
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 08:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130B285C9D;
	Tue, 29 Jul 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoQZHrfg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1478F34;
	Tue, 29 Jul 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779136; cv=none; b=X4mHdotNtuwIbrqO+417bWfY7IH9z1s8vOdmAZGdQRvktkT8DY0geuD6kVltVzKcV3OW+lCI1vqxJo7Euo5+V2x3ZE40XifI216GEwN1l6ImSJL93tSs3G2fBgrAYWT0yFjsuwfFDXXjoC5jEdbBzOMLMAquOv/tQSUzO4p/VLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779136; c=relaxed/simple;
	bh=SN+9wrL45KOmZEoCo+QRSzNzRfauhceyHUari7IM4No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZ9QtYtdbkqotDF93dmFZYwbYLiYjysD+eKLJv/7PwaH5JpbL+uQQRa2k9UjLyAGW5V3SLpC00u3p/dWHwb79XIkV8irTZ3TlTJ5pu0Y+9YndDOKBCu0THZXYAkDLN+UywJwDEhSDROACNnLvV9sY/wNzWbU8qnWBHRNeTFYy6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoQZHrfg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso39216185e9.2;
        Tue, 29 Jul 2025 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753779133; x=1754383933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=puylhfEeh04//TXk56E+rvqvhJy4E6rc8s7DMainMJQ=;
        b=IoQZHrfg3xUMzo3PxoRHiOgJNruj8+8No7dvuXU/ywgLZ9s4+iyrb027hnr7Ru2VNm
         uEn4RIYeFRzEsltJ6X8Oc18tbwHeYZHkQkQb0ryUBGVSJVxXTQuT9rKe2mq6guHFvNZh
         ONjRThZ+kGZcyO1FRlqinQkOyvc1s0+OAoZ1/vn/Hm4FAd/GNCBnyv+4HxeiWhm7ZBOb
         N/rIg6LUzjx+WNcb+cgtcE/hhbm+TQZpp3+YxPeu4+UtXXnLBu9BM5isDlj8r3QCRN13
         2haE/DYebbM2dg6NU19qRIrDsYEWhB+YqC2YbBxes8VRf7kniBQVxbmqHdf+0mVVAp91
         ON6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753779133; x=1754383933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puylhfEeh04//TXk56E+rvqvhJy4E6rc8s7DMainMJQ=;
        b=ibyLhln2Yy/NRr7eK+5YQlTRI3hDUWnZ7XqwZNs86CGxKjGWQMiSHCx1SHLbKNkwj7
         A1pC/0KA+usl8BZLNDZj1go+poQ7fSN9El7LVJsLbS5kET45BojZv5Xt+fKO+QnK7KWt
         wJP9K13xmkQ59ue/40G7yOrtxXMXwVqzw0cnX9mxekHTKm/IVO0wKPhzCOc2i8JVHOKq
         Jk+b8g3zOnvAFsaANfMMdvYb0XUnF2yaQiNElWMd5d+jddgSGYRr9t59I7phW5wtgytt
         6e4PKHhS1dKJ+piKQCjzSwovPMFUTSxKPxY5cZPP5bkLcKwNy0Vxv0R8PDDPbd/3ItNQ
         HoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYygsdA3K43wxJvy47ILUnjxhberk+0eziJ6EQhzy0edlDwLj5ayEIhFadHfoXRQzhvnU=@vger.kernel.org, AJvYcCWjKSOEX1lFel3nJMALPUj2qRtv95LVT62noHdoj445+3igafeRJGUUnRpMwSLF7JtKsffq4FN+@vger.kernel.org, AJvYcCWsDkgKAb4UXtOmCEJ+TZgiWYbYsLRHK8upXjN5dhjnpPfZse9RQbUvHxNV8SICuQgUqprFHNd/A3C35A==@vger.kernel.org, AJvYcCX/KdDNRONkL4WBlBYzh0AIjNKiCamtrH6Sv4u3d7kM6Brs2Vym8he5fZHkqsqVf/s/UP36pc6A/q2zuo/J@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49sLNNvtJuIteqkfRI/HDVvlwXb+aElvIl/GmeT5CAh11aI/a
	VXFU8VcrHawNYr3QtBAGR/BNlzVprPthFzB0Cym1KkZL8Gqbme6yW6lk
X-Gm-Gg: ASbGncvorSVmIyLYDNdGUCSBO6ArhgzmJV3PHeBElJX9qUyes/awTi4UA08QWSJXnK2
	NXwDNS7d5h72gn5H4a6B1LluOMOZ2gqh5b/mxH9+vCCQsEKizwRHqYkd+BfAiU5Uc5/SJJ4foPX
	0v27plElWV6qYZ0Lm96KDoxK2aiiEaFfq8eQ9fL0Lm9hx0+J3K/E1nWqPjA8agDt4cp/ByCQKim
	PCM6LQG34zL6LCT2Wo0A2dhweFvPt5Mk7o8lpEbMhbe45sToloL+aeGCYKb/vstg13NS5tYkhil
	dWFPHrLndWLjNu66RgyryCyC4nNihMhIa26Dpp8WsxTs5VeQymneKEEWGT86dJwdcVmQ0prBxYt
	TpCI/TBjKNShqd707vnRMJZEmR6zsa5/Ql8c=
X-Google-Smtp-Source: AGHT+IEm4VTiD/JSN689v0JLsMbYqbkmePqxtHqQp6IbEjtW00P2+vOo5p+wkfxwZCh3NLYlWmARzg==
X-Received: by 2002:a05:600c:458d:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-4587b16efb2mr105032655e9.0.1753779132350;
        Tue, 29 Jul 2025 01:52:12 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:72ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b77e216516sm10225969f8f.72.2025.07.29.01.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 01:52:11 -0700 (PDT)
Message-ID: <7d7eb3cd-db7e-4a9e-8671-4185b716bbc8@gmail.com>
Date: Tue, 29 Jul 2025 09:53:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page pool
 in page type
To: Byungchul Park <byungchul@sk.com>
Cc: Mina Almasry <almasrymina@google.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com, toke@redhat.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250728052742.81294-1-byungchul@sk.com>
 <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
 <CAHS8izO6t0euQcNyhxXKPbrV7BZ1MfuMjrQiqKr-Y68t5XCGaA@mail.gmail.com>
 <da4a9efd-64b3-4dc5-a613-b73e17f160d6@gmail.com>
 <20250729010410.GC56089@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250729010410.GC56089@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/25 02:04, Byungchul Park wrote:
> On Mon, Jul 28, 2025 at 07:49:30PM +0100, Pavel Begunkov wrote:
>> On 7/28/25 19:39, Mina Almasry wrote:
>>> On Mon, Jul 28, 2025 at 11:35 AM Pavel Begunkov <asml.silence@gmail.com> wrote:

...>>> This may be my bad since I said we should check if it's 0 initialized.
>>>
>>> It looks like on the devmem side as well we kvmalloc_array the niovs,
>>> and if I'm checking through the helpers right, kvmalloc_array does
>>> 0-initialize indeed.
>>
>> I wouldn't rely on that, it's just for zcrx I do:
>>
>> kvmalloc_array(...,  GFP_KERNEL | __GFP_ZERO);
> 
> For net_devmem_bind_dmabuf(), __GFP_ZERO will add bigger overhead than
> just assignment, 'niov->pp = NULL'.

That's not a place where you should care about zeroing overhead.

> I'd like to ask you if you are still good with __GFP_ZERO overhead
> before going ahead.

However, it might be easier for you to just assign it directly
for devmem and let Mina add GFP_ZERO if he fancy the idea.

-- 
Pavel Begunkov


