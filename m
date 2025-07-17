Return-Path: <bpf+bounces-63580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E060EB08916
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC44188B984
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA31288CA4;
	Thu, 17 Jul 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRMpg/3c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE05912C544;
	Thu, 17 Jul 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743758; cv=none; b=RVXebvS2gWKxZbv1XP4JLMMY/n0GQZZbOgIf+sjmka1mgFwKTQkqrC8gnedoxgUYeVc1384XJStxVx06Tu3wfNzrwNlHyjpSXLdu5SGfirGIZsndfrv60hZQ5EMSfIoKbYmjDYJHWlGFMAZ6bctRCz4sQZEG4UD1So4goW/Kl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743758; c=relaxed/simple;
	bh=7xiU6lQp5gZes9PPa5o+K6K/0XTTIF97z1CduNvdwPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8+pg/vR/beXdzLUNe+laAdvBjv2JlKl8wQnC+z8aWiJEnmxivniHkINg4231cQVDoQXibNL2fLWXenehnIi4PE/P/vbJ/xbNntjivT7rpqMXgmM27Gc9lJTRLLuKmyuxNSnklWXSuxW7YSkcD2fpYKURwp3oy8EpglopKPQnYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRMpg/3c; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-adfb562266cso123622666b.0;
        Thu, 17 Jul 2025 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752743755; x=1753348555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XuQuLev07eyWeKHWKCNdTOJWBDIr2mJkHs95ZW2/jJQ=;
        b=LRMpg/3cLLdpJvFqJGGaQqJ3LxQS8SZzFGKBWTIqPrPXrYIeiFHNVO/oZ/YGE+Z4Vj
         5bnP9+PbRq2kRgbQBmHKo00Y4oEOJXwF5ruKUDjNp4L9UjjZuX9Qb/G7JiIPuIUUeyXU
         OPQicYbFX3BhW+aXO+GF6m0n7bwpPx6/rva/y9TVYaNbKCbYDnvC3R9o/Loo56NPHgIp
         pYK/2yDmdWwo2miqCUwGnGK0FwfKDSdp1ZCNeIUJPLSaFnHTJ0ZbFurNaJxpAw1cDsAU
         pL5Msv8EZxvXcTN4AWbB+bfjrcK14pq4MFuVMQZOGvS8LmL7JC1qQF9jtvEQcaptZdU4
         CpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752743755; x=1753348555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XuQuLev07eyWeKHWKCNdTOJWBDIr2mJkHs95ZW2/jJQ=;
        b=DHDCYmpapE6N11YK+X3t4wXHWacmgdMSjdrqfZAd1E6efJUomLhGoA+6CYfEJW90MG
         O5i7PPZx6ceXcVPX8BYtLwxhVXlXhCk3pnlr57E3a9oXMjoCGdyGOs9kX6xkSL2DWdd1
         UVwb7KaQnlRbw0xhSkGXta1TWHZno+eazAQWIrB2+fx53FxqlI9wjX53Lg0MF4DZ/xWI
         UFCsKMYoS4n3UhnvPihpS+b/wgMkv5TRS2zKv0CHs07cZ1+9qsrxT6SWIU4MnhDuGmpi
         dOsXQ5ol3MPO3ZAnJ0ik5JxEVrER8WFpLuVD/sq3jNa2uxO8LvBs6nFd9TSz0KDWyxii
         Rtgg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Hts5IJiyt6oC25xfiPK1hNWDziJRH5RbBmOMtNUrdV30KbkwPiR/zDggRl84yYwBb0M=@vger.kernel.org, AJvYcCVlz651BlNAzeggwJX77ikNqIp7aHNevlMjJp6KYzoWrhEbrORiLY8WcU7isQ4ts6jLPTJ48AAVFvx91qXaaTM=@vger.kernel.org, AJvYcCVmnjhrxkm+msW3vTotmXV71zlBeSBl1o07ggom6xGrkMZqYdMymFlEXPZP+6FWLe2gDtQw5qpDMly8NiKA@vger.kernel.org, AJvYcCWdwQ5PHWp8DnEq3mkpUVNIDMlnL/XQcBaLHV092iVrdx/zOr9atf1rJwKRJQUaF2FXsVw4ZXszeoiwjQ==@vger.kernel.org, AJvYcCWfkinIl8776SBtBvaLNlzJNdX8H9HJUzeE6jwNW427WlFdihUkKPLyWtOSklMtMGX4PAv0lJca@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCO4TUYWsUNcnraCJjok17itv3Gkt8px9N0dmw5puPOJZh/bt
	PvARvgvZ0b9Z/HbaPUff/tFTOTduoFvPfDQJ81eTmoEk6ym5h17uvfa1
