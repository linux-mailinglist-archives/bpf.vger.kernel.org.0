Return-Path: <bpf+bounces-21401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F53B84CADD
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 13:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D865EB21841
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203D77605B;
	Wed,  7 Feb 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw1oFMXD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873176055;
	Wed,  7 Feb 2024 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707310164; cv=none; b=pA7X7gHEkJc49cC74/O0UOViJTN8ctf6iOnAVYmJT9++8S6LVwYJCDDPsaQxSq69hFtYSnf6Z+if9t+AOmOLpPI1/091vwCDyGUSrZ62JHfL1nD6mQ0NssWihhxNAw7yTfOwTesIsUK7oGYlcSM/bN9EvjYj8XTv1SJDgIgRRe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707310164; c=relaxed/simple;
	bh=SdxDGI3p54cRrgwFZEdB935gwlZd0IXu/XtYT/38WEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWGGJdeL6JugIUjIYMwNzciJ/kBZvapT0w1HsDfMtfUp3HfbMd9xIy7jvpHgbDHSxMuXpVdmm8bQ2gAm3RUQdVrh6oYC8yw9RKycCwuoD0+hOY7pzBxH/Dn/G4RLeZU+kDQbdOCDmvHE6SlCnHdomqdDyRE0V/nZTeVbLAfrPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw1oFMXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6C3C433F1;
	Wed,  7 Feb 2024 12:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707310164;
	bh=SdxDGI3p54cRrgwFZEdB935gwlZd0IXu/XtYT/38WEg=;
	h=From:To:Cc:Subject:Date:From;
	b=Lw1oFMXDuulRTciClVOJTZnjwLZX6ou09/mOxaSz7VDRH3b2k36NDCmu2bJtwyWHN
	 L1joT3FW5CxyFhMSlQ7kNE+ePEHtJfQ7zYqrtKwmtqq03KCh0rxXnh7XJGBWozFR4X
	 rxO3wDWSfozFUxR/4wC6aTwWJxiCSwZAYUwbX0FpjTGICXTRddnbtcjAkANFqwrH1m
	 XsrjAXKpe3QPexEEDKAUU3x+KmoVXFlb+YvnLmC5b2QAWR+2ojs75JbFlQ9hsWgXBN
	 kxPkKYWPI6MpEwM24mXtNNK83fRb4PaJLyWL2ogpDNmFf4swcBVsf7XIuxVajaS833
	 PJzqt06PrHwig==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	keescook@chromium.org,
	casey@schaufler-ca.com,
	song@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	pabeni@redhat.com,
	andrii@kernel.org,
	kpsingh@kernel.org
Subject: [PATCH v9 0/4] Reduce overhead of LSMs with static calls
Date: Wed,  7 Feb 2024 13:49:14 +0100
Message-ID: <20240207124918.3498756-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
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
  kernel: Add helper macros for loop unrolling
  security: Count the LSMs enabled at compile time
  security: Replace indirect LSM hook calls with static calls
  bpf: Only enable BPF LSM hooks when an LSM program is attached

 include/linux/bpf_lsm.h   |   5 +
 include/linux/lsm_count.h | 114 ++++++++++++++++++
 include/linux/lsm_hooks.h |  81 +++++++++++--
 include/linux/unroll.h    |  36 ++++++
 kernel/bpf/trampoline.c   |  24 ++++
 security/bpf/hooks.c      |  25 +++-
 security/security.c       | 245 ++++++++++++++++++++++++--------------
 7 files changed, 431 insertions(+), 99 deletions(-)
 create mode 100644 include/linux/lsm_count.h
 create mode 100644 include/linux/unroll.h

-- 
2.43.0.594.gd9cf4e227d-goog


