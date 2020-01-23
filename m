Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5121C146CAC
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 16:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAWPZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 10:25:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35661 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgAWPZ2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:25:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1494715plt.2
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pm/qlmTwoj9xBcfQ8i56kTmB4d7npYdmRJjtPZEldNU=;
        b=iJEdOkp9cfyjO+r1ZPhPq6BQfndRotjgj/AyZ0IhQeZma1zlDm/prxLGkjAKuq+jSU
         VztkFXcfqQkIMMMmA3H7Axqgt6SbVjtCev+ZGBxXYncrDmU/p91nVIJTSoeuAWaZGDAE
         6+2R/e6AnUFN1R8KiKWai1QheA4mdgjx45spw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pm/qlmTwoj9xBcfQ8i56kTmB4d7npYdmRJjtPZEldNU=;
        b=prqVy75aSqsS82OgbhZ+4VBRNJDUvBnAYOlIJq6VQtZKpI+59T/wRT9PYnhxo2WBXc
         hes59oJ/PLBuFD+pJLjqkWHfdqq0awCbbdDsaDxACYVHDwRFzkKlyq24O55+Qj9tNhVA
         ZXA68MX3M0CYlN/MyYCq0rTDYjz6EcqSTbWyO1WKPXhF2HqXrDvGzDii8l3YAj4CuNuh
         /0gGyBIQhhv0GvrF5/ychfXEs21m8cgWRnemF+wJBaZsShbh4OCZZNE2mpXYCRoF/sn8
         ewVY0Og/MZstk9Ewxkm6fzl0+1yM2wguDQ6cXgohr47RUAjNUyGjp7496UVn98LJWQpN
         DafQ==
X-Gm-Message-State: APjAAAWhHT5HuepZZ5qCLVYyIH/Gj12y6xInQu+5eMre/KjCaqQFhyCh
        ah5l34a10ai/GQVruicpMKehtw==
X-Google-Smtp-Source: APXvYqwl+g5hqZiMHHCFU7voGkQ+34EMfRPBhV+Dei2UW4tlPjN55vZe/zGM4x3WKAYiWZHQOxQUnQ==
X-Received: by 2002:a17:902:524:: with SMTP id 33mr17242642plf.241.1579793127216;
        Thu, 23 Jan 2020 07:25:27 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id v5sm3108118pfn.122.2020.01.23.07.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:25:26 -0800 (PST)
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
Subject: [PATCH bpf-next v3 10/10] bpf: lsm: Add Documentation
Date:   Thu, 23 Jan 2020 07:24:40 -0800
Message-Id: <20200123152440.28956-11-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123152440.28956-1-kpsingh@chromium.org>
References: <20200123152440.28956-1-kpsingh@chromium.org>
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
 Documentation/security/bpf.rst   | 165 +++++++++++++++++++++++++++++++
 Documentation/security/index.rst |   1 +
 MAINTAINERS                      |   1 +
 3 files changed, 167 insertions(+)
 create mode 100644 Documentation/security/bpf.rst

diff --git a/Documentation/security/bpf.rst b/Documentation/security/bpf.rst
new file mode 100644
index 000000000000..ec7d147c83b2
--- /dev/null
+++ b/Documentation/security/bpf.rst
@@ -0,0 +1,165 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright 2019 Google LLC.
+
+==========================
+eBPF Linux Security Module
+==========================
+
+This LSM allows runtime instrumentation of the LSM hooks by privileged users to
+implement system-wide MAC (Mandatory Access Control) and Audit policies using
+eBPF. The LSM is privileged and stackable and requires both ``CAP_SYS_ADMIN``
+and ``CAP_MAC_ADMIN`` for the loading of BPF programs and modification of MAC
+policies respectively.
+
+eBPF Programs
+==============
+
+`eBPF (extended BPF) <https://cilium.readthedocs.io/en/latest/bpf>`_ is a
+virtual machine-like construct in the Linux Kernel allowing the execution of
+verifiable, just-in-time compiled byte code at various points in the Kernel.
+
+The eBPF LSM adds a new type, ``BPF_PROG_TYPE_LSM``, of eBPF programs which
+have the following characteristics:
+
+   * Multiple eBPF programs can be attached to the same LSM hook
+   * The programs are always run after the static hooks (i.e. the ones
+     registered by SELinux, AppArmor, Smack etc.)
+   * LSM hooks can return an ``-EPERM`` to indicate the decision of the
+     MAC policy being enforced (``CONFIG_SECURITY_BPF_ENFORCE``) or
+     simply be used for auditing.
+   * If ``CONFIG_SECURITY_BPF_ENFORCE`` is enabled and a non-zero error
+     code is returned from the BPF program, no further BPF programs for
+     the hook are executed
+   * Allowing the eBPF programs to be attached to all the LSM hooks by
+     making :doc:`/bpf/btf` type information available for all LSM hooks
+     and allowing the BPF verifier to perform runtime relocations and
+     validation on the programs
+
+Structure
+---------
+
+The example shows an eBPF program that can be attached to the ``file_mprotect``
+LSM hook:
+
+.. c:function:: int file_mprotect(struct vm_area_struct *vma, unsigned long reqprot, unsigned long prot);
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
+The ``vmlinux.h`` can then simply be included in the BPF programs wihtout
+requiring the definition of the the types.
+
+The eBPF programs can be declared using the``BPF_PROG``
+macros defined in `tools/testing/selftests/bpf/bpf_trace_helpers.h`_. In this
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
+                     unsigned long reqprot, unsigned long prot)
+	{
+		int is_heap;
+
+		is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
+			   vma->vm_end <= vma->vm_mm->brk);
+
+		/*
+		 * Return an -EPERM or write information to the perf events buffer
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
+eBPP programs can be loaded with the :manpage:`bpf(2)` syscall's
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
+An example eBPF program can be found in
+`tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c`_ and the corresponding
+userspace code in
+`tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c`_
+
+.. Links
+.. _tools/testing/selftests/bpf/bpf_trace_helpers.h:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/selftests/bpf/bpf_trace_helpers.h
+.. _tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
+.. _tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index fc503dd689a7..844463df4547 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -5,6 +5,7 @@ Security Documentation
 .. toctree::
    :maxdepth: 1
 
+   bpf
    credentials
    IMA-templates
    keys/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 32236d89d00b..e1de1a345205 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3213,6 +3213,7 @@ F:	include/linux/bpf_lsm.h
 F:	tools/testing/selftests/bpf/lsm_helpers.h
 F:	tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
 F:	tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
+F:	Documentation/security/bpf.rst
 
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
-- 
2.20.1

