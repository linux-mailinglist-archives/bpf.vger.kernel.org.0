Return-Path: <bpf+bounces-63701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B5AB09EFE
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 11:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FE47B2436
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 09:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB10C2980A4;
	Fri, 18 Jul 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co4gKkvF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91C8207DF7;
	Fri, 18 Jul 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830236; cv=none; b=H6EG8QJ7ufWd2oGwCmvx/l75LbTFJi5mqecrxGPIud6ooLnMedb+atQRTo2SP2WYXXpSF9/WBdZYMNWM0vdGtb1HCYTPzPZvm7yvvVshqR8/JKfUfXaJWQP9cybr+x9rkvIP43ihl5CmhMywCvz1syV7NiPooAj4NCCYxFMFImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830236; c=relaxed/simple;
	bh=Fw3ZT2waXkd52WH6dSOHrXUL1IonLYSsmY5LPvFE23I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srpsS2mSSVkSeVweHjz6NjoZfJ/z7CcivcnABEm1WNpXFCQ1wrmODm6wwAr8EHuHa7zUnLKWHmS+A8LVV0qDaEa54tJE1aZFtXeN20hSBbzFc8WvAhBpSV24nD/BeYpgG/MFQ10JUg/w9Q2OGNaH1N55cIFoh/uTlAPWzEbOW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co4gKkvF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so3057092a12.2;
        Fri, 18 Jul 2025 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752830233; x=1753435033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQt5WkoSDJsxA1BJMl3UO35qCdstjQjYzU9xXXTDo18=;
        b=co4gKkvF6inHK98b6s4f5uK6YO3m/VlU3WN+2+qQaudKb2ZIxxPN0sbC/QV53HAj6l
         gMcKptL1JI7ssi3rlPBVp6M8deZJ8CmtZfzVjyb6i85X5aIy+LBc5DIlhC4S34KXS7cL
         54Xe903ECJBJZx9oRs/egbRTKWpLWzCMAY5MWJu/gb2tGjwkbQ4Rh+XcQoIQtp8Hiq2J
         1uu0v8S6tY3hSysBAI9wv97vcvjQhbuXRivqMunzLaK/PkSn0sbQvLeKEYfziEar7n+w
         /c1kyV7MxHBRyHAzFw4LQ3se4Dyu+r5rMSDZ1cqK4BdtK4YDdSmz8esT4dXMf/1NUR9t
         o2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830233; x=1753435033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQt5WkoSDJsxA1BJMl3UO35qCdstjQjYzU9xXXTDo18=;
        b=HZyWxmL4kOi98ZrBEgQvNAD6hDRuoijr7jg5/96itIpBP+Yg4e2Ni/iEWCvL57svkI
         v5398MpVnWdTPB1+y8/t2r0QdT2D6YpLLT3/lbEI7RVJQibv3jcxU9eYWoO6GWYzu9Ls
         Z9Y3duEhfefyfNiWuNMNcXCzScC3E4oeUpekaq2IijwDDD3wy/HijWx+f5pNKcHnm4qt
         YQPQN9gVOPfiKs0XKHaH39hnZI8Uwm8pwj4yoNwLB5tVegdfLaSU2OvdXtD+LtD9waX9
         LVPxuluSVBh52RrH0VOkgoqKMGalvVf1nyj3Bpj+U0X1XkhTpAsLj9WXoZegkeBAWPz4
         zpyA==
X-Forwarded-Encrypted: i=1; AJvYcCU7UpcD6ibzjDV10GBP9gyf4QI9TNFgjlDBBnyh7q9glcCA/d1zcfQppZsm33yScTmU3+eOtfrHErYDgQ==@vger.kernel.org, AJvYcCWs/QfPI+CJgJp6VzbFdsUo3lL/961vDNTgfi0NxriDqKLK7OZf+I+FpA7nIdBwPNMwO7QlnvfR@vger.kernel.org, AJvYcCWzC63zWMekgjcF9nQPYkrxbcHOaQM8C5zrV/Xt1FTDJdReeHC7dVAFImdlqtjMgj5uEoH+jtoPJOFkEbQw@vger.kernel.org, AJvYcCXo0Y0u1sqz6ekt7kPnaqyJ/krtMaIFLEEery1NAPNAJMsWF9hiRW9Lol0eFOk6raoE9rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzZzDBc/YY6FKzVawFvMXwygXevirdoxgLb2JNddaWFv7Sbmd
	QSP/DRb8sQswCw1hNt0xXgiXenmZUJT3Q4p3V7MMZRvH+ATDPmHrnfJt
