Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462BA56CDA5
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 09:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGJHcS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 03:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJHcR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 03:32:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D1192B5
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 00:32:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y4-20020a25b9c4000000b0066e573fb0fcso1819227ybj.21
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 00:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t63gxYnqY/rj0/phOitCSls/u6CQ33pwzplOgpHsAMw=;
        b=cTG7s5oMvKi7QSlGJ2IX8pYkdKBeptl+8VdN7wNuA3+aH37jAtdCIPOF48MzVQviLx
         lBpu7xwlCKFit1y/WqWGsCvR9Iq3kz5GH5ZU8OQp/zzqJp8j7oEA9HuThJXpeDzhA30z
         sBZ06gix0dShKw/MmJCd9ViXt5YdX6FwstXF0a9j3/B0LBa/J6ZNlvo3061PQkAhM29Q
         ghRpgj6ASJsG2mFwwkr2EPVjOs1hP+eedV1hSI33dNE0TscWNp/5lkibmchC9LZt+D7S
         p+M7qePv1h7A1vdjg4G8FZJLCzRKNdbN+p7Wv0TDnzrbr5zvWIyS9/eBhSDHtyoWpefC
         ghvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t63gxYnqY/rj0/phOitCSls/u6CQ33pwzplOgpHsAMw=;
        b=nfPT1UXrZXhoyTRzkXqPZWxcNRJYRHaQbSbADjibIEIV1rel5QzBFUjRm9soFMcPnS
         vcCih1Ryvogddsqk5T93DQrqR3Mkx3YliERmYPMv5ZMsDYIdidqAs5HCbKMGJc6YNC3k
         U3q2VvjVzj4RYJspphUtosiGclRFzZOopqYXKbvOLeOXi6WdhPD6YTrvlcnqZ+WbQajA
         ufnkXgq0ALkX6oAvIvKUpKjmxXyyVCzLbdZprnh3uM3z3zUBpuadzrnCNrZnPLMl+y6J
         nZih7uJ65mYRxzncbVX5t83BF+oBiLwhzsoOWnFy1vVz5yWMNTneLnDRb9HvgZLUAI8m
         uO3g==
X-Gm-Message-State: AJIora+Q7YZN6iEMxCDouiTq5BfFeFv2UMRkUtTnr0BTSlsBqOdOZXPc
        j22sNwwXrkj3MLXAwtH3jNruBeysXeTybw==
X-Google-Smtp-Source: AGRyM1ueExjOAIzVciXYEJOOM29pcwMojuHNMU+0gy8kDJxdOmyE4lDkeXYQrZDpOfOH7E1BKHqmu7ycpy2t0A==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:3bd3:0:b0:66e:2e5c:5415 with SMTP id
 i202-20020a253bd3000000b0066e2e5c5415mr11899313yba.76.1657438335879; Sun, 10
 Jul 2022 00:32:15 -0700 (PDT)
Date:   Sun, 10 Jul 2022 07:32:13 +0000
In-Reply-To: <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
Message-Id: <20220710073213.bkkdweiqrlnr35sv@google.com>
Mime-Version: 1.0
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org> <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local> <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz> <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com> <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
From:   Shakeel Butt <shakeelb@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 09, 2022 at 10:26:23PM -0700, Alexei Starovoitov wrote:
> On Fri, Jul 8, 2022 at 2:55 PM Shakeel Butt <shakeelb@google.com> wrote:
[...]
> >
> > Most probably Michal's comment was on free objects sitting in the caches
> > (also pointed out by Yosry). Should we drain them on memory pressure /
> > OOM or should we ignore them as the amount of memory is not significant?
> 
> Are you suggesting to design a shrinker for 0.01% of the memory
> consumed by bpf?

No, just claim that the memory sitting on such caches is insignificant.
