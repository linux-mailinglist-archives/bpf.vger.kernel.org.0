Return-Path: <bpf+bounces-27592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E98AF8A2
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 22:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A174A285029
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 20:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A014533F;
	Tue, 23 Apr 2024 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TMfI4sXz"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6F143873
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905611; cv=none; b=L6qgRG+1gXIcRBDlO7AWYd8tvyya1vYgO0Gx1pOcjZR7THc0l/j6iMATOuhkMa1Vk9kdH+Z+KVWhSPEAcYQtCEJv7Mb4QZ2FR4GsCA6LXhjOKbYnIPmqPVf69X7DccGNA+oan+8X88rubqRfbPZ+Sb8tFUeo4lsyUJD2BPi2NiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905611; c=relaxed/simple;
	bh=T3Q92gFUy/P1UcmszYWlLKTrq3XEsOaOm9jx95J/PzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/i1/+Osguk1V5Uzpxn6K81dp9MTDB1tyneS6ufo5uB/VG5laWoP49vRTLdZkbj5ukZxaiycK0kgNqDZdcDdVniSaXHr4TrMWEBc7rFjAZJ++yz4lAQkhPi/uk3MJSOuJK8YHmbaqM0rqofW2S8kEbDBjmgKx1s3xMlEJA08ksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TMfI4sXz; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ec6f3bf-c811-416d-aa28-bc97a994f03e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713905608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5IPHXvmn5IlORh0Jz+RdXye8CqoldRLwCZWA0z/eSLA=;
	b=TMfI4sXzP6NLNHH6rOkbGxMOcE9Pz/lZrMl+rnDF9z+fXHzp6VGpKe/5nQB04AllxKa+I5
	tOfRyehX/D3zUI2g8d+Aw1EfWsyP+nnMTy/TVf9upt0uMbZyh45xVpGMBr/za0STgCtwiT
	j4y6ZG2V/0scNrEmSVgYlKwi2DfiJdc=
Date: Tue, 23 Apr 2024 13:53:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/5] bpf/verifier: relax MUL range computation
 check
Content-Language: en-GB
To: Cupertino Miranda <cupertino.miranda@oracle.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 David Faust <david.faust@oracle.com>,
 Elena Zannoni <elena.zannoni@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
 <20240417122341.331524-5-cupertino.miranda@oracle.com>
 <78488c062d4154f78706d371bf3ed600a0601ab6.camel@gmail.com>
 <8734rhk7jq.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <8734rhk7jq.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/19/24 2:47 AM, Cupertino Miranda wrote:
> Eduard Zingerman writes:
>
>> On Wed, 2024-04-17 at 13:23 +0100, Cupertino Miranda wrote:
>>
>> [...]
>>
>>>   static int is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
>>> +					    struct bpf_reg_state dst_reg,
>>>   					    struct bpf_reg_state src_reg)
>> Nit: there is no need to pass {dst,src}_reg by value,
>>       struct bpf_reg_state is 120 bytes in size
>>      (but maybe compiler handles this).
>>
>>>   {
>>> -	bool src_known;
>>> +	bool src_known, dst_known;
>>>   	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
>>>   	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
>>>   	u8 opcode = BPF_OP(insn->code);
>>>
>>> -	bool valid_known = true;
>>> -	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
>>> +	bool valid_known_src = true;
>>> +	bool valid_known_dst = true;
>>> +	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known_src);
>>> +	dst_known = is_const_reg_and_valid(dst_reg, alu32, &valid_known_dst);
>>>
>>>   	/* Taint dst register if offset had invalid bounds
>>>   	 * derived from e.g. dead branches.
>>>   	 */
>>> -	if (valid_known == false)
>>> +	if (valid_known_src == false)
>>>   		return UNCOMPUTABLE_RANGE;
>>>
>>>   	switch (opcode) {
>>> @@ -13457,10 +13460,12 @@ static int is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
>>>   	case BPF_OR:
>>>   		return COMPUTABLE_RANGE;
>>>
>>> -	/* Compute range for the following only if the src_reg is known.
>>> +	/* Compute range for MUL if at least one of its registers is known.
>>>   	 */
>>>   	case BPF_MUL:
>>> -		return src_known ? COMPUTABLE_RANGE : UNCOMPUTABLE_RANGE;
>>> +		if (src_known || (dst_known && valid_known_dst))
>>> +			return COMPUTABLE_RANGE;
>>> +		break;
>> Is it even necessary to restrict src or dst to be known?
>> adjust_scalar_min_max_vals() logic for multiplication looks as follows:
>>
>> 	case BPF_MUL:
>> 		dst_reg->var_off = tnum_mul(dst_reg->var_off, src_reg.var_off);
>> 		scalar32_min_max_mul(dst_reg, &src_reg);
>> 		scalar_min_max_mul(dst_reg, &src_reg);
>> 		break;
>>
>> Where tnum_mul() refers to a paper, and that paper does not restrict
>> abstract multiplication algorithm to constant values on either side.
>> The scalar_min_max_mul() and scalar32_min_max_mul() are similar:
>> - if both src and dst are positive
>> - if overflow is not possible
>> - adjust dst->min *= src->min
>> - adjust dst->max *= src->max
>>
>> I think this should work just fine if neither of src or dst is a known constant.
>> What do you think?
>>
> With the refactor this looked like an armless change. Indeed if we agree
> that the algorithm covers all scenarios, then why not.
> I did not study the paper or the scalar_min_max_mul function nearly
> enough to know for sure.

I double checked and I think Eduard is correct. src_known checking
is not necessary for multiplication. It would be great if you can
add this change as well in the patch set.

>> [...]

