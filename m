Return-Path: <bpf+bounces-53644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011FDA57A2E
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 13:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9133B0F2F
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 12:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6BE1BEF87;
	Sat,  8 Mar 2025 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGArCf+v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A18196;
	Sat,  8 Mar 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741437237; cv=none; b=TMDHy0X8FXWVPrRGd8OIrtZPVMWKxNeobQgHIehF3Gn2VY69to+iIt1NZfzzGNTBPoa3cPyr7ROzxL5w6OKkQ1sCpgFSnIG3vFf6DmyUVJtdDTFtDdCNG1x+Azv+NwNF5o/W/ceuNVjwf5zlk61aHC9ZIhtrrWYVrhOdt/LF21o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741437237; c=relaxed/simple;
	bh=V/0SqlQacp+h4g7KCVIboICK9m0VGNB0L46HL+T24OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TU2fEbREngKlSXnmYHcR5q+xP+PeQVcFxts/9ykwc3ZREiq94KA4Rv1dNNmLkEe/NtU1FbuCt5SUCrfYShZy6QrnWfsuninIEOs11uu61EpRzNsF6r5wZ4Y04yrgP/1QBrZuaX769+HDrpv6k9UH01lgazrbamcKQHH1Mv5aF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGArCf+v; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22185cddbffso70967205ad.1;
        Sat, 08 Mar 2025 04:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741437236; x=1742042036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrHqPe4qI/nAbruW3F2vRPvWp4Qoww7mexetKwU+H74=;
        b=RGArCf+vP48/eTM3H0kN2UIShrS7ZAoIfiqLXWFdqyq2f9CHfelbGZ9GLdMUn8KU54
         ZEh3VD4zAY+iPQaZ5PXtBh1VgGhmitNdctEVB1ObKAJqhf9nZr39AC3vb0XrCQT2D1HT
         0mCRf06JboEZ3Y6qPKjbbQ+9aS12Bd7+KGc6NDuyLwJarBSEifeP0d/LL1NNA2WX/O8I
         PY8fC8RAL6waPAEX27j0wvwF22rPigHJwu1V5XbAXMx1X7ryETiKzThNZYfaZcoBALRj
         EoEjq2bh66rRbbx0lNFYRj4/EmeM4JOLd5c4xYfhjdlld7vIgnwQgrtRM6JI22FXJpCZ
         Eutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741437236; x=1742042036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrHqPe4qI/nAbruW3F2vRPvWp4Qoww7mexetKwU+H74=;
        b=k5l6RZem/NhjP/plbhVjRYgfvr0bkC1rY1wRmUmOn4xvBXOZ40F9gXQHsrELQxrbAB
         nuAvuVLUI5joxY5SFz7/wSDASMv7SQZS55cGtoG5secCm4CjEyR+4fQ0WT2B6zvwRhNf
         FvTjASTHsxZjHgueTFJAE1EDbSFRNkAvieNYpAhStsgLjpQcmyLR6scVcI1PfUsY95xX
         f+mqKi7/FPewgbR05e7xmFzAXAeyQ590xG8Ogu8vgSmCkvgx63XXFSaigihK6ZvU/fHz
         Zp8td73dZHP7OMjM9LlnRyaFAPfGKBsTwe0ZzwTR5UiY2dRlYGr9QwkBkQvoRiugfmcU
         q1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX+52y23PSHUrDSj9Ig5g8DL7V/DPbVfAclqYd9TmgJ4FR2GyYtjwvlcP4Vgx0fSiMQttuv+hpABpKHENb@vger.kernel.org, AJvYcCVmfnRw9Drqkeu2cqS+TvKpju5Ulc36ZhGuefeThZNLMkjCLqY7wD21FChmw+bbXckQk5wUg9xv@vger.kernel.org, AJvYcCWxj84Hz/UMR/ED2g3LmQK9t/hIBOtjZ5xYX9XtQF/4SkNYlW+kLwcjrd0ZijARBU/ZPuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmxL/EPzHxv9CZj+IPi0TDRtUxKYgI9emyJ3Bl3f6V4yt6UdiR
	RvyU4JxJrFu/Br9gik3/wb+bm9U9FV12u7HNe/u2ftmGz1psO5tZ
