Return-Path: <bpf+bounces-61276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45484AE3D0A
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 12:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1603AA6AB
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE7724DD13;
	Mon, 23 Jun 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3acAskO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4F23C507
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675102; cv=none; b=mLMVsZ2tl7/kkiRK/EgInRsMalHQ94qP4klw/6XXwO4X0k4CgYn0zdr8C37ss0tltxn3fbnUfHISZ6mN0vJFJctEkuKr416XIPCTT1c8+XT7OL7AvnTR/JGgtZoEiJd58zOYz4sf4Z+Q0Q29Vo3YcWfSXMOev9Qe98Gb9hyV4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675102; c=relaxed/simple;
	bh=5ooyaI4wDPnxG5yL6wKu9KRPIbrl5gWWCG82EkHNcRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHKXSMbtlP8MGh3Sx44LHttM+jTQakxuqMbN7U+67nUNeAgU3hiKVhUZs7DvhnbTIHXfAz5A5JSTPKU7f1tLRY0d8TpdGgvpLpe4Jk69FX4ESIsY2BZfkoSzAmrlX84v5p3Qiy7aXePrmepDmuE5eg/yBQNpfkw5XzeK1NgnpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3acAskO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750675099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/LN+rsWZhGokjOy4icyjolrxjXaEoKJN2Q70eJhKUPk=;
	b=E3acAskOCIFNo8/YLiMdwqvHOMGO1q9WYaMfUtMOnTkD2Xgi7RbZHtmjeYYRjIBNTjOlFz
	kPi91CcLNLq23rYnO7msriV8vYaBqqVs7EWtjp5hmVGk2WS3DOKlZk7+rqNMFGgs6lswp5
	+NM0oF/ZDcI+DROk4AsQ4cyyZL2iz58=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-aPI1k1WQMS6UlFApx1qqxQ-1; Mon, 23 Jun 2025 06:38:18 -0400
X-MC-Unique: aPI1k1WQMS6UlFApx1qqxQ-1
X-Mimecast-MFC-AGG-ID: aPI1k1WQMS6UlFApx1qqxQ_1750675097
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f3796779so1918425f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 03:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750675097; x=1751279897;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/LN+rsWZhGokjOy4icyjolrxjXaEoKJN2Q70eJhKUPk=;
        b=N626Y/tY99m4lulNPWBLdJvOQvyNbuyWXZJLBoocgKvEXH8R2mSg510Z157XyeviWZ
         ubUNaH5hh017w9odnNHSknfJMxKwJRqhFAZ14Eqq6MA/+9Qm80kr1P7z7LReK6xnPQvO
         3CrRqq8rIL7y1NfN0nZTL5xUU5k8txxJnnlbtuglH+rZhoZbugtFx6mGJOVxqAX13q5Q
         4OcgD0WGl2yiKfbqashZVB6OgCigx2RMhWrOOcAY0tBqyctfC0PKbHFSGW8tgIq6T7lb
         TcKrRPeOdIBhhNJxP2suT/+J7byvxlQmlXCCyB3DNMKIh6B4DLlLrpBREtTsI6h/Q3ij
         gAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgYhrHulJVF7IndicA50ro8UObOSh+jb1XQZDve5CgggbO6ng5nu5nwz/hWbHeggS/2Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RYZg1/JqaRrdo/UR8HF9o+uH6vQ49F9s1dN9Cn/qeRWqzOrv
	iBRC+trIvqKu5UVOYyQsHBxV2xDA8iPLuSINi5j1iYshrRqRD8bipjewDWLsPtDLLKHTi5aFH4S
	jtUqMgZNCOoHoe7YrsfPglPRtDCGA+G74BIbb/N1swSt7wcOz3lVc6A==
X-Gm-Gg: ASbGncuAeHINWBdDTdGyJNGoXyvquk0fYSLYEXF8D4PdIGUdIhTVnbJGGsCSxRKJrfK
	relxVtiI1KsfhZ/kuHSoTWYpgzmxOayq9XK5286xbfkSKu4SG7iTwEYjxcIxbSO9NHc744K/JT9
	9SLs9UXMmBmMM1gEESRQ3S0VSzu/cn3FuZPHGkBkESwgFaeAH/fQOE0Lp3YBc5pqu7IHILujH5x
	kmkgtcgLZt6/1LwI34Anvdt9txTA74j2vofLRZSBAHfCy+M4gwGmEo+ImQ6bNqdRO5BBOzZXWko
	b9ZbRXMkvjt8OslamJJ+vbyENQ3Kb4OYjiMVHFj8jHmF5Y2RMTuPBPcgKXNiDNOHtIWbaQUzEqn
	0QqnQpcS2bRhU+ZLlOo5Vld4xlWzoqVQKsW8uFbLKqO1r6B7BUg==
X-Received: by 2002:adf:9c8c:0:b0:3a4:f7af:db9c with SMTP id ffacd0b85a97d-3a6d1318226mr9357718f8f.59.1750675097212;
        Mon, 23 Jun 2025 03:38:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECcM+AqvRUC1A9hXYWujS1T9gYxYIu8+M512UDLAM+1KfUYKRpiKkV8XEwoTWYUAmkmNpyEw==
X-Received: by 2002:adf:9c8c:0:b0:3a4:f7af:db9c with SMTP id ffacd0b85a97d-3a6d1318226mr9357698f8f.59.1750675096820;
        Mon, 23 Jun 2025 03:38:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453624554cfsm77494885e9.0.2025.06.23.03.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 03:38:16 -0700 (PDT)
Message-ID: <4ff361af-fd74-4d9e-b7e6-4756622109d6@redhat.com>
Date: Mon, 23 Jun 2025 12:38:14 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, almasrymina@google.com, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org,
 ziy@nvidia.com, jackmanb@google.com
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-2-byungchul@sk.com>
 <8eaf52bf-4c3c-4007-afe5-a22da9f228f9@redhat.com>
 <20250623102821.GC3199@system.software.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250623102821.GC3199@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.06.25 12:28, Byungchul Park wrote:
> On Mon, Jun 23, 2025 at 11:32:16AM +0200, David Hildenbrand wrote:
>> On 20.06.25 06:12, Byungchul Park wrote:
>>> To simplify struct page, the page pool members of struct page should be
>>> moved to other, allowing these members to be removed from struct page.
>>>
>>> Introduce a network memory descriptor to store the members, struct
>>> netmem_desc, and make it union'ed with the existing fields in struct
>>> net_iov, allowing to organize the fields of struct net_iov.
>>
>> It would be great adding some result from the previous discussions in
>> here, such as that the layout of "struct net_iov" can be changed because
>> it is not a "struct page" overlay, what the next steps based on this
> 
> I think the network folks already know how to use and interpret their
> data struct, struct net_iov for sure.. but I will add the comment if it
> you think is needed.  Thanks for the comment.

Well, you CC MM folks like me ... :)

-- 
Cheers,

David / dhildenb


