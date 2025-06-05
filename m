Return-Path: <bpf+bounces-59716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 481ADACEDE0
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DA218831AB
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CAD218AD1;
	Thu,  5 Jun 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSOZp5aT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC72217F53;
	Thu,  5 Jun 2025 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119947; cv=none; b=uV9iJ6CainG6vVH4jW5K3fNH6Yl9y9pxpFpm+uO5Fkui2KwFinWkZykDdiDy80X6LpH1Z4RoeN/WVMGuVRItwbceIKwMlt8LL1WzZYv/HHbh48zqDoZsdoH5BOqNL7CkQNJONjQa9MTT/E5REXS77/q19a+TbHCUjSA9zRHvAmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119947; c=relaxed/simple;
	bh=L6jdoLRYeGddgVxcU+RG+qLHomps+vlG1KKIXVVpM4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrLgcqoyQyuKwXRIJODZpdVtFkeCIzADFZzUypVxOn19VS3k5hjb+9NNnW9/086Gb3MtEauMR4xCOOSaGU4yguqWnyW5RVp3viEYgwdsjuLEtXCshnLO5vZ/GCTZj6/T5HceLT/u6keA4A6bAWHkZrQ4Ruk5LNi+YXkYWlpJy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSOZp5aT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad88d77314bso160267066b.1;
        Thu, 05 Jun 2025 03:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749119944; x=1749724744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/HebOR35fUuSfZnbAb4tyLv2vY1WjieTwW4UEi8kq4=;
        b=ZSOZp5aTVuAMsL//7/F+0NA92EdBjKBP+kI+cty5QLnbQORHRvGPxLP26NcLm7NwIf
         uTpXBHBf2DDLIZ8WuGUo6B4MyXZcfuJLKEdfBHiyitTTN5xWCFjJvSvy7zUzri28gSkg
         vCqCBCjBtS6yGHpqPBcR1/bEhC/PCG6GOscBoIHa5nYhgdPhOsQap4CteWbYNuZW4ntj
         pm85tll7+Uagph0URt8i0twt5IJsAwAcXknxcPYMABUZOHjSSWeOcgZK3oi1TN95+gDM
         6IEa2CLWVUAoXVXmKDgPr3IJhDwEDJJJCgtb3vFf/k++IIEYxASotyhOvzUqu6ksfG7A
         ghgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119944; x=1749724744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/HebOR35fUuSfZnbAb4tyLv2vY1WjieTwW4UEi8kq4=;
        b=YQ/FqMqqGXbwrNCYBtVp5tjZFpa2CPShfmpnsuROQFi/Vc65fyPSSluYxKoE7U/ajJ
         kI2jFwL7TKBmyGKAqsUTCQy1M3+mMnsnSS3H9IQpbPxYnx/rK7Mopw2rVZqTx4X1DIVf
         tS9zgmKBI8QUY3Ymxe1WfhxWBnbg6SvZDBAOIOnT5kRd7h/flvX2MPsUPwtLhPtq4oJK
         93xXySffp+Lm28HMbfoywLVnB6ShgN/+AfyQHVcP0MzDMNpBkXtmIzcooqEKAuCq39GN
         zSWy9LXt2Zi9px80lz69TSJAgvYCq94aK0H/gMOJfKmS0utFstEa1o20bV2TewBj7+0C
         TLGg==
X-Forwarded-Encrypted: i=1; AJvYcCUgrUq9tRsDjoh3cucO+xOIwBhjSqXpxg32a3DEE5ShkzVblgfymrQ5QkjhG+mkvTOGJcDiNt6FZVJAdg==@vger.kernel.org, AJvYcCVv2CH8M1Tw3XVb1KnV5d/qpFNEQUtsQder8r0wUfpf855VPjzfHMSqmuPujzJWcvKk15iH02h8@vger.kernel.org, AJvYcCWSwrYm9IvlWG8x56EWhxLSVaGnzDv5zzT7uPbu4ZjqZa7yUCYbaVweebpTit0rk2kLl04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+w8HkwZoVs6B2s3lNeKycNGGQoKk7h2Z2NZwt6GVHLJ22enk0
	tBhwgtL3KjkTawkwmkvC2NGaaMb2yIxEl5FOZPtJR9gBdH3Rl9+a6kKrVUrODuB6
X-Gm-Gg: ASbGnctZNB44LmUmW+4zcqJLWbbZ6bGv1V2nf48/1hnfxC9qamrPB0NXQB6Z3nFrvn8
	VQbFfnVqm3rmNhUAUljh6pb+N7NleskQHLWMilqWg5Ih0vNKHpQ4U/QZ66TbpiFWYEvLlWexXDE
	1F9kptEMzQfukoQc6yGmVxazWCnkQRH/yUs8o51xBYncBRPau0Oz5n1dEOzxHLm5o1sX6QTgDSw
	Z5pUFdU97vzjYXJ9Z2se3Sfp8SXqZN1A2vYn1ww7Ep+tBpa4p48rBZYL0+njrrupVhRsDmHUzGy
	5UozWirH4pY/lrsHu94ykgeFOYtfSH4rB/NIoEFQXpUpWGIDYJvkMqS2CKNtDiB5
X-Google-Smtp-Source: AGHT+IEesdOVPN+u14tZsRl3xXfJ2LKUNkfj4NytgeNKIvy3iAaYv1rX7nKN/z59TSgH8D4EudMrqg==
X-Received: by 2002:a17:907:944b:b0:adb:413a:a981 with SMTP id a640c23a62f3a-addf8cd8c1bmr602570166b.14.1749119944044;
        Thu, 05 Jun 2025 03:39:04 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb33aa6bc4sm1068353866b.100.2025.06.05.03.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:39:03 -0700 (PDT)
Message-ID: <5dff2072-ac44-466b-9302-d5d02a373f63@gmail.com>
Date: Thu, 5 Jun 2025 11:40:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 12/18] netmem: use _Generic to cover const casting for
 page_to_netmem()
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-13-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-13-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> The current page_to_netmem() doesn't cover const casting resulting in
> trying to cast const struct page * to const netmem_ref fails.
> 
> To cover the case, change page_to_netmem() to use macro and _Generic.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


