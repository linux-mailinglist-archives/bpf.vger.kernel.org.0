Return-Path: <bpf+bounces-60895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AF6ADE4D5
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 09:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA633BC970
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 07:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EAB27EFF3;
	Wed, 18 Jun 2025 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLiVYhfd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB3253941;
	Wed, 18 Jun 2025 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750233020; cv=none; b=MRe+4o1pCgvInNwbRcyGbEg5vqgxu9X7BGJFR0Nrn71zhiorpyWvwMvXk8h0PEgNQUj/yX33H/ofMrlb2se0HG8NLJtWuSLP39N4OPO/pt33UOqbkv44cLluXPAKRpvyg1knNsz065HJYLNI+Xm4/p98HerucyXDQ2eVpiSwNo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750233020; c=relaxed/simple;
	bh=MeaewijDxGT7gmruAwpRJWBbB70dS3bLaAjXvOgPHwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGVCD7/ljbk+QIp3utGupnAzfSDv+J1L9DLRtPF81MBiuUH2+onyrcmFvWtMVwb83FD4pvOIKAvvg4kk3NDe2C40B72a35Go9XFG1UoTD6ggzdIaJ2A2qRTutz32Pgg6bp5qgW1qQhaO3SjDak5BvKkF1FA78gtQlRQKETEYaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLiVYhfd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6097b404f58so4343882a12.3;
        Wed, 18 Jun 2025 00:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750233017; x=1750837817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECKn4hQ4bwsuqfN+mIcN9gog+ud6vUM+tBu4MrCxvDU=;
        b=YLiVYhfdM71EjctnCasm/N0SVZd5z9eSKubgDXw0dxv2a/6upz2zkR/p0swxKshB5h
         sl3363pYlZpvcL8ZGr/uZ+396CPcoahB3dbD20pAFl98Pw8BvPXOasBjSursKjm3May2
         KEsh51VWGzxoFB9/ufqegVvBNeQQr8kk52TEd5tai626OQUsiorlQbO+KsFEM1E+t2gV
         XxUOxmAU/O0036LTqafHWmneexHhEc2FRQf5CbbHOUIy+ycSrqma6JcNa6Cs0+OQJzj5
         /Ogdgt3JQRng32oGwj4Fri0EczxIwvUPiMF+jl/t8Wx0KZ5bjzwYoczX80dbk836d/ba
         ZySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750233017; x=1750837817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECKn4hQ4bwsuqfN+mIcN9gog+ud6vUM+tBu4MrCxvDU=;
        b=p16EcuCTHpfXUX76vLIIAykxhKtHfY5qAYX0NcfbR+rmHbLbhq7/BLQ/DHxT4n2787
         5oP0J1vhXEcjS3WprEKxNGmeh7m2AY9vyrMfmRfHCUXFrRoN1Z7uVuRkCv2oMAUQghhg
         yq6SugQeq72VC1sZKTY/LnSvA2vi9HEd29R/ul/7IJJnjcF1XDB2yliVm0EIi3MGDb7h
         85qdpl+nh4s+zqbqi2EfO9dMos91b6boKdrt+a6QPs3FI8fk1E7UB68aYavVt2hN9X0o
         PrXYiht7Q5mtsEya3cUNlOMzYZcLYBK98EzCNp9ACF30lhcXO6s7K0z4P0U6g1fFHKgT
         t1OA==
X-Forwarded-Encrypted: i=1; AJvYcCU33/AZDVWVbXONUjpPaqX6BI9dVjSmS9iEa+d+G3nmIMcLXQUhW7AtUdCBB5r9AtTJ19c3maSMKCftJg==@vger.kernel.org, AJvYcCWBIC/HleNOSB1pr8ocmEFUsNHOsQc3PDEalB4+7PRf9qOGT5A0VwGFJCsxxpnO1W2ms+xwJYWZ@vger.kernel.org, AJvYcCWrctnx01q1/faDBeU1weL78oB68NAiZv3QOFujoUYeZkEyt96kVPakYT0DREay2WeKjIk=@vger.kernel.org, AJvYcCXORg2dWiT5f1W/ROO7vkvvYbnL0Cq6yiKR7Kc/PD2HF05CuPsVyhLWF9g5xyavcUkOds37YC+G2qoYbAQe@vger.kernel.org
X-Gm-Message-State: AOJu0YxQHvr/aRTSqFRYhjT3EBTp9JJybUTstofQGY53BHWkq64/FrPG
	acLmeI22lGlsatsgW75qCQ7mRKXHhZRPeSQ4gmgmTiYSU/ldb3/pOy3w
