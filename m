Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E564F5725AD
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 21:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiGLTgd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 15:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiGLTgN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 15:36:13 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D626210B240
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 12:12:01 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id l190so8768760vsc.0
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKBUIvv8aNPODGFzkzruwu1gOgcsIvACZpHnA9s8S78=;
        b=JHIYKxGtDHW6Ai7dYGvzir8gEwGoLbDhv7XXPSHwGpgR3Ct2PJvzeZa0kOQYT7HMqM
         M0a+Cfive2wD3CQkvw5z/CwlQtajyTXWFXT1p9VlwCt0gVIeUea8iKSnOyFNMQqQk1Rk
         jlCB/ef/opJVGuHW7NaDhgrBvyGF+K8jAuUzw8s+HNcoM2xaCJGf17b3XSnInjTsLHxC
         oAybbOoF87qlV5ryOuzMzt85Dub5CcM1jg2T2fR6mMZk5vrfDGXWsW2ySMd1p7Am5Ktf
         jdZ5KfYk0tHSuXzgcq3y9ibUXDcqVLTOQtIttCLKOmTgA4NGJdt6HOvTDnqyfs/PYUOq
         S6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKBUIvv8aNPODGFzkzruwu1gOgcsIvACZpHnA9s8S78=;
        b=F5zsme26KUe06AUIQT9kv2lJsHrXClj3ImOWaFrnOcyB2KXmvSEAu7XGLBcxIj+5Jw
         X6VEj2ssyAFT+W0oDbp8m29/I28bQt52mvLt+9ZuFBtOTdbz0aGabBRlpKribjrh+WyJ
         roXucbYCeCvz1NMJvgYdKPKZxs+scaI3YvDcrCBNV4j3L9tZ8hY20jhdMZ4UK83DED2x
         CGeqxoAoWbhSKvHzQRRHLHc4jiMF4NvR7NVcBfrVhR3tr+iPOqfLNJmhGF6HVgRxnkm9
         4MD6zIJ8u/abUFTj1Rb8YDy9T1SGMFUv2gWfplJY2kmaxaE016720yBmU7PR6YVzthLe
         NbQw==
X-Gm-Message-State: AJIora84HbKOnqgsA0XTg0rNe1xSqg7K7wjCGqf9TcDrX4w3hj3pXUDa
        rcLq1JiKGDd0N3KfzswqZsg2wbyN1h6vstIYrsoUAQ==
X-Google-Smtp-Source: AGRyM1sFYhzvYzQZieH6k7hGQVEDC0NgF++UpPOyOq17Q1VYqkc5b6iGNO0bhpi/rs8ljqh4Wy3LJ0u7uUYKNfaVsho=
X-Received: by 2002:a67:d495:0:b0:357:688d:f65c with SMTP id
 g21-20020a67d495000000b00357688df65cmr4040211vsj.59.1657653120487; Tue, 12
 Jul 2022 12:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com> <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <CALvZod460hip0mQouEVtfcOZ0M21Xmzaa-atxxrUnR3ZisDCNw@mail.gmail.com>
 <Ys2iIVMZJNPe73MI@slm.duckdns.org> <CALvZod7YKrTvh-5SkDgFvtRk=DkxQ8iEhRGhDhhRGBXmYM4sFw@mail.gmail.com>
 <Ys2xGe+rdviCAjsC@slm.duckdns.org> <CALvZod6Y3p1NZwSQe6+UWpY88iaOBrZXS5c5+uzMb+9sY1ziwg@mail.gmail.com>
