Return-Path: <bpf+bounces-40665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6E998BD53
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84ACA1C23A45
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235019C556;
	Tue,  1 Oct 2024 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jO2dnp89"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814436C
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788815; cv=none; b=FDdWhKcNC8N6tyU+DgMpPSIcMYZMl3qHe7tnTs5xb3a6b30Qd8ZhWEQnSMp3seUdKOt5MGOWOAU0nZbHiYcuBKFuQmJ0ntmAHXOfEFHfpQVi51Yvn3ZGv22zsVcJkIukLsiJ1Sz4ayhvIJlNeld7Dz9b35mW1XhZU9V9BggVVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788815; c=relaxed/simple;
	bh=/nFgSK20uBPDbf913wW2+HGOwvVgLYncLSiV/E7ksEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YC6TDNE/7uRtOz5sTTTyBAXuOSuD12OdPoPe7Dk2oobEgJmBiNQJDzeQsxWmYXr/Zm/MZBtmDa464pzEU8zLfNKRpxRJHH4aKQNaHF2KApi9g9T4uHTG4uKvL3JnW4vjK+RjrtO7fGcJc451YEUOsa8IWTR1FoaT7U0mTWET5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jO2dnp89; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <57d535b9-1229-4048-aee5-7184c2ca9e9e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727788810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNIkNx1nPQPBC/SErBnr8uWBmz3ekUNkm4jo1rBrhYs=;
	b=jO2dnp89hZfZMHas09NPIxRugYyjIVbxmds825HWjLp2jD4hz+YxtUsb37EMB+JB3HM9iU
	h+FnoOiDDADR4XcxQUfq1aLJcqS3fMkI8OEk3pNwTSALEZ+q/Cl4fkszHX65jc3uVNZ7tQ
	NiI45tevR2kBb4S9UhUr2gDgTDoP6j8=
Date: Tue, 1 Oct 2024 21:20:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Prevent updating extended prog to
 prog_array map
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 xukuohai@huaweicloud.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240929132757.79826-1-leon.hwang@linux.dev>
 <20240929132757.79826-2-leon.hwang@linux.dev>
 <916f579cce8397b45790b1db68ad2a61cce4dfd8.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <916f579cce8397b45790b1db68ad2a61cce4dfd8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/10/1 19:13, Eduard Zingerman wrote:
> On Sun, 2024-09-29 at 21:27 +0800, Leon Hwang wrote:
> 
> [...]
> 
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 79660e3fca4c1..4a4de4f014be9 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -947,16 +947,29 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
>>  				   struct file *map_file, int fd)
>>  {
>>  	struct bpf_prog *prog = bpf_prog_get(fd);
>> +	bool is_extended;
>>  
>>  	if (IS_ERR(prog))
>>  		return prog;
>>  
>> -	if (!bpf_prog_map_compatible(map, prog)) {
>> -		bpf_prog_put(prog);
>> -		return ERR_PTR(-EINVAL);
>> -	}
>> +	if (!bpf_prog_map_compatible(map, prog))
>> +		goto out_put_prog;
>> +
>> +	mutex_lock(&prog->aux->ext_mutex);
>> +	is_extended = prog->aux->is_extended;
>> +	mutex_unlock(&prog->aux->ext_mutex);
>> +	if (is_extended)
>> +		/* Extended prog can not be tail callee. It's to prevent a
>> +		 * potential infinite loop like:
>> +		 * tail callee prog entry -> tail callee prog subprog ->
>> +		 * freplace prog entry --tailcall-> tail callee prog entry.
>> +		 */
>> +		goto out_put_prog;
> 
> Nit: I think return value should be -EBUSY in this case.

Ack.

> 
>>  
>>  	return prog;
>> +out_put_prog:
>> +	bpf_prog_put(prog);
>> +	return ERR_PTR(-EINVAL);
>>  }
>>
> 
> [...]
> 
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index a8f1808a1ca54..db17c52fa35db 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3212,14 +3212,23 @@ static void bpf_tracing_link_release(struct bpf_link *link)
>>  {
>>  	struct bpf_tracing_link *tr_link =
>>  		container_of(link, struct bpf_tracing_link, link.link);
>> -
>> -	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
>> -						tr_link->trampoline));
>> +	struct bpf_prog *tgt_prog = tr_link->tgt_prog;
>> +
>> +	if (link->prog->type == BPF_PROG_TYPE_EXT) {
>> +		mutex_lock(&tgt_prog->aux->ext_mutex);
>> +		WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
>> +							tr_link->trampoline));
>> +		tgt_prog->aux->is_extended = false;
> 
> In case if unlink fails is_extended should not be reset.
>

Nope.

In bpf_trampoline_unlink_prog(), 'tr->extension_prog = NULL;' always no
matter whether fail to unlink.

So, it should reset is_extended always too.

Thanks,
Leon

>> +		mutex_unlock(&tgt_prog->aux->ext_mutex);
>> +	} else {
>> +		WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
>> +							tr_link->trampoline));
>> +	}
>>  
>>  	bpf_trampoline_put(tr_link->trampoline);
>>  
>>  	/* tgt_prog is NULL if target is a kernel function */
>> -	if (tr_link->tgt_prog)
>> +	if (tgt_prog)
>>  		bpf_prog_put(tr_link->tgt_prog);
>>  }
> 
> [...]
> 


