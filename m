Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AFF6AF816
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 22:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjCGVy7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 16:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjCGVyx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 16:54:53 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2D99279
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 13:54:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s11so58188699edy.8
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 13:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678226089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzFlGMQUCryhLj+uUrJf9wZmn1cYQKmfa8FeFSAa9d4=;
        b=C9PHT0X/Eo1avZ2cUIyOG7QrI2OTspn0bAdGuNphWaKfYzdDOyC5ygKjh377g7p+tv
         C2FA0ybvRPP24EAt82Llvj4iAqCRrsTnLCs/AhjGTIYsf1Q3YNVK9krhmJG/rxt9n0o/
         aaadF0QsnZ7+YadtLifaByfF8N9aT9AMr+Ct/NMU+lNjrO+iGdLeST8ZVEYDmkrdR3s4
         yPA+lMbHpvMUS+ZnQCnVq9h+/rtqGSh/NVYE03sslGUkSgiSQ+/A/dLLKKFW0YJRfSh8
         oF0DuFcmljbUj5joq2l3sZRDEk2dEZDC3Q1bXUhLTjPqZVXXTxCPUqGYJzyV04Bsso0Q
         vKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678226089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzFlGMQUCryhLj+uUrJf9wZmn1cYQKmfa8FeFSAa9d4=;
        b=cgYyFDkwqjmD6xZQZ0711jpkwI2xFQ5eYQiAf/fImO9GcuBLlwIrVvwUldiWYZBfAZ
         jkXtkd09tDrRHGubkjkn+nStbsAHL5vvJEV5AOkVCAOErDeSl8Xrnsze2YoiQ7DtENFY
         VBaM1vQDBX5l+p2HQiQMZZeXUv7ujSgwgo8GEUYdawmdKObKaQ7R63Dlrw6bkHEnLqiS
         a1XykJGX44vePuCPFG33uwE/8TzjedvTOQGbW236G1jFFJx1BLqHaMNt+ljRRCH/jM6m
         ES4vmFamOvlc3LsOJGp92/apRm/QpywLYDyynATheWH5oZS5Sltt7yNksb2Bot5S1t3O
         CXyA==
X-Gm-Message-State: AO0yUKWJQjSOfpiy2Ym26oHq2X9h1e/qhTLkh0VXqhwZUezIgl3P87fJ
        MPFXkq0KSitK0v/eSBkxfwC1vQIoi41yaeHlSbs=
X-Google-Smtp-Source: AK7set9fPA4ll1C46/Dho9zFM/ObGUdaSc43oNAC1vy85RekS1sQsKcZkhKBbaj1OnjrFBr2wHHnXCqUqcvsdMDIu6k=
X-Received: by 2002:a50:cd15:0:b0:4c1:1555:152f with SMTP id
 z21-20020a50cd15000000b004c11555152fmr8818828edi.5.1678226088937; Tue, 07 Mar
 2023 13:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20230302235015.2044271-1-andrii@kernel.org> <20230302235015.2044271-16-andrii@kernel.org>
 <20230304203406.ynvl5hmmekvo42uj@MacBook-Pro-6.local> <CAEf4BzZG+KsUuJfYboiesRHegZAf13CCr4VxUKeRNfgSXmShXA@mail.gmail.com>
 <20230306001228.mpu4f6l5uosoo26v@MacBook-Pro-6.local>
