Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 721E0146C93
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 16:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAWPY4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 10:24:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37761 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgAWPY4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:24:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so1545540pga.4
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/5KMi+sNCAgo7zXwagBMYnJV1f6hcxVwZ21U5z4bX14=;
        b=YUgGvz2Rw2MF/+dx7fPF6FuLCXyaIanu7kMuwPOLJOpQAD9QV7hPK3fXG0NJm7jkZQ
         Q272SYnlagUi3Cf+DFK1VEqE/b1DDlbrVm1GQLBqSoc9HLB1++ckckYc9h4LY3geCNGd
         ZmOdT9MrmoR74PyGc9jNwArtq7YIW7/3FBvpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/5KMi+sNCAgo7zXwagBMYnJV1f6hcxVwZ21U5z4bX14=;
        b=oHWE1m7gBLzdX7/ylwJUarxfGxEzXCDirjQq+6uNpP7MtM3N/r8O754X1QSa54hUBN
         rgTprL/rDGFxxX4BoAp5k7voy2vpvcVmTwfb7uDn6d+cCkGpT2ow3tudhyxX4lKD6kxK
         gBQ9QuS1+ttvmCsUVy84JZh1lEJ2pGU0hZ18tOr57RE8HJ9IFOpDJAUl+G8GBrPdE6Ot
         ZoWQOTXjDBqpOGNDd07NQ3KUkhV7dIw5KfjxOec6nRFxGq2gdC0CKVydTcE27Ddkw+V1
         aQrSGhVEEafcIBAWAqHsjaBc1TM6g00kCtsukPyOVWUhHUFj+dWBEvlynCyQjaf8EQAV
         YTFA==
X-Gm-Message-State: APjAAAVP2S1Naf56uYiPj1eZ0gJqIVdvHRflTPZCUyAYT4TkvdUrUn6K
        JY9/UgzwzFH1XWFKJCaSWQeu8Q==
X-Google-Smtp-Source: APXvYqwvQCTgBrTFthFd/fDobF215aivw+9jna6cY+f8MGy8Bha2faYSTUHyKXiBAA0JIdIhp5soiA==
X-Received: by 2002:a65:484d:: with SMTP id i13mr4593036pgs.32.1579793095390;
        Thu, 23 Jan 2020 07:24:55 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id v5sm3108118pfn.122.2020.01.23.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:24:54 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v3 00/10]  MAC and Audit policy using eBPF (KRSI)
Date:   Thu, 23 Jan 2020 07:24:30 -0800
Message-Id: <20200123152440.28956-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

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

# Changes since v1 (https://lore.kernel.org/bpf/20191220154208.15895-1-kpsingh@chromium.org/):

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

This patchset proposes a new stackable and privileged LSM which allows
the LSM hooks to be implemented using eBPF. This facilitates a unified
and dynamic (not requiring re-compilation of the kernel) audit and MAC
policy.

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

