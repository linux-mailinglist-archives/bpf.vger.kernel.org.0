Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A82D2B47
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 13:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgLHMmp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 07:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgLHMmo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 07:42:44 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A71DC061749
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 04:42:04 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a6so1968319wmc.2
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 04:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CLLACH+9GUxthwusUWI6UMdl2mSI4mXIk0SrZSU0esg=;
        b=XFVfLG7YHK/hvTBDMVLWtWSyAYAQdYLdEJ5R2324oxUZSg7yxSbiJlcSiO+Ds0U1wd
         /UnhmvsM18A9Z5i8zgsRYMENnbAmCwQT6YNKvZrNqanpXIo5cw+hlR5ofvHbuUBPSCEX
         jexvynqjVVpRuAWw6OalhB7bUKZH1N6nTZo60O1/DKdzcfpy6G8e4VzyfFvMkn7+Eq35
         qWggTkoPHmTW8zR4q+V6P2mbmUFs1huDjCwLjd/KzgvRga/Ck3pDBts2DUxQ6FohmDn0
         Japi/SE8/e6/jnS4LFphVZY6CaJpUiUjJpm0GeZGsqa8TYfq9SFfmTrKsOyrL4hRsPi2
         AbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CLLACH+9GUxthwusUWI6UMdl2mSI4mXIk0SrZSU0esg=;
        b=ECkzEJRxwrL48MtxQMSmwFGqiwXj0t+cx3TLoQm/74tyE/r6U3t27EfhjVe9ybHgrY
         e5DM6yYpzvHO4NZac0Fg67mwaTOrZZOOxvFosnqz8oiW/7Kp9ry+kA0wrWKJMRhMkFji
         JNBz7HY94npSre/FaURLv7R6hAnDnF53Cj9kehRmvXw5NXQvMNePiqeV7KY9XDMIozS4
         Hvwv8Y5NqdWbicqk0OCPbs3qMN895WOkgMPuHwOUYjP/YKoclkF+Z46ddAA+Oo2/zghB
         Fj0PTU1eY1k11oHkwuy3mOJHYrl0pFsT4CFoqj3VeIpB+U3QL0uiV3zp1MvpFMPCKnl5
         8X+Q==
X-Gm-Message-State: AOAM530vJB3iXZgoEupCV6wuSVRqihDREI4SZ4KB/M8Bdw3UdGrxhqvV
        cuNNhBkO0EWep1SPj2rHq7d/Kg==
X-Google-Smtp-Source: ABdhPJx8TcSjHB4IiLzAUVpWqbwxmd7ysKukerH7/9oClZVQJO/x1seobLtzVTW36RkR5XRow0aUyw==
X-Received: by 2002:a7b:cbd0:: with SMTP id n16mr3730613wmi.162.1607431322632;
        Tue, 08 Dec 2020 04:42:02 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id y6sm3402280wmg.39.2020.12.08.04.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 04:42:01 -0800 (PST)
Date:   Tue, 8 Dec 2020 12:41:58 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v4 10/11] bpf: Add tests for new BPF atomic
 operations
Message-ID: <X890lro0A5mFJHyD@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-11-jackmanb@google.com>
 <3adb88d5-b8d8-9c15-a988-7c10f86686fd@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3adb88d5-b8d8-9c15-a988-7c10f86686fd@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 07, 2020 at 07:18:57PM -0800, Yonghong Song wrote:
> 
> 
> On 12/7/20 8:07 AM, Brendan Jackman wrote:
> > The prog_test that's added depends on Clang/LLVM features added by
> > Yonghong in commit 286daafd6512 (was https://reviews.llvm.org/D72184 ).
> > 
> > Note the use of a define called ENABLE_ATOMICS_TESTS: this is used
> > to:
> > 
> >   - Avoid breaking the build for people on old versions of Clang
> >   - Avoid needing separate lists of test objects for no_alu32, where
> >     atomics are not supported even if Clang has the feature.
> > 
> > The atomics_test.o BPF object is built unconditionally both for
> > test_progs and test_progs-no_alu32. For test_progs, if Clang supports
> > atomics, ENABLE_ATOMICS_TESTS is defined, so it includes the proper
> > test code. Otherwise, progs and global vars are defined anyway, as
> > stubs; this means that the skeleton user code still builds.
> > 
> > The atomics_test.o userspace object is built once and used for both
> > test_progs and test_progs-no_alu32. A variable called skip_tests is
> > defined in the BPF object's data section, which tells the userspace
> > object whether to skip the atomics test.
> > 
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> 
> Ack with minor comments below.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> 
> > ---
> >   tools/testing/selftests/bpf/Makefile          |  10 +
> >   .../selftests/bpf/prog_tests/atomics.c        | 246 ++++++++++++++++++
> >   tools/testing/selftests/bpf/progs/atomics.c   | 154 +++++++++++
> >   .../selftests/bpf/verifier/atomic_and.c       |  77 ++++++
> >   .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
> >   .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++++
> >   .../selftests/bpf/verifier/atomic_or.c        |  77 ++++++
> >   .../selftests/bpf/verifier/atomic_xchg.c      |  46 ++++
> >   .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++++
> >   9 files changed, 889 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/atomics.c
> >   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
> >   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> >   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
> >   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
> >   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
> >   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c
> > 
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index ac25ba5d0d6c..13bc1d736164 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -239,6 +239,12 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
> >   	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
> >   	     -I$(abspath $(OUTPUT)/../usr/include)
> > +# BPF atomics support was added to Clang in llvm-project commit 286daafd6512
> > +# (release 12.0.0).
> > +BPF_ATOMICS_SUPPORTED = $(shell \
> > +	echo "int x = 0; int foo(void) { return __sync_val_compare_and_swap(&x, 1, 2); }" \
> > +	| $(CLANG) -x cpp-output -S -target bpf -mcpu=v3 - -o /dev/null && echo 1 || echo 0)
> 
> '-x c' here more intuitive?
> 
> > +
> >   CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
> >   	       -Wno-compare-distinct-pointer-types
> > @@ -399,11 +405,15 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
> >   		       $(wildcard progs/btf_dump_test_case_*.c)
> >   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> >   TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> > +ifeq ($(BPF_ATOMICS_SUPPORTED),1)
> > +  TRUNNER_BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
> > +endif
> >   TRUNNER_BPF_LDFLAGS := -mattr=+alu32
> >   $(eval $(call DEFINE_TEST_RUNNER,test_progs))
> >   # Define test_progs-no_alu32 test runner.
> >   TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
> > +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> >   TRUNNER_BPF_LDFLAGS :=
> >   $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
> > diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
> > new file mode 100644
> > index 000000000000..c841a3abc2f7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
> > @@ -0,0 +1,246 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +
> > +#include "atomics.skel.h"
> > +
> > +static void test_add(struct atomics *skel)
> > +{
> > +	int err, prog_fd;
> > +	__u32 duration = 0, retval;
> > +	struct bpf_link *link;
> > +
> > +	link = bpf_program__attach(skel->progs.add);
> > +	if (CHECK(IS_ERR(link), "attach(add)", "err: %ld\n", PTR_ERR(link)))
> > +		return;
> > +
> > +	prog_fd = bpf_program__fd(skel->progs.add);
> > +	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
> > +				NULL, NULL, &retval, &duration);
> > +	if (CHECK(err || retval, "test_run add",
> > +		  "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
> > +		goto cleanup;
> > +
> > +	ASSERT_EQ(skel->data->add64_value, 3, "add64_value");
> > +	ASSERT_EQ(skel->bss->add64_result, 1, "add64_result");
> > +
> > +	ASSERT_EQ(skel->data->add32_value, 3, "add32_value");
> > +	ASSERT_EQ(skel->bss->add32_result, 1, "add32_result");
> > +
> > +	ASSERT_EQ(skel->bss->add_stack_value_copy, 3, "add_stack_value");
> > +	ASSERT_EQ(skel->bss->add_stack_result, 1, "add_stack_result");
> > +
> > +	ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noreturn_value");
> > +
> > +cleanup:
> > +	bpf_link__destroy(link);
> > +}
> > +
> [...]
> > +
> > +__u64 xchg64_value = 1;
> > +__u64 xchg64_result = 0;
> > +__u32 xchg32_value = 1;
> > +__u32 xchg32_result = 0;
> > +
> > +SEC("fentry/bpf_fentry_test1")
> > +int BPF_PROG(xchg, int a)
> > +{
> > +#ifdef ENABLE_ATOMICS_TESTS
> > +	__u64 val64 = 2;
> > +	__u32 val32 = 2;
> > +
> > +	__atomic_exchange(&xchg64_value, &val64, &xchg64_result, __ATOMIC_RELAXED);
> > +	__atomic_exchange(&xchg32_value, &val32, &xchg32_result, __ATOMIC_RELAXED);
> 
> Interesting to see this also works. I guess we probably won't advertise
> this, right? Currently for LLVM, the memory ordering parameter is ignored.

Well IIUC this specific case is fine: the ordering that you get with
BPF_[CMP]XCHG (via kernel atomic_[cmpxchg]) is sequential consistency,
and its' fine to provide a stronger ordering than the one requested. I
should change it to say __ATOMIC_SEQ_CST to avoid confusing readers,
though.

(I wrote it this way because I didn't see a __sync* function for
unconditional atomic exchange, and I didn't see an __atomic* function
where you don't need to specify the ordering).

However... this led me to double-check the semantics and realise that we
do have a problem with ordering: The kernel's atomic_{add,and,or,xor} do
not imply memory barriers and therefore neither do the corresponding BPF
instructions. That means Clang can compile this:

 (void)__atomic_fetch_add(&val, 1, __ATOMIC_SEQ_CST)

to a {.code = (BPF_STX | BPF_DW | BPF_ATOMIC), .imm = BPF_ADD},
which is implemented with atomic_add, which doesn't actually satisfy
__ATOMIC_SEQ_CST.

In fact... I think this is a pre-existing issue with BPF_XADD.

If all I've written here is correct, the fix is to use
(void)atomic_fetch_add etc (these imply barriers) even when BPF_FETCH is
not set. And that change ought to be backported to fix BPF_XADD.
