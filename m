Return-Path: <bpf+bounces-2682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ADD73240B
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 02:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D2728159D
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 00:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67133368;
	Fri, 16 Jun 2023 00:04:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC497C
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 00:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36449C433C0;
	Fri, 16 Jun 2023 00:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686873892;
	bh=51mwmhOfmWg2iKgpMyXdCK9LdMkNJIor8yuUuwPQBtE=;
	h=From:To:Cc:Subject:Date:From;
	b=FLxPLuSbgTaGgUaF7JcSXmcAVrGjn8va5ODnts9n1RnTiM95l6ji6GI4oLVuYEByM
	 ygrvSIEVIn/mv6PrD97AQQ2TNCubC0h7sR28YRhnFfxVVUZPwPL02mN0X0coxrJiMw
	 0Vy3UodOVkJXp8KD4nB4gfkO3MvfcjeeR1O4mYXTzp7bPEOr9OmC10emvaX8h2YiQt
	 G5zIeFes76YWeSZm1ZQ6aWNhaeZVcpU7uOYj2Q9sr/a+d4RncMZlLjhBIak4cvc6Wc
	 WVQSfiW7ZOP63MPqeRdwaSpzPobmnrVsV3I7Po3p60O8wBcOOeUL2IydzacXcziM2y
	 PIcC0r4Vl2nbQ==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	keescook@chromium.org,
	casey@schaufler-ca.com,
	song@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	jannh@google.com
Subject: [PATCH v2 0/5] Reduce overhead of LSMs with static calls
Date: Fri, 16 Jun 2023 02:04:36 +0200
Message-ID: <20230616000441.3677441-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Background

LSM hooks (callbacks) are currently invoked as indirect function calls. These
callbacks are registered into a linked list at boot time as the order of the
LSMs can be configured on the kernel command line with the "lsm=" command line
parameter.

Indirect function calls have a high overhead due to retpoline mitigation for
various speculative execution attacks.

Retpolines remain relevant even with newer generation CPUs as recently
discovered speculative attacks, like Spectre BHB need Retpolines to mitigate
against branch history injection and still need to be used in combination with
newer mitigation features like eIBRS.

This overhead is especially significant for the "bpf" LSM which allows the user
to implement LSM functionality with eBPF program. In order to facilitate this
the "bpf" LSM provides a default callback for all LSM hooks. When enabled,
the "bpf" LSM incurs an unnecessary / avoidable indirect call. This is
especially bad in OS hot paths (e.g. in the networking stack).
This overhead prevents the adoption of bpf LSM on performance critical
systems, and also, in general, slows down all LSMs.

Since we know the address of the enabled LSM callbacks at compile time and only
the order is determined at boot time, the LSM framework can allocate static
calls for each of the possible LSM callbacks and these calls can be updated once
the order is determined at boot.

This series is a respin of the RFC proposed by Paul Renauld (renauld@google.com)
and Brendan Jackman (jackmanb@google.com) [1]

# Performance improvement

With this patch-set some syscalls with lots of LSM hooks in their path
benefitted at an average of ~3% and I/O and Pipe based system calls benefitting
the most.

Here are the results of the relevant Unixbench system benchmarks with BPF LSM
and SELinux enabled with default policies enabled with and without these
patches.

Benchmark                                               Delta(%): (+ is better)
===============================================================================
Execl Throughput                                             +1.9356
File Write 1024 bufsize 2000 maxblocks                       +6.5953
Pipe Throughput                                              +9.5499
Pipe-based Context Switching                                 +3.0209
Process Creation                                             +2.3246
Shell Scripts (1 concurrent)                                 +1.4975
System Call Overhead                                         +2.7815
System Benchmarks Index Score (Partial Only):                +3.4859

In the best case, some syscalls like eventfd_create benefitted to about ~10%.
The full analysis can be viewed at https://kpsingh.ch/lsm-perf

[1] https://lore.kernel.org/linux-security-module/20200820164753.3256899-1-jackmanb@chromium.org/


# BPF LSM Side effects

Patch 4 of the series also addresses the issues with the side effects of the
default value return values of the BPF LSM callbacks and also removes the
overheads associated with them making it deployable at hyperscale.

# v1 -> v2 (based on linux-next, next-20230614)

- Incorporated suggestions from Kees
- Changed the way MAX_LSMs are counted from a binary based generator to a clever header.
- Add CONFIG_SECURITY_HOOK_LIKELY to configure the likelihood of LSM hooks.

(Note on avaialability: I won't be able to reply / rev the series for the next couple of weeks)

KP Singh (5):
  kernel: Add helper macros for loop unrolling
  security: Count the LSMs enabled at compile time
  security: Replace indirect LSM hook calls with static calls
  bpf: Only enable BPF LSM hooks when an LSM program is attached
  security: Add CONFIG_SECURITY_HOOK_LIKELY

 include/linux/bpf.h       |   1 +
 include/linux/bpf_lsm.h   |   5 +
 include/linux/lsm_count.h | 131 +++++++++++++++++++++++++
 include/linux/lsm_hooks.h |  81 ++++++++++++++--
 include/linux/unroll.h    |  36 +++++++
 kernel/bpf/trampoline.c   |  29 +++++-
 security/Kconfig          |  11 +++
 security/bpf/hooks.c      |  25 ++++-
 security/security.c       | 197 +++++++++++++++++++++++++-------------
 9 files changed, 438 insertions(+), 78 deletions(-)
 create mode 100644 include/linux/lsm_count.h
 create mode 100644 include/linux/unroll.h

-- 
2.41.0.162.gfafddb0af9-goog


