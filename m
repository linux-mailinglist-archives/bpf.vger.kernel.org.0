Return-Path: <bpf+bounces-9824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 136EA79DCA8
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40441C212A1
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD4125D7;
	Tue, 12 Sep 2023 23:32:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2817C2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:18 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B041910FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-9a6190af24aso772364866b.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561536; x=1695166336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPuWazfASr1wC5dtt2RgFA5TbA6rDFn3kEak4sradTs=;
        b=ij7ulbtnK5R7p+y69WEZbCSOIUUdc8mqD4rLWr/sPGbp0Ng9JHDkbOYnICX4KN3kvP
         hG8RmQDUhRWJ+lvzkuxvEIhk7LWPUS/lzV6UAOnBFxYVzythFFv8dxVc1UtO1D0xMaKc
         MoC2JLe3rR38Lnx49Un65xq/PAGocYE5m0Wvxjz8JQGI6FV8Fntqs1zqvnlV26FNXt1N
         v6ZORWbDvRg0b2c7dlXt2UgizADqZxFN5OyH0ElsYIzjGy+3BRhpoBbhacPen6EEoPDX
         CCpaSQTrJ5Lg8zGPLMapgVczAgm8Mp6eo0DzcFxf004RbIbi14ZtsduecdBCd7NGkP2d
         hRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561536; x=1695166336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPuWazfASr1wC5dtt2RgFA5TbA6rDFn3kEak4sradTs=;
        b=ZKFkkgUKMZiCVbIWb701KEr6nDF5lM28HjH14uS4FSHcXPA6/+PUJoyir4uEV5wbEF
         Vz9Z1Y5up0aKTbBLvmX27MbdbbCRy8lp9WBQWDX/e6rq4Qtiu6RH5I6fl25SQKcYc52s
         sZROOiRYyjdRIgj8/BrobEwRNE6D8NWFKH/JAxcxp/QGVyDvpmHpH2Xfmo8YqByaMBDV
         4q3m0JgRBSrdH3EPwWHjdOmova/I1be5QV90IVRuKrBbHpbyBk0tDyoMmZdOWgLmbLWc
         7O7xIYpcRHn/Yh2La8XCSFB+A8DWguibqMI2cLB/y2jcexi514R3AgswMIbqn65mB0qN
         vGDQ==
X-Gm-Message-State: AOJu0Yx33qet9D3pnnyJT3gc3ChMWjZ8jHefvNll1aPYCJdB77Do4Rfb
	2OUD+UN20P+ChzmAjIffQ1hVyakCZYVcNg==
X-Google-Smtp-Source: AGHT+IFWaaO4Aet5ayfqffKCbYatl/nH94rsZXkZdpQxUnlT8s50A6NatFG8mbWy0mn5YHivzNxebw==
X-Received: by 2002:a17:906:20dc:b0:9a1:e395:2d10 with SMTP id c28-20020a17090620dc00b009a1e3952d10mr610655ejc.75.1694561535617;
        Tue, 12 Sep 2023 16:32:15 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id kf4-20020a17090776c400b0099c53c4407dsm7417866ejc.78.2023.09.12.16.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 00/17] Exceptions - 1/2
