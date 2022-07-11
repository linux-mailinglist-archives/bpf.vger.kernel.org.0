Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAE55701ED
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 14:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiGKMWa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 08:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGKMW3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 08:22:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0361629820
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 05:22:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B2FFF20218;
        Mon, 11 Jul 2022 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657542146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hK+QKRmMvPYxr+cYe5fj5/V4jUFyChqieicBd63wLJA=;
        b=cPbqTQxnoSOqx1wGG5uhWMKYRemf04k28jSyvnZJZ0TbF8ElwNaakDPe0yWSZA02AbUUuE
        zEuX+MmIlg06pC1fB7V2gva2EDLM8oY/SjNCDYaoCy6qCWwNfUv3InfPw964E67pVN4bWd
        zWfhwWXPGiIpqNSsIJvCY9TIO0uSrkw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3D5012C141;
        Mon, 11 Jul 2022 12:22:23 +0000 (UTC)
Date:   Mon, 11 Jul 2022 14:22:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Message-ID: <YswV/+vqtB2SCVOG@dhcp22.suse.cz>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz>
 <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri 08-07-22 10:48:58, Alexei Starovoitov wrote:
> On Fri, Jul 08, 2022 at 03:41:47PM +0200, Michal Hocko wrote:
[...]
> > Finally it is not really clear to what kind of entity is the life time
> > of these caches bound to. Let's say the system goes OOM, is any process
> > responsible for it and a clean up would be done if it gets killed?
> 
> We've been asking these questions for years and have been trying to
> come up with a solution.
> bpf progs are not analogous to user space processes. 
> There are bpf progs that function completely without user space component.
> bpf progs are pretty close to be full featured kernel modules with
> the difference that bpf progs are safe, portable and users have
> full visibility into them (source code, line info, type info, etc)
> They are not binary blobs unlike kernel modules.
> But from OOM perspective they're pretty much like .ko-s.
> Which kernel module would you force unload when system is OOMing ?
> Force unloading ko-s will likely crash the system.
> Force unloading bpf progs maybe equally bad. The system won't crash,
> but it may be a sorrow state. The bpf could have been doing security
> enforcement or network firewall or providing key insights to critical
> user space components like systemd or health check daemon.
> We've been discussing ideas on how to rank and auto cleanup
> the system state when progs have to be unloaded. Some sort of
> destructor mechanism. Fingers crossed we will have it eventually.
> bpf infra keeps track of everything, of course.
> Technically we can detach, unpin and unload everything and all memory
> will be returned back to the system.
> Anyhow not a new problem. Orthogonal to this patch set.
> bpf progs have been doing memory allocation from day one. 8 years ago.
> This patch set is trying to make it 100% safe.
> Currently it's 99% safe.

OK, thanks for the clarification. There is still one thing that is not
really clear to me. Without a proper ownership bound to any process why
is it desired/helpful to account the memory to a memcg?

We have discussed something similar in a different email thread and I
still didn't manage to find time to put all the parts together. But if
the initiator (or however you call the process which loads the program)
exits then this might be the last process in the specific cgroup and so
it can be offlined and mostly invisible to an admin.

As you have explained there is nothing really actionable on this memory
by the OOM killer either. So does it actually buy us much to account?

-- 
Michal Hocko
SUSE Labs
