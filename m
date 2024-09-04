Return-Path: <bpf+bounces-38939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B2E96CA2B
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 00:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61861F288BE
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 22:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F715E5D3;
	Wed,  4 Sep 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r7tUoSfo"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63D154456
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488520; cv=none; b=J7YJKDZDOgor66brUfBgZ8vK3WAVufjuVOI0v5w1FCkQ3jjehKL3fV+WF0+ter26fGl4Uw/OuLVWy4HYqyjZt+gKLujV1Gda4Se8YA2SrS+nccIl5w0EY6NjatqWqLjnVvhpLZOgTfH9zj9D7mu7LnuW5Vc4YGU/EjBAQNHa+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488520; c=relaxed/simple;
	bh=Qya3p0z23V3Ou1e5tj/LI/dBu0sP3X/F0iiAevXtKLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6kt4h2C5s1WuQCCysY4gnrKDBmET04ZitrA8VkdLnDAroh6oisERvsinbgp8Jiorseo+Ug/osx5iDWN0oqu8sxd34Q/7gTPQHTT9IwmUdaVmdHWyNt4rkqps4kbkihgUAak7de80wLT567ocGLkVmi8s3bN1YJLg/uy5S+SWjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r7tUoSfo; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70a1b24f-84cd-464c-8fb6-a2c52fd3d703@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725488516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I878VpUdVTEx9+klbDYSkj67bfJZkb3Se/53OB4PWH4=;
	b=r7tUoSfoO7hLnMU1AaKbR7QUDnc4c4US7CLqE4h10TocClvJjdyg/bt8tihKfCAOoJuJBI
	OUTXmzfNuN0SYrDHx4BHIcAB8uoQSfqIxX+97lm8M4+Xf1G1BFRZZAgIkVa1eM+uVzCr7z
	qJOVWhW/rTixtZfoQ5YnKYaPG9nQ//o=
Date: Wed, 4 Sep 2024 15:21:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v4 4/6] bpf: pin, translate, and unpin __uptr from
 syscalls.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Kui-Feng Lee <sinquersw@gmail.com>,
 linux-mm <linux-mm@kvack.org>
References: <20240816191213.35573-1-thinker.li@gmail.com>
 <20240816191213.35573-5-thinker.li@gmail.com>
 <CAADnVQLUN1XLzV0kVbXWm5TaQyH5pN4M3agha-uZoWP3Dkcw8Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAADnVQLUN1XLzV0kVbXWm5TaQyH5pN4M3agha-uZoWP3Dkcw8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/24 4:24 PM, Alexei Starovoitov wrote:
>> @@ -714,6 +869,11 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>>                                  field->kptr.dtor(xchgd_field);
>>                          }
>>                          break;
>> +               case BPF_UPTR:
>> +                       if (*(void **)field_ptr)
>> +                               bpf_obj_unpin_uptr(field, *(void **)field_ptr);
>> +                       *(void **)field_ptr = NULL;
> This one will be called from
>   task_storage_delete->bpf_selem_free->bpf_obj_free_fields
> 
> and even if upin was safe to do from that context
> we cannot just do:
> *(void **)field_ptr = NULL;
> 
> since bpf prog might be running in parallel,
> it could have just read that addr and now is using it.
> 
> The first thought of a way to fix this was to split
> bpf_obj_free_fields() into the current one plus
> bpf_obj_free_fields_after_gp()
> that will do the above unpin bit.
> and call the later one from bpf_selem_free_rcu()
> while bpf_obj_free_fields() from bpf_selem_free()
> will not touch uptr.
> 
> But after digging further I realized that task_storage
> already switched to use bpf_ma, so the above won't work.
> 
> So we need something similar to BPF_KPTR_REF logic:
> xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
> and then delay of uptr unpin for that address into call_rcu.
> 
> Any better ideas?

Many thanks to Kui-Feng starting this useful work on task storage. I will think 
about it and respin the set.

