Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C095F32FD
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 17:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJCP5l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJCP53 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 11:57:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2BE33868;
        Mon,  3 Oct 2022 08:57:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id f26so6566678qto.11;
        Mon, 03 Oct 2022 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zfcmYjP0FJgNZ+yHzXdq3GIst5gkrtYi0k8o5rSrBek=;
        b=pfR1/0erQPgMbNqGsOMNVBVJXuW5U5iGu7/o8QVimRQhlbYagw6nXfRDignNkWIcJ0
         OIJLx2lQIirufz0hvw1827sX5ngk5AH6PGbBIRaKTseh0ogDW7JqulbfjRdoVNm2Ex88
         jM4McKFsWIqYewroozBS4K7CVN2LOuW3KT9YOA0dJPGIcPj6PhE+myOmAsmweCGzLr2/
         fx8Hfn9aNBjX74/s6w+/nn+lPY5XjtebO+rgVysrz+0gkbpfctcI7r6SS3NL/evxtv8h
         2rQQTyJbTwfkKYwI1sQbd0KPVSmFnPeQsw1ZxFLXAYyogYSx5DUWUZx9almZRGVQLDMp
         i57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zfcmYjP0FJgNZ+yHzXdq3GIst5gkrtYi0k8o5rSrBek=;
        b=joXxKxA53zcfwmcGE2pjFADWGhJuwICVH21Qt7ucWSCTus4quBAly74aiz0ACO1HWI
         YYASeKbvgqF6XRNgkOxbwMHwVqK5yZl22UnOJjAfAq2lXT9UPQfw5JoGnSCqNYhBcVif
         Nf2Jy5+M5KMKUtY5j5A51cvipxqTFs1yKGJWana/sQaMn0rOiUE73cXYPOpI6PXFfnC/
         MvFrlKkyuDhHvvg0O+zcf1eRLJ0rCA5YlhAzEGzpdy0D5brtSOjRtLDxuNJHPlSf6aiZ
         tXbwlw7aayL575G0vRJKYMKn4n7S5UUgQoCghbdEYUrct156OdGpeFxcAuZOZmW/id99
         bnZg==
X-Gm-Message-State: ACrzQf3A5HEupPWugOhBSHbId4xEfABBpXX6bMyU0wjsCaaI6II3qpqK
        t1KhDeECnJFfePgX75ROc6utl+GXWcS9qZMqvj8=
X-Google-Smtp-Source: AMsMyM6+Dsm2UdIRiQq6aF6IFcqGxXrsox046izXYUf7KfS1MMzc9wNbc7mSkdypc/G+Bq0Bbmoz2IVEDqjKP0/NHWc=
X-Received: by 2002:ac8:5f0c:0:b0:382:65e1:5ea5 with SMTP id
 x12-20020ac85f0c000000b0038265e15ea5mr1628778qta.193.1664812640124; Mon, 03
 Oct 2022 08:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221001144716.3403120-1-void@manifault.com> <20221001144716.3403120-3-void@manifault.com>
 <CAP01T74TtMARkfYWsYY0+cnsx2w4axB1LtvF-RFMAihW7v=LUw@mail.gmail.com> <YzsBSoGnPEIJADSH@maniforge.dhcp.thefacebook.com>
