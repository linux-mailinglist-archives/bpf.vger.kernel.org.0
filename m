Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D911457381C
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 15:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiGMN4s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 09:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiGMN4s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 09:56:48 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2142CE1B
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 06:56:47 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 125so4122137vsx.7
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmR3zIvPRcGHZ+9uuqzqrigy1eQiGWgglnEUCHnLRTw=;
        b=jqvCG36YrXa31HLHjFghK3hWp0U+tkXHjZdVEW4qnG45XLWlagRu0xQKCjI0TngXbX
         AhRqFz9i5hqrgoItpzy5asLZ4OkuTJ/jv5kuLXQEStM+aRGj1tF6cPnNvlPuQaWoBNZz
         9gSfYBUqj4CU/It7BSTtoz22Pq2NuMdU+5rrVmAUNcDmPzDe96aReqXEWfUQT+Dzt0Iv
         2W182CxYF1CAYX+jMbgQKDM7K35d35qedLTEQjd5D/5ScAL/kAve91pXJcs5XRHBkR0Z
         NOxmxUPeMrcd6MWG4a5/aPwYC7eiSZYZA3G96sOyEpBzr8xIpc64EHNFaExxN1cMzYTf
         p4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmR3zIvPRcGHZ+9uuqzqrigy1eQiGWgglnEUCHnLRTw=;
        b=tRkOHWmGD+0tpJJvJwGhPI+1zOll18ZU62HoFueQrf58nbL5W4Op9ZDpjsAaw5Qhl6
         pegMzcZ2UKCbDTlcmVVlpwpYEyNsL/FCgS76Q8VeYyHrG+9LCjx7MYBTTDJIg5bTWgF5
         Cx5i0jijkDUQzOcrKI5Tw504G0Hw+8md0bFqU2F9086h18KkRGsfQj6gzh3EohKUHkcE
         /YJzabGnBwday7cSWlaSna56YMK8MY7GXrYJ9g5dZ286BQpxIADmjj9YKXm3VZ0BMLsk
         +/+xAPk4w3nNBD/W0r1hkXxYwW1g4Q7LowwbsU8CvlBjVB2skYK9xXYpvnRWzdgmjG8z
         q6Ow==
X-Gm-Message-State: AJIora8G1atfW794RHgeVTxaLj4Tc1PbnpwLV4yQ0hqAzHNJuwIBxGpt
        dfxJIzpjMQmaWg/5WeUrGHnqdqAtZRTQHwtJjCw=
X-Google-Smtp-Source: AGRyM1vjlYSXh2tsTBxNP1Xah71beC6fLMhLz1iiDXJ/EgZ1xZenJyUAOLTOoUvFkZwImz3TM/auk9bJ1jlWzbz6SbI=
X-Received: by 2002:a05:6102:7b2:b0:357:6ab5:e1a5 with SMTP id
 x18-20020a05610207b200b003576ab5e1a5mr1432091vsg.22.1657720606255; Wed, 13
 Jul 2022 06:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <YswUS/5nbYb8nt6d@dhcp22.suse.cz> <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <CALvZod460hip0mQouEVtfcOZ0M21Xmzaa-atxxrUnR3ZisDCNw@mail.gmail.com>
 <Ys2iIVMZJNPe73MI@slm.duckdns.org> <CALvZod7YKrTvh-5SkDgFvtRk=DkxQ8iEhRGhDhhRGBXmYM4sFw@mail.gmail.com>
 <Ys2xGe+rdviCAjsC@slm.duckdns.org> <CALvZod6Y3p1NZwSQe6+UWpY88iaOBrZXS5c5+uzMb+9sY1ziwg@mail.gmail.com>
 <20220712184315.k6tteikog7pze5z2@MacBook-Pro-3.local.dhcp.thefacebook.com>
In-Reply-To: <20220712184315.k6tteikog7pze5z2@MacBook-Pro-3.local.dhcp.thefacebook.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 13 Jul 2022 21:56:09 +0800
Message-ID: <CALOAHbD9hTDy1jgE_oD1OwNC_1HnR4TxAAUVU5u0HWJ7COLoKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 2:43 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 12, 2022 at 11:11:25AM -0700, Shakeel Butt wrote:
> > Ccing Mina who actually worked on upstreaming this. See [1] for
> > previous discussion and more use-cases.
> >
> > [1] https://lore.kernel.org/linux-mm/20211120045011.3074840-1-almasrymina@google.com/
>
> Doesn't look like that it landed upstream?
>
> For bpf side we're thinking of something similar.
> We cannot do memcg= mount option, of course.
> Instead memcg path or FD will passed to bpf side to be used later.
> So the user can select a memcg instead of taking it from current.
>
> Yafang,
> I'm assuming you're working on something like this?

Yes, I'm working on it. I will post it once it is ready, but probably
not shortly.

-- 
Regards
Yafang
