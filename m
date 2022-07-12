Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE457223C
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 20:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiGLSLj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 14:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGLSLi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 14:11:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918262AC7
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:11:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o15so8591773pjh.1
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBx1pY9EtMlCrqsynZvCfTIrEDWjv6gTf74UrxEZY3g=;
        b=XxQywCdn8RqM7IzctJY8fSm81TTjLI+j9OKbMS6SyhstOOeyzCWq82FgGBaCuAcuHt
         TlmgoihNElsRQR6XtFv4jbFo7DwzOI1vavRgrq1ggecAWoY3cNyULssdPe4oP5E0qRpd
         Zhd6NuiM5fDm9/yrtqXAwiy5J9nftFEVQxzteWGgj+R/8Q+RDRRdoWpFf5wp2Nw0WjTG
         mtGb1Zayr4BcySzVySUuc+FN4xdhXu4o91t4wjWbzklRNB4fXjpqYlW4PHomcFTR6y87
         eKxrrS1robHB1LRe5LL4NAM1SZN6caeXVT5v3B+DjRdwwVejmmAG17m3FjKopkWf4dSb
         r1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBx1pY9EtMlCrqsynZvCfTIrEDWjv6gTf74UrxEZY3g=;
        b=qEAs1Tp5c/9zYMhcwkt4S/fcrIZLcCKH4lqPC3SzfXiMgnRPpe7h4r5YN7OYxnbnDj
         CSGlBXb8Wg/Wj2bUgMe1kYICRUwtFsQV4zvTQeGH9/bTnNbMvHBt/YB8ehk1qGOeeYZf
         70Cn1hPXrM+m/1WOS0mpjpXk6bUruiD0rhS1XGtYVAljPFvmF6iAAeToMl/drzLPOLNz
         ORFbZcclE9taYQp4KEGjjGL37bNF13CjWX0jb3tMzVjGP1SLshhIr8xKYQHK97rTOjre
         slRFKu1pAqOTsu722aIiMrIAwZU9+9VjP1RhVJ8mquaY56kjHEBwRBGsEzET6sYx09r3
         j+Gw==
X-Gm-Message-State: AJIora+oP8jgayR4PQ7KoXz8/wUNdVYbWPeoscn95sz44Bw0SpuLmQbp
        HQTG4uc9Kd4M1nO9MOwvj/ZMg2EW6+eE7uyNdmltVA==
X-Google-Smtp-Source: AGRyM1uHTzCyVAEwaQCgt07MuKAtpwBktlsdB7zVhwi/2LgdETQvt5b+Q8RLNFBkOTDSMkk6P/3EQaKIW5AMQdCfLcU=
X-Received: by 2002:a17:90b:1d91:b0:1f0:7824:1297 with SMTP id
 pf17-20020a17090b1d9100b001f078241297mr242040pjb.126.1657649496958; Tue, 12
 Jul 2022 11:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com> <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <CALvZod460hip0mQouEVtfcOZ0M21Xmzaa-atxxrUnR3ZisDCNw@mail.gmail.com>
 <Ys2iIVMZJNPe73MI@slm.duckdns.org> <CALvZod7YKrTvh-5SkDgFvtRk=DkxQ8iEhRGhDhhRGBXmYM4sFw@mail.gmail.com>
 <Ys2xGe+rdviCAjsC@slm.duckdns.org>
In-Reply-To: <Ys2xGe+rdviCAjsC@slm.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Jul 2022 11:11:25 -0700
Message-ID: <CALvZod6Y3p1NZwSQe6+UWpY88iaOBrZXS5c5+uzMb+9sY1ziwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Tejun Heo <tj@kernel.org>, Mina Almasry <almasrymina@google.com>
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

Ccing Mina who actually worked on upstreaming this. See [1] for
previous discussion and more use-cases.

[1] https://lore.kernel.org/linux-mm/20211120045011.3074840-1-almasrymina@google.com/

On Tue, Jul 12, 2022 at 10:36 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jul 12, 2022 at 10:26:22AM -0700, Shakeel Butt wrote:
> > One use-case we have is a build & test service which runs independent
> > builds and tests but all the build utilities (compiler, linker,
> > libraries) are shared between those builds and tests.
> >
> > In terms of topology, the service has a top level cgroup (P) and all
> > independent builds and tests run in their own cgroup under P. These
> > builds/tests continuously come and go.
> >
> > This service continuously monitors all the builds/tests running and
> > may kill some based on some criteria which includes memory usage.
> > However the memory usage is nondeterministic and killing a specific
> > build/test may not really free memory if most of the memory charged to
> > it is from shared build utilities.
>
> That doesn't sound too unusual. So, one saving grace here is that the memory
> pressure in the stressed cgroup should trigger reclaim of the shared memory
> which will be likely picked up by someone else, hopefully, under less memory
> pressure. Can you give more concerete details? ie. describe a failing
> scenario with actual ballpark memory numbers?

Mina, can you please provide details requested by Tejun?

>
> FWIW, at least from generic resource constrol standpoint, I think it may
> make sense to have a way to escape certain resources to an ancestor for
> shared resources provided that we can come up with a sane interface.
>
> Thanks.
>
> --
> tejun
