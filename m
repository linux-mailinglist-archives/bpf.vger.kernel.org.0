Return-Path: <bpf+bounces-63702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B36B09FD8
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 11:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF27A86F4F
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F5E223710;
	Fri, 18 Jul 2025 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TojAV+ph"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF9221FBA;
	Fri, 18 Jul 2025 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831073; cv=none; b=Bo/CiFEVR9s6rhU36hddroU5LMbjhdoUBYvF7oG5z449MZ8O1ICTSosKVnxLqMLN8TB7yqo9DVtUYeyK+iYiyxIOsgjdDr+knfafJZxJv4TFxcnwaXeZrKLgEkLHfHCZuyPsg0WTaHoxCq/R4uhA62O3ydEmNh3nzEJu6YolvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831073; c=relaxed/simple;
	bh=bhe0zcLGy5GklMgwNIQG4xyAuKnkHHvNVTH7d7Uwzqs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q/7s1MlWFbFrqKG1so033sfP0hTdPF8fhMcAUZ7nuQFpfUjFuSBTJ5Jx+VL/6hmkcYbkje4Q6CpqUsQbFjAVDf36sPQeZnMPp/iL+n0c6Yv8Ru14kiHYC0vLoolJbzJfFRZl+CjlZ8q5ylw7dcdSjImSzq3kz/KEVJvo4G33ahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TojAV+ph; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0e0271d82so335662866b.3;
        Fri, 18 Jul 2025 02:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752831070; x=1753435870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjU6nrqfbiw0u0TIKCSt6roZUluHkikf0/decEoYNJE=;
        b=TojAV+phUnHpE12r/iHX2Yz5o1m1dHl06PQjdp9hkZkG2NK8Esx77EPg0wLlqaUxNu
         tctMMIYbwuUc5YcXn10of94ELvmSnWF338zsp2WSdV2oYBDCCwDotnPBWqzBGfK//lHF
         Cykj6z0MeXOxzYbxAHH7c8PoMEFwGx8aoREWzwvs2qwPeO6g2eYZlzNuh0X6yQk2VTbq
         Bec6zemUETdlEU70WqC35z1TCAU26n7irzebZIScMGDHAuvzVhM1Y2YneCqx4hlfNrZD
         ACWuT5e854cuKEIcIftQaZTO0y8UeXbzC2dyW1o2yjP9cBggKn9yiy/N/lYlmpK+S+DI
         ovXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752831070; x=1753435870;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjU6nrqfbiw0u0TIKCSt6roZUluHkikf0/decEoYNJE=;
        b=Euh1x1iLF0m9JyM7qRzEDe+SWE9ug6FCDU+3HZH1fkeigc+qn3VVuuQeTjzvy2c5bb
         GnliDKlmTl7cjHzkUzKMrcMuygYDYAlLzdGQKafRrK1x6LNxP2t7GK8bc7nouR9gck/e
         pQLzl+fY8Fc7XYGefyrq0de1cN4t9Ik1ex+jsaQUQrMEm8dbiem9k3maQ8BdXfaw6RaL
         HD3JX7jk3b0QyWT8gEP1LydDzHc8kzNMSDZ4mhpZWJeqQfH5aUnoCD67osNr0z2TMOT2
         f20ecTPtHjaT/FMTIobJ4OeSfG/eK4kuLaE7OfFqFtDZoHVhhUc+wYuCnNxyf/Yfc8tO
         hs5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/SEAb1QSTRVTYxTZvGtYnYSAf60PTNrci+hYHVK3IjtbqHb5gcQirYD/Z6R5C9j4lsJiUuct9@vger.kernel.org, AJvYcCVpN5zFb68TecQJMhzZ9P9OMHeAHaZMyW7uUF+kLJkHKpPVX9PbQwW8QKbDbFeapdImwXs=@vger.kernel.org, AJvYcCWX+X9G4DBg0C7GZslYMkEAYAKARDmAxdpsZ9sMnL19hX/7CsWl6kUO8UmxPdTbsyR7emWOlQTXKpirIfS/@vger.kernel.org, AJvYcCXbl/HMjIGDgCSL89VU0iGPIvzbLfsROUEdinG0vv2wuYirBuFqZX0i/anxO06aEzfbRoUGmUqc6fovRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDGTrJhIRmvcomt9EktZGqAbxKu1DGpK1S5kkZRpViYHVJntym
	f/wrs8CrFnoUGHny3CrMpYydsEGjV/ctgiQvd8g40uDWuOvLDRYjNo/x
