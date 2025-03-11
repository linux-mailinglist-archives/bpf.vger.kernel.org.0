Return-Path: <bpf+bounces-53818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5BA5C1F9
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 14:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD1916D7BC
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DE778F5B;
	Tue, 11 Mar 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJWA/FpL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D43BB48
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698535; cv=none; b=awuvDaKRKJjWE3C4abAGbxMgBeukM6tha+ZNCYBkHwsEyXkYNO8GQLJHn969ivPWc2SOS+Qn9qczO2plo/6JyHlWXF4OEbLPvhdQAjDcjPLFR8JaYiqpBEgNE0/GtBuzQGZ2hPRwxXss9OOZpwIZCi243FkffEnDlmut6IqqAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698535; c=relaxed/simple;
	bh=NY1wpa0KtsBaIPbsx0L2RVvkqMHjLmULXkYd5FOpTXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=el1OClrU1wCM1qUUOUu7IF2uO9bIvoxuWAVwOSCOMyByoFOZafFgDCRUgcyqGhVcqrDXoCfZ9DiNQS3tKYHWEDUvsBd+QVPCJ50ZqsMuf0QBhzsZUAmDWudWKFIBIC5OcDqXO2bq/eoRQstFtIVotlWlKoJe4hVpvMGrk/rBKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJWA/FpL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741698532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSr0TDQLJaYD83EU6zHlB1nKsxywhTiBP95UqC0cvIM=;
	b=iJWA/FpLY4ALcVQWvmhM7z571xx3XbxbOnBN7Y62P8yNIYMvQRYnDRlPns1aGrgAtc6Sw2
	YNFuBqw12QjDYf2iCprl2fHokKe7bnCjYBnoWlU8+zDlVo5FDn2SK9XYNKCjS/ugeRIDab
	cg64px5RP0SXe6TaHgiKgjSa7/komIU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-VT8RQNTUOw2Crorh5pQ3_g-1; Tue, 11 Mar 2025 09:08:50 -0400
X-MC-Unique: VT8RQNTUOw2Crorh5pQ3_g-1
X-Mimecast-MFC-AGG-ID: VT8RQNTUOw2Crorh5pQ3_g_1741698529
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf446681cso12941985e9.1
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 06:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741698529; x=1742303329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSr0TDQLJaYD83EU6zHlB1nKsxywhTiBP95UqC0cvIM=;
        b=CfXsweMH5t0HMI7CWcwMBv00yWhLqNOVzobw3F7rbvcSwmntbch42EPWWGoxsDtSIr
         IuTIGzYaSgyTTnESNV7XoTA5mmOphbBHbsyRjhxhkP6M21sxdUQyO+mcgInqJLrH/NSI
         sS7vpCt1G/c6CdFE92iWwMpo8JlS5B42M7O744BG0B6glpAvykinF2rxul2pq8UPYMe9
         xwkMYb4FtiSHBlqcuyFz3OOeg2gIbgod3X9hI7D1U6M1G3MBUP+h85EQfcp6lwtEg83q
         quh0ToOTruSSuk3aa+IiUBO8Vr3TvVz850Oc/eTz9tFKDDvIDrSfyo2G40sFEytHGGRb
         fOPg==
X-Forwarded-Encrypted: i=1; AJvYcCUUrutVWRIFuu9A3OZavBVLh+0vc/BhoZLMWjFTzeh8ND0EK59DqCnvQ9A9tf2mVy8UY2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Uy39cQE1TsqA1H8m7FM2GrmbwMsiaLHZp+mZtZjVKA37SRgU
	q+RhSarnostUtdVUJfiqdXy320f5MX424Uh6cZei/I9o26aK9X7Xh+GEKhBBcESp4zv41uh5zPW
	hA70TmOBUMVBXlrgGIqkmjimKh2e8tsrCyfjwNRyLXOTv5KFf1w==
X-Gm-Gg: ASbGncstxbyTtrjmxqRUGW5ns6Oz/uimELpa67b76c6asG15Sr0R7q2fNmfWZcH1gjd
	daZdunDPsTbLV2OU/bu8GPHyaIES/hy/p/paJd1M5om/Erj1+5p+zhaFj/lsuMk7f4Tk472yeMW
	5Od6UNjYpXxrQwdKy+6HU/zKbDrMbNb2ExNjjl/Hr1K3Yzc7OUx4veZR6WYuOSQ96H2qPJR03am
	OwnusacBeSWiv5+1IIThSAfS4CzA5pf5cXkM4WUiQ2IpE5tyzSgV0rMPB+3gYgpNUaAhAkdy6hq
	0ioZ1CXUwBkoldruI0aXTArQx5DGexT9vH89hIRJYbd3cA==
X-Received: by 2002:a05:600c:3b04:b0:43c:f44c:72b7 with SMTP id 5b1f17b1804b1-43cf44c7703mr98398765e9.14.1741698528838;
        Tue, 11 Mar 2025 06:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHg2xJEtdcFy90P2VzdKFh3p/fCZJcgu7H/volTSsPrNEA8I4PMuG+4jYjYdTWL3xOUsvL7A==
X-Received: by 2002:a05:600c:3b04:b0:43c:f44c:72b7 with SMTP id 5b1f17b1804b1-43cf44c7703mr98398315e9.14.1741698528418;
        Tue, 11 Mar 2025 06:08:48 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf3ca4f5asm82801875e9.12.2025.03.11.06.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:08:47 -0700 (PDT)
Message-ID: <72cd7f5a-ab92-494c-b7f8-4696d23ed4b1@redhat.com>
Date: Tue, 11 Mar 2025 14:08:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v11 0/4] fix the DMA API misuse
 problem for page_pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yunsheng Lin <yunshenglin0825@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org
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
 <87v7slvsed.fsf@toke.dk> <40b33879-509a-4c4a-873b-b5d3573b6e14@gmail.com>
 <875xkj1t70.fsf@toke.dk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <875xkj1t70.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/8/25 3:40 PM, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
>> I only took a glance at git code above, it seems reusing the
>> _pp_mapping_pad for pp_dma_index seems like a wrong direction
>> as mentioned in discussion with Ilias above as the field might
>> be used when a page is mmap'ed to user space, and reusing that
>> field in 'struct page' seems to disable the tcp_zerocopy feature,
>> see the below commit from Eric:
>> https://github.com/torvalds/linux/commit/577e4432f3ac810049cb7e6b71f4d96ec7c6e894
>>
>> Also, I am not sure if a page_pool owned page can be spliced into the fs
>> subsystem yet, but if it does, I am not sure how is reusing the
>> page->mapping possible if that page is called in __filemap_add_folio()?
>>
>> https://elixir.bootlin.com/linux/v6.14-rc5/source/mm/filemap.c#L882
> 
> Hmm, so I did look at the mapping field, but concluded using it wouldn't
> interfere with anything relevant as long as it's reset back to zero
> before the page is returned to the page allocator. However, I definitely
> missed the TCP zero-copy thing, and other things as well, it would seem
> (cf the discussion you referred to above).
> 
> However, I did consider alternatives: AFAICT there should be space in
> the pp_magic field (used for the PP_SIGNATURE), so that with a bit of
> care we can stick an ID into the upper bits and still avoid ending up
> with a value that could look like a valid pointer.
> 
> I didn't implement that initially because I wasn't sure it was
> necessary, but seeing as it is, I will take another look at it. I have
> one or two other ideas if this turns out not to pan out.

Another dumb option would be storing directly the page address in the
xarray, and avoid entirely going through an ID. I guess it will use more
memory (the array will be more sparse) and will have more overhead, but
could be possibly simpler?

/P


