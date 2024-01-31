Return-Path: <bpf+bounces-20853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19F584461C
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531DB1F2986B
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FEA12CDB2;
	Wed, 31 Jan 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GF8TVVP3"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991D12BF33
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722034; cv=none; b=Poy61vI2nFn7DQ4Zk6SmqOdDIE8mfMyShKjSFoVR4kG6EeANe0CDtl1dnRJO1VHd2AMlZP0rYLB9ZTQyZSPgGgaMQesaW7naEGxRXQ3BfoEisM5+z3Gm6jpsb0DK6AMwCf2XEIT+cLKOhXsuB0grK+ayNijTxozTy/lrOJQbkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722034; c=relaxed/simple;
	bh=AnEQZcaz1WMtq26EmVZWuCpNf/k6jZnQdB71B+IEHB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umLcg3IQLghu4f5N0ELksZQmlDcsliihP6zpMi0tc/PG+n87rlPkSXjqxMA4y63kQsmnx2TaCwvpP/1xqtb2vUrPD9haY3PPLw09JsNldqcA7A8KTyFRszdBvidezTXo7LxA8B9B6OICWcaGG4s42jb+uG8qTwwwQ/FbnGkDcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GF8TVVP3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6fb02841-e6f8-4737-b538-c0d259e28cfe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706722030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhrUU/l8/9qST2qGCmyskD53pxPxthSi2sEXkDbVFMc=;
	b=GF8TVVP3IUmFFMF9VqsBLII3nyGtSqQtw73MFVk1/8x8oO1gj8TmFjAjwWlmVH0LT/4kXn
	+os3gWH+JBIRIZM5iFIPm+aNmc84Giar4+a63KPp/E+MXGKpiYKJ9cOQoqVn7DN6nu7xpC
	yy+PMU3iuqwf0uziJ/YGOAcTuEBdASc=
Date: Wed, 31 Jan 2024 09:27:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/5] libbpf: add btf__new_split() API that was
 declared but not implemented
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
References: <20240130193649.3753476-1-andrii@kernel.org>
 <20240130193649.3753476-4-andrii@kernel.org>
 <3b4b98dd-64a6-4fbd-bc8f-45006cc0e089@linux.dev>
 <CAEf4BzZbZOg=OYuSmNZEj1guMxg-Jvxn1k_OeZM6UtDk8w20OQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZbZOg=OYuSmNZEj1guMxg-Jvxn1k_OeZM6UtDk8w20OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/31/24 9:20 AM, Andrii Nakryiko wrote:
> On Tue, Jan 30, 2024 at 9:30 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
>>> Seems like original commit adding split BTF support intended to add
>>> btf__new_split() API, and even declared it in libbpf.map, but never
>>> added (trivial) implementation. Fix this.
>>>
>>> Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> The patch LGTM. We did some cross checking between libbpf.map
>> and the implementation. What things are missing here to
>> capture missed implementation or LIBBPF_API marking?
> Yes, we still have it, and it does detect issues when API wasn't added
> into libbpf.map.
>
> I haven't investigated exactly why it didn't catch the issue when API
> is in libbpf.map, but is not marked with LIBBPF_API, but I suspect
> it's because existing check doesn't take into account visibility of
> the symbol, so there is some room for improvement.
>
> Similarly, not sure why it didn't detect that btf_ext__new_split()
> wasn't even implemented, probably because we don't distinguish UNDEF
> and FUNC symbols? So something to follow up on for sure.

Agreed. A followup to improve API matching between libbpf.map and code
can be done later.

>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>
>>> ---
>>>    tools/lib/bpf/btf.c      | 5 +++++
>>>    tools/lib/bpf/libbpf.map | 3 ++-
>>>    2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>> index 95db88b36cf3..845034d15420 100644
>>> --- a/tools/lib/bpf/btf.c
>>> +++ b/tools/lib/bpf/btf.c
>>> @@ -1079,6 +1079,11 @@ struct btf *btf__new(const void *data, __u32 size)
>>>        return libbpf_ptr(btf_new(data, size, NULL));
>>>    }
>>>
>>> +struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf)
>>> +{
>>> +     return libbpf_ptr(btf_new(data, size, base_btf));
>>> +}
>>> +
>>>    static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>>>                                 struct btf_ext **btf_ext)
>>>    {
>>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>>> index d9e1f57534fa..386964f572a8 100644
>>> --- a/tools/lib/bpf/libbpf.map
>>> +++ b/tools/lib/bpf/libbpf.map
>>> @@ -245,7 +245,6 @@ LIBBPF_0.3.0 {
>>>                btf__parse_raw_split;
>>>                btf__parse_split;
>>>                btf__new_empty_split;
>>> -             btf__new_split;
>>>                ring_buffer__epoll_fd;
>>>    } LIBBPF_0.2.0;
>>>
>>> @@ -411,5 +410,7 @@ LIBBPF_1.3.0 {
>>>    } LIBBPF_1.2.0;
>>>
>>>    LIBBPF_1.4.0 {
>>> +     global:
>>>                bpf_token_create;
>>> +             btf__new_split;
>>>    } LIBBPF_1.3.0;

