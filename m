Return-Path: <bpf+bounces-37375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1F954DFE
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 17:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368631F26D38
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1101BDAAB;
	Fri, 16 Aug 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKBT6Mt6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012D1A76B2;
	Fri, 16 Aug 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822994; cv=none; b=NQEsMSSu2Ud1sMPojvH0AiBlmP4eMubDBuJ9ZQy2l4kErlbjXx6dxvwteqN2r/Co2yYQSh1ah8ueeE70poEE/Z8K1xenRQFjgLD5U3zyMBkjBy+RWA7thMiccfFjzP0YUjZBNdoZLnbPof5vSAVdwGois/oNOztq3i+QKihnkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822994; c=relaxed/simple;
	bh=928Iu6enDYdLOVWsNl5Ro0KLyIykHit2sBYHTjz3oRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdK795bhr6KvKCqy45QGdAp0naOSzus9f8mW4FSK1ifh+bLV3MkY6dVqiJrG4oLkIElu6iiYP0zVfpNkhGu9Ms7bsEhSGf0ypeE67TgyFaXGyLYnofLM4POHNUpZ5psW8uf0B0vFOLMh8c7MAiXreXZtd3fv9sjJSgOcyNGqyhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKBT6Mt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B96C32782;
	Fri, 16 Aug 2024 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723822993;
	bh=928Iu6enDYdLOVWsNl5Ro0KLyIykHit2sBYHTjz3oRE=;
	h=From:To:Cc:Subject:Date:From;
	b=NKBT6Mt64d1L5vsZs7krUmC/4ojMCMuDVhqnSwyyHKKpoOaJYgvXQKWNvnISJR3rP
	 qdQLAO0GQOTAjX8PJ8J3grsX3+hISOQVRuxvFv2c6Yn5L/+tYVKqXR6/m47pkEsOCH
	 N4yo3sl6L+J0wYvokqf0ltX6/0fR7vHEjTCc19pAGtkUKTruiujwBxvwkkGf3xWzhz
	 6UwjnHoBtAOO2gmw4iY+NpMYYn6TecrfMIrHiNR6b2CdBA96/5msAXGqkpRts1z/9m
	 0imm6a0hs2pIaFG77DpL40yZDeS+R+Y7PpZreuYWklupQtDsYrgzgt16fQ3UAPQ/PX
	 JMUzf8GtKDUsg==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	andrii@kernel.org,
	keescook@chromium.org,
	daniel@iogearbox.net,
	renauld@google.com,
	revest@chromium.org,
	song@kernel.org,
	linux@roeck-us.net
Subject: [PATCH v15 0/4] Reduce overhead of LSMs with static calls
Date: Fri, 16 Aug 2024 17:43:03 +0200
Message-ID: <20240816154307.3031838-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
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


More context in the excellent LWN article by Jonathan Corbet [2]

[1] https://lore.kernel.org/linux-security-module/20200820164753.3256899-1-jackmanb@chromium.org/
[2] https://lwn.net/Articles/979683/

# v14 to v15

* Fixed early LSM init wuth Patch 1
* Made the static call table aligned to u64 and added a comment as to why this
  is needed.

# v13 to v14

* Dropped Patch 5 based on the ongoing discussion in
  https://lore.kernel.org/linux-security-module/20240629084331.3807368-4-kpsingh@kernel.org/, BPF
  LSM will still have default callbacks enabled.
* Dropped Patch 4 as recommended by Paul, indirect calls will remain in some LSM hooks for now.
  https://lore.kernel.org/linux-security-module/20240629084331.3807368-5-kpsingh@kernel.org/
* Fixed minor nits in Patch 3

# v12 to v13

* Fixed the GCC note when struct randomization is enabled
* Added missing link to BPF LSM side effects discussion in the commit message

# v11 to v12

* Casey's feedback on readability of patch 4
* Tetsuo's catch on the bug in Patch 5
* Changed LSM_HOOK_TOGGLEABLE to LSM_HOOK_RUNTIME, the bikeshed is blue now.
* Also, as security_toggle_hook relies on iterating over a
  flat lsm_static_calls_table, I added the __packed attribute.

# v10 to v11

* bpf_lsm_toggle_hook to security_toggle_hook with LSM_HOOK_TOGGLEABLE
  limiting the hooks as the ones that can be toggled.

# v9 to v10

* Addressed Paul's comments for Patch 3. I did not remove the acks from this one
  as changes were minor.
* Moved BPF LSM specific hook toggling logic bpf_lsm_toggle_hook to s
  security_toggle_hook as a generic API. I removed the Ack's from this patch
  as it's worth another look.
* Refactored the non-standard hooks to use static calls.

# v8 to v9

Paul, I removed the 5th patch about CONFIG_SECURITY_HOOK_LIKELY and went through
all the feedback. I believe it all should be addressed now.
But, please let me know if I missed anything.

The patches are based on https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
(next branch as of 2024-02-07) and resolved a bunch of conflicts.

I also added Andrii's series ack to indidividual patches.

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


KP Singh (4):
  init/main.c: Initialize early LSMs after arch code, static keys and
    calls.
  kernel: Add helper macros for loop unrolling
  lsm: count the LSMs enabled at compile time
  lsm: replace indirect LSM hook calls with static calls

 include/linux/args.h      |   6 +-
 include/linux/lsm_count.h | 128 ++++++++++++++++++++++
 include/linux/lsm_hooks.h |  52 +++++++--
 include/linux/unroll.h    |  36 +++++++
 init/main.c               |   6 +-
 security/security.c       | 219 +++++++++++++++++++++++++++-----------
 6 files changed, 369 insertions(+), 78 deletions(-)
 create mode 100644 include/linux/lsm_count.h
 create mode 100644 include/linux/unroll.h

-- 
2.46.0.184.g6999bdac58-goog


