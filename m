Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42285A5718
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 00:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiH2W2A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 18:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2W17 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 18:27:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594A57C77F
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:27:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z41so4506525ede.0
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=StN1ci7BUla7rql82wgDtpuvqfCEri46SZjEaE6S5YI=;
        b=HVIURYsfcYragyBIU+rm16Mxc2ZVDchWUXvrVPmX2Lfu57JxvYdH5EtDEOBqhFlIYp
         j08XIsNiDQvB+MqGyGqB5h1q8av/yyBLjRn1jTaQIGcZbLuXtk9ylm5SsruO8Hnpjovy
         SuQ4yIs4pHvbf+shXd1t1a3XvTLMmij9IcgdsJL9TtWAiBynjEliJ5NqsXMdDyKJm2pr
         mRZBMPHkIG96kE0XawvUr0oK+hL7uSjznPIkHjDy+MPhWYQazuzxMbMw2BSonAj2lNtf
         sa7Kj9GA7Pxe1aX1ENHZ9GUHgvDjhwbs6/4zgY3xRg0XxJoti70tHCPAAlACBJZd31Wf
         FMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=StN1ci7BUla7rql82wgDtpuvqfCEri46SZjEaE6S5YI=;
        b=Ev+6+KHjtKlFEwMHNf8rR6oEZRIzDOb5NsUulhLFGug6O7kLR3amK6JAyVmzJfAQiI
         YZC41nAEuXumVSTyS6ydoGIh8YCbadsNVUnSSXNRKcpbXUqUByCvZGOkDNUFLEtvfTRg
         iFCMdZNa+igEJJ8F5vMVWwVKacm1Lyphe9jmEZUtXvbbZwlkX+0Ae5WY9pQ5e05OA8tu
         Iixv0GRJPgNgSn6VgG+VoCH0vH54fk7wPM4kFV1xgfbv1OevkDftYcnpkhYmsFuZLRdn
         nUCQTe6xLGC1vItdD9ENkZBsjIk7hvKNrGQbrl7lYR/T0nQw7WRZ9rA3roRbhdCWSGqX
         WRDA==
X-Gm-Message-State: ACgBeo0s6BDQKstJi/2klC/v9iCRb/m7Jl5nO47gvSyewbhzluMSNA/i
        VlGMj4t0xEaPcIqQ0/RKfny+hSxGF57HVqacD0M=
X-Google-Smtp-Source: AA6agR7OBnfVLBmrXWL8eOELRbpT8Qsy670LyyoMMUtjMp+ox6cEddCQX9vAS5nNEEIl2OwO/BqkKSoI1HCEnftwSZE=
X-Received: by 2002:a05:6402:270d:b0:43a:67b9:6eea with SMTP id
 y13-20020a056402270d00b0043a67b96eeamr17998862edd.94.1661812076879; Mon, 29
 Aug 2022 15:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-16-alexei.starovoitov@gmail.com> <f0e3e3ab-99b7-4d87-4b5a-b71ca7724310@iogearbox.net>
In-Reply-To: <f0e3e3ab-99b7-4d87-4b5a-b71ca7724310@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Aug 2022 15:27:45 -0700
Message-ID: <CAADnVQ+vcSmbE=AydXiNTRo1fYFsCA1bPg9ypjVdpYTAUrs2AQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 15/15] bpf: Introduce sysctl kernel.bpf_force_dyn_alloc.
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Delyan Kratunov <delyank@fb.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, Aug 29, 2022 at 3:02 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 8/26/22 4:44 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce sysctl kernel.bpf_force_dyn_alloc to force dynamic allocation in bpf
> > hash map. All selftests/bpf should pass with bpf_force_dyn_alloc 0 or 1 and all
> > bpf programs (both sleepable and not) should not see any functional difference.
> > The sysctl's observable behavior should only be improved memory usage.
> >
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >   include/linux/filter.h | 2 ++
> >   kernel/bpf/core.c      | 2 ++
> >   kernel/bpf/hashtab.c   | 5 +++++
> >   kernel/bpf/syscall.c   | 9 +++++++++
> >   4 files changed, 18 insertions(+)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index a5f21dc3c432..eb4d4a0c0bde 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1009,6 +1009,8 @@ bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
> >   }
> >   #endif
> >
> > +extern int bpf_force_dyn_alloc;
> > +
> >   #ifdef CONFIG_BPF_JIT
> >   extern int bpf_jit_enable;
> >   extern int bpf_jit_harden;
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 639437f36928..a13e78ea4b90 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -533,6 +533,8 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
> >       bpf_prog_kallsyms_del(fp);
> >   }
> >
> > +int bpf_force_dyn_alloc __read_mostly;
> > +
> >   #ifdef CONFIG_BPF_JIT
> >   /* All BPF JIT sysctl knobs here. */
> >   int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 89f26cbddef5..f68a3400939e 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -505,6 +505,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> >
> >       bpf_map_init_from_attr(&htab->map, attr);
> >
> > +     if (!lru && bpf_force_dyn_alloc) {
> > +             prealloc = false;
> > +             htab->map.map_flags |= BPF_F_NO_PREALLOC;
> > +     }
> > +
>
> The rationale is essentially for testing, right? Would be nice to avoid
> making this patch uapi. It will just confuse users with implementation
> details, imho, and then it's hard to remove it again.

Not for testing, but for production.
The plan is to roll this sysctl gradually in the fleet and
hopefully observe memory saving without negative side effects,
but map usage patterns are wild. It will take a long time to get
the confidence that prelloc code from htab can be completely removed.
At scale usage might find all kinds of unforeseen issues.
Probably new alloc heuristics would need to be developed.
If 'git rm kernel/bpf/percpu_freelist.*' ever happens
(would be great, but who knows) then this sysctl will become a nop.
This patch is trivial enough and we could keep it internal,
but everybody else with a large fleet of servers would probably
be applying the same patch and will be repeating the same steps.
bpf usage in hyperscalers varies a lot.
Before 'git rm freelist' we probably flip the default for this sysctl
to get even broader coverage.
