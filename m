Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF37B62ED67
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 07:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbiKRGEe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 01:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKRGEc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 01:04:32 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE78D498;
        Thu, 17 Nov 2022 22:04:31 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b29so3929027pfp.13;
        Thu, 17 Nov 2022 22:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz2BN+We9VqpzC9CMq0N62SJLR54nmwKzt8KWRKP45A=;
        b=F9sOPbAujt9vXjlZm8DkqcCYHa2BKBSZ28ZtLukzwGpYuwVOPmk6TK4SgjBnmXV5eF
         DQxILg+gNWzqOv6zzetFFNpsD0B6SHhQhS1k0hBSMsLGOsYMrpGALGG3j4tJKAf12hOY
         z6DYPRA2HNio/ASJuLinVB9FKvQPDV6whrRbjhFUhH/enwg3Mn9h1aGeyzExkowVuzjO
         3aZYTLXv8BVzI442vc9F1/wzm/j4mzNDKxhMOslncFQMGtBornS7SudwgzxFuUKw1HwS
         B/5MizoehUWP9MvLF/s7JX01fOZTz+ugrUz/dVA5S9ZKCqzG3m/MD/Nk/SuLBzY2tbYR
         KB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iz2BN+We9VqpzC9CMq0N62SJLR54nmwKzt8KWRKP45A=;
        b=dSDo8Bd2dGclcGYGhjQFvblJQbM7PORvakcgNITKzK8Jey3/nc2lwVB0he3H5vhYRG
         X8QZodHGAhGMiikr1l+NEzySemOyJOVE3w1J5vDhvrFs2WZgYx9dQK8oZ6iqJsW4X7xX
         zOZ5ceNQyLUF/SR/UBlYQ9T207q6wxkkC/BOse5rR8ZexMUEvNAO6TBHU2BrgwtrDYkk
         3TPsatk21ct8oQLfVHrwdR7afgPxN2tL2dDNRZMsBeJWOoieTtlkznQK2OrKrZdeHl48
         3Wj3R2kQPvmYVoH96Lg5pGwGA1SAUE/+er8kxEpxZdvKqRDMNv5PXxW7den5hsgGGpM6
         b4yQ==
X-Gm-Message-State: ANoB5pksWOWi8hLpiM0izvxUfAa+dk3i6zh0InjAYTHuaJhM2is8F+eG
        Nw+OtdC0bzFYeAgs036GenD67UlrhZc=
X-Google-Smtp-Source: AA0mqf7O/6LC3bTjmjuqZkTghqcin1gBhzfk8Yg6+eYBdGOHnnqg5ALLybQFMQgr/VQrjS7Zc1UvNw==
X-Received: by 2002:a63:f503:0:b0:470:4acb:1eb with SMTP id w3-20020a63f503000000b004704acb01ebmr5229572pgh.440.1668751470960;
        Thu, 17 Nov 2022 22:04:30 -0800 (PST)
Received: from localhost ([2605:59c8:47b:5f10:50b0:9de6:f19a:a2fe])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090a67c600b0020ad26fa65dsm1848139pjm.56.2022.11.17.22.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:04:30 -0800 (PST)
Date:   Thu, 17 Nov 2022 22:04:27 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     David Vernet <void@manifault.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        yhs@fb.com, song@kernel.org, sdf@google.com, kpsingh@kernel.org,
        jolsa@kernel.org, haoluo@google.com, tj@kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Message-ID: <6377206bed37e_2063d20878@john.notmuch>
