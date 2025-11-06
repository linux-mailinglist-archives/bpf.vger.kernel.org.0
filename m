Return-Path: <bpf+bounces-73812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD78C3A747
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 12:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB95F189415E
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ABF2DC346;
	Thu,  6 Nov 2025 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFsaGLaa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66B92E6CCE
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427284; cv=none; b=m0vshlKFys2LnNhOotVJkBSgLJa79ogqyVYznkFxYv5dE48fM9v73saMzenycpDUztUyOBpqD/f4fF4lRgX9zxeSGd5/T8kKWuuyld7LaqM/J+pBHNt/oBJPo27xIXkHVgOIQHOcxwVr9WwdhN1svv2ymlVb5sqsNqzMP2++b9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427284; c=relaxed/simple;
	bh=iflFF8uGA+JQqg5PeOnkh0xBZA/LPV6uIzaa7UsyVRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZ9th474xonib5rk8SzGaYnVD4HJ46/01bF+eSNZ0JZH4y9PA0pmjV/WMflFDlOYpB3TxJ3gPFinIb/NJP+l3v8OcH1pXrDRluGdPn5/E6Qozs1uIZacpiHqk2a+AiWPhqFmYDCulAH6YeEwEpv1KEA7xRFI6Y+mYv1GkkOPF78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFsaGLaa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42557c5cedcso456385f8f.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427281; x=1763032081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KemrrCvE16IUsPvIdPc7ZklZCJchRhA/4dXIse7pcqc=;
        b=lFsaGLaav2Wzq+kdJsJU1Wb4wW+hsZE5/nqsyi2eb0dBlUw0xGSjTlzzn4Sa1cJnLz
         qOyyIeD4YWjmrVzmwvu8aLSvJiCrNWiWtPu3V2gOXZd2hOq/2CFDkuqVKsyHc8xWaV+2
         UnIEinVpCzCm1HQ4R8dAMK+BQyH5QFyCxuMW0Wu90+6fKHiCDqa85zysgdJoHRrOgGTY
         4TuJETudPaQ70g6dro3pDcNu6mNd5AGjgpMzdSEf+ANdVpng/0xQwNfcTBWXI4fgmKma
         Gx1wfD/x+CU3EW9C3Q90NaljRbG7J9kS+1tSE2oTZqfxywlZzb1JbKbJFTSXG8MyWUxe
         SNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427281; x=1763032081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KemrrCvE16IUsPvIdPc7ZklZCJchRhA/4dXIse7pcqc=;
        b=Ztn8UzuiB07kZeT7lnAed9kqgGBZeeRjs5s2/oDNXZdkn5L7wMY+4WVDUatIRvXfWi
         ZsZ4qhbMmDYNNTrnwBeDnrBAwC2SPI8qvtyDDRkGvDlHdRJjIWikO6+j7lVehigOX8Wy
         XCl/pUXGPXEkM/we3RnGtE5Jfn5nM8S5dVwG+6aSn6AiIAMLS0C4NPQCTYt4Y5wOFz6k
         eA9mOFbZL+LIvHuFHASOcW7UAZksmQzK4cmqfonvP7ovRxyI/GDSOa6u/cOGBiF6OcTy
         SBvxEZC05B8x7ELKHVIIVIKg/BhhJqF/N4Zlf/g0UnSsS7zX7NIminm9QOHtjZpTpa/u
         6LNg==
X-Forwarded-Encrypted: i=1; AJvYcCWx/6exBusM4kska1+o49iq/Xi3wA+9jcYLgyI7yv3HTkwmYHgO4lmmHvvvEV/XbeEf4O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64qENxSNA/LPERIEo9RWsImy8P7vk2hb/vl7OrwytityKY2k/
	mRs+a2ZNEuhBbh7rVqnVjM62NfqkG4L+qgv9zXJeUYCvQN3k63zkkj7S
X-Gm-Gg: ASbGncvrh/W+gKlM8Hl1Wpn05HVVBvGF9y4sUXlIbSJBkc+J4fUGoRP2BovQSsOt3+m
	0+l/qJMUtT+HTIByIsC53017L2uT48gJxiNM95K32Zfwf904QbwzJQ1tWl5wpJLGrbk12WGfi9B
	B5ljiz8peK7dMe7S8nk/lUSjdk+vfUUxpYR97jEyvdZHpug9wX9WI+bJFCLb2Pv5FhPxt6CTEhS
	Ci49yQvu0k4u5pXgT/FyCTHPoKDFZQM43vbVwJt6jlrtkvnCajNEVKA4z8N3galYw0TOiBtDnxX
	CGdbSz96YooKWf5mGsKssF7uYE50HNv5SZMZjAp5jM5qNb6Prhep3cG05ZNzNtVedAuerP4hL0P
	J/nmc4OEoJLiNGTZeCLa+LccRTUNJWEGwunxiuk/K2PBSnhpK7cza2GM/0H2fASjTSscm2WYkil
	UERYADvEiRnHABudMyXn2bcIGIhebZZsogd6vtj0h6xT3j3ajjenI=
X-Google-Smtp-Source: AGHT+IG/WPvgkkz5ima282cKyz2di1ByWQE6/QNBfZEdI+atynO653MZ5MMOXdVnpoH97C2BXp1trA==
X-Received: by 2002:a05:6000:250a:b0:426:ee44:6d9 with SMTP id ffacd0b85a97d-429e32e3595mr5318368f8f.21.1762427280858;
        Thu, 06 Nov 2025 03:08:00 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403849sm4648357f8f.1.2025.11.06.03.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:08:00 -0800 (PST)
Message-ID: <785c9d27-23e7-4ecf-ad2e-202ba506f2e0@gmail.com>
Date: Thu, 6 Nov 2025 11:07:58 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-2-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251103075108.26437-2-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 07:51, Byungchul Park wrote:
> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of ->pp_magic, we will instead leverage the page_type in struct
> page, such as PGTY_netpp, for this purpose.
> 
> That works for page-backed network memory.  However, for net_iov not
> page-backed, the identification cannot be based on the page_type.
> Instead, nmdesc->pp can be used to see if it belongs to a page pool, by
> making sure nmdesc->pp is NULL otherwise.
> 
> For net_iov not page-backed, initialize it using nmdesc->pp = NULL in
> net_devmem_bind_dmabuf() and using kvmalloc_array(__GFP_ZERO) in
> io_zcrx_create_area() so that netmem_is_pp() can check if nmdesc->pp is
> !NULL to confirm its usage as page pool.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


