Return-Path: <bpf+bounces-63888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D05B0BF70
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E393B2BB4
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593B2877E0;
	Mon, 21 Jul 2025 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYE+twWZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F08801
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087786; cv=none; b=Bz6NtUdckUJ3ffYQRV+UdQdpAsXEmP9fDGWG3epdCmgK3VtigWm8x1JwCndJDnb5k6MJAPGebqoG5nEeGfPl+WUSULYMhnMdfO50xnFpBDTEsIgmKO7mmAF+J3+wVRbMHU9RpGRUPpPYg2t5kae873vHumljQ8bcKj2fxEfIHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087786; c=relaxed/simple;
	bh=O86pCKYYqFW3brRImFAd909wt+XrZ1IcPtW+VeAnRLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLLRo2QfU+TaqM5pX9WWpzy0uDDx9yND+p/sWmq5yQzbgCO9wqyUlTnYhv40dNHamicXt5BaruppQpl/t3SzlCXwLAtfIAjzyN22u8Yb+tZox83iLx0RuvSrJ7mrnws1t4WnlzEONoP9xrj6/JErv8NDe6Sec+aVnN6PZLdTE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYE+twWZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753087783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eEyJkY9ZcW+iRGk8l+mt+fm3yxn1zcNir5mSzl4jwkA=;
	b=RYE+twWZLmHIHlUDJqv7kPR1kKmLh6G7bvsCFgAlBX6k6hk5kPdfdb8zxWSVb5Pjm5CcJX
	t4GKikXPu5dvf7NwgwIreI/USh0pvORrHp3InngGgIR2EQKTfkC+Z6bzF53E+cG2MFO94r
	bqc97A2eDteH93YGuMiaOF8pDpe88HA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-SSUjS9s6NQq-nh97iqMyGQ-1; Mon, 21 Jul 2025 04:49:42 -0400
X-MC-Unique: SSUjS9s6NQq-nh97iqMyGQ-1
X-Mimecast-MFC-AGG-ID: SSUjS9s6NQq-nh97iqMyGQ_1753087781
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso23797185e9.0
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 01:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753087781; x=1753692581;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eEyJkY9ZcW+iRGk8l+mt+fm3yxn1zcNir5mSzl4jwkA=;
        b=V9Czj4oNuzWpSrQSIsekb5JZ8hA3M8qXTHmjrNyCrO3+2yUjVooA92o6YgmqJEnvyH
         w9fc6ffFtRKBwmcwH7eVZOOJqTvNLU8TQrwbI+yh3OhXHUM8u/dq5+/ZEIMtepR9pIHw
         Ekclzjg5ruSP7tX9TLslQJ8e7ddnSyPArnKky4xqmQn0/0+gWOVAG3DPvYal0uONJ0J5
         tnHex6XRZgXkonbhGx6+hY4korEKmyqDvRmlevq5rw1nvGUOnCR9mUve2sIKlg7EHtUD
         DFjjW9mnnN9w1gbRBKxcQF7lYYGUQF56Qz6+acrpr2OtvBo9pMMM2lO1nauO68E0FnDr
         WwBA==
X-Forwarded-Encrypted: i=1; AJvYcCXHflUPZBv2jmpxoykFh/GtSD8ck3XFDxaUUby7MkHsXxedcG8HJR+vpx9Rtlg6DnagrRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPvgYm6COJPc8TvQphRs+nv7U6OdM/b0eZUiIdKXv8TFdWCoG
	b4L+Dl7EHC/iXimWBOefPzHaEEyFuZNuw2U6C9SiTfuvkv1E5cg1PUZRCnDJuqdSgPXIoTwZmT2
	L3ZBoFAW0kyaXG9uDu4UDPtJ5iPdIY93ufJlZywbEB+OPHCSVixi/tg==
X-Gm-Gg: ASbGncsb2oPhFru4O+18KBAigksZro8D0WA+mAK1j9/qs9LuT/mBrxqTa490phTGH4E
	vlETyHvoHYflk0cAx5RZsIoiZoXmPYFaniN/xTS6sXusjc8e9jm53JDyk1ChJy2pIcgGKRFHpvS
	O5Jhn+2dh+DE821nhk+Msrg2WJraq209klhd2Tb58YJWt9ump0jdxgAJp19behGloWkACP9B/N6
	EAYUhN+ZcwvndndJNzHBx1TedFxLuhYAw+uTSHyrFjqPYSyfcc5XWyN0g1xZR0C0OUwvepOFpBW
	yQ14JSIih8SmQ4J4ajd2mpdFNkhc37hwQT3uOJSzvFjVS0tiTnZyI7nf6hpvCzlLn2hLrmE983t
	iY2UXalqgAGo+D9gEMH9WDzFDtmrCUo2TqRnzltmUnhLGTOW7jWcGAiPsxgxXmQuY
X-Received: by 2002:a05:600c:c0d0:b0:456:12ad:ec3d with SMTP id 5b1f17b1804b1-4563a54de9amr96245225e9.14.1753087780610;
        Mon, 21 Jul 2025 01:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGDXuvG/9c+M1TgLOa2nxRpw+VaS0oi8mIDcJ1ihrrncI17JDx29cO0dxPdF5voli4IFz5OQ==
X-Received: by 2002:a05:600c:c0d0:b0:456:12ad:ec3d with SMTP id 5b1f17b1804b1-4563a54de9amr96244645e9.14.1753087780049;
        Mon, 21 Jul 2025 01:49:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4c:df00:a9f5:b75b:33c:a17f? (p200300d82f4cdf00a9f5b75b033ca17f.dip0.t-ipconnect.de. [2003:d8:2f4c:df00:a9f5:b75b:33c:a17f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d732sm9673327f8f.61.2025.07.21.01.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 01:49:39 -0700 (PDT)
Message-ID: <8b6e6547-cb39-4e64-8dff-6e16e27e7055@redhat.com>
Date: Mon, 21 Jul 2025 10:49:37 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool in
 page type
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250721054903.39833-1-byungchul@sk.com>
 <e897e784-4403-467c-b3e4-4ac4dc7b2e25@redhat.com>
 <20250721081910.GA21207@system.software.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250721081910.GA21207@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> This will not work they way you want it once you rebase on top of
>> linux-next, where we have (from mm/mm-stable)
>>
>> commit 2dfcd1608f3a96364f10de7fcfe28727c0292e5d
> 
> I just checked this.
> 
> So is it sufficient that I rebase on mm/mm-stable?  Or should I wait for
> something else?  Or should I achieve this in other ways?

Probably best to rebase (+test) to linux-next, where that commit should 
be in.

Whatever is in mm-stable is expected to go upstream in the next merge 
window (iow, soon), with stable commit ids.

-- 
Cheers,

David / dhildenb


