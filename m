Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7519415F
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 15:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgCZO2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 10:28:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51649 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgCZO2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 10:28:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id c187so6705765wme.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2020 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W5Ff7Fn5bZi7i9uBczexSq34+wj8TN4wlXIgFvQuXvM=;
        b=jUN78QlK1G4YyVDyrmrvjDleFBmsR6d6nESaJYDRYFSLHcDfq/imq26Gaqgao6QV8q
         l9gC9uAsQvY68rUOoR7xf81WyogRP2hg2qA2D/xV9rDsRSpRHRe7CKcqqIob5dV/ENJM
         ogmbBIKmkvBn4MsaQ/UE0igYWjby2rKWlf2bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W5Ff7Fn5bZi7i9uBczexSq34+wj8TN4wlXIgFvQuXvM=;
        b=LEzJhMRwU5tmsvvNmY/bv2PaTxICbkyfKoSqX/CXJcrkh8837m0CxvrPjcnYH8Ig5C
         tKI+/qBQT8tn4NOZiDNHvQPm+1rWUzDp7EHvCyXNGZMyxPOLZuhPn+kN9yRxmNnIjHFX
         MhwoOjFN7cze/sWZ8OKlYsthbvk2fB2NwKYnSfFcTbVFW7E+ZpnozDobChl0/2b+YcIK
         tG5uShWnD9XAyko5pTn26hGuY4QiY1tdHfyg1p2GNQKJ76GcR2XPDQ4jy/t7UeNJEnEF
         3v80HyeN7jut2cf15PDhm7sY8OmFZ5VEIWOq4PHV0GrL9AtYL4HWpF6qeNp0XLykCkCg
         QTpQ==
X-Gm-Message-State: ANhLgQ0kjoCOo9cVQ+umFRHhJ+dyqMH4zWyzS/eFZ+8bD3LmifWHt/Vb
        jnK5NQq5f8sYz54PmcX4OFHgLw==
X-Google-Smtp-Source: ADFU+vvt623pdVGLa4tSnvVuUBz4uO2AQOo0BPKA3e1gQU7O41ZRqUIPW5OQRA+Lo9JpGl1YnooR/Q==
X-Received: by 2002:a1c:9e97:: with SMTP id h145mr205280wme.61.1585232924119;
        Thu, 26 Mar 2020 07:28:44 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id q3sm3643971wru.87.2020.03.26.07.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:28:43 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v7 8/8] bpf: lsm: Add Documentation
Date:   Thu, 26 Mar 2020 15:28:23 +0100
Message-Id: <20200326142823.26277-9-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326142823.26277-1-kpsingh@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
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
---
 Documentation/bpf/bpf_lsm.rst | 150 ++++++++++++++++++++++++++++++++++
 Documentation/bpf/index.rst   |   1 +
 2 files changed, 151 insertions(+)
 create mode 100644 Documentation/bpf/bpf_lsm.rst

diff --git a/Documentation/bpf/bpf_lsm.rst b/Documentation/bpf/bpf_lsm.rst
new file mode 100644
index 000000000000..2a2c3b4a74d4
--- /dev/null
+++ b/Documentation/bpf/bpf_lsm.rst
@@ -0,0 +1,150 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2020 Google LLC.
+
+================
+LSM BPF Programs
+================
+
+These BPF programs allow runtime instrumentation of the LSM hooks by privileged
+users to implement system-wide MAC (Mandatory Access Control) and Audit
+policies using eBPF. Since these program end up modifying the MAC policies of
+the system, they require both ``CAP_MAC_ADMIN`` and also require
+``CAP_SYS_ADMIN`` for the loading of BPF programs.
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
+.. note:: Only the size and the names of the fields must match the type in the
+	  kernel and the order of the fields is irrelevant.
+
+This can be further simplified (if one has access to the BTF information at
+build time) by generating the ``vmlinux.h`` with:
+
+.. code-block:: console
+
+        # bpftool dump file <path-to-btf-vmlinux> format c > vmlinux.h
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
+        SEC("lsm/file_mprotect")
+        int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
+                     unsigned long reqprot, unsigned long prot, int ret)
+	{
+                /* Ret is the return value from the previous BPF program
+                 * or 0 if it's the first hook.
+                 */
+                if (ret != 0)
+                        return ret;
+
+		int is_heap;
+
+		is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
+			   vma->vm_end <= vma->vm_mm->brk);
+
+		/* Return an -EPERM or write information to the perf events buffer
+		 * for auditing
+		 */
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
+``BPF_PROG_LOAD`` operation or more simply by using the the libbpf helper
+``bpf_prog_load_xattr``:
+
+
+.. code-block:: c
+
+	struct bpf_prog_load_attr attr = {
+		.file = "./prog.o",
+	};
+	struct bpf_object *prog_obj;
+	struct bpf_program *prog;
+	int prog_fd;
+
+	bpf_prog_load_xattr(&attr, &prog_obj, &prog_fd);
+
+Attachment to LSM Hooks
+-----------------------
+
+The LSM allows attachment of eBPF programs as LSM hooks using :manpage:`bpf(2)`
+syscall's ``BPF_PROG_ATTACH`` operation or more simply by
+using the libbpf helper ``bpf_program__attach_lsm``. In the code shown below
+``prog`` is the eBPF program loaded using ``BPF_PROG_LOAD``:
+
+.. code-block:: c
+
+	struct bpf_link *link;
+
+	link = bpf_program__attach_lsm(prog);
+
+The program can be detached from the LSM hook by *destroying* the ``link``
+link returned by ``bpf_program__attach_lsm``:
+
+.. code-block:: c
+
+	link->destroy();
+
+Examples
+--------
+
+An example eBPF programs can be found in
+`tools/testing/selftests/bpf/progs/lsm.c`_ and the corresponding
+userspace code in `tools/testing/selftests/bpf/prog_tests/test_lsm.c`_
+
+.. Links
+.. _tools/lib/bpf/bpf_tracing.h:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/lib/bpf/bpf_tracing.h
+.. _tools/testing/selftests/bpf/progs/lsm.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm.c
+.. _tools/testing/selftests/bpf/progs/lsm_void_hook.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm_void_hook.c
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

