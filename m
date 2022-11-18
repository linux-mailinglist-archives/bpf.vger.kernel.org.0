Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E208862EB25
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbiKRBlb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbiKRBl1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:41:27 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B6FEE33;
        Thu, 17 Nov 2022 17:41:23 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id v8so2532871qkg.12;
        Thu, 17 Nov 2022 17:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2iDkgi6Cz8+ghmu1fZWCpIJ9rUZoFg0eD2OPo7Dxik=;
        b=ArZrnXBUaRzdXxsTX2EHs2qMEvveglT+o+A9kBUf8cfRIwbUXxaZnfK0RjjGG2fB+9
         tj4bP8BC6zk7fI/EoTvIdP+4lXPpWWN/I3JlZ9E6KAl+eah/7FhUdABstNxjpWfEGq2Q
         WInMm3FOpILAHSIJdCOhn/F7lrtZcggftelLk6MRMqnWsox6IC1+mOnOe7peDenSPWyy
         kEiPXdOVNxeyW5CxWOeg3GGezt5gTe0dMOvJgVDuQWqSlo9dgWkepCTC/YYE4qWVzUep
         lpROnGjxvwUIJYTyv9zY5E07oMc0URaRg0bk3hFN3eTOY+dPVFRDvrS6K41cw+cmdfn4
         kTfA==
X-Gm-Message-State: ANoB5pnzjoh15nivJXU1RUQis4Sx5odJgW4Ywaxtll6GsraucWzczv9E
        gt+O9VxFcsi7cWZqGiR3FcapOGHf+q8MoTfp
X-Google-Smtp-Source: AA0mqf5lT8GzBiFdNWOWsbIY4ziJuWnF6nVbx8Ri4nv4aA8YHdyYNBoyaOKgZsUMqVsSMCVB+qL9Ag==
X-Received: by 2002:a05:620a:2795:b0:6ec:51cd:c376 with SMTP id g21-20020a05620a279500b006ec51cdc376mr1352916qkp.300.1668735682302;
        Thu, 17 Nov 2022 17:41:22 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:8ad4])
        by smtp.gmail.com with ESMTPSA id q25-20020a05620a2a5900b006ee7923c187sm1480426qkp.42.2022.11.17.17.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:41:21 -0800 (PST)
Date:   Thu, 17 Nov 2022 19:41:23 -0600
From:   David Vernet <void@manifault.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        yhs@fb.com, song@kernel.org, sdf@google.com, kpsingh@kernel.org,
        jolsa@kernel.org, haoluo@google.com, tj@kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 0/3] Support storing struct task_struct
 objects as kptrs
Message-ID: <Y3biwxIq8B5oYdOS@maniforge.lan>
References: <20221117032402.2356776-1-void@manifault.com>
 <6376a1b12bb4d_4101208d@john.notmuch>
 <Y3atifGs0DM9to8z@maniforge.lan>
 <6376b7822f4df_8c7a208f7@john.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6376b7822f4df_8c7a208f7@john.notmuch>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 17, 2022 at 02:36:50PM -0800, John Fastabend wrote:
> David Vernet wrote:
> > On Thu, Nov 17, 2022 at 01:03:45PM -0800, John Fastabend wrote:
> > > David Vernet wrote:
> > > > Now that BPF supports adding new kernel functions with kfuncs, and
> > > > storing kernel objects in maps with kptrs, we can add a set of kfuncs
> > > > which allow struct task_struct objects to be stored in maps as
> > > > referenced kptrs.
> > > > 
> > > > The possible use cases for doing this are plentiful.  During tracing,
> > > > for example, it would be useful to be able to collect some tasks that
> > > > performed a certain operation, and then periodically summarize who they
> > > > are, which cgroup they're in, how much CPU time they've utilized, etc.
> > > > Doing this now would require storing the tasks' pids along with some
> > > > relevant data to be exported to user space, and later associating the
> > > > pids to tasks in other event handlers where the data is recorded.
> > > > Another useful by-product of this is that it allows a program to pin a
> > > > task in a BPF program, and by proxy therefore also e.g. pin its task
> > > > local storage.
> > > 
> > > Sorry wasn't obvious to me (late to the party so if it was in some
> > > other v* described apologies). Can we say something about the life
> > > cycle of this acquired task_structs because they are incrementing
> > > the ref cnt on the task struct they have potential to impact system.
> > 
> > We should probably add an entire docs page which describes how kptrs
> > work, and I am happy to do that (ideally in a follow-on patch set if
> > that's OK with you). In general I think it would be useful to include
> > docs for any general-purpose kfuncs like the ones proposed in this set.
> 
> Sure, I wouldn't require that for your series though fwiw.

Sounds good to me

[...]

> > > quick question. If you put acquired task struct in a map what
> > > happens if user side deletes the entry? Presumably this causes the
> > > release to happen and the task_struct is good to go. Did I miss
> > > the logic? I was thinking you would have something in bpf_map_free_kptrs
> > > and a type callback to release() the refcnt?
> > 
> > Someone else can chime in here to correct me if I'm wrong, but AFAIU
> > this is handled by the map implementations calling out to
> > bpf_obj_free_fields() to invoke the kptr destructor when the element is
> > destroyed. See [3] and [4] for examples of where they're called from the
> > arraymap and hashmap logic respectively. This is how the destructors are
> > similarly invoked when the maps are destroyed.
> 
> Yep I found the dtor() gets populated in btf.c and apparently needed
> to repull my local tree because I missed it. Thanks for the detailed
> response.
> 
> And last thing I was checking is because KF_SLEEPABLE is not set
> this should be blocked from running on sleepable progs which would
> break the call_rcu in the destructor. Maybe small nit, not sure
> its worth it but might be nice to annotate the helper description
> with a note, "will not work on sleepable progs" or something to
> that effect.

KF_SLEEPABLE is used to indicate whether the kfunc _itself_ may sleep,
not whether the calling program can be sleepable. call_rcu() doesn't
block, so no need to mark the kfunc as KF_SLEEPABLE. The key is that if
a kfunc is sleepable, non-sleepable programs are not able to call it
(and this is enforced in the verifier).
