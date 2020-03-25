Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2319310F
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 20:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYTZE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 15:25:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39417 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgCYTZD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 15:25:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id b22so1631344pgb.6
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kVuxo6g9r71k0zuZSOCSjJ50gzlcc0vuqbur0SEabis=;
        b=CTpWRJuTarAgR3ttd+9HkifncXceeSwLI4NSBD7Uy0W4sQ3byptZT5qXZANNwjtJi3
         rEhJwLfWUVU0USZ3+GgxED+Q4KOiUaoS3+bhFIc6R9bJEH9Va8PMRCow4dIzE+ToeC2I
         xqla0hx3NRFDknU3WpOb0pNT4eAxvyjW+BHtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kVuxo6g9r71k0zuZSOCSjJ50gzlcc0vuqbur0SEabis=;
        b=aXwfsoKfWAW0k5rTPin90gw4rm4bt5CBm3//2erlNmFI61LLnmPDED5RZK3+vmEEop
         vuIRV0+C+IOJxk2XFiqkwnbxZtE5gDacIgBRd9oSzJglfQuuh0N60N3LyjUiQQwRmwIM
         iNPyy6fOOAJxTipk70LOd6CmyFfsRmUxsdPWeyJIR6ZO9/8AyF3ORdWy3V9mPuIhZ0w9
         2NagGJWTuuvxPPTLmHpfL6xtbLhfyqxRAW6tjr0yUJRO0xwheE3ZvFlI8M9Y5DljPnpI
         Kx77xnem7nrNjP2sc2NCE4V2ROiwsUyFaa/qqYeNAxQtDhS6y9sXYPKloW4lmSrD8WZN
         zalA==
X-Gm-Message-State: ANhLgQ0lgh0+U15ilBDTUaZbsWGKLd6v8bs20dRECqoOnBOIqt9357IB
        pSIJdZSuRiSpOcVDQ+c86M1BWA==
X-Google-Smtp-Source: ADFU+vuly1NlnNxO9VbCRDykG3KZ1DUsMFiR9l2zDi3kbLRHcES2UZOTk4L3AHN/xyxZRd5/RDvR9A==
X-Received: by 2002:aa7:9f11:: with SMTP id g17mr5101599pfr.224.1585164301677;
        Wed, 25 Mar 2020 12:25:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z11sm18945622pfa.149.2020.03.25.12.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:25:00 -0700 (PDT)
Date:   Wed, 25 Mar 2020 12:24:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v6 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <202003251224.2C80636F0F@keescook>
References: <20200325152629.6904-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325152629.6904-1-kpsingh@chromium.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 25, 2020 at 04:26:21PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> # v5 -> v6
> 
>   https://lwn.net/Articles/815826/

Random question: why the switch to lwn.net from lore URLs? The lore
URLs have been suggested to be the canonical way to refer to kernel
development discussion threads.

-Kees

