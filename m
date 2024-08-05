Return-Path: <bpf+bounces-36411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD849482C6
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 22:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8B528386A
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81BC16BE00;
	Mon,  5 Aug 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nHEJMNCG"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45715F3FE
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888032; cv=none; b=MMCmjHk9CZzGRkfM/C7Xl92mxlbsmmkqSxlv7pP167+9E5BqM9L8xe/DxrevkSVrgbksug1kmKSX/x65dL6Wqh7rOcPWnRaeSJVOJm6J2RIgWL4vSI7uDpaN6zWoeQtxVWYwmUQ7d2ui7AgbPKovtlhBzH/eGjy0s67wec+Dfkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888032; c=relaxed/simple;
	bh=XANk7IVYWZp8pOs5CbymWk7HkClJ55TCVBQFD0PHFBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEeCFvTSsPzO4zRhPWUaWbCIWeiEj1bU/77a2VHNt0+IueGW30E8w+pOul+codLEciuFeu5yaCEgUyvMeLrBzqN249lVUGh6to2YtCMuQLT4NzVryc6R0aJfX0AUDOsfRtB2LhIxaRdwOcrcTTO6adJOkMCn8AGHvEPEDwwvKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nHEJMNCG; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c72b14ef-47a9-4746-876a-609542755dd0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722888026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7XyPEiUvLwDgO8/GgMDYF/1ZvEZdTVu+LG89R2dMA0=;
	b=nHEJMNCGxjkbr1Q4o+5G9wTidiAcIyp94YaRNbKvJiBWp4xiNSCrf3gq5KIZLg5D74afxW
	LAOW8tp/LuvjbCOc4g6nolWGgEuiMd8U2zG6aNRaJJqtziZv3u7p5I1X9c5ctCEXBf89pT
	U8vRlR8RIn6I+7gj053MYmfTo57zlyc=
Date: Mon, 5 Aug 2024 13:00:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
To: Hou Tao <houtao@huaweicloud.com>, Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com,
 davemarchevsky@fb.com, Amery Hung <amery.hung@bytedance.com>
References: <20240803001145.635887-1-amery.hung@bytedance.com>
 <20240803001145.635887-2-amery.hung@bytedance.com>
 <2921fc67-9129-1b5d-e720-1ca8f64e47fc@huaweicloud.com>
 <CAMB2axMwf07usb4gqocBH_9hgPsu9_VLQYMp83gV0sdazrcc-g@mail.gmail.com>
 <7b527651-a551-7d57-19d2-15dbff25db92@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <7b527651-a551-7d57-19d2-15dbff25db92@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/5/24 12:32 AM, Hou Tao wrote:
> Hi,
> 
> On 8/5/2024 12:31 PM, Amery Hung wrote:
>> On Sun, Aug 4, 2024 at 7:41 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Hi,
>>>
>>> On 8/3/2024 8:11 AM, Amery Hung wrote:
>>>> From: Dave Marchevsky <davemarchevsky@fb.com>
>>>>
>>>> Currently btf_parse_fields is used in two places to create struct
>>>> btf_record's for structs: when looking at mapval type, and when looking
>>>> at any struct in program BTF. The former looks for kptr fields while the
>>>> latter does not. This patch modifies the btf_parse_fields call made when
>>>> looking at prog BTF struct types to search for kptrs as well.
>>>>
>>> SNIP
>>>> On a side note, when building program BTF, the refcount of program BTF
>>>> is now initialized before btf_parse_struct_metas() to prevent a
>>>> refcount_inc() on zero warning. This happens when BPF_KPTR is present
>>>> in program BTF: btf_parse_struct_metas() -> btf_parse_fields()
>>>> -> btf_parse_kptr() -> btf_get(). This should be okay as the program BTF
>>>> is not available yet outside btf_parse().
>>> If btf_parse_kptr() pins the passed btf, there will be memory leak for
>>> the btf after closing the btf fd, because the invocation of btf_put()
>>> for kptr record in btf->struct_meta_tab depends on the invocation of
>>> btf_free_struct_meta_tab() in btf_free(), but the invocation of
>>> btf_free() depends the final refcnt of the btf is released, so the btf
>>> will not be freed forever. The reason why map value doesn't have such
>>> problem is that the invocation of btf_put() for kptr record doesn't
>>> depends on the release of map value btf and it is accomplished by
>>> bpf_map_free_record().
>>>
>> Thanks for pointing this out. It makes sense to me.
>>
>>> Maybe we should move the common btf used by kptr and graph_root into
>>> btf_record and let the callers of btf_parse_fields() and
>>> btf_record_free() to decide the life cycle of btf in btf_record.
>> Could you maybe explain if and why moving btf of btf_field_kptr and
>> btf_field_graph_root to btf_record is necessary? I think letting
>> callers of btf_parse_fields() and btf_record_free() decide whether or
>> not to change refcount should be enough. Besides, I personally would
>> like to keep individual btf in btf_field_kptr and
>> btf_field_graph_root, so that later we can have special fields
>> referencing different btf.
> 
> Sorry, I didn't express the rough idea clearly enough. I didn't mean to
> move btf of btf_field_kptr and btf_field_graph_root to btf_record,
> because there are other btf-s which are different with the btf which
> creates the struct_meta_tab. What I was trying to suggest is to save one
> btf in btf_record and hope it will simplify the pin and the unpin of btf
> in btf_record:
> 
> 1) save the btf which owns the btf_record in btf_record.
> 2) during btf_parse_kptr() or similar, if the used btf is the same as
> the btf in btf_record, there is no need to pin the btf

I assume the used btf is the one that btf_parse is working on.

> 3) when freeing the btf_record, if the btf saved in btf_field is the
> same as the btf in btf_record, there is no need to put it

For btf_field_kptr.btf, is it the same as testing the btf_field_kptr.btf is 
btf_is_kernel() or not? How about only does btf_get/put for btf_is_kernel()?


> 
> For step 2) and step 3), however I think it is also doable through other
> ways (e.g., pass the btf to btf_record_free or similar).

