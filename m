Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AC196A5E
	for <lists+bpf@lfdr.de>; Sun, 29 Mar 2020 01:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgC2AoS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Mar 2020 20:44:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42252 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgC2AoL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Mar 2020 20:44:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so16567564wrx.9
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2020 17:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZCJESVWL3nHGbQE99gL9GwjtKKOUZwGHm1zDWXXUHs=;
        b=cNiZTryPs+44n+r8Q0aGpw/DPzm93aVoB1Gcrkttir78O4sEHS33GDArJ+SU5gveqK
         j3o8KP2jqhN8RBjgcttNn0GeOATrEh1OnOR4zYhMz3tBNikapjp33MBT2bHZnPMb3mrm
         wwhC4C10vEekDIH7jw464ff5bOkgvLeVZFt4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZCJESVWL3nHGbQE99gL9GwjtKKOUZwGHm1zDWXXUHs=;
        b=ByobOyv7bg06X5J5caoOYKZ4BdOWW/s4AJE4bB7Y0J97SvXcam4xyaC+EWoGzC+VKT
         Y5Q+t96iDBmoyVwE8MyFkN9eyiu+LoVOHlMjY6TU+ZH8fHGxT7OTTO3ivYd+SbcvOmMN
         XYM24/9ROqf5ye8K0ixlZKPa7+au+5724NMFincO0QezAxiQi/ZjvOwB7efG3cYAic9A
         h18Rxuq50zQ9tnIHEbeEkfLQmdKf4DAfXh76MzfibmgHjj0idCBniU0338E1jUmaI3lF
         zbCLsZK5sPLoledpiHjSjjzI+Sh5/g3IkcrRBvXb3ApE3Rq4OKZYvLQ/7OpJDV+lCx/T
         CGJw==
X-Gm-Message-State: ANhLgQ1Erytte38rt3NEVDV4nZ5O/l9QMc5L9P2kWkRRw93m5owuox87
        vdvVxrjN3BvpwcySTxLFck32cQ==
X-Google-Smtp-Source: ADFU+vte5lHHD9uTGa5XD2B4lsTSofLkANVBQD8ABPhqpJ/t1C6Bcs7dKv4lsuKWoKP8ZtH9LbxX+Q==
X-Received: by 2002:a5d:664d:: with SMTP id f13mr6891598wrw.51.1585442649692;
        Sat, 28 Mar 2020 17:44:09 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id e5sm14577647wru.92.2020.03.28.17.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 17:44:09 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v9 8/8] bpf: lsm: Add Documentation
Date:   Sun, 29 Mar 2020 01:43:56 +0100
Message-Id: <20200329004356.27286-9-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200329004356.27286-1-kpsingh@chromium.org>
References: <20200329004356.27286-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Document how eBPF programs (BPF_PROG_TYPE_LSM) can be loaded and
attached (BPF_LSM_MAC) to the LSM hooks.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
---
 Documentation/bpf/bpf_lsm.rst | 142 ++++++++++++++++++++++++++++++++++
 Documentation/bpf/index.rst   |   1 +
 2 files changed, 143 insertions(+)
 create mode 100644 Documentation/bpf/bpf_lsm.rst

