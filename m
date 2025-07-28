Return-Path: <bpf+bounces-64555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 319B0B14238
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A573189E450
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DAF276047;
	Mon, 28 Jul 2025 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihrBSZE3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09021CC57;
	Mon, 28 Jul 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728494; cv=none; b=uw8No4oWApZ6rF3h9Y2c2PInuKHyBRGqELYoFt6zn7gghun76VLtHQ1V06ZWpFxRGCXN2qlvqnA0Dly2Uafu6hhMv2B4dAamVIH75R7ZQhUbrGNu9V/OkkyQMdx9V60s+36vfH4hWusKb92tAg+6JP6EPmygfnkDqLGBDkpxfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728494; c=relaxed/simple;
	bh=HmUFXtsPLKlOxVadQ+y0n2hrEEj+K3jv5Vs3dl1+XSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3g5h+07/PCwe8Q5V77H/OG87yv3vwSnAN6NTvWwmGO0zd6Eg834wDe6WHIrAshKG2LkxGTYL9v24rrO0U7648iln8baAvU4PiJmiwrr+2fqmHVHBpnW/9TkwhRInaTUWRnjoy+jpLkWCoLVpaNZkbO3MMZHYlNLuG9X60cgJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihrBSZE3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so967506166b.2;
        Mon, 28 Jul 2025 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753728491; x=1754333291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KPtqArRqu6RKIpD2evhkTp5wjAyR3mIuxIPwkqRJjJg=;
        b=ihrBSZE3YVPxc2F4rB6i03BeINzq9ZLbmlNAzC7g0mT45APCy3SFwhB6IYDhre+i7h
         PVt1kfD5kzF3QJ0N361To36T/kbfQMap1mTOYGkuDM5uSQC3gNlHZJahujmwsgaX+khr
         psie1BQOfL3X1JLpkuDnfahSvGCKVix+Uf16yVHhiUVwQiB6v3jQYRu4FF66hZAXIgzT
         ny9forDzpyqe4ka0ZXn+TMPJh/cswyAQPeysrJMLRKQnoVHTkOqPYH94STunGLmfgduj
         qgilMabfR3N2g9fVl2dlqa25gxRezoa9jRe1x/WdsCvCFzXrsXloef52O5siq9UTTNZd
         qlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753728491; x=1754333291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPtqArRqu6RKIpD2evhkTp5wjAyR3mIuxIPwkqRJjJg=;
        b=ubI6SYAZtfnhCZekKCyf5BriuPwPxMzQLNtEDByTdwdG3hmLTFcaRXJolJnRCjYzgl
         99ldF2yChv/RGfIH+TELTW3a9qyw+xA+MHjGDQ/XcETqRmJY8yX+dX2vmRZttxzax67S
         Sf+NwQvDiDTmxMNib6ug5VxzGk1JXxp+mkeGsGxpmOmv7UdfkOyORFuwLrE95tSitGIL
         OZxmuFU+/TNX9p21NsvPyxQhhwYPOG9mtBiVfHG71qnFJKNTrbOTTVuSYveBas13Dwqt
         A0yekyCUtXkpd8ofG+j6fuUlmx5Jbw2ZqX+TZuu3f6pLbEqoAQTdUBZoQGrt//wx6rU7
         oeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJrWbVA2fDWJYMEBKElksnetmcWNGvC3zfs0efb+AZ+NIxTT98FAk6zDHl1U256NUpD3a1G1v/@vger.kernel.org, AJvYcCULingRW9SWCTUciHQYGRGdwwdMMQZzMf9COTu6E+xuId9A1z6XFi9mm3Zyrsb4rmpfXdBvCCapaLQbmSmW@vger.kernel.org, AJvYcCV8163SH9Im/pxTJck1HmfERkem3bDd65WcbyAs/Qjni/kRX3qHg/TiN5m+fv+hZ5COpkKJQljHjvxooA==@vger.kernel.org, AJvYcCVcbjmHQQmJ/HvNiVHer/HBQirg2DRgVwsJhIMluaMB9qtZCN7uP352cRU7d442pHgQ9Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6Ai77gengSOmIWtI3EX9SHQKV8DlNsUdiq2A7xzJaveg7JGK
	D+F6xkR5BCtWChsV/P4l1i+RXzn21jDimDzWSWwsIltxFwOmdQXwAKWA
