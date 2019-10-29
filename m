Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D9FE8E55
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 18:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfJ2RjV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 13:39:21 -0400
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:55501 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfJ2RjU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 13:39:20 -0400
X-Greylist: delayed 1166 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Oct 2019 13:35:48 EDT
Received: from smtp8.infomaniak.ch (smtp8.infomaniak.ch [83.166.132.38])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x9THFJRJ005841
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:15:20 +0100
Received: from localhost (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp8.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x9THFHvg167626;
        Tue, 29 Oct 2019 18:15:17 +0100
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        Florent Revest <revest@chromium.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        John Johansen <john.johansen@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        KP Singh <kpsingh@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Tejun Heo <tj@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>, bpf@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v11 0/7] Landlock LSM
Date:   Tue, 29 Oct 2019 18:14:58 +0100
Message-Id: <20191029171505.6650-1-mic@digikod.net>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

This eleventh series is a major rework of the previous series [1] to
make the patches smaller while still putting in place the foundations of
Landlock and implementing a useful feature.  The whole file-system
support (i.e. inode map and program triggers) has been removed (but is
still planed in the future).  This series rewrite the previous static
ptrace restrictions with a programmatic one thanks to eBPF.  To be more
independent from seccomp, Landlock is now a full LSM using task's
credentials thanks to the LSM stacking infrastructure.  The only part of
seccomp still used is the syscall, which makes sense and which is a
quite simple interface.  The clear definition of Landlock domains (sets
of eBPF programs) can be used for other use-cases than sandboxing e.g.,
to implement a system-wide security signaling framework as described by
KRSI [2].  In addition to improvements and bug fixes, I split the
patches as much as possible to ease the review process.

As discussed at LSS NA [3] (with Kees Cook, James Morris, KP Singh and
Florent Revest) and at Kernel Recipes (with Alexei Starovoitov), I
planned to shrink the code of Landlock to a bare minimum to enable
incremental feature integration.  The idea was to create a "memory
protection" hook and the appropriate eBPF program type.  After some
experimentations, I concluded that it is not easy to implement a simple
interface to control actions such as mmap(2) or mprotect(2).  I then
focused on an old stable feature of Landlock: ptrace protection.  But
instead of keeping the static security policy, which make sense in a
sandboxing scenario, I extended Landlock with a ptrace hook and the
appropriate eBPF program type.  The ptrace enforcement is not mandatory
anymore but this new hook could be used (and extended with new helpers)
for a security signaling mechanism such as KRSI.  I hope the KRSI
developments could take advantage of this new Landlock version.

This is the first step of the roadmap discussed at LPC [4].  While the
intended final goal is to allow unprivileged users to use Landlock, this
series allows only a process with global CAP_SYS_ADMIN to load and
enforce a rule.  This may help to get feedback and avoid unexpected
behaviors.

This series can be applied on top of bpf-next, commit e93d99180abd
("selftests/bpf: Restore $(OUTPUT)/test_stub.o rule").  This can be
tested with CONFIG_BPF_SYSCALL, CONFIG_SECCOMP_FILTER and
CONFIG_SECURITY_LANDLOCK.  This patch series can be found in a Git
repository here:
https://github.com/landlock-lsm/linux/commits/landlock-v11
I would really appreciate constructive comments on the design and the
code.


# Landlock LSM

Landlock is a stackable LSM [5] intended to be used as a low-level
framework to build custom access-control/audit systems or safe endpoint
security agents.  There is currently one Landlock hook dedicated to
check ptrace(2).  This hook accepts a dedicated eBPF program, called a
Landlock program, which can currently compare its position in the
hierarchy of similar programs tied to other processes.  This enables to
enforce programmatic scoped ptrace restrictions.

The final goal of this new Linux Security Module (LSM) called Landlock
is to allow any process, including unprivileged ones, to create powerful
security sandboxes comparable to XNU Sandbox, FreeBSD Capsicum or
OpenBSD Pledge (which could be implemented with Landlock).  This kind of
sandbox is expected to help mitigate the security impact of bugs or
unexpected/malicious behaviors in user-space applications.

