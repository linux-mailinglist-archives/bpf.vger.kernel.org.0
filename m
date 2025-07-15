Return-Path: <bpf+bounces-63316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD254B057F6
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 12:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6468E3A5BA5
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241792D8783;
	Tue, 15 Jul 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLRq7Wkd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8826FA5C;
	Tue, 15 Jul 2025 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575782; cv=none; b=mbPM6+EgmJngvIxPjTV3ZzEA9K604hWOuKvQkQLLXS/3OsAOjP3ObqoagA8hg4mjzWP55hgtOypAdSUBiXvdABCT1pmWBoxeWZyqug1vmTUzd97ta44l9uYUnjWVtSNuPCQpyGHxPZ9d2Ficl/Qa616M1Z0xIeMlfIb0c2rF+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575782; c=relaxed/simple;
	bh=F+tYOXJ8hjiy2s7ICd+QbNKS1sdyZsQBpGzRhNcc6jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvS0HmwWN4rpr06EATS+0a/HqWTKmvT4x5yFePkxdrl2HasSO2Z1jdkjF6KfTt2U4dA6KftBGeX3hlIo9UIZ1HXt+Hfa5Kx684lAadfTM8jdr8Il40Q6S4cYVB3j+P/g6uLfm2z1rSF99TxZWoY9m8g+2kGawystLagAClQJuVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLRq7Wkd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so8828084a12.3;
        Tue, 15 Jul 2025 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752575779; x=1753180579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwJj2XW0Xtg7vWbGRjw0IzVQ1p4FfGBNG+AO9cOWVHY=;
        b=jLRq7WkdZMcSiLTaLVo7wsMRPJhu8Vi22rCcac22t1+fk9PVHtmbbebj7bFJYtEsj3
         YXawYvu3CGGetIn/4FPdpUFhTc0HE7aGDO92BvrzCbPM4YQJljtis07+KKJXHM1ipEq1
         TEKJrMwGfiYZ6zXjdFmK74Uy1O5ajGflD7JLCKbGRnYY1abTUmreKlXHJuwCFycuDmvh
         jXHpyQd1I/sWmfzpOiMpgFnXf2aGn+TKz7H2Ilrac9oEWnIK2/wENKSSkTYf1W7JkNHC
         TjDfrYWlw672+tyk0aA5tEOQ7l0n/l0FxN0LSdeEw/DD9h4RW71cWPitgwSxOZkJuL9Y
         5eaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752575779; x=1753180579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwJj2XW0Xtg7vWbGRjw0IzVQ1p4FfGBNG+AO9cOWVHY=;
        b=fRX/gvWiP7kNG0x/Tou2BwWsyQGD7FmbeCN3nhjQrmzTsR/tLIiJwDixcYovTFAxqB
         96aHcgAsLV+SxQvnOR1g4BqwCSzICyBWjkfFBjhhDhlaPa2aAIghIXRdSWyedAXhGUs0
         nEkxr/JwfbTuKnxGj7iRIfJzf0giePzfE3/in7/hskj7exFTCfaEiL4rWbQq/gtIVIPy
         Qra4NdMV67KaDuZr8Wi2ayuIgsBXWd9GuVC28lVbinge2GPbXzHlkKW0OwLaVUfXdb8A
         xBILe0sRpkhzzdY1IsdgVapSOHFoZhVHeCUFo3B8Of2FOv8bpw1gRVI8ngX2REv1rWsP
         9Kyw==
X-Forwarded-Encrypted: i=1; AJvYcCU9fiQqqiDjpOj+Kig2Q87XSpJuhWG0qBZIMPLe6U9ET8yH4uw9T+ClUaOznlrYvA2xMIOHKfaOi78ra3G1@vger.kernel.org, AJvYcCVZsnhDbiyE/JgAah3tzPW2f+IQZjpMi4Hhz3et+UtOugLx4t78bDjM5nRJs6bmqx28poY=@vger.kernel.org, AJvYcCWhavnj3O1PTKR8zI9QqXyoHXmtaZWLzPLTEtxtT0Qx5GtxzazpofwNq9Tg/aCB4TAIbGT1Iu0G@vger.kernel.org, AJvYcCXazEYsKl7jAoKhtxP35zuL0x2hOTmN7amcCte9N7aWsiZFmOHYxML6TcOQ/jYowugySxCu/X0dq0V3x7SkAgA=@vger.kernel.org, AJvYcCXpeKODxpGM2n1jjr6eqi6EvZ16iUVKvQUYP4I/hvWoK6YMxaXYwsNN/jwqAOeG4IvJzdqKXRavaoEHHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyteToK/UTJ/hBhdG31uTCfny/IppUCtdnAPOwA84yr/M+/vQf
	tp9UIW2JtVkdcF25ESyoSnZeiLbJi+Wyz94Wf3InBToNa1LMmVZzG+Ic
