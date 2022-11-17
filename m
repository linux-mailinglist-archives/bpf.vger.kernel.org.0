Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242EB62E887
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiKQWg4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiKQWgy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:36:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF53B1659F;
        Thu, 17 Nov 2022 14:36:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w3-20020a17090a460300b00218524e8877so5735366pjg.1;
        Thu, 17 Nov 2022 14:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCGsGWRONG6v/SgotUhqwMZI4/tumJFdiemZiG1EYz0=;
        b=ZOzabP6xkUTUtr/QJnyMK/XhuThhhK7Iit4scavgk2H8JyBDFxa7FcqVJktbGVnEsf
         7EhGmQK8VdONtFJfbpi/N7GcJJM4ae/IURkzFUK7rSIRdhe2sUc7fPX3n7m6cRMkVpW+
         O8lPP5wWo/c1FCyxfNRDPJnhiZYz/IF++PsVsOISyBTrsTs+pY/EXvd4VBEzOqsRvAok
         Ubt21fO0bX1zxM/WA4QqsdY+KsGF8UryJdiKLeKs+UfpwtLbk1z8Z/Ajwi48H6jWp1hu
         Xm6ao2Zpabnmjwa/+aT6ZnaaYFyobR/5YcZZZBdMRMwJ7POzN7Qicv0URQMVUNZnFdTr
         Bh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MCGsGWRONG6v/SgotUhqwMZI4/tumJFdiemZiG1EYz0=;
        b=vylfJ3jyzcwyFMfBpjAds002o0JXEmnzu1ADP+2t2ItWfulVKPS36tlin8LwFOETAZ
         RHWid5QMnVZ6ueCWbmNf2xqfMisVoUdiQ4wP5iCb6lmaURSJV610OqoMRtMD1ReG8IUw
         7tepASqyJSiSlApysttadWOeJoNBSLqWW0FO+zawfFHvE5ytDesATRqjbx1BvqQhk7Ty
         prWxUoLjX4rSirDHV47xqOjXF7o8WoECC+v9Y3FcWq4BpN/FJavPvQ+pLNd6Tgse3Bdm
         plXXntuhcGy1noYX88z4BJX72nyVmChEfVNmz2m81Gz0sHLZxRsURgTKSsBNgitUuaYD
         xDTg==
X-Gm-Message-State: ANoB5pnT3MritYZpbbAJiMwALw423y7ptAnMIF/lmTm3ucxe3NaNUXzT
        gy/Tpcj4rusZIlFhSpKoj/w=
X-Google-Smtp-Source: AA0mqf5pzZ9XhJOtQzZiBSYnLGkMrYjAlITumeWei4wgo0buGMRCC318ynGnKN7WNuWIfqxb0Bzxew==
X-Received: by 2002:a17:90b:1bc3:b0:212:ed58:2825 with SMTP id oa3-20020a17090b1bc300b00212ed582825mr10888765pjb.199.1668724612296;
        Thu, 17 Nov 2022 14:36:52 -0800 (PST)
Received: from localhost ([98.97.115.29])
        by smtp.gmail.com with ESMTPSA id b7-20020aa79507000000b0056bcfe015c9sm1633662pfp.204.2022.11.17.14.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:36:51 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:36:50 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     David Vernet <void@manifault.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        yhs@fb.com, song@kernel.org, sdf@google.com, kpsingh@kernel.org,
        jolsa@kernel.org, haoluo@google.com, tj@kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Message-ID: <6376b7822f4df_8c7a208f7@john.notmuch>
In-Reply-To: <Y3atifGs0DM9to8z@maniforge.lan>
References: <20221117032402.2356776-1-void@manifault.com>
 <6376a1b12bb4d_4101208d@john.notmuch>
 <Y3atifGs0DM9to8z@maniforge.lan>
Subject: Re: [PATCH bpf-next v7 0/3] Support storing struct task_struct
 objects as kptrs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet wrote:
