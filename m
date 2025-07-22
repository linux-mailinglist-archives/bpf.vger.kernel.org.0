Return-Path: <bpf+bounces-64066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5B7B0E00E
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0188A188A234
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6652EBBA9;
	Tue, 22 Jul 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6qF6fAS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DDF2EACF5
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196623; cv=none; b=c/XikmrSOftYE0vCY3u+I+GnieQZyxm1OnmHin/69ggNv7O6jl3+sCXqs7C6ZdP5aRHBSn3xMu1ll0tNv9n2ieWxzqJYsoBXESdUZ1JC+z4oumlwOz1Rs8MkD0NPnSPqF4JZC+S1tlaEX42adnl3qAsPNIn8X13hmhmUOHrnOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196623; c=relaxed/simple;
	bh=z2gj5V7u4WprQQoCZFJO+IylNg/HsgVNMYcaqhQgwVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEPY4XKvbyBA3twxKbbAIjIKdFi6emWFv9OUYjkrKlK6sLii9zmn4wGpZoZK8ZzPt7MJuBeKki/0r2yTnBsC88s73h3WRqhiUe16Jqp/5/sG1/cYWWD98TnGTXah+21Z2vmAVkvk12V67N+BqQ9A+80w7kG/aIAi+0c3hvna9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6qF6fAS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753196621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLoXN0zviuhjRHlOKL2rQE3hdCG3gOLWxmD1fwrgVH8=;
	b=e6qF6fASoNrnxqcY2XZ/M9LYqJxkLRhyinXWc7XfGu3PFmUaT5N1YPvUqyAgf3ifsJ4o3k
	oCF1PNUjwls5raYKpl4C7cvzYwH8DjoVuvT7XZlxAXQCTy8p1pTxhrX7Y91+pHlK6MC3SL
	5GvSA8ABZ/rYkTImXab7YojbFkahaT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-3JR06RLuPz-fYI5hReGlFQ-1; Tue, 22 Jul 2025 11:03:38 -0400
X-MC-Unique: 3JR06RLuPz-fYI5hReGlFQ-1
X-Mimecast-MFC-AGG-ID: 3JR06RLuPz-fYI5hReGlFQ_1753196617
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45526e19f43so22946475e9.3
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 08:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196616; x=1753801416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLoXN0zviuhjRHlOKL2rQE3hdCG3gOLWxmD1fwrgVH8=;
        b=dFKdXZYZqwXX969IdA6Ry3Xfcps8es93oi/EU3US7lUBhff1rdDnM9ogiDgDc4M9s0
         PuCYQLuaA1OCtKeZ+uYVhsGuUMNsg2KTtCkoqAMFUCgQ4Jpx9ZSPDgOJELIa29CFw5K1
         7HKVr66xhc33jOPQBi44gAldsJR3OU8CwjO+T04sjRzAhBvRwowyIv2OYIQLldojMkp+
         PfpMyVnyHZTi2ne6s81C0b9QYw4HdSP7OqRjE0obf6wbY6KSLqkzTH1JtRR/yWBGU0zY
         ViZ8DGs88kqwGFs+WUkH7JEtyRCqbHDKK3piqA2iwmdjP+qurxcDytiL0DFwHN0j8UQb
         NsLA==
X-Forwarded-Encrypted: i=1; AJvYcCUtAjKb+V/H1qHI7uGa7RvfreBPBiOFYbJOPn2F3DO5iuOhMTLivNkXdPEzzHx2PMpJV2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEcZtPnsQFL/yQLfJlrp8rFQOjO5GF2Cq7te+CrIE6qHVxqAmo
	iZ8gxEixs+4Q9kJzMGBBk4POLz1ko+8IMHLxwV/ZT44clJLhw/ccrdUb7stCl9hAx1QO8LUQ64L
	TX7PoxTpYtEMrxpKyOWb3DCKbaihJdyszEdwGQByxtLEs5S5I2ZvRiFUcNljSgA==
