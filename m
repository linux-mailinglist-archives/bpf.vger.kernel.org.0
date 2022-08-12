Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C755913CC
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 18:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbiHLQVK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbiHLQVJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 12:21:09 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBE46A4A5;
        Fri, 12 Aug 2022 09:21:05 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id d1so984155qvs.0;
        Fri, 12 Aug 2022 09:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9OfqdCuCD+UHa5XcQtfGcHPlewQVHBoItXj9iDTx07U=;
        b=eN5ZJpE/aJiYenhpIbXugD1iCuui1hI4excylgfsdztoOGgAvIudDKqlvOjYagNkJd
         0Ke7/txIw6D1EdezXkazuZV9Si+2BaWCNlq5sI2ivd/fLI0flPHR5390bff0XXv84rbZ
         KyWY3P2pZ5yaKAxx5N56QXc2ubwhJJlfEz8Kose6hujfazrv5rQguS/FE0Seu+K8CdX0
         mlFVWhiF/9AQnNUG4mkefNBRF3mpfTAQK8EYdTo/6/O8TIpCl2Si5O3t23X/qr21qH9l
         5WLoh/5Ffb+ftxBNmpArSsbAH8JcBR6CLEzOfkwXIxMQAlD+jLVn8jEp28PNo0Tvy4bH
         UAjw==
X-Gm-Message-State: ACgBeo0hlUVkPzNYZKdQJRkhsk9MlJRk5KNc5b9geAkrOqCD1BFhu5Yt
        h7jVlGHBA+SePgCbiZPWH/A=
X-Google-Smtp-Source: AA6agR7Sa3C/LHf+RQuDW7RRH8XzGb3vvnkmOVwBO+STOObVOemEXGttCIQOIPg1O639hfixD4BNew==
X-Received: by 2002:a0c:ab17:0:b0:474:8a27:ed53 with SMTP id h23-20020a0cab17000000b004748a27ed53mr4089040qvb.56.1660321264457;
        Fri, 12 Aug 2022 09:21:04 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::9c4])
        by smtp.gmail.com with ESMTPSA id 20-20020a370914000000b006b8d1914504sm1880095qkj.22.2022.08.12.09.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 09:21:04 -0700 (PDT)
Date:   Fri, 12 Aug 2022 11:21:01 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH 2/5] bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
Message-ID: <YvZ97XQNRvvA00Xx@maniforge.dhcp.thefacebook.com>
References: <20220808155341.2479054-1-void@manifault.com>
 <20220808155341.2479054-2-void@manifault.com>
 <CAEf4BzbGEQ9rMHBaiex2wPEB2cOMXFNydpPUutko6P7UCK-UyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbGEQ9rMHBaiex2wPEB2cOMXFNydpPUutko6P7UCK-UyQ@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 11, 2022 at 04:22:50PM -0700, Andrii Nakryiko wrote:
> On Mon, Aug 8, 2022 at 8:54 AM David Vernet <void@manifault.com> wrote:
> >
> > We want to support a ringbuf map type where samples are published from
> > user-space to BPF programs. BPF currently supports a kernel -> user-space
> > circular ringbuffer via the BPF_MAP_TYPE_RINGBUF map type. We'll need to
> > define a new map type for user-space -> kernel, as none of the helpers
> > exported for BPF_MAP_TYPE_RINGBUF will apply to a user-space producer
> > ringbuffer, and we'll want to add one or more helper functions that would
> > not apply for a kernel-producer ringbuffer.
> >
> > This patch therefore adds a new BPF_MAP_TYPE_USER_RINGBUF map type
> > definition. The map type is useless in its current form, as there is no way
> > to access or use it for anything until we add more BPF helpers. A follow-on
> > patch will therefore add a new helper function that allows BPF programs to
> > run callbacks on samples that are published to the ringbuffer.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> >  include/linux/bpf_types.h      |  1 +
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/ringbuf.c           | 70 +++++++++++++++++++++++++++++-----
> >  kernel/bpf/verifier.c          |  3 ++
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  tools/lib/bpf/libbpf.c         |  1 +
> >  6 files changed, 68 insertions(+), 9 deletions(-)
> >
> 
> [...]
> 
> >
> > -static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
> > +static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma,
> > +                           bool kernel_producer)
> >  {
> >         struct bpf_ringbuf_map *rb_map;
> >
> >         rb_map = container_of(map, struct bpf_ringbuf_map, map);
> >
> >         if (vma->vm_flags & VM_WRITE) {
> > -               /* allow writable mapping for the consumer_pos only */
> > -               if (vma->vm_pgoff != 0 || vma->vm_end - vma->vm_start != PAGE_SIZE)
> > +               if (kernel_producer) {
> > +                       /* allow writable mapping for the consumer_pos only */
> > +                       if (vma->vm_pgoff != 0 || vma->vm_end - vma->vm_start != PAGE_SIZE)
> > +                               return -EPERM;
> > +               /* For user ringbufs, disallow writable mappings to the
> > +                * consumer pointer, and allow writable mappings to both the
> > +                * producer position, and the ring buffer data itself.
> > +                */
> > +               } else if (vma->vm_pgoff == 0)
> >                         return -EPERM;
> 
> the asymmetrical use of {} in one if branch and not using them in
> another is extremely confusing, please don't do that

Ah, sorry, I misread the style guide and thought this was stipulated there,
but I now see that it's explicitly stated that you should include a brace
if only one branch is in a single statement. I'll fix this (by splitting
these into their own implementations, as mentioned below).

> the way you put big comment inside the wrong if branch also throws me
> off, maybe move it before return -EPERM instead with proper
> indentation?

Yeah, fair enough.

> sorry for nitpicks, but I've been stuck for a few minutes trying to
> figure out what exactly is happening here :)

Not a problem at all, sorry for the less-than-readable code.

> >         } else {
> >                 vma->vm_flags &= ~VM_MAYWRITE;
> > @@ -242,6 +271,16 @@ static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
> >                                    vma->vm_pgoff + RINGBUF_PGOFF);
> >  }
> >
> > +static int ringbuf_map_mmap_kern(struct bpf_map *map, struct vm_area_struct *vma)
> > +{
> > +       return ringbuf_map_mmap(map, vma, true);
> > +}
> > +
> > +static int ringbuf_map_mmap_user(struct bpf_map *map, struct vm_area_struct *vma)
> > +{
> > +       return ringbuf_map_mmap(map, vma, false);
> > +}
> 
> I wouldn't mind if you just have two separate implementations of
> ringbuf_map_mmap for _kern and _user cases, tbh, probably would be
> clearer as well

Yeah, I can do this. I was trying to avoid any copy-pasta at all cost, but
I think it's doing more harm than good. I'll just split them into totally
separate implementations.

> > +
> >  static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
> >  {
> >         unsigned long cons_pos, prod_pos;
> > @@ -269,7 +308,7 @@ const struct bpf_map_ops ringbuf_map_ops = {
> >         .map_meta_equal = bpf_map_meta_equal,
> >         .map_alloc = ringbuf_map_alloc,
> >         .map_free = ringbuf_map_free,
> > -       .map_mmap = ringbuf_map_mmap,
> > +       .map_mmap = ringbuf_map_mmap_kern,
> >         .map_poll = ringbuf_map_poll,
> >         .map_lookup_elem = ringbuf_map_lookup_elem,
> >         .map_update_elem = ringbuf_map_update_elem,
> > @@ -278,6 +317,19 @@ const struct bpf_map_ops ringbuf_map_ops = {
> >         .map_btf_id = &ringbuf_map_btf_ids[0],
> >  };
> >
> 
> [...]
