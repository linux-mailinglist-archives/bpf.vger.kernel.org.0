Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0537128136
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 18:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLTRRf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 12:17:35 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:43880
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727391AbfLTRRe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Dec 2019 12:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576862250; bh=tICZ1FeKHXXXSQDMQ7hgb5ljJ4Tq9PA5wfEk83a/Ork=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=iPCoJB2mRVTBru5fyzHIN/cUc9d8S1PuwjcEM3aVHi4iv+IZKc7berkYlJlil5xneycsJIvUnYpAxRoyFHazeH62w4P66oQEiNN+9x9CUWhF60scgtbaTFtOI39mtQ/MbOp1LVgFt2pmKzIBgqBl2PCq+ntu6IzEEkzgQ9fKIyjFVxA8LwMKkgqJgcGGiPVVlmTQkmha1viHTNpNuwNjbLVq+HSlikGFLdmXToeA0hk3ND9/mDyaBBTm3N0KM6x+BjUQYfauuGPubRdlJuF75MMVKLkHeFCdo4ZYzaRnH0zWsBMRZKdv2zvwwHCjevN2ZSn7PT8yiYHz48fq6hrLSw==
X-YMail-OSG: hH0z2PEVM1mQvZilr1FJrlfAmrctBiykJ01OOKGticXiy7CmQjQXcIDtiDhoBP6
 aQE2kEvvaq94KfxXGd1Z9PFSL3MAnuDVRbwV_SPjBKzXSiMUPztDSnOUXUJQUWuUam6hUMWr.gWS
 z9bNsWMhvuS_Z1uO59Ocj_7e5nRC9MHuJ_kR3AjfDJuAHCrmaFnRtnhyluo.07XJlBRX.UB5dhrF
 9XeAvie0sIsOj1_M_syHoH3CrzzG37UqCi3l2FZXefyB.gbw1BW1DTe4LwaZZsmX9APhFiw3eIyM
 .vog0hbEbpq94uFtCT8HtWN5OXEEEI.djUEgcMI192TAEiKp97cufuZRM9avCVMsB8nO4Sw2yheM
 tfslt9VwK29EVANjimuTYBkXp.DAoM5lecj1.3hng5gCn0OuT99OXuhZqJTlHyQewIlTRXIUC9yC
 4hMnx_FqFvthVjODFVmwpIO11jw.2zr63EEbIdaYeI2NdXArv2Vzj8fgZsCdBTCKxpCeuIPPMdyf
 yNECCkvY3RovRTYMEx10LocdmWJdQQtRZfeFTeXKOEKPDWKls3WIPM7BtwMuXRmLauAsfN7C9MJJ
 5A4zRJmUDerXmzwkmJMgmsZQPcgvqrkpSp.HfSCEAQLIiB49hLeVxThOmgFg5i8GH5kCWXD9oGEV
 q6pu9SbXHq_Q1HOAVyXzISvVj2pBja2NACn3ttCpE.ucOWj4_Vni8IvjnhslFVEDVwaWmo.FO7pJ
 3bNcuo2b_MXmL9Uv_Ss45f2AOblAmGR1NupP879npHq4l_SCpACU5hdFkB2AA8FFFgR2Qgorjk5X
 g8r_m8zsAIgPShhdqstSV2zJUlJcnrNopu7ceqZLnfS.GXGcr2zeO8vq.Xy2eOAf7w1FeoiAbM5a
 86evKRPAeDNqtO6wDJoF_6Je9Bh2PctXr5q2EBLOjg3jib_PQ0pHkCtIcbu16MUpEppzS57VtC4z
 3Ho5FcS53RLepqt8xHaeaNstG9xebiZvS1UXRv3CGxGf2L2ryxzpC3BE6t9m42k0L4dZW.xGhgPb
 y3WmWAqCgPraukXWB_b4OfeFCcwQcGdvTAbYY.0AjFGu7TvmfaFuWmcD6laOzIupoPCdgW6xuNrH
 a7sW4UPKbEwQRrNMKG.Dp3.wIHRETUXvpIGVB53JktAcXHL90l0PUwjVpU9FMoi6s9O8RBzb0Plb
 AQHuD3_cUxfcKCJhHU8nwah.K1OtqLRPT3985veVTqtRrIcragCzEmmR2z_4sMh02qaW6qmDDPcH
 E3PPhM7dGQ0euurPZvvv0ihHAFzkEdnYEoWuJ32ngppHl5jWI7W1kyIzuEJtTGRqY1Ry5Zsfv5p4
 wpNvAapsBxkem4RatGtUzVUnKKmhkIxkCTX2wmZ4lLFbCqZXVV3WlOJqF6Wd77LEjWwB7FdK.xqW
 cCrBV4yEd7ykXWnSEI0T.98IOgTVX_mjSuWtMxQ26nGMxJFrjS8ZnxTQZhfJbVjzjbZ.6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Dec 2019 17:17:30 +0000
