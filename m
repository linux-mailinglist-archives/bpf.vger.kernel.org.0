Return-Path: <bpf+bounces-42982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB75C9AD8FD
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1701C2183C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 00:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8DCC8F0;
	Thu, 24 Oct 2024 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i7IfyvoY"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE9B658
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729730699; cv=none; b=GXs7lDYVVF56kiYoJgP0Cxb7L2FPwlb/qHY/iUL2FMFHnSdeMRKlvFNEawM4A84gU41r8K31FgjTIw74zwELSn2qq+Satzh4kAMxM7z3TvjAf0na80ml1paJEDEWfmOADdAzTD1b9TcmCEkbb7IBe2z5JyPJs2zRtRqZ2ILwako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729730699; c=relaxed/simple;
	bh=UCldnDRWMi45Fh2e61634tkPIgU+O/P1LXlwbEn7rmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeSVYq7rcbVbBlvLG1ysMK6qSCEXXeVUT7WNw+bk4dDw4I35DB7yqIUkQ6ybbk4u5BSRPJNjlBeoxw7ttc9qrD0L5jS6QYmNnY1BYIebHCBFP48S4z5GYGxvv78GkkRyA3vcQzuqMayRwlrFuXL71anU++DhzwFFWaaWqaRLD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i7IfyvoY; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdd04472-7e8d-4609-986b-bbea82fd77ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729730694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4U5Grdy9U7IEXbPXIYSkeQV5LOqLXNssTe9EsB9reiA=;
	b=i7IfyvoYvEu+bReDQmHHJ8Gblr7SZceNBzgW6M8lXfaM/uONt2tkWht78OXkWY1MOhidYs
	eZhUNi/Y/wSCv8WlfFEQP0V8kTErkpOAxrC0Bpr6HnHWDOuYSwOVDKzMbe9v81C1TsqXHe
	UJFATi3G8SnLFG1PZ8soOW0wEjznQEM=
Date: Wed, 23 Oct 2024 17:44:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 06/12] bpf: Add uptr support in the map_value
 of the task local storage.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kui-Feng Lee <thinker.li@gmail.com>, kernel-team@meta.com, linux-mm@kvack.org
References: <20241015005008.767267-1-martin.lau@linux.dev>
 <20241015005008.767267-7-martin.lau@linux.dev>
 <pu7v27kmibjeqmmom3xbkcgq5w3okk5bgfrponpcmioxrncq7y@3ebhucmwyxsz>
 <2ngvjjbgow7bhsr5bpcyosxrzkbaux6mrvtvh2ru6wrzujtoki@7vpyhef5vux5>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <2ngvjjbgow7bhsr5bpcyosxrzkbaux6mrvtvh2ru6wrzujtoki@7vpyhef5vux5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/22/24 5:57 PM, Shakeel Butt wrote:
> On Tue, Oct 22, 2024 at 04:07:50PM GMT, Shakeel Butt wrote:
>> On Mon, Oct 14, 2024 at 05:49:56PM GMT, Martin KaFai Lau wrote:
>>> From: Martin KaFai Lau <martin.lau@kernel.org>
> [...]
>>> +
>>> +		err = pin_user_pages_fast(start, 1, FOLL_LONGTERM | FOLL_WRITE, &page);
>>> +		if (err != 1)
>>> +			goto unpin_all;
>>> +
>>> +		*uptr_addr = page_address(page) + offset_in_page(start);
>>
>> Please use kmap(page) instead of page_address(page) and then you will
>> need to kunmap(kptr) on the unpin side.
>>
> 
> This is needed only if you plan to support your feature for HIGHMEM
> kernels though. Otherwise you can error out for PageHighMem(page).

I just posted v6 with the PageHighMem(page). Thanks for the review.

