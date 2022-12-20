Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E04A652850
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 22:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLTVVY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 16:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLTVVX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 16:21:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526C61D66E
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:21:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a1so4366734edf.5
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ibb5IwuDSryPETrCnjWs1Z+0RX2KxHDg5g/ybkpg7jg=;
        b=QS+dlnpb+n97H8A6D9TyUAIskm3BXF3QJsgsoDEhh/sUAV5xLoS2ivx5/G9Dc6JC/B
         r2bZZ6F9JXqVdT+htQpnDCckcrwpz7SHNx7UEqvcYN+YyQtPx40pHWppHUn2f4WVfSCC
         vsZDO2QUrV56eZdTorEGNrytUHi3OCM1jYGtDNTetcabdTJLQexuigu+JHCppnGNSnCO
         tKKV8ZbgHGgHaeq81NSPaM4DGegLytDO95UFz89+5sMkcnbtoBa5Q0HyKhx5QEqE8vv5
         Ot7QKcBJLZtupdUaMtVz2h9DNTYZIRf/xKuaNHJQ8UzfaEthcDwvzytYvtdlNKuAztIq
         M/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ibb5IwuDSryPETrCnjWs1Z+0RX2KxHDg5g/ybkpg7jg=;
        b=D47V4pb/djXKdtoJ7uyYkImxmUuOFrhMZBlLDn/l+tKlwj4eC9/9ezC///KYmoy2py
         aL5BHzlLNhwyv9hPARfilB/RFUQLfXHG28mhLJ1a187IOy0cHQCoISZot3Eb5LMepuO7
         Ma0yVS1WKBpMdA/xiLw3+eZsFCmSCYVUs0cSkPLeHvvOo7lsUJbmpG8ZksIVd0S2j7p+
         PFyz7qQFUMmpL0ah9bO0h25fvrpsP2klNyuSA51KBE51zoMp+Ho/8zyFhrz0gZfBW7RG
         L/XLjq4P/wWcB0e0KyE09i9i+3pH0iBq2JNNXZMrmc1NVuwVmLN/0Qqf4lNEwz0PAb5s
         0Lkg==
X-Gm-Message-State: ANoB5pn3V+vvhJMEYrwMVMBU2jgBBSQ4B7iFQlvs9aGy9WBMEkjbnnRW
        B7HRc7uMuBWY5p16ksW37LgEvG7pbbW6LnNhW7g=
X-Google-Smtp-Source: AA0mqf6TIupCadLcS/eLMFLlF0+Fa2PmcQLkjdzchFjhBrwbzq2cYjTwXjPv2u7TRIfnBLeDSzzNg+vTh8RQZTaf4i8=
X-Received: by 2002:aa7:d80d:0:b0:46b:7645:86a9 with SMTP id
 v13-20020aa7d80d000000b0046b764586a9mr39383179edq.311.1671571280824; Tue, 20
 Dec 2022 13:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20221217021711.172247-1-eddyz87@gmail.com>
In-Reply-To: <20221217021711.172247-1-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 13:21:08 -0800
Message-ID: <CAEf4BzZCX27eKhgB1d6AEtfX1bTFEKpeKM2Ae+BYHpN2CjdRBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] reduce BPF_ID_MAP_SIZE to fit only valid programs
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Fri, Dec 16, 2022 at 6:17 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> This is a follow-up for threads [1] and [2]:
>  - The size of the bpf_verifier_state->idmap_scratch array is reduced but
>    remains sufficient for any valid BPF program.
>  - selftests/bpf test_loader is updated to allow specifying that program
>    requires BPF_F_TEST_STATE_FREQ flag.
>  - Test case for the verifier.c:check_ids() update uses test_loader and is
>    meant as an example of using it for test_verifier-kind tests.
>
> The combination of test_loader and naked functions (see [3]) with inline
> assembly allows to write verifier tests easier than it is done currently
> with BPF_RAW_INSN-series macros.
>
> One can follow the steps below to add new tests of such kind:
>  - add a topic file under bpf/progs/ directory;
>  - define test programs using naked functions and inline assembly:

it's better, you don't *have* to use __naked functions, you can mix
and match. E.g., I have local tests that rely on the C compiler to do
stack allocation for local variables (%[dynptr]) and global variables
(%[zero]) and pass an address (fp-X) register to asm parts to work
with it.

