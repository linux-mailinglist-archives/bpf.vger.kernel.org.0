Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2971E62E754
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 22:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbiKQVyR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 16:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiKQVyR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 16:54:17 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200046BDDC;
        Thu, 17 Nov 2022 13:54:16 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id w9so2015913qtv.13;
        Thu, 17 Nov 2022 13:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjdY4Kpbu9uYjT7gJokz4DeGk9HCzyYbfyJj+p0YN2k=;
        b=JboHmYaXgnesOeOWaXqVU5tToRqdI3Jwngo6nZNrH1wTsrWazhHUYTOGIpNUWjfId4
         gU81gKoFy0TgjkPVldj7NDl0rVKTQrgTtxilY6orW72Gm82a3OvOB9GOKxRfDLoQ84ms
         tOfbrNlpXLrqWBOStlBWvnbqtEYbAvV9p2NPCiqTpjhaNiJushPJfJJaA+HE2U6LEi+n
         sbP0Jv+VQ/PIfhV0NGknEZRkPoeJUlKAGDZqoRzhOQ1pURF/hgdPUaYbm/Hnjn+d90Ks
         v20J+QWd5K0ficWkBWPY5kDBlC0FUjY1h6X4+kWAk6b3ENxeMp/DVBNdEToa1W9LvJPd
         vVhg==
X-Gm-Message-State: ANoB5pmYlksY36q17Qd+dJntqvj9Q+8UevKxnnWLn+IridaZibbwkd4T
        ysaZKNZW7eoQm6t5AX5djsI=
X-Google-Smtp-Source: AA0mqf64MuWYyFX6xHztdR9C0cB6KvkHg8/ih0oSxbaCMXI68qMkWG0EEqxTbNHzK9Bo06YQWyK4lA==
X-Received: by 2002:ac8:7444:0:b0:39a:5f99:c7ce with SMTP id h4-20020ac87444000000b0039a5f99c7cemr4190843qtr.621.1668722055095;
        Thu, 17 Nov 2022 13:54:15 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:8ad4])
        by smtp.gmail.com with ESMTPSA id fg22-20020a05622a581600b003a580cd979asm1025563qtb.58.2022.11.17.13.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:54:14 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:54:17 -0600
From:   David Vernet <void@manifault.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        yhs@fb.com, song@kernel.org, sdf@google.com, kpsingh@kernel.org,
        jolsa@kernel.org, haoluo@google.com, tj@kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 0/3] Support storing struct task_struct
 objects as kptrs
Message-ID: <Y3atifGs0DM9to8z@maniforge.lan>
References: <20221117032402.2356776-1-void@manifault.com>
 <6376a1b12bb4d_4101208d@john.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6376a1b12bb4d_4101208d@john.notmuch>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 17, 2022 at 01:03:45PM -0800, John Fastabend wrote:
> David Vernet wrote:
> > Now that BPF supports adding new kernel functions with kfuncs, and
> > storing kernel objects in maps with kptrs, we can add a set of kfuncs
> > which allow struct task_struct objects to be stored in maps as
> > referenced kptrs.
> > 
> > The possible use cases for doing this are plentiful.  During tracing,
> > for example, it would be useful to be able to collect some tasks that
> > performed a certain operation, and then periodically summarize who they
> > are, which cgroup they're in, how much CPU time they've utilized, etc.
> > Doing this now would require storing the tasks' pids along with some
> > relevant data to be exported to user space, and later associating the
> > pids to tasks in other event handlers where the data is recorded.
> > Another useful by-product of this is that it allows a program to pin a
> > task in a BPF program, and by proxy therefore also e.g. pin its task
> > local storage.
> 
> Sorry wasn't obvious to me (late to the party so if it was in some
> other v* described apologies). Can we say something about the life
> cycle of this acquired task_structs because they are incrementing
> the ref cnt on the task struct they have potential to impact system.

We should probably add an entire docs page which describes how kptrs
work, and I am happy to do that (ideally in a follow-on patch set if
that's OK with you). In general I think it would be useful to include
docs for any general-purpose kfuncs like the ones proposed in this set.

In regards to your specific question about the task lifecycle, nothing
being proposed in this patch set differs from how kptr lifecycles work
in general. The idea is that the BPF program:

1. Gets a "kptr_ref" kptr from an "acquire" kfunc.
2. Stores it in a map with bpf_kptr_xchg().

The program can then either later manually extract it from the map
(again with bpf_kptr_xchg()) and release it, or if the reference is
never removed from the map, let it be automatically released when the
map is destroyed. See [0] and [1] for a bit more information.

[0]: https://docs.kernel.org/bpf/kfuncs.html?highlight=kptr#kf-acquire-flag
[1]: https://lwn.net/Articles/900749/

> I know at least we've had a few bugs in our task struct tracking
> that has led to various bugs where we leak references. In our case
> we didn't pin the kernel object so the leak is just BPF memory and
> user space memory, still sort of bad because we would hit memory
> limits and get OOM'd. Leaking kernel task structs is worse though.

I don't think we need to worry about leaks. The verifier should fail to
load any program that doesn't properly release a kptr, and if it fails
to identify programs that improperly hold refcounts, that's a bug that
needs to be fixed. Similarly, if any map implementation (described
below) fails to properly free references at the appropriate time (when
an element or the map itself is destroyed), those are just bugs that
need to be fixed.

I think the relevant tradeoff here is really the possible side effects
of keeping a task pinned and avoiding it being reaped. I agree that's an
important consideration, but I think that would arguably apply to any
kptr (modulo the size of the object being pinned, which is certainly
relevant as well). We already have kptrs for e.g. struct nf_conn [2].
Granted, struct task_struct is significantly larger, but bpf_kptr_xchg()
is only enabled for privileged programs, so it seems like a reasonable
operation to allow.

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/net/netfilter/nf_conntrack_bpf.c#n253

> quick question. If you put acquired task struct in a map what
> happens if user side deletes the entry? Presumably this causes the
> release to happen and the task_struct is good to go. Did I miss
> the logic? I was thinking you would have something in bpf_map_free_kptrs
> and a type callback to release() the refcnt?

Someone else can chime in here to correct me if I'm wrong, but AFAIU
this is handled by the map implementations calling out to
bpf_obj_free_fields() to invoke the kptr destructor when the element is
destroyed. See [3] and [4] for examples of where they're called from the
arraymap and hashmap logic respectively. This is how the destructors are
similarly invoked when the maps are destroyed.

[3]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/arraymap.c#n431
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/hashtab.c#n764

[...]