In-Reply-To: <CALvZod6Y3p1NZwSQe6+UWpY88iaOBrZXS5c5+uzMb+9sY1ziwg@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 12 Jul 2022 12:11:48 -0700
Message-ID: <CAHS8izPHjhTOXYTG5O4kpYUou51MDrUBEYb2SgFEP5vKZaOWtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 11:11 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> Ccing Mina who actually worked on upstreaming this. See [1] for
> previous discussion and more use-cases.
>
> [1] https://lore.kernel.org/linux-mm/20211120045011.3074840-1-almasrymina@google.com/
>
> On Tue, Jul 12, 2022 at 10:36 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, Jul 12, 2022 at 10:26:22AM -0700, Shakeel Butt wrote:
> > > One use-case we have is a build & test service which runs independent
> > > builds and tests but all the build utilities (compiler, linker,
> > > libraries) are shared between those builds and tests.
> > >
> > > In terms of topology, the service has a top level cgroup (P) and all
> > > independent builds and tests run in their own cgroup under P. These
> > > builds/tests continuously come and go.
> > >
> > > This service continuously monitors all the builds/tests running and
> > > may kill some based on some criteria which includes memory usage.
> > > However the memory usage is nondeterministic and killing a specific
> > > build/test may not really free memory if most of the memory charged to
> > > it is from shared build utilities.
> >
> > That doesn't sound too unusual. So, one saving grace here is that the memory
> > pressure in the stressed cgroup should trigger reclaim of the shared memory
> > which will be likely picked up by someone else, hopefully, under less memory
> > pressure. Can you give more concerete details? ie. describe a failing
> > scenario with actual ballpark memory numbers?
>
> Mina, can you please provide details requested by Tejun?
>

As far as I am aware the builds/tests service Shakeel mentioned is a
theoretical use case we're considering, but the actual use cases we're
running are the 3 I listed in my cover letter in my original proposal:

https://lore.kernel.org/linux-mm/20211120045011.3074840-1-almasrymina@google.com/

Still, the use case Shakeel is talking about is almost identical to
use case #2 in that proposal:
"Our infrastructure has large meta jobs such as kubernetes which spawn
multiple subtasks which share a tmpfs mount. These jobs and its
subtasks use that tmpfs mount for various purposes such as data
sharing or persistent data between the subtask restarts. In kubernetes
terminology, the meta job is similar to pods and subtasks are
containers under pods. We want the shared memory to be
deterministically charged to the kubernetes's pod and independent to
the lifetime of containers under the pod."

To run such a job we do the following:

- We setup a hierarchy like so:
                   pod_container
                  /           |                 \
container_a    container_b     container_c

- We set up a tmpfs mount with memcg= pod_container. This instructs
the kernel to charge all of this tmpfs user data to pod_container,
instead of the memcg of the task which faults in the shared memory.

- We set up the pod_container.max to be the maximum amount of memory
allowed to the _entire_ job.

- We set up container_a.max, container_b.max, and container_c.max to
be the limit of each of sub-tasks a, b, and c respectively, not
including the shared memory, which is allocated via the tmpfs mount
and charged directly to pod_container.


For some rough numbers, you can imagine a scenario:

tmpfs memcg=pod_container,size=100MB

                                 pod_container.max=130MB
                    /                           |
             \
container_a.max=10MB    container_b.max=20MB    container_c.max=30MB


Thanks to memcg=pod_container, neither tasks a, b, and c are charged
for the shared memory, so they can stay within their 10MB, 20MB, and
30MB limits respectively. This gives us fine grained control to
deterministically charge the shared memory and apply limits on the
memory usage of the individual sub-tasks and the overall amount of
memory the entire pod should consume.

For transparency's sake, this is Johannes's comments on the API:
https://lore.kernel.org/linux-mm/YZvppKvUPTIytM%2Fc@cmpxchg.org/

As Tejun puts it:

"it may make sense to have a way to escape certain resources to an ancestor for
shared resources provided that we can come up with a sane interface"

The interface Johannes has opted for is to reparent memory to the
common ancestor _when it is accessed by a task in another memcg_. This
doesn't work for us for a few reasons, one of which in the example
above container_a may get charged for all the 100MB of shared memory
if it's the unlucky task that faults in all the shared memory.


> >
> > FWIW, at least from generic resource constrol standpoint, I think it may
> > make sense to have a way to escape certain resources to an ancestor for
> > shared resources provided that we can come up with a sane interface.
> >
> > Thanks.
> >
> > --
> > tejun