The use of seccomp and Landlock is more suitable with the help of a
user-space library (e.g.  libseccomp) that could help to specify a
high-level language to express a security policy instead of raw eBPF
programs.  Moreover, thanks to the LLVM front-end, it is quite easy to
write an eBPF program with a subset of the C language.

The documentation patch contains some kernel documentation, explanations
on how to use Landlock and a FAQ.  The compiled documentation and some
talks can be found here: https://landlock.io


# Frequently asked questions

## Why is seccomp-bpf not enough?

A seccomp filter can access only raw syscall arguments (i.e. the
register values) which means that it is not possible to filter according
to the value pointed to by an argument, such as a file pathname. As an
embryonic Landlock version demonstrated (i.e. seccomp-object), filtering
at the syscall level is complicated (e.g. need to take care of race
conditions). This is mainly because the access control checkpoints of
the kernel are not at this high-level but more underneath, at the
LSM-hook level. The LSM hooks are designed to handle this kind of
checks.  Landlock abstracts this approach to leverage the ability of
unprivileged users to limit themselves.

Cf. section "What it isn't?" in
Documentation/userspace-api/seccomp_filter.rst


## Why use the seccomp(2) syscall?

Landlock use the same semantic as seccomp to apply access rule
restrictions. It add a new layer of security for the current process
which is inherited by its children. It makes sense to use an unique
access-restricting syscall (that should be allowed by seccomp filters)
which can only drop privileges. Moreover, a Landlock rule could come
from outside a process (e.g.  passed through a UNIX socket). It is then
useful to differentiate the creation/load of Landlock eBPF programs via
bpf(2), from rule enforcement via seccomp(2).


## Why a new LSM? Are SELinux, AppArmor, Smack and Tomoyo not good
   enough?

The current access control LSMs are fine for their purpose which is to
give the *root* the ability to enforce a security policy for the
*system*. What is missing is a way to enforce a security policy for any
application by its developer and *unprivileged user* as seccomp can do
for raw syscall filtering.

Differences from other (access control) LSMs:
* not only dedicated to administrators (i.e. no_new_priv);
* limited kernel attack surface (e.g. policy parsing);
* constrained policy rules (no DoS: deterministic execution time);
* do not leak more information than the loader process can legitimately
  have access to (minimize metadata inference).


# Changes since v10

* remove all the file system related features: program types, inode
  map and expected_attach_triggers
* replace the static ptrace security policy with a new and simpler
  ptrace program (attached) type and a task_landlock_ptrace_ancestor()
  eBPF helper
* do not rely on seccomp internal structure but use stacked credentials
  insdead
* extend ptrace tests
* add more documentation
* split and rename files/patches
* miscellaneous fixes

Previous changes can be found in the previous cover-letter [1].


[1] https://lore.kernel.org/lkml/20190721213116.23476-1-mic@digikod.net/
[2] https://lore.kernel.org/lkml/20190910115527.5235-1-kpsingh@chromium.org/
[3] https://lwn.net/Articles/798157/
[4] https://lore.kernel.org/lkml/5828776A.1010104@digikod.net/
[5] https://lore.kernel.org/lkml/50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com/

Regards,

