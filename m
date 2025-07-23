Return-Path: <bpf+bounces-64180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DBDB0F77F
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B03A960519
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BC31E3787;
	Wed, 23 Jul 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tbw5DceG"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4A1F03D5
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285962; cv=none; b=VuC3p+iZgujR92RnsLgHdL9gnSMSeW3jx7PrhEcq3iVVcrWCcy9+nRKsg3VoUcf1Efbi8DxZ+FUn3DEm8IO0yGZL3nj4M883JvWqwxwaKi3wa2MwjxlS93/fI19aesPFm/fT60PKH4EBZiBUEWEJsZqUZGSkbxUNHXX8PUb+SWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285962; c=relaxed/simple;
	bh=DiBOvH++NZsUHSC2Dr6hotPOdDYDVFXQoekPTVW6LfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWcI/kVKR1z+hFuazAdc7zkfP2KQN+FV4/UqAILuxGK8bwMRcdnk4ceIWKVsEc4ht6DL+BHkdbqHueoMN0lDG83TFKMCEQ67LA6vcIp/lxZ33bJUj5KbuFJv1R8pb9wPjxhIhHJhP4I7rOFa93y08hpi0bOmzpCylNVdSy4F1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tbw5DceG; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <74709a08-4536-4c5a-8140-12d8b42e97c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753285957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4n+zG0TX4zRTGBk8jZsFMT6r7aY4KxsTCaDB/5pV6qw=;
	b=Tbw5DceGwh3X7jnj4xTXQTxMUpSMwoXsp/qExD1BzgnhP/Ux1hTxJXBzCnriV6Uv15Bqnk
	JZb8742QhCajE7ZL3fSj0D8Fi/3PeKthI1kpXDGn5DDszDqLI5PQjaTAVBwfTHSxsgXeVT
	xSih5pywZe7x8WOpescejqu4Yz2GIp4=
Date: Wed, 23 Jul 2025 08:52:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] bpftool: Add CET-aware symbol matching for x86_64
 architectures
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>,
 aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuan Chen <chenyuan@kylinos.cn>
References: <20250723022043.20503-1-chenyuan_fl@163.com>
 <aIDe3IR2SR6S0WM9@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aIDe3IR2SR6S0WM9@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/23/25 6:08 AM, Jiri Olsa wrote:
> On Wed, Jul 23, 2025 at 10:20:43AM +0800, chenyuan_fl@163.com wrote:
>> From: Yuan Chen <chenyuan@kylinos.cn>
>>
>> Adjust symbol matching logic to account for Control-flow Enforcement
>> Technology (CET) on x86_64 systems. CET prefixes functions with
>> a 4-byte 'endbr' instruction, shifting the actual hook entry point to
>> symbol + 4.
>>
>> Changed in PATCH v4:
>> * Refactor repeated code into a function.
>> * Add detection for the x86 architecture.
>>
>> Changed int PATH v5:
>> * Remove detection for the x86 architecture.
>>
>> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
>> ---
>>   tools/bpf/bpftool/link.c | 26 ++++++++++++++++++++++++--
>>   1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
>> index a773e05d5ade..288bf9a032a5 100644
>> --- a/tools/bpf/bpftool/link.c
>> +++ b/tools/bpf/bpftool/link.c
>> @@ -282,6 +282,28 @@ get_addr_cookie_array(__u64 *addrs, __u64 *cookies, __u32 count)
>>   	return data;
>>   }
>>   
>> +static bool
>> +symbol_matches_target(__u64 sym_addr, __u64 target_addr)
>> +{
>> +	if (sym_addr == target_addr)
>> +		return true;
>> +
>> +#if defined(__x86_64__)
>> +	/*
>> +	 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
>> +	 * function entry points have a 4-byte 'endbr' instruction prefix.
>> +	 * This causes kprobe hooks to target the address *after* 'endbr'
>> +	 * (symbol address + 4), preserving the CET instruction.
>> +	 * Here we check if the symbol address matches the hook target address
>> +	 * minus 4, indicating a CET-enabled function entry point.
>> +	 */
>> +	if (sym_addr == target_addr - 4)
>> +		return true;
>> +#endif
> looks good.. perhaps it might be too much, but should we try to read
> CONFIG_X86_KERNEL_IBT value and do the check based on that? there's
> already some code reading options in probe_kernel_image_config

Sounds a good idea. Maybe we can abstract out a helper function
based on probe_kernel_image_config() so it can be used in
both probe_kernel_image_config() and for this symbol_matches_target
case. We can have a variable like 'ibt_supported = ...' outside
the loop. In the above we can do
	if (ibt_supported && sym_addr == target_addr - 4)
		return true;

>
> jirka
>
>> +
>> +	return false;
>> +}
>> +
>>   static void
>>   show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>>   {
>> @@ -307,7 +329,7 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>>   		goto error;
>>   
>>   	for (i = 0; i < dd.sym_count; i++) {
>> -		if (dd.sym_mapping[i].address != data[j].addr)
>> +		if (!symbol_matches_target(dd.sym_mapping[i].address, data[j].addr))
>>   			continue;
>>   		jsonw_start_object(json_wtr);
>>   		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
>> @@ -744,7 +766,7 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>>   
>>   	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
>>   	for (i = 0; i < dd.sym_count; i++) {
>> -		if (dd.sym_mapping[i].address != data[j].addr)
>> +		if (!symbol_matches_target(dd.sym_mapping[i].address, data[j].addr))
>>   			continue;
>>   		printf("\n\t%016lx %-16llx %s",
>>   		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
>> -- 
>> 2.25.1
>>
>>