X-Gm-Gg: ASbGnctLyHwiJW1ZIxLs8cXq4iQpDR4H38H1OHF8wjNcg/QUgoXz1VlL+Hf7Ed1bxXJ
	qCgiWub1dWtBg7X16PoyKEzolNr1/yoWTGV/b2yyOiuVrCeCeomtuUJotgb/vc40NS6yqGbZ+xo
	yllfhMIf0vEwWcfvKNQpz+eTp1A0cPNgZ7qS3FzGnN0fnozMuIKeGVO4z+mgFgGTVxVPVqgbZYc
	yTb5QAzlhxSDyLVsCm3iE1D4/rPgt0acVAffqBLtKGMD+jCIRvyZubs3QJ6KuSPdKt5GE6vulI0
	ltKMZm1QiaBYzA9wQ9jTQSbNPKYXhuaXyccALl2kHhTnHoow5eVwxk1TeGXqz2UVt3HVdZsULPQ
	=
X-Google-Smtp-Source: AGHT+IGU4+U2g1i+YBxoe05CktY6r7Lz+Sv5ZqQdL+2ljUCgejgb3V2iXZawdXMuMofP/og+uhKFKw==
X-Received: by 2002:a17:907:dab:b0:ad8:9428:6a3c with SMTP id a640c23a62f3a-adfad31ccc4mr1575311066b.11.1750233016473;
        Wed, 18 Jun 2025 00:50:16 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::2ef? ([2620:10d:c092:600::1:ae0d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff1a1sm987202266b.89.2025.06.18.00.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 00:50:15 -0700 (PDT)
Message-ID: <72e9f23c-58ca-49c3-baee-f76b91d093ff@gmail.com>
Date: Wed, 18 Jun 2025 08:51:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: netmem series needs some love and Acks from MM folks
To: Byungchul Park <byungchul@sk.com>, David Hildenbrand <david@redhat.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Mina Almasry <almasrymina@google.com>,
 willy@infradead.org, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, ilias.apalodimas@linaro.org, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org>
 <20250610013001.GA65598@system.software.com>
 <20250611185542.118230c1@kernel.org>
 <20250613011305.GA18998@system.software.com>
 <CAHS8izMsKaP66A1peCHEMxaqf0SV-O6uRQ9Q6MDNpnMbJ+XLUA@mail.gmail.com>
 <aFDTikg1W3Bz_s5E@hyeyoo> <129fe808-4285-48fe-95b6-00ea19bd87af@redhat.com>
 <20250618000840.GA23579@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250618000840.GA23579@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/25 01:08, Byungchul Park wrote:
> On Tue, Jun 17, 2025 at 06:09:36PM +0200, David Hildenbrand wrote:
...>> 1) have a dedicated data-structure we will allocate alter dynamically.
>>
>> 2) Make it overlay "struct page" for now in a way that doesn't break things
>>
>> 3) Convert all users of "struct page" to the new data-structure
>>
>> Later, the memdesc data-structure will then actually come be allocated
>> dynamically, so "struct page" content will not apply anymore, and we can
>> shrink "struct page".
>>
>>
>> What I see in this patch is exactly 1) and 2).
>>
>> I am not 100% sure about existing "struct net_iov" and how that
>> interacts with "struct page" overlay. I suspects it's just a dynamically
>> allocated structure?
>>
>> Because this patch changes the layout of "struct net_iov", which is a
>> bit confusing at first sight?
> 
> The changes of the layout was asked by network folks, that was to split
> the struct net_iov fields to two, netmem_desc and net_iov specific ones.

That's right, and the moved fields should never be touched without
checking that it's a net_iov first. All of it will eventually converge
to netmem_desc without net_iov sticking out where it shouldn't, but my
personal preference would be to get this merged, as it's a good enough
base, and do the rest on top.

> How to organize struct net_iov further is up to the network folks, but
> I believe the current layout should be the first step.
-- 
Pavel Begunkov


