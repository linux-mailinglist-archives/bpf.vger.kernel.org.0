Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237DB6779A1
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 11:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjAWKyu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 05:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjAWKyn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 05:54:43 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649E01ABF3
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 02:54:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y19so14082327edc.2
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 02:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=fC7rpfaSwbNfsDpt9B3A0bWFPATi+nwUhv2xdT4my5A=;
        b=sB4KS7GkeChrwW8NwxbTcyQKYbNY/8b8pqb2TlzWbgKK+rcpmWF9UPLb+aaWkFHQMx
         Si+P4lIBxAvdaP62VpCdR+4s5x6qRwu9dSOxlQW/MQIhRp0bp/YFnZyoE+OS+RsIW9o1
         weza+UEoDQraWHy1CciXTSFYt71C5XDIl2NYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC7rpfaSwbNfsDpt9B3A0bWFPATi+nwUhv2xdT4my5A=;
        b=osojIyLySAcBrWfNkpXOX/yoxfkuurjPmRKiadNfAQy8My8YDqLR2qTBwEaKQFzvxv
         vR7Ro8S9Hy5XMoukzVedvrhgZCT/Wdn0AyddytwUkDPqAwuTJpIcNNfW+QlFryron5p3
         Yey268hOQlYiDOa9zog29GttpMYYMkLtvNk9vwhyQaCOouC1Vz63NAmQoFLU+pdGM3mk
         RlWDA+284unS1A2FnA2l8j6NMnXR0Cr7aTXtDahosKf8zggSGt0d481f8M1km2Cnwr5s
         3eD3LX4oMzsoxidz91I+SrTN8EwkRdqgFi/X7LDhaM4G3nVwH/hxkRArWuKdoT0axktN
         ejZA==
X-Gm-Message-State: AFqh2kqsKDRURal9A2sa8VVo7I0UIgi++EoFAy1aO/4cDBIbHeDf4vZX
        ajEIzSCXZb7kCiNTGnxxIP1P99adLIhms0by
X-Google-Smtp-Source: AMrXdXtqr+4golq/ykzdhAYvG4XXj8HyYW0hmme6ADjkc2O8rIq+Dpv2RW8SUNLrtiHjvkWChv0jtA==
X-Received: by 2002:a05:6402:2989:b0:461:1998:217f with SMTP id eq9-20020a056402298900b004611998217fmr24342750edb.4.1674471280687;
        Mon, 23 Jan 2023 02:54:40 -0800 (PST)
Received: from cloudflare.com (79.191.179.97.ipv4.supernova.orange.pl. [79.191.179.97])
        by smtp.gmail.com with ESMTPSA id ew7-20020a056402538700b0049b58744f93sm14812190edb.81.2023.01.23.02.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:54:40 -0800 (PST)
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: Are BPF programs preemptible?
Date:   Mon, 23 Jan 2023 11:46:58 +0100
In-reply-to: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
Message-ID: <878rhty100.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 11:21 AM +02, Yaniv Agman wrote:
> Hello!
>
> Several places state that eBPF programs cannot be preempted by the
> kernel (e.g. https://docs.cilium.io/en/latest/bpf/toolchain), however,
> I did see a strange behavior where an eBPF percpu map gets overridden,
> and I'm trying to figure out if it's due to a bug in my program or
> some misunderstanding I have about eBPF. What caught my eye was a
> sentence in a LWN article (https://lwn.net/Articles/812503/) that
> says: "Alexei thankfully enlightened me recently over a beer that the
> real intent here is to guarantee that the program runs to completion
> on the same CPU where it started".
>
> So my question is - are BPF programs guaranteed to run from start to
> end without being interrupted at all or the only guarantee I get is
> that they run on the same CPU but IRQs (NMIs, soft irqs, whatever) can
> interrupt their run?
>
> If the only guarantee is no migration, it means that a percpu map
> cannot be safely used by two different BPF programs that can preempt
> each other (e.g. some kprobe and a network cgroup program).

Since v5.7 BPF program runners use migrate_disable() instead of
preempt_disable(). See commit 2a916f2f546c ("bpf: Use
migrate_disable/enable in array macros and cgroup/lirc code.") [1].

But at that time migrate_disable() was merely an alias for
preempt_disable() on !CONFIG_PREEMPT_RT kernels.

Since v5.11 migrate_disable() does no longer disable preemption on
!CONFIG_PREEMPT_RT kernels. See commit 74d862b682f5 ("sched: Make
migrate_disable/enable() independent of RT") [2].

So, yes, you are right, but it depends on the kernel version.

PS. The migrate_disable vs per-CPU data problem is also covered in [3].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a916f2f546ca1c1e3323e2a4269307f6d9890eb
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=74d862b682f51e45d25b95b1ecf212428a4967b0
[3]: https://lwn.net/Articles/836503/