In-Reply-To: <Y3biwxIq8B5oYdOS@maniforge.lan>
References: <20221117032402.2356776-1-void@manifault.com>
 <6376a1b12bb4d_4101208d@john.notmuch>
 <Y3atifGs0DM9to8z@maniforge.lan>
 <6376b7822f4df_8c7a208f7@john.notmuch>
 <Y3biwxIq8B5oYdOS@maniforge.lan>
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
> On Thu, Nov 17, 2022 at 02:36:50PM -0800, John Fastabend wrote:
> > David Vernet wrote:
> > > On Thu, Nov 17, 2022 at 01:03:45PM -0800, John Fastabend wrote:
> > > > David Vernet wrote:
> > > > > Now that BPF supports adding new kernel functions with kfuncs, and
> > > > > storing kernel objects in maps with kptrs, we can add a set of kfuncs
> > > > > which allow struct task_struct objects to be stored in maps as
> > > > > referenced kptrs.
> > > > > 
> > > > > The possible use cases for doing this are plentiful.  During tracing,
> > > > > for example, it would be useful to be able to collect some tasks that
> > > > > performed a certain operation, and then periodically summarize who they
> > > > > are, which cgroup they're in, how much CPU time they've utilized, etc.
> > > > > Doing this now would require storing the tasks' pids along with some
> > > > > relevant data to be exported to user space, and later associating the
> > > > > pids to tasks in other event handlers where the data is recorded.
> > > > > Another useful by-product of this is that it allows a program to pin a
> > > > > task in a BPF program, and by proxy therefore also e.g. pin its task
> > > > > local storage.
> > > > 
> > > > Sorry wasn't obvious to me (late to the party so if it was in some
> > > > other v* described apologies). Can we say something about the life
> > > > cycle of this acquired task_structs because they are incrementing
> > > > the ref cnt on the task struct they have potential to impact system.
> > > 
> > > We should probably add an entire docs page which describes how kptrs
> > > work, and I am happy to do that (ideally in a follow-on patch set if
> > > that's OK with you). In general I think it would be useful to include
> > > docs for any general-purpose kfuncs like the ones proposed in this set.
> > 
> > Sure, I wouldn't require that for your series though fwiw.
> 
> Sounds good to me
> 
> [...]
> 
> > > > quick question. If you put acquired task struct in a map what
> > > > happens if user side deletes the entry? Presumably this causes the
> > > > release to happen and the task_struct is good to go. Did I miss
> > > > the logic? I was thinking you would have something in bpf_map_free_kptrs
> > > > and a type callback to release() the refcnt?
> > > 
> > > Someone else can chime in here to correct me if I'm wrong, but AFAIU
> > > this is handled by the map implementations calling out to
> > > bpf_obj_free_fields() to invoke the kptr destructor when the element is
> > > destroyed. See [3] and [4] for examples of where they're called from the
> > > arraymap and hashmap logic respectively. This is how the destructors are
> > > similarly invoked when the maps are destroyed.
> > 
> > Yep I found the dtor() gets populated in btf.c and apparently needed
> > to repull my local tree because I missed it. Thanks for the detailed
> > response.
> > 
> > And last thing I was checking is because KF_SLEEPABLE is not set
> > this should be blocked from running on sleepable progs which would
> > break the call_rcu in the destructor. Maybe small nit, not sure
> > its worth it but might be nice to annotate the helper description
> > with a note, "will not work on sleepable progs" or something to
> > that effect.
> 
> KF_SLEEPABLE is used to indicate whether the kfunc _itself_ may sleep,
> not whether the calling program can be sleepable. call_rcu() doesn't
> block, so no need to mark the kfunc as KF_SLEEPABLE. The key is that if
> a kfunc is sleepable, non-sleepable programs are not able to call it
> (and this is enforced in the verifier).

OK but should these helpers be allowed in sleepable progs? I think
not. What stops this, (using your helpers):

  cpu0                                       cpu1
  ----
  v = insert_lookup_task(task)
  kptr = bpf_kptr_xchg(&v->task, NULL);
  if (!kptr)
    return 0;
                                            map_delete_elem()
                                               put_task()
                                                 rcu_call
  do_something_might_sleep()
                                                    put_task_struct
                                                      ... free  
  kptr->[free'd memory]
 
the insert_lookup_task will bump the refcnt on the acquire on map
insert. But the lookup doesn't do anything to the refcnt and the
map_delete_elem will delete it. We have a check for spin_lock
types to stop them from being in sleepable progs. Did I miss a
similar check for these?

Thanks again