Date: Wed, 13 Sep 2023 01:31:57 +0200
Message-ID: <20230912233214.1518551-1-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9678; i=memxor@gmail.com; h=from:subject; bh=MJJXF+paqYPFu0RtuYTSJVUl1hdnfuUxNpYzcsyK/pA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSsJnNwaN5A8W6Dtp/2KL4Shei2srAfe86Mq VwCjPZjzXSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rAAKCRBM4MiGSL8R yoeYD/9NMpFLB8SZVcxyk9zM7dojQJ2fwFAglP7JxIwmLJGE0zirIp/4jtrB6Bu7NGZh2wpXghG ZpGxWXIR9CUYwOXiNpLo7UU2U4JelQnAEV4zMOD0XuMC1az/tkZ5E/1dIFql9hB6NU6EKbsEw4h eSdYuOjN3PcBfwhukvCa5tD+/WOW9Af/SF/S+uJ/AKYryyHIS2cBOn+rZT/ieaDnpsXNVK1kxLX cgY7+39ce0FFJ1B4FJe8S8AMhHrsFAa+wqXLaRHGw6lG6Yz4T28CgVl19tVvNfSjfO0vQrj42w6 7Vba9JcgEmFqpJDCEnl9AQfgidB3WCheDToNHZEIe2FuAcTKD1t3XhPYWanHSpnIff+A0QrteyX HT/04Wk1kTB+F09Dv5l9m87TG9mrniU6Ve49g0gGTvNEMzOWxNyz7MKLcZvoLNH0OnMvdH0B+2G aCXypvDa+ny48GIPiJ9zfZNV9tSD1NVWXOpTaKk70YJGkZfa4jnit5XX+0FUjkkz6r8zPgeTOYw pFn15XurvNjmC18SdL2ZaDvvZjgCEC0AY260JctnQYp7IPhlLRMBryu5uNHrkQrjSHFg4rZrnOC mrFQD5LtPdFsdxTY+iXXa5v0uC9qYCU/JKY3SkmZhET2Mzf2I5dpoR0iv3sRju4QK6rQFYj6l8I /cGYb5CAs9vb1Nw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

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

The following kfuncs and macros are introduced:

Assertion macros are also introduced, please see patch 13 for their
documentation.

/* Description
 *	Throw a BPF exception from the program, immediately terminating its
 *	execution and unwinding the stack. The supplied 'cookie' parameter
 *	will be the return value of the program when an exception is thrown,
 *	and the default exception callback is used. Otherwise, if an exception
 *	callback is set using the '__exception_cb(callback)' declaration tag
 *	on the main program, the 'cookie' parameter will be the callback's only
 *	input argument.
 *
 *	Thus, in case of default exception callback, 'cookie' is subjected to
 *	constraints on the program's return value (as with R0 on exit).
 *	Otherwise, the return value of the marked exception callback will be
 *	subjected to the same checks.
 *
 *	Note that throwing an exception with lingering resources (locks,
 *	references, etc.) will lead to a verification error.
 *
 *	Note that callbacks *cannot* call this helper.
 * Returns
 *	Never.
 * Throws
 *	An exception with the specified 'cookie' value.
 */
extern void bpf_throw(u64 cookie) __ksym;

/* This macro must be used to mark the exception callback corresponding to the
 * main program. For example:
 *
 * int exception_cb(u64 cookie) {
 *	return cookie;
 * }
 *
 * SEC("tc")
 * __exception_cb(exception_cb)
 * int main_prog(struct __sk_buff *ctx) {
 *	...
 *	return TC_ACT_OK;
 * }
 *
 * Here, exception callback for the main program will be 'exception_cb'. Note
 * that this attribute can only be used once, and multiple exception callbacks
 * specified for the main program will lead to verification error.
 */
\#define __exception_cb(name) __attribute__((btf_decl_tag("exception_callback:" #name)))

As such, a program can only install an exception handler once for the
lifetime of a BPF program, and this handler cannot be changed at
runtime. The purpose of the handler is to simply interpret the cookie
value supplied by the bpf_throw call, and execute user-defined logic
corresponding to it. The primary purpose of allowing a handler is to
control the return value of the program. The default handler returns the
cookie value passed to bpf_throw when an exception is thrown.

Fixing the handler for the lifetime of the program eliminates tricky and
expensive handling in case of runtime changes of the handler callback
when programs begin to nest, where it becomes more complex to save and
restore the active handler at runtime.

