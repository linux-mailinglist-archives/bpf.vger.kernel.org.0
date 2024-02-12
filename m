Return-Path: <bpf+bounces-21789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A945B8521AA
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FE31C22798
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F74DA1C;
	Mon, 12 Feb 2024 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3hjNH+j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF24F881
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777862; cv=none; b=QfWhJ+zKU9K48j3Va1Grt8F4H0dyJ6RuaToITMq6ntfpSygA5qcl1kh8evcSZAmeU6kmbjYFqbJnbSMrEjwNwWLgdfKHvfILhu4qRaKT2uq0/0x+W3bbzMWB208cDqv/vY4yTFifNc3MAEvupfgeHPZO7GWclg+jel3nFRIwY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777862; c=relaxed/simple;
	bh=p0KjmU+zk4tU/TulkT2V/Fihi6eqlOBbJiWYTJ0hbVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSfoMHVQdxQO2N4gFaw7Do0Xuz6Ciqe/IstiOIbXG66HoPVhgKCBbuT38Pykk0e4eZYGKFaTfSue07UT/rljggDjUOkXFR0ubvzF12G63hAZ6krWHtxRvtdlLPR2Tmh963Xty3N8jhYP4wanIsuBZq2Ysot4e4Mi+MrVKADJZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3hjNH+j; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a38271c0bd5so461584866b.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707777859; x=1708382659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d2tT+n21Q2FzsMdiTfouruiIsOYzJZciA5r7lVvKyrk=;
        b=E3hjNH+jp5OgiO8CbuAOSiD0CGaUIyWDMJFmVarF2rSRIJYDb7fNQ+GOhI4ocwTUUu
         SchyyeZiXfneZHXoqFqt9745JZi6KHAijboJU900KraAS28Ly7MnnkMb6PMC8rAv6zlg
         OhDkh57Mk8aCcvC8VvU40w2Ec8WWdGWl/jS2odd2hHfQ0Jujr1/V2xqOP0ic2aWf6B3b
         Zed0x8aGXldb1ZH9CxHjndXKGYXMYW0UYH+gOqkRMuDnitk9Q1/QrxI0oPcQIrLHGSiW
         BluF3TUgmpvpPdzB5UM4o26EMjiWnSQOv8ckwuSU7FB3zPpP+B97k+Ed4hOIIuvbwM+s
         RDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777859; x=1708382659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2tT+n21Q2FzsMdiTfouruiIsOYzJZciA5r7lVvKyrk=;
        b=AeONeCPr7GpcBlBuebj1NNWaHlFyd8LEc4Q3P1jekxCN6hcAHkuIxSHMxgsn8Ix9D1
         0Q4zBs5x18rW/R6lEt5H+uP79ujCYeHAu5HSpJxMQ9PHvZsoCaV6tyB3yFstTXK/aqqd
         Ahwfa7cD6dOEMWoCj8EQXXpGFlesGAwVs2PVyzpugBt9CZmuFXOddiGcdSpyBqKTMl3Q
         /c1dSDdeDrxLg1vfsMO5JVQb029QL0UM4ofmjFFaDmzc+BzUqnViYa5DJoARmDkhc/OA
         xxrDgzmLsD5hmJRt8vB+vOTL0rwq3n8TmcNvldk1TyWl7H7SygobDFbztDeXKpZ7TuuI
         Z5og==
X-Gm-Message-State: AOJu0YwnFER+w6Oxhy0JUMS62R+74mNC6GDzucrKPoTIpfq5DtlSqeUi
	xB9qJpoUO15JnUz7LdFx925PQbhXAPKGkvh79iuBFjeePWxFRI8W1OPH+7Vl7gFRjtiqGi+QyBw
	j6FgdcawkGPiODjtYySXcgHczmmM=
X-Google-Smtp-Source: AGHT+IGT+hhisqnM2tvJBCRQ80N88AhE62cwEozXSwqozEHg8LvPhBdqAJzhkZYiFJaW9rw7g5K4iQWxCw5GRZn7LQc=
X-Received: by 2002:a17:906:f14c:b0:a3c:d5e6:7e82 with SMTP id
 gw12-20020a170906f14c00b00a3cd5e67e82mr1582999ejb.55.1707777858746; Mon, 12
 Feb 2024 14:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-15-memxor@gmail.com>
 <20240212205314.GC2200361@maniforge.lan>
