Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E8F3ACD0E
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 16:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhFROHf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhFROHf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 10:07:35 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B83C06175F;
        Fri, 18 Jun 2021 07:05:25 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id g19so717113qvx.12;
        Fri, 18 Jun 2021 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a508cxmJ8BbQ6PvxZBmVZwYXCufbRzWcf4XqrLdaMqg=;
        b=IdTjaAvlIODgNunyEPAOvGD2yo43KcE/FyrK7Nh/A61SKphzAB0PzBszPFv9dwJ4Aq
         1TCwnYo+5/U6lFwYwMKRYscBTWP5YMc0TG55LQ9hYwpo/qc2Jv+3aJuA1ZBqBeigQC0G
         xF1VwhK+Kp7JQXM+kFCjQFUpz9PiDPylB0aJlkNaXsqRpuX8t65sAaA4Rj8ElEum/OUK
         z1eOm4wvPM5CprdORcteuMhlCHAM18pAsoTCKZ4TIt7dQuyFx908tSSnD9gcoLon/B8R
         VzDrhNJdZid/sBjObnyphrl+GrdQL9ddXMYLbycOAB+NrnaWYm9frTvyO2td3v0adf88
         IEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a508cxmJ8BbQ6PvxZBmVZwYXCufbRzWcf4XqrLdaMqg=;
        b=lK64wiF1nnVLey92eu91EaDELEnw8KtB8XYM9vg+IGBkKF/J4xUskPlKGFJTLVNeaw
         T/t0mF0/h5U0gjEUe6CQRvs2eN5uMpJ+kxZnMbfEGON5xydIKqDXjt3knxrNlpwEOhgR
         JrjpJO/jY44pkGWIOnvdggJPO4UizF+DHg1g7tUPPHEfN74LNJpIQlDtVzTGmZ/75Dzx
         MiBcXdR6AotN5fNDNKVV2Xb9oJWNqKQ8gJjC+dTmqEFKlBWb2YnKDLhHfdvGgRzByThf
         nblOi4dmkAeWMt0hBcYVlkbjmrqLvREgEmSgcXg7VCziKmtUhQcA716Ud9Kq1/EkR91K
         ZzvQ==
X-Gm-Message-State: AOAM530rbYMNEuYGUOItpsmxq8yYSwK5lDdemhAizrNmB26wqVCOZtRm
        90+lcSz1HPWl9CZlw/Pd4gE=
X-Google-Smtp-Source: ABdhPJz9do0Ri71ZA8dUwSHCezOT06nPA/0tWYdtYuDHtvU8yDWaTOgLOdSYgvknBQSyowdtKNJnOg==
X-Received: by 2002:a05:6214:18d0:: with SMTP id cy16mr5736333qvb.29.1624025124823;
        Fri, 18 Jun 2021 07:05:24 -0700 (PDT)
Received: from localhost.localdomain (pool-108-54-205-133.nycmny.fios.verizon.net. [108.54.205.133])
        by smtp.gmail.com with ESMTPSA id t30sm3974078qkm.11.2021.06.18.07.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 07:05:24 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, grantseltzer@gmail.com,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 1/1] Add documentation for libbpf including API autogen
Date:   Fri, 18 Jun 2021 14:04:59 +0000
Message-Id: <20210618140459.9887-2-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210618140459.9887-1-grantseltzer@gmail.com>
References: <20210618140459.9887-1-grantseltzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds rst files containing documentation for libbpf. This includes
the addition of libbpf_api.rst which pulls comment documentation from
header files in libbpf under tools/lib/bpf/. The comment docs would be
of the standard kernel doc format.

