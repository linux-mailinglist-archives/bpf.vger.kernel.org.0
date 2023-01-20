Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32A9674C4D
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjATF24 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjATF23 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:28:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF5930E0;
        Thu, 19 Jan 2023 21:23:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDE02B8229F;
        Fri, 20 Jan 2023 00:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49799C433EF;
        Fri, 20 Jan 2023 00:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674173309;
        bh=3KzjNLNPNLSIodWpCueB2WhRu6smQFH2gkFhC5biMYc=;
        h=From:To:Cc:Subject:Date:From;
        b=RSfl6Q9tDytFkXobVl4OA/1Ff1T9CF13+Ki50UlIzp77vhoHMu3itDxiA6m66qu4+
         YCoHiO7gRFl7dqWNLuOePxhnPFwNJfEaJaoZQsRNh6OHSbSI3dyPhfcMhWDRuX5sCh
         IL1IlQrT2ylc2j5LxoxL0LohI1Y9qW3WFxDv3Efksh+mK/UjVD3e/WCUnfuJ3ICHZt
         5N5EpNMTghU7PW39WUTHs1MuGOuzDaDDrjvCL97I60eC3q54HzFImdOKQ5whaXkV40
         mEfjGLQ2QbXOHSQp4w0nT3oThZUmicloHIa5oC6eWZEJksXUCU3NafU77E/WMtIWKH
         Fx+9sOo5AWSUw==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        song@kernel.org, revest@chromium.org, keescook@chromium.org
Subject: [PATCH RESEND bpf-next 0/4] Reduce overhead of LSMs with static calls
Date:   Fri, 20 Jan 2023 01:08:14 +0100
Message-Id: <20230120000818.1324170-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
benefitted at an average of ~3%. Here are the results of the relevant Unixbench
system benchmarks with BPF LSM and a major LSM (in this case apparmor) enabled
with and without the series.

Benchmark                                               Delta(%): (+ is better)
===============================================================================
Execl Throughput                                             +2.9015
File Write 1024 bufsize 2000 maxblocks                       +5.4196
Pipe Throughput                                              +7.7434
Pipe-based Context Switching                                 +3.5118
Process Creation                                             +0.3552
Shell Scripts (1 concurrent)                                 +1.7106
System Call Overhead                                         +3.0067
System Benchmarks Index Score (Partial Only):                +3.1809

In the best case, some syscalls like eventfd_create benefitted to about ~10%.
The full analysis can be viewed at https://kpsingh.ch/lsm-perf

[1] https://lore.kernel.org/linux-security-module/20200820164753.3256899-1-jackmanb@chromium.org/

KP Singh (4):
  kernel: Add helper macros for loop unrolling
  security: Generate a header with the count of enabled LSMs
  security: Replace indirect LSM hook calls with static calls
  bpf: Only enable BPF LSM hooks when an LSM program is attached

 include/linux/bpf.h              |   1 +
 include/linux/bpf_lsm.h          |   1 +
 include/linux/lsm_hooks.h        |  94 +++++++++++--
 include/linux/unroll.h           |  35 +++++
 kernel/bpf/trampoline.c          |  29 ++++-
 scripts/Makefile                 |   1 +
 scripts/security/.gitignore      |   1 +
 scripts/security/Makefile        |   4 +
 scripts/security/gen_lsm_count.c |  57 ++++++++
 security/Makefile                |  11 ++
 security/bpf/hooks.c             |  26 +++-
 security/security.c              | 217 ++++++++++++++++++++-----------
 12 files changed, 386 insertions(+), 91 deletions(-)
 create mode 100644 include/linux/unroll.h
 create mode 100644 scripts/security/.gitignore
 create mode 100644 scripts/security/Makefile
 create mode 100644 scripts/security/gen_lsm_count.c

-- 
2.39.0.246.g2a6d74b583-goog

