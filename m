Return-Path: <bpf+bounces-20889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B44D84501F
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E892C1C230BD
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D413A3B79F;
	Thu,  1 Feb 2024 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsOVPQAj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF23B78D
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761275; cv=none; b=ZLK94O0kDhh3jWZZyjz1dD2XYRMdHy7TWtaDMNBTH6hXvorlReue4RxQUiIUudsy99tprK84lAWYdkltDsvj0uYVU5JKZvUdVtJ66VGjqai+CDvx2LBj7q63yNZVHszxfQsKwvfGY1oRLDeYc+VJ6PnFUjxkMTdAN8J+GeU9Upg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761275; c=relaxed/simple;
	bh=kr3R+BqPASOPOYWX0k6XntaFtWLA5NJ1I5aVsNAFrGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JWQGSki+UMEKuFaaSfrzP2xs1Os9ATZtuk1bujElqd4GMagDxM8AOxlKgvLzCKTZba4aAWb+AqLD+m9YdpdTnoVsfzifefo+P+Y4W07u5Co5k2Va1RX9eesUXoPpz1r7//ajYIC7uZv4d2/SrAIjtxMtSOx91SzOuHY3I35aRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsOVPQAj; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so555584a12.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761271; x=1707366071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAVqCojkjcN0JNxecRXbK9Vpc8JsINCpF9S+LZVNjbo=;
        b=QsOVPQAjrL7+EGwUJKY6m77ofM9isOEmIqICQR6Qz3CInkR51ZAermn72ZtMXXb9y3
         Kw8hzG6GyNEg84mw3jVvtnQyN+cqjOlsSRRkY3Vei2z4YPaIQoBkBmZs8jX66DcgGRF1
         TwqeWaa2w4WQsZnC5gSHX4U1Q/DdvCqSXJmB5AHOp+fR7oeBD9KH1iupDFzZwKleqc+G
         tvMJtj/9t9+xm5OITpuJ4aIGIpugD2e4o/TRh7ZIUSwdbLNpZlK4Xu2loRPdoNPf0uRM
         qI5xMRrjBp8nFUErvG24/JiDZylya5eqHECScAp2+ue0JgbKSQCBeU8VYOVuTOvZ4n8L
         lSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761271; x=1707366071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAVqCojkjcN0JNxecRXbK9Vpc8JsINCpF9S+LZVNjbo=;
        b=KPb3UoH2Vz8C/JoCI/GzY0nLXN1yQkS2GdkC1X9vl+JsBy1r3k7btJeB3G51LXPs7B
         TI62GCAi929Vs8g7Fbk1JPTPfyY1fXAvyvJ3Wu+wfo5M50l5KT2U6bszn28Di9aGQc8F
         SkRyFgdwx7nym7dlCeCfJwRyu5Js1d+mUNcEHCClikhkxXI7p4xp/q0hELlEA7XmZ56o
         hz94+a5qmu4WGiaulzI8b12J7H+T0peGTqKF0tPABZk9jewI2wXNqFIWBpdhzph+LBvB
         wzbdDn41wo3KsEyy1LtkP6adN19Pb+VNEFWH2axUmISowbKZhKGwN8TMYor087quK1ws
         qE5A==
X-Gm-Message-State: AOJu0YwYT/WVPEMOgaUfCv1AR7yQ5h5r5vHWh8xINE3stlbvzo2owTxL
	EnB7S4XO+b4h2dMgGUOJ2ya9UQUapOuTAZQkZcux1ur8XUjFicxiGhZziTkjpXE=
X-Google-Smtp-Source: AGHT+IH0sNnGnkRHMCDT0c3oFgNwvOqbQOXHrFu2sZ97MGuBcM0bLY1OfAMo+gkdHsacnwNG+KBiNA==
X-Received: by 2002:a17:906:2894:b0:a36:7327:410a with SMTP id o20-20020a170906289400b00a367327410amr2523294ejd.58.1706761270769;
        Wed, 31 Jan 2024 20:21:10 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ig8-20020a1709072e0800b00a36c2ab1b14sm116471ejc.139.2024.01.31.20.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:09 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 00/14] Exceptions - Resource Cleanup
Date: Thu,  1 Feb 2024 04:20:55 +0000
Message-Id: <20240201042109.1150490-1-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5612; i=memxor@gmail.com; h=from:subject; bh=kr3R+BqPASOPOYWX0k6XntaFtWLA5NJ1I5aVsNAFrGI=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwL1cEhh2ApCRAByKPxS/M1i0XlR6IREO8Ie oexKEzHN/WJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscCwAKCRBM4MiGSL8R yiGkD/9CtbZDQLzGz9SQqUbgME6oFnKgv0wxb2PdnROOb2rqbAu3RMOim7fIOh6U4FZjvD0/PIS 9Sv4V5fx5mH9S48xfiN6Lnuu5fkqQltI3pSSCCXBBJ+0thpqKdNKH4vN+EgiWfQeoQh7CnOhiGy +w4jG/KUgBDjS0tiU6e7OFGa5TLyjHTHddCan/Jt9loBfikUT/kEv+ey2HBIYG+9hxHYORQXbD9 TuhJpkFXD6TiQMAx7Tt6MQAFzBsTSti7IZkhi03LzpnLQNuxvIE1ndhKH50drl5QZcrBFXmNrCR h6zMLmM7EdLZA/+NEr3lzT3/43QTjj3lNh9BdsLkoONx4GAMzfbaL/NRmXhd92yV7xZHglWc6yC vI8fXiD2fEQvo+MP4ZjMuCFezE6W3Kv4eLgHEMO84ECiXe6koeQvng2SwBhXTeIn3kXUPnKCaG+ Kx61+6EiIRjKRsPDJIhgxPwcktOMMpnGkmqwxCPqvwYXjMdendGyh5EYSWEKgpVVEww9DQP1yhW cz7S7gAf/9ijdLlxeFNd69h7adrRQx76DwLllMRCleHXfnA2IPQGxehIRnJGD/DOjO59eySAn3G NRKqFwpN7gyAihSd4GbXf/VgVrc5g4IkXMp3sMkmgPFi3DxDg+OrGgBOmNjtv9FaPTWyuyh5znq Wq5vK0oNBwcJ2xQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set implements the second part of the exceptions set, with support
for releasing resources at runtime during the unwinding phase. This
allows programs to throw an exception at any point of time and terminate
their execution immediately.

