Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A063FAA4
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 23:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiLAWfH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 17:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiLAWfA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 17:35:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ED785672
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 14:34:59 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669934097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQ3l/8iPHJrE4lXKcSUZU6jnY9bc7FNJ5TKI/6vTgGA=;
        b=IRR/xyts6kOonxpsMaiU6T/O5xt31MgiyF46ryrFDvRwkSdjhqvecw8s1IWhk8X1qpi2y+
        /AyGu9sKkh53xbPjjNlKOSD1dJvBo/6+gJoVc46o2FFO5zI/lv0MwscmKCRo5YqoJ0HXzX
        3LvlVZXid6e8kvpNTzm5OGd7zAXBlum6Iu0cybPxLwRbsp94JIUPxrnKQAKuLQbqOO+Gb7
        yFGaaDseYJU05KJrUuXT/69mCFtBAwRONUNUSeAGPnIGNEjw5XEwJ7cyFYgyWkqWB9ReeI
        zIaw/WgLofHY52R4wCrbmfdyjsPpU4JbnKBmc1FgM4viyfvs1u5YxBL6aDIIig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669934097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQ3l/8iPHJrE4lXKcSUZU6jnY9bc7FNJ5TKI/6vTgGA=;
        b=69s2aBBM19lrmXJ4LMiY+TRz0Zup152ougrxGaYiZR5QmJgMwJcMgz4MTGWqaZhM1IFRmO
        lP8U2qALBWgIiyBw==
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
In-Reply-To: <Y4kNMpRgvEN2KrkD@kernel.org>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx> <Y4kNMpRgvEN2KrkD@kernel.org>
Date:   Thu, 01 Dec 2022 23:34:57 +0100
Message-ID: <87mt86rbvy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mike!

On Thu, Dec 01 2022 at 22:23, Mike Rapoport wrote:
> On Thu, Dec 01, 2022 at 10:08:18AM +0100, Thomas Gleixner wrote:
>> On Wed, Nov 30 2022 at 08:18, Song Liu wrote:
>> The symptom is iTLB pressure. The root cause is the way how module
>> memory is allocated, which in turn causes the fragmentation into
>> 4k PTEs. That's the same problem for anything which uses module_alloc()
>> to get space for text allocated, e.g. kprobes, tracing....
>
> There's also dTLB pressure caused by the fragmentation of the direct map.
> The memory allocated with module_alloc() is a priori mapped with 4k PTEs,
> but setting RO in the malloc address space also updates the direct map
> alias and this causes splits of large pages.
>
> It's not clear what causes more performance improvement: avoiding splits of
> large pages in the direct map or reducing iTLB pressure by backing text
> memory with 2M pages.

From our experiments when doing the first version of the SKX retbleed
mitigation, the main improvement came from reducing iTLB pressure simply
because the iTLB cache is really small.

The kernel text placement is way beyond suboptimal. If you really do a
hotpath analysis and (manually) place all hot code into one or two 2M
pages, then you can achieve massive performance improvements way above
the 10% range.

We currently have a master student investigating this, but it will take
some time until usable results materialize.

> If the major improvement comes from keeping direct map intact, it's
> might be possible to mix data and text in the same 2M page.

No. That can't work.

    text = RX
    data = RW or RO

If you mix this, then you end up with RWX for the whole 2M page. Not an
option really as you lose _all_ protections in one go.

That's why I said:

>>      As a logical next step we make that three blocks and allocate text,
>>      data and rodata separately, which will preserve the large mappings for
>>      text and data. rodata still needs to be split because we need a space to
>>      accomodate ro_after_init data.

The point is, that rodata and ro_after_init_data is a pretty small
portion of modules as far as my limited analysis of a distro build
shows.

The bulk is in text and data. So if we preserve 2M pages for text and
for RW data and bite the bullet to split one 2M page for
ro[_after_init_]data, we get the maximum benefit for the least
complexity.

>> But at the end we want an allocation mechanism which:
>> 
>>   - preserves large mappings
>>   - handles a distinct address range
>>   - is mapping type aware
>> 
>> That solves _all_ the issues of modules, kprobes, tracing, bpf in one
>> go. See?
>
> There is also
>
>     - handles kaslr
>
> and at least for arm and powerpc we'd also need 
>
>     - handles architecture specific range restrictions and fallbacks

Good points.

kaslr should be fairly trivial.

The architecture specific restrictions and fallbacks are not really hard
to solve either. If done right then the allocator just falls back to 4k
maps during initialization in early boot which brings it back to the
status quo. But we can provide consistent semantics for the three types
which are required for modules and the text only usage for kprobes,
tracing, bpf...

Thanks,

        tglx
