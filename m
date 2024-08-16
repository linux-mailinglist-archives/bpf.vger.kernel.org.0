Return-Path: <bpf+bounces-37343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D577953E0F
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 01:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807491C22034
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE1155CB2;
	Thu, 15 Aug 2024 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SddckgYM"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E01AC898
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765668; cv=none; b=OqldouZe/QNBUaze6zrnrzM9BnbQRp3M6ZhzGahbJRwPB0PouUL5dMTn2xgP3pPwGaaWpziIfUv7d4w6M6KuImhcgDkapqVUgfKAARrCW8tLaog8Q/+LMzsNIN/X6BjD6AJL/qk5IxLHNuMWeUKuTNHkUtcCUeWhg9rZzNqTn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765668; c=relaxed/simple;
	bh=ImG6kbmc/9TkzlHHzumhnbFsISZr2S6PMZO+P69oT88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz9j85Ij/i5QLCvKViFJ+m6l7mGlSILUdiTt92usVy81ta8AFtb+m5HOFYLAoeYCOqrS+4Zy2cR7w9F7CgmETyiFmrxnUSYgelN1SG88KHIHkTGlPfidNIVDJ9khWoagG1Ov7eH8sVEWFgRRlNHnbeNpMootGhWIhYkbBBjAvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SddckgYM; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2773a090-8b8b-4c9a-be02-e35b06e9fec5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723765663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9py6HBaG0Ugoz8B0iqqHFS6R1yxxE9aF5v9Cq69Puk=;
	b=SddckgYMAcgbjclbIChbDKqYZnekb4FtUcKFmoc5G9qMS1ZcjE2OIzPmf0E2g+x6LfZ9oF
	/grwjhMIXMVEpo3tC36DRl9WclPLFCMpwcfoqqxvTDU3KSBagRdzOaRSUx5zjQA79+N3On
	76eOGTSY/ght7IxGFEAwVk8hdBqfZ3E=
Date: Thu, 15 Aug 2024 16:47:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 5/6] bpf: Allow pro/epilogue to call kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 kernel-team@meta.com
References: <20240813184943.3759630-1-martin.lau@linux.dev>
 <20240813184943.3759630-6-martin.lau@linux.dev>
 <3066ed3d157d391e67858e44da8b0d7865df2ad9.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <3066ed3d157d391e67858e44da8b0d7865df2ad9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/14/24 3:17 PM, Eduard Zingerman wrote:
> On Tue, 2024-08-13 at 11:49 -0700, Martin KaFai Lau wrote:
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> The existing prologue has been able to call bpf helper but not a kfunc.
>> This patch allows the prologue/epilogue to call the kfunc.
> 
> [...]
> 
>> Once the insn->off is determined (either reuse an existing one
>> or an unused one is found), it will call the existing add_kfunc_call()
>> and everything else should fall through.
>>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> ---
> 
> fwiw, don't see any obvious problems with this patch.
> 
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> 
>>   kernel/bpf/verifier.c | 116 ++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 113 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 5e995b7884fb..2873e1083402 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2787,6 +2787,61 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
>>   	return btf_vmlinux ?: ERR_PTR(-ENOENT);
>>   }
>>   
>> +static int find_kfunc_desc_btf_offset(struct bpf_verifier_env *env, struct btf *btf,
>> +				      struct module *module, s16 *offset)
>> +{
>> +	struct bpf_kfunc_btf_tab *tab;
>> +	struct bpf_kfunc_btf *b;
>> +	s16 new_offset = S16_MAX;
>> +	u32 i;
>> +
>> +	if (btf_is_vmlinux(btf)) {
>> +		*offset = 0;
>> +		return 0;
>> +	}
>> +
>> +	tab = env->prog->aux->kfunc_btf_tab;
>> +	if (!tab) {
>> +		tab = kzalloc(sizeof(*tab), GFP_KERNEL);
>> +		if (!tab)
>> +			return -ENOMEM;
>> +		env->prog->aux->kfunc_btf_tab = tab;
>> +	}
>> +
>> +	b = tab->descs;
>> +	for (i = tab->nr_descs; i > 0; i--) {
> 
> Question: why iterating in reverse here?

Agreed. It is unnecessary. I will change it to iterate forward in the next re-spin.

Thanks for the review!


