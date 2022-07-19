Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC857A832
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 22:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiGSU3T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGSU3S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 16:29:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74875018E
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:29:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s27so14490557pga.13
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E7QI4chrb95A+lfqDE3Gr++Mecj38UYUtwYRCtLQ3Io=;
        b=dDASEWftANcWPA68mA6v9t1UAwvek58z7jMRi32IoZbby1X+Ge2rZMPmQy5K4zw/tP
         v4jT+6qFRjFOjZ8xaFECgczQcG380/atE2VdNllR6/TIP30/He7eiY0SlFdHSTLPFgv2
         XXIFhjY6ypfsXS7U9eH2/vFfXhXMJkIOTHFeQqoGVre7y197zejpoTEnYrmAM4Jl+Vz1
         5bQhTNWY2sT28eXX/7K3Ropv2nsAhL0L6o7nYviRWxO75IKkctCB1ZcHLKUFlm9weIal
         /yqS7FeGiNq7ELDMMiGMyys5Edfrxk7LF8QMXDQUXgejbWMa64RFdifPiz17YJgM8iOv
         wixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=E7QI4chrb95A+lfqDE3Gr++Mecj38UYUtwYRCtLQ3Io=;
        b=xI4kg1WiUEHTB4or0Uhzi/4UADJqLm9ahf489zJDxgbcFzANumrsPRylZ2PaSTw2b7
         3hHkEJbRGvIPwxuiwKMMZWXA4vr8DbOIweVLh/vSri0yc7yBTTcok646ZxVufJnH9EaV
         ph6iLYDmNskGV6ZytEsYNcemp7K4LbC0hpJCpLDChlwiczEX3MsCXXtqTVReBNEc8ZS7
         nnWRnLiXxXMA/cLAd9+jW8ejZUvkyacJXOBpRLTenUB7ZYDggti8sfhbJbB1k3UYQcP4
         hQ8L+4yJT2I529wLCcNVuf8wd5knY4nYuLhIuKnGwIW0o/zWp7x44yzWuSyxyNWS2nuy
         i5jw==
X-Gm-Message-State: AJIora+D+TB0eWnJetUG6rb+mgTgapc7sC7km5Q8aBXf+6Y2LYHdwrO1
        dgSlEA8eM0FKWG4xGRPXilU=
X-Google-Smtp-Source: AGRyM1sZjD4k7AvJtFCsSvkiTX9qTMF2ZL+c8xxKL/W6LyQYixrn9npsVnYmKKKjYEB2Vd/6fDxOPw==
X-Received: by 2002:a63:6:0:b0:419:7b89:69ff with SMTP id 6-20020a630006000000b004197b8969ffmr30273431pga.442.1658262557178;
        Tue, 19 Jul 2022 13:29:17 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f3dd])
        by smtp.gmail.com with ESMTPSA id x126-20020a623184000000b0052b8240840dsm3381912pfx.145.2022.07.19.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:29:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Jul 2022 10:29:14 -1000
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
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: cgroup specific sticky resources (was: Re: [PATCH bpf-next 0/5]
 bpf: BPF specific memory allocator.)
Message-ID: <YtcUGom4GkNzVamP@slm.duckdns.org>
References: <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
 <YtaV6byXRFB6QG6t@dhcp22.suse.cz>
 <CAJD7tkbieq_vDxwnkk_jTYz9Fe1t5AMY6b3Q=8O-ag9YLo9uZg@mail.gmail.com>
 <CAHS8izP-Ao7pYgHOuQ-8oE2f_xe1+tP6TQivDYovEOt+=_QC7Q@mail.gmail.com>
 <YtcDEpaHniDeN7fP@slm.duckdns.org>
 <CAJD7tkZkFnVqjkdOK3Wf8f1o3XmMWCmWkzHNQKh8Znh5dDF27w@mail.gmail.com>
 <YtcIJClKxUPntdM9@slm.duckdns.org>
 <CAHS8izOrGBLUGDAo0_7Y0_7y4+2BusFeqOMkxwbXUSvMTvTGDQ@mail.gmail.com>
 <YtcL5Sb0Nu1DCfrv@slm.duckdns.org>
 <CAHS8izP4qd0vv3mmgVHu+Dxrimv3cegG-DCgDp+=bK60O0oaYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izP4qd0vv3mmgVHu+Dxrimv3cegG-DCgDp+=bK60O0oaYQ@mail.gmail.com>
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

On Tue, Jul 19, 2022 at 01:16:02PM -0700, Mina Almasry wrote:
> I think I'm flexible in this sense. Would you like the kernel to
> prevent reattaching the tmpfs to a different cgroup? To be honest we
> have a use case for that, but I'm not going to die on this hill. I
> guess the worst case scenario is that I can carry a local patch on our
> kernel which allows reattaching to a different cgroup and directs
> future charges there...

If it's not gonna be dynamic, putting it in a writable cgroupfs file feels
awakard to me, prone to creating incorrect expectations.

> > I'd much prefer something alont the line of `mount -t tmpfs -o cgroup=XXX`
> > where the tmpfs code checks whether the specified cgroup is one of the
> > ancestors and the mounting task has enough permission to shift the resource
> > there.
> 
> Actually this is pretty much the same interface I opted for in my
> original proposal (except I named it memcg= rather than cgroup=):
> https://lore.kernel.org/linux-mm/20211120045011.3074840-1-almasrymina@google.com/

Right. Hmm... the discussion w/ Johannes didn't seem to have concluded, so
continue that here, I guess?

If the consensus becomes that we want to allow charging resources to an
ancestor, I like the the mount option interface a lot more than other
proposals.

> Curious, why do we need to check if the cgroup= is an ancestor? We
> actually do have a use case where the cgroups are unrelated and the
> common ancestor is root. Again, I'm not sure I want to die on this
> hill. At worst I can remove the restriction in a local patch for our
> kernel again...

First of all, permission doesn't capture the whole picture due to delegation
boundaries. Maybe we can use the same perm check as delegation checks but
keeping it inside the subtree seems simpler and less confusing to me. We can
always relax if necessary in the future.

Thanks.

-- 
tejun