Currently, any acquired resources held by the program will cause a
thrown exception to fail during verification. This is because safely
unwinding the stack requires releasing these resources which represent
kernel objects and locks. Not doing this and continuing the stack
unwinding will destroy the stack frames containing such objects and will
lead to all kinds of issues and the violation of BPF's safety
properties.

Note that while the current mechanism only supports throwing exceptions
synchronously, the unwinding mechanism only requires a valid frame
descriptor to perform the cleanup. Thus, in a followup, we can build on
top of this series to introduce support for preempting execution of BPF
programs and terminating them, in cases where termination is not
statically provable and the program exceeds some runtime threshold.
This can also allow holding multiple locks at the same time, detecting
deadlocks and aborting programs, etc.

In this set, we implement support that allows the kernel to release such
resources when performing the unwinding step for the program and
aborting it. To enable this, the kernel needs to be made aware about the
layout of the program stack (for each BPF frame) and the type of each
kernel object residing therein. This information is retrieved at runtime
by tying this metadata to the program counter.

Everytime a bpf_throw call is processed by the verifier, it generates a
frame descriptor for the caller and all of its caller frames, and ties
them to the program counter. At runtime, the kernel will only process
unwinding requests for such program counters, and this mapping of frame
descriptors to the PC will allow their discovery of resources for each
frame.

Note that at the same program point, there cannot be a case where the
verifier may have to produce distinct frame descriptors. If such a case
is encountered, then the verification will fail. This is an uncommon
case where depending on the program path taken at runtime, the same
stack slot may contain pointers of different types. In most of these
examples, the program would not pass the verifier anyway, since the
value that has to be freed would be lost in verifier state and cannot be
recovered.

A special provision is made for cases where the stack slot contains NULL
or a pointer in two different program paths, it is quite common for such
a case to occur where a resource may be acquired conditionally, and the
release occurs later in the program guarded by the same conditional.

Notes
=====

 * Releasing bpf_spin_lock, RCU read locks is not supported in the RFC,
   but will be done as a follow up or added to the next revision on top
   of this set.
 * A few known rough edges/minor bugs which will be fixed in the next
   version.
 * Adding more tests for corner cases.

Kumar Kartikeya Dwivedi (14):
  bpf: Mark subprogs as throw reachable before do_check pass
  bpf: Process global subprog's exception propagation
  selftests/bpf: Add test for throwing global subprog with acquired refs
  bpf: Refactor check_pseudo_btf_id's BTF reference bump
  bpf: Implement BPF exception frame descriptor generation
  bpf: Adjust frame descriptor pc on instruction patching
  bpf: Use hidden subprog trampoline for bpf_throw
  bpf: Compute used callee saved registers for subprogs
  bpf, x86: Fix up pc offsets for frame descriptor entries
  bpf, x86: Implement runtime resource cleanup for exceptions
  bpf: Release references in verifier state when throwing exceptions
  bpf: Register cleanup dtors for runtime unwinding
  bpf: Make bpf_throw available to all program types
  selftests/bpf: Add tests for exceptions runtime cleanup

 arch/x86/net/bpf_jit_comp.c                   | 116 ++-
 drivers/hid/bpf/hid_bpf_dispatch.c            |  17 +
 include/linux/bpf.h                           |  57 ++
 include/linux/bpf_verifier.h                  |   9 +-
 include/linux/btf.h                           |  10 +-
 include/linux/filter.h                        |   3 +
 kernel/bpf/btf.c                              |  11 +-
 kernel/bpf/core.c                             |  18 +
 kernel/bpf/cpumask.c                          |   3 +-
 kernel/bpf/helpers.c                          | 165 +++-
 kernel/bpf/verifier.c                         | 714 +++++++++++++++++-
 kernel/trace/bpf_trace.c                      |  16 +
 net/bpf/test_run.c                            |   4 +-
 net/core/filter.c                             |   5 +
 net/netfilter/nf_conntrack_bpf.c              |  14 +-
 net/xfrm/xfrm_state_bpf.c                     |  16 +
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../bpf/prog_tests/exceptions_cleanup.c       |  65 ++
 .../selftests/bpf/progs/exceptions_cleanup.c  | 468 ++++++++++++
 .../bpf/progs/exceptions_cleanup_fail.c       | 154 ++++
 .../selftests/bpf/progs/exceptions_fail.c     |  38 +-
 22 files changed, 1817 insertions(+), 88 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c


base-commit: 77326a4a06e1e97432322f403cb439880871d34d
-- 
2.40.1


