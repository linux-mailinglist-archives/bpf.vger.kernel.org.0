Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4456D718B
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 02:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbjDEAmu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 20:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbjDEAms (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:42:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F84C08
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 17:42:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j24so34598910wrd.0
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 17:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680655361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClUTJ/FQgs6vHYAQOJrrSsK5ffa57jnEs4BWKuOrxjw=;
        b=PuXYDoB1T7KjVPPxO0NZ1esRyWMXVVVWCunCrvMRAOV1Buv/MoqkpYlktOG1wBrzaX
         eayV6ptXDVMU3CuYUNfdCZBxhzR0YdOdqPGKPlPjxdfIEagbIHJFk3N37m6k0fvQolA4
         AKwWCb6l7xXbYAwfm+zBrFyCaVvGZeqvc6iAttxanrcj9ukMcXQn7CgydE7y3YlvndjQ
         sDqxc5qZaVClW6ov00+7Jkfhu4bW4SkXiGWYkFmGKmQHRcWep9yXwflK+B9x2xpFRykC
         Y63BQuPnnpfvvs+132S/DqkjQCLUZFDNnWF1csFq4StK/Nib/LYdxbeYy7yw1Q5WaUyX
         8+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClUTJ/FQgs6vHYAQOJrrSsK5ffa57jnEs4BWKuOrxjw=;
        b=Rwxklz0UB/Isly7O/L268DaOPenIFsHVQ8E8WtLS0qM2uB8QdKMEOIH8nptF5J2iSS
         RLzHUp3Ga2GkSmOv/FPdkhrTZ3TiH3IlFbSQ/N9zhU32CK1DX6sDaRMeHSt8gWIffNbk
         wf+XRdn1eLX5CeTrUWeLyKtlI+sEQAMIx+q//H44CkB6dUKlIniyPzIe8fEZsoUJaTbv
         7sBp4X2YW4TEeQqQu0H2eLC3rq4tNhRwU205m76gtwW9xSMjJtVUproGo8V8dxOPi4fW
         e4O51hurM7qyox9sntCDDXdHKpdizHXhB/FlLl3P5nauFba+1AR3HRbg24dKAV1xpzYs
         2oAw==
X-Gm-Message-State: AAQBX9e7UFfZSPzWnLhNT8pYd2AK2cx2gKnoZxr8R2kJHodVSaistgTk
        LrW3H//+wT0NdQ9hI8g2PHavhqrLdHjTMQ==
X-Google-Smtp-Source: AKy350bfHC1TyVF9tT9OSaUB/qCdsiEFH3+M4Wo9N5Wo0zH8W6LGl56fsoF1lsG8uoSut2m0aPiGXA==
X-Received: by 2002:a05:6000:11d2:b0:2e4:bfa0:8c2a with SMTP id i18-20020a05600011d200b002e4bfa08c2amr2822393wrx.49.1680655360935;
        Tue, 04 Apr 2023 17:42:40 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id g4-20020adffc84000000b002d8566128e5sm13428860wrr.25.2023.04.04.17.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 17:42:40 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH RFC bpf-next v1 0/9] Exceptions - 1/2
Date:   Wed,  5 Apr 2023 02:42:30 +0200
Message-Id: <20230405004239.1375399-1-memxor@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10207; i=memxor@gmail.com; h=from:subject; bh=ZOg/hbQTFEZXqgZvm0o8oDZGF3S3Bij0l2XoTCwfbPY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBkLMPvrz2eM5/dB3I/VFMLRjB0P85662K7hJgv1 wDehL6AfyKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZCzD7wAKCRBM4MiGSL8R yvHiD/9UyyO1CymOOpyNcZ4GsoMcelVSzuqUL5yT9U8UR26rLQhTIXsjfd5maISlZR3sWPQ4ujD lPwU9llOOXQungaUe6KaLBeCE/fCnRYGQagvevvERFiQ7TxQu/4KsHktXziMPbCot2VnKqLL6A8 tns9F4eIkm61ShNsGdpDS7rhApxfcHWSU+iv4IiNuRE7P8TX1KN6seP614ginZhGl946ORhVtfA r//yC41rwoj2Ju+5u7Evf2gBb6b3/z1V+PEWd+Wc1ajtZT9irMX21feZkrAnSALblnA5OoLn/bv QRK+LZlowZRMWYbnJy/ljnaR/30hAuhWy3Y7mUUoswWqIfrYaHVACTiHsRXdbYbPB+5jnZYjyFC pwlPPq8hdj5OEeOjkbUSQA/4fR/B3LhZyCqHL4WZjTqlr6Xi/vR/XOBPeBmXZgLvEuH909wgO1a ygvHaZRCPfovsOfEg+Mu7ClmHq2D/4LnMOYIO7qSS34Ua3BohSwFG66VuwNsi2epqcsjA3ZX9cx xmXwpZo551q6KaJZcIrCMrVg53wvc0dphXyLgYHC4NMXpINbE6YRNkdw/ci25I1X995enr43llq eaEOeknKL+kL8JXq/bK5AacJLRYXbLgm7DMA+gvKyXu6xBmmOY7xKr/3iwAOCjYDgqbfgMTEJ/A wfOcrb3WfmHhZfw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series implements the bare minimum support for basic BPF
exceptions. This is a feature to allow programs to simply throw a
valueless exception within a BPF program to abort its execution.
Automatic cleanup of held resources and generation of landing pads to
unwind program state will be done in the part 2 set.