This version of offline unwinding based BPF exceptions is truly zero
overhead, with the exception of generation of a default callback which
contains a few instructions to return a default return value (0) when no
exception callback is supplied by the user.

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

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20230809114116.3216687-1-memxor@gmail.com

 * Add Dave's Acked-by.
 * Address all comments from Alexei.
   * Use bpf_is_subprog to check for main prog in bpf_stack_walker.
   * Drop accidental leftover hunk in libbpf patch.
   * Split libbpf patch's refactoring to aid review
   * Disable fentry/fexit in addition to freplace for exception cb.
   * Add selftests for fentry/fexit/freplace on exception cb and main prog.
 * Use btf_find_by_name_kind in bpf_find_exception_callback_insn_off (Martin)
 * Split KASAN patch into two to aid backporting (Andrey)
 * Move exception callback append step to bpf_object__reloacte (Andrii)
 * Ensure that the exception callback name is unique (Andrii)
 * Keep ASM implementation of assertion macros instead of C, as it does
   not achieve intended results for bpf_assert_range and other cases.

v1 -> v2
v1: https://lore.kernel.org/bpf/20230713023232.1411523-1-memxor@gmail.com

 * Address all comments from Alexei.
 * Fix a few bugs and corner cases in the implementations found during
   testing. Also add new selftests for these cases.
 * Reinstate patch to consider ksym.end part of the program (but
   reworked to cover other corner cases).
 * Implement new style of tagging exception callbacks, add libbpf
   support for the new declaration tag.
 * Limit support to 64-bit integer types for assertion macros. The
   compiler ends up performing shifts or bitwise and operations when
   finally making use of the value, which defeats the purpose of the
   macro. On noalu32 mode, the shifts may also happen before use,
   hurting reliability.
 * Comprehensively test assertion macros and their side effects on the
   verifier state, register bounds, etc.
 * Fix a KASAN false positive warning.

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

Kumar Kartikeya Dwivedi (17):
  bpf: Use bpf_is_subprog to check for subprogs
  arch/x86: Implement arch_bpf_stack_walk
  bpf: Implement support for adding hidden subprogs
  bpf: Implement BPF exceptions
  bpf: Refactor check_btf_func and split into two phases
  bpf: Add support for custom exception callbacks
  bpf: Perform CFG walk for exception callback
  bpf: Treat first argument as return value for bpf_throw
  mm: kasan: Declare kasan_unpoison_task_stack_below in kasan.h
  bpf: Prevent KASAN false positive with bpf_throw
  bpf: Detect IP == ksym.end as part of BPF program
  bpf: Disallow fentry/fexit/freplace for exception callbacks
  bpf: Fix kfunc callback register type handling
  libbpf: Refactor bpf_object__reloc_code
  libbpf: Add support for custom exception callbacks
  selftests/bpf: Add BPF assertion macros
  selftests/bpf: Add tests for BPF exceptions

 arch/arm64/net/bpf_jit_comp.c                 |   2 +-
 arch/s390/net/bpf_jit_comp.c                  |   2 +-
 arch/x86/net/bpf_jit_comp.c                   | 117 ++++-
 include/linux/bpf.h                           |  13 +-
 include/linux/bpf_verifier.h                  |   8 +-
 include/linux/filter.h                        |   8 +
 include/linux/kasan.h                         |   2 +
 kernel/bpf/btf.c                              |  29 +-
 kernel/bpf/core.c                             |  29 +-
 kernel/bpf/helpers.c                          |  45 ++
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         | 456 +++++++++++++++---
 mm/kasan/kasan.h                              |   1 -
 tools/lib/bpf/libbpf.c                        | 166 ++++++-
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../testing/selftests/bpf/bpf_experimental.h  | 288 +++++++++++
 .../selftests/bpf/prog_tests/exceptions.c     | 408 ++++++++++++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 368 ++++++++++++++
 .../selftests/bpf/progs/exceptions_assert.c   | 135 ++++++
 .../selftests/bpf/progs/exceptions_ext.c      |  72 +++
 .../selftests/bpf/progs/exceptions_fail.c     | 347 +++++++++++++
 22 files changed, 2376 insertions(+), 124 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_assert.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_fail.c


base-commit: 5bbb9e1f08352a381a6e8a17b5180170b2a93685
-- 
2.41.0