> On Thu, Nov 17, 2022 at 01:03:45PM -0800, John Fastabend wrote:
> > David Vernet wrote:
> > > Now that BPF supports adding new kernel functions with kfuncs, and
> > > storing kernel objects in maps with kptrs, we can add a set of kfuncs
> > > which allow struct task_struct objects to be stored in maps as
> > > referenced kptrs.
> > > 
> > > The possible use cases for doing this are plentiful.  During tracing,
> > > for example, it would be useful to be able to collect some tasks that
> > > performed a certain operation, and then periodically summarize who they
> > > are, which cgroup they're in, how much CPU time they've utilized, etc.
> > > Doing this now would require storing the tasks' pids along with some
> > > relevant data to be exported to user space, and later associating the
> > > pids to tasks in other event handlers where the data is recorded.
> > > Another useful by-product of this is that it allows a program to pin a
> > > task in a BPF program, and by proxy therefore also e.g. pin its task
> > > local storage.
> > 
> > Sorry wasn't obvious to me (late to the party so if it was in some
> > other v* described apologies). Can we say something about the life
> > cycle of this acquired task_structs because they are incrementing
> > the ref cnt on the task struct they have potential to impact system.
> 
> We should probably add an entire docs page which describes how kptrs
> work, and I am happy to do that (ideally in a follow-on patch set if
> that's OK with you). In general I think it would be useful to include
> docs for any general-purpose kfuncs like the ones proposed in this set.

Sure, I wouldn't require that for your series though fwiw.

> 
> In regards to your specific question about the task lifecycle, nothing
> being proposed in this patch set differs from how kptr lifecycles work
> in general. The idea is that the BPF program:
> 
> 1. Gets a "kptr_ref" kptr from an "acquire" kfunc.
> 2. Stores it in a map with bpf_kptr_xchg().
> 
> The program can then either later manually extract it from the map
> (again with bpf_kptr_xchg()) and release it, or if the reference is
> never removed from the map, let it be automatically released when the
> map is destroyed. See [0] and [1] for a bit more information.

Yep as long as the ref is decremented on map destroy and elem delete
all good.

> 
> [0]: https://docs.kernel.org/bpf/kfuncs.html?highlight=kptr#kf-acquire-flag
> [1]: https://lwn.net/Articles/900749/
> 
> > I know at least we've had a few bugs in our task struct tracking
> > that has led to various bugs where we leak references. In our case
> > we didn't pin the kernel object so the leak is just BPF memory and
> > user space memory, still sort of bad because we would hit memory
> > limits and get OOM'd. Leaking kernel task structs is worse though.
> 
> I don't think we need to worry about leaks. The verifier should fail to
> load any program that doesn't properly release a kptr, and if it fails
> to identify programs that improperly hold refcounts, that's a bug that
> needs to be fixed. Similarly, if any map implementation (described
> below) fails to properly free references at the appropriate time (when
> an element or the map itself is destroyed), those are just bugs that
> need to be fixed.
> 
> I think the relevant tradeoff here is really the possible side effects
> of keeping a task pinned and avoiding it being reaped. I agree that's an
> important consideration, but I think that would arguably apply to any
> kptr (modulo the size of the object being pinned, which is certainly
> relevant as well). We already have kptrs for e.g. struct nf_conn [2].
> Granted, struct task_struct is significantly larger, but bpf_kptr_xchg()
> is only enabled for privileged programs, so it seems like a reasonable
> operation to allow.

No not arguing it shouldn't be possible just didn't see the release
hook.

> 
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/net/netfilter/nf_conntrack_bpf.c#n253
> 
> > quick question. If you put acquired task struct in a map what
> > happens if user side deletes the entry? Presumably this causes the
> > release to happen and the task_struct is good to go. Did I miss
> > the logic? I was thinking you would have something in bpf_map_free_kptrs
> > and a type callback to release() the refcnt?
> 
> Someone else can chime in here to correct me if I'm wrong, but AFAIU
> this is handled by the map implementations calling out to
> bpf_obj_free_fields() to invoke the kptr destructor when the element is
> destroyed. See [3] and [4] for examples of where they're called from the
> arraymap and hashmap logic respectively. This is how the destructors are
> similarly invoked when the maps are destroyed.

Yep I found the dtor() gets populated in btf.c and apparently needed
to repull my local tree because I missed it. Thanks for the detailed
response.

And last thing I was checking is because KF_SLEEPABLE is not set
this should be blocked from running on sleepable progs which would
break the call_rcu in the destructor. Maybe small nit, not sure
its worth it but might be nice to annotate the helper description
with a note, "will not work on sleepable progs" or something to
that effect.

Thanks.

> 
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/arraymap.c#n431
> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/hashtab.c#n764
> 
> [...]


