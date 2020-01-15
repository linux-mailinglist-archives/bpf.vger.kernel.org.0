Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA2213CA98
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 18:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgAORNg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 12:13:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50565 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbgAORNf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 12:13:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so775909wmb.0
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 09:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irVenSBk+qsWtPOnLfffjUTanFCczadJPyzi1GpXUI4=;
        b=a//MelKGTTeEPFAZ8QADS5Z8uj/uFdQChD92Dj6apjnnBYpt9gKl/YmEguk6YRTFPv
         SFUzm3VB9+TvPOnNrtNxJeNRxKSVNjTKfGxIotIxfbJNp4b/gR3ib679Xl3FWX2JWOal
         acK9dmUlomW7rFWZ/X8zGHyyO8WSv8g5xez3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irVenSBk+qsWtPOnLfffjUTanFCczadJPyzi1GpXUI4=;
        b=Mat88mO3QykkqFsRyxSS2dZ6YF2z/Ql0PUD7hvl7gZHi8Si4QNIVfXV/7Wdzgi6u3J
         eyiq56HTCSInf93oU6s2thxhV//Blpin4edaCzIpuhjBwB/5epjwT24xnKc7NH1BuGrf
         bdoCC+8xBGc4w6s4zsh2q4KUldFjNyn7KgaU03BD8ktKcMnPhJ8FjQd1/Syjk4NQJ4fv
         ksD7ZjeHq/1WSSyveB5R9cbYSS8kDsD3dAkMbRJI0tdL1wfpGDgH2Bzl8hR74Oew9ZyE
         z8KJjpmdRng6eypK0IdIGXixfdEJoVsRGE2MkzH8g4BI+NSDSRQWQOqwbM4TWbrN6QwG
         8Apw==
X-Gm-Message-State: APjAAAW5KlBKDikepPIMzJRX32AtzEIy3UaG1ffK+YNLziPjMntxXWk9
        laD8OE/WgsUevBB9n8qLIva7DA==
X-Google-Smtp-Source: APXvYqyq8Y0listaQwfuHlfsGtWorsrBUDEQxn03dRh8XEsYAWMqFyOm7c4bfHb/zSQJFrYZ0loj6w==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr942072wma.5.1579108412501;
        Wed, 15 Jan 2020 09:13:32 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:84f3:4331:4ae9:c5f1])
        by smtp.gmail.com with ESMTPSA id d16sm26943227wrg.27.2020.01.15.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:13:32 -0800 (PST)
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
Subject: [PATCH bpf-next v2 10/10] bpf: lsm: Add Documentation
Date:   Wed, 15 Jan 2020 18:13:33 +0100
Message-Id: <20200115171333.28811-11-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115171333.28811-1-kpsingh@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
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
---
 Documentation/security/bpf.rst   | 150 +++++++++++++++++++++++++++++++
 Documentation/security/index.rst |   1 +
 MAINTAINERS                      |   1 +
 3 files changed, 152 insertions(+)
 create mode 100644 Documentation/security/bpf.rst

diff --git a/Documentation/security/bpf.rst b/Documentation/security/bpf.rst
new file mode 100644
index 000000000000..4d115c07c370
--- /dev/null
+++ b/Documentation/security/bpf.rst
@@ -0,0 +1,150 @@
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
+	* Multiple eBPF programs can be attached to the same LSM hook
+	* The programs are always run after the static hooks (i.e. the ones
+	  registered by SELinux, AppArmor, Smack etc.)
+	* LSM hooks can return an ``-EPERM`` to indicate the decision of the
+	  MAC policy being enforced or simply be used for auditing
+	* If ``CONFIG_SECURITY_BPF_ENFORCE`` is enabled and a non-zero error
+	  code is returned from the BPF program, no further BPF programs for the hook are executed
+	* Allowing the eBPF programs to be attached to all the LSM hooks by
+	  making :doc:`/bpf/btf` type information available for all LSM hooks
+	  and allowing the BPF verifier to perform runtime relocations and
+	  validation on the programs
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
+The eBPF programs can be declared using macros similar to the ``BPF_TRACE_<N>``
+macros defined in `tools/testing/selftests/bpf/bpf_trace_helpers.h`_. In this
+example:
+
+	* The LSM hook takes 3 args so we use ``BPF_TRACE_3``
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
index 5d553c2e7452..dd4c4ee151b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3212,6 +3212,7 @@ F:	security/bpf/
 F:	include/linux/bpf_lsm.h
 F:	tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
 F:	tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
+F:	Documentation/security/bpf.rst
 
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
-- 
2.20.1