The exception state is part of the the current task's task_struct's
exception_thrown array, which is a set of 4 boolean variables,
representing the exception state for each kernel context (Task, SoftIRQ,
HardIRQ, NMI). This allows a program interrupting the execution of
another program to not corrupt its exception state when throwing.

During program nesting, i.e. a program invoked in the same context while
another program is active, an exception can never be in the 'thrown'
state, as long as it clears its own exception state when exiting and
returning to the kernel, the caller program will be fine.

Hence, the conditions are that a program receives unset exception state
on entry, and preserves the unset exception state on exit. Only BPF
subprogs avoid resetting exception state on exit, so that they can
propagate the modified exception state to their caller. This can be
another caller subprog, the caller main prog, or the kernel.

BPF helpers executing callbacks in the kernel are modified to catch and
exit early when they detect a thrown exception from the callback. The
program will then catch this exception and unwind.

BPF helpers and kfuncs may also throw BPF exceptions, they simply
declare their intent to throw using annotations (e.g. predicate function
with list of throwing helpers, KF_THROW for kfuncs, etc). The program
will automatically be instrumented to detect a thrown exception and
unwind the stack.

The following two kfuncs are introduced:

// Throw a BPF exception, terminating execution of the program.
void bpf_throw(void);

// Set an exception handler which is invoked after the unwinding of the
// stack is finished. The return value of the handler is the value
// returned when an exception is thrown, otherwise by default it is 0.
void bpf_set_exception_handler(int (*handler)(void));

Dedicated exception state in task_struct vs bpf_run_ctx was chosen
primarily for the following reasons:
 - Synchronous callbacks semantically execute within programs and affect
   their state. Hence, exceptions thrown by them should be propagated
   when invoked from helpers and kfuncs.
 - For async callbacks that terminate execution safely using bpf_throw,
   this would require having a bpf_run_ctx by default (with same
   semantics as the current solution) or setup by the invoking context
   for each cb invocation (which breaks cb == func pointer semantics
   assumed currently within the kernel).
 - Avoid setting up bpf_run_ctx for program types (esp. XDP) that don't
   need it, and no changes are needed for programs that don't use
   exceptions. Whatever minor overhead there is, is only paid for when
   they are used.

