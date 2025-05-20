Return-Path: <bpf+bounces-58585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A60ABDF9E
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB448A4DDF
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E691261571;
	Tue, 20 May 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWCw0rLk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F30C25F7A1
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756489; cv=none; b=VFnMDXc2OQ5rz6A+Utv5JqovfQZJKELpA5yehpJyz+gbmZC6jFhBMPX42gmw3Tu/Hf9rTSn80of2kGN4Y3R8tOG0tJ89JxLwoK7y4WjJV16MfnVLYqDcLzOn9tNBsBO48AEJ09ThOkIQeJJToYomRZ66NftVPnSo+IOI48xxoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756489; c=relaxed/simple;
	bh=PsfAi/Q9gud8VNaJjpqie3AstpVTa7udNOf/T74FcNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqhhNhuTrZy/b39DxW8YurLVf/Wu6qgoo52qMU7geLGlvtwMwWB6aEJE5FYpk3iqC/eHHwQ8D5WtvScz0PfX5kOwCbOngkTXmmKE7Yi2DTuBghtD1eqSnk8eIHSX2/vUSlS6Pw6CHnEqjTBe0E/JwiC0hig5BRRJcIx17f4llpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWCw0rLk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747756487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OKcnKwFmtSUX4HUY416IGKBb5t3RzMZpZ4+wRruvRJ0=;
	b=JWCw0rLksXcb2wuD6COAW49ygaGefhS720xc7UW/UpaunBVPdG6nBA0HOepiOOSbIbWRsI
	SRzrlssmlXJiWRVp+8tN+9k62ORZcxerzjiVTZuQsoGqel7X6TEGpdxvZ8+n6n2HxTVdyn
	guiwCWeH9ISKJI7oFjZx3QNazYiCBZY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-zeUVwO7WOiqG4kys8eHmeg-1; Tue, 20 May 2025 11:54:45 -0400
X-MC-Unique: zeUVwO7WOiqG4kys8eHmeg-1
X-Mimecast-MFC-AGG-ID: zeUVwO7WOiqG4kys8eHmeg_1747756485
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so34500575e9.2
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 08:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747756484; x=1748361284;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OKcnKwFmtSUX4HUY416IGKBb5t3RzMZpZ4+wRruvRJ0=;
        b=GSuWa9R1KoZiHyEoVs3l+lB+2LFXfRpyCUiWqGXj7rrk2iGd/31O7WfcR8xCTrsYtV
         dUydE7lDLjye4E+5aIViwX1Ly0rCaoj/WdXp8ZmcktZKm9hI7kvkb480EGPUG3XUvwyP
         n2NOWBSJzGuFv2ioBJZ4LR6dvXWh15lkXsQ9ym2iyvOCLdz22a4Em/vv3oXkUP3O5qIb
         DMyhq2FQiiOb38zBPE4iXL/tZXieCJjL1R/5HZiPNjckPJsFD988azfJeas8m9t6Crlv
         A2RlaXluuHC0NREW7JptQMlyYXUR9wyf+BKtIyoU31ZSR6ddYNpsg+Y3fYOP6+nqVBiv
         9J4A==
X-Forwarded-Encrypted: i=1; AJvYcCW6G6pYqgYf4Jtvrqf2IkzDMaaky+/Pg622xTBi9c7wSNiznoPJ03FX4WzKrlcYFnMEiG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2RRW9TFx7JJSiyEUr+fuvWLoeDCpijdaB+kl/ZSPGbFKqggwB
	XeL0/sOK4X9jEHebFhrcosrsBPN/vSLBnQYkvcGZjA2tV3vuCmGJGGuFRa/GM7Pxnn6uzZWOLLO
	aBWxd7kGJWpYy0GwyGylXmrhtSX7lwWcVlZJlzhfgaJkPhxAbwRpmQBt/4wrhflAN
