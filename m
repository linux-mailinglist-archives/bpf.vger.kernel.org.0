Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C10128546
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 23:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfLTWz5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 17:55:57 -0500
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:41720 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTWz5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 17:55:57 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Dec 2019 17:55:24 EST
Received: from smtp-2-0001.mail.infomaniak.ch ([10.5.36.108])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id xBKMlC5I028293
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Dec 2019 23:47:12 +0100
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 1B85910203403;
        Fri, 20 Dec 2019 23:47:08 +0100 (CET)
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
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
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
References: <20191220154208.15895-1-kpsingh@chromium.org>
Message-ID: <a6b61f33-82dc-0c1c-7a6c-1926343ef63e@digikod.net>
Date:   Fri, 20 Dec 2019 23:46:47 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 20/12/2019 16:41, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> This patch series is a continuation of the KRSI RFC
> (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/)
> 
> # Motivation
> 
> Google does rich analysis of runtime security data collected from
> internal Linux deployments (corporate devices and servers) to detect and
> thwart threats in real-time. Currently, this is done in custom kernel
> modules but we would like to replace this with something that's upstream
> and useful to others.
> 
> The current kernel infrastructure for providing telemetry (Audit, Perf
> etc.) is disjoint from access enforcement (i.e. LSMs).  Augmenting the
> information provided by audit requires kernel changes to audit, its
> policy language and user-space components. Furthermore, building a MAC
> policy based on the newly added telemetry data requires changes to
> various LSMs and their respective policy languages.
> 
> This patchset proposes a new stackable and privileged LSM which allows
> the LSM hooks to be implemented using eBPF. This facilitates a unified
> and dynamic (not requiring re-compilation of the kernel) audit and MAC
> policy.
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
> The LSM introduces a new eBPF (https://docs.cilium.io/en/v1.6/bpf/)
> program type, BPF_PROG_TYPE_LSM, which can only be attached to a LSM
> hook.  All LSM hooks are exposed as files in securityfs. Attachment
> requires CAP_SYS_ADMIN for loading eBPF programs and CAP_MAC_ADMIN for
> modifying MAC policies.
> 
> The eBPF programs are passed the same arguments as the LSM hooks and
> executed in the body of the hook. If any of the eBPF programs returns an
> error (like ENOPERM), the behaviour represented by the hook is denied.
> 
> Audit logs can be written using a format chosen by the eBPF program to
> the perf events buffer and can be further processed in user-space.
> 
> # Limitations of RFC v1
> 
> In the previous design
> (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/),
> the BPF programs received a context which could be queried to retrieve
> specific pieces of information using specific helpers.
> 
> For example, a program that attaches to the file_mprotect LSM hook and
> queries the VMA region could have had the following context:
> 
> // Special context for the hook.
> struct bpf_mprotect_ctx {
> 	struct vm_area_struct *vma;
> };
> 
> and accessed the fields using a hypothetical helper
> "bpf_mprotect_vma_get_start:
> 
> SEC("lsm/file_mprotect")
> int mprotect_audit(bpf_mprotect_ctx *ctx)
> {
> 	unsigned long vm_start = bpf_mprotect_vma_get_start(ctx);
> 	return 0;
> }
> 
> or directly read them from the context by updating the verifier to allow
> accessing the fields:
> 
> int mprotect_audit(bpf_mprotect_ctx *ctx)
> {
> 	unsigned long vm_start = ctx->vma->vm_start;
> 	return 0;
> }
> 
> As we prototyped policies based on this design, we realized that this
> approach is not general enough. Adding helpers or verifier code for all
> usages would imply a high maintenance cost while severely restricting
> the instrumentation capabilities which is the key value add of our
> eBPF-based LSM.
> 
> Feedback from the BPF maintainers at Linux Plumbers also pushed us
> towards the following, more general, approach.
> 
> # BTF Based Design
> 
> The current design uses BTF
> (https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhancement.html,
> https://lwn.net/Articles/803258/) which allows verifiable read-only
> structure accesses by field names rather than fixed offsets. This allows
> accessing the hook parameters using a dynamically created context which
> provides a certain degree of ABI stability:
> 
> /* Clang builtin to handle field accesses. */
> #define _(P) (__builtin_preserve_access_index(P))
> 
> // Only declare the structure and fields intended to be used
> // in the program
> struct vm_area_struct {
> 	unsigned long vm_start;
> };
> 
> // Declare the eBPF program mprotect_audit which attaches to
> // to the file_mprotect LSM hook and accepts three arguments.
> BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
> 	    struct vm_area_struct *, vma,
> 	    unsigned long, reqprot, unsigned long, prot
> {
> 	unsigned long vm_start = _(vma->vm_start);
> 	return 0;
> }
> 
> By relocating field offsets, BTF makes a large portion of kernel data
> structures readily accessible across kernel versions without requiring a
> large corpus of BPF helper functions and requiring recompilation with
> every kernel version. The limitations of BTF compatibility are described
> in BPF Co-Re (http://vger.kernel.org/bpfconf2019_talks/bpf-core.pdf,
> i.e. field renames, #defines and changes to the signature of LSM hooks).
> 
> This design imposes that the MAC policy (eBPF programs) be updated when
> the inspected kernel structures change outside of BTF compatibility
> guarantees. In practice, this is only required when a structure field
> used by a current policy is removed (or renamed) or when the used LSM
> hooks change. We expect the maintenance cost of these changes to be
> acceptable as compared to the previous design
> (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/).
> 
> # Distinction from Landlock
> 
> We believe there exist two distinct use-cases with distinct set of users:
> 
> * Unprivileged processes voluntarily relinquishing privileges with the
>    primary users being software developers.
> 
> * Flexible privileged (CAP_MAC_ADMIN, CAP_SYS_ADMIN) MAC and Audit with
>    the primary users being system policy admins.
> 
> These use-cases imply different APIs and trade-offs:
> 
> * The unprivileged use case requires defining more stable and custom APIs
>    (through opaque contexts and precise helpers).
> 
> * Privileged Audit and MAC requires deeper introspection of the kernel
>    data structures to maximise the flexibility that can be achieved without
>    kernel modification.
> 
> Landlock has demonstrated filesystem sandboxes and now Ptrace access
> control in its patches which are excellent use cases for an unprivileged
> process voluntarily relinquishing privileges.
> 
> However, Landlock has expanded its original goal, "towards unprivileged
> sandboxing", to being a "low-level framework to build
> access-control/audit systems" (https://landlock.io). We feel that the
> design and implementation are still driven by the constraints and
> trade-offs of the former use-case, and do not provide a satisfactory
> solution to the latter.
> 
> We also believe that our approach, direct access to common kernel data
> structures as with BTF, is inappropriate for unprivileged processes and
> probably not a good option for Landlock.
> 
> In conclusion, we feel that the design for a privileged LSM and
> unprivileged LSM are mutually exclusive and that one cannot be built
> "on-top-of" the other. Doing so would limit the capabilities of what can
> be done for an LSM that provides flexible audit and MAC capabilities or
> provide in-appropriate access to kernel internals to an unprivileged
> process.

I don't think that the design for a privileged LSM and an unprivileged 
LSM are necessarily mutually exclusive, however I do agree that the 
design of an *introspection* LSM like this version of KRSI, and an 
unprivileged LSM are mutually exclusive.

> 
> Furthermore, the Landlock design supports its historical use-case only
> when unprivileged eBPF is allowed. This is something that warrants
> discussion before an unprivileged LSM that uses eBPF is upstreamed.

Because of seccomp-bpf, on which the first version of Landlock was based 
on, I then used eBPF as a way to define a security policy which could be 
updated on the fly (thanks to eBPF maps) and evolves over time. The main 
goal of Landlock was and still is to bring sandboxing features to all 
users, which means to have an unprivileged access-control. However, I've 
reach a similar conclusion about eBPF for unprivileged access-control, 
but for slightly different reasons.

eBPF is very powerful and I proved with Landlock that it is possible to 
implement an access-control with it. However, a programmatic 
access-control does not fit well with unprivileged principles (i.e. 
innocuous composability). First, it can be used for side-channel attacks 
against (other) access-controls. Second, composability of eBPF programs 
imply to execute a stack of programs, which does not scale well. Third, 
as shown by multiple attacks, it is quite challenging to safely expose 
eBPF to malicious processes.

I'm working on a version of Landlock without eBPF, but still with the 
initial sought properties: safe unprivileged composability, modularity, 
and dynamic update. I'll send this version soon.

I hope that the work and experience from Landlock to bring eBPF to LSM 
will continue to be used through KRSI. Landlock will now focus on the 
unprivileged sandboxing part, without eBPF. Stay tuned!


> 
> # Why not tracepoints or kprobes?
> 
> In order to do MAC with tracepoints or kprobes, we would need to
> override the return value of the security hook. This is not possible
> with tracepoints or call-site kprobes.
> 
> Attaching to the return boundary (kretprobe) implies that BPF programs
> would always get called after all the other LSM hooks are called and
> clobber the pre-existing LSM semantics.
> 
> Enforcing MAC policy with an actual LSM helps leverage the verified
> semantics of the framework.
> 
> # Usage Examples
> 
> A simple example and some documentation is included in the patchset.
> 
> In order to better illustrate the capabilities of the framework some
> more advanced prototype code has also been published separately:
> 
> * Logging execution events (including environment variables and arguments):
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c
> * Detecting deletion of running executables:
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c
> * Detection of writes to /proc/<pid>/mem:
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c
> 
> We have updated Google's internal telemetry infrastructure and have
> started deploying this LSM on our Linux Workstations. This gives us more
> confidence in the real-world applications of such a system.
> 
> KP Singh (13):
>    bpf: Refactor BPF_EVENT context macros to its own header.
>    bpf: lsm: Add a skeleton and config options
>    bpf: lsm: Introduce types for eBPF based LSM
>    bpf: lsm: Allow btf_id based attachment for LSM hooks
>    tools/libbpf: Add support in libbpf for BPF_PROG_TYPE_LSM
>    bpf: lsm: Init Hooks and create files in securityfs
>    bpf: lsm: Implement attach, detach and execution.
>    bpf: lsm: Show attached program names in hook read handler.
>    bpf: lsm: Add a helper function bpf_lsm_event_output
>    bpf: lsm: Handle attachment of the same program
>    tools/libbpf: Add bpf_program__attach_lsm
>    bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
>    bpf: lsm: Add Documentation
> 
>   Documentation/security/bpf.rst                |  164 +++
>   Documentation/security/index.rst              |    1 +
>   MAINTAINERS                                   |   11 +
>   include/linux/bpf_event.h                     |   78 ++
>   include/linux/bpf_lsm.h                       |   25 +
>   include/linux/bpf_types.h                     |    4 +
>   include/trace/bpf_probe.h                     |   30 +-
>   include/uapi/linux/bpf.h                      |   12 +-
>   kernel/bpf/syscall.c                          |   10 +
>   kernel/bpf/verifier.c                         |   84 +-
>   kernel/trace/bpf_trace.c                      |   24 +-
>   security/Kconfig                              |   11 +-
>   security/Makefile                             |    2 +
>   security/bpf/Kconfig                          |   25 +
>   security/bpf/Makefile                         |    7 +
>   security/bpf/include/bpf_lsm.h                |   63 +
>   security/bpf/include/fs.h                     |   23 +
>   security/bpf/include/hooks.h                  | 1015 +++++++++++++++++
>   security/bpf/lsm.c                            |  160 +++
>   security/bpf/lsm_fs.c                         |  176 +++
>   security/bpf/ops.c                            |  224 ++++
>   tools/include/uapi/linux/bpf.h                |   12 +-
>   tools/lib/bpf/bpf.c                           |    2 +-
>   tools/lib/bpf/bpf.h                           |    6 +
>   tools/lib/bpf/libbpf.c                        |  163 ++-
>   tools/lib/bpf/libbpf.h                        |    4 +
>   tools/lib/bpf/libbpf.map                      |    7 +
>   tools/lib/bpf/libbpf_probes.c                 |    1 +
>   .../bpf/prog_tests/lsm_mprotect_audit.c       |  129 +++
>   .../selftests/bpf/progs/lsm_mprotect_audit.c  |   58 +
>   30 files changed, 2451 insertions(+), 80 deletions(-)
>   create mode 100644 Documentation/security/bpf.rst
>   create mode 100644 include/linux/bpf_event.h
>   create mode 100644 include/linux/bpf_lsm.h
>   create mode 100644 security/bpf/Kconfig
>   create mode 100644 security/bpf/Makefile
>   create mode 100644 security/bpf/include/bpf_lsm.h
>   create mode 100644 security/bpf/include/fs.h
>   create mode 100644 security/bpf/include/hooks.h
>   create mode 100644 security/bpf/lsm.c
>   create mode 100644 security/bpf/lsm_fs.c
>   create mode 100644 security/bpf/ops.c
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
>   create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
> 
