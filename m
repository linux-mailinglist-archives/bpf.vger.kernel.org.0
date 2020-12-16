Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D992DBFD9
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 12:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgLPLwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 06:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLPLwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 06:52:45 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DD5C06179C
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 03:52:04 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id d9so23674697iob.6
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8HJ+xb/a9oqIR8xR8fqVtF6iMeQd6DTTe6f36lZzVXs=;
        b=TzxyQRWLziS9EsZgrc5b9P56kBUOh/38eQobLLOJSZ1YukJpsFfHoO8zkJp7Uwy/hV
         W1ks1Ui2mEaKQ5ur0x6oS5fIJqVnPt11YbjBuV1XN8y1iX61VWqt1HpthboEWi/3xZcG
         3HdBP58f5z9l1fW7edQ29W0Z1Qp9uBT0p3OaDx1dVdB/oB9u2TefE+UgZij14sCbaa/e
         hMKRt06k+yzlVRdxHyewuk7t7LVNoFx6gZzGGSILhhify77NIPBYSftp7LPg32BBjQzC
         i/r0WwBJJrCuNdZnmUV1QmqMImQNq/LMTFRXkgJ+tCZHmwY9U/NDcIS7TFU9XA3+l1CC
         T77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8HJ+xb/a9oqIR8xR8fqVtF6iMeQd6DTTe6f36lZzVXs=;
        b=ksKJkrQ3aIg5Bl/gQChb6AHU+rYs58A1T3XhaXLqrbJXUf60k8p3JyZmkpt/UGYTAH
         Zs23wY66hZdKWGniDRw7rH2j2eh5mCua9Dw3Km9Q2/3u9p+pn5kwJYKHlMjOy6RDdChz
         h+yZBTKeSNwg6/AxNemVJLZ3emkcjumhwROPXR6I5YnUlZ9ZU5eCJBcmiVGQc4uQPEhE
         sxHUvUDV7zv28Bqlg3uxzghTx43KSp7oY2hDtHldthKTz9GcTt5WJBbWfH00q/VfrcW+
         +QybEtuz1lSTsW5Bcs4KXj1Y7+3R1h5YfiM8nIf79TPuw6gLKVRbipESmgwB+xYnT/Of
         X1mw==
X-Gm-Message-State: AOAM530vkFUGAG/DvMwTyHatQDthI5rrt6MW9V+g+ekJgHburjiwDE6+
        jSdzQicn3zrlQhKbklLW3WGk/CfPEJqvT13NVcJGvQ==
X-Google-Smtp-Source: ABdhPJz1+E/vgd0VBYIqx7i+wSWHpBSPIlTjjgtT1z8hhMoK/g8KMyhwmob/vts1DNuBHN2AUBZX+tCL2l6IHv+KXU4=
X-Received: by 2002:a02:ce8a:: with SMTP id y10mr41534860jaq.102.1608119524010;
 Wed, 16 Dec 2020 03:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20201207160734.2345502-1-jackmanb@google.com> <20201207160734.2345502-11-jackmanb@google.com>
 <3adb88d5-b8d8-9c15-a988-7c10f86686fd@fb.com> <X890lro0A5mFJHyD@google.com>
 <24c9b2d7-f9b1-d7d4-71dc-47f4208ee6e9@fb.com> <X8+w8g56z11AKNci@google.com>
 <67ee3925-9388-c9d4-8ad8-9c28cff35d55@fb.com> <X9iaHF4FdFAPYBLx@google.com> <3f49c18e-fed6-b005-19ca-b11ad620f535@fb.com>
