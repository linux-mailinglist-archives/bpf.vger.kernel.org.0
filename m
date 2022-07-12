Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB9B571F05
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 17:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiGLPZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiGLPZh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 11:25:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E95F47
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 08:25:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so11747264pjn.0
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVCxtziu69ypPL5baLDbqkUeAm+Vad851F8u5cx8lOU=;
        b=WAgI080vmtFPk69NUza6Dbq2aG5KAv/af8J9ue1zjHkKGo7hGrryj5ttPAhOXJ+c1I
         Qc/9oH2fjGAe06jXU2V7fzsPXj7ziWGehJAsacIyysKGlmhmqCYEYq2gSLLChpf5qOKh
         9F9n0Uusnr7YWWBmgbMV7go7ESJz3KrtZorZpaBSt8/gGKyays1DjDUG2+XIl6bQdwvR
         rTS8tAtp6gCKys14qS8LGJS/nVafbHSG7TaxXtuKwW6bO7I7ctbsLFs624WgLLfYXEX6
         fRChwTXMG6yfJ286oHSU3XqsITkxWh8DO4JBxYMo8kxcksukjQBe8O2gGlELpLqir3wt
         9gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVCxtziu69ypPL5baLDbqkUeAm+Vad851F8u5cx8lOU=;
        b=GSOwgPxFgkr/YlpIsOV47zLHVxy7UYtfRYAgAWcY/c2OG6Y61Lxv/XgUDwlGMz3ZzM
         VcXXgMWm8Gc2M5IaSsFkMdAfrLOwUWJmscvHssN3EgTPztvjzB/8uNNWKcQxjF6podno
         fb8LRTrXnM4KKM7pdPNR4d1ggV9nkleUGTIezrMWJyKRt3gbbTG/DtOcnRvdebn/r0pI
         halfAFm/4Ffcpxjg+h5Nip4sT7QrNdxBic1fWrTNMxxUG2B/51+xzplD5w6J9ogzxaMD
         86e3ncs5jeMOnShbeniEj0b2tvTUOthhL0ZbmB/S4TTl0Glw/eDJLaW9ZGUFhvgQBA4E
         32UA==
X-Gm-Message-State: AJIora8vXjSC2a4c67aSQcTvB6HjDMUVPZTH0h+H4HIFHG3Jsea+z0ZB
        A7iJ9Mn1x61oG2fyDp72gBYUpsDs/p6ntxU2bcpDNg==
X-Google-Smtp-Source: AGRyM1sv5Gbh5ZPu/A6moairXeSxW8wxQJ8yt+D2EwscGxLo3ku6ph8ISut0pYDZmca3iA9jJbZZp0PPR30NkwhKmpo=
X-Received: by 2002:a17:90a:ba97:b0:1ef:91ab:de1e with SMTP id
 t23-20020a17090aba9700b001ef91abde1emr4998824pjr.237.1657639535861; Tue, 12
 Jul 2022 08:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz> <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com> <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com> <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
In-Reply-To: <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Jul 2022 08:25:24 -0700
Message-ID: <CALvZod460hip0mQouEVtfcOZ0M21Xmzaa-atxxrUnR3ZisDCNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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

CCing Yosry, Muchun & Johannes

On Tue, Jul 12, 2022 at 2:52 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 12-07-22 16:39:48, Yafang Shao wrote:
> > On Tue, Jul 12, 2022 at 3:40 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > > Roman already sent reparenting fix:
> > > > https://patchwork.kernel.org/project/netdevbpf/patch/20220711162827.184743-1-roman.gushchin@linux.dev/
> > >
> > > Reparenting is nice but not a silver bullet. Consider a shallow
> > > hierarchy where the charging happens in the first level under the root
> > > memcg. Reparenting to the root is just pushing everything under the
> > > system resources category.
> > >
> >
> > Agreed. That's why I don't like reparenting.
> > Reparenting just reparent the charged pages and then redirect the new
> > charge, but can't reparents the 'limit' of the original memcg.
> > So it is a risk if the original memcg is still being charged. We have
> > to forbid the destruction of the original memcg.
>
> yes, I was toying with an idea like that. I guess we really want a
> measure to keep cgroups around if they are bound to a resource which is
> sticky itself. I am not sure how many other resources like BPF (aka
> module like) we already do charge for memcg but considering the
> potential memory consumption just reparenting will not help in general
> case I am afraid.

Another very obvious example is the filesystem shared between multiple
jobs. We had a similar discussion [1] on LRU reparenting patch series.

For this use-case internally we have a memcg= mount option where the
given memcg is the common ancestor (think of pod in k8s environment)
of the jobs who are sharing the filesystem.

[1] https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@bytedance.com/