Signed-off-by: grantseltzer <grantseltzer@gmail.com>
---
 Documentation/bpf/index.rst                   | 13 +++++++
 Documentation/bpf/libbpf/libbpf.rst           | 14 +++++++
 Documentation/bpf/libbpf/libbpf_api.rst       | 27 ++++++++++++++
 Documentation/bpf/libbpf/libbpf_build.rst     | 37 +++++++++++++++++++
 .../bpf/libbpf/libbpf_naming_convention.rst   | 30 ++++++---------
 5 files changed, 103 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/bpf/libbpf/libbpf.rst
 create mode 100644 Documentation/bpf/libbpf/libbpf_api.rst
 create mode 100644 Documentation/bpf/libbpf/libbpf_build.rst
 rename tools/lib/bpf/README.rst => Documentation/bpf/libbpf/libbpf_naming_convention.rst (90%)

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index a702f67dd..319b06a7a 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -12,6 +12,19 @@ BPF instruction-set.
 The Cilium project also maintains a `BPF and XDP Reference Guide`_
 that goes into great technical depth about the BPF Architecture.
 
+libbpf
+======
+
+Libbpf is a userspace library for loading and interacting with bpf programs.
+
+.. toctree::
+   :maxdepth: 1
+
+   libbpf/libbpf
+   libbpf/libbpf_api
+   libbpf/libbpf_build
+   libbpf/libbpf_naming_convention
+
 BPF Type Format (BTF)
 =====================
 
diff --git a/Documentation/bpf/libbpf/libbpf.rst b/Documentation/bpf/libbpf/libbpf.rst
new file mode 100644
index 000000000..1b1e61d5e
--- /dev/null
+++ b/Documentation/bpf/libbpf/libbpf.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+libbpf
+======
+
+This is documentation for libbpf, a userspace library for loading and
+interacting with bpf programs.
+
+All general BPF questions, including kernel functionality, libbpf APIs and
+their application, should be sent to bpf@vger.kernel.org mailing list.
+You can `subscribe <http://vger.kernel.org/vger-lists.html#bpf>`_ to the
+mailing list search its `archive <https://lore.kernel.org/bpf/>`_.
+Please search the archive before asking new questions. It very well might
+be that this was already addressed or answered before.
diff --git a/Documentation/bpf/libbpf/libbpf_api.rst b/Documentation/bpf/libbpf/libbpf_api.rst
new file mode 100644
index 000000000..f07eecd05
--- /dev/null
+++ b/Documentation/bpf/libbpf/libbpf_api.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+API
+===
+
+This documentation is autogenerated from header files in libbpf, tools/lib/bpf
+
+.. kernel-doc:: tools/lib/bpf/libbpf.h
+   :internal:
+
+.. kernel-doc:: tools/lib/bpf/bpf.h
+   :internal:
+
+.. kernel-doc:: tools/lib/bpf/btf.h
+   :internal:
+
+.. kernel-doc:: tools/lib/bpf/xsk.h
+   :internal:
+
+.. kernel-doc:: tools/lib/bpf/bpf_tracing.h
+   :internal:
+
+.. kernel-doc:: tools/lib/bpf/bpf_core_read.h
+   :internal:
+
+.. kernel-doc:: tools/lib/bpf/bpf_endian.h
+   :internal:
\ No newline at end of file
diff --git a/Documentation/bpf/libbpf/libbpf_build.rst b/Documentation/bpf/libbpf/libbpf_build.rst
new file mode 100644
index 000000000..8e8c23e80
--- /dev/null
+++ b/Documentation/bpf/libbpf/libbpf_build.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+Building libbpf
+===============
+
+libelf and zlib are internal dependencies of libbpf and thus are required to link
+against and must be installed on the system for applications to work.
+pkg-config is used by default to find libelf, and the program called
+can be overridden with PKG_CONFIG.
+
+If using pkg-config at build time is not desired, it can be disabled by
+setting NO_PKG_CONFIG=1 when calling make.
+
+To build both static libbpf.a and shared libbpf.so:
+
+.. code-block:: bash
+
+    $ cd src
+    $ make
+
+To build only static libbpf.a library in directory build/ and install them
+together with libbpf headers in a staging directory root/:
+
+.. code-block:: bash
+
+    $ cd src
+    $ mkdir build root
+    $ BUILD_STATIC_ONLY=y OBJDIR=build DESTDIR=root make install
+
+To build both static libbpf.a and shared libbpf.so against a custom libelf
+dependency installed in /build/root/ and install them together with libbpf
+headers in a build directory /build/root/:
+
+.. code-block:: bash
+
+    $ cd src
+    $ PKG_CONFIG_PATH=/build/root/lib64/pkgconfig DESTDIR=/build/root make
\ No newline at end of file
diff --git a/tools/lib/bpf/README.rst b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
similarity index 90%
rename from tools/lib/bpf/README.rst
rename to Documentation/bpf/libbpf/libbpf_naming_convention.rst
index 8928f7787..3de1d51e4 100644
--- a/tools/lib/bpf/README.rst
+++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
-libbpf API naming convention
-============================
+API naming convention
+=====================
 
 libbpf API provides access to a few logically separated groups of
 functions and types. Every group has its own naming convention