In-Reply-To: <3f49c18e-fed6-b005-19ca-b11ad620f535@fb.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 16 Dec 2020 12:51:52 +0100
Message-ID: <CA+i-1C1qfhgZOnpD1kZW9_UzGSDpWgmqGM+YgCiJr5qxx4NeFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 10/11] bpf: Add tests for new BPF atomic operations
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 16 Dec 2020 at 08:19, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 12/15/20 3:12 AM, Brendan Jackman wrote:
> > On Tue, Dec 08, 2020 at 10:15:35AM -0800, Yonghong Song wrote:
> >>
> >>
> >> On 12/8/20 8:59 AM, Brendan Jackman wrote:
> >>> On Tue, Dec 08, 2020 at 08:38:04AM -0800, Yonghong Song wrote:
> >>>>
> >>>>
> >>>> On 12/8/20 4:41 AM, Brendan Jackman wrote:
> >>>>> On Mon, Dec 07, 2020 at 07:18:57PM -0800, Yonghong Song wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 12/7/20 8:07 AM, Brendan Jackman wrote:
> >>>>>>> The prog_test that's added depends on Clang/LLVM features added b=
y
> >>>>>>> Yonghong in commit 286daafd6512 (was https://reviews.llvm.org/D72=
184    ).
> >>>>>>>
> >>>>>>> Note the use of a define called ENABLE_ATOMICS_TESTS: this is use=
d
> >>>>>>> to:
> >>>>>>>
> >>>>>>>      - Avoid breaking the build for people on old versions of Cla=
ng
> >>>>>>>      - Avoid needing separate lists of test objects for no_alu32,=
 where
> >>>>>>>        atomics are not supported even if Clang has the feature.
> >>>>>>>
> >>>>>>> The atomics_test.o BPF object is built unconditionally both for
> >>>>>>> test_progs and test_progs-no_alu32. For test_progs, if Clang supp=
orts
> >>>>>>> atomics, ENABLE_ATOMICS_TESTS is defined, so it includes the prop=
er
> >>>>>>> test code. Otherwise, progs and global vars are defined anyway, a=
s
> >>>>>>> stubs; this means that the skeleton user code still builds.
> >>>>>>>
> >>>>>>> The atomics_test.o userspace object is built once and used for bo=
th
> >>>>>>> test_progs and test_progs-no_alu32. A variable called skip_tests =
is
> >>>>>>> defined in the BPF object's data section, which tells the userspa=
ce
> >>>>>>> object whether to skip the atomics test.
> >>>>>>>
> >>>>>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> >>>>>>
> >>>>>> Ack with minor comments below.
> >>>>>>
> >>>>>> Acked-by: Yonghong Song <yhs@fb.com>
> >>>>>>
> >>>>>>> ---
> >>>>>>>      tools/testing/selftests/bpf/Makefile          |  10 +
> >>>>>>>      .../selftests/bpf/prog_tests/atomics.c        | 246 ++++++++=
++++++++++
> >>>>>>>      tools/testing/selftests/bpf/progs/atomics.c   | 154 ++++++++=
+++
> >>>>>>>      .../selftests/bpf/verifier/atomic_and.c       |  77 ++++++
> >>>>>>>      .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
> >>>>>>>      .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++++
> >>>>>>>      .../selftests/bpf/verifier/atomic_or.c        |  77 ++++++
> >>>>>>>      .../selftests/bpf/verifier/atomic_xchg.c      |  46 ++++
> >>>>>>>      .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++++
> >>>>>>>      9 files changed, 889 insertions(+)
> >>>>>>>      create mode 100644 tools/testing/selftests/bpf/prog_tests/at=
omics.c
> >>>>>>>      create mode 100644 tools/testing/selftests/bpf/progs/atomics=
.c
> >>>>>>>      create mode 100644 tools/testing/selftests/bpf/verifier/atom=
ic_and.c
> >>>>>>>      create mode 100644 tools/testing/selftests/bpf/verifier/atom=
ic_cmpxchg.c
> >>>>>>>      create mode 100644 tools/testing/selftests/bpf/verifier/atom=
ic_fetch_add.c
> >>>>>>>      create mode 100644 tools/testing/selftests/bpf/verifier/atom=
ic_or.c
> >>>>>>>      create mode 100644 tools/testing/selftests/bpf/verifier/atom=
ic_xchg.c
> >>>>>>>      create mode 100644 tools/testing/selftests/bpf/verifier/atom=
ic_xor.c
> >>>>>>>
> >>>>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing=
/selftests/bpf/Makefile
> >>>>>>> index ac25ba5d0d6c..13bc1d736164 100644
> >>>>>>> --- a/tools/testing/selftests/bpf/Makefile
> >>>>>>> +++ b/tools/testing/selftests/bpf/Makefile
> >>>>>>> @@ -239,6 +239,12 @@ BPF_CFLAGS =3D -g -D__TARGET_ARCH_$(SRCARCH)=
 $(MENDIAN)                      \