X-Gm-Gg: ASbGncu4GzhQS4NUzkjM1GbBgR8LSf6pVr37zAFrm/VXU8XP0yFupWE2G5/NDFdSkV1
	M2dk1H9L/gN2XbLj9gkfvPxawTtLK5+G3sNGFcPV985Fyng1qEjnoC7oa/HXEc+RiKsPcD105Pk
	mFriq+zZj8xxk0lmbHg22q5MV9BjBY0pWRZPIcsVAgPFLyjnQ/0+EeHB/FkjBFyhBv4eByxm/rA
	Yj8prI9q7jxpZKt3tibWAAnJ+kxrJDQ9kwVmTj/SqqYLb7oiUFoaHYQlMh20+NMWrhEVqCs4PXK
	FqiCw2Z0IWF3RB+2gDelllKrkCcEBQNP6gIk0rYpU1sR25jsP7XoS/hOuskCem6U4xpafnCktXn
	Rr3b1mnw7NXefI7NN3n549vBK90nVoS/gwhU=
X-Google-Smtp-Source: AGHT+IFIqad+0hlUN3zY87QsZXaNiyLAJ+x0TZ9qnNxIHZCIsq6bsPaf5QF99Ci+hSan+dVtZ2on2A==
X-Received: by 2002:a17:907:990c:b0:ae6:eff6:165c with SMTP id a640c23a62f3a-aec4fc41e91mr497084166b.48.1752831069432;
        Fri, 18 Jul 2025 02:31:09 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:6915])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d46ffsm88380066b.42.2025.07.18.02.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:31:08 -0700 (PDT)
Message-ID: <1fe747ea-56ce-4418-92cb-057d989e3732@gmail.com>
Date: Fri, 18 Jul 2025 10:32:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v11 12/12] libeth: xdp: access
 ->pp through netmem_desc instead of page
From: Pavel Begunkov <asml.silence@gmail.com>
To: Byungchul Park <byungchul@sk.com>, kernel test robot <lkp@intel.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 akpm@linux-foundation.org, andrew+netdev@lunn.ch, toke@redhat.com,
 david@redhat.com, Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org,
 ziy@nvidia.com, jackmanb@google.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
References: <20250717070052.6358-13-byungchul@sk.com>
 <202507180111.jygqJHzk-lkp@intel.com>
 <20250718004346.GA38833@system.software.com>
 <20250718011407.GB38833@system.software.com>
 <35592824-6749-4fa4-89d9-2de9caccc695@gmail.com>
Content-Language: en-US
In-Reply-To: <35592824-6749-4fa4-89d9-2de9caccc695@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/18/25 10:18, Pavel Begunkov wrote:
> On 7/18/25 02:14, Byungchul Park wrote:
...>>>>     include/linux/mm.h:4176:54: note: expected 'struct page *' but argument is of type 'const struct page *'
>>>>      static inline bool page_pool_page_is_pp(struct page *page)
>>>>                                              ~~~~~~~~~~~~~^~~~
>>>
>>> Oh.  page_pool_page_is_pp() in the mainline code already has this issue
>>> that the helper cannot take const struct page * as argument.
> 
> Probably not, and probably for wrong reasons. netmem_ref is define
> as an integer, compilers cast away such const unlike const pointers.

Taking a look libeth, at least at the reported spot it does
page->pp->p.offset, that should be fine. And your problem
is caused by the is_pp check in pp_page_to_nmdesc().

-- 
Pavel Begunkov


