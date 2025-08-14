Return-Path: <bpf+bounces-65635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E27B26433
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 13:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA009E72AC
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 11:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18282F1FDF;
	Thu, 14 Aug 2025 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYXXtvz2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9675809;
	Thu, 14 Aug 2025 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170804; cv=none; b=mr6LsmgCY80joIrQwaahptYGD3/BraypNdVtM4Km3rnPWNm62j1sU4N5W47u3SoGnxVCRbJJOjiO3Ls5Pn0NCV540xqjq26j1eaME2II79bK7HfoCakMQOmUJNBbJs56SJdWicrJIC3rSJnDwjDvcnWgjfkXLigQdXbdHmsbZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170804; c=relaxed/simple;
	bh=30DXgkTYYD6RYCecMC8sYcMnUiHiVam0osnwdwk5nJA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=GEaQSMg2XcStKB1+qOEVzDP/xGA79EbWeYoTU0zKTwiDsniAHXBmZDpjPlIsxYJ/aRnZiW7vA371oe9uiX2GO6vPuieVPRV6tdmQkK7imxEpuJdSiKsEbYGtFSnyDTmURquQNe7XcTuFMOO+D3UoUdWDQ+/5mpcE6T48vwfaHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYXXtvz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85060C4CEED;
	Thu, 14 Aug 2025 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755170803;
	bh=30DXgkTYYD6RYCecMC8sYcMnUiHiVam0osnwdwk5nJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SYXXtvz2m1bwfOsPB1EL46Mn1yVdrXeh+7FI7l3nBC+wBNZTCtYoInI2P9nE/CudD
	 OQ5FyedlGQGBRf1DsBuJLlDDRo8JOmK+U9i4ImKGeER/30aDbfhu8DxlZACWrQus7U
	 hjAY706BayX2bx99MwHQKxjVfefiYjyAoBzovPWrxUGH6r/ik+o4+l/TvSTQT83LjV
	 iGc1n72OXw4NMwxqcOMh4qBvFaKR4O0rdOr5T0Aa9tDcMx7tlNi6B38Hsofin5ktxJ
	 +PVuUAo0u632+jQjPg/pvvl9zsR2HUOZXtwZU5qXcCs/3yWgbKOskVQZHA+6KTqwLY
	 8kjgdqzQNxJhw==
Content-Type: multipart/mixed; boundary="------------lF30PlGn2iU8UK0ul3hEviSE"
Message-ID: <e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org>
Date: Thu, 14 Aug 2025 13:26:37 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] mlx5_core memory management issue
To: Dragos Tatulea <dtatulea@nvidia.com>, Chris Arges <carges@cloudflare.com>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
 tariqt@nvidia.com, saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Rzeznik <arzeznik@cloudflare.com>, Yan Zhai <yan@cloudflare.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <aIEuZy6fUj_4wtQ6@861G6M3>
 <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
 <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
 <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
 <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
 <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
 <aJuxY9oTtxSn4qZP@861G6M3> <aJzfPFCTlc35b2Bp@861G6M3>
 <5hinwlan55y6fl6ocilg7iccatuu5ftiyruf7wwfi44w5b4gpa@ainmdlgjtm5g>
 <4zkm7dmkxhfhf3cm7eniim26z6nbp3zsm4qttapg3xbvkrqhro@cvjnbr624m5h>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <4zkm7dmkxhfhf3cm7eniim26z6nbp3zsm4qttapg3xbvkrqhro@cvjnbr624m5h>

This is a multi-part message in MIME format.
--------------lF30PlGn2iU8UK0ul3hEviSE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/08/2025 22.24, Dragos Tatulea wrote:
> On Wed, Aug 13, 2025 at 07:26:49PM +0000, Dragos Tatulea wrote:
>> On Wed, Aug 13, 2025 at 01:53:48PM -0500, Chris Arges wrote:
>>> On 2025-08-12 16:25:58, Chris Arges wrote:
>>>> On 2025-08-12 20:19:30, Dragos Tatulea wrote:
>>>>> On Tue, Aug 12, 2025 at 11:55:39AM -0700, Jesse Brandeburg wrote:
>>>>>> On 8/12/25 8:44 AM, 'Dragos Tatulea' via kernel-team wrote:
>>>>>>
>>>>>>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>>>>>>> index 482d284a1553..484216c7454d 100644
>>>>>>> --- a/kernel/bpf/devmap.c
>>>>>>> +++ b/kernel/bpf/devmap.c
>>>>>>> @@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
>>>>>>>           /* If not all frames have been transmitted, it is our
>>>>>>>            * responsibility to free them
>>>>>>>            */
>>>>>>> +       xdp_set_return_frame_no_direct();
>>>>>>>           for (i = sent; unlikely(i < to_send); i++)
>>>>>>>                   xdp_return_frame_rx_napi(bq->q[i]);
>>>>>>> +       xdp_clear_return_frame_no_direct();
>>>>>>
>>>>>> Why can't this instead just be xdp_return_frame(bq->q[i]); with no
>>>>>> "no_direct" fussing?
>>>>>>
>>>>>> Wouldn't this be the safest way for this function to call frame completion?
>>>>>> It seems like presuming the calling context is napi is wrong?
>>>>>>
>>>>> It would be better indeed. Thanks for removing my horse glasses!
>>>>>
>>>>> Once Chris verifies that this works for him I can prepare a fix patch.
>>>>>
>>>> Working on that now, I'm testing a kernel with the following change:
>>>>
>>>> ---
>>>>
>>>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>>>> index 3aa002a47..ef86d9e06 100644
>>>> --- a/kernel/bpf/devmap.c
>>>> +++ b/kernel/bpf/devmap.c
>>>> @@ -409,7 +409,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
>>>>           * responsibility to free them
>>>>           */
>>>>          for (i = sent; unlikely(i < to_send); i++)
>>>> -               xdp_return_frame_rx_napi(bq->q[i]);
>>>> +               xdp_return_frame(bq->q[i]);
>>>>   
>>>>   out:
>>>>          bq->count = 0;
>>>
>>> This patch resolves the issue I was seeing and I am no longer able to
>>> reproduce the issue. I tested for about 2 hours, when the reproducer usually
>>> takes about 1-2 minutes.
>>>
>> Thanks! Will send a patch tomorrow and also add you in the Tested-by tag.
>>