X-Gm-Gg: ASbGncstQ9CUJp3jXYTO4Sbq0LyjSQr0MHKtE3RouVZ4W27ruu3ZDJHtu3gsL5FIWaG
	HZ5cHYDiEMZvx8IY+GmaY00I/hippCU2dvKilIGH4AqdUlhXH2XoHA6OiAdRf8snE8vr0Pl91dJ
	jh2WocxZjdkzfAY2cbBfQ3kPLt837O3qZd5fGRtKBlBX482E296AS47mq+/QpK772+CcqPEvn5n
	bHSe7IyCFwodSdQjpdqRSVwr85BNJMxFqm1ed1ofQUmeeJJ/9RmEyEwh+kcMXr1jVq7o5olewyY
	j4o4sSUd4V0OtCgu6xJKd3bkizm5RshF1JhT2Zd7tJvYkNXoGC7LCQOomDglzjYKVXLFVZ53TrR
	emdVATG0HMRoPAI6GvmfmQ4A77+ww2Gk=
X-Google-Smtp-Source: AGHT+IGzAV+yc6Tr08lhtVqfYb5YTgQLPzE5kcZfo5vFpSIrj8JxMfbWLpoJFl0I+K+SgA12E6PiOQ==
X-Received: by 2002:a17:907:d2a:b0:ae3:e378:159e with SMTP id a640c23a62f3a-af617d0afbbmr1521651666b.26.1753728490438;
        Mon, 28 Jul 2025 11:48:10 -0700 (PDT)
Received: from [192.168.8.100] ([185.69.144.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635aa33f9sm460220966b.98.2025.07.28.11.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:48:09 -0700 (PDT)
Message-ID: <da4a9efd-64b3-4dc5-a613-b73e17f160d6@gmail.com>
Date: Mon, 28 Jul 2025 19:49:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page pool
 in page type
To: Mina Almasry <almasrymina@google.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com, toke@redhat.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250728052742.81294-1-byungchul@sk.com>
 <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
 <CAHS8izO6t0euQcNyhxXKPbrV7BZ1MfuMjrQiqKr-Y68t5XCGaA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izO6t0euQcNyhxXKPbrV7BZ1MfuMjrQiqKr-Y68t5XCGaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/28/25 19:39, Mina Almasry wrote:
> On Mon, Jul 28, 2025 at 11:35 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 7/28/25 06:27, Byungchul Park wrote:
>>> Changes from v1:
>>>        1. Rebase on linux-next.
>>
>> net-next is closed, looks like until August 11.
>>
>>>        2. Initialize net_iov->pp = NULL when allocating net_iov in
>>>           net_devmem_bind_dmabuf() and io_zcrx_create_area().
>>>        3. Use ->pp for net_iov to identify if it's pp rather than
>>>           always consider net_iov as pp.
>>>        4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
>>
>> Oops, looks you killed my suggested-by tag now. Since it's still
>> pretty much my diff spliced with David's suggestions, maybe
>> Co-developed-by sounds more appropriate. Even more so goes for
>> the second patch getting rid of __netmem_clear_lsb().
>>
>> Looks fine, just one comment below.
>>
>> ...> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>>> index 100b75ab1e64..34634552cf74 100644
>>> --- a/io_uring/zcrx.c
>>> +++ b/io_uring/zcrx.c
>>> @@ -444,6 +444,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
>>>                area->freelist[i] = i;
>>>                atomic_set(&area->user_refs[i], 0);
>>>                niov->type = NET_IOV_IOURING;
>>> +             niov->pp = NULL;
>>
>> It's zero initialised, you don't need it.
>>
> 
> This may be my bad since I said we should check if it's 0 initialized.
> 
> It looks like on the devmem side as well we kvmalloc_array the niovs,
> and if I'm checking through the helpers right, kvmalloc_array does
> 0-initialize indeed.

I wouldn't rely on that, it's just for zcrx I do:

kvmalloc_array(...,  GFP_KERNEL | __GFP_ZERO);

-- 
Pavel Begunkov


