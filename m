Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2E619213
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 08:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKDHfI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 03:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKDHfH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 03:35:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FD565D2
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 00:35:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so7018402pjh.1
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2kqD+OfpudX+jIrhWz28KrItqWYasPHYeABrJ0pXbg=;
        b=g8J8+9BUiDjGRHEN4oOsWCwUJhpwkGAKcB8AFuqsNQmZBE2HIg2potFNTw9bqgaYd7
         Cg0fbYdWgOHUDUj9D7x5p5MjtnFSssCV6PCDQSVIznGOOEeQqDqvimIGpVlJIOD7Z7YY
         Flv+rRSxGP5arhaeEMJV1Hwe3H8t7a0dErh5763F4uWyHqMZ1jtxYbmUSbpW/ODJeRt9
         CceenNzNCMgPaWKmlAtpY/xKdA37RKeIjFOWTQ3YIyPrFqZH9kGY1ImQZc44ZiFyj5j0
         zFAsAolell736vGVkPmodLkIFRl9NyS1o6XuZM3ryhSE+XCe8YhdiMcqVsZM7VfqTJcg
         gw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2kqD+OfpudX+jIrhWz28KrItqWYasPHYeABrJ0pXbg=;
        b=dYgRmM4GSvtubEankz28zi+5AHMqBV2jVMg8B/+yxj4XTvdqLGpB5PqlwsNdk2+nTl
         CQ0O08Z4tRG1JAn2RlhLbRswiuyZ2Lnnd6AerTMAc4x6H9qEk720bVn9sH8AJrR6pFGu
         iQ0CCfLRIRvFSybFDmx9iVsieWBiATCFPJli2F0RKy5+CXTTmOSJDgfVQqV9zr5PECGY
         uHTdUG9pGayInz06DwJLwF7MPJHLI33m4SgDmJavARLBgoQu7PBwMYyB+asb+GkoN6Xl
         rPflnGBfWKGb+ZU7u40nN9rWWlZOMbGj7aKGsGSp3Fsz1XEKyPktysRKz7uTCmLSHSX0
         wlaw==
X-Gm-Message-State: ACrzQf35aO9UX43zsle5XFgvzT7V4novsL2u3G58fUjzTnLPqi/110xR
        bxzPlP8jtZdNSkAYAKPIi0U=
X-Google-Smtp-Source: AMsMyM7rZVOtmDBbDpFY/PI849oY8EqEuYtMn2kvwkKWKGD0YPAUUASczzFCpKua9MQH/DpFsjMbBg==
X-Received: by 2002:a17:902:7c12:b0:186:8111:ade2 with SMTP id x18-20020a1709027c1200b001868111ade2mr33899074pll.111.1667547305409;
        Fri, 04 Nov 2022 00:35:05 -0700 (PDT)
Received: from localhost ([157.51.134.255])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0018869119e37sm217171pll.142.2022.11.04.00.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:35:05 -0700 (PDT)
Date:   Fri, 4 Nov 2022 13:04:41 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 06/24] bpf: Refactor kptr_off_tab into
 btf_record
Message-ID: <20221104073200.a4mdg5vamev7s76s@apollo>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-7-memxor@gmail.com>
 <20221104040058.mo4r62wf72clvhcb@macbook-pro-5.dhcp.thefacebook.com>
 <CAADnVQJ1TnKYdJ=--BVAw7Y24rkAohX+4zSYbWc-TjDHWJROvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ1TnKYdJ=--BVAw7Y24rkAohX+4zSYbWc-TjDHWJROvQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 09:39:22AM IST, Alexei Starovoitov wrote:
> On Thu, Nov 3, 2022 at 9:01 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 04, 2022 at 12:39:55AM +0530, Kumar Kartikeya Dwivedi wrote:
> > >
> > > -enum bpf_kptr_type {
> > > -     BPF_KPTR_UNREF,
> > > -     BPF_KPTR_REF,
> > > +enum btf_field_type {
> > > +     BPF_KPTR_UNREF = (1 << 2),
> > > +     BPF_KPTR_REF   = (1 << 3),
> > > +     BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
> > >  };
> >
> > ...
> >
> > > +             for (i = 0; i < sizeof(map->record->field_mask) * 8; i++) {
> > > +                     switch (map->record->field_mask & (1 << i)) {
> > > +                     case 0:
> > > +                             continue;
> > > +                     case BPF_KPTR_UNREF:
> > > +                     case BPF_KPTR_REF:
> > > +                             if (map->map_type != BPF_MAP_TYPE_HASH &&
> > > +                                 map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> > > +                                 map->map_type != BPF_MAP_TYPE_ARRAY &&
> > > +                                 map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
> > > +                                     ret = -EOPNOTSUPP;
> > > +                                     goto free_map_tab;
> > > +                             }
> > > +                             break;
> > > +                     default:
> > > +                             /* Fail if map_type checks are missing for a field type */
> > > +                             ret = -EOPNOTSUPP;
> > > +                             goto free_map_tab;
> > > +                     }
> >
> > With this patch alone this is also wrong.
>
> Actually this bit is probably fine. The bug is elsewhere.
>
> The point below stands:
>
>
> > And it breaks bisect.
> > Please make sure to do a full vmtest.sh for every patch in the series.

I'm sorry. I made multiple small changes to these two and never retested them
again in isolation, and then it was 'fixed' by later changes. I'll make sure it
doesn't happen again.