Looking at code ... there are more cases we need to deal with.
If simply replacing xdp_return_frame_rx_napi() with xdp_return_frame.

The normal way to fix this is to use the helpers:
  - xdp_set_return_frame_no_direct();
  - xdp_clear_return_frame_no_direct()

Because __xdp_return() code[1] via xdp_return_frame_no_direct() will
disable those napi_direct requests.

  [1] https://elixir.bootlin.com/linux/v6.16/source/net/core/xdp.c#L439

Something doesn't add-up, because the remote CPUMAP bpf-prog that 
redirects to veth is running in cpu_map_bpf_prog_run_xdp()[2] and that 
function already uses the xdp_set_return_frame_no_direct() helper.

  [2] https://elixir.bootlin.com/linux/v6.16/source/kernel/bpf/cpumap.c#L189

I see the bug now... attached a patch with the fix.
The scope for the "no_direct" forgot to wrap the xdp_do_flush() call.

Looks like bug was introduced in 11941f8a8536 ("bpf: cpumap: Implement 
generic cpumap") v5.15.

>> As follow up work it would be good to have a way to catch this family of
>> issues. Something in the lines of the patch below.
>>

Yes, please, we want something that can catch these kind of hard to find 
bugs.

>> Thanks,
>> Dragos
>>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index f1373756cd0f..0c498fbd8df6 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -794,6 +794,10 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
>>   {
>>          lockdep_assert_no_hardirq();
>>   
>> +#ifdef CONFIG_PAGE_POOL_CACHEDEBUG
>> +       WARN(page_pool_napi_local(pool), "Page pool cache access from non-direct napi context");
> I meant to negate the condition here.
> 

The XDP code have evolved since the xdp_set_return_frame_no_direct()
calls were added.  Now page_pool keeps track of pp->napi and
pool-> cpuid.  Maybe the __xdp_return [1] checks should be updated?
(and maybe it allows us to remove the no_direct helpers).

--Jesper

--------------lF30PlGn2iU8UK0ul3hEviSE
Content-Type: text/x-patch; charset=UTF-8;
 name="01-cpumap-disable-pp-direct.patch"
Content-Disposition: attachment; filename="01-cpumap-disable-pp-direct.patch"
Content-Transfer-Encoding: base64

Y3B1bWFwOiBkaXNhYmxlIHBhZ2VfcG9vbCBkaXJlY3QgeGRwX3JldHVybiBuZWVkIGxhcmdl
ciBzY29wZQoKRnJvbTogSmVzcGVyIERhbmdhYXJkIEJyb3VlciA8aGF3a0BrZXJuZWwub3Jn
PgoKV2hlbiBydW5uaW5nIGFuIFhEUCBicGZfcHJvZyBvbiB0aGUgcmVtb3RlIENQVSBpbiBj
cHVtYXAgY29kZQp0aGVuIHdlIG11c3QgZGlzYWJsZSB0aGUgZGlyZWN0IHJldHVybiBvcHRp
bWl6YXRpb24gdGhhdAp4ZHBfcmV0dXJuIGNhbiBwZXJmb3JtIGZvciBtZW1fdHlwZSBwYWdl
X3Bvb2wuICBUaGlzIG9wdGltaXphdGlvbgphc3N1bWVzIGNvZGUgaXMgc3RpbGwgZXhlY3V0
aW5nIHVuZGVyIFJYLU5BUEkgb2YgdGhlIG9yaWdpbmFsCnJlY2VpdmluZyBDUFUsIHdoaWNo
IGlzbid0IHRydWUgb24gdGhpcyByZW1vdGUgQ1BVLgoKVGhlIGNwdW1hcCBjb2RlIGFscmVh
ZHkgZGlzYWJsZWQgdGhpcyB2aWEgaGVscGVycwp4ZHBfc2V0X3JldHVybl9mcmFtZV9ub19k
aXJlY3QoKSBhbmQgeGRwX2NsZWFyX3JldHVybl9mcmFtZV9ub19kaXJlY3QoKSwKYnV0IHRo
ZSBzY29wZSBkaWRuJ3QgaW5jbHVkZSB4ZHBfZG9fZmx1c2goKS4KCldoZW4gZG9pbmcgWERQ
X1JFRElSRUNUIHRvd2FyZHMgZS5nIGRldm1hcCB0aGlzIGNhdXNlcyB0aGUKZnVuY3Rpb24g
YnFfeG1pdF9hbGwoKSB0byBydW4gd2l0aCBkaXJlY3QgcmV0dXJuIG9wdGltaXphdGlvbgpl
bmFibGVkLiBUaGlzIGNhbiBsZWFkIHRvIGhhcmQgdG8gZmluZCBidWdzLgoKRml4IGJ5IGV4
cGFuZGluZyBzY29wZSB0byBpbmNsdWRlIHhkcF9kb19mbHVzaCgpLgoKRml4ZXM6IDExOTQx
ZjhhODUzNiAoImJwZjogY3B1bWFwOiBJbXBsZW1lbnQgZ2VuZXJpYyBjcHVtYXAiKQpTaWdu
ZWQtb2ZmLWJ5OiBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxoYXdrQGtlcm5lbC5vcmc+Ci0t
LQoga2VybmVsL2JwZi9jcHVtYXAuYyB8ICAgIDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBm
L2NwdW1hcC5jIGIva2VybmVsL2JwZi9jcHVtYXAuYwppbmRleCBiMmI3YjhlYzJjMmEuLmM0
NjM2MGIyNzg3MSAxMDA2NDQKLS0tIGEva2VybmVsL2JwZi9jcHVtYXAuYworKysgYi9rZXJu
ZWwvYnBmL2NwdW1hcC5jCkBAIC0xODYsNyArMTg2LDYgQEAgc3RhdGljIGludCBjcHVfbWFw
X2JwZl9wcm9nX3J1bl94ZHAoc3RydWN0IGJwZl9jcHVfbWFwX2VudHJ5ICpyY3B1LAogCXN0
cnVjdCB4ZHBfYnVmZiB4ZHA7CiAJaW50IGksIG5mcmFtZXMgPSAwOwogCi0JeGRwX3NldF9y
ZXR1cm5fZnJhbWVfbm9fZGlyZWN0KCk7CiAJeGRwLnJ4cSA9ICZyeHE7CiAKIAlmb3IgKGkg
PSAwOyBpIDwgbjsgaSsrKSB7CkBAIC0yMzEsNyArMjMwLDYgQEAgc3RhdGljIGludCBjcHVf
bWFwX2JwZl9wcm9nX3J1bl94ZHAoc3RydWN0IGJwZl9jcHVfbWFwX2VudHJ5ICpyY3B1LAog
CQl9CiAJfQogCi0JeGRwX2NsZWFyX3JldHVybl9mcmFtZV9ub19kaXJlY3QoKTsKIAlzdGF0
cy0+cGFzcyArPSBuZnJhbWVzOwogCiAJcmV0dXJuIG5mcmFtZXM7CkBAIC0yNTUsNiArMjUz
LDcgQEAgc3RhdGljIHZvaWQgY3B1X21hcF9icGZfcHJvZ19ydW4oc3RydWN0IGJwZl9jcHVf
bWFwX2VudHJ5ICpyY3B1LCB2b2lkICoqZnJhbWVzLAogCiAJcmN1X3JlYWRfbG9jaygpOwog
CWJwZl9uZXRfY3R4ID0gYnBmX25ldF9jdHhfc2V0KCZfX2JwZl9uZXRfY3R4KTsKKwl4ZHBf
c2V0X3JldHVybl9mcmFtZV9ub19kaXJlY3QoKTsKIAogCXJldC0+eGRwX24gPSBjcHVfbWFw
X2JwZl9wcm9nX3J1bl94ZHAocmNwdSwgZnJhbWVzLCByZXQtPnhkcF9uLCBzdGF0cyk7CiAJ
aWYgKHVubGlrZWx5KHJldC0+c2tiX24pKQpAQCAtMjY0LDYgKzI2Myw3IEBAIHN0YXRpYyB2
b2lkIGNwdV9tYXBfYnBmX3Byb2dfcnVuKHN0cnVjdCBicGZfY3B1X21hcF9lbnRyeSAqcmNw
dSwgdm9pZCAqKmZyYW1lcywKIAlpZiAoc3RhdHMtPnJlZGlyZWN0KQogCQl4ZHBfZG9fZmx1
c2goKTsKIAorCXhkcF9jbGVhcl9yZXR1cm5fZnJhbWVfbm9fZGlyZWN0KCk7CiAJYnBmX25l
dF9jdHhfY2xlYXIoYnBmX25ldF9jdHgpOwogCXJjdV9yZWFkX3VubG9jaygpOwogCg==

--------------lF30PlGn2iU8UK0ul3hEviSE--

