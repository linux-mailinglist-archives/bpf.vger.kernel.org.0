Return-Path: <bpf+bounces-36432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC594856F
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 00:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC52283834
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 22:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939B816E877;
	Mon,  5 Aug 2024 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vA0lxvFX"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD716CD11
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722896734; cv=none; b=S8Fpp3IYAOE0qFh6hmYhPHSIPiJK4un4S4ZsrFxn6I9zKeooYToqX25GefGNWcSpMx8f12Ez0JfUr9UrqCiWiflKM5+avQ2EXqodav+4WSzt6uMZ1UyW02UiSVSfWtiss5RTuEuHHG34f0GmkrLq4Xza+gmZoQDozHQrEloxL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722896734; c=relaxed/simple;
	bh=xq5xBWGv38XPFD+wRfc8LRAItUPml+Jo13yBj0yW0Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+TKXLLnhbwFEhLOK1DGXuvp0pXfQrxSEm5vml+wLEdKYqsM+LlQGJaicWQ/ufVClKPw9sz/425Za7B43Vz2BbuSWWk/6cC509k4B1tEh8NYMa6Rys4TdWGBbSL3iu5gNERCXSm2lQ2zWqVyDRKpwN1NQSRDKwqWmwaN1blwIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vA0lxvFX; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fc6ba752-78c0-4514-900d-7bef6c1f447e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722896731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4Av6xbq7clNfTahj34VoDxajX926f4my63Yz0IQvpc=;
	b=vA0lxvFX1KGhff78arK6DuJLWRSyMBeHVzKujpSbOiKEnqNrJCmqAudirF8nJH46Syxcd4
	G1bsgfkW5JVAykbWrYO0gRRFgyRAvFCHKZrjw29YxuVS5nUcGeSm7o6MB8vn/6gaMSrQfb
	Eujuc8aaQiFehfOWO8tib1/6AB/lF7c=
Date: Mon, 5 Aug 2024 15:25:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
To: Amery Hung <ameryhung@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, davemarchevsky@fb.com,
 Amery Hung <amery.hung@bytedance.com>
References: <20240803001145.635887-1-amery.hung@bytedance.com>
 <20240803001145.635887-2-amery.hung@bytedance.com>
 <2921fc67-9129-1b5d-e720-1ca8f64e47fc@huaweicloud.com>
 <CAMB2axMwf07usb4gqocBH_9hgPsu9_VLQYMp83gV0sdazrcc-g@mail.gmail.com>
 <7b527651-a551-7d57-19d2-15dbff25db92@huaweicloud.com>
 <c72b14ef-47a9-4746-876a-609542755dd0@linux.dev>
 <CAMB2axMOTr-3svaKGqHxAwoR2_uZQ7ZWJrOzSZF7o7jqndhxQQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axMOTr-3svaKGqHxAwoR2_uZQ7ZWJrOzSZF7o7jqndhxQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/5/24 1:44 PM, Amery Hung wrote:
>>>>> Maybe we should move the common btf used by kptr and graph_root into
>>>>> btf_record and let the callers of btf_parse_fields() and
>>>>> btf_record_free() to decide the life cycle of btf in btf_record.
>>>> Could you maybe explain if and why moving btf of btf_field_kptr and
>>>> btf_field_graph_root to btf_record is necessary? I think letting
>>>> callers of btf_parse_fields() and btf_record_free() decide whether or
>>>> not to change refcount should be enough. Besides, I personally would
>>>> like to keep individual btf in btf_field_kptr and
>>>> btf_field_graph_root, so that later we can have special fields
>>>> referencing different btf.
>>>
>>> Sorry, I didn't express the rough idea clearly enough. I didn't mean to
>>> move btf of btf_field_kptr and btf_field_graph_root to btf_record,
>>> because there are other btf-s which are different with the btf which
>>> creates the struct_meta_tab. What I was trying to suggest is to save one
>>> btf in btf_record and hope it will simplify the pin and the unpin of btf
>>> in btf_record:
>>>
>>> 1) save the btf which owns the btf_record in btf_record.
>>> 2) during btf_parse_kptr() or similar, if the used btf is the same as
>>> the btf in btf_record, there is no need to pin the btf
>>
>> I assume the used btf is the one that btf_parse is working on.
>>
>>> 3) when freeing the btf_record, if the btf saved in btf_field is the
>>> same as the btf in btf_record, there is no need to put it
>>
>> For btf_field_kptr.btf, is it the same as testing the btf_field_kptr.btf is
>> btf_is_kernel() or not? How about only does btf_get/put for btf_is_kernel()?
>>
> 
> IIUC. It will not be the same. For a map referencing prog btf, I
> suppose we should still do btf_get().
> 
> I think the core idea is since a btf_record and the prog btf
> containing it has the same life time, we don't need to
> btf_get()/btf_put() in btf_parse_kptr()/btf_record_free() when a
> btf_field_kptr.btf is referencing itself.
> 
> However, since btf_parse_kptr() called from btf_parse() and
> map_check_btf() all use prog btf, we need a way to differentiate the
> two. Hence Hou suggested saving the owner's btf in btf_record, and

map_check_btf() calls btf_parse_kptr(map->btf).

I am missing how it is different from the 
btf_new_fd()=>btf_parse()=>btf_parse_kptr(new_btf).

akaik, the map->record has no issue now because bpf_map_free_deferred() does 
btf_record_free(map->record) before btf_put(map->btf). In the map->record case, 
does the map->record need to take a refcnt of the btf_field_kptr.btf if the 
btf_field_kptr.btf is pointing back to itself (map->btf) which is not a kernel btf?

> then check if btf_record->btf is the same as the btf_field_kptr.btf in
> btf_parse_kptr()/btf_record_free().

I suspect it will have the same end result? The btf_field_kptr.btf is only the 
same as the owner's btf when btf_parse_kptr() cannot found the kptr type from a 
kernel's btf (the id == -ENOENT case in btf_parse_kptr).