X-Gm-Gg: ASbGncunT0jL7cQimAcq0uwN6gJz+sJUUH8XyawByhT24iGL/RM11Bddiq6rpya34FW
	SNLHxPyNtmZoatfXbainQweuClGSw5Zu1JnWPJ+aDyvRHkFr/zwJbdzhYUP6btuhjZoN91BGtXw
	YAUBXZT/Mh6fcdNWlEHOzzw5VLiiJOL/SA1aemNXjT+tm2lU8wCOXYehnwXWO9K2mOdmNTfGzU2
	EUSbjk+RYEnomMiYFdcEioH/bCFrXhLR0q1sL3j+1Bjb0FhFIzdwgWrfoswQKEXOlmjdyW1ozo0
	ukA+l7N10GshMZVTabMVrTl4xyoDQT75WX5wqZuTgOT1VMLyiv87UGouawLPEZz3K+mLG+IxZiq
	vcz5x9XSCOAArWUFoY2d7f0OBin7aak6bpmhfOmQ=
X-Received: by 2002:a05:600c:3c82:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-445229b42b7mr111181095e9.10.1747756484531;
        Tue, 20 May 2025 08:54:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNEcn99+03kGAQrm1G1mjNjQw2+1R7DVYoyqW5NZdrOcV1X92Hcwd0Dn+lFyl7PKIs9qT0Cg==
X-Received: by 2002:a05:600c:3c82:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-445229b42b7mr111180775e9.10.1747756484112;
        Tue, 20 May 2025 08:54:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84? (p200300d82f287c00a95eac49f2adab84.dip0.t-ipconnect.de. [2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a364d2636bsm14163272f8f.99.2025.05.20.08.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:54:43 -0700 (PDT)
Message-ID: <9b44fe43-155d-457d-81ce-a2c1fb86521a@redhat.com>
Date: Tue, 20 May 2025 17:54:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <746e8123-2332-41c8-851b-787cb8c144a1@redhat.com>
 <c77698ed-7257-46d5-951e-1da3c74cd36a@lucifer.local>
 <CALOAHbCZRDuMtc=MpiR1FWpURZAVrHWQmDV08ySsiPekxU2KcA@mail.gmail.com>
 <849decad-ab38-4a1a-8532-f518a108d8c6@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <849decad-ab38-4a1a-8532-f518a108d8c6@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I totally agree with you that the key point here is how to define the
>> API. As I replied to David, I believe we have two fundamental
>> principles to adjust the THP policies:
>> 1. Selective Benefit: Some tasks benefit from THP, while others do not.
>> 2. Conditional Safety: THP allocation is safe under certain conditions
>> but not others.
>>
>> Therefore, I believe we can define these APIs based on the established
>> principles - everything else constitutes implementation details, even
>> if core MM internals need to change.
> 
> But if we're looking to make the concept of THP go away, we really need to
> go further than this.

Yeah. I might be wrong, but I also don't think doing control on a 
per-process level etc would be the right solution long-term.

In a world where we do stuff automatically ("auto" mode), we would be 
much smarter about where to place a (m)THP, and which size we would use.

One might use bpf to control the allocation policy. But I don't think 
this would be per-process or even per-VMA etc. Sure, we might give 
hints, but placement decisions should happen on another level (e.g., 
during page faults, during khugepaged etc).

> 
> The second we have 'bpf program that figures out whether THP should be
> used' we are permanently tied to the idea of THP on/off being a thing.
> 
> I mean any future stuff that makes THP more automagic will probably involve
> having new modes for the legacy THP
> /sys/kernel/mm/transparent_hugepage/enabled and
> /sys/kernel/mm/transparent_hugepage/hugepages-xxkB/enabled

Yeah, the plan is to have "auto" in 
/sys/kernel/mm/transparent_hugepage/enabled and just have all other 
sizes "inherit" that option. And have a Kconfig that just enables that 
as default. Once we're there, just phase out the interface long-term.

That's the plan. Now we "only" have to figure out how to make the 
placement actually better ;)

> 
> But if people are super reliant on this stuff it's potentially really
> limiting.
> 
> I think you said in another post here that you were toying with the notion
> of exposing somehow the madvise() interface and having that be the 'stable
> API' of sorts?
> 
> That definitely sounds more sensible than something that very explicitly
> interacts with THP.
> 
> Of course we have Usama's series and my proposed series for extending
> process_madvise() along those lines also.

Yes.

-- 
Cheers,

David / dhildenb


