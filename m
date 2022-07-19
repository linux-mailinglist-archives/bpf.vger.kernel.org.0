Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BBF5798C8
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 13:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiGSLwj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 07:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGSLwi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 07:52:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AEB24097
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 04:52:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7021333C53;
        Tue, 19 Jul 2022 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658231556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XtmWboqbIASJbCrB3i9Htkl40gPCS3M/5k4PjxT7q4U=;
        b=rjGbuC42p9TIRGVuAsTjkqWWU8HSco3uB7gWo+4g+78R4NymeMBiqg3yzDohYIJT79vZqd
        NRIH7DfowVPJhzJMGPkW9+Rdtu5DmDVzxm7kcG1KLNsj2J237/MzXqnXlwPtdkvkeDnpLW
        Di/cOEW+FixPnWulwkT+e7GFJWKfRiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658231556;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XtmWboqbIASJbCrB3i9Htkl40gPCS3M/5k4PjxT7q4U=;
        b=2zZ9DVKfdtyQN4eQi+3xNvatYxeN7cEZSsQGjhfvDfVpha0XXt19RC90yXVE494UDkxdIf
        mPGI5O/0GvnSYXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24C4713A72;
        Tue, 19 Jul 2022 11:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R48dCASb1mIcLAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 19 Jul 2022 11:52:36 +0000
Message-ID: <a3ff1556-30f8-f25c-6abf-72e7bee551f2@suse.cz>
Date:   Tue, 19 Jul 2022 13:52:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Lameter <cl@gentwo.de>,
        Christoph Hellwig <hch@infradead.org>,
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
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <YrlWLLDdvDlH0C6J@infradead.org>
 <alpine.DEB.2.22.394.2206280213510.280764@gentwo.de>
 <CAADnVQKfLE6mwh8BrijgJeLL60DNaGgVy9b133vZ6edZmugong@mail.gmail.com>
 <alpine.DEB.2.22.394.2206281550210.328950@gentwo.de>
 <20220628170343.ng46xfwi32vefiyp@MacBook-Pro-3.local>
 <alpine.DEB.2.22.394.2206290431540.371188@gentwo.de>
 <CAADnVQ+6BQsunu+ipDJpEuikUU402bZPevK9+MuaBoNC_rAu_A@mail.gmail.com>
 <8a160205-99fe-a632-aeed-6b59eadc2aa2@suse.cz>
 <20220706174328.xqfyu4ikjvutnpr4@MacBook-Pro-3.local>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220706174328.xqfyu4ikjvutnpr4@MacBook-Pro-3.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/6/22 19:43, Alexei Starovoitov wrote:
> On Mon, Jul 04, 2022 at 06:13:17PM +0200, Vlastimil Babka wrote:
>> 
>> > On RT fast path == slow path with a lock.
>> > On !RT fast path is lock less.
>> > That's all correct.
>> > bpf side has to make sure safety in all possible paths
>> > therefore RT or !RT makes no difference.
>> 
>> So AFAIK we don't right now have what BFP needs - an extra-constrained kind
>> of GFP_ATOMIC. I don't object you adding it privately. But it's another
>> reason to think about if these things can be generalized. For example we had
>> a discussion about the Maple tree having kinda similar kinds of requirements
>> to avoid its tree node preallocations always for the worst possible case.
> 
> What kind of maple tree needs? Does it need to be fully reentrant and nmi safe?
> Not really. The caller knows the context and can choose appropriate flags.
> While bpf alloc doesn't know the context. The bpf prog can be called from
> places where slab/page/kasan specific locks are held which makes all these
> pieces non-reentrable.

Sure, the context restrictions can differ between bpf, maple tree and other
users, but I think there's common need not to be dependend on slab/page
allocator implementation internals and its locking. So the common
allocator/cache on top would need to be implemented in a way to support the
most restricted context (e.g. bpf), thus be lockless and whatnot.
But then the individual users would be able to specify different details such as
- how much to preallocate in order to not run out of the cache
- what is allowed if we run out of cache - only async refill (bpf?) or also
e.g. GFP_NOWAIT for less restricted users?

> The full prealloc of bpf maps (read: waste a lot of memory) was our solution until now.
> This is specific to tracing bpf programs, of course.
> bpf networking, bpf security, sleepable bpf are completely different.
> 
>> I'm not sure we can sanely implement this within each of SLAB/SLUB/SLOB, or
>> rather provide a generic cache on top...
> 
> Notice that all of bpf cache functions are notrace/nokprobe/no locks.
> The main difference vs all other allocators is bpf_mem_alloc from cache
> and refill of the cache are two asynchronous operations. It allows the former
> to be reentrant and nmi safe.
> All in tree allocators sooner or later synchornously call into page_alloc,
> kasan, memleak and other debugging facilites that grab locks.
> 

