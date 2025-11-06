Return-Path: <bpf+bounces-73814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2165C3A771
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 12:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EEC1A4762F
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 11:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF9E2DC346;
	Thu,  6 Nov 2025 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHL+/B5m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C5322D4E9
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427321; cv=none; b=CUNL1wFE7rkXRzSasI+YoN9HlSPJJax7ySsFExZvO44Nvb3y8aMJyisphnVh75T97HjlbyrUu+W9qU7zzELtoIvNL8m0hVNBhCZaGyQNmbwNrx+6tp0tnnsTcapEePy1+HsHXMv3qfBD89jYFY+x5pZhB17frQbWVmE3+DNE/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427321; c=relaxed/simple;
	bh=PXhPi+1hjJwewKP9F5q/Fq4A6lOFuf7yfuMD/xspVc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHYQXVeL81tcNLlnqSRMYuoxbVG1j3+fUA/NGTXugCLHIz9kLc3l7fyg6lW0A8QUHmwNkRKdwkqkINBN5awb95pCTtdWLA/FY7LtpPWm7SRPg2arQLKOrO74YYxlhLz5ZuRZ6q5eMQbS6+QhaQBxlZrpdgDE5GLCuTxK5cR5JRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHL+/B5m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so9013825e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 03:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427318; x=1763032118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3smk6GeMQLyg2bWpqf+opFvd8OFCVzmfS4zTn2VVngo=;
        b=NHL+/B5mvjXpeuKKe4fkmjixR7Nm80lIkURNcityRDYr+D5pkL1GNX9f+cIT1HbnK5
         fIpG8yLJ5JAhuBaLZAISDF9jIzv6un2EbKUyjcAEiUie88cyD1+cfzRlegYGxW5bjGWG
         vAA5/sWSADsQY596hceHBxGsqR6UOR1ApH5S7ukBdPOitdjqWuUuL+pFYFPKJjtnssIj
         wIdLP2Z2lJRhPm59pJ3E6evFOghju2DEVWiLc8wecJqLLrrF57AQnsbEhuIbmbwqqNrI
         s0f9K2HaUHtBkAtHEGmPWowo2jTfaoyTAvpKsgyIGhq6Hn0qUDbmks5YZTK3Qs9DW8Lw
         L0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427318; x=1763032118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3smk6GeMQLyg2bWpqf+opFvd8OFCVzmfS4zTn2VVngo=;
        b=lAHvNff3LNWUJEq3GhV8aldRzEDMF+sotc0oAIs2pknP1UJdfrTBgHIUVGzB1ybQo5
         +UyhHRWBHOhhQjwD9PLXg9vzV2n90gD0lYk7caC/xXi7SdW/w2hMR9JuXrodqFXgZn8t
         q08aNLM9C4pf/u3Uzj+dXCvcA4/yQA9yQPr2RfwG22i/+OKTup/mRXqs3OPt/Gcz2pfJ
         dNw1TiqlBQAQ9SojAaZKegnLcLf0WkwJLDOKxDmTIVlNx6tNpKCplNVFWo8QF/JlUMYx
         sKmNnTh748wyPqkdudUKHz9gM+iZi4u5S6U/EhX9DY7LixhWC2b30WjzZf2ZKEVE4G/U
         Ozcw==
X-Forwarded-Encrypted: i=1; AJvYcCUuvif8NDLudBVPDyg64ZYFUILFONQlif1K+st0h4CV1TDuz5vCoXp0oC8yXmtjXyP2268=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Pti2k1AE6H9vxIWKezgtNDUzZ3IOqr2Zt1AWMgFMWc8wPZRO
	hOr/c5ZvmxHaz9yK7erMCgMJHCKaE4La8Eg7C7W/1L/ToimPSHV8QZII
X-Gm-Gg: ASbGncujbehO4GQGbADvRzN13y9CzGAO6jH1OJ3aGHYy8cbgl0pdJfd0KNIhbIr3lRi
	utcfXPj7Pfh7+2GEKF7AJzk2bbl7ZnAIwcqQokZyIZJcpyN+0s6nkvexIc5PBps6Vly71+phhJp
	/CFBayBM/Z26gG/OK6UUKS4vBXt+yiOMGM3suWLoBUpZdSvh33TWALxieJSgI3tOD9oWJSp/cwM
	U2m7SCQbKVLTQOkjBbaeRjht46QXspYHsloHutJXNkp/8o2vrxNI/eZ97qCWpUxCBdaDCOoALMl
	o/tiyekmAkwWj4ez3IneDV4JVTrFq2LMW4T0RDnCCz2ZBAUWRt9VpuY83oZTyovfawvKyOvuQWH
	3xXTP9yc1btNqz73ZZuo5ffKJ2XXq7AKG4hDhT1LXT5iUkTtEHkKRLlO33ngAg0V8BPlxRCWe42
	1cUTw5GkxddbQOKmYVgj0dbnRnPt0qXj+ByLQrgnIK2PLjj/ip/Zj6f/X62COUiQ==
X-Google-Smtp-Source: AGHT+IFUsWMoUQp2LAQBvEqelZeh8+i2mx6qm6o3gPPvtfcki9Q9yd5em3sUzeuAg53ANmu2/8izdQ==
X-Received: by 2002:a05:600c:4c27:b0:477:14ba:28da with SMTP id 5b1f17b1804b1-4776201cbb8mr15583175e9.5.1762427318220;
        Thu, 06 Nov 2025 03:08:38 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm102571845e9.15.2025.11.06.03.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:08:37 -0800 (PST)
Message-ID: <4ab9d277-97ef-414d-bb5d-910fd8964c2b@gmail.com>
Date: Thu, 6 Nov 2025 11:08:35 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mm v5 2/2] mm: introduce a new page type for page pool in
 page type
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
 <20251103075108.26437-3-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251103075108.26437-3-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 07:51, Byungchul Park wrote:
> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of ->pp_magic, we should instead leverage the page_type in
> struct page, such as PGTY_netpp, for this purpose.
> 
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
> 
> This work was inspired by the following link:
> 
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> 
> While at it, move the sanity check for page pool to on free.

Looks good to me

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


