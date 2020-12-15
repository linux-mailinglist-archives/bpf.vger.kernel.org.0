Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DA22DABAE
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 12:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgLOLNW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 06:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgLOLNP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 06:13:15 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76F1C0617A6
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 03:12:34 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r7so19445157wrc.5
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fEagg6+9XQYogiWq2FhfANvXvfu7dv7wJXpB1emAfT8=;
        b=Sb6p+RZB2WnsCzfx6Wgs/NE/KoC4e20xHfHgJxCudl8VWYLfIX/SxB29NMgF+1I5Vy
         GAJcS1TLF9PgRgAhj7KmpMc8BkGKiUpXU72RmDUN6MBRRXI1ygA8KrqeSV6PmuvNENTJ
         lAVQ7lKI4LpPz5C/Uo/vrl/N2kfsULO+5v6zxAdlhbk1nRKQ79YzK6yh8kRDti/OMruC
         /saGMaVyrNdB1Fmyz7k767fo8Zd+C+svAu8lml+oy36n7JIiJrnV4gAkMhpbkAvk0TNf
         SqA9iimK6QnxZhANqwLHQliaTPrAEYne0KxppNEyjIv21fMg7fm7BcMEDM6TSzmto7WI
         2KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fEagg6+9XQYogiWq2FhfANvXvfu7dv7wJXpB1emAfT8=;
        b=nCNTmyFfRJVWSOHs5FI6IDM/WAmPZiDJZbOPMLciemuHdMpfdvJpPiPdzTIsSr2cUB
         wZIigKvpAodzx2I3cgkeeH3tVLIomloq1208XEtnrrxtkpvckknjJdu6dU7mg0JX4PaT
         2TdLkYkkeoq0a1+HHGu86tUYu1KyopCqsO0D/SpdyALC8evtOMxFqui4CU9avrq8m7zr
         Ak31+E0nskp5RrOU+DK0IK74jDFeh26hd8uDBqEfb8fy4XJQbtm6tFLhazohFqYdqP4i
         vHp9XtxSnGImaWDHApvQGM23vPpZNmehk9f705ClL2+ngktBfLbgsxmNoEWuygd8PnYC
         l1KQ==
X-Gm-Message-State: AOAM531jAvDohiPgVKEHea9CjNiCBmEEyOxAcldmSsmty2m09f3JL6VL
        ridsmlVxoWkrlp7DAMIonWxdkA==
X-Google-Smtp-Source: ABdhPJzi5iPSoK/O2IP9FZsv1BpHCTf1qLnjgzrUEJKFfsSZe9/PyQbCiMK5YciMhsLcpTlzPDKJSw==
X-Received: by 2002:a5d:4a44:: with SMTP id v4mr34479698wrs.106.1608030753313;
        Tue, 15 Dec 2020 03:12:33 -0800 (PST)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id u6sm40736178wrm.90.2020.12.15.03.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 03:12:32 -0800 (PST)
Date:   Tue, 15 Dec 2020 11:12:28 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v4 10/11] bpf: Add tests for new BPF atomic
 operations
Message-ID: <X9iaHF4FdFAPYBLx@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-11-jackmanb@google.com>
 <3adb88d5-b8d8-9c15-a988-7c10f86686fd@fb.com>
 <X890lro0A5mFJHyD@google.com>
 <24c9b2d7-f9b1-d7d4-71dc-47f4208ee6e9@fb.com>
 <X8+w8g56z11AKNci@google.com>
 <67ee3925-9388-c9d4-8ad8-9c28cff35d55@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ee3925-9388-c9d4-8ad8-9c28cff35d55@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 08, 2020 at 10:15:35AM -0800, Yonghong Song wrote:
> 
> 
> On 12/8/20 8:59 AM, Brendan Jackman wrote:
> > On Tue, Dec 08, 2020 at 08:38:04AM -0800, Yonghong Song wrote:
> > > 
> > > 
> > > On 12/8/20 4:41 AM, Brendan Jackman wrote:
> > > > On Mon, Dec 07, 2020 at 07:18:57PM -0800, Yonghong Song wrote:
> > > > > 
> > > > > 
> > > > > On 12/7/20 8:07 AM, Brendan Jackman wrote:
> > > > > > The prog_test that's added depends on Clang/LLVM features added by
> > > > > > Yonghong in commit 286daafd6512 (was https://reviews.llvm.org/D72184   ).
> > > > > > 
> > > > > > Note the use of a define called ENABLE_ATOMICS_TESTS: this is used
> > > > > > to:
> > > > > > 
> > > > > >     - Avoid breaking the build for people on old versions of Clang
> > > > > >     - Avoid needing separate lists of test objects for no_alu32, where
> > > > > >       atomics are not supported even if Clang has the feature.
> > > > > > 
> > > > > > The atomics_test.o BPF object is built unconditionally both for
> > > > > > test_progs and test_progs-no_alu32. For test_progs, if Clang supports
> > > > > > atomics, ENABLE_ATOMICS_TESTS is defined, so it includes the proper
> > > > > > test code. Otherwise, progs and global vars are defined anyway, as
> > > > > > stubs; this means that the skeleton user code still builds.
> > > > > > 
> > > > > > The atomics_test.o userspace object is built once and used for both
> > > > > > test_progs and test_progs-no_alu32. A variable called skip_tests is
> > > > > > defined in the BPF object's data section, which tells the userspace
> > > > > > object whether to skip the atomics test.
> > > > > > 
> > > > > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > > > 
> > > > > Ack with minor comments below.
> > > > > 
> > > > > Acked-by: Yonghong Song <yhs@fb.com>
> > > > > 
> > > > > > ---
> > > > > >     tools/testing/selftests/bpf/Makefile          |  10 +
> > > > > >     .../selftests/bpf/prog_tests/atomics.c        | 246 ++++++++++++++++++
> > > > > >     tools/testing/selftests/bpf/progs/atomics.c   | 154 +++++++++++
> > > > > >     .../selftests/bpf/verifier/atomic_and.c       |  77 ++++++
> > > > > >     .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
> > > > > >     .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++++
> > > > > >     .../selftests/bpf/verifier/atomic_or.c        |  77 ++++++
> > > > > >     .../selftests/bpf/verifier/atomic_xchg.c      |  46 ++++
> > > > > >     .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++++
> > > > > >     9 files changed, 889 insertions(+)
> > > > > >     create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics.c
> > > > > >     create mode 100644 tools/testing/selftests/bpf/progs/atomics.c
> > > > > >     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
> > > > > >     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> > > > > >     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
> > > > > >     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
> > > > > >     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
> > > > > >     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c
> > > > > > 
> > > > > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > > > > index ac25ba5d0d6c..13bc1d736164 100644
> > > > > > --- a/tools/testing/selftests/bpf/Makefile
> > > > > > +++ b/tools/testing/selftests/bpf/Makefile
> > > > > > @@ -239,6 +239,12 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
> > > > > >     	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
> > > > > >     	     -I$(abspath $(OUTPUT)/../usr/include)
> > > > > > +# BPF atomics support was added to Clang in llvm-project commit 286daafd6512
> > > > > > +# (release 12.0.0).
> > > > > > +BPF_ATOMICS_SUPPORTED = $(shell \
> > > > > > +	echo "int x = 0; int foo(void) { return __sync_val_compare_and_swap(&x, 1, 2); }" \
> > > > > > +	| $(CLANG) -x cpp-output -S -target bpf -mcpu=v3 - -o /dev/null && echo 1 || echo 0)
> > > > > 
> > > > > '-x c' here more intuitive?
> > > > > 
> > > > > > +
> > > > > >     CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
> > > > > >     	       -Wno-compare-distinct-pointer-types
> > > > > > @@ -399,11 +405,15 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
> > > > > >     		       $(wildcard progs/btf_dump_test_case_*.c)
> > > > > >     TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> > > > > >     TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> > > > > > +ifeq ($(BPF_ATOMICS_SUPPORTED),1)
> > > > > > +  TRUNNER_BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
> > > > > > +endif
> > > > > >     TRUNNER_BPF_LDFLAGS := -mattr=+alu32
> > > > > >     $(eval $(call DEFINE_TEST_RUNNER,test_progs))
> > > > > >     # Define test_progs-no_alu32 test runner.
> > > > > >     TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
> > > > > > +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> > > > > >     TRUNNER_BPF_LDFLAGS :=
> > > > > >     $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
> > > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..c841a3abc2f7
> > > > > > --- /dev/null
> > > > > > +++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
> > > > > > @@ -0,0 +1,246 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +
> > > > > > +#include <test_progs.h>
> > > > > > +
> > > > > > +#include "atomics.skel.h"
> > > > > > +
> > > > > > +static void test_add(struct atomics *skel)
> > > > > > +{
> > > > > > +	int err, prog_fd;
> > > > > > +	__u32 duration = 0, retval;
> > > > > > +	struct bpf_link *link;
> > > > > > +
> > > > > > +	link = bpf_program__attach(skel->progs.add);
> > > > > > +	if (CHECK(IS_ERR(link), "attach(add)", "err: %ld\n", PTR_ERR(link)))
> > > > > > +		return;
> > > > > > +
> > > > > > +	prog_fd = bpf_program__fd(skel->progs.add);
> > > > > > +	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
> > > > > > +				NULL, NULL, &retval, &duration);
> > > > > > +	if (CHECK(err || retval, "test_run add",
> > > > > > +		  "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
> > > > > > +		goto cleanup;
> > > > > > +
> > > > > > +	ASSERT_EQ(skel->data->add64_value, 3, "add64_value");
> > > > > > +	ASSERT_EQ(skel->bss->add64_result, 1, "add64_result");
> > > > > > +
> > > > > > +	ASSERT_EQ(skel->data->add32_value, 3, "add32_value");
> > > > > > +	ASSERT_EQ(skel->bss->add32_result, 1, "add32_result");
> > > > > > +
> > > > > > +	ASSERT_EQ(skel->bss->add_stack_value_copy, 3, "add_stack_value");
> > > > > > +	ASSERT_EQ(skel->bss->add_stack_result, 1, "add_stack_result");
> > > > > > +
> > > > > > +	ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noreturn_value");
> > > > > > +
> > > > > > +cleanup:
> > > > > > +	bpf_link__destroy(link);
> > > > > > +}
> > > > > > +
> > > > > [...]
> > > > > > +
> > > > > > +__u64 xchg64_value = 1;
> > > > > > +__u64 xchg64_result = 0;
> > > > > > +__u32 xchg32_value = 1;
> > > > > > +__u32 xchg32_result = 0;
> > > > > > +
> > > > > > +SEC("fentry/bpf_fentry_test1")
> > > > > > +int BPF_PROG(xchg, int a)
> > > > > > +{
> > > > > > +#ifdef ENABLE_ATOMICS_TESTS
> > > > > > +	__u64 val64 = 2;
> > > > > > +	__u32 val32 = 2;
> > > > > > +
> > > > > > +	__atomic_exchange(&xchg64_value, &val64, &xchg64_result, __ATOMIC_RELAXED);
> > > > > > +	__atomic_exchange(&xchg32_value, &val32, &xchg32_result, __ATOMIC_RELAXED);
> > > > > 
> > > > > Interesting to see this also works. I guess we probably won't advertise
> > > > > this, right? Currently for LLVM, the memory ordering parameter is ignored.
> > > > 
> > > > Well IIUC this specific case is fine: the ordering that you get with
> > > > BPF_[CMP]XCHG (via kernel atomic_[cmpxchg]) is sequential consistency,
> > > > and its' fine to provide a stronger ordering than the one requested. I
> > > > should change it to say __ATOMIC_SEQ_CST to avoid confusing readers,
> > > > though.
> > > > 
> > > > (I wrote it this way because I didn't see a __sync* function for
> > > > unconditional atomic exchange, and I didn't see an __atomic* function
> > > > where you don't need to specify the ordering).
> > > 
> > > For the above code,
> > >     __atomic_exchange(&xchg64_value, &val64, &xchg64_result,
> > > __ATOMIC_RELAXED);
> > > It tries to do an atomic exchange between &xchg64_value and
> > >   &val64, and store the old &xchg64_value to &xchg64_result. So it is
> > > equivalent to
> > >      xchg64_result = __sync_lock_test_and_set(&xchg64_value, val64);
> > > 
> > > So I think this test case can be dropped.
> > 
> > Ah nice, I didn't know about __sync_lock_test_and_set, let's switch to
> > that I think.
> > 
> > > > However... this led me to double-check the semantics and realise that we
> > > > do have a problem with ordering: The kernel's atomic_{add,and,or,xor} do
> > > > not imply memory barriers and therefore neither do the corresponding BPF
> > > > instructions. That means Clang can compile this:
> > > > 
> > > >    (void)__atomic_fetch_add(&val, 1, __ATOMIC_SEQ_CST)
> > > > 
> > > > to a {.code = (BPF_STX | BPF_DW | BPF_ATOMIC), .imm = BPF_ADD},
> > > > which is implemented with atomic_add, which doesn't actually satisfy
> > > > __ATOMIC_SEQ_CST.
> > > 
> > > This is the main reason in all my llvm selftests I did not use
> > > __atomic_* intrinsics because we cannot handle *different* memory
> > > ordering properly.
> > > 
> > > > 
> > > > In fact... I think this is a pre-existing issue with BPF_XADD.
> > > > 
> > > > If all I've written here is correct, the fix is to use
> > > > (void)atomic_fetch_add etc (these imply barriers) even when BPF_FETCH is
> > > > not set. And that change ought to be backported to fix BPF_XADD.
> > > 
> > > We cannot change BPF_XADD behavior. If we change BPF_XADD to use
> > > atomic_fetch_add, then suddenly old code compiled with llvm12 will
> > > suddenly requires latest kernel, which will break userland very badly.
> > 
> > Sorry I should have been more explicit: I meant that the fix would be to
> > call atomic_fetch_add but discard the return value, purely for the
> > implied barrier. The x86 JIT would stay the same. It would not break any
> > existing code, only add ordering guarantees that the user probably
> > already expected (since these builtins come from GCC originally and the
> > GCC docs say "these builtins are considered a full barrier" [1])
> > 
> > [1] https://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Atomic-Builtins.html
> 
> This is indeed the issue. In the past, people already use gcc
> __sync_fetch_and_add() for xadd instruction for which git generated
> code does not implying barrier.
> 
> The new atomics support has the following logic:
>   . if return value is used, it is atomic_fetch_add
>   . if return value is not used, it is xadd
> The reason to do this is to preserve backward compabiility
> and this way, we can get rid of -mcpu=v4.
> 
> barrier issue is tricky and as we discussed earlier let us
> delay this after basic atomics support landed. We may not
> 100% conform to gcc __sync_fetch_and_add() or __atomic_*()
> semantics. We do need to clearly document what is expected
> in llvm and kernel.

OK, then I think we can probably justify not conforming to the
__sync_fetch_and_add() semantics since that API is under-specified
anyway.

However IMO it's unambiguously a bug for

  (void)__atomic_fetch_add(&x, y, __ATOMIC_SEQ_CST);

to compile down to a kernel atomic_add. I think for that specific API
Clang really ought to always use BPF_FETCH | BPF_ADD when
anything stronger than __ATOMIC_RELAXED is requested, or even just
refuse to compile with when the return value is ignored and a
none-relaxed memory ordering is specified.
