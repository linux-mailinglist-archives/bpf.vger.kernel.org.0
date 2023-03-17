Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB26BE0F3
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 07:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCQGFH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 02:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCQGFF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 02:05:05 -0400
Received: from out-25.mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFE51A978
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 23:05:02 -0700 (PDT)
Message-ID: <f015a098-1e17-b503-a098-b3d1adbe4ce8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679033099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UE69xZGQOzXTXFmTaT0iMSWwoKRN3khdJM8QXeqSFV8=;
        b=DhAU1Cup+o0IfS8uvpJZjis3a2iPSKERvFBeO3gcKpLuHfwxE+8UtKmPY8zKFYTkBiculk
        rMpA23qCJ6vG6Sw7c2C2vSQoqtt0Be38j8cyPfxl4gZKAYqpvlrwk066oMMKJWK1yV7fyX
        JXIAqAAVCgoFzVHtC9pnNmLzembXQuk=
Date:   Thu, 16 Mar 2023 23:04:54 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add LRU internals description and
 graph
Content-Language: en-US
To:     Joe Stringer <joe@isovalent.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, bagasdotme@gmail.com,
        maxtram95@gmail.com, bpf@vger.kernel.org
References: <20230312190600.324573-1-joe@isovalent.com>
 <c6172fe2-7d88-f9f8-e19a-47c232f9cb75@linux.dev>
 <CADa=RyxDHp5x0iCcfgiCDuM68we=dTAmVBvx1hgrRLBbN27rdw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADa=RyxDHp5x0iCcfgiCDuM68we=dTAmVBvx1hgrRLBbN27rdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/15/23 6:54 PM, Joe Stringer wrote:
> On Tue, Mar 14, 2023 at 12:31 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 3/12/23 12:05 PM, Joe Stringer wrote:
>>> Extend the bpf hashmap docs to include a brief description of the
>>> internals of the LRU map type (setting appropriate API expectations),
>>> including the original commit message from Martin and a variant on the
>>> graph that I had presented during my Linux Plumbers Conference 2022 talk
>>> on "Pressure feedback for LRU map types"[0].
>>>
>>> The node names in the dot file correspond roughly to the functions where
>>> the logic for those decisions or steps is defined, to help curious
>>> developers to cross-reference and update this logic if the details of
>>> the LRU implementation ever differ from this description.
>>>
>>> [0]: https://lpc.events/event/16/contributions/1368/
>>>
>>> Signed-off-by: Joe Stringer <joe@isovalent.com>
>>> ---
>>> v3: Use standard table syntax
>>>       Replace inline commit message with reference to commit
>>>       Fix incorrect Y/N label for common LRU check
>>>       Rename some dotfile variables to reduce confusion between cases
>>>       Minor wording touchups
>>> v2: Fix issue that caused initial email submission to fail
>>> ---
>>>    Documentation/bpf/map_hash.rst            |  62 ++++++++
>>>    Documentation/bpf/map_lru_hash_update.dot | 166 ++++++++++++++++++++++
>>>    2 files changed, 228 insertions(+)
>>>    create mode 100644 Documentation/bpf/map_lru_hash_update.dot
>>>
>>> diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
>>> index 8669426264c6..61602ce26561 100644
>>> --- a/Documentation/bpf/map_hash.rst
>>> +++ b/Documentation/bpf/map_hash.rst
>>> @@ -1,5 +1,6 @@
>>>    .. SPDX-License-Identifier: GPL-2.0-only
>>>    .. Copyright (C) 2022 Red Hat, Inc.
>>> +.. Copyright (C) 2022-2023 Isovalent, Inc.
>>>
>>>    ===============================================
>>>    BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
>>> @@ -206,3 +207,64 @@ Userspace walking the map elements from the map declared above:
>>>                        cur_key = &next_key;
>>>                }
>>>        }
>>> +
>>> +Internals
>>> +=========
>>> +
>>> +This section of the document is targeted at Linux developers and describes
>>> +aspects of the map implementations that are not considered stable ABI. The
>>> +following details are subject to change in future versions of the kernel.
>>> +
>>> +``BPF_MAP_TYPE_LRU_HASH`` and variants
>>> +--------------------------------------
>>> +
>>> +An LRU hashmap type consists of two properties: Firstly, it is a hash map and
>>> +hence is indexable by key for constant time lookups. Secondly, when at map
>>> +capacity, map updates will trigger eviction of old entries based on the age of
>>> +the elements in a set of lists. Each of these properties may be either global
>>> +or per-CPU, depending on the map type and flags used to create the map:
>>> +
>>> ++------------------------+---------------------------+----------------------------------+
>>> +|                        | ``BPF_MAP_TYPE_LRU_HASH`` | ``BPF_MAP_TYPE_LRU_PERCPU_HASH`` |
>>> ++========================+===========================+==================================+
>>> +| ``BPF_NO_COMMON_LRU``  | Per-CPU LRU, global map   | Per-CPU LRU, per-cpu map         |
>>> ++------------------------+---------------------------+----------------------------------+
>>> +| ``!BPF_NO_COMMON_LRU`` | Global LRU, global map    | Global LRU, per-cpu map          |
>>> ++------------------------+---------------------------+----------------------------------+
>>> +
>>> +Notably, there are various steps that the update algorithm attempts in order to
>>> +enforce the LRU property which have increasing impacts on other CPUs involved
>>> +in the following operation attempts:
>>> +
>>> +- Attempt to use CPU-local state to batch operations
>>> +- Attempt to fetch free nodes from global lists
>>> +- Attempt to pull any node from a global list and remove it from the hashmap
>>> +- Attempt to pull any node from any CPU's list and remove it from the hashmap
>>> +
>>> +Even if an LRU node may be acquired, maps of type ``BPF_MAP_TYPE_LRU_HASH``
>>> +may fail to insert the entry into the map if other CPUs are heavily contending
>>> +on the global hashmap lock.
>>
>> The global hashmap lock described here is the action taken in htab_lock_bucket()?
>>
>> It is a percpu counter added in commit 20b6cc34ea74 ("bpf: Avoid hashtab
>> deadlock with map_locked") to avoid deadlock/recursion.
> 
> Hmm, yes that's the lock I had in mind. Thanks for the pointer, I
> didn't really understand the motivation for that case previously. That
> said, I now find it even harder to think of reasonable wording to
> describe in the ABI about how an eBPF program developer should reason
> about the -EBUSY failure case.

-EBUSY should be very unlikely. No good idea how to explain it as a user manual/doc.

> 
>> I would suggest to simplify the diagram by removing the "Can lock this hashtab
>> bucket?" details.
> 
> I could swap that to instead have "Update hashmap with new element",
> then have two possible outcomes depending on whether that succeeds or
> not. I guess this is also similar to John's feedback above that in the
> end, EBUSY return code ends up being ABI for the helper. Does that
> make sense? One of my goals for the diagram was to at least capture
> the various return codes to assist readers in reasoning about the
> different failure modes.

don't mind to leave the "Can lock this hashtab bucket?" as is in the diagram. I 
was just thinking a simpler diagram may be easier to grab the big picture quickly.

> 
>> Maybe a note somewhere to mention why it will still fail to
>> shrink the list because the htab_lock_bucket() have detected potential
>> deadlock/recursion which is a very unlikely case.
> 
> I missed the "shrink the list" link here since it seems like this
> could happen for any combination of update or delete elems for the
> same bucket. But yeah given that also needs to happen on the same CPU,
> it does seem very unlikely... 

shrink should try to shrink a couple of stale elems which are likely hashed to 
different buckets. If shrink hits htab_lock_bucket() EBUSY on all stale elems, 
shrink could fail but unlikely.

> Could there be a case something like "userspace process is touching that bucket, 
> gets interrupted, then the same CPU runs an eBPF program that attempts to 
> update/delete elements in the same bucket"?

raw_spin_lock_irqsave() is done after the percpu counter, so there is a gap but 
not sure if it matters though unless the production use case can really hit it.

> 
> Previously I had read this to think that EBUSY was the common case and
> ENOMEM is the uncommon case, but based on your pointers above I'm less
> convinced now, and more surprised that either failure would occur.
> Perhaps the failure I had hit was even later in the regular hashtab
> update logic. At the time of the incidents I was investigating, we
> unfortunately did not record which of the failure cases occurred so I
> don't have specific data to back up what we were experiencing. We have
> since added such reporting but I haven't received further information
> from the failure mode.