In-Reply-To: <20240212205314.GC2200361@maniforge.lan>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 Feb 2024 23:43:42 +0100
Message-ID: <CAP01T76hX2jxHiJ_iiWSj7Wgu5t4RL48-eLGJmEtik9GR0rq6g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 14/14] selftests/bpf: Add tests for exceptions
 runtime cleanup
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, 
	Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 21:53, David Vernet <void@manifault.com> wrote:
>
> On Thu, Feb 01, 2024 at 04:21:09AM +0000, Kumar Kartikeya Dwivedi wrote:
> > Add tests for the runtime cleanup support for exceptions, ensuring that
> > resources are correctly identified and released when an exception is
> > thrown. Also, we add negative tests to exercise corner cases the
> > verifier should reject.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
> >  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
> >  .../bpf/prog_tests/exceptions_cleanup.c       |  65 +++
> >  .../selftests/bpf/progs/exceptions_cleanup.c  | 468 ++++++++++++++++++
> >  .../bpf/progs/exceptions_cleanup_fail.c       | 154 ++++++
> >  .../selftests/bpf/progs/exceptions_fail.c     |  13 -
> >  6 files changed, 689 insertions(+), 13 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > index 5c2cc7e8c5d0..6fc79727cd14 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > @@ -1,6 +1,7 @@
> >  bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> >  bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> >  exceptions                                    # JIT does not support calling kfunc bpf_throw: -524
> > +exceptions_unwind                             # JIT does not support calling kfunc bpf_throw: -524
> >  fexit_sleep                                      # The test never returns. The remaining tests cannot start.
> >  kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
> >  kprobe_multi_test                                # needs CONFIG_FPROBE
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> > index 1a63996c0304..f09a73dee72c 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > @@ -1,5 +1,6 @@
> >  # TEMPORARY
> >  # Alphabetical order
> >  exceptions                            # JIT does not support calling kfunc bpf_throw                                (exceptions)
> > +exceptions_unwind                     # JIT does not support calling kfunc bpf_throw                                (exceptions)
> >  get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
> >  stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> > new file mode 100644
> > index 000000000000..78df037b60ea
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> > @@ -0,0 +1,65 @@
> > +#include "bpf/bpf.h"
> > +#include "exceptions.skel.h"
> > +#include <test_progs.h>
> > +#include <network_helpers.h>
> > +
> > +#include "exceptions_cleanup.skel.h"
> > +#include "exceptions_cleanup_fail.skel.h"
> > +
> > +static void test_exceptions_cleanup_fail(void)
> > +{
> > +     RUN_TESTS(exceptions_cleanup_fail);
> > +}
> > +
> > +void test_exceptions_cleanup(void)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, ropts,
> > +             .data_in = &pkt_v4,
> > +             .data_size_in = sizeof(pkt_v4),
> > +             .repeat = 1,
> > +     );
> > +     struct exceptions_cleanup *skel;
> > +     int ret;
> > +
> > +     if (test__start_subtest("exceptions_cleanup_fail"))
> > +             test_exceptions_cleanup_fail();
>
> RUN_TESTS takes care of doing test__start_subtest(), etc. You should be
> able to just call RUN_TESTS(exceptions_cleanup_fail) directly here.
>

Ack, will fix.

