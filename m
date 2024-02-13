Return-Path: <bpf+bounces-21892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DEA853C71
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 21:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253CB1F283B8
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16AB612FA;
	Tue, 13 Feb 2024 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju/7C4Nd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65315FF03
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857531; cv=none; b=S01kpJyIv0IGlkgAr2kyKtiUIcKAEJAKcYIEr1fglUzTxb+VKd/Fo6bAbV/Cs5h7j5LCV5wD6cK5kOBzdt3Su1mq4g8/PdgNbA/CBjTlfa2UCLi2Hj4t5ItOKpph1IkDQpNBtzKtNXe26ApSysIaHITc6B9YL9wV1/I+Sqv75ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857531; c=relaxed/simple;
	bh=NeHzQXnNfgEFXzNwjYOjEV2KcCZa0afnUfqZO/BPCMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHE1suarKr9aFO8xdP3tbhoPqF9Rm5FTGlfjTnBuwzCO9Ez3yltI8Ebu097p7NSnZw9U6xYSWSiItMWj6MbXMpLwyC00T6YcpmCNE01uu5dfA82BrIH7m4mr+VRyHc3Aut65fe8itgiQuSyDRbEi75pRt9k8cWldH3F6hMdc7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ju/7C4Nd; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so6661552a12.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 12:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857527; x=1708462327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KKXAW8M0YfvMRz5/0feISztMjPDlB+YmAzmITXC5IdM=;
        b=Ju/7C4NdcK9tKfcBKzaK0ZtGm23IoGTD4epxRQQqX6ry3+ey8UwEfEr9Yn23wAssXs
         NnuOYDewvI352ojPdC3Gt7g2lykEyFJveHdvt4Xb6FXjRgRIMKe4rBlMgnSCWkOVubMK
         O+vI0tLoeQCxRhchEcabKSiw92nuLuxiRJUDF1vL1B9vG/gYZnGApnwWquhYc7OorQdI
         N1nGPzcREOJroemTDPGIGyg037vq1z6uK1qW20jF/+l3Hjtv1qMJXbHfB56K349rUsNo
         IoWwNTndmz5zsSsRFAzkSQiy2Zq1sIeCu4Ny7fYGi/PoUvSNmEzEe2eazTVQjC2s1er2
         tWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857527; x=1708462327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKXAW8M0YfvMRz5/0feISztMjPDlB+YmAzmITXC5IdM=;
        b=NHEqKvas6e5T2eTf0/THtdbyN4MDeW6h42fKBh0ip6cRXNy+EPqETItRzMuNYDBHKd
         XPv79mRi6H410s0uyTRI3Mxn6TkqWzlZhWLZZSaGNZ3uTl07iDJkU2XusvE+4Ysi7/Vy
         m/eXt9gN2GNYtyRy8jZG1F4xJV/D/ZIAMSLc2N6RLm8CUH/ymLfcqRnhTPOvJlUzkNhw
         w97VruZM7EsjsZ/1oTFSnpC3n5kmIQRyZOCx5RM1eSDSN6XVonlNFKdTbmE7KKxLYvxX
         KpPIid+eIHLYF6JUcLCmKWJGl9wmAfY90QNPmrrWUyLFDbkShwDDeSD0hIXLIH1NVQhL
         L+9A==
X-Gm-Message-State: AOJu0YyC5UylxYJ0nLmapWVphNRg5TtPgL4vOXMmZO/yzaX9lBaBQ1bk
	QlVMZZTmZxNxm/DVIedL/kptPjoQzoO99RPBRaDO+cWALQpEpMl4gVPSOXxnsRHV9a81YZIsOEK
	Px9/ki9zDvcLOEiVrGuvN18Vei14=
X-Google-Smtp-Source: AGHT+IHe6J67kYgmJcXac6xebgWqqF9MfuvCsHVZrnfXVfYxDkegcIAewGHjHx6mZACQSiGivxYQwRrpX5vajXQszWw=
X-Received: by 2002:a17:907:10c1:b0:a3c:1f9d:e7c with SMTP id
 rv1-20020a17090710c100b00a3c1f9d0e7cmr424805ejb.34.1707857526782; Tue, 13 Feb
 2024 12:52:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-15-memxor@gmail.com>
 <20240212205314.GC2200361@maniforge.lan> <CAP01T76hX2jxHiJ_iiWSj7Wgu5t4RL48-eLGJmEtik9GR0rq6g@mail.gmail.com>
 <20240213193324.GA2453398@maniforge.lan>
In-Reply-To: <20240213193324.GA2453398@maniforge.lan>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 13 Feb 2024 21:51:30 +0100
Message-ID: <CAP01T75CnbchAnqG6wJnzrTcQTtQ4Ygyo0LmB+HMUU+9W3SG5w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 14/14] selftests/bpf: Add tests for exceptions
 runtime cleanup
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, 
	Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 20:33, David Vernet <void@manifault.com> wrote:
