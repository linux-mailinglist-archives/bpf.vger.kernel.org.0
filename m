Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE6B606D6A
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 04:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJUCKM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 22:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUCKK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 22:10:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35840E22C1
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 19:10:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id j14so1815266ljh.12
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 19:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NK0IM2l0z+MD1pPwtNnJFIyTJt3H3WiqdvqNACGjOsk=;
        b=nul8qmg3hSPOe+UDepO0JAulRIWJF5kNehWnFdDiuzfdZTg2exDDNfNkaWmSPEE/Wy
         2zgxpgRFWg7j4lAPHgAkHQ8oDC1IpZz1ZjoTgXL67rw0b/tLWa243J0xy2hjkiuPjcZY
         YjT/ODygibHQoHcB3BtxgWlMJmJerFMxGGi1QUqW1f25D9UBaVekcULx1g00ipBb1faK
         zKTWCm46kTUcMR8IdsUQMeFZDN+Vp7tF6Y+YzIiTG18WRSicueGrLkfxTU+FVyAQ518d
         smpa8GZJhMHTEnVK2lAlapw/1UcnOygBs8sYcLp8AVyN1BupThO1/MXTIbSrSlE5TY/J
         5oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK0IM2l0z+MD1pPwtNnJFIyTJt3H3WiqdvqNACGjOsk=;
        b=NIYuIV3gkpkb7NUk5eCPHyeagKQi5DRLjR8qrPHowpxeAmacp2QxVMRYnj+b4PMjEk
         FpcDvv6AN/ecl7WJ9JlUg9j5HmUDOhXWEQv5/1m/l44tYfQYzICiv/HQM26U6JDeSuhY
         iZcU3WvyWcalk5J0fcllN21YhPOYvuoaKRFIHMNbX2GDbGTLTtmEg33kQ0JSC5BGfxg+
         MS5Jz1DU4PhlkE3EDLg5TkHnI225r7UDNHq97wW+M9ZK0rEmCrmOP8P4YF2SUqwG1OYe
         JO3K30/7uOFDJTtjMduPK0JOkCpnBrLM9Ya+sjb1x9Q5L3oDYWDUQsrfHjJJQn+YJieI
         PiYA==
X-Gm-Message-State: ACrzQf3EvQbXp3zscPiifd36ylqst1NeIh3tKPrZujsJ7bzfTp+Y+M5j
        LP0j3jjvi5GZyr+5okT45E0Fc8RI+vc8DmdPB0BzcLh1
X-Google-Smtp-Source: AMsMyM4B2+qHy29fHV5YPGtaCfp/g8DAUEuwza83oH+JPMzUtVM4V3WOI8SUCfV3y0iER+IJmVKQ5vXrLMoCQHbpIB4=
X-Received: by 2002:a17:907:16a6:b0:78e:f140:a9b9 with SMTP id
 hc38-20020a17090716a600b0078ef140a9b9mr13485514ejc.502.1666318196632; Thu, 20
 Oct 2022 19:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221020142247.1682009-1-houtao@huaweicloud.com>
 <CA+khW7jE_inL9-66Cb_WAPey6YkY+yf1H+q2uASTQujNXbRF=Q@mail.gmail.com>
 <212fbd46-7371-c3f9-e900-3a49d9fafab8@huaweicloud.com> <20221021014807.pvjppg433lucybui@macbook-pro-4.dhcp.thefacebook.com>
 <b20aa49f-61ee-6275-3f8b-aa2b5e950874@huaweicloud.com>
In-Reply-To: <b20aa49f-61ee-6275-3f8b-aa2b5e950874@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Oct 2022 19:09:45 -0700
Message-ID: <CAADnVQJXdFsPXSQBhD9WD_66bWaGyq1x_=SY5UiFGzUqm=34Dg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Support for setting numa node in bpf memory allocator
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 7:06 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 10/21/2022 9:48 AM, Alexei Starovoitov wrote:
> > On Fri, Oct 21, 2022 at 09:43:08AM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 10/21/2022 2:01 AM, Hao Luo wrote:
> >>> On Thu, Oct 20, 2022 at 6:57 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >>>> From: Hou Tao <houtao1@huawei.com>
> >>>>
> >>>> Since commit fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc."),
> >>>> numa node setting for non-preallocated hash table is ignored. The reason
> >>>> is that bpf memory allocator only supports NUMA_NO_NODE, but it seems it
> >>>> is trivial to support numa node setting for bpf memory allocator.
> >>>>
> >>>> So adding support for setting numa node in bpf memory allocator and
> >>>> updating hash map accordingly.
> >>>>
> >>>> Fixes: fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc.")
> >>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>>> ---
> SNIP
> >> How about the following comments ?
> >>
> >>  * For per-cpu allocator (percpu=true), the only valid value of numa_node is
> >>  * NUMA_NO_NODE. For non-per-cpu allocator, if numa_node is NUMA_NO_NODE, the
> >>  * preferred memory allocation node is the numa node where the allocating CPU
> >>  * is located, else the preferred node is the specified numa_node.
> > No. This patch doesn't make sense to me.
> > As far as I can see it can only make things worse.
> > Why would you want a cpu to use non local memory?
> For pre-allocated hash table, the numa node setting is honored. And I think the
> reason is that there are bpf progs which are pinned on specific CPUs or numa
> nodes and accessing local memory will be good for performance.

prealloc happens at map creation time while
bpf prog might be running on completely different cpu,
so numa is necessary for prealloc.

> And in my
> understanding, the bpf memory allocator is trying to replace pre-allocated hash
> table to save memory, if the numa node setting is ignored, the above use cases
> may be work badly. Also I am trying to test whether or not there is visible
> performance improvement for the above assumed use case.

numa should be ignored, because we don't want users to accidently
pick wrong numa id.

> >
> > The commit log:
> > " is that bpf memory allocator only supports NUMA_NO_NODE, but it seems it
> >   is trivial to support numa node setting for bpf memory allocator."
> > got it wrong.
> >
> > See the existing comment:
> >                 /* irq_work runs on this cpu and kmalloc will allocate
> >                  * from the current numa node which is what we want here.
> >                  */
> >                 alloc_bulk(c, c->batch, NUMA_NO_NODE);
>