> > +
> > +     skel = exceptions_cleanup__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "exceptions_cleanup__open_and_load"))
> > +             return;
> > +
> > +     ret = exceptions_cleanup__attach(skel);
> > +     if (!ASSERT_OK(ret, "exceptions_cleanup__attach"))
> > +             return;
> > +
> > +#define RUN_EXC_CLEANUP_TEST(name)                                      \
>
> Should we add a call to if (test__start_subtest(#name)) to this macro?
>

Makes sense, will change this.

> > [...]
> > +
> > +SEC("tc")
> > +int exceptions_cleanup_percpu_obj(struct __sk_buff *ctx)
> > +{
> > +    struct { int i; } *p;
> > +
> > +    p = bpf_percpu_obj_new(typeof(*p));
> > +    MARK_RESOURCE(&p, RES_SPILL);
> > +    bpf_throw(VAL);
>
> It would be neat if we could have the bpf_throw() kfunc signature be
> marked as __attribute__((noreturn)) and have things work correctly;
> meaning you wouldn't have to even return a value here. The verifier
> should know that bpf_throw() is terminal, so it should be able to prune
> any subsequent instructions as unreachable anyways.
>

Originally, I was tagging the kfunc as noreturn, but Alexei advised
against it in
https://lore.kernel.org/bpf/CAADnVQJtUD6+gYinr+6ensj58qt2LeBj4dvT7Cyu-aBCafsP5g@mail.gmail.com
... so I have dropped it since.

Right now, the verifier will do dead code elimination ofcourse, but
sometimes the compiler does generate code that is tricky or unexpected
(like putting the bpf_throw instruction as the final one instead of
exit or jmp if somehow it can prove that bpf_throw will be taken by
all paths) for the verifier if the bpf_throw is noreturn. Even though
this would have the same effect at runtime (if the analysis of the
compiler is not wrong), there were some places we would have to modify
so that the compiler does not get confused.

Overall I'm not opposed to this, but I think we need more consensus
before flipping the flag. Since this can be changed later and the
necessary changes can be made in the verifier (just a couple of places
which expect exit or jmp to final insns), I decided to move ahead
without noreturn.

> > +    return !p;
> > +}
> > +
> > +SEC("tc")
> > +int exceptions_cleanup_ringbuf(struct __sk_buff *ctx)
> > +{
> > +    void *p;
> > +
> > +    p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
> > +    MARK_RESOURCE(&p, RES_SPILL);
> > +    bpf_throw(VAL);
> > +    return 0;
> > +}
> > +
> > +SEC("tc")
> > +int exceptions_cleanup_reg(struct __sk_buff *ctx)
> > +{
> > +    void *p;
> > +
> > +    p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
> > +    MARK_RESOURCE(p, RES_REG);
> > +    bpf_throw(VAL);
> > +    if (p)
> > +        bpf_ringbuf_discard(p, 0);
>
> Does the prog fail to load if you don't have this bpf_ringbuf_discard()
> check? I assume not given that in
> exceptions_cleanup_null_or_ptr_do_ptr() and elsewhere we do a reserve
> without discarding. Is there some subtle stack state difference here or
> something?
>

So I will add comments explaining this, since I realized this confused
you in a couple of places, but basically if I didn't do a discard
here, the compiler wouldn't save the value of p across the bpf_throw
call. So it may end up in some caller-saved register (R1-R5) and since
bpf_throw needs things to be either saved in the stack or in
callee-saved regs (R6-R9) to be able to do the stack unwinding, we
would not be able to test the case where the resource is held in
R6-R9.

In a correctly written program, in the path where bpf_throw is not
done, you will always have some cleanup code (otherwise your program
wouldn't pass), so the value should always end up being preserved
across a bpf_throw call (this is kind of why Alexei was sort of
worried about noreturn, because in that case the compiler may decide
to not preserve it for the bpf_throw path).
You cannot just leak a resource acquired before bpf_throw in the path
where exception is not thrown.

Also,  I think the test is a bit fragile, I should probably rewrite it
in inline assembly, because while the compiler chooses to hold it in a
register here, it is not bound to do so in this case.

> >  [...]
> >
> > -SEC("?tc")
> > -__failure __msg("Unreleased reference")
> > -int reject_with_reference(void *ctx)
> > -{
> > -     struct foo *f;
> > -
> > -     f = bpf_obj_new(typeof(*f));
> > -     if (!f)
> > -             return 0;
> > -     bpf_throw(0);
>
> Hmm, so why is this a memory leak exactly? Apologies if this is already
> explained clearly elsewhere in the stack.
>

I will add comments around some of these to better explain this in the
non-RFC v1.
Basically, this program is sort of unrealistic (since it's always
throwing, and not really cleaning up the object since there is no
other path except the one with bpf_throw). So the compiler ends up
putting 'f' in a caller-saved register, during release_reference we
don't find it after bpf_throw has been processed (since caller-saved
regs have been cleared due to kfunc processing, and we generate frame
descriptors after check_kfunc_call, basically simulating the state
where only preserved state after the call is observed at runtime), but
the reference state still lingers around for 'f', so you get this
"Unreleased reference" error later when check_reference_leak is hit.

It's just trying to exercise the case where the pointer tied to a
reference state has been lost in verifier state, and that we return an
error in such a case and don't succeed in verifying the program
accidently (because there is no way we can recover the value to free
at runtime).

> [...]