>
> On Mon, Feb 12, 2024 at 11:43:42PM +0100, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 12 Feb 2024 at 21:53, David Vernet <void@manifault.com> wrote:
> > >
> > > On Thu, Feb 01, 2024 at 04:21:09AM +0000, Kumar Kartikeya Dwivedi wrote:
> > > > Add tests for the runtime cleanup support for exceptions, ensuring that
> > > > resources are correctly identified and released when an exception is
> > > > thrown. Also, we add negative tests to exercise corner cases the
> > > > verifier should reject.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
> > > >  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
> > > >  .../bpf/prog_tests/exceptions_cleanup.c       |  65 +++
> > > >  .../selftests/bpf/progs/exceptions_cleanup.c  | 468 ++++++++++++++++++
> > > >  .../bpf/progs/exceptions_cleanup_fail.c       | 154 ++++++
> > > >  .../selftests/bpf/progs/exceptions_fail.c     |  13 -
> > > >  6 files changed, 689 insertions(+), 13 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > > > index 5c2cc7e8c5d0..6fc79727cd14 100644
> > > > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > > > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > > > @@ -1,6 +1,7 @@
> > > >  bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> > > >  bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> > > >  exceptions                                    # JIT does not support calling kfunc bpf_throw: -524
> > > > +exceptions_unwind                             # JIT does not support calling kfunc bpf_throw: -524
> > > >  fexit_sleep                                      # The test never returns. The remaining tests cannot start.
> > > >  kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
> > > >  kprobe_multi_test                                # needs CONFIG_FPROBE
> > > > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> > > > index 1a63996c0304..f09a73dee72c 100644
> > > > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > > > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > > > @@ -1,5 +1,6 @@
> > > >  # TEMPORARY
> > > >  # Alphabetical order
> > > >  exceptions                            # JIT does not support calling kfunc bpf_throw                                (exceptions)
> > > > +exceptions_unwind                     # JIT does not support calling kfunc bpf_throw                                (exceptions)
> > > >  get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
> > > >  stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> > > > new file mode 100644
> > > > index 000000000000..78df037b60ea
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> > > > @@ -0,0 +1,65 @@
> > > > +#include "bpf/bpf.h"
> > > > +#include "exceptions.skel.h"
> > > > +#include <test_progs.h>
> > > > +#include <network_helpers.h>
> > > > +
> > > > +#include "exceptions_cleanup.skel.h"
> > > > +#include "exceptions_cleanup_fail.skel.h"
> > > > +
> > > > +static void test_exceptions_cleanup_fail(void)
> > > > +{
> > > > +     RUN_TESTS(exceptions_cleanup_fail);
> > > > +}
> > > > +
> > > > +void test_exceptions_cleanup(void)
> > > > +{
> > > > +     LIBBPF_OPTS(bpf_test_run_opts, ropts,
> > > > +             .data_in = &pkt_v4,
> > > > +             .data_size_in = sizeof(pkt_v4),
> > > > +             .repeat = 1,
> > > > +     );
> > > > +     struct exceptions_cleanup *skel;
> > > > +     int ret;
> > > > +
> > > > +     if (test__start_subtest("exceptions_cleanup_fail"))
> > > > +             test_exceptions_cleanup_fail();
> > >
> > > RUN_TESTS takes care of doing test__start_subtest(), etc. You should be
> > > able to just call RUN_TESTS(exceptions_cleanup_fail) directly here.
> > >
> >
> > Ack, will fix.
> >
> > > > +
> > > > +     skel = exceptions_cleanup__open_and_load();
> > > > +     if (!ASSERT_OK_PTR(skel, "exceptions_cleanup__open_and_load"))
> > > > +             return;
> > > > +
> > > > +     ret = exceptions_cleanup__attach(skel);
> > > > +     if (!ASSERT_OK(ret, "exceptions_cleanup__attach"))
> > > > +             return;
> > > > +
> > > > +#define RUN_EXC_CLEANUP_TEST(name)                                      \
> > >
> > > Should we add a call to if (test__start_subtest(#name)) to this macro?
> > >
> >
> > Makes sense, will change this.
> >
> > > > [...]
> > > > +
> > > > +SEC("tc")
> > > > +int exceptions_cleanup_percpu_obj(struct __sk_buff *ctx)
> > > > +{
> > > > +    struct { int i; } *p;
> > > > +
> > > > +    p = bpf_percpu_obj_new(typeof(*p));
> > > > +    MARK_RESOURCE(&p, RES_SPILL);
> > > > +    bpf_throw(VAL);
> > >
> > > It would be neat if we could have the bpf_throw() kfunc signature be
> > > marked as __attribute__((noreturn)) and have things work correctly;
> > > meaning you wouldn't have to even return a value here. The verifier
> > > should know that bpf_throw() is terminal, so it should be able to prune
> > > any subsequent instructions as unreachable anyways.
> > >
> >
> > Originally, I was tagging the kfunc as noreturn, but Alexei advised
> > against it in
> > https://lore.kernel.org/bpf/CAADnVQJtUD6+gYinr+6ensj58qt2LeBj4dvT7Cyu-aBCafsP5g@mail.gmail.com
> > ... so I have dropped it since.
>
> I see. Ok, we can ignore this for now, though I think we should consider
> revisiting this at some point once we've clarified the rules behind the
> implicit prologue/epilogue. Being able to actually specify noreturn
> really can make a difference in performance in some cases.
>

I agree. I will add this to my TODO list to explore after this set is merged.

> [...]
> > > > +
> > > > +SEC("tc")
> > > > +int exceptions_cleanup_reg(struct __sk_buff *ctx)
> > > > +{
> > > > +    void *p;
> > > > +
> > > > +    p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
> > > > +    MARK_RESOURCE(p, RES_REG);
> > > > +    bpf_throw(VAL);
> > > > +    if (p)
> > > > +        bpf_ringbuf_discard(p, 0);
> > >
> > > Does the prog fail to load if you don't have this bpf_ringbuf_discard()
> > > check? I assume not given that in
> > > exceptions_cleanup_null_or_ptr_do_ptr() and elsewhere we do a reserve
> > > without discarding. Is there some subtle stack state difference here or
> > > something?
> > >
> >
> > So I will add comments explaining this, since I realized this confused
> > you in a couple of places, but basically if I didn't do a discard
> > here, the compiler wouldn't save the value of p across the bpf_throw
> > call. So it may end up in some caller-saved register (R1-R5) and since
> > bpf_throw needs things to be either saved in the stack or in
> > callee-saved regs (R6-R9) to be able to do the stack unwinding, we
> > would not be able to test the case where the resource is held in
> > R6-R9.
> >
> > In a correctly written program, in the path where bpf_throw is not
> > done, you will always have some cleanup code (otherwise your program
> > wouldn't pass), so the value should always end up being preserved
> > across a bpf_throw call (this is kind of why Alexei was sort of
> > worried about noreturn, because in that case the compiler may decide
> > to not preserve it for the bpf_throw path).
> > You cannot just leak a resource acquired before bpf_throw in the path
> > where exception is not thrown.
>
> Ok, that makes sense. I suppose another way to frame this would be to
> consider it in a typical scheduling scenario:
>
> struct task_ctx *lookup_task_ctx(struct task_struct *p)
> {
>         struct task_ctx *taskc;
>         s32 pid = p->pid;
>
>         taskc = bpf_map_lookup_elem(&task_data, &pid);
>         if (!taskc)
>                 bpf_throw(-ENOENT); // Verifier
>
>         return taskc;
> }
>
> void BPF_STRUCT_OPS(sched_stopping, struct task_struct *p, bool runnable)
> {
>         struct task_ctx *taskc;
>
>         taskc = lookup_task_ctx(p)
>
>         /* scale the execution time by the inverse of the weight and charge */
>         p->scx.dsq_vtime +=
>                 (bpf_ktime_get_ns() - taskc->running_at) * 100 / p->scx.weight;
> }
>
> We're not dropping a reference here, but taskc is preserved across the
> bpf_throw() path, so the same idea applies.
>

Yeah, I will add an example like this to the selftests to make sure we
also exercise such a pattern.

> > Also,  I think the test is a bit fragile, I should probably rewrite it
> > in inline assembly, because while the compiler chooses to hold it in a
> > register here, it is not bound to do so in this case.
>
> To that point, I wonder if it would be useful or possible to come up with some
> kind of a macro that allows us to specify a list of variables that must be
> preserved after a bpf_throw() call? Not sure how or if that would work exactly.
>

I think it can be useful, supposedly if we can force the compiler to
do a spill to the stack, that will be enough to enable unwinding.
But we should probably come back to this in case we see there are
certain compiler optimizations causing trouble.
Otherwise it's unnecessary cognitive overhead for someone writing a
program to have to explicitly mark variables like this.

> > > >  [...]
> > > >
> > > > -SEC("?tc")
> > > > -__failure __msg("Unreleased reference")
> > > > -int reject_with_reference(void *ctx)
> > > > -{
> > > > -     struct foo *f;
> > > > -
> > > > -     f = bpf_obj_new(typeof(*f));
> > > > -     if (!f)
> > > > -             return 0;
> > > > -     bpf_throw(0);
> > >
> > > Hmm, so why is this a memory leak exactly? Apologies if this is already
> > > explained clearly elsewhere in the stack.
> > >
> >
> > I will add comments around some of these to better explain this in the
> > non-RFC v1.
> > Basically, this program is sort of unrealistic (since it's always
> > throwing, and not really cleaning up the object since there is no
> > other path except the one with bpf_throw). So the compiler ends up
> > putting 'f' in a caller-saved register, during release_reference we
> > don't find it after bpf_throw has been processed (since caller-saved
> > regs have been cleared due to kfunc processing, and we generate frame
> > descriptors after check_kfunc_call, basically simulating the state
> > where only preserved state after the call is observed at runtime), but
> > the reference state still lingers around for 'f', so you get this
> > "Unreleased reference" error later when check_reference_leak is hit.
> >
> > It's just trying to exercise the case where the pointer tied to a
> > reference state has been lost in verifier state, and that we return an
> > error in such a case and don't succeed in verifying the program
> > accidently (because there is no way we can recover the value to free
> > at runtime).
>
> Makes total sense, thanks a lot for explaining!
>
> This looks great, I'm really excited to use it.

Thanks for the review! Will respin addressing your comments after
waiting for a day or two.

