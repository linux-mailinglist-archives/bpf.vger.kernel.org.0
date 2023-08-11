Return-Path: <bpf+bounces-7615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F0F779ACF
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 00:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EA5281445
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 22:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A4634CD2;
	Fri, 11 Aug 2023 22:49:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099A2F4E
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 22:49:45 +0000 (UTC)
Received: from out-118.mta1.migadu.com (out-118.mta1.migadu.com [IPv6:2001:41d0:203:375::76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EDA2130
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 15:49:43 -0700 (PDT)
Message-ID: <d1fa5eff-b0d2-4388-0513-eaead8542b9f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691794181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtSYDgWKfmC8HeY8zGq3T1AYfKfRMdNPL5N6msTOnRA=;
	b=YuI5gqBRbzI4RZGmeTLxwFtQmSeVL67wwtxXoLSxeHJys+DVvOfmFTdXfsXe5c9AvfEQVa
	5p6q1nRtpT4ieBp46k46Z4MPG7xWL1jMF6A3vwzFuvHKFqbzDatPjUzRXsxSZRKTp94GUp
	cTgN3LOQqa9trUgT0brR9TTa9KluV04=
Date: Fri, 11 Aug 2023 15:49:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Content-Language: en-US
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
 clm@meta.com, thinker.li@gmail.com, Stanislav Fomichev <sdf@google.com>
References: <20230810220456.521517-1-void@manifault.com>
 <ZNVousfpuRFgfuAo@google.com> <20230810230141.GA529552@maniforge>
 <ZNVvfYEsLyotn+G1@google.com>
 <fe388d79-bdfc-0480-5f4b-1a40016fd53d@linux.dev>
 <20230811201914.GD542801@maniforge>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230811201914.GD542801@maniforge>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/11/23 1:19 PM, David Vernet wrote:
> On Fri, Aug 11, 2023 at 10:35:03AM -0700, Martin KaFai Lau wrote:
>> On 8/10/23 4:15 PM, Stanislav Fomichev wrote:
>>> On 08/10, David Vernet wrote:
>>>> On Thu, Aug 10, 2023 at 03:46:18PM -0700, Stanislav Fomichev wrote:
>>>>> On 08/10, David Vernet wrote:
>>>>>> Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
>>>>>> define the .validate() and .update() callbacks in its corresponding
>>>>>> struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
>>>>>> in its own right to ensure that the map is unloaded if an application
>>>>>> crashes. For example, with sched_ext, we want to automatically unload
>>>>>> the host-wide scheduler if the application crashes. We would likely
>>>>>> never support updating elements of a sched_ext struct_ops map, so we'd
>>>>>> have to implement these callbacks showing that they _can't_ support
>>>>>> element updates just to benefit from the basic lifetime management of
>>>>>> struct_ops links.
>>>>>>
>>>>>> Let's enable struct_ops maps to work with BPF_F_LINK even if they
>>>>>> haven't defined these callbacks, by assuming that a struct_ops map
>>>>>> element cannot be updated by default.
>>>>>
>>>>> Any reason this is not part of sched_ext series? As you mention,
>>>>> we don't seem to have such users in the three?
>>>>
>>>> Hi Stanislav,
>>>>
>>>> The sched_ext series [0] implements these callbacks. See
>>>> bpf_scx_update() and bpf_scx_validate().
>>>>
>>>> [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
>>>>
>>>> We could add this into that series and remove those callbacks, but this
>>>> patch is fixing a UX / API issue with struct_ops links that's not really
>>>> relevant to sched_ext. I don't think there's any reason to couple
>>>> updating struct_ops map elements with allowing the kernel to manage the
>>>> lifetime of struct_ops maps -- just because we only have 1 (non-test)
>>
>> Agree the link-update does not necessarily couple with link-creation, so
>> removing 'link' update function enforcement is ok. The intention was to
>> avoid the struct_ops link inconsistent experience (one struct_ops link
>> support update and another struct_ops link does not) because consistency was
>> one of the reason for the true kernel backed link support that Kui-Feng did.
>> tcp-cc is the only one for now in struct_ops and it can support update, so
>> the enforcement is here. I can see Stan's point that removing it now looks
>> immature before a struct_ops landed in the kernel showing it does not make
>> sense or very hard to support 'link' update. However, the scx patch set has
>> shown this point, so I think it is good enough.
> 
> Sorry for sending v2 of the patch a bit prematurely. Should have let you
> weigh in first.
> 
>> For 'validate', it is not related a 'link' update. It is for the struct_ops
>> 'map' update. If the loaded struct_ops map is invalid, it will end up having
>> a useless struct_ops map and no link can be created from it. I can see some
> 
> To be honest I'm actually not sure I understand why .validate() is only
> called for when BPF_F_LINK is specified. Is it because it could break

Regardless '.validate' must be enforced or not, the ->validate() should be 
called for the non BPF_F_LINK case also during map update. This should be fixed.

> existing programs if they defined a struct_ops map that wasn't valid
> _without_ using BPF_F_LINK? Whether or not a map is valid should inform
> whether we can load it regardless of whether there's a link, no? It
> seems like .init_member() was already doing this as well. That's why I
> got confused and conflated the two.

I think the best is to look at bpf_struct_ops_map_update_elem() and the 
differences between BPF_F_LINK and the older non BPF_F_LINK behavior.

Before the BPF_F_LINK was introduced, the map update and ->reg() happened 
together, so the kernel can reject at the map update time through ->reg() 
because '->reg()' does the validation also. If the earlier map update failed, 
the user space can do a map update again.

With the BPF_F_LINK, the map update and ->reg are two separated actions. The 
->reg is done later in the link creation time (after the map is updated). If the 
BPF_F_LINK struct_ops is not validated as a whole (like ops1 and ops2 must be 
defined) during map update, it will only be discovered during the link creation 
time in bpf_struct_ops_link_create() by ->reg(). It will be too late for the 
userspace to correct that mistake because the map cannot be updated again. Then 
it will end up having a struct_ops map loaded in the kernel that cannot do 
anything. I don't think it is the common case but at least the map should not be 
left in some unusable state when it did happen.

It is why the validation part has been separated from the '.reg', so '.validate' 
was added and enforced.  and ->validate() is called during the map update.

'.init_member' is for validating individual ops/member but not for validating 
struct_ops as a whole, like if ops_x is implemented, then ops_y must be 
implemented also.

>> struct_ops subsystem check all the 'ops' function for NULL before calling
>> (like the FUSE RFC). I can also see some future struct_ops will prefer not
>> to check NULL at all and prefer to assume a subset of the ops is always
>> valid. Does having a 'validate' enforcement is blocking the scx patchset in
>> some way? If not, I would like to keep this for now. Once it is removed,
> 
> No, it's not blocking scx at all. scx, as with any other struct_ops
> implementation, could and does just implement these callbacks. As
> Kui-Feng said in [0], this is really just about enabling a sane default
> to improve usability. If a struct_ops implementation actually should
> have implemented some validation but neglected to, that would be a bug
> in exactly the same manner as if it had implemented .validate(), but
> neglected to check some corner case that makes the map invalid.
> 
> [0]: https://lore.kernel.org/lkml/887699ea-f837-6ed7-50bd-48720cea581c@gmail.com/
> 
>> there is no turning back.
> 
> Hmm, why there would be no turning back from this? This isn't a UAPI
> concern, is it? Whether or not a struct_ops implementation needs to

hmm...at least, map update success in one kernel and then map update failure in 
a later kernel is a different behavior. yeah, the succeeded map is unusable 
anyway but still no need to create this inconsistency to begin with if it does 
not have to.

> implement .validate() or can just rely on the default behavior of "no
> .validate() callback implies the map is valid" is 100% an implementation
> detail that's hidden from the end user. This is meant to be a UX
> improvement for a developr defining a struct bpf_struct_ops instance in
> the main kernel, not someone defining an instance of that struct_ops
> (e.g. struct tcp_congestion_ops) in a BPF prog.

The UX here is about the subsystem doing the very first time struct_ops 
implementation in the kernel, so yes it is the internal details of the kernel 
and one time cost.

Multiple struct_ops bpf prog can then be developed and the bpf developer is not 
affected no matter .validate is enforced or not.

I think I weighted the end-user space experience more. Having map in unusable 
state is a bad userspace experience. Yes, the way it is enforcing it now looks 
bureaucratic. I think it took two emails to explain the internal details of the 
struct_ops update and the difference between doing validation in .validate vs in 
.reg. I am not sure if the subsystem implementer wants to know all this details 
or just go ahead to implement validation in '.validate' and put an empty one for 
the subsystem does not need to check anything.

I think enough words have exchanged on this subject. I am not going to insist. 
If it is still preferred to have this check removed, please add details 
description to the '.validate' of struct bpf_struct_ops in bpf.h and also the 
commit message to spell out the details for the future subsystem struct_ops 
kernel developer to follow:

If it needs to validate struct_ops as a while,

1. it must be implemented in .validate instead of .reg. Otherwise, it may end up 
having an unusable map.

2. if the validation is implemented in '.reg' only, the map update behavior will 
be different between BPF_F_LINK map and the non BPF_F_LINK map.


