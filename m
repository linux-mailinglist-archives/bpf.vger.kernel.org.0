Return-Path: <bpf+bounces-4895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD54751653
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99CD1C2125C
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C425862A;
	Thu, 13 Jul 2023 02:32:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873DC7C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:32:39 +0000 (UTC)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06F99E
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-666ed230c81so272078b3a.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215557; x=1691807557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uvYM4GXrMbd8NwQxfNouozayytWt03X/jTP+PZjI7w=;
        b=Ew8OVwLtVivsW0zJ9zmyYXgtg2lEQfJAQdBJfFBoFI872JL1FhE9n/Nj4HcaA31N9j
         evhXR5mXBA9iTPw+tyeir878UEbuFgS8P0Z/rh62q/OAgRHIX1OWVBb8vgUQWdEXLy+D
         DIc6PQyWWIjJmCrpDPIEz/6hF5qzBKMF8ABfQCY1vFm75N4jK9yxYt0sVCBbfoSW0oKt
         8OutTsa622StrrBOHTHpu/q6o5kaAAoc4Fw9hIdCh8WeNE9V3KNR1pLDHRWr2BhWHzdl
         4GbXIqIf77QVSz0NpgTmOFgB8Io6gNTMiLGqOxKhXUhsNuKja5HW+nhLjwsL0+Cp/O8f
         rjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215557; x=1691807557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uvYM4GXrMbd8NwQxfNouozayytWt03X/jTP+PZjI7w=;
        b=PY/fN0Tyzt6545JsSlOuzOj/cG7ubW9BbA1K6dln7bWH+j+oXaUetZ0zfIWSKRlZVv
         24M/MUvZMCJEiCRMOhL9abtzaibF8jbZAG+WQBxoVSztBh7mwf82SlmDrCDuLi0KI9IZ
         lRKlZ6B9hrc6DXinvj/P3SBIRb0vvsu0ugmOlNVv3Sq3+O+jZDTDuQHVsHh7qcQszW97
         Ug82W77GQrjdUYQ4J/oYMDFQ+FMH/2j1kqomdZ+DsjJYcR89Xs7frP3w/SaYZRPS3LO6
         I/j/NRFqIUMMiws4pFUN5REaKnnm9oXjATqVmIvXRNmtIYxjoTKyEiW719eNrkWEB087
         S20A==
X-Gm-Message-State: ABy/qLa0be/FbfV37OZ9XApc5iiA7o5aqW39iEAkleeqmhBJMhKuijtt
	RkoJB7gvS7FxLKB6OS7OOJjBp0zDFcRQNA==
X-Google-Smtp-Source: APBJJlHIekIAY+JszUEf68IVp2sJWXtUVrt26UhTySCspI/LKpiwND+Jdf8+nIzPBjcHtX6PzzX5BA==
X-Received: by 2002:a05:6a00:b90:b0:66a:5d4a:e47d with SMTP id g16-20020a056a000b9000b0066a5d4ae47dmr653046pfj.8.1689215556675;
        Wed, 12 Jul 2023 19:32:36 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id c7-20020aa78807000000b006815fbe3240sm4421931pfo.11.2023.07.12.19.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:32:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 00/10] Exceptions - 1/2
Date: Thu, 13 Jul 2023 08:02:22 +0530
Message-Id: <20230713023232.1411523-1-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8366; i=memxor@gmail.com; h=from:subject; bh=gu8AMqwhxQvalXRRdFHoAbCdOOUr0pt8537eh6MzX3E=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr2HFLyXfOqk4V+Rqx+a9Hd2sOh/M/5bclOTzc CRkf4aZA0CJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9hxQAKCRBM4MiGSL8R yupSEACkBdG/kX9K8aCYW1/2zECXb8hfwJYJd5NS9pwJFuUkgAXUs0wqqK5PdXx8+k/GIi1vedm Wmt+uRwenDZR1/OJ4A78iGQE7IvUrlntn5JiQkjRtzq4x2P5S64OkbpKx3OQwod47a2loP2GvsB 75mZHlxwNkgYdXJqr8ns5XI90ONZQtj+jFkZ4jES6UsdQPGddYxy2dp38S+5jyORCNBel0Y3tjD pYUVwnYGArH/ce19JXRt4FKzemOTGTBQbU4Z3gQqv7+GlXdQ+JC27ndzuxxEANjosh6eiPJA3V8 BXlHSj3bt4vGpJqHMh7X7l9k8wpmNQIvCXcrUVaiMr4cBrEC+36AU/rV3FjecgywRetCKVfx7oC cojPYpoSKGaDnuu53xgA9X41p0iK2O84quwKZtVoQ/YYqa0PRAw0YrU0Iso5gJdgYdGACqmLY0l HTNeB+xG1Nr/DDmxNU/oU4tW+XKIsXsuXM9n9tRyYt5csYm5CFuI6SvvbmJFU7UjPYBo7dFwkt1 MJSQfILRSFabB0pgmYC7Cyocfwv1UxrE/rnshOb8ni4HAfq9qZvi5aydh+57l8zlkB/3twtUMTZ UVxL197WcD5Xm0jWB5Pdr563/qHbBH/33BClcn7fbUmJCfjo3sutXgH+/MCwRN3XOLTsDlqt4vW ejgXr+UTYkb1VCQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series implements the _first_ part of the runtime and verifier
support needed to enable BPF exceptions. Exceptions thrown from programs
are processed as an immediate exit from the program, which unwinds all
the active stack frames until the main stack frame, and returns to the
BPF program's caller. The ability to perform this unwinding safely
allows the program to test conditions that are always true at runtime
but which the verifier has no visibility into.

Thus, it also reduces verification effort by safely terminating
redundant paths that can be taken within a program.

