Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93A76AB3A1
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 01:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCFAMi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 19:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCFAMh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 19:12:37 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0FCE05D
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 16:12:32 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i10so8441625plr.9
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 16:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ls4aaDI7WxZWmKXfMyY0vfmHboNK9emRyfda7VuIjmI=;
        b=QGoaR8YDg8au+hYnnQaowVZWLRBWbfFbF6/PijJifp7q2vXXonX4bUDP9FzXb6/9Nd
         LgrqqDPMvt1/ihh/4JTW5qH8uEf0bazQNFvxvb2PhlaOtzuwk4rFmxiI+IM1EYKaVO+v
         YSsVWYWaatGu1jmCw7NepPZ2WFFL3YZsijpbiLUDZEI67Kfg4VBP95H87Z9IrJ3/nPHR
         IZQn/Jd0PyQnxQH55nhAZji7eG13xzd1avtnFIfblpXRY9zhEqapJ6yJGo5uKNrTe2MF
         tUupzTgUx5LtgSWQqpNV2wlC8iEDgrs6nDEDbglqebtG8NKsX7gx1H7KehHJQjsObdoe
         Zfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ls4aaDI7WxZWmKXfMyY0vfmHboNK9emRyfda7VuIjmI=;
        b=1cYbUxiBYEoXWvuqQIvy0K27veoem5IGwYc8TNQXxYgJp85NkZQREfRji/oZEMHWR9
         +2YutYnoyCGODl6HEz3FLM2qOOVK1fD0WI7/iAr1Hi8UmqjUMhtVwFTAHxKS7duNrhFA
         T1dbIw8EoGxzeltycByX3Ww3qyE8Oa3I+Jicsyyx0hKhHrH5IW9PZSf0FgVGMTQ4p6zX
         69FWf2Qc/D9XZhuflmjZK6b46kSZWFVvcNa8eDuDQmNPBZ/vjiug5p1oJC7Oeg+df6fV
         eBID9IqGqc/YJl8EqHiMJMk7za9mW2oYiEnro8wkm9PdvGBO/8CPcYpoe9u2RjVzwmp2
         R3zw==
X-Gm-Message-State: AO0yUKUxKzb2NKsnOAD8RhEbxaG3ZqXQX+ynRP2sHDJiS7z97QE+NwSY
        /T/Pv0kj0R+zsq63v9/Vj40=
X-Google-Smtp-Source: AK7set+zxGMTm2QpbjCKeySDJFhR4tXsoCFyVkK2tL0YnZaGm8pIHWk4a9iOaV3fbCsLKPZpPwWX9Q==
X-Received: by 2002:a17:902:d70c:b0:19e:72e5:e058 with SMTP id w12-20020a170902d70c00b0019e72e5e058mr8342475ply.48.1678061551875;
        Sun, 05 Mar 2023 16:12:31 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:59fc])
        by smtp.gmail.com with ESMTPSA id kt16-20020a170903089000b0019a7385079esm5236394plb.123.2023.03.05.16.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 16:12:31 -0800 (PST)
Date:   Sun, 5 Mar 2023 16:12:28 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 15/17] selftests/bpf: add bpf_for_each(),
 bpf_for(), and bpf_repeat() macros
Message-ID: <20230306001228.mpu4f6l5uosoo26v@MacBook-Pro-6.local>
References: <20230302235015.2044271-1-andrii@kernel.org>
 <20230302235015.2044271-16-andrii@kernel.org>
 <20230304203406.ynvl5hmmekvo42uj@MacBook-Pro-6.local>
 <CAEf4BzZG+KsUuJfYboiesRHegZAf13CCr4VxUKeRNfgSXmShXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZG+KsUuJfYboiesRHegZAf13CCr4VxUKeRNfgSXmShXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 04, 2023 at 03:28:03PM -0800, Andrii Nakryiko wrote:
> On Sat, Mar 4, 2023 at 12:34 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 02, 2023 at 03:50:13PM -0800, Andrii Nakryiko wrote:
> > > Add bpf_for_each(), bpf_for() and bpf_repeat() macros that make writing
> > > open-coded iterator-based loops much more convenient and natural. These
> > > macro utilize cleanup attribute to ensure proper destruction of the
> > > iterator and thanks to that manage to provide an ergonomic very close to
> > > C language for construct. Typical integer loop would look like:
> > >
> > >   int i;
> > >   int arr[N];
> > >
> > >   bpf_for(i, 0, N) {
> > >   /* verifier will know that i >= 0 && i < N, so could be used to
> > >    * directly access array elements with no extra checks
> > >    */
> > >    arr[i] = i;
> > >   }
> > >
> > > bpf_repeat() is very similar, but it doesn't expose iteration number and
> > > is mean as a simple "repeat action N times":
> > >
> > >   bpf_repeat(N) { /* whatever */ }
> > >
> > > Note that break and continue inside the {} block work as expected.
> > >
> > > bpf_for_each() is a generalization over any kind of BPF open-coded
> > > iterator allowing to use for-each-like approach instead of calling
> > > low-level bpf_iter_<type>_{new,next,destroy}() APIs explicitly. E.g.:
> > >
> > >   struct cgroup *cg;
> > >
> > >   bpf_for_each(cgroup, cg, some, input, args) {
> > >       /* do something with each cg */
> > >   }
> > >
> > > Would call (right now hypothetical) bpf_iter_cgroup_{new,next,destroy}()
> > > functions to form a loop over cgroups, where `some, input, args` are
> > > passed verbatim into constructor as
> > > bpf_iter_cgroup_new(&it, some, input, args).
> > >
> > > As a demonstration, add pyperf variant based on bpf_for() loop.
> > >
> > > Also clean up few tests that either included bpf_misc.h header
> > > unnecessarily from user-space or included it before any common types are
> > > defined.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  .../bpf/prog_tests/bpf_verif_scale.c          |  6 ++
> > >  .../bpf/prog_tests/uprobe_autoattach.c        |  1 -
> > >  tools/testing/selftests/bpf/progs/bpf_misc.h  | 76 +++++++++++++++++++
> > >  tools/testing/selftests/bpf/progs/lsm.c       |  4 +-
> > >  tools/testing/selftests/bpf/progs/pyperf.h    | 14 +++-
> > >  .../selftests/bpf/progs/pyperf600_iter.c      |  7 ++
> > >  .../selftests/bpf/progs/pyperf600_nounroll.c  |  3 -
> > >  7 files changed, 101 insertions(+), 10 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_iter.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> > > index 5ca252823294..731c343897d8 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> > > @@ -144,6 +144,12 @@ void test_verif_scale_pyperf600_nounroll()
> > >       scale_test("pyperf600_nounroll.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
> > >  }
> > >
> > > +void test_verif_scale_pyperf600_iter()
> > > +{
> > > +     /* open-coded BPF iterator version */
> > > +     scale_test("pyperf600_iter.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
> > > +}
> > > +
> > >  void test_verif_scale_loop1()
> > >  {
> > >       scale_test("loop1.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> > > index 6558c857e620..d5b3377aa33c 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> > > @@ -3,7 +3,6 @@
> > >
> > >  #include <test_progs.h>
> > >  #include "test_uprobe_autoattach.skel.h"
> > > -#include "progs/bpf_misc.h"
> > >
> > >  /* uprobe attach point */
> > >  static noinline int autoattach_trigger_func(int arg1, int arg2, int arg3,
> > > diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> > > index f704885aa534..08a791f307a6 100644
> > > --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> > > +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> > > @@ -75,5 +75,81 @@
> > >  #define FUNC_REG_ARG_CNT 5
> > >  #endif
> > >
> > > +struct bpf_iter;
> > > +
> > > +extern int bpf_iter_num_new(struct bpf_iter *it__uninit, int start, int end) __ksym;
> > > +extern int *bpf_iter_num_next(struct bpf_iter *it) __ksym;
> > > +extern void bpf_iter_num_destroy(struct bpf_iter *it) __ksym;
> > > +
> > > +#ifndef bpf_for_each
> > > +/* bpf_for_each(iter_kind, elem, args...) provides generic construct for using BPF
> > > + * open-coded iterators without having to write mundane explicit low-level
> > > + * loop. Instead, it provides for()-like generic construct that can be used
> > > + * pretty naturally. E.g., for some hypothetical cgroup iterator, you'd write:
> > > + *
> > > + * struct cgroup *cg, *parent_cg = <...>;
> > > + *
> > > + * bpf_for_each(cgroup, cg, parent_cg, CG_ITER_CHILDREN) {
> > > + *     bpf_printk("Child cgroup id = %d", cg->cgroup_id);
> > > + *     if (cg->cgroup_id == 123)
> > > + *         break;
> > > + * }
> > > + *
> > > + * I.e., it looks almost like high-level for each loop in other languages,
> > > + * supports continue/break, and is verifiable by BPF verifier.
> > > + *
> > > + * For iterating integers, the difference betwen bpf_for_each(num, i, N, M)
> > > + * and bpf_for(i, N, M) is in that bpf_for() provides additional proof to
> > > + * verifier that i is in [N, M) range, and in bpf_for_each() case i is `int
> > > + * *`, not just `int`. So for integers bpf_for() is more convenient.
> > > + */
> > > +#define bpf_for_each(type, cur, args...) for (                                                 \
> > > +     /* initialize and define destructor */                                            \
> > > +     struct bpf_iter ___it __attribute__((cleanup(bpf_iter_##type##_destroy))),        \
> >
> > We should probably say somewhere that it requires C99 with some flag that allows
> > declaring variables inside the loop.
> 
> yes, I'll add a comment. I think cleanup attribute isn't standard as
> well, I'll mention it. This shouldn't be restrictive, though, as we
> expect very modern Clang (or eventually GCC), which definitely will
> support all of that. And I feel like most people don't restrict their
> BPF-side code to strict C89 anyways.

yep. No UX concerns. A comment to manage expectations should be enough.

> >
> > Also what are the rules for attr(cleanup()).
> > When does it get called?
> 
> From GCC documentation:
> 
>   > The cleanup attribute runs a function when the variable goes out of scope.
> 
> So given ___it is bound to for loop, any code path that leads to loop
> exit (so, when condition turns false or *breaking* out of the loop,
> which is why I use cleanup, this was a saving grace for this approach
> to work at all).

+1

> 
> > My understanding that the visibility of ___it is only within for() body.
> 
> right
> 
> > So when the prog does:
> > bpf_for(i, 0, 10) sum += i;
> > bpf_for(i, 0, 10) sum += i;
> >
> > the compiler should generate bpf_iter_num_destroy right after each bpf_for() ?
> 
> Conceptually, yes, but see the note about breaking out of the loop
> above. How actual assembly code is generated is beyond our control. If
> the compiler generates multiple separate code paths, each with its own
> destroy, that's fine as well. No assumptions are made in the verifier,
> we just need to see one bpf_iter_<type>_destroy() for each instance of
> iterator.
> 
> > Or will it group them at the end of function body and destroy all iterators ?
> 
> That would be a bug, as documentation states that clean up happens as
> soon as a variable goes out of scope. Delaying clean up could result
> in program logic bugs. I.e., we rely on destructors to be called as
> soon as possible.
> 
> > Will compiler reuse the stack space used by ___it in case there are multiple bpf_for-s ?
> 
> That's the question to compiler developers, but I'd assume that, yes,
> it should. Why not?
> 
> And looking at, for example, iter_pass_iter_ptr_to_subprog which has 4
> sequential bpf_for() loops:
> 
> 0000000000002328 <iter_pass_iter_ptr_to_subprog>:
>     1125:       bf a6 00 00 00 00 00 00 r6 = r10
>     1126:       07 06 00 00 28 ff ff ff r6 += -216    <-- THIS IS ITER
>     1127:       bf 61 00 00 00 00 00 00 r1 = r6
>     1128:       b4 02 00 00 00 00 00 00 w2 = 0
>     1129:       b4 03 00 00 10 00 00 00 w3 = 16
>     1130:       85 10 00 00 ff ff ff ff call -1
>                 0000000000002350:  R_BPF_64_32  bpf_iter_num_new
>     1131:       bf a7 00 00 00 00 00 00 r7 = r10
>     1132:       07 07 00 00 c0 ff ff ff r7 += -64
>     1133:       bf 61 00 00 00 00 00 00 r1 = r6
>     1134:       bf 72 00 00 00 00 00 00 r2 = r7
>     1135:       b4 03 00 00 10 00 00 00 w3 = 16
>     1136:       b4 04 00 00 02 00 00 00 w4 = 2
>     1137:       85 10 00 00 53 00 00 00 call 83
>                 0000000000002388:  R_BPF_64_32  .text
>     1138:       bf 61 00 00 00 00 00 00 r1 = r6
>     1139:       85 10 00 00 ff ff ff ff call -1
>                 0000000000002398:  R_BPF_64_32  bpf_iter_num_destroy
>     1140:       bf 61 00 00 00 00 00 00 r1 = r6     <<--- HERE WE REUSE
>     1141:       b4 02 00 00 00 00 00 00 w2 = 0
>     1142:       b4 03 00 00 20 00 00 00 w3 = 32
>     1143:       85 10 00 00 ff ff ff ff call -1
>                 00000000000023b8:  R_BPF_64_32  bpf_iter_num_new
> 
> Note that r6 is set to fp-216 and is just reused as is for second
> bpf_for loop (second bpf_iter_num_new) call.

Great. Thanks for checking. I was worried that attr(cleanup) will force compiler to think
that different objects cannot reuse the stack slots which will lead to stack exhaustion.
Especially with 24-bytes bpf_iter-s and our tiny 512 limit.

> >
> > > +     /* ___p pointer is just to call bpf_iter_##type##_new() *once* to init ___it */   \
> > > +                     *___p = (bpf_iter_##type##_new(&___it, ##args),           \
> > > +     /* this is a workaround for Clang bug: it currently doesn't emit BTF */           \
> > > +     /* for bpf_iter_##type##_destroy when used from cleanup() attribute */            \
> > > +                             (void)bpf_iter_##type##_destroy, (void *)0);              \
> > > +     /* iteration and termination check */                                             \
> > > +     ((cur = bpf_iter_##type##_next(&___it)));                                         \
> > > +     /* nothing here  */                                                               \
> > > +)
> > > +#endif /* bpf_for_each */
> > > +
> > > +#ifndef bpf_for
> > > +/* bpf_for(i, start, end) proves to verifier that i is in [start, end) */
> > > +#define bpf_for(i, start, end) for (                                                   \
> > > +     /* initialize and define destructor */                                            \
> > > +     struct bpf_iter ___it __attribute__((cleanup(bpf_iter_num_destroy))),             \
> > > +     /* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */   \
> > > +                     *___p = (bpf_iter_num_new(&___it, (start), (end)),                \
> > > +     /* this is a workaround for Clang bug: it currently doesn't emit BTF */           \
> > > +     /* for bpf_iter_num_destroy when used from cleanup() attribute */                 \
> > > +                             (void)bpf_iter_num_destroy, (void *)0);                   \
> > > +     ({                                                                                \
> > > +             /* iteration step */                                                      \
> > > +             int *___t = bpf_iter_num_next(&___it);                                    \
> > > +             /* termination and bounds check */                                        \
> > > +             (___t && ((i) = *___t, i >= (start) && i < (end)));                       \
> >
> > The i >= (start) && i < (end) is necessary to make sure that the verifier
> > tightens the range of 'i' inside the body of the loop and
> > when the program does arr[i] access the verifier will know that 'i' is within bounds, right?
> 
> yes, it feels like a common pattern, but I was contemplating to add
> bpf_for_uncheck() where we "expose" i value, but don't do check. I
> decided to keep it simple, as most examples actually required bounds
> checks anyways. And for cases where we don't, often bpf_repeat()
> suffices. One other way would be to expose i from bpf_repeat(), just
> no checks.
> 
> One restriction with this approach is that I can't define both `struct
> bpf_iter __it` and `int i` inside for loop, so cur/i has to be
> declared and passed into bpf_for/bpf_for_each by user explicitly. So
> for bpf_repeat() to expose i would require always doing:
> 
> int i;
> 
> bpf_repeat(i, 100) { /* i is set to 0, 1, ..., 99 */ }
> 
> which, if you don't care about iteration number, is a bit of waste. So
> don't know, I'm undecided on bpf_repeat with i.

It feels that the proposed bpf_repeat() without 'i' is cleaner.

> >
> > In such case should we add __builtin_constant_p() check for 'start' and 'end' ?
> 
> that seems to defy the purpose, as if you know start/end statically,
> you might as well just write either unrolled loop or bounded for()
> loop
> 
> > int arr[100];
> > if (var < 100)
> >   bpf_for(i, 0, global_var) sum += arr[i];
> > will fail the verifier and the users might complain of dumb verifier.
> 
> 
> but I'm not following this example, so maybe the answer to above would
> be different if I would. What's var and global_var? 

typo. I meant the same var in both places.

> Are they supposed
> to be the same thing? If yes, why would that bpf_for() loop fail?
> 
> I suspect you are conflating the other pattern I pointed out with:
> 
> int cnt = 0;
> 
> bpf_for_each(...) {
>    if (cnt++ > 100)
>       break;
> }
> 
> It's different, as cnt comes from outside the loop and is updated on
> each iteration. While for
> 
> bpf_for(i, 0, var) {
>    if (i > 100)
>         break;
> }
> 
> it should work fine, as i is originally unknowable, then narrowed to
> *a range* [0, 99]. But that [0, 99] knowledge is part of "inner loop
> body" state, so it will still converge as it's going to be basically
> ignored during the equivalence check on next bpf_iter_num_next() (old
> state didn't know about i yet).
> 
> >
> > Also if start and end are variables they potentially can change between bpf_iter_num_new()
> > and in each iteration of the loop.
> > __builtin_constant_p() might be too restrictive.
> 
> yep, I think so
> 
> > May be read start/end once, at least?
> 
> I can't do that, as for() allows only one type of variables to be
> defined (note `*___p` hack as well), so there is no place to remember
> start/end, unfortunately...

I see. Abusing bpf_iter like:
for (struct bpf_iter_num __it, *___p, start_end = (struct bpf_iter_num) {start, end};
is probably too ugly just to READ_ONCE(start).
Especially since bpf_iter_num is opaque.

Please add a comment to warn users that if start/end are variables they
better not change during bpf_for().
I guess plain C loop: for (int i = 0; i < j; i++) will go crazy too if 'j' changes.
I'm not sure what standard says here.
Whether compiler has to reload 'j' every iteration or not.

> So it's a tradeoff. I can drop range validation, but then every
> example and lots of production code would be re-checking these
> conditions.

Understood. Keep it as-is.

> >
> > > +     });                                                                               \
> > > +     /* nothing here  */                                                               \

btw that 'nothing here' comment is distracting when reading this macro.
