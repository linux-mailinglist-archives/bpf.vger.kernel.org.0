Return-Path: <bpf+bounces-63583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC8B08931
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849463B9C65
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD7289E2B;
	Thu, 17 Jul 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYmTJz/A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98301288525;
	Thu, 17 Jul 2025 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744126; cv=none; b=aYPu5EqJXvrJQHiUw9TUlalKXO3h66qgCUoVMAY5cg/jCWOH3Gh5KDKUPkdI9mqG2u6dIqbdMndtGLMdWCUHsx8qzqZmAPr7/PgP3VNJCoXnRVWuFodZiVb8IRBdQsi7sVAcmOdjWE5HTi932G4E3qPHa527RfkPn+LT1p8H5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744126; c=relaxed/simple;
	bh=Y8vcLPseK/UXuwRNAw+Cg504FHOBMlHLrWxVdz5/NHU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ioArmCaanBXW2hyH1ItYtstux/sqKmho5370mh8CfRTbcaUSRMQtPkhIwfneJBGVdjMikyKkpRSpWhPt2spn4dMMZRsUOOB2zgFRV1r4w3uRkh5TvYrzW5yp+OpzvklUGv5JjmbZsR0/8hC0LJh1SLLoZacEoQac3EQk46N9SNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYmTJz/A; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so996630a12.0;
        Thu, 17 Jul 2025 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752744123; x=1753348923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i00DCL7LArMdrcvWGazqRQUXotNFwoxDDFzCPluiP0Y=;
        b=IYmTJz/A5Kz6o5+KcC8NCdjg1C37ewDcCv5ici1kBzNYiSf+k9PerHemVgbNpfOuDT
         RQYbFVzUO+ZK9E1akMqj0QMJAaOCEhseAPS7BVdvYuIAp4a7elzcP+Tl64AJ0UvghHe1
         Abq2HxZ6HivRnyAUU1e7jt4fw4Tj3Lzaau5G7YxunVddP4RiEu3QpKdfVNWkANdf/SAk
         7w4uGgU48iURlM+cYS2lbNxT50+sg2M7dHgtWWog0hu4u0JHiUFvRL52KwRuhwVV943n
         CY5eOZIXkP8h3PU/iJAqyagD5wprojomQpp/Crx38H/zAXCtVoYqR36N1kr3Ve0a+5Bi
         a48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744123; x=1753348923;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i00DCL7LArMdrcvWGazqRQUXotNFwoxDDFzCPluiP0Y=;
        b=dc8qsagzR0Pl6jY+RdEKw+lziB5vq5zPZKUSnjAgU1Ypzm8ftvRdXqTWvO0JxVMeKq
         dSbOhSal+5ISlH1fJE6DGOUf0InXn37c/Puj2ZKnqc0Sc63fjb15Amgz+sMwOhpjePo3
         hoPSIabqs8t/rR8k/LGjrmsrCrnovrOj62pYnWO0iuqA3v2LyAhH/Aa8dDuC4AfZ4lUy
         rrbj1cJOLPz9kZ445p8arYfDQCxAsXsMCp+0ZiOE93PIKncJLvP9BsML3RjzbywC5WN1
         xSg7IwNNhdgoWDBBD2r99Of+RRJZZKtOC9p/1bx4SEmIF6w9MVXrc4GsNRVehoCHXUQf
         wHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBR5dsezav3s66SVS+08Jiz8dMgExrwI7s1wYPn9S2tYq0Pfyyj1DNrQg/iaxTK+hgvPp9a8KklA9Zbg==@vger.kernel.org, AJvYcCW5KtPVe4LRsTWhmuu2fRlVpLW95GhxbK+ic7ccOWK1wTvX+Ltq5EcAJghhCde4d3XTTY0wtma9E48Mm807@vger.kernel.org, AJvYcCX7/1P4mnZLaoPQzKWGYcrjsPwvqCPyXhoM9JgW24rluMOJ76RlSj/J5PApHc2RWs2Yv+XYTw7K@vger.kernel.org, AJvYcCXRplMlmutO9nCPeCGRwvgLW+MV9p6LlxaxcS7fis/iQ5s9/TwONa9raYOqsLLcaYauQwVnKTa4CQnzJx18ASc=@vger.kernel.org, AJvYcCXtfJc5srVYq5S/RbiUL9rSv43tfMPT7bTEMp0Bu34RfiYEjtfy8EcM6GOq0IQkmAFz2qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE06uKxhs4loibTCIdyBW7IWrKUTAEzAHXWnudAvprBchFY0kY
	sNTWUDTeFR8CSl0hftpM0IDAZwYu/rgJAFme955MDWpYWtM/DJL8fFk9
