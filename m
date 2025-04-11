Return-Path: <bpf+bounces-55788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37B8A866CB
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 22:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47DB17FB10
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173252836B3;
	Fri, 11 Apr 2025 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xnykIaSg"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF41F03EF
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744402299; cv=none; b=k/3qOm50kx7litkGQxm1mBJijVHEMXHRCkmfS/Do/aBVFPVqIw0x6RlyhnsKtYAduAMGFEC8b9iVrdgRAAL2uPccLbxxq3dQ9OEHAbwbQspcIl1doX+eEcEdLlwYGOLz0s98O9Fn4y1PWSg5Tlv8mSXrQJsGvDDTNZiQ9F5RmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744402299; c=relaxed/simple;
	bh=e+4M6Xi9F6viTakNIyhD3Ar/xzm9xyC73i6KofLE8kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8dE/ADBklqZCgZE/CJk7hLh39i1yYp6lh3OcrWNY7I0nQA95W/mgPCxx1C6p+2vMdozjek/U+A8Jsys+4mPH2k7uuNjwEbgNohpPtqdYcW2Z+ngERcffrqSHg9Krn7Tz1j5gB/xW3FT7tUh9fDgF2DVNkrxu0jLAytSYGGDnVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xnykIaSg; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <10ca0a54-18b0-43fd-bf70-c1ab15349e87@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744402292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcQUiY23RBFB/J8LBRhiVaGaEbURCximcrcml47+nR0=;
	b=xnykIaSg9fg4qmHzJJAuFq/B7cQ8StoEI/I6OSbyGvN1xkM01mgHhK1OrXrJcS2oyimwyd
	9lz6i4ZVvPQl6BplN0bgGxQFlqt3OIYYqgGtgmK+yPLQuYWQs5Wg6g6BhGZWcDUBwp2Voa
	BlOs4a5vTU+24lTF4hfnDsYFLvBeITs=
Date: Fri, 11 Apr 2025 13:11:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 03/10] bpf: net_sched: Add basic bpf qdisc
 kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org,
 xiyou.wangcong@gmail.com, jhs@mojatatu.com, martin.lau@kernel.org,
 jiri@resnulli.us, stfomichev@gmail.com, toke@redhat.com,
 sinquersw@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, yepeilin.cs@gmail.com, kernel-team@meta.com
References: <20250409214606.2000194-1-ameryhung@gmail.com>
 <20250409214606.2000194-4-ameryhung@gmail.com>
 <CAP01T77ibGcEhwsyJb1WVaH-vhbZB_M2yVA8Uyv9b5fy=ErWQQ@mail.gmail.com>
 <CAMB2axNqfBpneVc9unn7S65Ewb1u6EpLudjtiq00-sqbfnSY7w@mail.gmail.com>
 <CAP01T76oTKg5H2nqd5ppyLhk1rNjPY0DcYVELmyZU+Du8izbbA@mail.gmail.com>
 <08811dd9-2449-42c9-8028-8a4dfec20afd@linux.dev>
 <CAMB2axNeb-UzO8AOkdXPcqrwnw2J6vKVLSRVM_R+oN=SJEsx9g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axNeb-UzO8AOkdXPcqrwnw2J6vKVLSRVM_R+oN=SJEsx9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/11/25 1:03 PM, Amery Hung wrote:
>> The same goes for the bpf_kfree_skb(). I was thinking if it is useful at all
>> considering there is already a bpf_qdisc_skb_drop(). I kept it there because it
>> is a little more intuitive in case the .reset/.destroy wanted to do a "skb =
>> bpf_kptr_xchg(&skbn->skb, NULL);" and then explicitly free the
>> bpf_kfree_skb(skb). However, the bpf prog can also directly do the
>> bpf_obj_drop(skbn) and then bpf_kfree_skb() is not needed, right?
>>
>>
> 
> My rationale for keeping two skb releasing kfuncs: bpf_kfree_skb() is
> the dtor and since dtor can only have one argument, so
> bpf_qdisc_skb_drop() can not replace it. Since bpf_kfree_skb() is here
> to stay, I allow users to call it directly for convenience. Only
> exposing bpf_qdisc_skb_drop() and calling kfree_skb() in
> bpf_qdisc_skb_drop() when to_free is NULL will also do. I don’t have a
> strong opinion.
> 
> Yes, bpf_kfree_skb() will not be needed if doing bpf_obj_drop(skbn).
> bpf_obj_drop() internally will call the dtor of a kptr (i.e., in this
> case, bpf_kfree_skb()) in an allocated object.

Make sense. Lets keep the bpf_kfree_skb() as-is instead of complicating the 
bpf_qdisc_skb_drop() with NULL vs non-NULL argument.