X-Gm-Gg: ASbGncvIjnzK6msDxj7M3kIJRBZsQhKii7XNduifCVTS4yubSw1qKxkOo+abrCEZOgZ
	QpGWlTDfjI9noMQL13qGyonFoa686WbaxJsd9HlgvXQtmBorImDOTOFbFzzj8BlU/MFBe2gKILD
	SUV2VxSdbxBY0nal0GFjLXtTlDstEO3luR2puOc/FOtsYf3KSxIZxjsUqO5UmOaMdDurY5TTpHq
	zWh/rqZpi9Sol/vHqqozIrxp7gtPtGXwSfa8hJDkUqAeGCzMaJjvYpS5cOjZTW8ci7Rx7iuxHGc
	mDyjOfKgjpYx+JaLB1kz6KqV4hP1FFlvoovcnFzkOrUWkGekcY4721wErQVvuJGDSnpx3Et+mkW
	HSs2FEzk4Pz4=
X-Received: by 2002:a05:600c:8588:b0:456:22f0:d9ca with SMTP id 5b1f17b1804b1-4563bf262e3mr103369895e9.26.1753196615963;
        Tue, 22 Jul 2025 08:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXBjtom7DfrBS3RzSHHM2jEi5VfD/84zxgrNdm4BqqX7Z5GS1hjLJJaVsZOKAqO1uS8F1VCg==
X-Received: by 2002:a05:600c:8588:b0:456:22f0:d9ca with SMTP id 5b1f17b1804b1-4563bf262e3mr103368725e9.26.1753196614818;
        Tue, 22 Jul 2025 08:03:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b73fa43sm131621725e9.21.2025.07.22.08.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:03:34 -0700 (PDT)
Message-ID: <eea3a104-1cb9-4606-9664-a8beda93e018@redhat.com>
Date: Tue, 22 Jul 2025 17:03:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
To: Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Nimrod Oren <noren@nvidia.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 shuah@kernel.org, horms@kernel.org, cratiu@nvidia.com, cjubran@nvidia.com,
 mbloch@nvidia.com, jdamato@fastly.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, tariqt@nvidia.com,
 thoiland@redhat.com
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
 <20250719083059.3209169-3-mohsin.bashr@gmail.com>
 <ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
 <20250721084046.5659971c@kernel.org>
 <eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 8:34 PM, Gal Pressman wrote:
> On 21/07/2025 18:40, Jakub Kicinski wrote:
>> On Mon, 21 Jul 2025 14:43:15 +0300 Nimrod Oren wrote:
>>>> +static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port)
>>>> +{
>>>> +	void *data_end = (void *)(long)ctx->data_end;
>>>> +	void *data = (void *)(long)ctx->data;
>>>> +	struct udphdr *udph = NULL;
>>>> +	struct ethhdr *eth = data;
>>>> +
>>>> +	if (data + sizeof(*eth) > data_end)
>>>> +		return NULL;
>>>> +  
>>>
>>> This check assumes that the packet headers reside in the linear part of
>>> the xdp_buff. However, this assumption does not hold across all drivers.
>>> For example, in mlx5, the linear part is empty when using multi-buffer
>>> mode with striding rq configuration. This causes all multi-buffer test
>>> cases to fail over mlx5.
>>>
>>> To ensure correctness across all drivers, all direct accesses to packet
>>> data should use these safer helper functions instead:
>>> bpf_xdp_load_bytes() and bpf_xdp_store_bytes().
>>>
>>> Related discussion and context can be found here:
>>> https://github.com/xdp-project/xdp-tools/pull/409
>>
>> That's a reasonable way to modify the test. But I'm not sure it's
>> something that should be blocking merging the patches.
>> Or for that matter whether it's Mohsin's responsibility to make the
>> test cater to quirks of mlx5, 
> 
> Definitely not a quirk, you cannot assume the headers are in the linear
> part, especially if you're going to put this program as reference in the
> kernel tree.
> 
> This issue has nothing to do with mlx5, but a buggy XDP program.

Note that with the self-tests we have a slightly different premise WRT
the actual kernel code. We prefer on-boarding tests cases that work for
some/most of the possible setup vs perfect ones, and eventually improve
incrementally as needed: the goal is to increase the code coverage _and_
encourage people to contribute new tests upstream.

We try to avoid breaking existing tests (at least the ones actually
reporting into the infrastructure), but for new ones the barriers are
intentionally different than VS kernel code.

Cheers,

Paolo