> >>>>>>>              -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)            =
       \
> >>>>>>>              -I$(abspath $(OUTPUT)/../usr/include)
> >>>>>>> +# BPF atomics support was added to Clang in llvm-project commit =
286daafd6512
> >>>>>>> +# (release 12.0.0).
> >>>>>>> +BPF_ATOMICS_SUPPORTED =3D $(shell \
> >>>>>>> +       echo "int x =3D 0; int foo(void) { return __sync_val_comp=
are_and_swap(&x, 1, 2); }" \
> >>>>>>> +       | $(CLANG) -x cpp-output -S -target bpf -mcpu=3Dv3 - -o /=
dev/null && echo 1 || echo 0)
> >>>>>>
> >>>>>> '-x c' here more intuitive?
> >>>>>>
> >>>>>>> +
> >>>>>>>      CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES) \
> >>>>>>>                -Wno-compare-distinct-pointer-types
> >>>>>>> @@ -399,11 +405,15 @@ TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_=
read $(OUTPUT)/bpf_testmod.ko    \
> >>>>>>>                        $(wildcard progs/btf_dump_test_case_*.c)
> >>>>>>>      TRUNNER_BPF_BUILD_RULE :=3D CLANG_BPF_BUILD_RULE
> >>>>>>>      TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS)
> >>>>>>> +ifeq ($(BPF_ATOMICS_SUPPORTED),1)
> >>>>>>> +  TRUNNER_BPF_CFLAGS +=3D -DENABLE_ATOMICS_TESTS
> >>>>>>> +endif
> >>>>>>>      TRUNNER_BPF_LDFLAGS :=3D -mattr=3D+alu32
> >>>>>>>      $(eval $(call DEFINE_TEST_RUNNER,test_progs))
> >>>>>>>      # Define test_progs-no_alu32 test runner.
> >>>>>>>      TRUNNER_BPF_BUILD_RULE :=3D CLANG_NOALU32_BPF_BUILD_RULE
> >>>>>>> +TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS)
> >>>>>>>      TRUNNER_BPF_LDFLAGS :=3D
> >>>>>>>      $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
> >>>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/t=
ools/testing/selftests/bpf/prog_tests/atomics.c
> >>>>>>> new file mode 100644
> >>>>>>> index 000000000000..c841a3abc2f7
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
> >>>>>>> @@ -0,0 +1,246 @@
> >>>>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>>>> +
> >>>>>>> +#include <test_progs.h>
> >>>>>>> +
> >>>>>>> +#include "atomics.skel.h"
> >>>>>>> +
> >>>>>>> +static void test_add(struct atomics *skel)
> >>>>>>> +{
> >>>>>>> +       int err, prog_fd;
> >>>>>>> +       __u32 duration =3D 0, retval;
> >>>>>>> +       struct bpf_link *link;
> >>>>>>> +
> >>>>>>> +       link =3D bpf_program__attach(skel->progs.add);
> >>>>>>> +       if (CHECK(IS_ERR(link), "attach(add)", "err: %ld\n", PTR_=
ERR(link)))
> >>>>>>> +               return;
> >>>>>>> +
> >>>>>>> +       prog_fd =3D bpf_program__fd(skel->progs.add);
> >>>>>>> +       err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
> >>>>>>> +                               NULL, NULL, &retval, &duration);
> >>>>>>> +       if (CHECK(err || retval, "test_run add",
> >>>>>>> +                 "err %d errno %d retval %d duration %d\n", err,=
 errno, retval, duration))
