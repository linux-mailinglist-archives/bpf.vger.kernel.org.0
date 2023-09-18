Return-Path: <bpf+bounces-10329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F927A54F6
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 23:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD286281BCD
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D145928DA5;
	Mon, 18 Sep 2023 21:25:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A0450C7
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 21:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABDBC433C7;
	Mon, 18 Sep 2023 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695072313;
	bh=v7HrHk/auMBPUrO+Ktdp23Bxj9pNu96eMnMq/wlxdGU=;
	h=From:To:Cc:Subject:Date:From;
	b=ZoG2gMilxigu+rUgAM1cruo7UGM9cTU5qkMCuifSSJDpRcusYMXASNM6PORB4R/VL
	 +inaCMw/Tk42dLkmVdqem6iKsmVTogiRErc3isNgLreaW4NaPGRubBfAmw2oGO5mHQ
	 dPp8EHiI0G51HFrg6p8zzygkLizMptGNk7rBeG7tIZ0OKEFApI9qi0hKyiLmojRB0J
	 3aTTyLtsgKPulBbsIJBI6aw9CLXEV7oSpfSfQXrN3GCnZTu6Zl521Qk8BrehPNNREz
	 f4Seh5ieGSNRN3BMlPuuN1/2wygSElfzepWuG1Zjx5CJpEpOmgKf4y320jepyWGRFM
	 1Q5EIL4uRKbKQ==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	keescook@chromium.org,
	casey@schaufler-ca.com,
	song@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	kpsingh@kernel.org
Subject: [PATCH v3 0/5] Reduce overhead of LSMs with static calls
Date: Mon, 18 Sep 2023 23:24:54 +0200
Message-ID: <20230918212459.1937798-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
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

 include/linux/bpf.h       |   1 +
 include/linux/bpf_lsm.h   |   5 +
 include/linux/lsm_count.h | 106 +++++++++++++++++++
 include/linux/lsm_hooks.h |  81 +++++++++++++--
 include/linux/unroll.h    |  36 +++++++
 kernel/bpf/trampoline.c   |  29 +++++-
 security/Kconfig          |  11 ++
 security/bpf/hooks.c      |  25 ++++-
 security/security.c       | 213 +++++++++++++++++++++++++-------------
 9 files changed, 424 insertions(+), 83 deletions(-)
 create mode 100644 include/linux/lsm_count.h
 create mode 100644 include/linux/unroll.h

-- 
2.42.0.459.ge4e396fd5e-goog


