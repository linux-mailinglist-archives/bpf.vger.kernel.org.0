Return-Path: <bpf+bounces-17234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD4C80AD86
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 21:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1491C20B88
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0957313;
	Fri,  8 Dec 2023 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KQ1AvS+X"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F293
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 12:07:36 -0800 (PST)
Message-ID: <335fbd65-585d-47b8-a98f-c0898aff7d7f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702066054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXM1ZnwF1XXvKCHcxMF5Y0NzmI1apaw0Oq28bYS/K2g=;
	b=KQ1AvS+XfpLaB+o/P5r9pGOcgruxWFQyQtuENXIRimQL1BdgOPU5OuGt19Z7Aq2UYYJvVo
	R99l1RGozk57CKBMkBCH1qu1VxNAwNuYdPB/albMEfRtc8e/dXNQvanw+E3UOqtqHB4ob9
	IKSG1/3k5U8pl1/ABhJGEDM4ftHVqtc=
Date: Fri, 8 Dec 2023 12:07:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v9 14/15] p4tc: add set of P4TC table kfuncs
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com,
 daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <20231201182904.532825-1-jhs@mojatatu.com>
 <20231201182904.532825-15-jhs@mojatatu.com>
 <8faf1308-2f9f-4923-804e-8d9b11ba74e0@linux.dev> <87lea5j8ys.fsf@toke.dk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87lea5j8ys.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 2:15 AM, Toke Høiland-Jørgensen wrote:
> Martin KaFai Lau <martin.lau@linux.dev> writes:
> 
>> On 12/1/23 10:29 AM, Jamal Hadi Salim wrote:
>>> We add an initial set of kfuncs to allow interactions from eBPF programs
>>> to the P4TC domain.
>>>
>>> - bpf_p4tc_tbl_read: Used to lookup a table entry from a BPF
>>> program installed in TC. To find the table entry we take in an skb, the
>>> pipeline ID, the table ID, a key and a key size.
>>> We use the skb to get the network namespace structure where all the
>>> pipelines are stored. After that we use the pipeline ID and the table
>>> ID, to find the table. We then use the key to search for the entry.
>>> We return an entry on success and NULL on failure.
>>>
>>> - xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
>>> program installed in XDP. To find the table entry we take in an xdp_md,
>>> the pipeline ID, the table ID, a key and a key size.
>>> We use struct xdp_md to get the network namespace structure where all
>>> the pipelines are stored. After that we use the pipeline ID and the table
>>> ID, to find the table. We then use the key to search for the entry.
>>> We return an entry on success and NULL on failure.
>>>
>>> - bpf_p4tc_entry_create: Used to create a table entry from a BPF
>>> program installed in TC. To create the table entry we take an skb, the
>>> pipeline ID, the table ID, a key and its size, and an action which will
>>> be associated with the new entry.
>>> We return 0 on success and a negative errno on failure
>>>
>>> - xdp_p4tc_entry_create: Used to create a table entry from a BPF
>>> program installed in XDP. To create the table entry we take an xdp_md, the
>>> pipeline ID, the table ID, a key and its size, and an action which will
>>> be associated with the new entry.
>>> We return 0 on success and a negative errno on failure
>>>
>>> - bpf_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
>>> First does a lookup using the passed key and upon a miss will add the entry
>>> to the table.
>>> We return 0 on success and a negative errno on failure
>>>
>>> - xdp_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
>>> First does a lookup using the passed key and upon a miss will add the entry
>>> to the table.
>>> We return 0 on success and a negative errno on failure
>>>
>>> - bpf_p4tc_entry_update: Used to update a table entry from a BPF
>>> program installed in TC. To update the table entry we take an skb, the
>>> pipeline ID, the table ID, a key and its size, and an action which will
>>> be associated with the new entry.
>>> We return 0 on success and a negative errno on failure
>>>
>>> - xdp_p4tc_entry_update: Used to update a table entry from a BPF
>>> program installed in XDP. To update the table entry we take an xdp_md, the
>>> pipeline ID, the table ID, a key and its size, and an action which will
>>> be associated with the new entry.
>>> We return 0 on success and a negative errno on failure
>>>
>>> - bpf_p4tc_entry_delete: Used to delete a table entry from a BPF
>>> program installed in TC. To delete the table entry we take an skb, the
>>> pipeline ID, the table ID, a key and a key size.
>>> We return 0 on success and a negative errno on failure
>>>
>>> - xdp_p4tc_entry_delete: Used to delete a table entry from a BPF
>>> program installed in XDP. To delete the table entry we take an xdp_md, the
>>> pipeline ID, the table ID, a key and a key size.
>>> We return 0 on success and a negative errno on failure
>>
>> [ ... ]
>>
>>> +BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
>>> +BTF_ID_FLAGS(func, bpf_p4tc_tbl_read, KF_RET_NULL);
>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create);
>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create_on_miss);
>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_update);
>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_delete);
>>> +BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)
>>
>> These create/read/update/delete kfuncs are like defining a new hidden bpf map
>> type in the kernel. bpf prog can now create its own link-list and rbtree.
>> sched_ext has already been using it. This is the way the bpf prog should use
>> instead of creating a new map type.
> 
> I don't really think this is an accurate assessment, given Jamal's use
> case. These kfuncs are more akin to the FIB lookup helper, or the
> netfilter kfuncs: they provide lookup into a kernel-internal data
> structure, so that BPF can access that data structure while staying in
> sync with the rest of the kernel.
> 
> If this was a BPF-only implementation you'd be right, but given the
> constraint of having the P4 objects represented in the kernel[0], I
> think this is a perfectly reasonable use of kfuncs, even though they
> happen to look like the map API.
> 
> -Toke
> 
> [0] Whether having those objects represented at all is reasonable is a
> separate discussion, which I believe John et al are having with Jamal in
> a separate subthread. I don't personally have any strong objections to
> doing that.

I might not be clear. It was my question on why it has to be in the kernel 
instead of in the bpf map, so the earlier bpf link-list and rbtree example just 
in case this recent bpf capability has not been considered.

If it is an existing kernel infra-structure, kfunc is a reasonable use.

The P4 objects are newly added to this set with bpf program as its user. It can 
be represented in the bpf map as well instead of in the kernel.

or is it fair to say that bpf prog is not the primary consumer of the P4 
objects. Instead kernel is the primary user of the p4 objects such that p4tc can 
work independently without the bpf piece to begin with and bpf could be 
considered as an extension later?