Restrictions can be imposed on the program to revisit the bpf_run_ctx
solution (like forbidding callbacks from using bpf_throw). However,
genericity of use of bpf_throw in all possible cases is given preference
(so that bpf_assert which is the primary consumer isn't surprising to
use when it isn't supported in certain contexts).

The overhead of calling helpers to deal with exception state can be
easily forgone by getting direct access to the current task pointer to
touch exception state, or using a dedicated callee-saved register to
hold it within the program (while relying on task_struct state across
BPF-Kernel boundary).

Verification
------------

We rely on the main verifier pass to decide how to rewrite the BPF
program to handle thrown exceptions.

The first step of verification in the main pass (do_check) is symbolic
execution of the global subprograms. These subprograms are verified
independently, and hence, they are not explored whenever there is a call
to a global subprog.

We first do 'can_throw' marking for each global subprogram by following
its execution, detecting any bpf_throw calls made in any of the paths
explored by the verifier. This however does not have full visibility
into the thrown exceptions, and only attains markings for exceptions it
can see to be thrown by static subprogs, helpers, kfuncs, etc.

For instance:

GF1:
	call GF2
	exit
GF2:
	call GF3
	exit
GF3:
	call bpf_throw

If all of these are explored in order, only GF3 receives the can_throw
marking. To remedy this, we do another pass and follow BPF_PSEUDO_CALL
edges to global subprogs in the call graph of global subprogs, and
propagate the direct throws in some global subprogs to other global
subprogs. Each caller then receives can_throw marking and is marked for
rewrite later.

Now, all global functions are annotated correctly with the right
can_throw markings, and any calls to them in the main subprog can also
be marked for appropriate rewrites later. We now go through the main
subprog, and since we have full visibility due to the verifier's path
awareness into which paths may throw, we use this to selectively mark
every such instruction which has throwing semantics (calls to throwing
subprogs (global/static), calls to helper or kfuncs taking callbacks
which throw), calls to kfuncs which throw, etc.

If a certain static subprog only throws when called from a certain point
in the program, and does not throw in the other, we avoid marking its
other callsite as throwing. However, this is unlike global subprogs,
where we do not explore them, hence cannot make this distinction. This
also means that two calls to the same static subprog may be rewritten
differently, and thus may or may not handle the exception.

This becomes a problem if we allow extension programs to attach to such
static subprogs. Usually, the use case is to replace global subprogs,
and static subprogs are rejected right now. A test case is included to
catch the case when things change and prompt appropriate checks in
check_ext_prog (as all callsites are not prepared to handle exceptions),

Optimizations
-------------

Currently, exception handling code is generated inline. This was done to
keep things simple for now, and since the generated code is typically
constant for each type of call instruction.

Generation of dedicated landing pads to unwind program stack and moving
it outline to a separate 'invented' subprog or end of subprog has been
split into the future set, where the BPF runtime needs to release
resources present on the program stack.

Another minor annoyance are the calls to bpf_get_exception to fetch
exception state. This call needs to be made unconditionally regardless
of whether an exception was thrown or not. It would be much more
convenient to have a hidden callee-saved BPF register which holds the
exception state, but I'm not using R12 for that (e.g. on x86) hurts some
other use case.

Then, checking exceptions thrown within the program becomes much more
lightweight, and the use bpf_get_exception is only limited to exceptions
thrown by helpers and kfuncs (around their call, and then the exception
register can propagate it to callers).

Callbacks invoked by the kernel synchronously will then set both
exception register and task-local exception state.

Known issues
------------

* Since bpf_throw is marked noreturn, the compiler sometimes may determine
  that a function always throws and emit the final instruction as a call
  to it without emitting an exit in the caller. This leads to an error
  where the verifier complains about final instruction not being a jump,
  exit, or bpf_throw call (which gets treated as an exit). This is
  unlikely to occur as bpf_throw wouldn't be used whenever the condition
  is already known at compile time, but I could see it when testing with
  always throwing subprogs and calling into them.

* Just asm volatile ("call bpf_throw" :::) does not emit DATASEC .ksyms
  for bpf_throw, there needs to be explicit call in C for clang to emit
  the DATASEC info in BTF, leading to errors during compilation.

Kumar Kartikeya Dwivedi (9):
  bpf: Fix kfunc callback handling
  bpf: Refactor and generalize optimize_bpf_loop
  bpf: Implement bpf_throw kfunc
  bpf: Handle throwing BPF callbacks in helpers and kfuncs
  bpf: Add pass to fixup global function throw information
  bpf: Add KF_THROW annotation for kfuncs
  bpf: Introduce bpf_set_exception_callback kfunc
  bpf: Introduce BPF assertion macros
  selftests/bpf: Add tests for BPF exceptions

 include/linux/bpf.h                           |   9 +-
 include/linux/bpf_verifier.h                  |  20 +-
 include/linux/btf.h                           |   1 +
 include/linux/sched.h                         |   1 +
 kernel/bpf/arraymap.c                         |  13 +-
 kernel/bpf/bpf_iter.c                         |   2 +
 kernel/bpf/hashtab.c                          |   4 +-
 kernel/bpf/helpers.c                          |  46 +-
 kernel/bpf/ringbuf.c                          |   4 +
 kernel/bpf/syscall.c                          |  10 +
 kernel/bpf/task_iter.c                        |   2 +
 kernel/bpf/trampoline.c                       |   4 +-
 kernel/bpf/verifier.c                         | 692 +++++++++++++++++-
 net/bpf/test_run.c                            |  12 +
 .../testing/selftests/bpf/bpf_experimental.h  |  37 +
 .../selftests/bpf/prog_tests/exceptions.c     | 240 ++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 218 ++++++
 .../selftests/bpf/progs/exceptions_ext.c      |  42 ++
 .../selftests/bpf/progs/exceptions_fail.c     | 267 +++++++
 19 files changed, 1576 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_fail.c


base-commit: d099f594ad5650e8d8232b5f31f5f90104e65def
-- 
2.40.0

