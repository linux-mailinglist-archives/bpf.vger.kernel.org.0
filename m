Return-Path: <bpf+bounces-54102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A329A62A21
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 10:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C803B43B4
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B08E1F5616;
	Sat, 15 Mar 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deK69s2M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3A01DAC81;
	Sat, 15 Mar 2025 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031108; cv=none; b=EUimlLJMtq+3IGrrU8ut2F0QNjxtbnwMEZGcC0fuPn1zCIyxQ1gDOfJDpQxSemDoMei8uDnbkyd/Z+YP2NfAkMFV+VDcQ6EKDNBbMHF6J3JFZys4WI/e5cqUgqrrHhKFTm7zo4Y2bMqbNgcp4UlCIvg/1S2OSc2yxeXHicw8/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031108; c=relaxed/simple;
	bh=E6fPl07TqZvI8KI3J541d5RAVfir/XDW72psEfNM9l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kodup8XniQGimt6CvdosTA+DnqCb2vi1cST9W+KGqQeytWjXeoPAvtYSeQ4YSOQZakNeQ5RfNjz6NojNsgri914waFqPCZgBAXgd/l0p3QBi2BSbzAYLvKzH732nzmdI8Q0gLqdYNpX7Y2HmR1EdGcbzVxvPpMLTzA9CFJI8qyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deK69s2M; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso724305a91.1;
        Sat, 15 Mar 2025 02:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742031106; x=1742635906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E6fPl07TqZvI8KI3J541d5RAVfir/XDW72psEfNM9l4=;
        b=deK69s2MbM0IY/QcuaNV2NpHlW47YiNqHj8yRwKhbkM0jHPuOZOBBLmSRjm7MS5edE
         pmonU6KYmkObsIVxSzudfwcslwvCoBnuXVmCN3oExvbwnoIAngpetjIYZjx+AXjPlYXy
         09A6JSTt1k8hvtDNUB9NCatu16OJ4+A995xr67EBBPv3UMywwSKMdm6M65oLomZINbe5
         NhAuZjX76CwS+lp1B9wKoaEuDooIy7ufxYYlVlk4QnqcpCBBw1yJc/DsD7B3kBfuGV73
         CAcDs0JzvXej2bj4F23p1cNrmTVTXszkcQbHQV1ygLqrFUnWacjkG0mO54ZeOaZMgEke
         7F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742031106; x=1742635906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6fPl07TqZvI8KI3J541d5RAVfir/XDW72psEfNM9l4=;
        b=uDER0pO14IU/sjsu5JNQF44+SHTL2anYAFkceZ70IJozvDQPKLmjE+gB9Dj0Atby8u
         FUkwZ7+vDzD8C0ushgtmus+1MZ+pzwk8Z8RxrirxbNTrmr6zsYF8hJXxXWoDB+x+JoLl
         YdyTke8EmEjNPXQJQPcilaq1RiNBKJDabRHx1I9D8YPOV5/9jUXl2YcbLCBr7vRUFa37
         OwbblFftPiSeW9upO+Au7/7VswIeE+m46l+7MOJGZE+U/W5lkZq0VvB9baitbuQc+FRt
         bC65Y0zZc53ahTwFc/MpxPRcNw1NqWF6Trx9bDYxE4uneckbqlyoBTrrRUYQoPGXuyQd
         b/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNB0T1HCu6WXOLLfC5CGrT7pUQB0xdAs6HTSRgMcovE2JidgkEtiSD1UlM6fanqerBBDuJRvgJckJllA==@vger.kernel.org, AJvYcCWFX8gaXtGCEEJIeomemCepnVrFP+fs/MwDlKYV35IeuH8y6zZhW9+WBV7Rk/y0/3rWkog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeYDyigyc9ygrN1KFYmmBjE18d/yX4ILSHYYSpcyKv7aKrgI9
	rf1NjZLeDM8QpEHKkxQTW+/Ogwl5JcQyqAwIQZxbSxGmHaT+Ajv6
X-Gm-Gg: ASbGncsJ9gcLMsLM1Y6tIRq5ltdCyVmCLAcYMfM0UuS0T64LgScyIBCniKa99ujA4xx
	i2CPWqvoGMFyktjhj+l+PVzwTn44xR7oJneeDIN3Lysuk3HLOGOUvT0g72BoBJuV8RvYzNOypLc
	S/KUjlD1q1M55Cl/vM50hlMWeuMR8g+KuBhsBdbG84xd8JnmISLHfWODb1ZNObkoJW/ssqSOIjQ
	peTGZiw9thZAGdamfZ0ID3VFhnOE/lC7jx9wnCsz8fGp/aes/YdTQQcaBFzIrZDlWkoKJOy3ZHl
	fkm/FW8oX85rg861nDV9t7bi6fugZAdmXBA6yX8amhev4YufNGb3yEoT5u95GQu4xeIzhS3QPV2
	e+IoHxE640elYvM/dLwpddhGRBPnQO3pb
X-Google-Smtp-Source: AGHT+IHMKmDOMILytbSWMK7guB7TYp01XHN80NPMKwIikDzXh+u/oIxsZsN603rsFkMlSGLRJRzKVQ==
X-Received: by 2002:a17:90a:d003:b0:2ff:53d6:2b82 with SMTP id 98e67ed59e1d1-30135f4e5f5mr12411785a91.11.1742031106303;
        Sat, 15 Mar 2025 02:31:46 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:9067:2f1e:9768:2c54? ([2409:8a55:301b:e120:9067:2f1e:9768:2c54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301534f49d7sm2380310a91.8.2025.03.15.02.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 02:31:45 -0700 (PDT)
Message-ID: <b0636b00-e721-4f21-b1c5-74391a36a3be@gmail.com>
Date: Sat, 15 Mar 2025 17:31:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] page_pool: Turn dma_sync and dma_sync_cpu
 fields into a bitmap
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-2-c212e57a74c2@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <20250314-page-pool-track-dma-v1-2-c212e57a74c2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/14/2025 6:10 PM, Toke Høiland-Jørgensen wrote:
> Change the single-bit booleans for dma_sync into an unsigned long with
> BIT() definitions so that a subsequent patch can write them both with a
> singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
> side into __page_pool_dma_sync_for_cpu() so it can be disabled for
> non-netmem providers as well.

I guess this patch is for the preparation of disabling the
page_pool_dma_sync_for_cpu() related API on teardown?

It seems unnecessary that page_pool_dma_sync_for_cpu() related API need
to be disabled on teardown as page_pool_dma_sync_for_cpu() has the same
calling assumption as the alloc API, which is not supposed to be called
by the drivers when page_pool_destroy() is called.

