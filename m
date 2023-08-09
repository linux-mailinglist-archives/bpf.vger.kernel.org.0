Return-Path: <bpf+bounces-7333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA26C775DD9
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4771E281B28
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA4018002;
	Wed,  9 Aug 2023 11:41:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097C17FE3
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:41:30 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF6F173A
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:41:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so8755285a12.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581286; x=1692186086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TtpzjHLoHgaMDqgSRL7xoaoEHj9FQExpgHDqNpnV7B4=;
        b=LFR2VnQifb02/UF/kzlpWCwqeFu/dw+bvK4t4dqvainXynJpmFYEQoBrjEpow/AqQE
         pptjcgd5uwHT5+F8WV2y7sOYZ3KmGBpKepaSE6q18XXpRUXAx+wR2qeCE6SbqXSeYDws
         wEWnVcpnpc2qLUVNtRaa214DXXre+xFoCleZ1DYCfAmmGJZQ0G0B3fAQKJehKFrUiMXI
         kW00nyA1bzj7NF/TjnW1+vqRsuElo0mRfR38OvzRdgsoBqZUhNRRJ1Ph9zuJBIpipXdm
         utgzRsXe/e7uCTHQ/T+++edlrF2ysiLdZmMiFmwGlXedzN4oxSN4jI/FtujFR9L3Vkgc
         dWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581286; x=1692186086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtpzjHLoHgaMDqgSRL7xoaoEHj9FQExpgHDqNpnV7B4=;
        b=YN3aaej0p/+mLUzNTKywd7jNT732XSBtL+hOQInouta3Zy2FSahd+nzNrxrcXhCNJp
         I40VpH3VANNCeGti+tt4widSxzruork2PuiDJW8jopwMFXCEQWJdYyh/9G7C3wFPAPzB
         yJGQo7lFrkV6/+eXQK8RB0Lu0s6jKI4V5xQBxqLkzZWJ13tVltCwKduhnfSE0fm+PVKF
         wz4Eug0W2KVGZwqiE4XXMZ1HYKnZyuFQlmvlm+cK9ZzDKRuqfkKIELao5PQmJ7Iw6xts
         3QWEbZvbVAW9wwaxBoEuzxA/NLxozhzrZS8C7Va38X1K2yWoLQWiz3r84sTwqFs4sPa6
         BUkw==
X-Gm-Message-State: AOJu0YwqrFkJJfnsF4X8zbikENgpwGc1ngZUq6LN9Syd+AyKHCXIPUmh
	dG2pf+3U7F5A6obyNDCQ1CGO7rAfAWL8mVUQkg4=
X-Google-Smtp-Source: AGHT+IGtsN3d0o/xZIgkIqcF20fyNbcIKXSS07Pm/oHFgoZ8CtrCv/66sTWX+SM5nczWxbEISE/Tzg==
X-Received: by 2002:a05:6402:1602:b0:51b:d567:cfed with SMTP id f2-20020a056402160200b0051bd567cfedmr2292397edv.5.1691581286236;
        Wed, 09 Aug 2023 04:41:26 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id e14-20020a50fb8e000000b0051df67eaf62sm8012873edq.42.2023.08.09.04.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:41:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 00/14] Exceptions - 1/2
Date: Wed,  9 Aug 2023 17:11:02 +0530
Message-ID: <20230809114116.3216687-1-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8692; i=memxor@gmail.com; h=from:subject; bh=ktel/tEhGiw62jAB9m063feRvuGmTTp/0Z9qEEcKkK4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rIeuQRpQCOMTu+uO0CU8UQc+Ols4YEKuDns 5vCF/uFMY2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yAAKCRBM4MiGSL8R ysVID/4lDfB4sGOwS0YsOE0NFIEsQj/4YY4i54NvECA4MayEnmM1pMjkzZ+syraB8wsxNVr7GHS ox6CijPnQvY19+iPF32OQT1+Fov2dhxce1Kui4pC7ECDZUQL/yIsR6dfVqzWHayEI4F9RK3n4O1 WwKq7Aj7e76h+JZuqb7TZz7jrUAgSv5A2KW85+e11tBnRYK7TH60r//nSP3hAbErKT330PpAJVO gidiGUnrflYnKiNlshQEjGYbTGj7H7lQd+ALz81kzNSurCgJy4xTttJVr+VkUtjUpRBpuT17H6+ dv81Q4bOnPUMGF/6H8GM+gI2HyqORqicdk9vtu0kfJ8h2ZlFX+D9t6CGnnsqOlqJlJZARya+gNv svb/g3IGsknH7aX/h+MFejt+awdQb0KLEA5JrJSLhKi0Z67kOg8eblnrqhLVFrrYxiqih7ZHWSh 0pJKDfNqBE0unEJ2Fk1yHA/8leBPchfCNoRQqrxvu2bKE/Kp6wH7MNQtzx1HDozW7TlHth7MSUl qFb436CxrnfHx6J4A8xuS6LH723RvDAXYnoAsdRsLBzI2qu7xq6Qe367GF+WjRhK09/IZO9RIWB F2r4BsNxY2xXsIgKM4xsVTuLX3mUG9Qfd60jWUzKKE2If7ogGEkY69kTTQvoRGOb4n746OH3h92 yrlCOQQwC6HFpHQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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

Known issues
------------

 * Just asm volatile ("call bpf_throw" :::) does not emit DATASEC .ksyms
   for bpf_throw, there needs to be explicit call in C for clang to emit
   the DATASEC info in BTF, leading to errors during compilation.

Changelog:
----------
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

Kumar Kartikeya Dwivedi (14):
  arch/x86: Implement arch_bpf_stack_walk
  bpf: Implement support for adding hidden subprogs
  bpf: Implement BPF exceptions
  bpf: Refactor check_btf_func and split into two phases
  bpf: Add support for custom exception callbacks
  bpf: Perform CFG walk for exception callback
  bpf: Treat first argument as return value for bpf_throw
  bpf: Prevent KASAN false positive with bpf_throw
  bpf: Detect IP == ksym.end as part of BPF program
  bpf: Disallow extensions to exception callbacks
  bpf: Fix kfunc callback register type handling
  libbpf: Add support for custom exception callbacks
  selftests/bpf: Add BPF assertion macros
  selftests/bpf: Add tests for BPF exceptions

 arch/x86/net/bpf_jit_comp.c                   | 118 ++++-
 include/linux/bpf.h                           |   8 +-
 include/linux/bpf_verifier.h                  |   8 +-
 include/linux/filter.h                        |   8 +
 include/linux/kasan.h                         |   2 +
 kernel/bpf/btf.c                              |  29 +-
 kernel/bpf/core.c                             |  29 +-
 kernel/bpf/helpers.c                          |  45 ++
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         | 455 +++++++++++++++---
 tools/lib/bpf/libbpf.c                        | 166 ++++++-
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../testing/selftests/bpf/bpf_experimental.h  | 287 +++++++++++
 .../selftests/bpf/prog_tests/exceptions.c     | 324 +++++++++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 368 ++++++++++++++
 .../selftests/bpf/progs/exceptions_assert.c   | 135 ++++++
 .../selftests/bpf/progs/exceptions_ext.c      |  59 +++
 .../selftests/bpf/progs/exceptions_fail.c     | 347 +++++++++++++
 19 files changed, 2271 insertions(+), 121 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_assert.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_fail.c


base-commit: 2adbb7637fd1fcec93f4680ddb5ddbbd1a91aefb
-- 
2.41.0