X-Gm-Gg: ASbGnctGe01sEjlSPl6OW8FESmC6MNEjCeT/gYIGr+WXDOnonvQ9sdqFqt7nfXIxvOB
	/MAV8wl8h5zvSgixZJHFf3JDWBOKnZNSHKHa4lGW+C/CH2FZrQB3rzW2mlnvZ6/ZyjGk2MWqb7r
	hv8fNh4liMvrMIivpB/2V+n5EIbOnhPmIRfM4kMlxuIikRflvGLU0eCWsv9lLU9KEUyhR1NC5nH
	qXcz6mCRXyX70mPF4/7jojBdq6QYxckSg2YxWnQNlhkbNHe3domBwH/hg9d8zjnlyL4LYzNk0/z
	QQHVxqxexfak6lWRUOCAblkK3L9KTN3w9GE0/+zLMynCIgf4CbCWQ1ls50S1hLIPIkI26egXWRA
	muLwnmKVBsE9B3fM/FDcww0b/m+UD8CTkZ1Y=
X-Google-Smtp-Source: AGHT+IHJ6Qkjj0/27EzE9VVfOI7xbm7fY60xnb0OKnLRmHC6l4c5UZ1MzUN+MM+C38ZmrD/ZAYQsDw==
X-Received: by 2002:a17:907:7f24:b0:adb:229f:6b71 with SMTP id a640c23a62f3a-ae9cddb1d86mr1032671266b.5.1752830232698;
        Fri, 18 Jul 2025 02:17:12 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:6915])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6cadd8c7sm84561966b.155.2025.07.18.02.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:17:11 -0700 (PDT)
Message-ID: <35592824-6749-4fa4-89d9-2de9caccc695@gmail.com>
Date: Fri, 18 Jul 2025 10:18:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v11 12/12] libeth: xdp: access
 ->pp through netmem_desc instead of page
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250718011407.GB38833@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/25 02:14, Byungchul Park wrote:
...>>>
>>>     In file included from include/linux/container_of.h:5,
>>>                      from include/linux/list.h:5,
>>>                      from include/linux/timer.h:5,
>>>                      from include/linux/netdevice.h:24,
>>>                      from include/trace/events/xdp.h:8,
>>>                      from include/linux/bpf_trace.h:5,
>>>                      from include/net/libeth/xdp.h:7,
>>>                      from drivers/net/ethernet/intel/libeth/tx.c:6:
>>>     include/net/libeth/xdp.h: In function 'libeth_xdp_prepare_buff':
>>>>> include/net/libeth/xdp.h:1295:23: warning: passing argument 1 of 'page_pool_page_is_pp' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>>>          pp_page_to_nmdesc(page)->pp->p.offset, len, true);
>>>                            ^~~~
>>>     include/linux/build_bug.h:30:63: note: in definition of macro 'BUILD_BUG_ON_INVALID'
>>>      #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
>>>                                                                    ^
>>>     include/net/netmem.h:301:2: note: in expansion of macro 'DEBUG_NET_WARN_ON_ONCE'
>>>       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));  \
>>>       ^~~~~~~~~~~~~~~~~~~~~~
>>>     include/net/libeth/xdp.h:1295:5: note: in expansion of macro 'pp_page_to_nmdesc'
>>>          pp_page_to_nmdesc(page)->pp->p.offset, len, true);
>>>          ^~~~~~~~~~~~~~~~~
>>>     In file included from arch/arm/include/asm/cacheflush.h:10,
>>>                      from include/linux/cacheflush.h:5,
>>>                      from include/linux/highmem.h:8,
>>>                      from include/linux/bvec.h:10,
>>>                      from include/linux/skbuff.h:17,
>>>                      from include/net/net_namespace.h:43,
>>>                      from include/linux/netdevice.h:38,
>>>                      from include/trace/events/xdp.h:8,
>>>                      from include/linux/bpf_trace.h:5,
>>>                      from include/net/libeth/xdp.h:7,
>>>                      from drivers/net/ethernet/intel/libeth/tx.c:6:
>>>     include/linux/mm.h:4176:54: note: expected 'struct page *' but argument is of type 'const struct page *'
>>>      static inline bool page_pool_page_is_pp(struct page *page)
>>>                                              ~~~~~~~~~~~~~^~~~
>>
>> Oh.  page_pool_page_is_pp() in the mainline code already has this issue
>> that the helper cannot take const struct page * as argument.

Probably not, and probably for wrong reasons. netmem_ref is define
as an integer, compilers cast away such const unlike const pointers.

>> How should we resolve the issue?  Changing page_pool_page_is_pp() to
>> macro and using _Generic again looks too much.  Or should we?  Any idea?

page_pool_page_is_pp() doesn't change the page, just make the
argument const.

bool page_pool_page_is_pp(const struct page *page)

-- 
Pavel Begunkov