The patches to perform runtime resource cleanup during the
frame-by-frame unwinding will be posted as a follow-up to this set.

It must be noted that exceptions are not an error handling mechanism for
unlikely runtime conditions, but a way to safely terminate the execution
of a program in presence of conditions that should never occur at
runtime. They are meant to serve higher-level primitives such as program
assertions.

As such, a program can only install an exception handler once for the
lifetime of a BPF program, and this handler cannot be changed at
runtime. The purpose of the handler is to simply interpret the cookie
value supplied by the bpf_throw call, and execute user-defined logic
corresponding to it. The primary purpose of allowing a handler is to
control the return value of the program. The default handler returns 0
when from the program when an exception is thrown.

Fixing the handler for the lifetime of the program eliminates tricky and
expensive handling in case of runtime changes of the handler callback
when programs begin to nest, where it becomes more complex to save and
restore the active handler at runtime.

The following kfuncs are introduced:

// Throw a BPF exception, terminating the execution of the program.
//
// @cookie: The cookie that is passed to the exception callback. Without
//          an exception callback set by the user, the programs returns
//          0 when an exception is thrown.
void bpf_throw(u64 cookie);

// Set an exception handler globally for the entire program. The handler
// is invoked after the unwinding of the stack is finished. The return
// value of the handler will be the return value of the program. By
// default, without a supplied exception handler, the return value is 0.
//
// Note that this helper is *idempotent*, and can only be called once in
// a program. The exception callback is then set permanently for the
// lifetime of the BPF program, and cannot be changed.
//
// @cb: The exception callback, which receives the cookie paramter
//	passed to the bpf_throw call which invoked a BPF exception.
void bpf_set_exception_callback(int (*cb)(u64 cookie));

This version of offline unwinding based BPF exceptions is truly zero
overhead, with the exception of generation of a default callback which
contains a few instructions to return a default return value (0) when no
exception callback is supplied by the user.

A limitation currently exists where all callee-saved registers have to
be saved on entry into the main BPF subprog. This will be fixed with a
follow-up or in the next revision.

Callbacks are disallowed from throwing BPF exceptions for now, since
such exceptions need to cross the callback helper boundary (and
therefore must care about unwinding kernel state), however it is
possible to lift this restriction in the future follow-up.

Exceptions terminate propogating at program boundaries, hence both
BPF_PROG_TYPE_EXT and tail call targets return to their caller context
the return value of the exception callback, in the event that they throw
an exception. Thus, exceptions do not cross extension or tail call
boundary.

However, this is mostly an implementation choice, and can be changed to
suit more user-friendly semantics.

PS: Patches 2 and 3 have been sent as [0] but are included to allow CI to
    build the set.

 [0]: https://lore.kernel.org/bpf/20230713003118.1327943-1-memxor@gmail.com

Notes
-----

A couple of questions to consider:

 * Should the default callback simply return the cookie value supplied
   to bpf_throw?

 * Should exceptions cross tail call and extension program boundaries?
   Currently they invoke the exception callback of tail call or
   extension program (if installed) and return to the caller, aborting
   propagation.

 * How should the assertion macros interface look like? It would be
   great to have more feedback from potential users (David?).

A few notes:

 * I'm working to address the callee-saved register spilling issue on
   entry into the main subprog as a follow-up. I wanted to send the
   current version out first.

 * The resource cleanup patches are based on top of this set, so once
   we converge on the implementation, they can either be appended to
   the set or sent as a follow up (whichever occurs first).

Known issues
------------

 * There is currently a splat when KASAN is enabled, which I believe to
   be a false positive occuring due to bad interplay between KASAN's stack
   memory accounting logic and my unwinding logic. I'm investigating it.

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

Changelog:
----------
RFC v1 -> v1
RFC v1: https://lore.kernel.org/bpf/20230405004239.1375399-1-memxor@gmail.com

 * Completely rework the unwinding infrastructure to use offline
   unwinding support.
 * Remove the runtime exception state and program rewriting code.
 * Make bpf_set_exception_callback idempotent to avoid vexing
   synchronization and state clobbering issues in presence of program
   nesting.
 * Disable bpf_throw within callback functions, for now.
 * Allow bpf_throw in tail call programs and extension programs,
   removing limitations of rewrite based unwinding.
 * Expand selftests.

Kumar Kartikeya Dwivedi (10):
  bpf: Fix kfunc callback register type handling
  bpf: Fix subprog idx logic in check_max_stack_depth
  bpf: Repeat check_max_stack_depth for async callbacks
  bpf: Add support for inserting new subprogs
  arch/x86: Implement arch_bpf_stack_walk
  bpf: Implement bpf_throw kfunc
  bpf: Ensure IP is within prog->jited_length for bpf_throw calls
  bpf: Introduce bpf_set_exception_callback
  selftests/bpf: Add BPF assertion macros
  selftests/bpf: Add tests for BPF exceptions

 arch/x86/net/bpf_jit_comp.c                   | 105 +++-
 include/linux/bpf.h                           |   6 +
 include/linux/bpf_verifier.h                  |   9 +-
 include/linux/filter.h                        |   8 +
 kernel/bpf/core.c                             |  15 +-
 kernel/bpf/helpers.c                          |  44 ++
 kernel/bpf/syscall.c                          |  19 +-
 kernel/bpf/verifier.c                         | 284 +++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  28 ++
 .../selftests/bpf/prog_tests/exceptions.c     | 272 +++++++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 450 ++++++++++++++++++
 .../selftests/bpf/progs/exceptions_ext.c      |  42 ++
 .../selftests/bpf/progs/exceptions_fail.c     | 311 ++++++++++++
 13 files changed, 1537 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_fail.c


base-commit: 0a5550b1165cd60ad6972791eda4a3eb7e347280
-- 
2.40.1


