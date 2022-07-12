Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3780C5721B3
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 19:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiGLR0g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 13:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiGLR0e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 13:26:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8E4BF56A
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 10:26:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so8999276pjl.4
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bD5Vt81GWvxaxfliFcqQlWhU4gxj9miMeasbRgHQrNs=;
        b=LPUimenByIRsyK/inetz+R7gf8CoKmgyG69kuGsVYFDhBuHrT4/rV5TSuiT6AtnhDU
         rBdWs1fvo4DudAnsB3df3u02yoOVuA6zbXLLXF7jhW9pnDECnthxXAfqsjTCU6FbP6Sm
         KjstAo/DkMZiGXMsC2r/pakgZLgLc/hQ5mjWNdbzYw5icTC5iWoEtIitlXCoSW9P6zmF
         7dcFhshcbtAq2zWmGZGjG+jXXLLLXtbdwNVEjueZphjZpX0AXridn7dl+B1cLmj2VUDa
         XsvbsabaeYaYodZJJCZGbDXyWdmDoLwuZnJCBr6Yy0zYXw3mlheT2F0H0y9qBd5AX9xj
         VoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bD5Vt81GWvxaxfliFcqQlWhU4gxj9miMeasbRgHQrNs=;
        b=qy4qUvFkLkCyW4ES0ijVlQl35tg0+WEzXE6LbUbx5WfguRYdes51cjaSHj8o+k37FT
         LVsjzkYJnnjzd3VIR1OMv89+P7DOkcy1jev/mf1RpsgXaevz92VUZd2cABsMNe+9cFmV
         xamnl0RiPGno9q/MR9/8I/vByoCxI+h1MN+axqLAv77eu5BW74aYLfFGoPlQSB6J7wCx
         RIZAQx7x9dU5y3PFDFc3U9PtFaz1IFrcoeT4MyfkIqQvDNtTINkPFZMsWix2/UDJCWth
         67wcJMsnSEjrOEKg0BONOl9f6O8FOOJ1VXdIJh/P/sl2e5G1vLYvXAm7jJ8NOX+p2RCd
         Vaww==
X-Gm-Message-State: AJIora+gbSMJVcsJCsSKAGjx+1Qh/lwDdoxe8xJxq+P50m3r4GSIG9aZ
        Lfko8AYgXDjQkJQDWPgGGNlTS+yKNJJYqmLVh4/OYg==
X-Google-Smtp-Source: AGRyM1vDtuysOBoFfVT0CqKAYEBsNcb9IX8AUkMTyCjon2tXxxAP7cqW1KlDZGMKkVRjuHA2N4tbpyIpXJuBsN+HIZ8=
X-Received: by 2002:a17:902:ef48:b0:16a:1d4b:22ca with SMTP id
 e8-20020a170902ef4800b0016a1d4b22camr24539104plx.6.1657646793485; Tue, 12 Jul
 2022 10:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com> <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com> <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <CALvZod460hip0mQouEVtfcOZ0M21Xmzaa-atxxrUnR3ZisDCNw@mail.gmail.com>
 <Ys2iIVMZJNPe73MI@slm.duckdns.org>
In-Reply-To: <Ys2iIVMZJNPe73MI@slm.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Jul 2022 10:26:22 -0700
Message-ID: <CALvZod7YKrTvh-5SkDgFvtRk=DkxQ8iEhRGhDhhRGBXmYM4sFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
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

On Tue, Jul 12, 2022 at 9:32 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jul 12, 2022 at 08:25:24AM -0700, Shakeel Butt wrote:
> > Another very obvious example is the filesystem shared between multiple
> > jobs. We had a similar discussion [1] on LRU reparenting patch series.
>
> Hmm... if I'm understanding correctly, what's discussed in [1] can be solved
> with proper reparenting and nesting, right?
>

To some extent i.e. the zombies will go away but the accounting/stats
of the sub-jobs will be nondeterministic until all the possible shared
stuff is reparented. Let me give a more concrete example below.

> > For this use-case internally we have a memcg= mount option where the
> > given memcg is the common ancestor (think of pod in k8s environment)
> > of the jobs who are sharing the filesystem.
>
> Can you elaborate a bit more on this? We've never really supported correctly
> accounting pages shared across cgroups because it can be very complicating
> and the use cases aren't that wide-spread. What's being shared? How big is
> the shared portion in relation to total memory usage? What's the cgroup
> topology like?
>

One use-case we have is a build & test service which runs independent
builds and tests but all the build utilities (compiler, linker,
libraries) are shared between those builds and tests.

In terms of topology, the service has a top level cgroup (P) and all
independent builds and tests run in their own cgroup under P. These
builds/tests continuously come and go.

This service continuously monitors all the builds/tests running and
may kill some based on some criteria which includes memory usage.
However the memory usage is nondeterministic and killing a specific
build/test may not really free memory if most of the memory charged to
it is from shared build utilities.
