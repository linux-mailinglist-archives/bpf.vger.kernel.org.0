Return-Path: <bpf+bounces-59718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E13EACEDEA
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B828D3AC778
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FBE217716;
	Thu,  5 Jun 2025 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeiFQDSB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB3520FA9C;
	Thu,  5 Jun 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120245; cv=none; b=c/BVD7wFS5ocVvYdXSNFg0ZRlYCaOG16BU/9fPfQNN280loYekxGo+onXw7tH8Z/kH/aT59dAkE9/oPB4fxveoIsPLjPTjZF1injyQYTqPk5Q+6BnBIzTeNyTiQnDDeHDAmFLm4F0vWftEtGmX5zAgw+Bj60s/fZMT6feOPw9Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120245; c=relaxed/simple;
	bh=pM5miZh01uji3C0pRA4Cm25p9yJ7xXEKKZ/Hfhd/lsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPw9E/E+yOwGr6zKVMhrfxJDMkQNrgNtHwPYsE8U9w1WpkXtmAljUYDnqVJxmI8u1jgMA/gngba5U2RQY3t3YJ4al8Vd4qpRnLyTu+YINOkK/mwWcWJgRONGSUzxi0Wt4seZxeEzIwD12rFzB27PDvsgRC/lmbQ+5rnkQODaQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeiFQDSB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad69e4f2100so126103566b.2;
        Thu, 05 Jun 2025 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749120242; x=1749725042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+t2wiktu8oav5PiZk75RVzZOPx88NbHUYhuBSZZX8k=;
        b=KeiFQDSBeEg6cmimoqosCJ/uo5k3IZT7x47vW3IV/6RJ15iZCwe+AsYg0Brinis8J/
         3RVilLaUtCHEND+FyGZ5g7wZWdp/MWkt9F1hNvbXPl8FJ3GqlwyZIM0cDPiEIBOcsrPn
         2fHBD8BVUOJPUrbK/iXQYkFhe3JiWpmmrI088rXHZrhwUI/zNXhjrD7pKAz59HWeUo/L
         DpQwZoU0Srhbm9QLQONHUmf2jAipchtgph0WoipP/bAa/MaTUHtH90F1mlw12+pNKLJK
         l4iNILQHS//D0sT5gC1mOIkSDervoQZkw59UVEPpmzD5ztjkuWqEsNT7jgeNBsnip/3F
         Chdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120242; x=1749725042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+t2wiktu8oav5PiZk75RVzZOPx88NbHUYhuBSZZX8k=;
        b=Y2P7MqR6RWe4Sn7Ga5fKcFM7r2FhZHb9PROgPqsk4xMrHbnv/jTjUzYofJRojWdcow
         dddPoM0G/KzwXI2sgn3zcWtP/WW0Jh5Lrvj77rByTD0pwbjDzaSOXXfN8DZZT2AAu7Mc
         RuKKnS7zffR6Sj/61aK1R+ytylp8tfDGRVtZku0i8h7IgfZkS2Wg1pOpxND8WwoHeTwF
         1OjLs2B6A9L0utCTYkT/wrVGDV3qczh+/bkHU/GAAY6ai/pvL+Vpfh8bK5My8SHK02Ay
         JXWJhbZrUD2ICYY4+uRx9sQAbyXdZcZK1KXYK4mpdN+jY7U5IVcmVdM4Rvk8FQrcg+Mz
         J1MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJFhqSnPnKvV66AbCboclRslJvbDWs64JsNNvPIeheL/l25ArUu3/Nx0zzh2txIw+OusdrvrVg@vger.kernel.org, AJvYcCVVgKnqGSjUyEI7/Iwrcl/Owmo7VrPRkiQa1g9+5yYJvpQDR7lLQLGf2BVskR14TvRimvw=@vger.kernel.org, AJvYcCWfGO5OWeX7FH5BLMvFitlSY35lfhttdoVzPqlwZp8jKmW1sHpfm5hY5X+VXRIh9H4RaDFEPU4Xukz0Iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTL4NKG48hjaMYQt6js7FCmFHvkBoFDpIhohXlfsSHzzXUv3QT
	6qaBIiCSoWpJ0NkOY4qMxBy5hq8RSGrkbw0/bONPdF203twVDIHjx5Ym
X-Gm-Gg: ASbGncvdqZvnagXIT+c0B83mF+khChgg4OPXHk5Mrsa6992hN2jJyu8Kc1z6UqJ5v1z
	Oty6Pw8iyAKRbMfy6RVsjOfGKdB29l7JRrFCe5NgD/3crJpTEQyH2b0C95pA+bcufi5zHEeMO2b
	61D+D2M6rK5EiYQ3my4LjUMUdcs7xERbFjouD6ddkSaIt7dXO2wwkM65XJ5faxzzYxfBSusO67A
	ttx1RJnXfsSZWCDR7R1KzNx0HsMRMzzSXVEuVFftHorumf/1OPXhRGsomt70mbR06zZoWqnpN49
	JE02t7aNf0Z4TPy7WVherjTcf9Sx/rks+++TnX8iBiY+tyDwI5moCSuBnpgGZthqCdvL5OCrim4
	=
X-Google-Smtp-Source: AGHT+IEnMT7KUgk1GoKIavHcGDuyVSsgBYtYpTLhKdHUW468TE4aLkLxghZM1WmYjvjcIB/15ct/4A==
X-Received: by 2002:a17:907:7249:b0:ad5:e18:2141 with SMTP id a640c23a62f3a-addf8fe4640mr573586866b.53.1749120242177;
        Thu, 05 Jun 2025 03:44:02 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6aa17sm1253730966b.175.2025.06.05.03.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:44:01 -0700 (PDT)
Message-ID: <31224f51-1457-4a71-a5b4-880dfcbfa659@gmail.com>
Date: Thu, 5 Jun 2025 11:45:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 14/18] page_pool: make page_pool_get_dma_addr() just wrap
 page_pool_get_dma_addr_netmem()
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
 <20250604025246.61616-15-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-15-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> The page pool members in struct page cannot be removed unless it's not
> allowed to access any of them via struct page.
> 
> Do not access 'page->dma_addr' directly in page_pool_get_dma_addr() but
> just wrap page_pool_get_dma_addr_netmem() safely.

FWIW, it adds small extra cost to the function, but that should be fine

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


