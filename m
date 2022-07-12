Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A325722D6
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 20:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiGLSkb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 14:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiGLSk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 14:40:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBF6BFAFE
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:40:22 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g4so8402929pgc.1
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4UeeXqybc/cqL+mbk/GXnvmjdYDPUcVq4hnPD2o0mrA=;
        b=XCN2l/7tBjfdV3ZcY6mjs0Cj1uwyI5BMT9Y9Esd63A2IfeNsQLLoBRZDt043X5aJ1t
         9ZqlRAOPRStHfEyscOLrY/+U/GD+WmaGTVfP2ve5f8Erac/rgVmjBb8zajD0einubCdd
         BHO53udkyyVan81Y3P1k/sCWBj10HTf3OEwQHsYnCCwgycVcMUckZsdFf020hw7gOSCO
         sDbRgiNxEKmy8k63s4wJyacRKYJipa7XGfAOPzHCMj1PHTfIcFgtF1GNvd8J+22AJnmM
         Y4lemm//n1trARql3Ywz0U69cd7lRpL8+upx3rEXWNnyLrWe9K3rdFbaClGslPBKFNlJ
         8D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4UeeXqybc/cqL+mbk/GXnvmjdYDPUcVq4hnPD2o0mrA=;
        b=dwcCd9SuoqOScsXfDlzfWdnX4b6Ov7c1vdVjLYVAUYH/ewRFrhw4RZZ5Th/x0zQKE8
         O2gRVwV4+ut8neM/QlSZpkzrPu6mrSIsxGIMrtGvKDq5nZPy5YE2jXDlbAHGx7mBf+xK
         gHNcyI3qPKJXBpBLPaQw648Xxa8cthIbt4E3jQr+oglCN55bNVr/dwR7ikc0PuBz1mra
         qOglAnJAu1Ts/uY+EJKU6V8L0tjVjlAd+jQ+eEHoZVaVYBz77rAQj0d2CLmHzXy5+YTB
         RDjL1WEJIH8nxgetua2cuyI1JOPGWNBSwN0D32QMbc3E3IIHLgem1cdHohXeiozdHiqQ
         Qc0Q==
X-Gm-Message-State: AJIora/7GYnYD/65koPDYN7F2+GZGPoedjaF8Vo+KFHeLbxQTdT4kMGa
        708NRjjeVUEqmOiT4P6Mq8M=
X-Google-Smtp-Source: AGRyM1s/J9hhivI5wwuV0abBfA36cyDpWxsEYI5J5tzavvNkY7X+a42vUR94FWarTlz4fdqGVMB9MQ==
X-Received: by 2002:a63:ba1d:0:b0:419:7e6e:2858 with SMTP id k29-20020a63ba1d000000b004197e6e2858mr1942549pgf.67.1657651222382;
        Tue, 12 Jul 2022 11:40:22 -0700 (PDT)
Received: from MacBook-Pro-3.local.dhcp.thefacebook.com ([2620:10d:c090:500::2:8800])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b0016a6caacaefsm7232427plh.103.2022.07.12.11.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 11:40:21 -0700 (PDT)
Date:   Tue, 12 Jul 2022 11:40:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <20220712184018.i3cisffxr7k3aei7@MacBook-Pro-3.local.dhcp.thefacebook.com>
References: <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz>
 <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com>
 <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
 <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 09:40:13AM +0200, Michal Hocko wrote:
> On Mon 11-07-22 21:39:14, Alexei Starovoitov wrote:
> > On Mon, Jul 11, 2022 at 02:15:07PM +0200, Michal Hocko wrote:
> > > On Sun 10-07-22 07:32:13, Shakeel Butt wrote:
> > > > On Sat, Jul 09, 2022 at 10:26:23PM -0700, Alexei Starovoitov wrote:
> > > > > On Fri, Jul 8, 2022 at 2:55 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > > [...]
> > > > > >
> > > > > > Most probably Michal's comment was on free objects sitting in the caches
> > > > > > (also pointed out by Yosry). Should we drain them on memory pressure /
> > > > > > OOM or should we ignore them as the amount of memory is not significant?
> > > > > 
> > > > > Are you suggesting to design a shrinker for 0.01% of the memory
> > > > > consumed by bpf?
> > > > 
> > > > No, just claim that the memory sitting on such caches is insignificant.
> > > 
> > > yes, that is not really clear from the patch description. Earlier you
> > > have said that the memory consumed might go into GBs. If that is a
> > > memory that is actively used and not really reclaimable then bad luck.
> > > There are other users like that in the kernel and this is not a new
> > > problem. I think it would really help to add a counter to describe both
> > > the overall memory claimed by the bpf allocator and actively used
> > > portion of it. If you use our standard vmstat infrastructure then we can
> > > easily show that information in the OOM report.
> > 
> > OOM report can potentially be extended with info about bpf consumed
> > memory, but it's not clear whether it will help OOM analysis.
> 
> If GBs of memory can be sitting there then it is surely an interesting
> information to have when seeing OOM. One of the big shortcomings of the
> OOM analysis is unaccounted memory.
> 
> > bpftool map show
> > prints all map data already.
> > Some devs use bpf to inspect bpf maps for finer details in run-time.
> > drgn scripts pull that data from crash dumps.
> > There is no need for new counters.
> > The idea of bpf specific counters/limits was rejected by memcg folks.
> 
> I would argue that integration into vmstat is useful not only for oom
> analysis but also for regular health check scripts watching /proc/vmstat
> content. I do not think most of those generic tools are BPF aware. So
> unless there is a good reason to not account this memory there then I
> would vote for adding them. They are cheap and easy to integrate.

We've seen enough performance issues with such counters.
So, no, they are not cheap.
Remember bpf has to be optimized for all cases.
Some of them process millions of packets per second.
Others do millions of map update/delete per second which means
millions of alloc/free.

> > > OK, thanks for the clarification. There is still one thing that is not
> > > really clear to me. Without a proper ownership bound to any process why
> > > is it desired/helpful to account the memory to a memcg?
> > 
> > The first step is to have a limit. memcg provides it.
> 
> I am sorry but this doesn't really explain it. Could you elaborate
> please? Is the limit supposed to protect against adversaries? Or is it
> just to prevent from accidental runaways? 

yes to above two.

> Is it purely for accounting
> purposes?

also soft yes. Once the user be able to select memcg it will become
a strong yes.