In-Reply-To: <20230306001228.mpu4f6l5uosoo26v@MacBook-Pro-6.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 13:54:36 -0800
Message-ID: <CAEf4BzZr6n21r1Kvv6+9iUg8JJ7fnAWRrRZA3rYY2kOZADP8aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 15/17] selftests/bpf: add bpf_for_each(),
 bpf_for(), and bpf_repeat() macros
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 5, 2023 at 4:12=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 04, 2023 at 03:28:03PM -0800, Andrii Nakryiko wrote:
> > On Sat, Mar 4, 2023 at 12:34=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Mar 02, 2023 at 03:50:13PM -0800, Andrii Nakryiko wrote:
> > > > Add bpf_for_each(), bpf_for() and bpf_repeat() macros that make wri=
ting
> > > > open-coded iterator-based loops much more convenient and natural. T=
hese
> > > > macro utilize cleanup attribute to ensure proper destruction of the
> > > > iterator and thanks to that manage to provide an ergonomic very clo=
se to
> > > > C language for construct. Typical integer loop would look like:
> > > >
> > > >   int i;
> > > >   int arr[N];
> > > >
> > > >   bpf_for(i, 0, N) {
> > > >   /* verifier will know that i >=3D 0 && i < N, so could be used to
> > > >    * directly access array elements with no extra checks
> > > >    */
> > > >    arr[i] =3D i;
> > > >   }
> > > >
> > > > bpf_repeat() is very similar, but it doesn't expose iteration numbe=
r and
> > > > is mean as a simple "repeat action N times":
> > > >
> > > >   bpf_repeat(N) { /* whatever */ }
> > > >
> > > > Note that break and continue inside the {} block work as expected.
> > > >
> > > > bpf_for_each() is a generalization over any kind of BPF open-coded
> > > > iterator allowing to use for-each-like approach instead of calling
> > > > low-level bpf_iter_<type>_{new,next,destroy}() APIs explicitly. E.g=
.:
> > > >
> > > >   struct cgroup *cg;
> > > >
> > > >   bpf_for_each(cgroup, cg, some, input, args) {
> > > >       /* do something with each cg */
> > > >   }
> > > >
> > > > Would call (right now hypothetical) bpf_iter_cgroup_{new,next,destr=
oy}()
> > > > functions to form a loop over cgroups, where `some, input, args` ar=
e
> > > > passed verbatim into constructor as
> > > > bpf_iter_cgroup_new(&it, some, input, args).
> > > >
> > > > As a demonstration, add pyperf variant based on bpf_for() loop.
> > > >
> > > > Also clean up few tests that either included bpf_misc.h header
> > > > unnecessarily from user-space or included it before any common type=
s are
> > > > defined.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  .../bpf/prog_tests/bpf_verif_scale.c          |  6 ++
> > > >  .../bpf/prog_tests/uprobe_autoattach.c        |  1 -
> > > >  tools/testing/selftests/bpf/progs/bpf_misc.h  | 76 +++++++++++++++=
++++
> > > >  tools/testing/selftests/bpf/progs/lsm.c       |  4 +-
> > > >  tools/testing/selftests/bpf/progs/pyperf.h    | 14 +++-
> > > >  .../selftests/bpf/progs/pyperf600_iter.c      |  7 ++
> > > >  .../selftests/bpf/progs/pyperf600_nounroll.c  |  3 -
> > > >  7 files changed, 101 insertions(+), 10 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_ite=
r.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale=
.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> > > > index 5ca252823294..731c343897d8 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> > > > @@ -144,6 +144,12 @@ void test_verif_scale_pyperf600_nounroll()
> > > >       scale_test("pyperf600_nounroll.bpf.o", BPF_PROG_TYPE_RAW_TRAC=
EPOINT, false);
> > > >  }
> > > >
> > > > +void test_verif_scale_pyperf600_iter()
> > > > +{
> > > > +     /* open-coded BPF iterator version */
> > > > +     scale_test("pyperf600_iter.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOI=
NT, false);
> > > > +}
> > > > +
> > > >  void test_verif_scale_loop1()
> > > >  {
> > > >       scale_test("loop1.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false=
);
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoatta=
ch.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> > > > index 6558c857e620..d5b3377aa33c 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> > > > @@ -3,7 +3,6 @@
> > > >
> > > >  #include <test_progs.h>
> > > >  #include "test_uprobe_autoattach.skel.h"
> > > > -#include "progs/bpf_misc.h"
> > > >
> > > >  /* uprobe attach point */
> > > >  static noinline int autoattach_trigger_func(int arg1, int arg2, in=
t arg3,
> > > > diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/t=
esting/selftests/bpf/progs/bpf_misc.h
> > > > index f704885aa534..08a791f307a6 100644
> > > > --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> > > > +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> > > > @@ -75,5 +75,81 @@
> > > >  #define FUNC_REG_ARG_CNT 5
> > > >  #endif
> > > >
> > > > +struct bpf_iter;
> > > > +
> > > > +extern int bpf_iter_num_new(struct bpf_iter *it__uninit, int start=
, int end) __ksym;
> > > > +extern int *bpf_iter_num_next(struct bpf_iter *it) __ksym;
> > > > +extern void bpf_iter_num_destroy(struct bpf_iter *it) __ksym;
> > > > +
> > > > +#ifndef bpf_for_each
> > > > +/* bpf_for_each(iter_kind, elem, args...) provides generic constru=
ct for using BPF
> > > > + * open-coded iterators without having to write mundane explicit l=
ow-level
> > > > + * loop. Instead, it provides for()-like generic construct that ca=
n be used
> > > > + * pretty naturally. E.g., for some hypothetical cgroup iterator, =
you'd write:
> > > > + *
> > > > + * struct cgroup *cg, *parent_cg =3D <...>;
> > > > + *
> > > > + * bpf_for_each(cgroup, cg, parent_cg, CG_ITER_CHILDREN) {
> > > > + *     bpf_printk("Child cgroup id =3D %d", cg->cgroup_id);
> > > > + *     if (cg->cgroup_id =3D=3D 123)
> > > > + *         break;
> > > > + * }
> > > > + *
> > > > + * I.e., it looks almost like high-level for each loop in other la=
nguages,
> > > > + * supports continue/break, and is verifiable by BPF verifier.
> > > > + *
> > > > + * For iterating integers, the difference betwen bpf_for_each(num,=
 i, N, M)
> > > > + * and bpf_for(i, N, M) is in that bpf_for() provides additional p=
roof to
> > > > + * verifier that i is in [N, M) range, and in bpf_for_each() case =
i is `int
> > > > + * *`, not just `int`. So for integers bpf_for() is more convenien=
t.
> > > > + */
> > > > +#define bpf_for_each(type, cur, args...) for (                    =
                             \
> > > > +     /* initialize and define destructor */                       =
                     \
> > > > +     struct bpf_iter ___it __attribute__((cleanup(bpf_iter_##type#=
#_destroy))),        \
> > >
> > > We should probably say somewhere that it requires C99 with some flag =
that allows
> > > declaring variables inside the loop.
> >
> > yes, I'll add a comment. I think cleanup attribute isn't standard as
> > well, I'll mention it. This shouldn't be restrictive, though, as we
> > expect very modern Clang (or eventually GCC), which definitely will
> > support all of that. And I feel like most people don't restrict their
> > BPF-side code to strict C89 anyways.
>
> yep. No UX concerns. A comment to manage expectations should be enough.
>

added


> > >
> > > Also what are the rules for attr(cleanup()).
> > > When does it get called?
> >
> > From GCC documentation:
> >
> >   > The cleanup attribute runs a function when the variable goes out of=
 scope.
> >
> > So given ___it is bound to for loop, any code path that leads to loop
> > exit (so, when condition turns false or *breaking* out of the loop,
> > which is why I use cleanup, this was a saving grace for this approach
> > to work at all).
>
> +1
>
> >
> > > My understanding that the visibility of ___it is only within for() bo=
dy.
> >
> > right
> >
> > > So when the prog does:
> > > bpf_for(i, 0, 10) sum +=3D i;
> > > bpf_for(i, 0, 10) sum +=3D i;
> > >
> > > the compiler should generate bpf_iter_num_destroy right after each bp=
f_for() ?
> >
> > Conceptually, yes, but see the note about breaking out of the loop
> > above. How actual assembly code is generated is beyond our control. If
> > the compiler generates multiple separate code paths, each with its own
> > destroy, that's fine as well. No assumptions are made in the verifier,
> > we just need to see one bpf_iter_<type>_destroy() for each instance of
> > iterator.
> >

[...]

> > One restriction with this approach is that I can't define both `struct
> > bpf_iter __it` and `int i` inside for loop, so cur/i has to be
> > declared and passed into bpf_for/bpf_for_each by user explicitly. So
> > for bpf_repeat() to expose i would require always doing:
> >
> > int i;
> >
> > bpf_repeat(i, 100) { /* i is set to 0, 1, ..., 99 */ }
> >
> > which, if you don't care about iteration number, is a bit of waste. So
> > don't know, I'm undecided on bpf_repeat with i.
>
> It feels that the proposed bpf_repeat() without 'i' is cleaner.
>

agreed, I'm keeping it as is

> > >
> > > In such case should we add __builtin_constant_p() check for 'start' a=
nd 'end' ?
> >
> > that seems to defy the purpose, as if you know start/end statically,
> > you might as well just write either unrolled loop or bounded for()
> > loop
> >
> > > int arr[100];
> > > if (var < 100)
> > >   bpf_for(i, 0, global_var) sum +=3D arr[i];
> > > will fail the verifier and the users might complain of dumb verifier.
> >
> >

[...]

> >
> > I can't do that, as for() allows only one type of variables to be
> > defined (note `*___p` hack as well), so there is no place to remember
> > start/end, unfortunately...
>
> I see. Abusing bpf_iter like:
> for (struct bpf_iter_num __it, *___p, start_end =3D (struct bpf_iter_num)=
 {start, end};
> is probably too ugly just to READ_ONCE(start).
> Especially since bpf_iter_num is opaque.

yeah, that seems like too much

>
> Please add a comment to warn users that if start/end are variables they
> better not change during bpf_for().
> I guess plain C loop: for (int i =3D 0; i < j; i++) will go crazy too if =
'j' changes.
> I'm not sure what standard says here.
> Whether compiler has to reload 'j' every iteration or not.

no idea, but yep, will add a comment

>
> > So it's a tradeoff. I can drop range validation, but then every
> > example and lots of production code would be re-checking these
> > conditions.
>
> Understood. Keep it as-is.
>
> > >
> > > > +     });                                                          =
                     \
> > > > +     /* nothing here  */                                          =
                     \
>
> btw that 'nothing here' comment is distracting when reading this macro.

ok, dropped this