Mickaël Salaün (7):
  bpf,landlock: Define an eBPF program type for Landlock hooks
  landlock: Add the management of domains
  landlock,seccomp: Load Landlock programs per process hierarchy
  landlock: Add ptrace LSM hooks
  bpf,landlock: Add task_landlock_ptrace_ancestor() helper
  bpf,landlock: Add tests for the Landlock ptrace program type
  landlock: Add user and kernel documentation for Landlock

 Documentation/security/index.rst              |   1 +
 Documentation/security/landlock/index.rst     |  22 ++
 Documentation/security/landlock/kernel.rst    | 139 +++++++++
 Documentation/security/landlock/user.rst      | 142 ++++++++++
 MAINTAINERS                                   |   9 +
 include/linux/bpf.h                           |   3 +
 include/linux/bpf_types.h                     |   3 +
 include/linux/landlock.h                      |  25 ++
 include/linux/lsm_hooks.h                     |   1 +
 include/uapi/linux/bpf.h                      |  23 +-
 include/uapi/linux/landlock.h                 |  39 +++
 include/uapi/linux/seccomp.h                  |   1 +
 kernel/bpf/syscall.c                          |   9 +
 kernel/bpf/verifier.c                         |  11 +
 kernel/seccomp.c                              |   4 +
 scripts/bpf_helpers_doc.py                    |   1 +
 security/Kconfig                              |   1 +
 security/Makefile                             |   2 +
 security/landlock/Kconfig                     |  19 ++
 security/landlock/Makefile                    |   6 +
 security/landlock/bpf_ptrace.c                |  98 +++++++
 security/landlock/bpf_ptrace.h                |  17 ++
 security/landlock/bpf_run.c                   |  62 ++++
 security/landlock/bpf_run.h                   |  25 ++
 security/landlock/bpf_verify.c                |  87 ++++++
 security/landlock/common.h                    |  84 ++++++
 security/landlock/domain_manage.c             | 265 ++++++++++++++++++
 security/landlock/domain_manage.h             |  23 ++
 security/landlock/domain_syscall.c            |  87 ++++++
 security/landlock/hooks_cred.c                |  47 ++++
 security/landlock/hooks_cred.h                |  14 +
 security/landlock/hooks_ptrace.c              | 114 ++++++++
 security/landlock/hooks_ptrace.h              |  19 ++
 security/landlock/init.c                      |  32 +++
 security/security.c                           |  15 +
 tools/include/uapi/linux/bpf.h                |  23 +-
 tools/include/uapi/linux/landlock.h           |  22 ++
 tools/lib/bpf/libbpf_probes.c                 |   3 +
 tools/testing/selftests/bpf/config            |   3 +
 tools/testing/selftests/bpf/test_verifier.c   |   1 +
 .../testing/selftests/bpf/verifier/landlock.c |  56 ++++
 tools/testing/selftests/landlock/.gitignore   |   5 +
 tools/testing/selftests/landlock/Makefile     |  27 ++
 tools/testing/selftests/landlock/config       |   5 +
 tools/testing/selftests/landlock/test.h       |  48 ++++
 tools/testing/selftests/landlock/test_base.c  |  24 ++
 .../testing/selftests/landlock/test_ptrace.c  | 210 ++++++++++++++
 47 files changed, 1875 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/security/landlock/index.rst
 create mode 100644 Documentation/security/landlock/kernel.rst
 create mode 100644 Documentation/security/landlock/user.rst
 create mode 100644 include/linux/landlock.h
 create mode 100644 include/uapi/linux/landlock.h
 create mode 100644 security/landlock/Kconfig
 create mode 100644 security/landlock/Makefile
 create mode 100644 security/landlock/bpf_ptrace.c
 create mode 100644 security/landlock/bpf_ptrace.h
 create mode 100644 security/landlock/bpf_run.c
 create mode 100644 security/landlock/bpf_run.h
 create mode 100644 security/landlock/bpf_verify.c
 create mode 100644 security/landlock/common.h
 create mode 100644 security/landlock/domain_manage.c
 create mode 100644 security/landlock/domain_manage.h
 create mode 100644 security/landlock/domain_syscall.c
 create mode 100644 security/landlock/hooks_cred.c
 create mode 100644 security/landlock/hooks_cred.h
 create mode 100644 security/landlock/hooks_ptrace.c
 create mode 100644 security/landlock/hooks_ptrace.h
 create mode 100644 security/landlock/init.c
 create mode 100644 tools/include/uapi/linux/landlock.h
 create mode 100644 tools/testing/selftests/bpf/verifier/landlock.c
 create mode 100644 tools/testing/selftests/landlock/.gitignore
 create mode 100644 tools/testing/selftests/landlock/Makefile
 create mode 100644 tools/testing/selftests/landlock/config
 create mode 100644 tools/testing/selftests/landlock/test.h
 create mode 100644 tools/testing/selftests/landlock/test_base.c
 create mode 100644 tools/testing/selftests/landlock/test_ptrace.c

-- 
2.23.0