@@ -10,14 +10,14 @@ new function or type is added to keep libbpf API clean and consistent.
 
 All types and functions provided by libbpf API should have one of the
 following prefixes: ``bpf_``, ``btf_``, ``libbpf_``, ``xsk_``,
-``perf_buffer_``.
+``btf_dump_``, ``ring_buffer_``, ``perf_buffer_``.
 
 System call wrappers
 --------------------
 
 System call wrappers are simple wrappers for commands supported by
 sys_bpf system call. These wrappers should go to ``bpf.h`` header file
-and map one-on-one to corresponding commands.
+and map one to one to corresponding commands.
 
 For example ``bpf_map_lookup_elem`` wraps ``BPF_MAP_LOOKUP_ELEM``
 command of sys_bpf, ``bpf_prog_attach`` wraps ``BPF_PROG_ATTACH``, etc.
@@ -49,10 +49,6 @@ object, ``bpf_object``, double underscore and ``open`` that defines the
 purpose of the function to open ELF file and create ``bpf_object`` from
 it.
 
-Another example: ``bpf_program__load`` is named for corresponding
-object, ``bpf_program``, that is separated from other part of the name
-by double underscore.
-
 All objects and corresponding functions other than BTF related should go
 to ``libbpf.h``. BTF types and functions should go to ``btf.h``.
 
@@ -72,11 +68,7 @@ of both low-level ring access functions and high-level configuration
 functions. These can be mixed and matched. Note that these functions
 are not reentrant for performance reasons.
 
-Please take a look at Documentation/networking/af_xdp.rst in the Linux
-kernel source tree on how to use XDP sockets and for some common
-mistakes in case you do not get any traffic up to user space.
-
-libbpf ABI
+ABI
 ==========
 
 libbpf can be both linked statically or used as DSO. To avoid possible
@@ -116,7 +108,8 @@ This bump in ABI version is at most once per kernel development cycle.
 
 For example, if current state of ``libbpf.map`` is:
 
-.. code-block::
+.. code-block:: c
+
         LIBBPF_0.0.1 {
         	global:
                         bpf_func_a;
@@ -128,7 +121,8 @@ For example, if current state of ``libbpf.map`` is:
 , and a new symbol ``bpf_func_c`` is being introduced, then
 ``libbpf.map`` should be changed like this:
 
-.. code-block::
+.. code-block:: c
+
         LIBBPF_0.0.1 {
         	global:
                         bpf_func_a;
@@ -148,7 +142,7 @@ Format of version script and ways to handle ABI changes, including
 incompatible ones, described in details in [1].
 
 Stand-alone build
-=================
+-------------------
 
 Under https://github.com/libbpf/libbpf there is a (semi-)automated
 mirror of the mainline's version of libbpf for a stand-alone build.
@@ -157,12 +151,12 @@ However, all changes to libbpf's code base must be upstreamed through
 the mainline kernel tree.
 
 License
-=======
+-------------------
 
 libbpf is dual-licensed under LGPL 2.1 and BSD 2-Clause.
 
 Links
-=====
+-------------------
 
 [1] https://www.akkadia.org/drepper/dsohowto.pdf
     (Chapter 3. Maintaining APIs and ABIs).
-- 
2.31.1

