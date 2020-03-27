Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C50195EC6
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 20:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgC0T3e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 15:29:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39317 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgC0T3C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 15:29:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so12849493wrt.6
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hD9MOsC3BEoml8ycU6+9aIkBQRhuAgalSch2pvrHqTw=;
        b=alDx2R0JbD+QeXz5fVHOPgHk5RbuQRdH0GR3eS3zGy/8IlTZkpVdLYwnsO94HMCg4d
         PXpWaUT/TIxGb2zAQ5D0CPD8cH+51TWtq0vfKOHVok/aXe9Qx+2tYatzZw4oH4+q8awF
         Tdl8uewUaXP8nNC6edxyzw+YhCoaZxa2FX2v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hD9MOsC3BEoml8ycU6+9aIkBQRhuAgalSch2pvrHqTw=;
        b=FZe+luYfZOID9svj6h5eS9/3nYBO0aumfcSWlaQxj1NOhF0jrfRKFWDp79tyaQW3Oj
         bT3N61uCL6ReLts1s5AgnAbRyaGd2iyl8KReBv+3bxfU3jdtpfI9upbyMgA+0YJxUXlx
         PVlrDsykjetjW6B63QAzZiZJMHVarC5zNyxJHN/fi4d4k3wlFMMQx9MtnTVi2JnSWKWC
         SmJZablKP2kKND4L/ZbrqvchDIIW9C16y00Sh7xf+t8HUrEtz0qszQA9MQDy6O6C0gIZ
         o0EwhDm1eCcM9jqcW0PGCOgTE2KBSeskPPByuMqvKJ3CE/qyeem6mXUaQdmFCYbVLI3K
         kN+g==
X-Gm-Message-State: ANhLgQ3ioxotergsd9iiEonK1vgzw+KyxJJoUzaKbM2n1iChCzBXIdGl
        Cn7Gm/FOhaKF4Wx6wNNADw146w==
X-Google-Smtp-Source: ADFU+vtDglT6q9bA8Howi3jDzqebisHTDMgtaWHuvaAMY2T0f0DwddY/UljbOLlYvAnV6q7DGN/hIw==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr976158wrl.397.1585337337318;
        Fri, 27 Mar 2020 12:28:57 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id h132sm9828537wmf.18.2020.03.27.12.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:28:56 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v8 0/8] MAC and Audit policy using eBPF (KRSI)
Date:   Fri, 27 Mar 2020 20:28:46 +0100
Message-Id: <20200327192854.31150-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v7 -> v8

  https://lore.kernel.org/bpf/20200326142823.26277-1-kpsingh@chromium.org/

* Removed CAP_MAC_ADMIN check from bpf_lsm_verify_prog. LSMs can add it
  in their own bpf_prog hook. This can be revisited as a separate patch.
* Added Andrii and James' Ack/Review tags.
* Fixed an indentation issue and missing newlines in selftest error
  a cases.
* Updated a comment as suggested by Alexei.
* Updated the documentation to use the newer libbpf API and some other
  fixes.
* Rebase

# v6 -> v7

  https://lore.kernel.org/bpf/20200325152629.6904-1-kpsingh@chromium.org/

* Removed __weak from the LSM attachment nops per Kees' suggestion.
  Will send a separate patch (if needed) to update the noinline
  definition in include/linux/compiler_attributes.h.
* waitpid to wait specifically for the forked child in selftests.
* Comment format fixes in security/... as suggested by Casey.
* Added Acks from Kees and Andrii and Casey's Reviewed-by: tags to
  the respective patches.
* Rebase

# v5 -> v6

  https://lore.kernel.org/bpf/20200323164415.12943-1-kpsingh@chromium.org/

* Updated LSM_HOOK macro to define a default value and cleaned up the
  BPF LSM hook declarations.
* Added Yonghong's Acks and Kees' Reviewed-by tags.
* Simplification of the selftest code.
* Rebase and fixes suggested by Andrii and Yonghong and some other minor
  fixes noticed in internal review.

# v4 -> v5

  https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/

* Removed static keys and special casing of BPF calls from the LSM
  framework.
* Initialized the BPF callbacks (nops) as proper LSM hooks.
* Updated to using the newly introduced BPF_TRAMP_MODIFY_RETURN
  trampolines in https://lkml.org/lkml/2020/3/4/877
