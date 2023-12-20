Return-Path: <bpf+bounces-18406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659A781A69A
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C21E1C256EC
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274C47A6B;
	Wed, 20 Dec 2023 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="st3lcHor"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22F47A45
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <28866cd7-8042-4a76-ac8d-698230eff08d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703095041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbkRcrpFBakMe9EeVftuLmV2DTHylW68LAgVg32cMTo=;
	b=st3lcHorlPxxJBH9oPcAtMutopRylNPyDKQyQZ7DMUSAn3Qq/911FCM8HL/ltFy5uuZ6v+
	naoc88B+l7R1mBMoCXnPZQ30w1TzePhSxhi7+ORdgAjbzQMSnwG0d22JRfqEeSGfTHqRa/
	h0K/rAbpubvr1VZmpcOXa0DG3NvRO0o=
Date: Wed, 20 Dec 2023 09:57:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231218063031.3037929-1-yonghong.song@linux.dev>
 <20231218063047.3040611-1-yonghong.song@linux.dev>
 <vwypdrjhtrvqcgocemp5ptkqqbbmtrw5q4mlkc5i2k7ipbhvm5@bixqyhggoihm>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <vwypdrjhtrvqcgocemp5ptkqqbbmtrw5q4mlkc5i2k7ipbhvm5@bixqyhggoihm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/19/23 8:37 PM, Alexei Starovoitov wrote:
> On Sun, Dec 17, 2023 at 10:30:47PM -0800, Yonghong Song wrote:
>> @@ -2963,7 +2963,9 @@ static int __init bpf_global_ma_init(void)
>>   
>>   	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
>>   	bpf_global_ma_set = !ret;
>> -	return ret;
>> +	ret = bpf_mem_alloc_percpu_init(&bpf_global_percpu_ma);
>> +	bpf_global_percpu_ma_set = !ret;
>> +	return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
> ...
>> -				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>> -					if (!bpf_global_percpu_ma_set) {
>> -						mutex_lock(&bpf_percpu_ma_lock);
>> -						if (!bpf_global_percpu_ma_set) {
>> -							err = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
>> -							if (!err)
>> -								bpf_global_percpu_ma_set = true;
>> -						}
>> -						mutex_unlock(&bpf_percpu_ma_lock);
>> -						if (err)
>> -							return err;
>> -					}
>> -				}
>> -
>>   				if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
>>   					verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
>>   					return -EINVAL;
>> @@ -12096,6 +12079,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   					return -EINVAL;
>>   				}
>>   
>> +				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>> +					if (!bpf_global_percpu_ma_set)
>> +						return -ENOMEM;
> The patch set looks great except I don't understand this part of the patch
> that goes back to allocating bpf_global_percpu_ma by default.
> Why allocate even small amount if no bpf prog will use it?
> It seems delaying allocation until the verifier sees the need is better.
> The rest of the series makes sense.

Thanks for suggestion. Will move early bpf_global_percpu_ma initialization
from __init stage to verifier then. This way, we have zero memory consumption
if bpf_global_percpu_ma is not used.


