Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96316656E
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 18:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBTRxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 12:53:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37149 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgBTRw6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 12:52:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so3027699wme.2
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AX9sVXYSyo+q1qOkt8FULjn7gyqcFkCzhWtuEbC6zIQ=;
        b=Cjb//L1TT+kFCDPYngm1odF8rKCR1vAUKCOBnlpW5ZeuODER6B1Jc19paVX1ql6atu
         51Jv7KlBe2jcxyiD8vj8xDiGhnh88TduIqF375a/Ff6OAcruboGJGRf1GugSJUmeA7Pi
         HO+JSPCXKlLEGg206kMgFbL8QONrPUZd2pHaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AX9sVXYSyo+q1qOkt8FULjn7gyqcFkCzhWtuEbC6zIQ=;
        b=SaQGOIRmfGgs7noHO+/Ym4MUrTKexywLyY0bif/oh7ji71BYC2GS4Tn472/6yruT6B
         wgewlwAHOiMsKfSrGLHIqKqLfhqoaIKQgJzCZWAm4TTzwO6RujtsMlTEg4xFSrg51CVU
         bBqu2kIj20WJShZjoKGR8wHX03Gx1EPsZTN2+nnirxK1HSvSkt4TvKCRX7wm+3WUnwov
         aGzjdyftVQRTbUYz3na6pjMQEGjcxT/RhCxaoquqrSlnAyF2JqQir2ORiBkaFEMIhj9A
         BrQer16IPUhTCoQfWW7PKiUPIaKa9aWW0KxCGDjFrgASUJ5olgmngCiUh4Z2BPsAgZe9
         NenA==
X-Gm-Message-State: APjAAAVSSlvdCZMiudiZW66BiTwzAyBwrOB0opTIj/sigSeMhlADG3+m
        Qs8B0bV86BI3MM/okGmfvq7+5g==
X-Google-Smtp-Source: APXvYqz0omDok3dSDam2AxHkpOU3DFNsEAan/TpkPSjreO/ziNPj225T/H0UAiprN9hV8iyYa3RrWQ==
X-Received: by 2002:a05:600c:1009:: with SMTP id c9mr5608558wmc.162.1582221173942;
        Thu, 20 Feb 2020 09:52:53 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:d960:542a:a1d:648a])
        by smtp.gmail.com with ESMTPSA id r5sm363059wrt.43.2020.02.20.09.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:52:53 -0800 (PST)
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
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v4 0/8] MAC and Audit policy using eBPF (KRSI)
Date:   Thu, 20 Feb 2020 18:52:42 +0100
Message-Id: <20200220175250.10795-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v3 -> v4

  https://lkml.org/lkml/2020/1/23/515

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

  https://lkml.org/lkml/2020/1/15/843

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

# Changes since v1:

  https://lkml.org/lkml/2019/12/20/641

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
Attachment requires CAP_SYS_ADMIN for loading eBPF programs and
CAP_MAC_ADMIN for modifying MAC policies.

The eBPF programs are attached to nop functions (bpf_lsm_<name>) added
in the LSM hooks (when CONFIG_BPF_LSM) and executed after all the
statically defined hooks (i.e. the ones declared by static LSMs (eg,
SELinux, AppArmor, Smack etc) allow the action. This also ensures that
statically defined LSM hooks retain the behaviour of "being read-only
after init", i.e. __lsm_ro_after_init and do not increase the attack
surface.

The branch into this nop function is guarded with a static key (jump
label) and is only taken when a BPF program is attached to the LSM hook.

eg. for bprm_check_security:

int bpf_lsm_bprm_check_security(struct linux_binprm *bprm)
{
        return 0;
}

DEFINE_STATIC_KEY_FALSE(bpf_lsm_key_bprm_check_security)

// Run all static hooks for bprm_check_security and set RC
if (static_key_unlikely(&bpf_lsm_key_bprm_check_security) {
        if (RC == 0)
                bpf_lsm_bprm_check_security(bprm);
}

Upon attachment, a BPF fexit trampoline is attached to the nop function
and the static key for the LSM hook is enabled. The trampoline has code
to handle the conversion from the signature of the hook to the BPF
context and allows the JIT'ed BPF program to be called as a C function
with the same arguments as the LSM hooks. If the attached eBPF programs
returns an error (like ENOPERM), the behaviour represented by the hook
is denied.

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
  bpf: lsm: Add support for enabling/disabling BPF hooks
  bpf: lsm: Implement attach, detach and execution
  tools/libbpf: Add support for BPF_PROG_TYPE_LSM
  bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
  bpf: lsm: Add Documentation

 Documentation/bpf/bpf_lsm.rst                 | 147 +++++
 Documentation/bpf/index.rst                   |   1 +
 MAINTAINERS                                   |   1 +
 arch/x86/net/bpf_jit_comp.c                   |  21 +-
 include/linux/bpf.h                           |   7 +
 include/linux/bpf_lsm.h                       |  66 ++
 include/linux/bpf_types.h                     |   4 +
 include/linux/lsm_hook_names.h                | 353 ++++++++++
 include/linux/lsm_hooks.h                     | 622 +-----------------
 include/uapi/linux/bpf.h                      |   2 +
 init/Kconfig                                  |  11 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/bpf_lsm.c                          |  88 +++
 kernel/bpf/btf.c                              |   3 +-
 kernel/bpf/syscall.c                          |  47 +-
 kernel/bpf/trampoline.c                       |  24 +-
 kernel/bpf/verifier.c                         |  19 +-
 kernel/trace/bpf_trace.c                      |  12 +-
 security/security.c                           |  35 +
 tools/include/uapi/linux/bpf.h                |   2 +
 tools/lib/bpf/bpf.c                           |   3 +-
 tools/lib/bpf/libbpf.c                        |  46 +-
 tools/lib/bpf/libbpf.h                        |   4 +
 tools/lib/bpf/libbpf.map                      |   3 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/testing/selftests/bpf/lsm_helpers.h     |  19 +
 .../selftests/bpf/prog_tests/lsm_mprotect.c   |  96 +++
 .../selftests/bpf/progs/lsm_mprotect_audit.c  |  48 ++
 .../selftests/bpf/progs/lsm_mprotect_mac.c    |  53 ++
 29 files changed, 1085 insertions(+), 654 deletions(-)
 create mode 100644 Documentation/bpf/bpf_lsm.rst
 create mode 100644 include/linux/bpf_lsm.h
 create mode 100644 include/linux/lsm_hook_names.h
 create mode 100644 kernel/bpf/bpf_lsm.c
 create mode 100644 tools/testing/selftests/bpf/lsm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_mac.c

-- 
2.20.1

