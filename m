Return-Path: <bpf+bounces-63908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81247B0C24C
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 13:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810CF540FE9
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D69295D8F;
	Mon, 21 Jul 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHb8qXEc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA615293C6A;
	Mon, 21 Jul 2025 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096275; cv=none; b=Z+50s1MP5EcoaePIoBMKhuhs7PXnDZDwf85YvNhzTvd0izV10fr3cu9SYKxk8qmn1671QVMaQ+jdoqTCsn6z2nJK1L7ezz7qpsrO0UoRLAM21H/WczcTCj6BIm92V7dlcDOrzI6PCnfBUdETeN0anyo2VYp8wMgj3Mwu6OdthgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096275; c=relaxed/simple;
	bh=JcNSWwvJTwhT64Y0/KqSF1ww+wIie45ZsLTs8CIlKao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9ifJ9JxMrm/igRnsSK1TvUKxmdoEAow+dMuqJvw1vXLzQNLQ8jZSikX186/JhQ7Hvw5KZ9PmnFE4WhbRIUSVzgqDV6qJ/m4KMNrqsCzoLyRlalMq3AO2GrpZPy5gH79GLYF69WNx61XZILYesKejY4F1vCs2CwP4MOvDksAOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHb8qXEc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so6734298a12.1;
        Mon, 21 Jul 2025 04:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753096272; x=1753701072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnIbqCqg7JUChrhPkDwkGlZxQxz27HWtx39eq2JQF6U=;
        b=LHb8qXEc699j7ANv/nV2+jdueCE5Xs8hiuBrQysDQ4uI1EMDxa2KmA0zph08Rj+lht
         9gsS5absPvgookIua7oq12cKkRrOKSmfNribKiPF7u5/iNEGO5wuD9Ssm5OXxlDTIBbV
         EvypjEYGeCM81JN39IUo9+yrU3fv2jeSov66zkbX48IBqFrW+64rttfdTk5J068w4vp3
         RBQz7ABNbqbCNW6s1umlwH7ZdX+VuOug/m7PwadtYgH5bVKXbTguzW7TORxTMnq/6D+3
         0pN8NS7l2deMFrjTUqdLft8KuwCkk8CVSS8jC2Hu6vNempqvIruPfNdo4gMCuoUQrbIE
         RgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096272; x=1753701072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnIbqCqg7JUChrhPkDwkGlZxQxz27HWtx39eq2JQF6U=;
        b=llU87+Nwvc3zxWYeUBJFqSFKdvWBohw1iaYbZT0yXGgJSJBnPoCF0CvQN2dqalX0yB
         2CW8maLT1Vj6JSnzWUZRh808vQK4bdA8j0dWJTXvIyOsZ2YEuBAckSNWjbAYkEWeu9fE
         a946sGCshK9bJRxGK9dkKsF5QANdPeity04UrDQD32SUC0bUabtoZcmtqbMA94QmGAOn
         cvzltbQ/kdavdggN7HmjSy+JtLWo3I6yWGBq5MkoGj4+vwqWJBuNkLeeOQm2qtzjD0uS
         tqjUBz5DRnZIrHkpo11B2tICh0Q6mlJHv8I+qESowERe43nNcC17nU9DToujUOtpsi+n
         rm0A==
X-Forwarded-Encrypted: i=1; AJvYcCWFEQvWhbh5rJ2ti8arfPxMXgYQZw4Y28tB4asjW65g91gNyvQNAm5ku5oSEhhxSSZVU+T7SoQF@vger.kernel.org, AJvYcCWYri5qv0K8WVrZ4r8d9sKHau0b6fRj97zxYlE33Z2sw+FO9X64b4naHamAsYC3f3jf0ED2sexe7obxWg==@vger.kernel.org, AJvYcCX9aiUblRWsqginD0dplou9GBnwbvjF/PSTWFVnecUm+5RxH+OhD/qZ7N2aU2NXVlIekAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ/aeDHO6FjruMohZYDY20NRv0ZU50HxCSQycZAEVMznFqFbFO
	bSQUCPWksZJ0hfxQNsvbLvwIm2yuJLPdh0GRNpPMNYJ5dwu1cwh6US1p
X-Gm-Gg: ASbGnct7nf+nFytWMs8FB9A2obf2t2CkCe8cmPp2joSOwC4zSbVW04n+XpcPVH2Vz0M
	spj5rQGONsq0z/IGNUiOyFtoXvGtsjkiRgIV5/MZpbfBpo6iwdYoMomrcmOYvja7qDUOtnJrINx
	MJIwyjqgxu76fJer2AYqxWWiJ74YDhwQPhSXoKzfc7w+v0Xyfi4y8um3w3N+z8e69DECOKUO/ZO
	fcfrktpxjOcUy27Uc7a2c6y88NAxmuST67DeA0KdsKDsEOkFmeyysNYlQyChiO4ONrXRjFRkAMe
	Bw2hJc6eZ5CmbUrjt56PliNHbhVbkeh5HucctfMEtyv8qN3L9Dj6Ib0z2D+ETflTPCUIUhR84B/
	UY6Fkmd0Rk/j/vb2KaGfW1WI4rgDpxe0WUW4=
X-Google-Smtp-Source: AGHT+IHZCiqaXpmflAtItwVaPlH3VjQHk/jBIB6Bq5oI/tEB5I4tXMP1diqfcZBAAFQiHufovShJUw==
X-Received: by 2002:a05:6402:524e:b0:607:425c:3c23 with SMTP id 4fb4d7f45d1cf-6128590ba42mr17312482a12.5.1753096271896;
        Mon, 21 Jul 2025 04:11:11 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:23d3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c907a5b1sm5274092a12.53.2025.07.21.04.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 04:11:11 -0700 (PDT)
Message-ID: <77ee68c4-f265-4e55-9889-43ab08f26efd@gmail.com>
Date: Mon, 21 Jul 2025 12:12:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool in
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
 linux-rdma@vger.kernel.org
References: <20250721054903.39833-1-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250721054903.39833-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/25 06:49, Byungchul Park wrote:
> Hi,
> 
> I focused on converting the existing APIs accessing ->pp_magic field to
> page type APIs.  However, yes.  Additional works would better be
> considered on top like:
> 
>     1. Adjust how to store and retrieve dma index.  Maybe network guys
>        can work better on top.
> 
>     2. Move the sanity check for page pool in mm/page_alloc.c to on free.

Don't be in a hurry, I've got a branch, but as mentioned before,
it'll be for-6.18. And there will also be more time for testing.

> This work was inspired by the following link by Pavel:

The idea came from David, let's add

Suggested-by: David Hildenbrand <david@redhat.com>

...> -
>   static inline bool netmem_is_pp(netmem_ref netmem)
>   {
> -	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> +	if (netmem_is_net_iov(netmem))

This needs to return false for tx niovs. Seems like all callers are
gated on ->pp_recycle, so maybe it's fine, but we can at least
check pp. Mina, you've been checking tx doesn't mix with rx, any
opinion on that?

Question to net maintainers, can a ->pp_recycle marked skb contain
not page pool originated pages or a mix?

-- 
Pavel Begunkov


