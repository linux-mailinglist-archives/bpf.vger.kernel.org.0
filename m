Return-Path: <bpf+bounces-19279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94308828CE2
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 19:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A1C1F26883
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4A3C49E;
	Tue,  9 Jan 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tLajNdnr"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335133BB3B
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4bc16abf-6f3e-41bc-8787-826c1f50d35b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704825958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0Z8ms4crxQP/Dexv07qg9PJVlQfb3eYPFml9WC8JtU=;
	b=tLajNdnrV8LkOuZnwfdH2UpoffdILG9xq5akv8uedWUIFQxJSIiAs5tJ7KOiVy7uPv13li
	bpbd4/ukVdimHg4L37q8BmiSdRwegk4FvVI4McJFK95e7rlJk04au+Q5qbAdC/yogypO1x
	Et5DWJgTxmNdyelo8qqHwA31dnYG/LY=
Date: Tue, 9 Jan 2024 10:45:50 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Track aligned st store as imprecise
 spilled registers
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
References: <20240109040524.2313448-1-yonghong.song@linux.dev>
 <de8dd3773d84b4c07fbba2776d52bf2114ca5414.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <de8dd3773d84b4c07fbba2776d52bf2114ca5414.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/9/24 10:02 AM, Eduard Zingerman wrote:
> On Mon, 2024-01-08 at 20:05 -0800, Yonghong Song wrote:
> [...]
>> @@ -4640,7 +4641,18 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>>   			return -EINVAL;
>>   		}
>>   
>> -		/* Erase all spilled pointers. */
>> +		/* If writing_zero and the the spi slot contains a spill of value 0,
>> +		 * maintain the spill type.
>> +		 */
>> +		if (writing_zero && is_spilled_scalar_reg(&state->stack[spi])) {
> As discussed on offlist today, this should probably look as follows:
>
> -               if (writing_zero && is_spilled_scalar_reg(&state->stack[spi])) {
> +               if (writing_zero && *stype == STACK_SPILL && is_spilled_scalar_reg(&state->stack[spi])) {
>
> In order to handle cases like "mmmmSSSS" for slot types.

Thanks Eduard for pointing this out. I did handle this in v2 but missed it in v3.
I will wait a little bit just in case there are some other comments before posting v4
to fix this issue.

>
>> +			spill_reg = &state->stack[spi].spilled_ptr;
>> +			if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value == 0) {
>> +				zero_used = true;
>> +				continue;
>> +			}
>> +		}
>> +
>> +		/* Erase all other spilled pointers. */
>>   		state->stack[spi].spilled_ptr.type = NOT_INIT;
>>   
>>   		/* Update the slot type. */
> [...]

