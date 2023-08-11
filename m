Return-Path: <bpf+bounces-7559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1777936B
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D0A1C21483
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B72AB40;
	Fri, 11 Aug 2023 15:43:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFBE63B6
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 15:43:52 +0000 (UTC)
Received: from out-97.mta0.migadu.com (out-97.mta0.migadu.com [IPv6:2001:41d0:1004:224b::61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5535F30D5
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 08:43:51 -0700 (PDT)
Message-ID: <3f7361e1-b80e-ab7f-492b-d5b138db40b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691768629; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlcIgO82eZPNY1T6jR66xLo5vGeNr7DmRLV0TPqju3s=;
	b=tznYyUGs+vR+rZq59U1S5oKWU88NcGpF4uLj7y2d7gBKv7oNJWx+EWdphb95glBc+mgspb
	nbc+Bkv6e4EVjiX6CmcLyNhsjhRDNPDzWleQM2xZS3K3C1MtywCjYIDorWvSrw9I0eP5SJ
	nFb8zpquXRGivCMRPS7UARRVOQ/mf7g=
Date: Fri, 11 Aug 2023 08:43:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Content-Language: en-US
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, tj@kernel.org, clm@meta.com, thinker.li@gmail.com
References: <20230810220456.521517-1-void@manifault.com>
 <371c72e1-f2b7-8309-0329-cdffc8a3f98d@linux.dev>
 <20230811150934.GA542801@maniforge>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230811150934.GA542801@maniforge>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 8:09 AM, David Vernet wrote:
> On Thu, Aug 10, 2023 at 11:43:26PM -0700, Yonghong Song wrote:
>>
>>
>> On 8/10/23 3:04 PM, David Vernet wrote:
>>> Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
>>> define the .validate() and .update() callbacks in its corresponding
>>> struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
>>> in its own right to ensure that the map is unloaded if an application
>>> crashes. For example, with sched_ext, we want to automatically unload
>>> the host-wide scheduler if the application crashes. We would likely
>>> never support updating elements of a sched_ext struct_ops map, so we'd
>>> have to implement these callbacks showing that they _can't_ support
>>> element updates just to benefit from the basic lifetime management of
>>> struct_ops links.
>>>
>>> Let's enable struct_ops maps to work with BPF_F_LINK even if they
>>> haven't defined these callbacks, by assuming that a struct_ops map
>>> element cannot be updated by default.
>>
>> Maybe you want to add one map_flag to indicate validate/update callbacks
>> are optional for a struct_ops link? In this case, some struct_ops maps
>> can still require validate() and update(), but others can skip them?
> 
> Are you proposing that a map flag be added that a user space caller can
> specify to say that they're OK with a struct_ops implementation not
> supporting .validate() and .update(), but still want to use a link to
> manage registration and unregistration?  Assuming I'm understanding your
> suggestion correctly, I don't think it's what we want. Updating a
> struct_ops map value is arguably orthogonal to the bpf link handling
> registration and unregistration, so it seems confusing to require a user
> to specify that it's the behavior they want as there's no reason they
> shouldn't want it. If they mistakenly thought that update element is
> supposed for that struct_ops variant, they'll just get an -EOPNOTSUPP
> error at runtime, which seems reasonable. If a struct_ops implementation
> should have implemented .validate() and/or .update() and neglects to,
> that would just be a bug in the struct_ops implementation.
> 
> Apologies if I've misunderstood your proposal, and please feel free to
> clarify if I have.

You understanding with my proposal is correct.
Okay, after further thought, I agree with your above point.
Lacking implementation of 'validate' and 'update' itself is
equivalent to a flag. So flag itself is not really needed.

> 
> Thanks,
> David
> 
>>
>>>
>>> Signed-off-by: David Vernet <void@manifault.com>
>>> ---
>>>    kernel/bpf/bpf_struct_ops.c | 17 +++++++++++------
>>>    1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>>> index eaff04eefb31..3d2fb85186a9 100644
>>> --- a/kernel/bpf/bpf_struct_ops.c
>>> +++ b/kernel/bpf/bpf_struct_ops.c
>>> @@ -509,9 +509,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>>    	}
>>>    	if (st_map->map.map_flags & BPF_F_LINK) {
>>> -		err = st_ops->validate(kdata);
>>> -		if (err)
>>> -			goto reset_unlock;
>>> +		err = 0;
>>> +		if (st_ops->validate) {
>>> +			err = st_ops->validate(kdata);
>>> +			if (err)
>>> +				goto reset_unlock;
>>> +		}
>>>    		set_memory_rox((long)st_map->image, 1);
>>>    		/* Let bpf_link handle registration & unregistration.
>>>    		 *
>>> @@ -663,9 +666,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>>    	if (attr->value_size != vt->size)
>>>    		return ERR_PTR(-EINVAL);
>>> -	if (attr->map_flags & BPF_F_LINK && (!st_ops->validate || !st_ops->update))
>>> -		return ERR_PTR(-EOPNOTSUPP);
>>> -
>>>    	t = st_ops->type;
>>>    	st_map_size = sizeof(*st_map) +
>>> @@ -838,6 +838,11 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>>>    		goto err_out;
>>>    	}
>>> +	if (!st_map->st_ops->update) {
>>> +		err = -EOPNOTSUPP;
>>> +		goto err_out;
>>> +	}
>>> +
>>>    	err = st_map->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
>>>    	if (err)
>>>    		goto err_out;
> 

