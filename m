Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E90573B1D
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiGMQYx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 12:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiGMQYw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 12:24:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5500CA9
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 09:24:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so4528377pjm.2
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I4nXvTrHWqcaRh/wbTzKGKZr7mZYOjAz89tRpbel2lU=;
        b=SZ0OMHcl16lDAPcha/JzO8rJCaPX76K7/6/3XLhB7qHjcKUk9LXRnPy+O2nh1LSV7J
         viBzimQ2JjqMAWA/4xCNxjwIeGW6U/W2GZtQF9iETtQN1IQ+A7HcIHFeHYjDy++onEsY
         NcKgqxms+1XMjfqrZvS/q5cPEqn5ga6FsWJVtDYqaT+Cw894oAuqRcJ0d/SJv2hQ/mQD
         xdMUtDr45yNNLUfXRt0QPFui5FI4MYRox046jBj8uIAoCf1TcXKHXjdSZj5nQPdWOj7E
         IEAoYXNyf78jiexRR0FDh9Lp3YgeUVFlEgWsZXw+KyEpS0WsY93VxOWMVnS9g7jaP9k0
         ++eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=I4nXvTrHWqcaRh/wbTzKGKZr7mZYOjAz89tRpbel2lU=;
        b=hs5zRA5kJiyn1qBGxl1k9XNmNBaDIGgzqR3CtSMsIajjPfwaLPM/0YmL8sxRBZGHC7
         JEnMyHF/j+7dulYuq9Hl81WbTiFdCygJyOWRNmJQoK5/DmbbelELsGCtjzk61/IRy4HW
         oHfgDMwPhmKrM3U9OJCJ8i97DQPW4Ec32+MrfJojbBzoeBtPv4U3skHU9iL4CsnVhNnJ
         5qL1KNb74MLLh0Aq0U2jXGJn4zpNkC1NVi9zCrO8+eXYGwWnUPQZXp+faOa+5Mz/ok9e
         0EMonkwNu4lvc+Ar2z4ug7dWdCRyoB/DXLxacyrmckYlJ4AI2R7DlBZgXgOJyOMacEXy
         yVpw==
X-Gm-Message-State: AJIora+LGGFB4lIoVz8OboCCb9a1sHZ6Jisk+b+v4lTW+TC1yxO6v3ln
        dIkoRT7phjlpgWIqqthp0E0=
X-Google-Smtp-Source: AGRyM1sxbJngnxCbXSmHXDaneeDVQH+0ZxZY+ACvkLdHP5FmVF3FPZr//WEBV9Di82SPEZRwy/OhkA==
X-Received: by 2002:a17:902:d64a:b0:16c:2755:428d with SMTP id y10-20020a170902d64a00b0016c2755428dmr3860778plh.79.1657729490543;
        Wed, 13 Jul 2022 09:24:50 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79627000000b005289ffefe82sm9098272pfg.130.2022.07.13.09.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 09:24:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 13 Jul 2022 06:24:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
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
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <Ys7xz8auWmD814tz@slm.duckdns.org>
References: <20220708215536.pqclxdqvtrfll2y4@google.com>
 <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
 <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
 <Ys4wRqCWrV1WeeWp@castle>
 <CALOAHbAyZBKRn3HpjeKsxpTP8aKnHxFiMD_kGJG22c0X8Cb9+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAyZBKRn3HpjeKsxpTP8aKnHxFiMD_kGJG22c0X8Cb9+w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Wed, Jul 13, 2022 at 10:24:05PM +0800, Yafang Shao wrote:
> I have told you that it is not reasonable to refuse a containerized
> process to pin bpf programs, but if you are not familiar with k8s, it
> is not easy to explain clearly why it is a trouble for deployment.
> But I can try to explain to you from a *systemd user's* perspective.

The way systemd currently sets up cgroup hierarchy doesn't work for
persistent per-service resource tracking. It needs to introduce an extra
layer for that which woudl be a significant change for systemd too.

> I assume the above hierarchy is what you expect.
> But you know, in the k8s environment, everything is pod-based, that
> means if we use the above hierarchy in the k8s environment, the k8s's
> limiting, monitoring, debugging must be changed consequently.  That
> means it may be a fullstack change in k8s, a great refactor.
> 
> So below hierarchy is a reasonable solution,
>                                           bpf-memcg
>                                                 |
>   bpf-foo pod                    bpf-foo-memcg     (limited)
>        /          \                                /
> (charge)     (not-charged)      (charged)
> proc-foo                     bpf-foo
> 
> And then keep the bpf-memgs persistent.

It looks like you draw the diagram with variable width font and it's
difficult to tell what you're trying to say. That said, I don't think the
argument you're making is a good one in general. The topic at hand is future
architectural direction in handling shared resources, which was never well
supported before. ie. We're not talking about breaking existing behaviors.

We don't want to architect kernel features to suit the expectations of one
particular application. It has to be longer term than that and it can't be
an one way road. Sometimes the kernel adapts to existing applications
because the expectations make sense. At other times, kernel takes a
direction which may require some work from applications to use new
capabilities because that makes more sense in the long term.

Let's keep the discussion more focused on technical merits.

Thanks.

-- 
tejun
