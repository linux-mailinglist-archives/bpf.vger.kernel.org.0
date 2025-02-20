Return-Path: <bpf+bounces-52060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB708A3D359
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 09:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC09B3B2160
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9391EB19B;
	Thu, 20 Feb 2025 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W16Lzwhj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909A1A23A0
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040706; cv=none; b=Pz1X8jqmv2F0jz6R0Hu7x9/EyqmoQICI27YnN3l8FLFHBtdLoEddw8e/d9K11Ekdtu5BVGRhHfJXu2ZeB/6qCeqUHuTVozflzLctuSwk5d5FynAH75QR3XKZXsJ33uAnMZ7YtDa+MRg6X7IcUKervV/gZXSj5OhieZHV2FIWODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040706; c=relaxed/simple;
	bh=FrcpVA1vsTxNxI1Gs/ep8rNytN9twIjnfOESK3tmuNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3e5ZxKBK5SudR0IDbocFmvqpD11Wri4DnfhDJBVbW556zdSAzncJE8fCvCOkFQewQM6SUbIiFhO41LJbBKVnNb4WWycJoGPWmIvkMEkbxdqQD8y2pXiDY6H+8qJt2YQyTtx0hpfnNnazTno/JhNdQ5+O0zOe7Xt3phVeK5avG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W16Lzwhj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740040704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jY7tYtFefzvHG4aShI6b5afWDaM1BnuW3bk8CDdolzk=;
	b=W16Lzwhjl+qh0odmhxlSm/9qLcItfRFPopERH52eq5/m8dNKEXCV9UabzGrSL478PTt3PJ
	BKQ2rFrh8j0U0NpEFmwx+Ve/kYsBoAbo5FrJkKO//cyn8tKlutJ8EgGVg3t8izJV87IeFI
	jrAw2Xl1nKKgXWo44BWMZULzDO1uBwY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-NVuMH46GOGqdx_CdNpPU4Q-1; Thu, 20 Feb 2025 03:38:22 -0500
X-MC-Unique: NVuMH46GOGqdx_CdNpPU4Q-1
X-Mimecast-MFC-AGG-ID: NVuMH46GOGqdx_CdNpPU4Q_1740040702
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f37b4a72fso878444f8f.1
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 00:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040701; x=1740645501;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jY7tYtFefzvHG4aShI6b5afWDaM1BnuW3bk8CDdolzk=;
        b=ABYK8oIqOy9lYk9zSogaRHCnHrmIWTOzMz9Zba5veNswyK7RexOSmH7qSF+04zXTKO
         7L7YXvUXAtF6unHCzQ1R5+A5ev3o8tQ0IFTBg62JO83U2MhRVX7XeeY5GjtK8o8/gmIv
         W1r1IHsTyrMFZAFKvjvpx4fKPnbj049lhgoTiokUqms8NRRzBaHI55m/U8tY9wDjaxqG
         Rp0Q4sfACsN17qE96qOCXXKtxW0XcI72yZY0K0HXb62l4F383iOZ2vUwc2EOEjGQkwZk
         BunKl3ljaY2FkM9O6h+sEwNhS9QAQIaINFM6V2LJpbw4JhuR84DKpe+gaBcg3jNHISib
         oSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNrqey9dOrrBD5U7UInS1Y7jYXRdcbQqwmGQbWgIskdtSs5y0i+i2vDd/0HYdJsO06msM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5QDpbbhJQSx2RAScU0kqBcS53YQ5YWkiJszrVEybv97i9JkG
	FHfjeZLvwGhACjf78jjKogHu8KQtzUXBxn1ej31u5QwriA4Avt4Zs4QQXn/XrkPnMgpLDUPNRrx
	WobRwe4h3rnix7gElsSlF8Mt/PJSbLlsKdUfI0c0H+xumP9LWLQ==
X-Gm-Gg: ASbGncvBoLkSvuT95c3iuDzpjL16xwAjMfiMRPrhEHhsI3FXw47tvvpX+/S7mJUs8VJ
	u/OW8IfOWiI1FvwHtQsTI4D7NDQ078K+GmVEe6SzTZJzr9eNkV7dhosJAtU18flUdL4IOOysB/P
	zM+GGa1LpLh7+ha63A3QtXL4b3w3lABH/wrEUudJ44FTKhmpoIjbQtBhR/cs5bF2xSPfRrD6LFj
	O5lGns6By/fJNkMnWv59+4+eHawofMmmR+ur+NQHdpnfcixbLQSQp5Yr1GvqjXZaQzFT4tRnApg
	XBwUuHss1PlRz7p3xWmUdaTCykJolunNnA==
X-Received: by 2002:a5d:6d09:0:b0:38f:4f37:7504 with SMTP id ffacd0b85a97d-38f615be1c7mr1806812f8f.16.1740040701642;
        Thu, 20 Feb 2025 00:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp7d6SevuNhLuZV8/jkVX3ymo9iXEjPh8PEOuN3PjCQ/0IUnneKs02MbsGlPfYJTfyuY/WSA==
X-Received: by 2002:a5d:6d09:0:b0:38f:4f37:7504 with SMTP id ffacd0b85a97d-38f615be1c7mr1806776f8f.16.1740040701197;
        Thu, 20 Feb 2025 00:38:21 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6195.dip0.t-ipconnect.de. [91.12.97.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43990f53847sm83879685e9.1.2025.02.20.00.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 00:38:19 -0800 (PST)
Message-ID: <196fc7d8-30a8-439a-89bd-57353fd98df8@redhat.com>
Date: Thu, 20 Feb 2025 09:38:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Add Morton,Peter and David for discussion//Re: [PATCH -next]
 uprobes: fix two zero old_folio bugs in __replace_page()
To: Tong Tiangen <tongtiangen@huawei.com>, Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 wangkefeng.wang@huawei.com, linux-mm <linux-mm@kvack.org>
References: <20250217123826.88503-1-tongtiangen@huawei.com>
 <c2924e9e-1a42-a4f6-5066-ea2e15477c11@huawei.com>
 <3b893634-5453-42d0-b8dc-e9d07988e9e9@redhat.com>
 <24a61833-f389-b074-0d9c-d5ad9efc2046@huawei.com>
 <20250219152237.GB5948@redhat.com>
 <34e18c47-e536-48e4-80ca-7c7bbc75ecce@redhat.com>
 <2fe4c4d1-c480-c250-1ba2-1a82caf5d7fa@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2fe4c4d1-c480-c250-1ba2-1a82caf5d7fa@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.02.25 03:31, Tong Tiangen wrote:
> 
> 
> 在 2025/2/20 0:12, David Hildenbrand 写道:
>> On 19.02.25 16:22, Oleg Nesterov wrote:
>>> On 02/18, Tong Tiangen wrote:
>>>>
>>>> OK, Before your rewrite last merged, How about i change the solution to
>>>> just reject them immediately after get_user_page_vma_remote()？
>>>
>>> I agree, uprobe_write_opcode() should simply fail if
>>> is_zero_page(old_page).
>>
>> Yes. That's currently only syzkaller that triggers it, not some sane use
>> case.
> 
> OK, change as follows:
> 
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -506,6 +506,12 @@ int uprobe_write_opcode(struct arch_uprobe
> *auprobe, struct mm_struct *mm,
>           if (ret <= 0)
>                   goto put_old;
> 
> +       if (WARN(is_zero_page(old_page),

This can likely be triggered by user space, so do not use WARN.

-- 
Cheers,

David / dhildenb


