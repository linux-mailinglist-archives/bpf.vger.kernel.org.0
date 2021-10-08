Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4BC42734C
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 23:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbhJHV7k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 17:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231774AbhJHV7j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 17:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633730263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XFrEJWkLw6B8GWd/xHTnVVUxTDqyhf4ypIs7xI2N/4=;
        b=ZIfTn5CHebdvWFwzeMf5jKt8mHJoDnjKjpylimEAc1Nemw5tZJuoAOLEZuanjk4C7OgPs9
        +XDsMmvrMSevLUvQftLqlcOBcQovTgoeZ/I9zXdFvyL6gZodTI7EylKapHiOUS7Lvex8XY
        jvXNtTxidTVLIN61uWB2/1YTIGjvczs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-QkuC_CKMMmiJL-xU-wEEHg-1; Fri, 08 Oct 2021 17:57:36 -0400
X-MC-Unique: QkuC_CKMMmiJL-xU-wEEHg-1
Received: by mail-ed1-f70.google.com with SMTP id c8-20020a50d648000000b003daa53c7518so10429764edj.21
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 14:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/XFrEJWkLw6B8GWd/xHTnVVUxTDqyhf4ypIs7xI2N/4=;
        b=qQOwwsvOKzDVWuZ/iwGRY9UpimLMi1Dcw0SQnjqoJBA6JAt1FAhItyZcXu5u5GD3Nz
         zcRP55j9mK6+OdStZJtknVo9Ml8a5F9A0S7mTrurXKtz4D8LMgRebs9rfCEsdf1YrLVg
         eDOVRJKFEcZRFietf6li/DMpHj1FFF7QbTK55bcYj3vy8jesezU6uYuV3kq+ui2yDVCM
         ZxFidDvc1UO/plM74yypwYAxPofY7KoG/UzoD+ZyOP2q7v67C2iCgkrqu/sNKCpMUYf7
         hptLAV7NyoaHsq0Ce+RlYUMi7fQucK8yb4sacwR9UUeOoE4T//Hqi8kS46ANkl/WuoAR
         T6dw==
X-Gm-Message-State: AOAM533/MThDd+ugt6qN37Lix/Xk+LRon4Rg+yBAJE+H64K4YnX0pLtZ
        P74auTr1f464TBQz7iW5seMBJmBJGRsLC+dAdTWGDA8kyp26VhrKmm17f74F8RwbEDlkMvQfRf1
        wjxFa2RUY25iH
X-Received: by 2002:a05:6402:2554:: with SMTP id l20mr9203776edb.186.1633730254923;
        Fri, 08 Oct 2021 14:57:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcVwHZrgpWHbDjXRUc9VDg2bGYlwzkaMUZJXOeuwMKjQTrhBhYHjTjsJrPZEKHVeOdmKkGkQ==
X-Received: by 2002:a05:6402:2554:: with SMTP id l20mr9203743edb.186.1633730254642;
        Fri, 08 Oct 2021 14:57:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f1sm237205edz.47.2021.10.08.14.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:57:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5E3C4180151; Fri,  8 Oct 2021 23:57:33 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     Kernel-team@fb.com
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter
 capabilities
In-Reply-To: <4536decc-5366-dc07-4923-32f2db948d85@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-2-joannekoong@fb.com> <87k0ioncgz.fsf@toke.dk>
 <4536decc-5366-dc07-4923-32f2db948d85@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 Oct 2021 23:57:33 +0200
Message-ID: <87o87zji2a.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> On 10/7/21 7:20 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>> Joanne Koong <joannekoong@fb.com> writes:
>>
>>> This patch adds the kernel-side changes for the implementation of
>>> a bitset map with bloom filter capabilities.
>>>
>>> The bitset map does not have keys, only values since it is a
>>> non-associative data type. When the bitset map is created, it must
>>> be created with a key_size of 0, and the max_entries value should be the
>>> desired size of the bitset, in number of bits.
>>>
>>> The bitset map supports peek (determining whether a bit is set in the
>>> map), push (setting a bit in the map), and pop (clearing a bit in the
>>> map) operations. These operations are exposed to userspace applications
>>> through the already existing syscalls in the following way:
>>>
>>> BPF_MAP_UPDATE_ELEM -> bpf_map_push_elem
>>> BPF_MAP_LOOKUP_ELEM -> bpf_map_peek_elem
>>> BPF_MAP_LOOKUP_AND_DELETE_ELEM -> bpf_map_pop_elem
>>>
>>> For updates, the user will pass in a NULL key and the index of the
>>> bit to set in the bitmap as the value. For lookups, the user will pass
>>> in the index of the bit to check as the value. If the bit is set, 0
>>> will be returned, else -ENOENT. For clearing the bit, the user will pass
>>> in the index of the bit to clear as the value.
>> This is interesting, and I can see other uses of such a data structure.
>> However, a couple of questions (talking mostly about the 'raw' bitmap
>> without the bloom filter enabled):
>>
>> - How are you envisioning synchronisation to work? The code is using the
>>    atomic set_bit() operation, but there's no test_and_{set,clear}_bit().
>>    Any thoughts on how users would do this?
> I was thinking for users who are doing concurrent lookups + updates,
> they are responsible for synchronizing the operations through mutexes.
> Do you think this makes sense / is reasonable?

Right, that is an option, of course, but it's a bit heavyweight. Atomic
bitops are a nice light-weight synchronisation primitive.

Hmm, looking at your code again, you're already using
test_and_clear_bit() in pop_elem(). So why not just mirror that to
test_and_set_bit() in push_elem(), and change the returns to EEXIST and
ENOENT if trying to set or clear a bit that is already set or cleared
(respectively)?

>> - It would be useful to expose the "find first set (ffs)" operation of
>>    the bitmap as well. This can be added later, but thinking about the
>>    API from the start would be good to avoid having to add a whole
>>    separate helper for this. My immediate thought is to reserve peek(-1)
>>    for this use - WDYT?
> I think using peek(-1) for "find first set" sounds like a great idea!

Awesome!

>> - Any thoughts on inlining the lookups? This should at least be feasible
>>    for the non-bloom-filter type, but I'm not quite sure if the use of
>>    map_extra allows the verifier to distinguish between the map types
>>    (I'm a little fuzzy on how the inlining actually works)? And can
>>    peek()/push()/pop() be inlined at all?
>
> I am not too familiar with how bpf instructions and inlining works, but
> from a first glance, this looks doable for both the non-bloom filter
> and bloom filter cases. From my cursory understanding of how it works,
> it seems like we could have something like "bitset_map_gen_lookup" where
> we parse the bpf_map->map_extra to see if the bloom filter is enabled;
> if it is, we could call the hash function directly to compute which bit=20
> to look up,
> and then use the same insn logic for looking up the bit in both cases
> (the bitmap w/ and w/out the bloom filter).
>
> I don't think there is support yet in the verifier for inlining
> peek()/push()/pop(), but it seems like this should be doable as well.
>
> I think these changes would maybe warrant a separate patchset
> on top of this one. What are your thoughts?

Ah yes, I think you're right, this should be possible to add later. I'm
fine with deferring that to a separate series, then :)

-Toke

