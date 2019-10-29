Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2885E8E5D
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 18:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfJ2Rj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 13:39:27 -0400
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:55501 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbfJ2Rj1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 13:39:27 -0400
X-Greylist: delayed 1166 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Oct 2019 13:35:48 EDT
Received: from smtp8.infomaniak.ch (smtp8.infomaniak.ch [83.166.132.38])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x9THFVp6006400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:15:31 +0100
Received: from localhost (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp8.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x9THFVsQ168934;
        Tue, 29 Oct 2019 18:15:31 +0100
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
Subject: [PATCH bpf-next v11 7/7] landlock: Add user and kernel documentation for Landlock
Date:   Tue, 29 Oct 2019 18:15:05 +0100
Message-Id: <20191029171505.6650-8-mic@digikod.net>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191029171505.6650-1-mic@digikod.net>
References: <20191029171505.6650-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This documentation can be built with the Sphinx framework.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: James Morris <jmorris@namei.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Will Drewry <wad@chromium.org>
---

Changes since v10:
* replace the filesystem hooks with the ptrace one
* remove the triggers
* update example
* add documenation for Landlock domains and seccomp interaction
* reference more kernel documenation (e.g. LSM hooks)

Changes since v9:
* update with expected attach type and expected attach triggers

Changes since v8:
* remove documentation related to chaining and tagging according to this
  patch series

Changes since v7:
* update documentation according to the Landlock revamp

Changes since v6:
* add a check for ctx->event
* rename BPF_PROG_TYPE_LANDLOCK to BPF_PROG_TYPE_LANDLOCK_RULE
* rename Landlock version to ABI to better reflect its purpose and add a
  dedicated changelog section
* update tables
* relax no_new_privs recommendations
* remove ABILITY_WRITE related functions
* reword rule "appending" to "prepending" and explain it
* cosmetic fixes

Changes since v5:
* update the rule hierarchy inheritance explanation
* briefly explain ctx->arg2
* add ptrace restrictions
* explain EPERM
* update example (subtype)
* use ":manpage:"
---
 Documentation/security/index.rst           |   1 +
 Documentation/security/landlock/index.rst  |  22 ++++
 Documentation/security/landlock/kernel.rst | 139 ++++++++++++++++++++
 Documentation/security/landlock/user.rst   | 142 +++++++++++++++++++++
 4 files changed, 304 insertions(+)
 create mode 100644 Documentation/security/landlock/index.rst
 create mode 100644 Documentation/security/landlock/kernel.rst
 create mode 100644 Documentation/security/landlock/user.rst

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index fc503dd689a7..4d213e76ddf4 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -15,3 +15,4 @@ Security Documentation
    self-protection
    siphash
    tpm/index
+   landlock/index
diff --git a/Documentation/security/landlock/index.rst b/Documentation/security/landlock/index.rst
new file mode 100644
index 000000000000..1eced757b05d
--- /dev/null
+++ b/Documentation/security/landlock/index.rst
@@ -0,0 +1,22 @@
+=========================================
+Landlock LSM: programmatic access control
+=========================================
+
+:Author: Mickaël Salaün
+
+Landlock is a stackable Linux Security Module (LSM) that makes it possible to
+create security sandboxes, programmable access-controls or safe endpoint
+security agents.  This kind of sandbox is expected to help mitigate the
+security impact of bugs or unexpected/malicious behaviors in user-space
+applications.  The current version allows only a process with the global
+CAP_SYS_ADMIN capability to create such sandboxes but the ultimate goal of
+Landlock is to empower any process, including unprivileged ones, to securely
+restrict themselves.  Landlock is inspired by seccomp-bpf but instead of
+filtering syscalls and their raw arguments, a Landlock rule can inspect the use
+of kernel objects like processes and hence make a decision according to the
+kernel semantic.
+
+.. toctree::
+
+    user
+    kernel
diff --git a/Documentation/security/landlock/kernel.rst b/Documentation/security/landlock/kernel.rst
new file mode 100644
index 000000000000..0be906f92c3e
--- /dev/null
+++ b/Documentation/security/landlock/kernel.rst
@@ -0,0 +1,139 @@
+==============================
+Landlock: kernel documentation
+==============================
+
+eBPF properties
+===============
+
+To get an expressive language while still being safe and small, Landlock is
+based on eBPF. Landlock should be usable by untrusted processes and must
+therefore expose a minimal attack surface. The eBPF bytecode is minimal,
+powerful, widely used and designed to be used by untrusted applications. Thus,
+reusing the eBPF support in the kernel enables a generic approach while
+minimizing new code.
+
+An eBPF program has access to an eBPF context containing some fields used to
+inspect the current object. These arguments may be used directly (e.g. raw
+value) or passed to helper functions according to their types (e.g. pointer).
+It is then possible to do complex access checks without race conditions or
+inconsistent evaluation (i.e.  `incorrect mirroring of the OS code and state
+<https://www.ndss-symposium.org/ndss2003/traps-and-pitfalls-practical-problems-system-call-interposition-based-security-tools/>`_).
+
+A Landlock hook describes a particular access type.  For now, there is one hook
+dedicated to ptrace related operations: BPF_LANDLOCK_PTRACE.  A Landlock
+program is tied to one hook.  This makes it possible to statically check
+context accesses, potentially performed by such program, and hence prevents
+kernel address leaks and ensure the right use of hook arguments with eBPF
+functions.  Any user can add multiple Landlock programs per Landlock hook.
+They are stacked and evaluated one after the other, starting from the most
+recent program, as seccomp-bpf does with its filters.  Underneath, a hook is an
+abstraction over a set of LSM hooks.
+
+
+Guiding principles
+==================
+
+Unprivileged use
+----------------
+
+* Landlock helpers and context should be usable by any unprivileged and
+  untrusted program while following the system security policy enforced by
+  other access control mechanisms (e.g. DAC, LSM), even if a global
+  CAP_SYS_ADMIN is currently required.
+
+
+Landlock hook and context
+-------------------------
+
+* A Landlock hook shall be focused on access control on kernel objects instead
+  of syscall filtering (i.e. syscall arguments), which is the purpose of
+  seccomp-bpf.
+* A Landlock context provided by a hook shall express the minimal and more
+  generic interface to control an access for a kernel object.
+* A hook shall guaranty that all the BPF function calls from a program are
+  safe.  Thus, the related Landlock context arguments shall always be of the
+  same type for a particular hook.  For example, a network hook could share
+  helpers with a file hook because of UNIX socket.  However, the same helpers
+  may not be compatible for a file system handle and a net handle.
+* Multiple hooks may use the same context interface.
+
+
+Landlock helpers
+----------------
+
+* Landlock helpers shall be as generic as possible while at the same time being
+  as simple as possible and following the syscall creation principles (cf.
+  *Documentation/adding-syscalls.txt*).
+* The only behavior change allowed on a helper is to fix a (logical) bug to
+  match the initial semantic.
+* Helpers shall be reentrant, i.e. only take inputs from arguments (e.g. from
+  the BPF context), to enable a hook to use a cache.  Future program options
+  might change this cache behavior.
+* It is quite easy to add new helpers to extend Landlock.  The main concern
+  should be about the possibility to leak information from the kernel that may
+  not be accessible otherwise (i.e. side-channel attack).
+
+
+Landlock domain
+===============
+
+A Landlock domain is a set of eBPF programs.  There is a list for each
+different program types that can be run on a specific Landlock hook (e.g.
+ptrace).  A domain is tied to a set of subjects (i.e. tasks).
+
+A Landlock program should not try (nor be able) to infer which subject is
+currently enforced, but to have a unique security policy for all subjects tied
+to the same domain.  This make the reasoning much easier and help avoid
+pitfalls.
+
+.. kernel-doc:: security/landlock/common.h
+    :functions: landlock_domain
+
+.. kernel-doc:: security/landlock/domain_manage.c
+    :functions: landlock_prepend_prog
+
+
+Adding a Landlock program with seccomp
+--------------------------------------
+
+The :manpage:`seccomp(2)` syscall can be used with the
+`SECCOMP_PREPEND_LANDLOCK_PROG` operation to prepend a Landlock program to the
+current task's domain.
+
+.. kernel-doc:: security/landlock/domain_syscall.c
+    :functions: landlock_seccomp_prepend_prog
+
+
+Running a list of Landlock programs
+-----------------------------------
+
+.. kernel-doc:: security/landlock/bpf_run.c
+    :functions: landlock_access_denied
+
+
+LSM hooks
+=========
+
+.. kernel-doc:: security/landlock/hooks_ptrace.c
+    :functions: hook_ptrace_access_check
+
+.. kernel-doc:: security/landlock/hooks_ptrace.c
+    :functions: hook_ptrace_traceme
+
+
+Questions and answers
+=====================
+
+Why a program does not return an errno or a kill code?
+------------------------------------------------------
+
+seccomp filters can return multiple kind of code, including an errno value or a
+kill signal, which may be convenient for access control.  Those return codes
+are hardwired in the userland ABI.  Instead, Landlock's approach is to return a
+bitmask to allow or deny an action, which is much simpler and more generic.
+Moreover, we do not really have a choice because, unlike to seccomp, Landlock
+programs are not enforced at the syscall entry point but may be executed at any
+point in the kernel (through LSM hooks) where an errno return code may not make
+sense.  However, with this simple ABI and with the ability to call helpers,
+Landlock may gain features similar to seccomp-bpf in the future while being
+compatible with previous programs.
diff --git a/Documentation/security/landlock/user.rst b/Documentation/security/landlock/user.rst
new file mode 100644
index 000000000000..e7aa9a260a86
--- /dev/null
+++ b/Documentation/security/landlock/user.rst
@@ -0,0 +1,142 @@
+================================
+Landlock: userland documentation
+================================
+
+Landlock programs
+=================
+
+eBPF programs are used to create security programs.  They are contained and can
+call only a whitelist of dedicated functions. Moreover, they can only loop
+under strict conditions, which protects from denial of service.  More
+information on BPF can be found in *Documentation/networking/filter.txt*.
+
+
+Writing a program
+-----------------
+
+To enforce a security policy, a thread first needs to create a Landlock
+program.  The easiest way to write an eBPF program depicting a security program
+is to write it in the C language.  As described in *samples/bpf/README.rst*,
+LLVM can compile such programs.  A simple eBPF program can also be written by
+hand has done in *tools/testing/selftests/landlock/*.
+
+Once the eBPF program is created, the next step is to create the metadata
+describing the Landlock program.  This metadata includes an expected attach
+type which contains the hook type to which the program is tied.
+
+A hook is a policy decision point which exposes the same context type for
+each program evaluation.
+
+A Landlock hook describes the kind of kernel object for which a program will be
+triggered to allow or deny an action.  For example, the hook
+BPF_LANDLOCK_PTRACE can be triggered every time a landlocked thread performs a
+set of action related to debugging (cf. :manpage:`ptrace(2)`) or if the kernel
+needs to know if a process manipulation requested by something else is
+legitimate.
+
+The next step is to fill a :c:type:`struct bpf_load_program_attr
+<bpf_load_program_attr>` with BPF_PROG_TYPE_LANDLOCK_HOOK, the expected attach
+type and other BPF program metadata.  This bpf_attr must then be passed to the
+:manpage:`bpf(2)` syscall alongside the BPF_PROG_LOAD command.  If everything
+is deemed correct by the kernel, the thread gets a file descriptor referring to
+this program.
+
+In the following code, the *insn* variable is an array of BPF instructions
+which can be extracted from an ELF file as is done in bpf_load_file() from
+*samples/bpf/bpf_load.c*.
+
+.. code-block:: c
+
+    int prog_fd;
+    struct bpf_load_program_attr load_attr;
+
+    memset(&load_attr, 0, sizeof(struct bpf_load_program_attr));
+    load_attr.prog_type = BPF_PROG_TYPE_LANDLOCK_HOOK;
+    load_attr.expected_attach_type = BPF_LANDLOCK_PTRACE;
+    load_attr.insns = insns;
+    load_attr.insns_cnt = sizeof(insn) / sizeof(struct bpf_insn);
+    load_attr.license = "GPL";
+
+    prog_fd = bpf_load_program_xattr(&load_attr, log_buf, log_buf_sz);
+    if (prog_fd == -1)
+        exit(1);
+
+
+Enforcing a program
+-------------------
+
+Once the Landlock program has been created or received (e.g. through a UNIX
+socket), the thread willing to sandbox itself (and its future children) should
+perform the following two steps.
+
+The thread should first request to never be allowed to get new privileges with a
+call to :manpage:`prctl(2)` and the PR_SET_NO_NEW_PRIVS option.  More
+information can be found in *Documentation/prctl/no_new_privs.txt*.
+
+.. code-block:: c
+
+    if (prctl(PR_SET_NO_NEW_PRIVS, 1, NULL, 0, 0))
+        exit(1);
+
+A thread can apply a program to itself by using the :manpage:`seccomp(2)` syscall.
+The operation is SECCOMP_PREPEND_LANDLOCK_PROG, the flags must be empty and the
+*args* argument must point to a valid Landlock program file descriptor.
+
+.. code-block:: c
+
+    if (seccomp(SECCOMP_PREPEND_LANDLOCK_PROG, 0, &fd))
+        exit(1);
+
+If the syscall succeeds, the program is now enforced on the calling thread and
+will be enforced on all its subsequently created children of the thread as
+well.  Once a thread is landlocked, there is no way to remove this security
+policy, only stacking more restrictions is allowed.  The program evaluation is
+performed from the newest to the oldest.
+
+When a syscall ask for an action on a kernel object, if this action is denied,
+then an EACCES errno code is returned through the syscall.
+
+
+.. _inherited_programs:
+
+Inherited programs
+------------------
+
+Every new thread resulting from a :manpage:`clone(2)` inherits Landlock program
+restrictions from its parent.  This is similar to the seccomp inheritance as
+described in *Documentation/prctl/seccomp_filter.txt* or any other LSM dealing
+with task's :manpage:`credentials(7)`.
+
+
+Ptrace restrictions
+-------------------
+
+A sandboxed process has less privileges than a non-sandboxed process and must
+then be subject to additional restrictions when manipulating another process.
+To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
+process, a sandboxed process should have a subset of the target process
+programs.  This security policy can easily be implemented like in
+*tools/testing/selftests/landlock/test_ptrace.c*.
+
+
+Landlock structures and constants
+=================================
+
+Contexts
+--------
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :functions: landlock_context_ptrace
+
+
+Return types
+------------
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :functions: landlock_ret
+
+
+Additional documentation
+========================
+
+See https://landlock.io
-- 
2.23.0

