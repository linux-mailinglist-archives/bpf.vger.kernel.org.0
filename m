Return-Path: <bpf+bounces-7195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF8B772FE1
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 21:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97021C20C97
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9E1171DD;
	Mon,  7 Aug 2023 19:50:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F12171BA
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 19:50:29 +0000 (UTC)
Received: from out-94.mta0.migadu.com (out-94.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FA319A2
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 12:49:58 -0700 (PDT)
Message-ID: <5a910ec7-ae16-6e8e-8236-db6f9e2fe1a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691437756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbQs0m03u8lzlDhSRuElu7hrx4Kn6CP6otbUmNNX1I0=;
	b=O0NC4EPWQeMn9n1Exr5w8zlNn0ch+w76NyIdOsmV+Krs+H9lZKI1h4P+Vul5B+AmGpAoAu
	+AVfn4RE85EYUajeKAkKoe1eV75dAU6jpOl6ft69Ls/0kAgFsEnPcpa13eDHeWJPuqEsP+
	5r/yTcQEB0xcSpShtPm64h1CwJCB+YE=
Date: Mon, 7 Aug 2023 12:49:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: fix bpf_dynptr_slice() to stop return an
 ERR_PTR.
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, Dan Carpenter <dan.carpenter@linaro.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230803231206.1060485-1-thinker.li@gmail.com>
 <e0e8bf3b-70af-3827-2fa3-30f3d48bcf46@linux.dev>
 <5f4bbed7-e0d1-e848-d820-e74b551075b4@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <5f4bbed7-e0d1-e848-d820-e74b551075b4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/7/23 10:07 AM, Kui-Feng Lee wrote:
> 
> 
> On 8/4/23 15:26, Martin KaFai Lau wrote:
>> On 8/3/23 4:12 PM, thinker.li@gmail.com wrote:
>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>
>>> Verify if the pointer obtained from bpf_xdp_pointer() is either an error or
>>> NULL before returning it.
>>>
>>> The function bpf_dynptr_slice() mistakenly returned an ERR_PTR. Instead of
>>> solely checking for NULL, it should also verify if the pointer returned by
>>> bpf_xdp_pointer() is an error or NULL.
>>>
>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> Closes: 
>>> https://lore.kernel.org/bpf/d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain/
>>> Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
>>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>> ---
>>>   kernel/bpf/helpers.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 56ce5008aedd..eb91cae0612a 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -2270,7 +2270,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct 
>>> bpf_dynptr_kern *ptr, u32 offset
>>>       case BPF_DYNPTR_TYPE_XDP:
>>>       {
>>>           void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
>>> -        if (xdp_ptr)
>>> +        if (!IS_ERR_OR_NULL(xdp_ptr))
>>
>> Considering the earlier bpf_dynptr_check_off_len() should have avoided the 
>> IS_ERR() case here, I think targeting bpf-next makes sense. Applied.
> 
> It is a good point. I think the bpf_dynptr_check_off_len() check is
> wrong as well. According to the behavior of the rest of the function,
> it should be
> 
>      err = bpf_dynptr_check_off_len(ptr, ptr->offset + offset, len);

Not sure why it is needed either.
The bpf_dynptr_adjust() has updated the size after updating the offset.
Did I missing other offset update places?