X-Gm-Gg: ASbGncvmRB/bn+CvWTaDW7JnIqGiiI2jEMTTnifTnfRCWgEuHRnTcFcsY3NV/cCILgP
	Q5dzK8QDEXu+0KoF3F3KMnJ01SVvjLOiUcebsdF87aiJ+RRIAI2p8rYldFi8NiK4k13HqWC4VPH
	B4MmtUkm+aTjVdMP188skGgPMOzBcfW9MpAyVpOeOqkbQv/XcwI6md7PXH2vzPE4nZyxAq8dVlY
	2I7GjCREOS4ukR5IyqzRahgSirsWnPajBokWex/3cWituowlIFlXd9aYJsiB/BlTkiF49F36ZrC
	oyaGOK8q2PSBDHPCPMYx8c1lD9fkhAnnYdc47BBXF1YHOQONBcWgz0G3pXKfVGvG0jIfM3TnITC
	S6rN2i+jyKNYNL7W76nSeEBBXyL4ll8CoUiRYA1rKb+bk7A==
X-Google-Smtp-Source: AGHT+IEm/CZVfnHKhdEovv47xnxQCwkLFXlL7R6Fz8Q/9sjCF0i+Wwcn8Nmka6MicAHPOBghKdtX1Q==
X-Received: by 2002:a17:907:3e9c:b0:ae3:c968:370 with SMTP id a640c23a62f3a-ae9ce1e8c11mr471633566b.59.1752744122539;
        Thu, 17 Jul 2025 02:22:02 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:72cc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eec2a0sm1338371766b.67.2025.07.17.02.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:22:01 -0700 (PDT)
Message-ID: <325c6297-b47f-43ad-8d2f-276cf70f3d57@gmail.com>
Date: Thu, 17 Jul 2025 10:23:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of
 page to access ->pp in __netmem_get_pp()
From: Pavel Begunkov <asml.silence@gmail.com>
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
 <6e4a4ae7-b84e-470d-81e9-a58ecf9c9157@gmail.com>
Content-Language: en-US
In-Reply-To: <6e4a4ae7-b84e-470d-81e9-a58ecf9c9157@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/17/25 10:17, Pavel Begunkov wrote:
> On 7/16/25 20:41, Mina Almasry wrote:
> ...>> I will kill __netmem_get_pp() as you and I prefer.  However,
>>> __netmem_get_pp() users e.i. libeth_xdp_return_va() and
>>> libeth_xdp_tx_fill_buf() should be altered.  I will modify the code like:
>>>
>>> as is: __netmem_get_pp(netmem)
>>> to be: __netmem_nmdesc(netmem)->pp
>>>
>>> Is it okay with you?
>>>
>>
>> When Pavel and I were saying 'remove __netmem_get_pp', I think we
>> meant to remove the entire concept of unsafe netmem -> page
>> conversions. I think we both don't like them. From this perspective,
>> __netmem_nmdesc(netmem)->pp is just as bad as __netmem_get_pp(netmem).
> 
> Yes. It'd great to have all of them gone. IMHO it's much better
> to let the caller do the casting so at least it's explicit and
> assumptions are not hidden. E.g. instead of
> 
> pp = __netmem_nmdesc(netmem)->pp;
> 
> It'd be
> 
> struct page *page = __netmem_to_page(netmem);
> 
> page_to_nmdesc(page)->pp;
> // or page_get_pp(page), or whatever the helper is
> 
> That might be easier as well.

FWIW, no need to respin a v12 for that

-- 
Pavel Begunkov


