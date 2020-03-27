Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9532F195EBB
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 20:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgC0T3M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 15:29:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41785 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgC0T3J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 15:29:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so12825956wrc.8
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZCJESVWL3nHGbQE99gL9GwjtKKOUZwGHm1zDWXXUHs=;
        b=aHPrseK3JaDguRzArN0PJP5nwfuYxKSPi6hrE+kFX9ngCKhe/moTRKa80hi0yDwXMa
         3dg1z4ce26oqoHOZZBeJ7fZdU+3PDRxun8cfMemUucnbPzp/JfhM9rLRn8bVa368M2sk
         t7lqCNCeW/NuCwsNhuqjH/5/eHiyI6zbJmFD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZCJESVWL3nHGbQE99gL9GwjtKKOUZwGHm1zDWXXUHs=;
        b=HZQg00jDIEJoGM/F4vTYkHQVlHenqlKdnNFI8j73KvGkPGNHcj2LK9qD6RDPZUZQ0P
         /G8IsWy0KRjzD5ekJcIwntj3x+hO7BB+ZefnKQJyxezUqGFipuczNnNQnHUZSpcGjNkb
         Og02jAteArDb2cMueIUbA/1/DOwLsc8bZI32Dvx4R+WVPuuNK1kZzinymMO3AIslbliR
         oXh0jzvyI/hrntejL+XCnqmJB9Km1bxzlGKra1ZZY9DdoodYGnti6tN+la0SPAziZ2ww
         hgE7HZv2YgwrlaoBz4bXVmN+olV06sc8TgZFdwgvjiLdhM3hLKFUmIbNXuU1F89GA8ra
         fq8g==
X-Gm-Message-State: ANhLgQ1rlGLRCBGnVSPEowslE0EJ4ua2muFzqxLm+zZGU2pL288QzNKb
        Ek4V4ExTyMAiE4uynre/Qq1fQQ==
X-Google-Smtp-Source: ADFU+vtVANcpITCNMzWhRAN5CeoIamlwBKD9HskxOe7SVXX+gFqM7Kb4GzQaJl4GQ1AU3qbm8eqgnQ==
X-Received: by 2002:adf:ff82:: with SMTP id j2mr1025324wrr.48.1585337347182;
        Fri, 27 Mar 2020 12:29:07 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id h132sm9828537wmf.18.2020.03.27.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:29:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 8/8] bpf: lsm: Add Documentation
Date:   Fri, 27 Mar 2020 20:28:54 +0100
Message-Id: <20200327192854.31150-9-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327192854.31150-1-kpsingh@chromium.org>
References: <20200327192854.31150-1-kpsingh@chromium.org>
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

