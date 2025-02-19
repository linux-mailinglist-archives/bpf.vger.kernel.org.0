Return-Path: <bpf+bounces-51967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1C4A3C4AF
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 17:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F8A3B9119
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C8B1FE461;
	Wed, 19 Feb 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GytTDOYr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19C1FDE3A
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981583; cv=none; b=L3RDkczZ6hYdUdC1upfgQ8T2/wYjPGbgFcDoe/bDUn8B0hiT1+0drW6L0E34a4KDr/4eAROoezB+ay0NHTug1jHdGcLk+/7hdtNmjG0hGuy8rOVGVObBzft3WeKMFosHHhCf+CdgILsBwy7v9NRTPEvTZCA6skMrhNzFAFnvArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981583; c=relaxed/simple;
	bh=CVnkRDktzT1iu/CfZAOr4Q7BcJt38e3u/TAtw62e9vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JB/y9q1SOPXGbhlSu4j1TUA8YIkFAGZ3DNGXVG+uo9tabh+NhdS42BOSeGzzC/t2YqZAK+5FgCzpqgHqS77PwFPofC+hfOKVVATFiCR00EbjNqiO8n+nYK1y2aes/P70QByqVGzg14FvVz2MDzoTL05z4ccR6+hLnV19ozIy3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GytTDOYr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739981581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qc0Hc4QPkOzkIooUycJdGnAOQy3VZli7UZpS44h6MQg=;
	b=GytTDOYrKUU/MRj5szyzLsIvbo/Mz3HUbZOieYuy+M5wy/PmKJ1IX/owSC6r+ZZgQ6TvZf
	BSn5ivyTGtV2TbXVjKuaq1Oc7TN5YWqkJEpRYSDRzWeAaTw/2kqm7ffm8DiAFtREPZY9We
	aOk4uqDQcUqG+P+FFl7W6UHtaa7Nq6s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-f7OCkXKVN926M9F-JtKuyA-1; Wed, 19 Feb 2025 11:12:59 -0500
X-MC-Unique: f7OCkXKVN926M9F-JtKuyA-1
X-Mimecast-MFC-AGG-ID: f7OCkXKVN926M9F-JtKuyA_1739981578
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4388eee7073so5087535e9.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 08:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981578; x=1740586378;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qc0Hc4QPkOzkIooUycJdGnAOQy3VZli7UZpS44h6MQg=;
        b=kzrw2eCyLSxnWIdaS7Iwo9f/cJGeOSPLtaQL2YcKVf1wwK8Ko5E6rh67+XDRxXLngR
         420XeWwOHJHt6DLa0hPXT9N08AQ6wONWWL36HCj0CvparKf3DsN3gUtYUmV9FpyUanUQ
         hDtZOJIyNtcUoOY+fRzToovWLF/RJJuaRMzkPFBzo+h/Plv67Y+QfYiM+3GTO7U5iKqz
         tFg402QPTNQ6mcdMRlJuQG3YqG8SIkYM8phU5b5BgZ24XZPiAlfzJZNd8HIxiDFpSNPq
         8h0LA0thE2FtTjnu575x2/y4UsI5K6XqeoQQH2Wpd7ExKHb3xMvcKjhVCsoKG47BEd6r
         vbvw==
X-Forwarded-Encrypted: i=1; AJvYcCVZY41hlK8kBWsG9Y72P9TTJxiZ7Co9hcchLvuEN58ouhSHX9ZJJxxojwC6IJ6SWT1RmEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9tNjzBLqlIz/pGbA9uiq0H/IftzXhdAOVA/32oximodSLM5i1
	Ziw3L3Ukcri5V+faaglPfmgcGCDQR/qMEI1khfIWJkWyRbECfMwhlHi6vLFrZIrnoXLOx5kNOf+
	9kA5rhJYSgFCSKxaphFtSX0CK7bxRwX3Dq3n4Jp22Ume95vldAw==
X-Gm-Gg: ASbGncu8MIW73luuUuWLscjFBNJPdGxJ3xVue/GF8z38sd5XBmGTm1eltkzUJfKuS0c
	jWBEoOIyYDZEFOFsY1KnDHVaMKzLdHXeuUFZhSfSqlMpVvb3ewxTD1qhopCgOjy15NXDtaSVe6o
	gUgiPgMDoeLtr+Acp/c1KvrtSjdG/S4GWo5SjpTXIEseUZrRTvv1EyjykA9PUUhvUVqwd3Dey5G
	fsAwQvHqrYRKaDfUjKHY+PzRLZtdIRcZRorGUwkiS+UDPNwSNBesdkM0oeUUi4hGxwlglYjCDr4
	FuNie4QDjzTjuoIjZL5d3utQBREWloI6X5p5JbjV93RFMMObLOcPpmU8iK+lek6fMf1O/HrBzCF
	SXt2LKH+gX6nb9SSL4soSjjw6Hg6rVYTe
X-Received: by 2002:a05:600c:17d5:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-43999ae0204mr36733615e9.4.1739981578307;
        Wed, 19 Feb 2025 08:12:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgyV0oed5NHSmPgVRPD7iiPxy4T1Xt6roKv1XTYfIc76HANJ9uYK3uKYFAmxkXXbO43Swfdw==
X-Received: by 2002:a05:600c:17d5:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-43999ae0204mr36733385e9.4.1739981577964;
        Wed, 19 Feb 2025 08:12:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c712:8400:50d0:d1c1:90d6:e2e0? (p200300cbc712840050d0d1c190d6e2e0.dip0.t-ipconnect.de. [2003:cb:c712:8400:50d0:d1c1:90d6:e2e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43992ad82cfsm58079805e9.37.2025.02.19.08.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:12:56 -0800 (PST)
Message-ID: <34e18c47-e536-48e4-80ca-7c7bbc75ecce@redhat.com>
Date: Wed, 19 Feb 2025 17:12:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Add Morton,Peter and David for discussion//Re: [PATCH -next]
 uprobes: fix two zero old_folio bugs in __replace_page()
To: Oleg Nesterov <oleg@redhat.com>, Tong Tiangen <tongtiangen@huawei.com>
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250219152237.GB5948@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.02.25 16:22, Oleg Nesterov wrote:
> On 02/18, Tong Tiangen wrote:
>>
>> OK, Before your rewrite last merged, How about i change the solution to
>> just reject them immediately after get_user_page_vma_remote()？
> 
> I agree, uprobe_write_opcode() should simply fail if is_zero_page(old_page).

Yes. That's currently only syzkaller that triggers it, not some sane use 
case.

-- 
Cheers,

David / dhildenb


