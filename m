Return-Path: <bpf+bounces-28414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1720E8B91F6
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 01:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1725D1C21786
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 23:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884D616ABEE;
	Wed,  1 May 2024 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dB4lhYAy"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA716ABDE
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604775; cv=none; b=qdcS5GzFPyaRFjPrR0sUdD39AlvVIyya3bfLgvNT3/2HB8m3x2h1LPZZ7A2z5ogKepZHElF0Vc59WEGCJtDv4hg3nTlvm1YUmepUHW+V3GCaYBY8kRmSYwae+IIWm2KlXWTMOLXmztTSRngzOaFjcXrO0IO5JhEesL4Mj16Psg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604775; c=relaxed/simple;
	bh=AXiCcTxfDcOnawE8n1jT7zZJ1h0MpIBH8x1O5xXWGCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOdxN/wWdHxSMpxzWqesnzvOR5cMBaaIBaeto0aCceGsP+maRVVLTIj4iecZInVgBTmv/szWOMM56HrcZkDUcRS7Lr/EYW3HQrSfdDleQM+COr8cevlgiS5MBQt/pEubkPxIvGv145l5HPhSFBkSsmTJQz7z61GxNEA+okACBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dB4lhYAy; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a17bfcb9-f446-41a4-a543-30dd56f7a7cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714604771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F65+iq4KxuUIE4UZkMQvDdryjR6raQXgdJBkLesXeKg=;
	b=dB4lhYAyx1xjll9fxeaWhlG1SdEOFQKnv4tPdEUhoiYrkW7lA/vX1SqjqY7vHe7LhdB9O7
	pgktUpF2G+iO04zd+cMA45NRzvKG90bbDmJL2W4sJu7CqF5yiM+jiofFbbpLJElMCjrsvT
	na0ezzbgS33xwUzTpVGx5gvHd/jtI20=
Date: Wed, 1 May 2024 16:06:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/6] bpf: provide a function to unregister
 struct_ops objects from consumers.
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-4-thinker.li@gmail.com>
 <f287c62f-628f-4201-ba34-03a7193212d8@linux.dev>
 <23f3dddd-b354-40a4-9b63-81d9e6649a3e@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <23f3dddd-b354-40a4-9b63-81d9e6649a3e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/1/24 3:15 PM, Kui-Feng Lee wrote:
> 
> 
> On 5/1/24 11:48, Martin KaFai Lau wrote:
>> On 4/29/24 2:36 PM, Kui-Feng Lee wrote:
>>> +/* Called from the subsystem that consume the struct_ops.
>>> + *
>>> + * The caller should protected this function by holding rcu_read_lock() to
>>> + * ensure "data" is valid. However, this function may unlock rcu
>>> + * temporarily. The caller should not rely on the preceding rcu_read_lock()
>>> + * after returning from this function.
>>
>> This temporarily losing rcu_read_lock protection is error prone. The caller 
>> should do the inc_not_zero() instead if it is needed.
>>
>> I feel the approach in patch 1 and 3 is a little box-ed in by the earlier 
>> tcp-cc usage that tried to fit into the kernel module reg/unreg paradigm and 
>> hide as much bpf details as possible from tcp-cc. This is not necessarily true 
>> now for other subsystem which has bpf struct_ops from day one.
>>
>> The epoll detach notification is link only. Can this kernel side specific 
>> unreg be limited to struct_ops link only? During reg, a rcu protected link 
>> could be passed to the subsystem. That subsystem becomes a kernel user of the 
>> bpf link and it can call link_detach(link) to detach. Pseudo code:
>>
>> struct link __rcu *link;
>>
>> rcu_read_lock();
>> ref_link = rcu_dereference(link)
>> if (ref_link)
>>      ref_link = bpf_link_inc_not_zero(ref_link);
>> rcu_read_unlock();
>>
>> if (!IS_ERR_OR_NULL(ref_link)) {
>>      bpf_struct_ops_map_link_detach(ref_link);
>>      bpf_link_put(ref_link);
>> }
> 
> 
> Since not every struct_ops map has a link, we need a callback in additional
> to ops->reg to register links with subsystems. If the callback is
> ops->reg_link, struct_ops will call ops->reg_link if a subsystem provide
> it and the map is registered through a link, or it should call ops->reg.

I would just add a link pointer arg to the existing reg(). The same probably 
needs to be done for unreg(). Pass a NULL as the link if it does not have one 
during reg(). If the subsystem chooses to enforce link only struct_ops, it can 
reject if link is not provided during reg().