> >>>>>>> +               goto cleanup;
> >>>>>>> +
> >>>>>>> +       ASSERT_EQ(skel->data->add64_value, 3, "add64_value");
> >>>>>>> +       ASSERT_EQ(skel->bss->add64_result, 1, "add64_result");
> >>>>>>> +
> >>>>>>> +       ASSERT_EQ(skel->data->add32_value, 3, "add32_value");
> >>>>>>> +       ASSERT_EQ(skel->bss->add32_result, 1, "add32_result");
> >>>>>>> +
> >>>>>>> +       ASSERT_EQ(skel->bss->add_stack_value_copy, 3, "add_stack_=
value");
> >>>>>>> +       ASSERT_EQ(skel->bss->add_stack_result, 1, "add_stack_resu=
lt");
> >>>>>>> +
> >>>>>>> +       ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noretur=
n_value");
> >>>>>>> +
> >>>>>>> +cleanup:
> >>>>>>> +       bpf_link__destroy(link);
> >>>>>>> +}
> >>>>>>> +
> >>>>>> [...]
> >>>>>>> +
> >>>>>>> +__u64 xchg64_value =3D 1;
> >>>>>>> +__u64 xchg64_result =3D 0;
> >>>>>>> +__u32 xchg32_value =3D 1;
> >>>>>>> +__u32 xchg32_result =3D 0;
> >>>>>>> +
> >>>>>>> +SEC("fentry/bpf_fentry_test1")
> >>>>>>> +int BPF_PROG(xchg, int a)
> >>>>>>> +{
> >>>>>>> +#ifdef ENABLE_ATOMICS_TESTS
> >>>>>>> +       __u64 val64 =3D 2;
> >>>>>>> +       __u32 val32 =3D 2;
> >>>>>>> +
> >>>>>>> +       __atomic_exchange(&xchg64_value, &val64, &xchg64_result, =
__ATOMIC_RELAXED);
> >>>>>>> +       __atomic_exchange(&xchg32_value, &val32, &xchg32_result, =
__ATOMIC_RELAXED);
> >>>>>>
> >>>>>> Interesting to see this also works. I guess we probably won't adve=
rtise
> >>>>>> this, right? Currently for LLVM, the memory ordering parameter is =
ignored.
> >>>>>
> >>>>> Well IIUC this specific case is fine: the ordering that you get wit=
h
> >>>>> BPF_[CMP]XCHG (via kernel atomic_[cmpxchg]) is sequential consisten=
cy,
> >>>>> and its' fine to provide a stronger ordering than the one requested=
. I
> >>>>> should change it to say __ATOMIC_SEQ_CST to avoid confusing readers=
,
> >>>>> though.
> >>>>>
> >>>>> (I wrote it this way because I didn't see a __sync* function for
> >>>>> unconditional atomic exchange, and I didn't see an __atomic* functi=
on
> >>>>> where you don't need to specify the ordering).
> >>>>
> >>>> For the above code,
> >>>>      __atomic_exchange(&xchg64_value, &val64, &xchg64_result,
> >>>> __ATOMIC_RELAXED);
> >>>> It tries to do an atomic exchange between &xchg64_value and
> >>>>    &val64, and store the old &xchg64_value to &xchg64_result. So it =
is
> >>>> equivalent to
> >>>>       xchg64_result =3D __sync_lock_test_and_set(&xchg64_value, val6=
4);
> >>>>
> >>>> So I think this test case can be dropped.
> >>>
> >>> Ah nice, I didn't know about __sync_lock_test_and_set, let's switch t=
o
> >>> that I think.
> >>>
> >>>>> However... this led me to double-check the semantics and realise th=
at we
> >>>>> do have a problem with ordering: The kernel's atomic_{add,and,or,xo=
r} do
> >>>>> not imply memory barriers and therefore neither do the correspondin=
g BPF
> >>>>> instructions. That means Clang can compile this:
> >>>>>
> >>>>>     (void)__atomic_fetch_add(&val, 1, __ATOMIC_SEQ_CST)
> >>>>>
> >>>>> to a {.code =3D (BPF_STX | BPF_DW | BPF_ATOMIC), .imm =3D BPF_ADD},
> >>>>> which is implemented with atomic_add, which doesn't actually satisf=
y
> >>>>> __ATOMIC_SEQ_CST.
> >>>>
> >>>> This is the main reason in all my llvm selftests I did not use
> >>>> __atomic_* intrinsics because we cannot handle *different* memory
> >>>> ordering properly.
> >>>>
> >>>>>
> >>>>> In fact... I think this is a pre-existing issue with BPF_XADD.
> >>>>>
> >>>>> If all I've written here is correct, the fix is to use
> >>>>> (void)atomic_fetch_add etc (these imply barriers) even when BPF_FET=
CH is
> >>>>> not set. And that change ought to be backported to fix BPF_XADD.
> >>>>
> >>>> We cannot change BPF_XADD behavior. If we change BPF_XADD to use
> >>>> atomic_fetch_add, then suddenly old code compiled with llvm12 will
> >>>> suddenly requires latest kernel, which will break userland very badl=
y.
> >>>
> >>> Sorry I should have been more explicit: I meant that the fix would be=
 to
> >>> call atomic_fetch_add but discard the return value, purely for the
> >>> implied barrier. The x86 JIT would stay the same. It would not break =
any
> >>> existing code, only add ordering guarantees that the user probably
> >>> already expected (since these builtins come from GCC originally and t=
he
> >>> GCC docs say "these builtins are considered a full barrier" [1])
> >>>
> >>> [1] https://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Atomic-Builtins.html
> >>
> >> This is indeed the issue. In the past, people already use gcc
> >> __sync_fetch_and_add() for xadd instruction for which git generated
> >> code does not implying barrier.
> >>
> >> The new atomics support has the following logic:
> >>    . if return value is used, it is atomic_fetch_add
> >>    . if return value is not used, it is xadd
> >> The reason to do this is to preserve backward compabiility
> >> and this way, we can get rid of -mcpu=3Dv4.
> >>
> >> barrier issue is tricky and as we discussed earlier let us
> >> delay this after basic atomics support landed. We may not
> >> 100% conform to gcc __sync_fetch_and_add() or __atomic_*()
> >> semantics. We do need to clearly document what is expected
> >> in llvm and kernel.
> >
> > OK, then I think we can probably justify not conforming to the
> > __sync_fetch_and_add() semantics since that API is under-specified
> > anyway.
> >
> > However IMO it's unambiguously a bug for
> >
> >    (void)__atomic_fetch_add(&x, y, __ATOMIC_SEQ_CST);
> >
> > to compile down to a kernel atomic_add. I think for that specific API
> > Clang really ought to always use BPF_FETCH | BPF_ADD when
> > anything stronger than __ATOMIC_RELAXED is requested, or even just
> > refuse to compile with when the return value is ignored and a
> > none-relaxed memory ordering is specified.
>
> Both the following codes:
>     (void)__sync_fetch_and_add(p, a);
>     (void)__atomic_fetch_add(p, a, __ATOMIC_SEQ_CST);
>
> will generate the same IR:
>     %0 =3D atomicrmw add i32* %p, i32 %a seq_cst
>
> Basically that means for old compiler (<=3D llvm11),
>    (void)__atomic_fetch_add(&x, y, __ATOMIC_SEQ_CST)
> already generates xadd.

Ah, I didn't realise that was already the case, that's unfortunate.

For users of newer Clang with alu32 enabled, unless I'm being na=C3=AFve
this could be fixed without breaking compatibility. Clang could just
start generating a BPF_ADD|BPF_FETCH, and then handle the fact that
the src_reg is clobbered, right?

For users without alu32 enabled I would actually argue that the new
Clang should start failing to build that code - as a user I'd much
rather have my build suddenly fail than my explicitly-stated ordering
assumptions violated. But I understand if that doesn't seem too
palatable...
