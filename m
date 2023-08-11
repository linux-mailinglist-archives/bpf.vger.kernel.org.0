Return-Path: <bpf+bounces-7623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59565779B61
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 01:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CFB281E85
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD683D3AE;
	Fri, 11 Aug 2023 23:34:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98B329D4
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 23:34:19 +0000 (UTC)
Received: from out-88.mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B110F5
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:34:17 -0700 (PDT)
Message-ID: <d9a8c8e0-a06d-2dd0-20a9-1fbf228fcef9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691796855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOAmUrlmN46mc8kLRjXg/L06bahnJsC47ASbtgox2n0=;
	b=SNHoCg5d13wmYFB3Vv9vgXrj8JvkuLaWsHbv6s1y5JjHbtBbtZKKPWBjqBxloswco9LOjr
	7IndQQykzTcQQpn3uC1QjRHqlrTXkvucO5lPLo8m7b3mZ2jQMN1VzjNtU+WIrX7wbM+fQB
	09xhUlEP0LxhAOA/EtAWr2ZHGMgogiM=
Date: Fri, 11 Aug 2023 16:34:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
 clm@meta.com, thinker.li@gmail.com, Stanislav Fomichev <sdf@google.com>,
 David Vernet <void@manifault.com>
References: <20230810220456.521517-1-void@manifault.com>
 <ZNVousfpuRFgfuAo@google.com> <20230810230141.GA529552@maniforge>
 <ZNVvfYEsLyotn+G1@google.com>
 <fe388d79-bdfc-0480-5f4b-1a40016fd53d@linux.dev>
 <20230811201914.GD542801@maniforge>
 <d1fa5eff-b0d2-4388-0513-eaead8542b9f@linux.dev>
 <03f9f9be-620d-a44d-d6a3-8b9084344db5@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <03f9f9be-620d-a44d-d6a3-8b9084344db5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/11/23 4:12 PM, Kui-Feng Lee wrote:
> 
> 
> On 8/11/23 15:49, Martin KaFai Lau wrote:
>> On 8/11/23 1:19 PM, David Vernet wrote:
>>> On Fri, Aug 11, 2023 at 10:35:03AM -0700, Martin KaFai Lau wrote:
>>>> On 8/10/23 4:15 PM, Stanislav Fomichev wrote:
>>>>> On 08/10, David Vernet wrote:
>>>>>> On Thu, Aug 10, 2023 at 03:46:18PM -0700, Stanislav Fomichev wrote:
>>>>>>> On 08/10, David Vernet wrote:
>>>>>>>> Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
>>>>>>>> define the .validate() and .update() callbacks in its corresponding
>>>>>>>> struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
>>>>>>>> in its own right to ensure that the map is unloaded if an application
>>>>>>>> crashes. For example, with sched_ext, we want to automatically unload
>>>>>>>> the host-wide scheduler if the application crashes. We would likely
>>>>>>>> never support updating elements of a sched_ext struct_ops map, so we'd
>>>>>>>> have to implement these callbacks showing that they _can't_ support
>>>>>>>> element updates just to benefit from the basic lifetime management of
>>>>>>>> struct_ops links.
>>>>>>>>
>>>>>>>> Let's enable struct_ops maps to work with BPF_F_LINK even if they
>>>>>>>> haven't defined these callbacks, by assuming that a struct_ops map
>>>>>>>> element cannot be updated by default.
>>>>>>>
>>>>>>> Any reason this is not part of sched_ext series? As you mention,
>>>>>>> we don't seem to have such users in the three?
>>>>>>
>>>>>> Hi Stanislav,
>>>>>>
>>>>>> The sched_ext series [0] implements these callbacks. See
>>>>>> bpf_scx_update() and bpf_scx_validate().
>>>>>>
>>>>>> [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
>>>>>>
>>>>>> We could add this into that series and remove those callbacks, but this
>>>>>> patch is fixing a UX / API issue with struct_ops links that's not really
>>>>>> relevant to sched_ext. I don't think there's any reason to couple
>>>>>> updating struct_ops map elements with allowing the kernel to manage the
>>>>>> lifetime of struct_ops maps -- just because we only have 1 (non-test)
>>>>
>>>> Agree the link-update does not necessarily couple with link-creation, so
>>>> removing 'link' update function enforcement is ok. The intention was to
>>>> avoid the struct_ops link inconsistent experience (one struct_ops link
>>>> support update and another struct_ops link does not) because consistency was
>>>> one of the reason for the true kernel backed link support that Kui-Feng did.
>>>> tcp-cc is the only one for now in struct_ops and it can support update, so
>>>> the enforcement is here. I can see Stan's point that removing it now looks
>>>> immature before a struct_ops landed in the kernel showing it does not make
>>>> sense or very hard to support 'link' update. However, the scx patch set has
>>>> shown this point, so I think it is good enough.
>>>
>>> Sorry for sending v2 of the patch a bit prematurely. Should have let you
>>> weigh in first.
>>>
>>>> For 'validate', it is not related a 'link' update. It is for the struct_ops
>>>> 'map' update. If the loaded struct_ops map is invalid, it will end up having
>>>> a useless struct_ops map and no link can be created from it. I can see some
>>>
>>> To be honest I'm actually not sure I understand why .validate() is only
>>> called for when BPF_F_LINK is specified. Is it because it could break
>>
>> Regardless '.validate' must be enforced or not, the ->validate() should be 
>> called for the non BPF_F_LINK case also during map update. This should be fixed.
> 
> For the case of the TCP congestion control, its validation function is
> called by the implementations of ->validate() and ->reg(). I mean it
> expects ->reg() to do validation as well.

Right, for tcp-cc, the reg is doing the validation because it is how the kernel 
tcp-cc module is done.

For newer subsystem supporting struct_ops, it should expect the validation is 
done in the .validate alone.


