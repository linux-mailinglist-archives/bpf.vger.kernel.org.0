Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBAB56BFF0
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 20:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbiGHRtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 13:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbiGHRtH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 13:49:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA51167EF
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 10:49:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w24so18644275pjg.5
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q9MViSedHlA+k9VSfjNemmyjdYyOVd1PGvic/0JdrSE=;
        b=p5npJkMfPAJOCljV/T6NxUmVcGRswNCyD5RdmtAN0sb7ek7Ate1kuaEuHIU6G2hNAc
         5UsQ4im5RIJ9hQ6asiWBbCD0rBzn1pIZt0KbJNzQ/1SskC9U5d7FcVT1n2wkZeeJIkH5
         WkK9XLtsVtkoZ0B2yz/k+yRZ0AMn2Rg53GqYp1xphwNLN58+KWBhc43xNRkvU+8mZEqM
         mjyCTbhTmJUbp4IKDZKweV66ehHfWuU/fpAkuF0Yzyjm0Zm6ow3wDqaDQe8guj2Urowf
         A/icjgavFUGBoaKiWXJaZq0A7dBHiVAKXA+UGzsVQgWgUQVRj5/F/ZWS5e8RGCs3AVdu
         ecCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9MViSedHlA+k9VSfjNemmyjdYyOVd1PGvic/0JdrSE=;
        b=p+neOSlgnWcTrXXk8zspRxbMcu+/CFldWs/axyxKa+x0eNW0nUb3N260R5wNFOMUbL
         pTnQ4d9xkqWamfFtpjv6ScZcj6/Q6ClRN88N09QpAIPv7uMow1NHNW1zn7lpaIHE4HLD
         hJr4FmeXjuhaItZ4ivi7gDWAcPyxMfRZWHMJBd3xA1hLKieZFIdhRwoovzKlg26T6970
         ePyCwMgKiesLNvo+vk1HhN0X5bHwpZY68KjrxdCEhVR4BKuh8Dxter4AZ5/xeHR+M75i
         vl2ty5is82WHKqyohwseBKIfVuyWYP2TJvJ4Zg4TzH8JBrkum1dtmXc9lTL9cNSSdS7p
         Ns+Q==
X-Gm-Message-State: AJIora/B5QOExh9Do4SZ771qUDUgb+FneQmeBYrpzgxHMprVidyKyDif
        Sax37KU1n7FF3Rwzmkht7OtRtOx+xqk=
X-Google-Smtp-Source: AGRyM1uNW3tXlqbbiEvVmAh6QSxh+IQjJHiAWJlDj0MBMkGctoJuQzfkRhbw6ljLOWpcu1rRCWC06g==
X-Received: by 2002:a17:902:ce09:b0:16b:ec52:760b with SMTP id k9-20020a170902ce0900b0016bec52760bmr4664110plg.155.1657302542920;
        Fri, 08 Jul 2022 10:49:02 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:46f2])
        by smtp.gmail.com with ESMTPSA id f4-20020a655504000000b0040de29f847asm23260799pgr.52.2022.07.08.10.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:49:02 -0700 (PDT)
Date:   Fri, 8 Jul 2022 10:48:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysg0GyvqUe0od2NN@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 08, 2022 at 03:41:47PM +0200, Michal Hocko wrote:
> On Wed 06-07-22 11:05:25, Alexei Starovoitov wrote:
> > On Wed, Jul 06, 2022 at 06:55:36PM +0100, Matthew Wilcox wrote:
> [...]
> > > For example, I assume that a BPF program
> > > has a fairly tight limit on how much memory it can cause to be allocated.
> > > Right?
> > 
> > No. It's constrained by memcg limits only. It can allocate gigabytes.
>  
> I have very briefly had a look at the core allocator parts (please note
> that my understanding of BPF is really close to zero so I might be
> missing a lot of implicit stuff). So by constrained by memcg you mean
> __GFP_ACCOUNT done from the allocation context (irq_work). The complete
> gfp mask is GFP_ATOMIC | __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_ACCOUNT
> which means this allocation is not allowed to sleep and GFP_ATOMIC
> implies __GFP_HIGH to say that access to memory reserves is allowed.
> Memcg charging code interprets this that the hard limit can be breached
> under assumption that these are rare and will be compensated in some
> way. The bulk allocator implemented here, however, doesn't reflect that
> and continues allocating as it sees a success so the breach of the limit
> is only bound by the number of objects to be allocated. If those can be
> really large then this is a clear problem and __GFP_HIGH usage is not
> really appropriate.

That was a copy paste from the networking stack. See kmalloc_reserve().
Not sure whether it's a bug there or not.
In a separate thread we've agreed to convert all of bpf allocations
to GFP_NOWAIT. For this patch set I've already fixed it in my branch.

> Also, I do not see any tracking of the overall memory sitting in these
> pools and I think this would be really appropriate. As there doesn't
> seem to be any reclaim mechanism implemented this can hide quite some
> unreachable memory.
> 
> Finally it is not really clear to what kind of entity is the life time
> of these caches bound to. Let's say the system goes OOM, is any process
> responsible for it and a clean up would be done if it gets killed?

We've been asking these questions for years and have been trying to
come up with a solution.
bpf progs are not analogous to user space processes. 
There are bpf progs that function completely without user space component.
bpf progs are pretty close to be full featured kernel modules with
the difference that bpf progs are safe, portable and users have
full visibility into them (source code, line info, type info, etc)
They are not binary blobs unlike kernel modules.
But from OOM perspective they're pretty much like .ko-s.
Which kernel module would you force unload when system is OOMing ?
Force unloading ko-s will likely crash the system.
Force unloading bpf progs maybe equally bad. The system won't crash,
but it may be a sorrow state. The bpf could have been doing security
enforcement or network firewall or providing key insights to critical
user space components like systemd or health check daemon.
We've been discussing ideas on how to rank and auto cleanup
the system state when progs have to be unloaded. Some sort of
destructor mechanism. Fingers crossed we will have it eventually.
bpf infra keeps track of everything, of course.
Technically we can detach, unpin and unload everything and all memory
will be returned back to the system.
Anyhow not a new problem. Orthogonal to this patch set.
bpf progs have been doing memory allocation from day one. 8 years ago.
This patch set is trying to make it 100% safe.
Currently it's 99% safe.