+int zero;
+
+SEC("?raw_tp")
+__failure
+__flags(BPF_F_TEST_STATE_FREQ)
+__msg("invalid size of register fill")
+int stacksafe_should_not_conflate_stack_spill_and_dynptr(void *ctx)
+{
+       struct bpf_dynptr dynptr;
+
+       asm volatile (
+               /* Create a fork in logic, with general setup as follows:
+                *   - fallthrough (first) path is valid;
+                *   - branch (second) path is invalid.
+                * Then depending on what we do in fallthrough vs branch path,
+                * we try to detect bugs in func_states_equal(), regsafe(),
+                * refsafe(), stack_safe(), and similar by tricking verifier
+                * into believing that branch state is a valid subset of
+                * a fallthrough state. Verifier should reject overall
+                * validation, unless there is a bug somewhere in verifier
+                * logic.
+                */
+               "call %[bpf_get_prandom_u32];"
+               "r6 = r0;"
+               "call %[bpf_get_prandom_u32];"
+               "r7 = r0;"
+               "if r6 > r7 goto bad;" /* fork */
+
+               /* spill r6 into stack slot of bpf_dynptr var */
+               "*(u64 *)(%[dynptr] + 0) = r6;"
+               "*(u64 *)(%[dynptr] + 8) = r6;"
+
+               "goto skip_bad;"
+       "bad:"
+               /* create dynptr in the same stack slot */
+               "r1 = %[zero];"
+               "r2 = 4;"
+               "r3 = 0;"
+               "r4 = %[dynptr];"
+               "call %[bpf_dynptr_from_mem];"
+
+               /* here, if stacksafe() doesn't distinguish STACK_DYNPTR from
+                * STACK_MISC, verifier will assume safety at checkpoint below
+                */
+       "skip_bad:"
+               "goto +0;" /* force checkpoint */
+
+               /* leak dynptr state */
+               "r0 = *(u64 *)(%[dynptr] + 8);"
+               "if r0 > 0 goto +1;"
+               "exit;"
+               :
+               : __asm_ptr(dynptr), __asm_ptr(zero),
+                 __asm_imm(bpf_get_prandom_u32),
+                 __asm_imm(bpf_dynptr_from_mem)
+               : __asm_common_clobbers, "r6", "r7"
+       );
+
+       return 0;
+}



>
>         #include <linux/bpf.h>
>         #include "bpf_misc.h"
>
>         SEC(...)
>         __naked int foo_test(void)
>         {
>                 asm volatile(
>                         "r0 = 0;"
>                         "exit;"
>                         ::: __clobber_all);
>         }
>
>  - add skeleton and runner functions in prog_tests/verifier.c:
>
>         #include "topic.skel.h"
>         TEST_SET(topic)
>
> After these steps the test_progs binary would include the topic tests.
> Topic tests could be selectively executed using the following command:
>
> $ ./test_progs -vvv -a topic
>
> These changes are suggested by Andrii Nakryiko.
>
> [1] https://lore.kernel.org/bpf/CAEf4BzYN1JmY9t03pnCHc4actob80wkBz2vk90ihJCBzi8CT9w@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/CAEf4BzYPsDWdRgx+ND1wiKAB62P=WwoLhr2uWkbVpQfbHqi1oA@mail.gmail.com/
> [3] https://gcc.gnu.org/onlinedocs/gcc/Basic-Asm.html#Basic-Asm
>
> Eduard Zingerman (4):
>   selftests/bpf: support for BPF_F_TEST_STATE_FREQ in test_loader
>   selftests/bpf: convenience macro for use with 'asm volatile' blocks
>   bpf: reduce BPF_ID_MAP_SIZE to fit only valid programs
>   selftests/bpf: check if verifier.c:check_ids() handles 64+5 ids
>
>  include/linux/bpf_verifier.h                  |  4 +-
>  kernel/bpf/verifier.c                         |  6 +-
>  .../selftests/bpf/prog_tests/verifier.c       | 12 +++
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |  7 ++
>  .../selftests/bpf/progs/check_ids_limits.c    | 77 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_loader.c     | 10 +++
>  6 files changed, 112 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier.c
>  create mode 100644 tools/testing/selftests/bpf/progs/check_ids_limits.c
>
> --
> 2.38.2
>
