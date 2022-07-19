Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F384157A784
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 21:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiGSTyS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 15:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGSTyR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 15:54:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD352E58
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:54:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d7-20020a17090a564700b001f209736b89so35474pji.0
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HZeKwLihEEt8Gb01cRA+F22Oe66cky6WGiN3/LkMvdM=;
        b=SqyAuePLHE8SDIZJ3Nm/v9EV8krbC81ZNmrSMnDfT4xydCrWNyl/4+unSC5Ask4Akt
         n16eU7j8Blg6jqKy9DU/xH/U1dxFTnBySPDDNXSxXehQJRJLJ5+PNFYavMnnipRIpmDa
         XpEBTf+uNYONzesS19OnuwlA7JBL3A0EnVIdP+0+xkjXrzDGSUV3VreDnZEaM3gyT4nJ
         Dg5NkFhFnta01uGUUA22G98J6Fq3VbzSTsUWTPO4ZHSQHi4ThWs+m0RKcbtxez2Lba4B
         7U7o3WSN0PePBXQCv912BJPJINrhyDluIjnFIKnD0WppHImvNvvcBMdktiS0Nz96gzy7
         4ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HZeKwLihEEt8Gb01cRA+F22Oe66cky6WGiN3/LkMvdM=;
        b=d4mwu4qSnSWS40deQIt6o4QJuru1d7LSwq6XwOoSMNyoMbNCc3yzLb7BkkqDiVAmNI
         3d9EANIDco3kh4gnSVwPOZDmuRhPje+V3gK/mARNMf17cEWXHEP6RFoiW1Wkrb0YM98a
         7zOh6487QUuhyNjEN5DCLendKuVdZY7g3eWNiSsaqn8T2Ntcs6tt0q3fm01DQ2rDIV9T
         iMqzfwdLW6AaGtZpFw6lfb3c8nm31tuZOtSchnNQMkG2YGx9mUtXkDe75g0uhqMx3ljh
         JXJh39qwKwoqV/w7Xp283AkootZuKmSNPTEdqsFYpwe0u/aQHjcDdGwOsLDfkLpT2S5j
         Y85g==
X-Gm-Message-State: AJIora//xPhTmSZNi4SH6UiOgMgF99iwdQVmcHgNmDErBE3kbmB0iQl4
        Oke0K+u5i9K1jRPBENeuUVj5j1upBtU=
X-Google-Smtp-Source: AGRyM1u6OR+3VxsW2ww3rLIXuKixdZTEWQ7s9wEuuiUCiIIMIErVMkNlFHdnYIDYYF4ueT3n6i2WOA==
X-Received: by 2002:a17:90b:4c4e:b0:1f0:48e7:7258 with SMTP id np14-20020a17090b4c4e00b001f048e77258mr1091191pjb.223.1658260455565;
        Tue, 19 Jul 2022 12:54:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f3dd])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902a38900b0016c0c82e85csm12065497pla.75.2022.07.19.12.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 12:54:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Jul 2022 09:54:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
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
Subject: Re: cgroup specific sticky resources (was: Re: [PATCH bpf-next 0/5]
 bpf: BPF specific memory allocator.)
Message-ID: <YtcL5Sb0Nu1DCfrv@slm.duckdns.org>
References: <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
 <Ys4wRqCWrV1WeeWp@castle>
 <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
 <YtaV6byXRFB6QG6t@dhcp22.suse.cz>
 <CAJD7tkbieq_vDxwnkk_jTYz9Fe1t5AMY6b3Q=8O-ag9YLo9uZg@mail.gmail.com>
 <CAHS8izP-Ao7pYgHOuQ-8oE2f_xe1+tP6TQivDYovEOt+=_QC7Q@mail.gmail.com>
 <YtcDEpaHniDeN7fP@slm.duckdns.org>
 <CAJD7tkZkFnVqjkdOK3Wf8f1o3XmMWCmWkzHNQKh8Znh5dDF27w@mail.gmail.com>
 <YtcIJClKxUPntdM9@slm.duckdns.org>
 <CAHS8izOrGBLUGDAo0_7Y0_7y4+2BusFeqOMkxwbXUSvMTvTGDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izOrGBLUGDAo0_7Y0_7y4+2BusFeqOMkxwbXUSvMTvTGDQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Tue, Jul 19, 2022 at 12:47:39PM -0700, Mina Almasry wrote:
> Hmm, sorry I might be missing something but I don't think we have the
> same thing in mind?
> 
> My understanding is that the sysadmin can do something like this which
> is relatively inexpensive to implement in the kernel:
> 
> 
> mount -t tmpfs /mnt/mymountpoint
> echo "/mnt/mymountpoint" > /path/to/cgroup/cgroup.charge_for.tmpfs
> 
> 
> At that point all tmpfs charges for this tmpfs are directed to
> /path/to/cgroup/memory.current.
> 
> Then the sysadmin can do something like:
> 
> 
> echo "/mnt/mymountpoint" > /path/to/cgroup2/cgroup.charge_for.tmpfs
> 
> 
> At that point all _future_ charges of that tmpfs will go to
> cgroup2/memory.current. All existing charges remain at
> cgroup/memory.current and get uncharged from there. Per my
> understanding there is no need to move all the _existing_ charges from
> cgroup/memory.current to cgroup2/memory.current.

So, it's a lot better if the existing charges aren't moved around but it's
also kinda confusing if something can be moved around the tree arbitrarily
leaving charges behind. We already do get that from moving processes around
but most common usages are pretty static at this point and I think it'd be
better to avoid expanding the interface in that direction.

I'd much prefer something alont the line of `mount -t tmpfs -o cgroup=XXX`
where the tmpfs code checks whether the specified cgroup is one of the
ancestors and the mounting task has enough permission to shift the resource
there.

Thanks.

-- 
tejun