* Addressed Andrii's feedback and rebased.

# v3 -> v4

* Moved away from allocating a separate security_hook_heads and adding a
  new special case for arch_prepare_bpf_trampoline to using BPF fexit
  trampolines called from the right place in the LSM hook and toggled by
  static keys based on the discussion in:

  https://lore.kernel.org/bpf/CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com/

* Since the code does not deal with security_hook_heads anymore, it goes
  from "being a BPF LSM" to "BPF program attachment to LSM hooks".
* Added a new test case which ensures that the BPF programs' return value
  is reflected by the LSM hook.

# v2 -> v3 does not change the overall design and has some minor fixes:

* LSM_ORDER_LAST is introduced to represent the behaviour of the BPF LSM
* Fixed the inadvertent clobbering of the LSM Hook error codes
* Added GPL license requirement to the commit log
* The lsm_hook_idx is now the more conventional 0-based index
* Some changes were split into a separate patch ("Load btf_vmlinux only
  once per object")

  https://lore.kernel.org/bpf/20200117212825.11755-1-kpsingh@chromium.org/

* Addressed Andrii's feedback on the BTF implementation
* Documentation update for using generated vmlinux.h to simplify
  programs
* Rebase

# Changes since v1

  https://lore.kernel.org/bpf/20191220154208.15895-1-kpsingh@chromium.org

* Eliminate the requirement to maintain LSM hooks separately in
  security/bpf/hooks.h Use BPF trampolines to dynamically allocate
  security hooks
* Drop the use of securityfs as bpftool provides the required
  introspection capabilities.  Update the tests to use the bpf_skeleton
  and global variables
* Use O_CLOEXEC anonymous fds to represent BPF attachment in line with
  the other BPF programs with the possibility to use bpf program pinning
  in the future to provide "permanent attachment".
* Drop the logic based on prog names for handling re-attachment.
* Drop bpf_lsm_event_output from this series and send it as a separate
  patch.

# Motivation

Google does analysis of rich runtime security data to detect and thwart
threats in real-time. Currently, this is done in custom kernel modules
but we would like to replace this with something that's upstream and
useful to others.

The current kernel infrastructure for providing telemetry (Audit, Perf
etc.) is disjoint from access enforcement (i.e. LSMs).  Augmenting the
information provided by audit requires kernel changes to audit, its
policy language and user-space components. Furthermore, building a MAC
policy based on the newly added telemetry data requires changes to
various LSMs and their respective policy languages.

This patchset allows BPF programs to be attached to LSM hooks This
facilitates a unified and dynamic (not requiring re-compilation of the
kernel) audit and MAC policy.

# Why an LSM?

Linux Security Modules target security behaviours rather than the
kernel's API. For example, it's easy to miss out a newly added system
call for executing processes (eg. execve, execveat etc.) but the LSM
framework ensures that all process executions trigger the relevant hooks
irrespective of how the process was executed.

Allowing users to implement LSM hooks at runtime also benefits the LSM
eco-system by enabling a quick feedback loop from the security community
about the kind of behaviours that the LSM Framework should be targeting.

# How does it work?

The patchset introduces a new eBPF (https://docs.cilium.io/en/v1.6/bpf/)
program type BPF_PROG_TYPE_LSM which can only be attached to LSM hooks.
Loading and attachment of BPF programs requires CAP_SYS_ADMIN.

The new LSM registers nop functions (bpf_lsm_<hook_name>) as LSM hook
callbacks. Their purpose is to provide a definite point where BPF
programs can be attached as BPF_TRAMP_MODIFY_RETURN trampoline programs
for hooks that return an int, and BPF_TRAMP_FEXIT trampoline programs
for void LSM hooks.

Audit logs can be written using a format chosen by the eBPF program to
the perf events buffer or to global eBPF variables or maps and can be
further processed in user-space.

# BTF Based Design

The current design uses BTF:

  * https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhancement.html
  * https://lwn.net/Articles/803258

which allows verifiable read-only structure accesses by field names
rather than fixed offsets. This allows accessing the hook parameters
using a dynamically created context which provides a certain degree of
ABI stability:


// Only declare the structure and fields intended to be used
// in the program
struct vm_area_struct {
  unsigned long vm_start;
} __attribute__((preserve_access_index));

// Declare the eBPF program mprotect_audit which attaches to
// to the file_mprotect LSM hook and accepts three arguments.
SEC("lsm/file_mprotect")
int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
       unsigned long reqprot, unsigned long prot, int ret)
{
  unsigned long vm_start = vma->vm_start;

  return 0;
}

By relocating field offsets, BTF makes a large portion of kernel data
structures readily accessible across kernel versions without requiring a
large corpus of BPF helper functions and requiring recompilation with
every kernel version. The BTF type information is also used by the BPF
verifier to validate memory accesses within the BPF program and also
prevents arbitrary writes to the kernel memory.

The limitations of BTF compatibility are described in BPF Co-Re
(http://vger.kernel.org/bpfconf2019_talks/bpf-core.pdf, i.e. field
renames, #defines and changes to the signature of LSM hooks).  This
design imposes that the MAC policy (eBPF programs) be updated when the
inspected kernel structures change outside of BTF compatibility
guarantees. In practice, this is only required when a structure field
used by a current policy is removed (or renamed) or when the used LSM
hooks change. We expect the maintenance cost of these changes to be
acceptable as compared to the design presented in the RFC.

(https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/).

# Usage Examples

A simple example and some documentation is included in the patchset.
In order to better illustrate the capabilities of the framework some
more advanced prototype (not-ready for review) code has also been
published separately:

* Logging execution events (including environment variables and
  arguments)
  https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c

* Detecting deletion of running executables:
  https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c

* Detection of writes to /proc/<pid>/mem:
  https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c

We have updated Google's internal telemetry infrastructure and have
started deploying this LSM on our Linux Workstations. This gives us more
confidence in the real-world applications of such a system.

KP Singh (8):
  bpf: Introduce BPF_PROG_TYPE_LSM
  security: Refactor declaration of LSM hooks
  bpf: lsm: provide attachment points for BPF LSM programs
  bpf: lsm: Implement attach, detach and execution
  bpf: lsm: Initialize the BPF LSM hooks
  tools/libbpf: Add support for BPF_PROG_TYPE_LSM
  bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
  bpf: lsm: Add Documentation

 Documentation/bpf/bpf_lsm.rst                 | 146 ++++
 Documentation/bpf/index.rst                   |   1 +
 MAINTAINERS                                   |   1 +
 include/linux/bpf.h                           |   3 +
 include/linux/bpf_lsm.h                       |  33 +
 include/linux/bpf_types.h                     |   4 +
 include/linux/lsm_hook_defs.h                 | 381 +++++++++++
 include/linux/lsm_hooks.h                     | 628 +-----------------
 include/uapi/linux/bpf.h                      |   2 +
 init/Kconfig                                  |  12 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/bpf_lsm.c                          |  59 ++
 kernel/bpf/btf.c                              |   9 +-
 kernel/bpf/syscall.c                          |  57 +-
 kernel/bpf/trampoline.c                       |  17 +-
 kernel/bpf/verifier.c                         |  19 +-
 kernel/trace/bpf_trace.c                      |  12 +-
 security/Kconfig                              |  10 +-
 security/Makefile                             |   2 +
 security/bpf/Makefile                         |   5 +
 security/bpf/hooks.c                          |  26 +
 security/security.c                           |  41 +-
 tools/include/uapi/linux/bpf.h                |   2 +
 tools/lib/bpf/bpf.c                           |   3 +-
 tools/lib/bpf/libbpf.c                        |  39 +-
 tools/lib/bpf/libbpf.h                        |   4 +
 tools/lib/bpf/libbpf.map                      |   3 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/test_lsm.c       |  86 +++
 tools/testing/selftests/bpf/progs/lsm.c       |  48 ++
 31 files changed, 987 insertions(+), 670 deletions(-)
 create mode 100644 Documentation/bpf/bpf_lsm.rst
 create mode 100644 include/linux/bpf_lsm.h
 create mode 100644 include/linux/lsm_hook_defs.h
 create mode 100644 kernel/bpf/bpf_lsm.c
 create mode 100644 security/bpf/Makefile
 create mode 100644 security/bpf/hooks.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm.c

-- 
2.20.1

