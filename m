Return-Path: <bpf+bounces-22394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A02985D36F
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 10:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC1D1F2364A
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37083D3A5;
	Wed, 21 Feb 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFslji75"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CFD3D386
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507643; cv=none; b=cmg+Ti6DqXaix4aG04kPOcT5XJggH66P0PsZtnpbfsIqoO8/70obS/M7CrIyfs8bTx6Vh8bEVxbwMOR2fBq8zF6hbzqNpm0pwt/JQx+dTZNEyAmbr/H9BLLCk/48zBszA+bGWk0tInG+WbT+Rt2WxM9Iy5G3bQwOH+aKOql5gcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507643; c=relaxed/simple;
	bh=5QP0MuDrmxNzRblbI3qrO9Ljkt4BlG3Q0Bb0TpHHhGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RK6Wf+l130ronn7664SYObwSwGFpk5oPtOtwzZB5Z6sX3SECJ4nbVctJrHG9gDvDCigaJsu3uCSwD18KX8/PSKQFfss4tHTMXv05SdbeleoKhZV1Zt8xkwGTY3kam0k6a82wpPxPq25B1g+zYUV9mhEsZqJVoccPZmhDw8AMESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFslji75; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708507635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JqDQzqQUNVGgLXFQ47h2MyrP+vNxqZ2Sfg76FoOL2Z4=;
	b=YFslji75Q/eCXAx0UssqFmxyG3kw6PNQutqWTAhzWGqemHH90Qy/ZsSjYVD5bs3xhw4+Ay
	kk5tdK+z+Z4z466S0BvdPSZ6DmHzLl7Ncrp8ZPt2r8+f4VrBaRqgzr3AVZh6CvzqiBo7Wt
	rksXrZuZKnrcjyTluPpYzbJrdvpksZk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-u2DFjs2hPBK65-JjBNvBcQ-1; Wed, 21 Feb 2024 04:27:13 -0500
X-MC-Unique: u2DFjs2hPBK65-JjBNvBcQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4125670e7d1so18178875e9.1
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 01:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507632; x=1709112432;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqDQzqQUNVGgLXFQ47h2MyrP+vNxqZ2Sfg76FoOL2Z4=;
        b=IiVdT2O1eWxdhlErQj3FsfpcYAsM0EUcY7wgbCm1IZFuFrdZZ97SA7MGviA7D1Jw8r
         Di70Yiy/LpCW0tMWP56DJlar1jwyIfE6lyHZXGQPHRVRl4ri6e7aGHdbbv0WQaYde2xI
         LGDV+TWvK0WyQQ4003dg6d5N5JJ4TIpM5sVKIAy5cneFinRurKcoWL0ciDHEI8BMrGKV
         BQ19XDyAbTxp0XnTnM8/PlBQq8G5JP2Cb45bxSvHR8lBorX67LkEPF2P8tgPFrBJGU1w
         pC46Z8Ji9JcIyWO3gQtsYW0Ol6Fz/7GCL2yRUS/bC0Q2U7V1zmL0AMiZoi+Lann5W4ji
         Hwwg==
X-Forwarded-Encrypted: i=1; AJvYcCVE5klZJn1TCLtZ5aqc4oENBAdG2kJlOeSpqtrokMLTOrre1dBCyqLo7AX8QE0rL8LP/NVaMZpLjPtmHdwmbDOiLqDo
X-Gm-Message-State: AOJu0YzENFbT/ADTrK6B5bRpC4s/thUxmlK4XGDPRUdqFf+sgnQE/wJ2
	hzKZ5BE2HYO4+sbkmp4qi75Xklk/aG8u7yn9oYwORNY3QQchAaltqFoglyrGIjZ8aEpQ3LpWUZi
	BKvszqwDIuVuuKrOAFMgZormuk9MimK5k7eLlBh9NfPFEUkr5IkxarRSH+A==
X-Received: by 2002:a05:600c:19c7:b0:412:5296:9737 with SMTP id u7-20020a05600c19c700b0041252969737mr13136529wmq.12.1708507631749;
        Wed, 21 Feb 2024 01:27:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ7FuH/em5oiRt/ZTOR4oMLbXYFTRabnhBDn5rQM4tupeTaNWMPYn2RFDHXi6wWaSGqKntiQ==
X-Received: by 2002:a05:600c:19c7:b0:412:5296:9737 with SMTP id u7-20020a05600c19c700b0041252969737mr13136504wmq.12.1708507631270;
        Wed, 21 Feb 2024 01:27:11 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id jj2-20020a05600c6a0200b004126732390asm1837805wmb.37.2024.02.21.01.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 01:27:10 -0800 (PST)
Message-ID: <cf5409c3-254a-459b-8969-429db2ec6439@redhat.com>
Date: Wed, 21 Feb 2024 10:27:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm: pgalloc: support address-conditional pmd
 allocation
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Maxwell Bland <mbland@motorola.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "ardb@kernel.org" <ardb@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "ast@kernel.org" <ast@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "cl@linux.com" <cl@linux.com>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "dennis@kernel.org" <dennis@kernel.org>,
 "dvyukov@google.com" <dvyukov@google.com>,
 "glider@google.com" <glider@google.com>,
 "gor@linux.ibm.com" <gor@linux.ibm.com>,
 "guoren@kernel.org" <guoren@kernel.org>,
 "haoluo@google.com" <haoluo@google.com>,
 "hca@linux.ibm.com" <hca@linux.ibm.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "lstoakes@gmail.com" <lstoakes@gmail.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "meted@linux.ibm.com" <meted@linux.ibm.com>,
 "michael.christie@oracle.com" <michael.christie@oracle.com>,
 "mjguzik@gmail.com" <mjguzik@gmail.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "mst@redhat.com"
 <mst@redhat.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "quic_nprakash@quicinc.com" <quic_nprakash@quicinc.com>,
 "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
 "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
 "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "samitolvanen@google.com" <samitolvanen@google.com>,
 "sdf@google.com" <sdf@google.com>, "song@kernel.org" <song@kernel.org>,
 "surenb@google.com" <surenb@google.com>,
 "svens@linux.ibm.com" <svens@linux.ibm.com>, "tj@kernel.org"
 <tj@kernel.org>, "urezki@gmail.com" <urezki@gmail.com>,
 "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "wuqiang.matt@bytedance.com" <wuqiang.matt@bytedance.com>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "zlim.lnx@gmail.com" <zlim.lnx@gmail.com>,
 "awheeler@motorola.com" <awheeler@motorola.com>
References: <20240220203256.31153-1-mbland@motorola.com>
 <20240220203256.31153-3-mbland@motorola.com>
 <838a05f0-568d-481d-b826-d2bb61908ace@csgroup.eu>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <838a05f0-568d-481d-b826-d2bb61908ace@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.02.24 08:13, Christophe Leroy wrote:
> 
> 
> Le 20/02/2024 à 21:32, Maxwell Bland a écrit :
>> [Vous ne recevez pas souvent de courriers de mbland@motorola.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>
>> While other descriptors (e.g. pud) allow allocations conditional on
>> which virtual address is allocated, pmd descriptor allocations do not.
>> However, adding support for this is straightforward and is beneficial to
>> future kernel development targeting the PMD memory granularity.
>>
>> As many architectures already implement pmd_populate_kernel in an
>> address-generic manner, it is necessary to roll out support
>> incrementally. For this purpose a preprocessor flag,
> 
> Is it really worth it ? It is only 48 call sites that need to be
> updated. It would avoid that processor flag and avoid introducing that
> pmd_populate_kernel_at() in kernel core.

+1, let's avoid that if possible.

-- 
Cheers,

David / dhildenb