X-Gm-Gg: ASbGncuMH7JKlV5w5zMdJQsaGfQ/4J1yxgVQz9zeuwU+bbrbXFBWsu6gONeTYKUhsXk
	uOFle+3jKJbXPLlqC/ISi1GVzWzj2qoA6JOwRu8m+rmejJ1jqjpCFHHVrtmulgYq5O84AHyOu7d
	7j1D2oMsTULJw4hF91eQwCt38fTQ1UZc6RGE4VF5aVyqT+sjpE33cPPOzSzjgf7u1x4aQWoMiSa
	y2WpJV8ZH1KIThvkL+bu79Ne9aTjV37P2VpCTwfZBLVj9dDLPw9rfSSq6c/X/Yljvif/aNa93x0
	E703DUUOLKzV8fsUTdNMrd1bhZDEfvGyFfWq45usnQNO/NIDRFJ/aYRl9pirZGLnSAbNK+ANwYM
	MkDiPChwc58UVcg4tuLzG51RMb8Cgl6Rf
X-Google-Smtp-Source: AGHT+IEq4oVqwhl+HcBlEEt5O5mLwczA0MCHU/VL6TVKG4WcVGMzJn/E2qe19p7uaCmDiiGmZcFF6w==
X-Received: by 2002:a05:6a00:816:b0:736:aea8:c9b7 with SMTP id d2e1a72fcca58-736bbf4af5dmr6123665b3a.2.1741437235636;
        Sat, 08 Mar 2025 04:33:55 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:9c19:1482:d401:437c? ([2409:8a55:301b:e120:9c19:1482:d401:437c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698450244sm4918282b3a.80.2025.03.08.04.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 04:33:55 -0800 (PST)
Message-ID: <40b33879-509a-4c4a-873b-b5d3573b6e14@gmail.com>
Date: Sat, 8 Mar 2025 20:33:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/4] fix the DMA API misuse problem for
 page_pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gaurav Batra <gbatra@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, IOMMU <iommu@lists.linux.dev>,
 MM <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Eric Dumazet <edumazet@google.com>
References: <20250307092356.638242-1-linyunsheng@huawei.com>
 <87v7slvsed.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <87v7slvsed.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/7/2025 10:15 PM, Toke Høiland-Jørgensen wrote:

...

> 
> You are making this incredibly complicated. You've basically implemented
> a whole new slab allocator for those page_pool_item objects, and you're
> tracking every page handed out by the page pool instead of just the ones
> that are DMA-mapped. None of this is needed.
 > > I took a stab at implementing the xarray-based tracking first suggested
> by Mina[0]:

I did discuss Mina' suggestion with Ilias below in case you didn't
notice:
https://lore.kernel.org/all/0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com/

Anyway, It is great that you take the effort to actually implement
the idea to have some more concrete comparison here.

> 
> https://git.kernel.org/toke/c/e87e0edf9520
> 
> And, well, it's 50 lines of extra code, none of which are in the fast
> path.

I wonder what is the overhead for the xarray idea regarding the
time_bench_page_pool03_slow() testcase before we begin to discuss
if xarray idea is indeed possible.

> 
> Jesper has kindly helped with testing that it works for normal packet
> processing, but I haven't yet verified that it resolves the original
> crash. Will post the patch to the list once I have verified this (help
> welcome!).

RFC seems like a good way to show and discuss the basic idea.

I only took a glance at git code above, it seems reusing the
_pp_mapping_pad for pp_dma_index seems like a wrong direction
as mentioned in discussion with Ilias above as the field might
be used when a page is mmap'ed to user space, and reusing that
field in 'struct page' seems to disable the tcp_zerocopy feature,
see the below commit from Eric:
https://github.com/torvalds/linux/commit/577e4432f3ac810049cb7e6b71f4d96ec7c6e894

Also, I am not sure if a page_pool owned page can be spliced into the fs
subsystem yet, but if it does, I am not sure how is reusing the
page->mapping possible if that page is called in __filemap_add_folio()?

https://elixir.bootlin.com/linux/v6.14-rc5/source/mm/filemap.c#L882

> 
> -Toke
> 
> [0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/
> 
> 


