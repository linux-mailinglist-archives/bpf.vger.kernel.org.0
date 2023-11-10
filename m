Return-Path: <bpf+bounces-14803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2957E8576
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 23:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED4C1F20F10
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 22:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45A3C6BD;
	Fri, 10 Nov 2023 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbY2ua47"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059B3C696
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 22:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6683BC433C7;
	Fri, 10 Nov 2023 22:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699654848;
	bh=eBZkUw/KeZezdhgwqLnavVcv2WlLhkH+00hDq11wuxw=;
	h=From:To:Cc:Subject:Date:From;
	b=GbY2ua47ZUWWYVEQ03PH8HIgIOaYaXt0hNEhNRtEuGLEq+bVVvAMZPGlaQ7qwKxLi
	 AAoIEeri9aStCAS32sZ+SffqrbxsA1qeE3ZdQiUfJV+w2LRO96jtX9bprllFpSiVMx
	 cM4wiEnCK9cK3nx/iW9/drfi5TM3usjmsl+EJ3XW4b2oZ87YDKwcUWWzAC85cLHvvQ
	 AULY99dQYTO2SUoh2neR1S3wk3lT4TJjj3E0BROuaV5sYSeW+8PQG4YgHbgE/0lyZ0
	 D6X/ucOUvYpl86imH9VS+4Ddy+xonmBJbUMEP46JMmEGULOTociReoeaTamqw6iudA
	 zpSU3K6UUN4Fw==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	keescook@chromium.org,
	casey@schaufler-ca.com,
	song@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	kpsingh@kernel.org,
	renauld@google.com,
	pabeni@redhat.com
Subject: [PATCH v8 0/5] Reduce overhead of LSMs with static calls
Date: Fri, 10 Nov 2023 23:20:32 +0100
Message-ID: <20231110222038.1450156-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

# v7 to v8

* Addressed Andrii's feedback
* Rebased (this seems to have removed the syscall changes). v7 has the required
  conflict resolution incase the conflicts need to be resolved again.

# v6 -> v7

* Rebased with latest LSM id changes merged

NOTE: The warning shown by the kernel test bot is spurious, there is no flex array
and it seems to come from an older tool chain.

https://lore.kernel.org/bpf/202310111711.wLbijitj-lkp@intel.com/

# v5 -> v6

* Fix a bug in BPF LSM hook toggle logic.

# v4 -> v5

* Rebase to linux-next/master
* Fixed the case where MAX_LSM_COUNT comes to zero when just CONFIG_SECURITY
  is compiled in without any other LSM enabled as reported here:

  https://lore.kernel.org/bpf/202309271206.d7fb60f9-oliver.sang@intel.com

# v3 -> v4

* Refactor LSM count macros to use COUNT_ARGS
* Change CONFIG_SECURITY_HOOK_LIKELY likely's default value to be based on
  the LSM enabled and have it depend on CONFIG_EXPERT. There are a lot of subtle
  options behind CONFIG_EXPERT and this should, hopefully alleviate concerns
  about yet another knob.
* __randomize_layout for struct lsm_static_call and, in addition to the cover
  letter add performance numbers to 3rd patch and some minor commit message
  updates.
* Rebase to linux-next.

# v2 -> v3

* Fixed a build issue on archs which don't have static calls and enable
  CONFIG_SECURITY.
* Updated the LSM_COUNT macros based on Andrii's suggestions.
* Changed the security_ prefix to lsm_prefix based on Casey's suggestion.
* Inlined static_branch_maybe into lsm_for_each_hook on Kees' feedback.

# v1 -> v2 (based on linux-next, next-20230614)

* Incorporated suggestions from Kees
* Changed the way MAX_LSMs are counted from a binary based generator to a clever header.
* Add CONFIG_SECURITY_HOOK_LIKELY to configure the likelihood of LSM hooks.


KP Singh (5):
  kernel: Add helper macros for loop unrolling
  security: Count the LSMs enabled at compile time
  security: Replace indirect LSM hook calls with static calls
  bpf: Only enable BPF LSM hooks when an LSM program is attached
  security: Add CONFIG_SECURITY_HOOK_LIKELY

 include/linux/bpf_lsm.h   |   5 +
 include/linux/lsm_count.h | 114 +++++++++++++++++++++
 include/linux/lsm_hooks.h |  81 +++++++++++++--
 include/linux/unroll.h    |  36 +++++++
 kernel/bpf/trampoline.c   |  24 +++++
 security/Kconfig          |  11 ++
 security/bpf/hooks.c      |  25 ++++-
 security/security.c       | 209 +++++++++++++++++++++++++-------------
 8 files changed, 425 insertions(+), 80 deletions(-)
 create mode 100644 include/linux/lsm_count.h
 create mode 100644 include/linux/unroll.h

-- 
2.42.0.869.gea05f2083d-goog


