Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AED60D3D7
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiJYSqL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiJYSpq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:45:46 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1581859EB0
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:45:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666723536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MSyYKq0oMDs/qBI1ZFGx2eHgiellBURTxIk3cffSSPU=;
        b=tP/6GAuHEzE4evZAy6rg5XmQ5d7AjN+4Idm7YWGWF1kHdSOPUyfastRcZ/iW3EmQ6PI3Et
        bnIt+MtLiAXG7FOMwntVCX3k6VwGgioIfl06+87b5fJtl3JGd6BIEX1FJbxUec9oyMxF7W
        ovWSRU5/2lFpzP+g/DsFRx/naQaYbO4=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        'Song Liu ' <songliubraving@meta.com>, kernel-team@meta.com
Subject: [PATCH bpf-next 0/9] bpf: Avoid unnecessary deadlock detection and failure in task storage
Date:   Tue, 25 Oct 2022 11:45:15 -0700
Message-Id: <20221025184524.3526117-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

The commit bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")
added deadlock detection to avoid a tracing program from recurring
on the bpf_task_storage_{get,delete}() helpers.  These helpers acquire
a spin lock and it will lead to deadlock.

It is unnecessary for the bpf_lsm and bpf_iter programs which do
not recur.  The situation is the same as the existing
bpf_pid_task_storage_{lookup,delete}_elem() which are
used in the syscall and they also do not have deadlock detection.

This set is to add new bpf_task_storage_{get,delete}() helper proto
without the deadlock detection.  The set also removes the prog->active
check from the bpf_lsm and bpf_iter program.  Please see the individual
patch for details.

Martin KaFai Lau (9):
  bpf: Remove prog->active check for bpf_lsm and bpf_iter
  bpf: Append _recur naming to the bpf_task_storage helper proto
  bpf: Refactor the core bpf_task_storage_get logic into a new function
  bpf: Avoid taking spinlock in bpf_task_storage_get if potential
    deadlock is detected
  bpf: Add new bpf_task_storage_get proto with no deadlock detection
  bpf: bpf_task_storage_delete_recur does lookup first before the
    deadlock check
  bpf: Add new bpf_task_storage_delete proto with no deadlock detection
  selftests/bpf: Ensure no task storage failure for bpf_lsm.s prog due
    to deadlock detection
  selftests/bpf: Tracing prog can still do lookup under busy lock

 arch/arm64/net/bpf_jit_comp.c                 |   9 +-
 arch/x86/net/bpf_jit_comp.c                   |  19 +--
 include/linux/bpf.h                           |  26 ++--
 include/linux/bpf_verifier.h                  |  15 +-
 kernel/bpf/bpf_local_storage.c                |   1 +
 kernel/bpf/bpf_task_storage.c                 | 119 +++++++++++---
 kernel/bpf/syscall.c                          |   5 +-
 kernel/bpf/trampoline.c                       |  80 ++++++++--
 kernel/trace/bpf_trace.c                      |   5 +
 .../bpf/prog_tests/task_local_storage.c       | 146 +++++++++++++++++-
 .../selftests/bpf/progs/task_ls_recursion.c   |  43 +++++-
 .../bpf/progs/task_storage_nodeadlock.c       |  47 ++++++
 12 files changed, 431 insertions(+), 84 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c

-- 
2.30.2