X-Gm-Gg: ASbGncuybiAAGLGbKlXTEhNpIawef5cQNsOTpKmBAPQ2uUv+BUvkfg820QuVtg6sdS3
	Mr/I2a+JHZrp3IxkNSMv+5Ae0idb7xJXHyeNJmpgiejOWlYNHANmz0VJXKZG7vHOLfJqPE2//Ce
	iqjsy3C7kVhwGTvzwsnhyK/1zc5QcJWPJ8HHIVou08neK4KLhSZMpb6QlYKuwF/a8d4/umEY48L
	YQSy5plKQ2AfwAPBVKK3hBwQqld6KqxBChChxv2JUJn1hkpK1ucMglwuXtPVvQWaOTkiFIT1Gsh
	roXv8ubNjdhsgEkflHsEm5Y8n3Jx+Vp8Uu9K9h+h9vfRpJA7zLIZM7kHXNLMuHEgCudL4cLfHe6
	BC0cwKQlat/NxodrnFNEZs3+TfgZKGloGNMo=
X-Google-Smtp-Source: AGHT+IEBp5fKU5jFwU7T/e+ghWZTAi9JtfLyT40aPkuCdbIfMXgA11Q2utS7ZVnD76C8XR+vIqhT6w==
X-Received: by 2002:a17:907:c290:b0:ae9:876a:4f14 with SMTP id a640c23a62f3a-ae9c9ba50a9mr629028466b.59.1752743754656;
        Thu, 17 Jul 2025 02:15:54 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:72cc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611f7365c7bsm8194693a12.62.2025.07.17.02.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:15:53 -0700 (PDT)
Message-ID: <6e4a4ae7-b84e-470d-81e9-a58ecf9c9157@gmail.com>
Date: Thu, 17 Jul 2025 10:17:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of
 page to access ->pp in __netmem_get_pp()
To: Mina Almasry <almasrymina@google.com>, Byungchul Park <byungchul@sk.com>,
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
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
 angelogioacchino.delregno@collabora.com, horms@kernel.org, m-malladi@ti.com,
 krzysztof.kozlowski@linaro.org, matthias.schiffer@ew.tq-group.com,
 robh@kernel.org, imx@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20250714120047.35901-1-byungchul@sk.com>
 <20250714120047.35901-3-byungchul@sk.com>
 <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
 <CAHS8izNh7aCJOb1WKTx7CXNDPv_UBqFyq2XEHHhqHH=5JPmJCQ@mail.gmail.com>
 <20250715013626.GA49874@system.software.com>
 <CAHS8izNgfrN-MimH1uv349AqNudvQJoeOsyHpoBT_QokF3Zv=w@mail.gmail.com>
 <20250716045124.GB12760@system.software.com>
 <CAHS8izMK2JA4rGNMRMqQbZtJVEP8b_QPLXzoKNeVgQFzAmdv3g@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMK2JA4rGNMRMqQbZtJVEP8b_QPLXzoKNeVgQFzAmdv3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/25 20:41, Mina Almasry wrote:
...>> I will kill __netmem_get_pp() as you and I prefer.  However,
>> __netmem_get_pp() users e.i. libeth_xdp_return_va() and
>> libeth_xdp_tx_fill_buf() should be altered.  I will modify the code like:
>>
>> as is: __netmem_get_pp(netmem)
>> to be: __netmem_nmdesc(netmem)->pp
>>
>> Is it okay with you?
>>
> 
> When Pavel and I were saying 'remove __netmem_get_pp', I think we
> meant to remove the entire concept of unsafe netmem -> page
> conversions. I think we both don't like them. From this perspective,
> __netmem_nmdesc(netmem)->pp is just as bad as __netmem_get_pp(netmem).

Yes. It'd great to have all of them gone. IMHO it's much better
to let the caller do the casting so at least it's explicit and
assumptions are not hidden. E.g. instead of

pp = __netmem_nmdesc(netmem)->pp;

It'd be

struct page *page = __netmem_to_page(netmem);

page_to_nmdesc(page)->pp;
// or page_get_pp(page), or whatever the helper is

That might be easier as well.

-- 
Pavel Begunkov


