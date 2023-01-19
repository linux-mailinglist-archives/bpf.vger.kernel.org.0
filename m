Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A346747AA
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 00:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjASX6r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 18:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjASX6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:44 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A00FA2597;
        Thu, 19 Jan 2023 15:58:34 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id jr19so1744085qtb.7;
        Thu, 19 Jan 2023 15:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhSKMP2yHsUoN/zBLwGaM1uaM3tp8od//0hsEDaGujQ=;
        b=s6OdQ5WDPIAR4vX18yKprqSCWwNbkZSWnF+/57A2UTln1fDPPSp2jL5Vb9TWgRyAL6
         m7AzgY3OACQflTOezYlHJ1Q8dRmkr5b3MQXolk22zYt1ZI7Iy7YRRvOV8NKXQlokqn4W
         KGoGMKUaC06fYsqo84md04+sxP2HxL5fCXrnv125Xqi8AKQSCybzI+kaUWoBTOEC7AaM
         mlDI2mBWa6ntzJD9+zgrkCfTWnYZpkfC93tFPHMNq+CAcUMMUKb0abKN6efdEp/mBIQ0
         hARPVeiBykIRO3fnjFtwnn9wkeErGk16eC54LFFzG0Gp6y5R7ah+/fobC29l4MJBcMck
         jEQg==
X-Gm-Message-State: AFqh2ko9YicpNxjqvgj/OhcDl080IYjrDF/dj/pxpu5PVth+5UuhyUCk
        STM0fjldehL1OFJAR/DwpflxYK/XYr3MDZe7
X-Google-Smtp-Source: AMrXdXs1PXckCi8O24A2BPNSuCLfKpTDilzjeeAePe+JH/zXNHy4VKF/zVh81D+PgaINHFzZJCv3EQ==
X-Received: by 2002:a05:622a:178d:b0:3b6:35cb:b946 with SMTP id s13-20020a05622a178d00b003b635cbb946mr23480628qtk.14.1674172712714;
        Thu, 19 Jan 2023 15:58:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id bm37-20020a05620a19a500b00704d8ad2e11sm8063824qkb.42.2023.01.19.15.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:32 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next 0/8] Enable cpumasks to be used as kptrs
Date:   Thu, 19 Jan 2023 17:58:25 -0600
Message-Id: <20230119235833.2948341-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

'struct cpumask' is a bitmap data structure in the kernel whose indices
reflect the CPUs on the system. Commonly, cpumasks are used to track
which CPUs a task is affinitized to, but they can also be used to e.g.
track which cores are associated with a scheduling domain, which cores
on a machine are idle, etc.

It would be useful to be able to query those cpumasks from BPF programs.
For example, when tracing percpu operations, it would be convenient to
have cpumask support if the tracing program wants to track which tasks
end up running on which CPUs in different time intervals, and to check
their cpumask distribution while doing so. Similarly, if we're tracking
NUMA allocations, CPU scheduling domain associations, etc, it would be
useful to be able to concretely compare decisions made by the kernel to
a task's cpumask.

So as to enable such use cases, this patch set proposes a set of kfuncs,
namespaced to bpf_cpumask_*, which allow BPF programs to make queries
against cpumasks, and to allocate and store them as kptrs.

In order to enable these kfuncs, this patch set adds two new
kfunc-related capabilities to the verifier:

1. Defining a mechanism that allows developers to specify which fields
   of a struct type should inherit their parent's trust. Specifically,
   we specify that the 'const cpumask_t *cpus_ptr' field will be
   considered trusted if the parent struct task_struct is trusted.

2. Allowing KF_TRUSTED_ARGS pointers to be walked to see if a BTF type
   is equivalent to what a kfunc requires. For example, the patch set
   defines the following type:

struct bpf_cpumask {
	cpumask_t cpumask;
	refcount_t usage;
};

  cpumask_t typedefs a struct cpumask, so if a BPF program has a trusted
  pointer to a struct bpf_cpumask, it would therefore be safe to pass
  that to a kfunc expecting a const struct cpumask *. Note that 

3. Updating the verifier to prevent NULL PTR_TO_MEM pointers to be
   passed to KF_TRUSTED_ARGS kfuncs. Without this, a kfunc may crash if
   it's given a pointer to what it thinks is a scalar struct, but in
   reality is an address. For example, a bitmap embedded in a cpumask_t.

Following these BPF verifier changes (and their associated selftest
additions), this patchset adds a set of cpumask kfuncs in
kernel/bpf/cpumask.c, and then tests and documents them.

Lastly, note that some of the kfuncs that were added would benefit from
additional verification logic. For example, any kfunc taking a CPU
argument that exceeds the number of CPUs on the system, etc. For now, we
silently check for and ignore these cases at runtime. When we have e.g.
per-argument kfunc flags, it might be helpful to add another KF_CPU-type
flag that specifies that the verifier should validate that it's a valid
CPU.

David Vernet (8):
  bpf: Enable annotating trusted nested pointers
  bpf: Allow trusted args to walk struct when checking BTF IDs
  bpf: Disallow NULL PTR_TO_MEM for trusted kfuncs
  bpf: Enable cpumasks to be queried and used as kptrs
  selftests/bpf: Add nested trust selftests suite
  selftests/bpf: Add selftest suite for cpumask kfuncs
  bpf/docs: Document cpumask kfuncs in a new file
  bpf/docs: Document how nested trusted fields may be defined

 Documentation/bpf/cpumasks.rst                | 353 +++++++++++++
 Documentation/bpf/index.rst                   |   1 +
 Documentation/bpf/kfuncs.rst                  |  26 +-
 include/linux/bpf.h                           |   4 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/btf.c                              |  64 ++-
 kernel/bpf/cpumask.c                          | 476 ++++++++++++++++++
 kernel/bpf/verifier.c                         |  67 ++-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   2 +
 .../selftests/bpf/prog_tests/cpumask.c        |  74 +++
 .../selftests/bpf/prog_tests/nested_trust.c   |  64 +++
 .../selftests/bpf/progs/cpumask_common.h      | 114 +++++
 .../selftests/bpf/progs/cpumask_failure.c     | 125 +++++
 .../selftests/bpf/progs/cpumask_success.c     | 426 ++++++++++++++++
 .../selftests/bpf/progs/nested_trust_common.h |  12 +
 .../bpf/progs/nested_trust_failure.c          |  33 ++
 .../bpf/progs/nested_trust_success.c          |  29 ++
 17 files changed, 1865 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/bpf/cpumasks.rst
 create mode 100644 kernel/bpf/cpumask.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/nested_trust.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_success.c

-- 
2.39.0