In-Reply-To: <YzsBSoGnPEIJADSH@maniforge.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 3 Oct 2022 17:56:42 +0200
Message-ID: <CAP01T76OR3J_P8YMq4ZgKHBpuZyA0zgsPy+tq9htbX=j6AVyOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bpf/selftests: Add selftests for new task kfuncs
To:     David Vernet <void@manifault.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 3 Oct 2022 at 17:35, David Vernet <void@manifault.com> wrote:
>
> On Mon, Oct 03, 2022 at 02:32:41AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > [...]
> > > +#endif /* _TASK_KFUNC_COMMON_H */
> > > diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> > > new file mode 100644
> > > index 000000000000..4cf01bbc8a16
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> > > @@ -0,0 +1,225 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> > > +
> > > +#include <vmlinux.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +
> > > +#include "task_kfunc_common.h"
> > > +
> > > +char _license[] SEC("license") = "GPL";
> > > +
> > > +/* Prototype for all of the program trace events below:
> > > + *
> > > + * TRACE_EVENT(task_newtask,
> > > + *         TP_PROTO(struct task_struct *p, u64 clone_flags)
> > > + */
> > > +
> > > +SEC("tp_btf/task_newtask")
> > > +int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64 clone_flags)
> > > +{
> > > +       struct task_struct *acquired, *stack_ptr;
> > > +
> > > +       if (!is_test_kfunc_task(task))
> > > +               return 0;
> > > +
> > > +       /* Can't invoke bpf_task_acquire() on an untrusted, random pointer. */
> > > +       stack_ptr = (struct task_struct *)0xcafef00d;
> >
> > This seems like a misleading comment. 'stack_ptr' would just be a
> > scalar, not a pointer. Maybe you should be testing this for an actual
> > PTR_UNTRUSTED pointer instead. Load of a __kptr tagged pointer would
> > be a good way.
> >
> > Very soon a lot of other pointers obtained from pointer walking are
> > going to be marked PTR_UNTRUSTED, so then we would cover those as well
> > similar to this test.
>
> Good point and good suggestion, let me update the test to do this.
>
> > Also, could you include a test to make sure sleepable programs cannot
> > call bpf_task_acquire? It seems to assume RCU read lock is held while
> > that may not be true. If already not possible, maybe a WARN_ON_ONCE
> > inside the helper to ensure future cases don't creep in.
>
> I don't _think_ it's unsafe for a sleepable program to call
> bpf_task_acquire(). My understanding is that the struct task_struct *
> parameter to bpf_task_acquire() is not PTR_UNTRUSTED, so it's safe to
> dereference directly in the kfunc. The implicit assumption here is that
> the task was either passed to the BPF program (which is calling
> bpf_task_acquire()) from the main kernel in something like a trace or
> struct_ops callback, or it was a referenced kptr that was removed from a
> map with bpf_kptr_xchg(), and is now owned by the BPF program. Given
> that the ptr type is not PTR_UNTRUSTED, it seemed correct to assume that
> the task was valid in bpf_task_acquire() regardless of whether we were
> in an RCU read region or not, but please let me know if I'm wrong about

I don't think it's correct. You can just walk arbitrary structures and
obtain a normal PTR_TO_BTF_ID that looks seemingly ok to the verifier
but has no lifetime guarantees. It's a separate pre-existing problem
unrelated to your series [0]. PTR_UNTRUSTED is not set for those cases
currently.

So the argument to your bpf_task_acquire may already be freed by then.
This issue would be exacerbated in sleepable BPF programs, where RCU
read lock is not held, so some cases of pointer walking where it may
be safe no longer holds.

I am planning to clean this up, but I'd still prefer if we don't allow
this helper in sleepable programs, yet. kptr_get is ok to allow.
Once you have explicit BPF RCU read sections, sleepable programs can
take it, do loads, and operate on the RCU pointer safely until they
invalidate it with the outermost bpf_rcu_read_unlock. It's needed for
local kptrs as well, not just this. I plan to post this very soon, so
we should be able to fix it up in the current cycle after landing your
series.

__rcu tags in the kernel will automatically be understood by the
verifier and for the majority of the correctly annotated cases this
will work fine and not break tracing programs.

[0]: https://lore.kernel.org/bpf/CAADnVQJxe1QT5bvcsrZQCLeZ6kei6WEESP5bDXf_5qcB2Bb6_Q@mail.gmail.com

> that.  Other kfuncs I saw such as bpf_xdp_ct_lookup() assumed that the
> parameter passed by the BPF program (which itself was passing on a
> pointer given to it by the main kernel) is valid as well.

Yeah, but the CT API doesn't assume validity of random PTR_TO_BTF_ID,
it requires KF_TRUSTED_ARGS which forces them to have ref_obj_id != 0.

>
> Note that the difference between bpf_task_acquire() and
> bpf_task_kptr_get() is that for bpf_task_kptr_get(), we're passing a
> pointer to a kptr which could be swapped out and invalidated at any
> moment by a bpf_kptr_xchg() elsewhere in the program.  That's why it's
> necessary to enter an RCU read region before calling READ_ONCE(), and
> why we have to do a refcount_inc_not_zero() rather than just a
> refcount_inc() as we do in bpf_task_acquire().
>

Swapping out is not a problem if the object is RCU protected (which
again, is a requirement for kptr_ref if you wish to support kptr_get,
otherwise it's not needed).

The double pointer ugliness is to allow sleepable programs to safely
do the rcu_dereference/READ_ONCE inside the rcu_read_lock that the
kptr_get helper holds. In non-sleepable programs RCU read lock is
already held, so technically we can just load and pass it to
refcount_inc_not_zero and make it work.

All of this stuff will be gone once we have explicit BPF RCU read
sections, the kptr will be tagged __rcu and while it won't work with
all helpers but those that can deal with refcount == 0, it would be
safer to operate on compared to the PTR_UNTRUSTED case (like the
normal load is right now for kptr_ref), and it also makes it easier to
rely on data read from the object.
