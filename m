Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF94CC5D1
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 20:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiCCTPI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 14:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiCCTPH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 14:15:07 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3F815C189
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 11:14:18 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 185so4728454qkh.1
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 11:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eR+icZk3nNe8y8lqXUwPYe9syiFxQjeLVqFkSjqoNEA=;
        b=f/SGKWKjiOztzCUpJz8k8AK0LJCOGMbBJnKWyp9hT2nq7Tj+4tby8Mu+QTkek/HDQM
         p7mvnSoFGrfd0/GtMauilg8/0Wxw4Mez49pYH16FIyYsQxAWIP9KXGZFMqeSpvScQCxP
         JM6Y6q5lrXdWkvEgxWb7W2SIfsXQzqf7Kr1cLofSb7fae3rhuXnFPoBJEZfCzZo9smF4
         ECCXPFjHfie6QN9z596PCGAoqSAsJ7Susunp90x/PU3PqWbhtHIVZb+28bGwqn5rDhEI
         8Hup4EIEiJSNL3GDmHch7M5mbUHr0o7XTN+PtPSWWGsqjamaP4AmXCw97lybqdmttTiw
         46YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eR+icZk3nNe8y8lqXUwPYe9syiFxQjeLVqFkSjqoNEA=;
        b=was200AFWbFUlD2j6RVdQmKLCjSevi//6TiETbqIXIwJpZurDhdFPPOlPecJzzeDbk
         CpwrQV30kQAO7Aa+u0qMsn+1aortsHiqop2KyA9lwiQpB+gRn26/R9IE66TljX/+iQeh
         tHi4mbtBGxLYa9CEqUrQAPwc68KAQYVsuvDY4UX5esZhHmyuHahn/S20kwULZJvUxT8c
         cFeNJpbn1Lr1YKr389YFtNaCHvqMTr7bi+wJ8Y/rvfuta0QDYh68O7Zw4e6u3Z2u2WFz
         hZl9HTbXrHc9R+fu2f39zqbcAsSm4iYRyxyiw7XAIbRs/H2Bst/B6LxOIT7jM8npjkRT
         sOSQ==
X-Gm-Message-State: AOAM530Ue8WjGvNIuSYcOPMIus8/tyVxO9jQgDCRmOhOTPwfJsWmdKmB
        06SLkhumczjBov3wpg+XFqj1HBITUzxOsgcAQhKTDg==
X-Google-Smtp-Source: ABdhPJyRx/q83W73jZPicJlpG062mABtEkVqxGGCEU+ejwoPrUMM19V9m1ltko0RdHwTELCL55TJWyyQJldOdzGRM7w=
X-Received: by 2002:a37:ea02:0:b0:47d:293b:7fa with SMTP id
 t2-20020a37ea02000000b0047d293b07famr431616qkj.669.1646334857746; Thu, 03 Mar
 2022 11:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-8-haoluo@google.com>
 <20220302200155.sid3imy4iqm7k5qf@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220302200155.sid3imy4iqm7k5qf@ast-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 3 Mar 2022 11:14:06 -0800
Message-ID: <CA+khW7jqaqwRJ26BLuwJoL+Lr=_0yB8YJe9srF9+m36LGE=toQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/9] bpf: Lift permission check in __sys_bpf
 when called from kernel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 2, 2022 at 12:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 25, 2022 at 03:43:37PM -0800, Hao Luo wrote:
> > After we introduced sleepable tracing programs, we now have an
> > interesting problem. There are now three execution paths that can
> > reach bpf_sys_bpf:
> >
> >  1. called from bpf syscall.
> >  2. called from kernel context (e.g. kernel modules).
> >  3. called from bpf programs.
> >
> > Ideally, capability check in bpf_sys_bpf is necessary for the first two
> > scenarios. But it may not be necessary for the third case.
>
> Well, it's unnecessary for the first two as well.
> When called from the kernel lskel it's a pointless check.
> The kernel module can do anything regardless.
> When called from bpf syscall program it's not quite correct either.
> When CAP_BPF was introduced we've designed it to enforce permissions
> at prog load time. The prog_run doesn't check permissions.
> So syscall progs don't need this secondary permission check.
> Please add "case BPF_PROG_TYPE_SYSCALL:" to is_perfmon_prog_type()
> and combine it with this patch.
>

Sure, will do.

> That would be the best. The alternative below is less appealing.
>
> > An alternative of lifting this permission check would be introducing an
> > 'unpriv' version of bpf_sys_bpf, which doesn't check the current task's
> > capability. If the owner of the tracing prog wants it to be exclusively
> > used by root users, they can use the 'priv' version of bpf_sys_bpf; if
> > the owner wants it to be usable for non-root users, they can use the
> > 'unpriv' version.
>
> ...
>
> > -     if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> > +     if (sysctl_unprivileged_bpf_disabled && !bpf_capable() && !uattr.is_kernel)
>
> This is great idea. If I could think of this I would went with it when prog_syscall
> was introduced.

Thanks!
