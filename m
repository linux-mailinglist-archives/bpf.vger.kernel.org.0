Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60C5565AB4
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiGDQNW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 12:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiGDQNV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 12:13:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42928138
        for <bpf@vger.kernel.org>; Mon,  4 Jul 2022 09:13:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F099C1F91E;
        Mon,  4 Jul 2022 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656951198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/fboqFL4a8xWdGOZp/3ipc1cfDpcMeyzqyxT1wDWv/M=;
        b=O/2cG6sqm34p/4l090bCtOc/4h4kniOc4A7rps7hIDkRMxe2BdNs66TI47un+ifO423Ska
        Z8e8tjMOk2zHzDAaHJsAHlBeek4cYn3HOlMTS2na4n3+XGYEbwDLcmDhLBL9pQNUTKm432
        lay7smnMYVGI5exyzlHN7ZyWJ0WFR4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656951198;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/fboqFL4a8xWdGOZp/3ipc1cfDpcMeyzqyxT1wDWv/M=;
        b=VNtWl4AIuwsWmSxpVy8hPib9zNA15ZcGFUHYBMwEMQxH327eOrsL+xOoOS0Q2LLcYlJZ0h
        Q9up0a3iMlKIeNCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9EB813451;
        Mon,  4 Jul 2022 16:13:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9MWxLJ0Rw2LzCAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Jul 2022 16:13:17 +0000
Message-ID: <8a160205-99fe-a632-aeed-6b59eadc2aa2@suse.cz>
Date:   Mon, 4 Jul 2022 18:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christoph Lameter <cl@gentwo.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <YrlWLLDdvDlH0C6J@infradead.org>
 <alpine.DEB.2.22.394.2206280213510.280764@gentwo.de>
 <CAADnVQKfLE6mwh8BrijgJeLL60DNaGgVy9b133vZ6edZmugong@mail.gmail.com>
 <alpine.DEB.2.22.394.2206281550210.328950@gentwo.de>
 <20220628170343.ng46xfwi32vefiyp@MacBook-Pro-3.local>
 <alpine.DEB.2.22.394.2206290431540.371188@gentwo.de>
 <CAADnVQ+6BQsunu+ipDJpEuikUU402bZPevK9+MuaBoNC_rAu_A@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAADnVQ+6BQsunu+ipDJpEuikUU402bZPevK9+MuaBoNC_rAu_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/29/22 04:49, Alexei Starovoitov wrote:
> On Tue, Jun 28, 2022 at 7:35 PM Christoph Lameter <cl@gentwo.de> wrote:
>>
>> On Tue, 28 Jun 2022, Alexei Starovoitov wrote:
>>
>> > > That is a relatively new feature due to RT logic support. without RT this
>> > > would be a simple irq disable.
>> >
>> > Not just RT.
>> > It's a slow path:
>> >         if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
>> >             unlikely(!object || !slab || !node_match(slab, node))) {
>> >               local_unlock_irqrestore(&s->cpu_slab->lock,...);
>> > and that's not the only lock in there.
>> > new_slab->allocate_slab... alloc_pages grabbing more locks.
>>
>>
>> Its not a lock for !RT.
>>
>> The fastpath is lockless if hardware allows that but then we go into more
>> and more serialiation needs as the allocation gets more into the page
>> allocator logic.

Yeah I don't think the recent RT-related changes made this much worse than
it already was. In alloc side you could perhaps try the really lockless
fastpaths only and fail if e.g. the per-cpu slabs were empty (but would BPF
be happy with that?). On the free side though you could end up having to
move a slab from partial to free list as a result, and now a spin lock is
needed (even before the RT changes), and you can't really fail a free...

> On RT fast path == slow path with a lock.
> On !RT fast path is lock less.
> That's all correct.
> bpf side has to make sure safety in all possible paths
> therefore RT or !RT makes no difference.

So AFAIK we don't right now have what BFP needs - an extra-constrained kind
of GFP_ATOMIC. I don't object you adding it privately. But it's another
reason to think about if these things can be generalized. For example we had
a discussion about the Maple tree having kinda similar kinds of requirements
to avoid its tree node preallocations always for the worst possible case.

I'm not sure we can sanely implement this within each of SLAB/SLUB/SLOB, or
rather provide a generic cache on top...
