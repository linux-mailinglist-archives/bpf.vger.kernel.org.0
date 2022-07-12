Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7916D5720B3
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiGLQY2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiGLQY1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 12:24:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2E6CAF34
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 09:24:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s21so8144283pjq.4
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7sEHZnwDHngZ8PkrUxm/ATIo3aq5UKj0LAY0nMBz/yk=;
        b=meJQ/dKf8HP6vS20zVKapOxrcORiVKzXMeR0qkrRs/dGuhkKecJaRK6r2Iss9H2K2j
         gA5Rzq4tqzIgi5NGmZUm8OyerBZnQZxXA7i5AWTSMU7BP+IOP6RITSysiX1+GtSibOpr
         InGYEdDZViTnBqcEj9HgVOcmo3T9o+0IFmi1CH2C+Ci+znLIvofR+Kd2RDshqo58PJff
         aXv/DPcAVZ3x7X+27pEziAPi3yIxwI8mTdNR/WDAvu98ogUyKF8iutbuBO1KwxbqKrRp
         3U6Vfx+iImOsbz76hKnyYLmh/Kv1bp08Coae9qoybh1lk8OgcSVY0kOb2uDZbar9du7u
         HJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7sEHZnwDHngZ8PkrUxm/ATIo3aq5UKj0LAY0nMBz/yk=;
        b=vSInTp9HcziY9Y4oabN+cdslPC6K+hfa/ZVdCcRVgJ5VmjTk+X0Et3VukRJU1wgjcH
         k7DZdlV2WuQU1Pa8tZfczEWvC2oL7JiUOhg28UDv+jcpHVI5qhft+rvn0gYdTs25e6ve
         6ruHpFigTyfNU3WXAoAszQUx2ezXIAzQ6iToGjswHnXXClQzXkeZV/K9mFS0yYjrDItJ
         lp6/VpWjB9NVKg8LEn9tTbfURKthfNTPfFU6CKeRfcec4KCFL4wItf+y8h1KBOXapt+Q
         v4fvAjGi/VrF8NvseQjBdAFMR3jowfQDgZVaQN+5Co6WADO+XfGhHM3zVZRK1SSGCbJl
         sUjA==
X-Gm-Message-State: AJIora+9tvpW3YGDTQmmjhhXdI4jeXlog0cnBR8AcvB0TK4U+7VAuO1S
        kfb8PMbygAe8SZv7w5YAIkk=
X-Google-Smtp-Source: AGRyM1vPQIv97fm/20hxzm1gicPKu76SuIxxULA29ZAmF4uFJB7irtvGCWOL90Qd5lx0F5BGLLZvWA==
X-Received: by 2002:a17:90b:1e4d:b0:1f0:462b:b573 with SMTP id pi13-20020a17090b1e4d00b001f0462bb573mr5337524pjb.164.1657643062744;
        Tue, 12 Jul 2022 09:24:22 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id be4-20020a656e44000000b0040caab35e5bsm6313952pgb.89.2022.07.12.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:24:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 12 Jul 2022 06:24:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
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
Message-ID: <Ys2gNCAyYGX3XVMm@slm.duckdns.org>
References: <Ysg0GyvqUe0od2NN@dhcp22.suse.cz>
 <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com>
 <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
 <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
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

Hello, Michal.

On Tue, Jul 12, 2022 at 11:52:11AM +0200, Michal Hocko wrote:
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

I think the solution here is an extra cgroup layering to represent
persistent resource tracking. In systemd-speak, a service should have a
cgroup representing a persistent service type and a cgroup representing the
current running instance. This way, the user (or system agent) can clearly
distinguish all resources that have ever been attributed to the service and
the resources that are accounted to the current instance while also giving
visibility into residual resources for services that are no longer running.

This gives userspace control over what to track for how long and also fits
what the kernel can do in terms of resource tracking. If we try to do
something smart from kernel side, there are cases which are inherently
insolvable. e.g. if a service instance creates tmpfs / shmem / whawtever and
leaves it pinned one way or another and then exits, and there's no one who
actively accessed it afterwards, there is no userland visible entity we can
reasonably attribute that memory to other than the parent cgroup.

Thanks.

-- 
tejun
