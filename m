Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085D0572375
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiGLStA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 14:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiGLSru (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 14:47:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944FCDE9CB
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:43:23 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r186so1151503pgr.2
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R/FYk9tPIDTawZE5OMd3QkyOPq+WSwEVrCOp+DVVU6c=;
        b=qdX8b8ZVZFH5ZQSgkvqaTXIu70J243GRuhnr8uGQFTjkdH+BzB+BAemU5hTnweGM9L
         uB8v59IjCjRxNJbI5Tkh4G1yE3BLombREzVoK70QB/WeQEJSgtxu8YQBp3xIkSj9C/Km
         LfpbbxAtKCxkDk1BQdbatn7rY4cKjIIrgbE/S3riaICmK8bA8n4+IzsFRHp6xkMubDbF
         giIkHPAXwvzjbGBUdI31FyfQakoXKh3xDbVU8T7KAviaqDX3bcPAcPA8bUB00p/fvQ6M
         Y0pjgRZfMCrPSc7CNFKU8Zx9kXRkKqhM9Ghc8dlr0s9ZUwqOx0gpKg2tyys1YMon5h3M
         OHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/FYk9tPIDTawZE5OMd3QkyOPq+WSwEVrCOp+DVVU6c=;
        b=DX6sD5TtSEfMjOjuQXm3xC73OPt5+r5kjfnAFkPXGqzZVY7kOADV1sRUhG/t9MwF7k
         zKVDklPftIsMOdtcsb8Tm0OvDcwl75u3Sek4YWnxvAM3bSYQVMq98/RwCGK5VQ0jrP7+
         QEEDPxil6kOBSLyfPDSvDQZVmgLNPMujhSWDoMkyQ9FEKQWcGQEz70qTJ4mkehDcti+5
         3zh2/s3jJek8hzD4MJlElQ+bZ6R9NRJzTCA/duwheEwXz6MccZpTrRgIk7hso+6WwNvu
         Ez8WuHL3G+kwnU+Lwit2hAYfpHXs8de34JB1UYfok+zC3b3s8X28xl8u7MLbfwzILXlp
         aOmw==
X-Gm-Message-State: AJIora/2DOmxU/PtwH/WnH+DvNzXFz3xQdIMCKnaYrhb/5jI6z/iEMLM
        eq95aqV/eOiK0fMNUglOvUY=
X-Google-Smtp-Source: AGRyM1vLmTbLA9Pi+aqc4f3ziiLI1ftifRlTCsgTGZoBsVYKOchZTAKd90hmAxNo+LXdxgdFRSEotQ==
X-Received: by 2002:a63:e955:0:b0:419:66f8:e331 with SMTP id q21-20020a63e955000000b0041966f8e331mr3323638pgj.585.1657651399424;
        Tue, 12 Jul 2022 11:43:19 -0700 (PDT)
Received: from MacBook-Pro-3.local.dhcp.thefacebook.com ([2620:10d:c090:500::2:8800])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b001618b70dcc9sm7231815plg.101.2022.07.12.11.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 11:43:18 -0700 (PDT)
Date:   Tue, 12 Jul 2022 11:43:15 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yafang Shao <laoar.shao@gmail.com>,
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
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <20220712184315.k6tteikog7pze5z2@MacBook-Pro-3.local.dhcp.thefacebook.com>
References: <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
 <CALvZod460hip0mQouEVtfcOZ0M21Xmzaa-atxxrUnR3ZisDCNw@mail.gmail.com>
 <Ys2iIVMZJNPe73MI@slm.duckdns.org>
 <CALvZod7YKrTvh-5SkDgFvtRk=DkxQ8iEhRGhDhhRGBXmYM4sFw@mail.gmail.com>
 <Ys2xGe+rdviCAjsC@slm.duckdns.org>
 <CALvZod6Y3p1NZwSQe6+UWpY88iaOBrZXS5c5+uzMb+9sY1ziwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6Y3p1NZwSQe6+UWpY88iaOBrZXS5c5+uzMb+9sY1ziwg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 11:11:25AM -0700, Shakeel Butt wrote:
> Ccing Mina who actually worked on upstreaming this. See [1] for
> previous discussion and more use-cases.
> 
> [1] https://lore.kernel.org/linux-mm/20211120045011.3074840-1-almasrymina@google.com/

Doesn't look like that it landed upstream?

For bpf side we're thinking of something similar.
We cannot do memcg= mount option, of course.
Instead memcg path or FD will passed to bpf side to be used later.
So the user can select a memcg instead of taking it from current.

Yafang,
I'm assuming you're working on something like this?
