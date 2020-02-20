Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D0D166561
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 18:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgBTRxH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 12:53:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37370 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgBTRxH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 12:53:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so5644264wru.4
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkZvckj4wnd1GhrUFR4okZmuZW+gAsxm+Y3ZecxjX+A=;
        b=oCXJA4iNDMJxI4eWXQms3Gpam17Cx4cXzNmACSL20BsHLoBsuXKXw+elnAC4MaGHcz
         Ogce6XK20NWPQ4qlBWhz6lRkorjh5ReCH9dqRW7c0sgzLFJFpjwGmUoenu2UvDeeEDjt
         mPlMQo2YqLlQ+p+AEvTOCkwIpPZ/5MMyldPuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkZvckj4wnd1GhrUFR4okZmuZW+gAsxm+Y3ZecxjX+A=;
        b=mQmeiHZ7byZkpQkvmKZAibhQe+gBZpD4sUvev4D1MzterZl+5okvfYLGUz+GqxflKh
         FIAXvpNEdJy4rOQLfc3AheLAgTTn2qgmwsOurZUrIcLAezi2gIi08/gNeksu/5JmAuNG
         NaKO/+ti4ntfqY2ICBnc5R1YEw0w9V0u3DNKXAYyYD6UnYyiObY6tM/fiToEXtUGyEVo
         4Q347jtJe4IUAZC039WE/bQsUS1KHpRJUoI9sl8/C4KNhodA+FKH9vQ/AfyvffNX9KGW
         afGDVv0kpyZHojbhoTDBaeRMKE13UpHN9foFrPY1/1KvvNo0WcenvwsAzbTPpDgnCFSd
         50xA==
X-Gm-Message-State: APjAAAWLux4DYnFRRTG7dcMCPrCvN894Njw/uqJK57Z+U3jkoR7oyNtK
        Jyuwe5YDPeFhlDllcTgFAFbuGw==
X-Google-Smtp-Source: APXvYqyoc0OvbZCWrmRmpqkKnCqwRB6+BRIPlIZP00OzqvEkOYVHJsqch1rLLWmle5n5duAaiaT42g==
X-Received: by 2002:adf:f283:: with SMTP id k3mr41832141wro.69.1582221184726;
        Thu, 20 Feb 2020 09:53:04 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:d960:542a:a1d:648a])
        by smtp.gmail.com with ESMTPSA id r5sm363059wrt.43.2020.02.20.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:53:04 -0800 (PST)
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
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v4 8/8] bpf: lsm: Add Documentation
Date:   Thu, 20 Feb 2020 18:52:50 +0100
Message-Id: <20200220175250.10795-9-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220175250.10795-1-kpsingh@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
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
 Documentation/bpf/bpf_lsm.rst | 147 ++++++++++++++++++++++++++++++++++
 Documentation/bpf/index.rst   |   1 +
 2 files changed, 148 insertions(+)
 create mode 100644 Documentation/bpf/bpf_lsm.rst

diff --git a/Documentation/bpf/bpf_lsm.rst b/Documentation/bpf/bpf_lsm.rst
new file mode 100644
index 000000000000..9d7ec8cb431d
--- /dev/null
+++ b/Documentation/bpf/bpf_lsm.rst
@@ -0,0 +1,147 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright 2019 Google LLC.
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
+Example eBPF programs can be found in
+`tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c`_ and `tools/testing/selftests/bpf/progs/lsm_mprotect_mac.c`_ and the corresponding
+userspace code in `tools/testing/selftests/bpf/prog_tests/lsm_mprotect.c`_
+
+.. Links
+.. _tools/testing/selftests/bpf/bpf_trace_helpers.h:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/selftests/bpf/bpf_trace_helpers.h
+.. _tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
+.. _tools/testing/selftests/bpf/progs/lsm_mprotect_mac.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm_mprotect_mac.c
+.. _tools/testing/selftests/bpf/prog_tests/lsm_mprotect.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/lsm_mprotect.c
diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 4f5410b61441..2c3d3c0cb7bb 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -45,6 +45,7 @@ Program types
    prog_cgroup_sockopt
    prog_cgroup_sysctl
    prog_flow_dissector
+   bpf_lsm
 
 
 Testing BPF
-- 
2.20.1