Received: by smtp406.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6c12bf1891c7c52d51ea8620338f974e;
          Fri, 20 Dec 2019 17:17:26 +0000 (UTC)
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
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
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
References: <20191220154208.15895-1-kpsingh@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <95036040-6b1c-116c-bd6b-684f00174b4f@schaufler-ca.com>
Date:   Fri, 20 Dec 2019 09:17:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/20/2019 7:41 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
>
> This patch series is a continuation of the KRSI RFC
> (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org=
/)
>
> # Motivation
>
> Google does rich analysis of runtime security data collected from
> internal Linux deployments (corporate devices and servers) to detect an=
d
> thwart threats in real-time. Currently, this is done in custom kernel
> modules but we would like to replace this with something that's upstrea=
m
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
> framework ensures that all process executions trigger the relevant hook=
s
> irrespective of how the process was executed.
>
> Allowing users to implement LSM hooks at runtime also benefits the LSM
> eco-system by enabling a quick feedback loop from the security communit=
y
> about the kind of behaviours that the LSM Framework should be targeting=
=2E
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
> executed in the body of the hook.

This effectively exposes the LSM hooks as external APIs.
It would mean that we can't change or delete them. That
would be bad.


>  If any of the eBPF programs returns an
> error (like ENOPERM), the behaviour represented by the hook is denied.
>
> Audit logs can be written using a format chosen by the eBPF program to
> the perf events buffer and can be further processed in user-space.
>
> # Limitations of RFC v1
>
> In the previous design
> (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org=
/),
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
> 	unsigned long vm_start =3D bpf_mprotect_vma_get_start(ctx);
> 	return 0;
> }
>
> or directly read them from the context by updating the verifier to allo=
w
> accessing the fields:
>
> int mprotect_audit(bpf_mprotect_ctx *ctx)
> {
> 	unsigned long vm_start =3D ctx->vma->vm_start;
> 	return 0;
> }
>
> As we prototyped policies based on this design, we realized that this
> approach is not general enough. Adding helpers or verifier code for all=

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
> (https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhanceme=
nt.html,
> https://lwn.net/Articles/803258/) which allows verifiable read-only
> structure accesses by field names rather than fixed offsets. This allow=
s
> accessing the hook parameters using a dynamically created context which=

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
> 	unsigned long vm_start =3D _(vma->vm_start);
> 	return 0;
> }
>
> By relocating field offsets, BTF makes a large portion of kernel data
> structures readily accessible across kernel versions without requiring =
a
> large corpus of BPF helper functions and requiring recompilation with
> every kernel version. The limitations of BTF compatibility are describe=
d
> in BPF Co-Re (http://vger.kernel.org/bpfconf2019_talks/bpf-core.pdf,
> i.e. field renames, #defines and changes to the signature of LSM hooks)=
=2E
>
> This design imposes that the MAC policy (eBPF programs) be updated when=

> the inspected kernel structures change outside of BTF compatibility
> guarantees. In practice, this is only required when a structure field
> used by a current policy is removed (or renamed) or when the used LSM
> hooks change. We expect the maintenance cost of these changes to be
> acceptable as compared to the previous design
> (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org=
/).
>
> # Distinction from Landlock
>
> We believe there exist two distinct use-cases with distinct set of user=
s:
>
> * Unprivileged processes voluntarily relinquishing privileges with the
>   primary users being software developers.
>
> * Flexible privileged (CAP_MAC_ADMIN, CAP_SYS_ADMIN) MAC and Audit with=

>   the primary users being system policy admins.
>
> These use-cases imply different APIs and trade-offs:
>
> * The unprivileged use case requires defining more stable and custom AP=
Is
>   (through opaque contexts and precise helpers).
>
> * Privileged Audit and MAC requires deeper introspection of the kernel
>   data structures to maximise the flexibility that can be achieved with=
out
>   kernel modification.
>
> Landlock has demonstrated filesystem sandboxes and now Ptrace access
> control in its patches which are excellent use cases for an unprivilege=
d
> process voluntarily relinquishing privileges.
>
> However, Landlock has expanded its original goal, "towards unprivileged=

> sandboxing", to being a "low-level framework to build
> access-control/audit systems" (https://landlock.io). We feel that the
> design and implementation are still driven by the constraints and
> trade-offs of the former use-case, and do not provide a satisfactory
> solution to the latter.
>
> We also believe that our approach, direct access to common kernel data
> structures as with BTF, is inappropriate for unprivileged processes and=

> probably not a good option for Landlock.
>
> In conclusion, we feel that the design for a privileged LSM and
> unprivileged LSM are mutually exclusive and that one cannot be built
> "on-top-of" the other. Doing so would limit the capabilities of what ca=
n
> be done for an LSM that provides flexible audit and MAC capabilities or=

> provide in-appropriate access to kernel internals to an unprivileged
> process.
>
> Furthermore, the Landlock design supports its historical use-case only
> when unprivileged eBPF is allowed. This is something that warrants
> discussion before an unprivileged LSM that uses eBPF is upstreamed.
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
> * Logging execution events (including environment variables and argumen=
ts):
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf=
/lsm_audit_env.c
> * Detecting deletion of running executables:
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf=
/lsm_detect_exec_unlink.c
> * Detection of writes to /proc/<pid>/mem:
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf=
/lsm_audit_env.c
>
> We have updated Google's internal telemetry infrastructure and have
> started deploying this LSM on our Linux Workstations. This gives us mor=
e
> confidence in the real-world applications of such a system.
>
> KP Singh (13):
>   bpf: Refactor BPF_EVENT context macros to its own header.
>   bpf: lsm: Add a skeleton and config options
>   bpf: lsm: Introduce types for eBPF based LSM
>   bpf: lsm: Allow btf_id based attachment for LSM hooks
>   tools/libbpf: Add support in libbpf for BPF_PROG_TYPE_LSM
>   bpf: lsm: Init Hooks and create files in securityfs
>   bpf: lsm: Implement attach, detach and execution.
>   bpf: lsm: Show attached program names in hook read handler.
>   bpf: lsm: Add a helper function bpf_lsm_event_output
>   bpf: lsm: Handle attachment of the same program
>   tools/libbpf: Add bpf_program__attach_lsm
>   bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
>   bpf: lsm: Add Documentation
>
>  Documentation/security/bpf.rst                |  164 +++
>  Documentation/security/index.rst              |    1 +
>  MAINTAINERS                                   |   11 +
>  include/linux/bpf_event.h                     |   78 ++
>  include/linux/bpf_lsm.h                       |   25 +
>  include/linux/bpf_types.h                     |    4 +
>  include/trace/bpf_probe.h                     |   30 +-
>  include/uapi/linux/bpf.h                      |   12 +-
>  kernel/bpf/syscall.c                          |   10 +
>  kernel/bpf/verifier.c                         |   84 +-
>  kernel/trace/bpf_trace.c                      |   24 +-
>  security/Kconfig                              |   11 +-
>  security/Makefile                             |    2 +
>  security/bpf/Kconfig                          |   25 +
>  security/bpf/Makefile                         |    7 +
>  security/bpf/include/bpf_lsm.h                |   63 +
>  security/bpf/include/fs.h                     |   23 +
>  security/bpf/include/hooks.h                  | 1015 +++++++++++++++++=

>  security/bpf/lsm.c                            |  160 +++
>  security/bpf/lsm_fs.c                         |  176 +++
>  security/bpf/ops.c                            |  224 ++++
>  tools/include/uapi/linux/bpf.h                |   12 +-
>  tools/lib/bpf/bpf.c                           |    2 +-
>  tools/lib/bpf/bpf.h                           |    6 +
>  tools/lib/bpf/libbpf.c                        |  163 ++-
>  tools/lib/bpf/libbpf.h                        |    4 +
>  tools/lib/bpf/libbpf.map                      |    7 +
>  tools/lib/bpf/libbpf_probes.c                 |    1 +
>  .../bpf/prog_tests/lsm_mprotect_audit.c       |  129 +++
>  .../selftests/bpf/progs/lsm_mprotect_audit.c  |   58 +
>  30 files changed, 2451 insertions(+), 80 deletions(-)
>  create mode 100644 Documentation/security/bpf.rst
>  create mode 100644 include/linux/bpf_event.h
>  create mode 100644 include/linux/bpf_lsm.h
>  create mode 100644 security/bpf/Kconfig
>  create mode 100644 security/bpf/Makefile
>  create mode 100644 security/bpf/include/bpf_lsm.h
>  create mode 100644 security/bpf/include/fs.h
>  create mode 100644 security/bpf/include/hooks.h
>  create mode 100644 security/bpf/lsm.c
>  create mode 100644 security/bpf/lsm_fs.c
>  create mode 100644 security/bpf/ops.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect=
_audit.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audi=
t.c
>