X-Gm-Gg: ASbGncu2a/IUk7obcDeeAYwrV6+/LBvFNWTUt/AEE5tJpevr7bq39I4osD2lLd0Hq6W
	Ei7E3Fnojp7r3pQF9PcNFJREBhxTy7XVPJnWfooWshbz2gKSONe6hRyb3poGZYb9d1mUzDCudI0
	S0LQ7AeuWHESjUAvpJ74DMopQhYY8VOSYZQmnjTALXJftMVdSWQjQ9pP5VS7VvxrgjaDsqeq7Yk
	+z5O41JWFwkPRRPEqpZxfNwivMNt3lRajAZXbANIg74+cvkVqeQHOv/8hPl8x2mvdWiJ+mlunK2
	e0kuVsWmkzy+7spl34zvx20PALOMWNEzdz/LKb7s6GUTPVyc6Elg/TZDb9ngp8+5V8qOrPSnfaN
	R2VjyLk3dFjWdjabm2VZCDQoLbHrFVxJaaB/qEJIjrAmauQ==
X-Google-Smtp-Source: AGHT+IGaK5G3wNkKd0FQXTFLEb3wcMNGQ8G+9vcipY4gHF5O0bM0XfRnvGt5TQBO6UmtOz1kGEnKVw==
X-Received: by 2002:a17:907:930c:b0:ae6:a8c1:c633 with SMTP id a640c23a62f3a-ae6fc1fae79mr1633481566b.34.1752575779007;
        Tue, 15 Jul 2025 03:36:19 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:a4c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dedd3sm976790966b.150.2025.07.15.03.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:36:18 -0700 (PDT)
Message-ID: <9bed2f6e-6251-4d0c-ad1e-f1b8625a0a10@gmail.com>
Date: Tue, 15 Jul 2025 11:37:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of
 page to access ->pp in __netmem_get_pp()
To: Mina Almasry <almasrymina@google.com>, Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 akpm@linux-foundation.org, andrew+netdev@lunn.ch, toke@redhat.com,
 david@redhat.com, Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org,
 ziy@nvidia.com, jackmanb@google.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
 tariqt@nvidia.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, danishanwar@ti.com, rogerq@kernel.org,
 nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, aleksander.lobakin@intel.com,
 horms@kernel.org, m-malladi@ti.com, krzysztof.kozlowski@linaro.org,
 matthias.schiffer@ew.tq-group.com, robh@kernel.org, imx@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20250714120047.35901-1-byungchul@sk.com>
 <20250714120047.35901-3-byungchul@sk.com>
 <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/14/25 20:37, Mina Almasry wrote:
> On Mon, Jul 14, 2025 at 5:01 AM Byungchul Park <byungchul@sk.com> wrote:
...>> +static inline struct netmem_desc *pp_page_to_nmdesc(struct page *page)
>> +{
>> +       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
>> +
>> +       /* XXX: How to extract netmem_desc from page must be changed,
>> +        * once netmem_desc no longer overlays on page and will be
>> +        * allocated through slab.
>> +        */
>> +       return (struct netmem_desc *)page;
>> +}
>> +
> 
> Same thing. Do not create a generic looking pp_page_to_nmdesc helper
> which does not check that the page is the correct type. The
> DEBUG_NET... is not good enough.
> 
> You don't need to add a generic helper here. There is only one call
> site. Open code this in the callsite. The one callsite is marked as
> unsafe, only called by code that knows that the netmem is specifically
> a pp page. Open code this in the unsafe callsite, instead of creating
> a generic looking unsafe helper and not even documenting it's unsafe.
> 
>>   /**
>>    * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
>>    * @netmem: netmem reference to get the pointer from
>> @@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
>>    */
>>   static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
>>   {
>> -       return __netmem_to_page(netmem)->pp;
>> +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
>>   }
> 
> This makes me very sad. Casting from netmem -> page -> nmdesc...

The function is not used, and I don't think the series adds any
new users? It can be killed then. It's a horrible function anyway,
would be much better to have a variant taking struct page * if
necessary.

> Instead, we should be able to go from netmem directly to nmdesc. I
> would suggest rename __netmem_clear_lsb to netmem_to_nmdesc and have
> it return netmem_desc instead of net_iov. Then use it here.

Glad you liked the diff I suggested :) In either case, seems
like it's not strictly necessary for this iteration as
__netmem_get_pp() should be killed, and the rest of patches work
directly with pages.

  
> We could have an unsafe version of netmem_to_nmdesc which converts the
> netmem to netmem_desc without clearing the lsb and mark it unsafe.
> 

-- 
Pavel Begunkov