> 
> * Updated LSM_HOOK macro to define a default value and cleaned up the
>   BPF LSM hook declarations.
> * Added Yonghong's Acks and Kees' Reviewed-by tags.
> * Simplification of the selftest code.
> * Rebase and fixes suggested by Andrii and Yonghong and some other minor
>   fixes noticed in internal review.
> 
> # v4 -> v5
> 
>   https://lwn.net/Articles/813057/
> 
> * Removed static keys and special casing of BPF calls from the LSM
>   framework.
> * Initialized the BPF callbacks (nops) as proper LSM hooks.
> * Updated to using the newly introduced BPF_TRAMP_MODIFY_RETURN
>   trampolines in https://lkml.org/lkml/2020/3/4/877
> * Addressed Andrii's feedback and rebased.
> 
> # v3 -> v4
> 
> * Moved away from allocating a separate security_hook_heads and adding a
>   new special case for arch_prepare_bpf_trampoline to using BPF fexit
>   trampolines called from the right place in the LSM hook and toggled by
>   static keys based on the discussion in:
> 
>   https://lore.kernel.org/bpf/CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com/
> 
> * Since the code does not deal with security_hook_heads anymore, it goes
>   from "being a BPF LSM" to "BPF program attachment to LSM hooks".
> * Added a new test case which ensures that the BPF programs' return value
>   is reflected by the LSM hook.
> 
> # v2 -> v3 does not change the overall design and has some minor fixes:
> 
> * LSM_ORDER_LAST is introduced to represent the behaviour of the BPF LSM
> * Fixed the inadvertent clobbering of the LSM Hook error codes
> * Added GPL license requirement to the commit log
> * The lsm_hook_idx is now the more conventional 0-based index
> * Some changes were split into a separate patch ("Load btf_vmlinux only
>   once per object")
> 
>   https://lore.kernel.org/bpf/20200117212825.11755-1-kpsingh@chromium.org/
> 
> * Addressed Andrii's feedback on the BTF implementation
> * Documentation update for using generated vmlinux.h to simplify
>   programs
> * Rebase
> 
> # Changes since v1
> 
>   https://lore.kernel.org/bpf/20191220154208.15895-1-kpsingh@chromium.org
> 
> * Eliminate the requirement to maintain LSM hooks separately in
>   security/bpf/hooks.h Use BPF trampolines to dynamically allocate
>   security hooks
> * Drop the use of securityfs as bpftool provides the required
>   introspection capabilities.  Update the tests to use the bpf_skeleton
>   and global variables
> * Use O_CLOEXEC anonymous fds to represent BPF attachment in line with
>   the other BPF programs with the possibility to use bpf program pinning
>   in the future to provide "permanent attachment".
> * Drop the logic based on prog names for handling re-attachment.
> * Drop bpf_lsm_event_output from this series and send it as a separate
>   patch.
> 
> # Motivation
> 
> Google does analysis of rich runtime security data to detect and thwart
> threats in real-time. Currently, this is done in custom kernel modules
> but we would like to replace this with something that's upstream and
> useful to others.
> 
> The current kernel infrastructure for providing telemetry (Audit, Perf
> etc.) is disjoint from access enforcement (i.e. LSMs).  Augmenting the
> information provided by audit requires kernel changes to audit, its
> policy language and user-space components. Furthermore, building a MAC
> policy based on the newly added telemetry data requires changes to
> various LSMs and their respective policy languages.
> 
> This patchset allows BPF programs to be attached to LSM hooks This
> facilitates a unified and dynamic (not requiring re-compilation of the
> kernel) audit and MAC policy.
> 
> # Why an LSM?
> 
> Linux Security Modules target security behaviours rather than the
> kernel's API. For example, it's easy to miss out a newly added system
> call for executing processes (eg. execve, execveat etc.) but the LSM
> framework ensures that all process executions trigger the relevant hooks
> irrespective of how the process was executed.
> 
> Allowing users to implement LSM hooks at runtime also benefits the LSM
> eco-system by enabling a quick feedback loop from the security community
> about the kind of behaviours that the LSM Framework should be targeting.
> 
> # How does it work?
> 
> The patchset introduces a new eBPF (https://docs.cilium.io/en/v1.6/bpf/)
> program type BPF_PROG_TYPE_LSM which can only be attached to LSM hooks.
> Loading and attachment of BPF programs requires CAP_SYS_ADMIN.
> 
> The new LSM registers nop functions (bpf_lsm_<hook_name>) as LSM hook
> callbacks. Their purpose is to provide a definite point where BPF
> programs can be attached as BPF_TRAMP_MODIFY_RETURN trampoline programs
> for hooks that return an int, and BPF_TRAMP_FEXIT trampoline programs
> for void LSM hooks.
> 
> Audit logs can be written using a format chosen by the eBPF program to
> the perf events buffer or to global eBPF variables or maps and can be
> further processed in user-space.
> 
> # BTF Based Design
> 
> The current design uses BTF:
> 
>   * https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhancement.html
>   * https://lwn.net/Articles/803258
> 
> which allows verifiable read-only structure accesses by field names
> rather than fixed offsets. This allows accessing the hook parameters
> using a dynamically created context which provides a certain degree of
> ABI stability:
> 
> 
> // Only declare the structure and fields intended to be used
> // in the program
> struct vm_area_struct {
>   unsigned long vm_start;
> } __attribute__((preserve_access_index));
> 
> // Declare the eBPF program mprotect_audit which attaches to
> // to the file_mprotect LSM hook and accepts three arguments.
> SEC("lsm/file_mprotect")
> int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
>        unsigned long reqprot, unsigned long prot, int ret)
> {
>   unsigned long vm_start = vma->vm_start;
> 
>   return 0;
> }
> 
> By relocating field offsets, BTF makes a large portion of kernel data
> structures readily accessible across kernel versions without requiring a
> large corpus of BPF helper functions and requiring recompilation with
> every kernel version. The BTF type information is also used by the BPF
> verifier to validate memory accesses within the BPF program and also
> prevents arbitrary writes to the kernel memory.
> 
> The limitations of BTF compatibility are described in BPF Co-Re
> (http://vger.kernel.org/bpfconf2019_talks/bpf-core.pdf, i.e. field
> renames, #defines and changes to the signature of LSM hooks).  This
> design imposes that the MAC policy (eBPF programs) be updated when the
> inspected kernel structures change outside of BTF compatibility
> guarantees. In practice, this is only required when a structure field
> used by a current policy is removed (or renamed) or when the used LSM
> hooks change. We expect the maintenance cost of these changes to be
> acceptable as compared to the design presented in the RFC.
> 
> (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/).
> 
> # Usage Examples
> 
> A simple example and some documentation is included in the patchset.
> In order to better illustrate the capabilities of the framework some
> more advanced prototype (not-ready for review) code has also been
> published separately:
> 
> * Logging execution events (including environment variables and
>   arguments)
>   https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c
> 
> * Detecting deletion of running executables:
>   https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c
> 
> * Detection of writes to /proc/<pid>/mem:
>   https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c
> 
> We have updated Google's internal telemetry infrastructure and have
> started deploying this LSM on our Linux Workstations. This gives us more
> confidence in the real-world applications of such a system.
> 
> 
> KP Singh (8):
>   bpf: Introduce BPF_PROG_TYPE_LSM
>   security: Refactor declaration of LSM hooks
>   bpf: lsm: provide attachment points for BPF LSM programs
>   bpf: lsm: Implement attach, detach and execution
>   bpf: lsm: Initialize the BPF LSM hooks
>   tools/libbpf: Add support for BPF_PROG_TYPE_LSM
>   bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
>   bpf: lsm: Add Documentation
> 
>  Documentation/bpf/bpf_lsm.rst                 | 150 +++++
>  Documentation/bpf/index.rst                   |   1 +
>  MAINTAINERS                                   |   1 +
>  include/linux/bpf.h                           |   3 +
>  include/linux/bpf_lsm.h                       |  32 +
>  include/linux/bpf_types.h                     |   4 +
>  include/linux/lsm_hook_defs.h                 | 378 +++++++++++
>  include/linux/lsm_hooks.h                     | 627 +-----------------
>  include/uapi/linux/bpf.h                      |   2 +
>  init/Kconfig                                  |  10 +
>  kernel/bpf/Makefile                           |   1 +
>  kernel/bpf/bpf_lsm.c                          |  60 ++
>  kernel/bpf/btf.c                              |   9 +-
>  kernel/bpf/syscall.c                          |  56 +-
>  kernel/bpf/trampoline.c                       |  17 +-
>  kernel/bpf/verifier.c                         |  19 +-
>  kernel/trace/bpf_trace.c                      |  12 +-
>  security/Kconfig                              |  10 +-
>  security/Makefile                             |   2 +
>  security/bpf/Makefile                         |   5 +
>  security/bpf/hooks.c                          |  26 +
>  security/security.c                           | 432 ++++++------
>  tools/include/uapi/linux/bpf.h                |   2 +
>  tools/lib/bpf/bpf.c                           |   3 +-
>  tools/lib/bpf/libbpf.c                        |  39 +-
>  tools/lib/bpf/libbpf.h                        |   4 +
>  tools/lib/bpf/libbpf.map                      |   3 +
>  tools/lib/bpf/libbpf_probes.c                 |   1 +
>  tools/testing/selftests/bpf/config            |   2 +
>  tools/testing/selftests/bpf/lsm_helpers.h     |  19 +
>  .../selftests/bpf/prog_tests/lsm_test.c       | 112 ++++
>  .../selftests/bpf/progs/lsm_int_hook.c        |  54 ++
>  .../selftests/bpf/progs/lsm_void_hook.c       |  41 ++
>  33 files changed, 1277 insertions(+), 860 deletions(-)
>  create mode 100644 Documentation/bpf/bpf_lsm.rst
>  create mode 100644 include/linux/bpf_lsm.h
>  create mode 100644 include/linux/lsm_hook_defs.h
>  create mode 100644 kernel/bpf/bpf_lsm.c
>  create mode 100644 security/bpf/Makefile
>  create mode 100644 security/bpf/hooks.c
>  create mode 100644 tools/testing/selftests/bpf/lsm_helpers.h
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm_int_hook.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm_void_hook.c
> 
> -- 
> 2.20.1
> 

-- 
Kees Cook