diff --git a/Documentation/bpf/bpf_lsm.rst b/Documentation/bpf/bpf_lsm.rst
new file mode 100644
index 000000000000..1c0a75a51d79
--- /dev/null
+++ b/Documentation/bpf/bpf_lsm.rst
@@ -0,0 +1,142 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2020 Google LLC.
+
+================
+LSM BPF Programs
+================
+
+These BPF programs allow runtime instrumentation of the LSM hooks by privileged
+users to implement system-wide MAC (Mandatory Access Control) and Audit
+policies using eBPF.
+
+Structure
+---------
+
+The example shows an eBPF program that can be attached to the ``file_mprotect``
+LSM hook:
+
+.. c:function:: int file_mprotect(struct vm_area_struct *vma, unsigned long reqprot, unsigned long prot);
+
+Other LSM hooks which can be instrumented can be found in
+``include/linux/lsm_hooks.h``.
+
+eBPF programs that use :doc:`/bpf/btf` do not need to include kernel headers
+for accessing information from the attached eBPF program's context. They can
+simply declare the structures in the eBPF program and only specify the fields
+that need to be accessed.
+
+.. code-block:: c
+
+	struct mm_struct {
+		unsigned long start_brk, brk, start_stack;
+	} __attribute__((preserve_access_index));
+
+	struct vm_area_struct {
+		unsigned long start_brk, brk, start_stack;
+		unsigned long vm_start, vm_end;
+		struct mm_struct *vm_mm;
+	} __attribute__((preserve_access_index));
+
+
+.. note:: The order of the fields is irrelevant.
+
+This can be further simplified (if one has access to the BTF information at
+build time) by generating the ``vmlinux.h`` with:
+
+.. code-block:: console
+
+	# bpftool btf dump file <path-to-btf-vmlinux> format c > vmlinux.h
+
+.. note:: ``path-to-btf-vmlinux`` can be ``/sys/kernel/btf/vmlinux`` if the
+	  build environment matches the environment the BPF programs are
+	  deployed in.
+
+The ``vmlinux.h`` can then simply be included in the BPF programs without
+requiring the definition of the types.
+
+The eBPF programs can be declared using the``BPF_PROG``
+macros defined in `tools/lib/bpf/bpf_tracing.h`_. In this
+example:
+
+	* ``"lsm/file_mprotect"`` indicates the LSM hook that the program must
+	  be attached to
+	* ``mprotect_audit`` is the name of the eBPF program
+
+.. code-block:: c
+
+	SEC("lsm/file_mprotect")
+	int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
+		     unsigned long reqprot, unsigned long prot, int ret)
+	{
+		/* ret is the return value from the previous BPF program
+		 * or 0 if it's the first hook.
+		 */
+		if (ret != 0)
+			return ret;
+
+		int is_heap;
+
+		is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
+			   vma->vm_end <= vma->vm_mm->brk);
+
+		/* Return an -EPERM or write information to the perf events buffer
+		 * for auditing
+		 */
+		if (is_heap)
+			return -EPERM;
+	}
+
+The ``__attribute__((preserve_access_index))`` is a clang feature that allows
+the BPF verifier to update the offsets for the access at runtime using the
+:doc:`/bpf/btf` information. Since the BPF verifier is aware of the types, it
+also validates all the accesses made to the various types in the eBPF program.
+
+Loading
+-------
+
+eBPF programs can be loaded with the :manpage:`bpf(2)` syscall's
+``BPF_PROG_LOAD`` operation:
+
+.. code-block:: c
+
+	struct bpf_object *obj;
+
+	obj = bpf_object__open("./my_prog.o");
+	bpf_object__load(obj);
+
+This can be simplified by using a skeleton header generated by ``bpftool``:
+
+.. code-block:: console
+
+	# bpftool gen skeleton my_prog.o > my_prog.skel.h
+
+and the program can be loaded by including ``my_prog.skel.h`` and using
+the generated helper, ``my_prog__open_and_load``.
+
+Attachment to LSM Hooks
+-----------------------
+
+The LSM allows attachment of eBPF programs as LSM hooks using :manpage:`bpf(2)`
+syscall's ``BPF_RAW_TRACEPOINT_OPEN`` operation or more simply by
+using the libbpf helper ``bpf_program__attach_lsm``.
+
+The program can be detached from the LSM hook by *destroying* the ``link``
+link returned by ``bpf_program__attach_lsm`` using ``bpf_link__destroy``.
+
+One can also use the helpers generated in ``my_prog.skel.h`` i.e.
+``my_prog__attach`` for attachment and ``my_prog__destroy`` for cleaning up.
+
+Examples
+--------
+
+An example eBPF program can be found in
+`tools/testing/selftests/bpf/progs/lsm.c`_ and the corresponding
+userspace code in `tools/testing/selftests/bpf/prog_tests/test_lsm.c`_
+
+.. Links
+.. _tools/lib/bpf/bpf_tracing.h:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/lib/bpf/bpf_tracing.h
+.. _tools/testing/selftests/bpf/progs/lsm.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm.c
+.. _tools/testing/selftests/bpf/prog_tests/test_lsm.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/test_lsm.c
diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 7be43c5f2dcf..f99677f3572f 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -45,6 +45,7 @@ Program types
    prog_cgroup_sockopt
    prog_cgroup_sysctl
    prog_flow_dissector
+   bpf_lsm
 
 
 Testing and debugging BPF
-- 
2.20.1