The LSM introduces a new eBPF (https://docs.cilium.io/en/v1.6/bpf/)
program type BPF_PROG_TYPE_LSM which can only be attached to LSM hooks.
Attachment requires CAP_SYS_ADMIN for loading eBPF programs and
CAP_MAC_ADMIN for modifying MAC policies.

The eBPF programs are attached to a separate security_hook_heads
maintained by the BPF LSM for mutable hooks and executed after all the
statically defined hooks (i.e. the ones declared by SELinux, AppArmor,
Smack etc). This also ensures that statically defined LSM hooks retain
the behaviour of "being read-only after init", i.e. __lsm_ro_after_init.

Upon attachment, a security hook is dynamically allocated with
arch_bpf_prepare_trampoline which generates code to handle the
conversion from the signature of the hook to the BPF context and allows
the JIT'ed BPF program to be called as a C function with the same
arguments as the LSM hooks. If any of the attached eBPF programs returns
an error (like ENOPERM), the behaviour represented by the hook is
denied.

Audit logs can be written using a format chosen by the eBPF program to
the perf events buffer or to global eBPF variables or maps and can be
further processed in user-space.

# BTF Based Design

The current design uses BTF
(https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhancement.html,
https://lwn.net/Articles/803258/) which allows verifiable read-only
structure accesses by field names rather than fixed offsets. This allows
accessing the hook parameters using a dynamically created context which
provides a certain degree of ABI stability:


// Only declare the structure and fields intended to be used
// in the program
struct vm_area_struct {
  unsigned long vm_start;
} __attribute__((preserve_access_index));

// Declare the eBPF program mprotect_audit which attaches to
// to the file_mprotect LSM hook and accepts three arguments.
SEC("lsm/file_mprotect")
int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
       unsigned long reqprot, unsigned long prot)
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
renames, #defines and changes to the signature of LSM hooks).

This design imposes that the MAC policy (eBPF programs) be updated when
the inspected kernel structures change outside of BTF compatibility
guarantees. In practice, this is only required when a structure field
used by a current policy is removed (or renamed) or when the used LSM
hooks change. We expect the maintenance cost of these changes to be
acceptable as compared to the previous design
(https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/).

# Why not tracepoints or kprobes?

In order to do MAC with tracepoints or kprobes, we would need to
override the return value of the security hook. This is not possible
with tracepoints or call-site kprobes.

Attaching to the return boundary (kretprobe) implies that BPF programs
would always get called after all the other LSM hooks are called and
clobber the pre-existing LSM semantics.

Enforcing MAC policy with an actual LSM helps leverage the verified
semantics of the framework.

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

KP Singh (10):
  bpf: btf: Add btf_type_by_name_kind
  bpf: lsm: Add a skeleton and config options
  bpf: lsm: Introduce types for eBPF based LSM
  bpf: lsm: Add mutable hooks list for the BPF LSM
  bpf: lsm: BTF API for LSM hooks
  bpf: lsm: Implement attach, detach and execution
  bpf: lsm: Make the allocated callback RO+X
  tools/libbpf: Add support for BPF_PROG_TYPE_LSM
  bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
  bpf: lsm: Add Documentation

 Documentation/security/bpf.rst                | 165 +++++++++
 Documentation/security/index.rst              |   1 +
 MAINTAINERS                                   |  11 +
 include/linux/bpf.h                           |   4 +
 include/linux/bpf_lsm.h                       |  99 ++++++
 include/linux/bpf_types.h                     |   4 +
 include/linux/btf.h                           |   3 +
 include/linux/lsm_hooks.h                     |   1 +
 include/uapi/linux/bpf.h                      |   6 +
 kernel/bpf/btf.c                              |  13 +
 kernel/bpf/syscall.c                          |  51 ++-
 kernel/bpf/verifier.c                         |  74 +++-
 security/Kconfig                              |  11 +-
 security/Makefile                             |   2 +
 security/bpf/Kconfig                          |  25 ++
 security/bpf/Makefile                         |   7 +
 security/bpf/hooks.c                          | 315 ++++++++++++++++++
 security/bpf/include/bpf_lsm.h                |  70 ++++
 security/bpf/lsm.c                            |  87 +++++
 security/bpf/ops.c                            |  30 ++
 security/security.c                           |  30 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 tools/lib/bpf/bpf.c                           |   6 +-
 tools/lib/bpf/bpf.h                           |   1 +
 tools/lib/bpf/libbpf.c                        | 104 +++++-
 tools/lib/bpf/libbpf.h                        |   4 +
 tools/lib/bpf/libbpf.map                      |   3 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/testing/selftests/bpf/lsm_helpers.h     |  19 ++
 .../bpf/prog_tests/lsm_mprotect_audit.c       |  58 ++++
 .../selftests/bpf/progs/lsm_mprotect_audit.c  |  48 +++
 31 files changed, 1229 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/security/bpf.rst
 create mode 100644 include/linux/bpf_lsm.h
 create mode 100644 security/bpf/Kconfig
 create mode 100644 security/bpf/Makefile
 create mode 100644 security/bpf/hooks.c
 create mode 100644 security/bpf/include/bpf_lsm.h
 create mode 100644 security/bpf/lsm.c
 create mode 100644 security/bpf/ops.c
 create mode 100644 tools/testing/selftests/bpf/lsm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c

-- 
2.20.1

