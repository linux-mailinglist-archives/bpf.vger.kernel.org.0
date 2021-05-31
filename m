Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0D1396895
	for <lists+bpf@lfdr.de>; Mon, 31 May 2021 21:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhEaT57 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 May 2021 15:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhEaT55 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 May 2021 15:57:57 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EB4C061574;
        Mon, 31 May 2021 12:56:16 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 76so12149980qkn.13;
        Mon, 31 May 2021 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1s5bzqtZaN8GCvEulhwqkgYerEpZXJqPwTlf1ew4Ak=;
        b=PlS/ioJT5WhiQOhVPfpiifU73WklubvmTnVKEE1/8G9GmqyGgstSPdJp+NGgIENyKy
         G7fH9m7ON8B6XCjDPCHlAthFulyPiDOrHRO+srBvrMaHzUEvHKamSeYQJjzOwSU81Xeu
         y8nMTDTAzJFURo1iz0/0pbO5mCZ0YhI3jsO3FwW7Y/EPCWe6icHRyUex1Na8YVOBRhcm
         1T6AIMxfLd2tQSzZC8KVmVNIdT1USBZg2m3tNWNJTHIYv3F+A16X2KzIcVwy3fUV6/e1
         prnLzSYHTSwVoCNVnCT2QH+0ogZ55vmxyPR0gdIhICGAT8D0jcN992g9PRqPgquMig9D
         KH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1s5bzqtZaN8GCvEulhwqkgYerEpZXJqPwTlf1ew4Ak=;
        b=WQ8k+Oq2C4F1j0Uq8zZY1E9OOPsTc3EOl/e0lxI6lYqyoQRj2V+eRRK5/toqiG7Qiu
         31PCHvrLNWW9795VxzLBLSs5f4B3P7NvAOZY+Yp9A0kHeoUT+cLZ217ojv6l+YqDYSgu
         UxtEGhVh+WgiX9KKBj7tiAsBLrskMBASsAFQH5tBzf3b8JeArhYhgMKln8ZWXX2bT/3y
         ZeV0pYoSwM6Y5BhGwZv8NkkjWvQRrtLsdkXpz6uvi6g4lMDpIrAw9UdJZiw5Qjpgk+Px
         kUxYOssjXc7HjV7em6XscJDs8cGnRFrKrDkLfGASEv8V+JylDIO6jvrAlvoI3tKtlh0P
         BixA==
X-Gm-Message-State: AOAM533gXX217/skqX1kUiMN2DmWcKNCaSJtltkR5lOn71vIN0pL+RQw
        xeorEeCHbVqYdFXu4u8dALY=
X-Google-Smtp-Source: ABdhPJzSxfdIiVQEiT/njl16KTIk/Sntr9dhYtN5FctVb88I17LcPYWSkDykfIxVeuaVHXYrgON2TA==
X-Received: by 2002:ae9:f30a:: with SMTP id p10mr18208761qkg.53.1622490975151;
        Mon, 31 May 2021 12:56:15 -0700 (PDT)
Received: from localhost.localdomain (pool-108-54-205-133.nycmny.fios.verizon.net. [108.54.205.133])
        by smtp.gmail.com with ESMTPSA id d18sm9939549qkc.28.2021.05.31.12.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:56:14 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, grantseltzer@gmail.com,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/2] Add documentation for libbpf including API autogen
Date:   Mon, 31 May 2021 19:55:52 +0000
Message-Id: <20210531195553.168298-2-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210531195553.168298-1-grantseltzer@gmail.com>
References: <20210531195553.168298-1-grantseltzer@gmail.com>
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
 Documentation/bpf/index.rst                   |  13 ++
 Documentation/bpf/libbpf.rst                  |  14 ++
 Documentation/bpf/libbpf_api.rst              |  18 ++
 Documentation/bpf/libbpf_build.rst            |  37 ++++
 .../bpf/libbpf_naming_convention.rst          | 170 ++++++++++++++++++
 5 files changed, 252 insertions(+)
 create mode 100644 Documentation/bpf/libbpf.rst
 create mode 100644 Documentation/bpf/libbpf_api.rst
 create mode 100644 Documentation/bpf/libbpf_build.rst
 create mode 100644 Documentation/bpf/libbpf_naming_convention.rst

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index a702f67dd..44f646735 100644
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
+   libbpf
+   libbpf_api
+   libbpf_build
+   libbpf_naming_convention
+
 BPF Type Format (BTF)
 =====================
 
diff --git a/Documentation/bpf/libbpf.rst b/Documentation/bpf/libbpf.rst
new file mode 100644
index 000000000..515e5f341
--- /dev/null
+++ b/Documentation/bpf/libbpf.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+libbpf
+======
+
+This is documentation for libbpf, a userspace library for loading and
+interacting with bpf programs.
+
+All general BPF questions, including kernel functionality, libbpf APIs and
+their application, should be sent to bpf@vger.kernel.org mailing list.
+You can subscribe to it `here <http://vger.kernel.org/vger-lists.html#bpf>`_
+and search its archive `here <https://lore.kernel.org/bpf/>`_.
+Please search the archive before asking new questions. It very well might
+be that this was already addressed or answered before.
diff --git a/Documentation/bpf/libbpf_api.rst b/Documentation/bpf/libbpf_api.rst
new file mode 100644
index 000000000..fd6b25e03
--- /dev/null
+++ b/Documentation/bpf/libbpf_api.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
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
diff --git a/Documentation/bpf/libbpf_build.rst b/Documentation/bpf/libbpf_build.rst
new file mode 100644
index 000000000..b8240eaaa
--- /dev/null
+++ b/Documentation/bpf/libbpf_build.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Building libbpf
+===============
+
+libelf is an internal dependency of libbpf and thus it is required to link
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
diff --git a/Documentation/bpf/libbpf_naming_convention.rst b/Documentation/bpf/libbpf_naming_convention.rst
new file mode 100644
index 000000000..048be7933
--- /dev/null
+++ b/Documentation/bpf/libbpf_naming_convention.rst
@@ -0,0 +1,170 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+API naming convention
+=====================
+
+libbpf API provides access to a few logically separated groups of
+functions and types. Every group has its own naming convention
+described here. It's recommended to follow these conventions whenever a
+new function or type is added to keep libbpf API clean and consistent.
+
+All types and functions provided by libbpf API should have one of the
+following prefixes: ``bpf_``, ``btf_``, ``libbpf_``, ``xsk_``,
+``perf_buffer_``.
+
+System call wrappers
+--------------------
+
+System call wrappers are simple wrappers for commands supported by
+sys_bpf system call. These wrappers should go to ``bpf.h`` header file
+and map one-on-one to corresponding commands.
+
+For example ``bpf_map_lookup_elem`` wraps ``BPF_MAP_LOOKUP_ELEM``
+command of sys_bpf, ``bpf_prog_attach`` wraps ``BPF_PROG_ATTACH``, etc.
+
+Objects
+-------
+
+Another class of types and functions provided by libbpf API is "objects"
+and functions to work with them. Objects are high-level abstractions
+such as BPF program or BPF map. They're represented by corresponding
+structures such as ``struct bpf_object``, ``struct bpf_program``,
+``struct bpf_map``, etc.
+
+Structures are forward declared and access to their fields should be
+provided via corresponding getters and setters rather than directly.
+
+These objects are associated with corresponding parts of ELF object that
+contains compiled BPF programs.
+
+For example ``struct bpf_object`` represents ELF object itself created
+from an ELF file or from a buffer, ``struct bpf_program`` represents a
+program in ELF object and ``struct bpf_map`` is a map.
+
+Functions that work with an object have names built from object name,
+double underscore and part that describes function purpose.
+
+For example ``bpf_object__open`` consists of the name of corresponding
+object, ``bpf_object``, double underscore and ``open`` that defines the
+purpose of the function to open ELF file and create ``bpf_object`` from
+it.
+
+Another example: ``bpf_program__load`` is named for corresponding
+object, ``bpf_program``, that is separated from other part of the name
+by double underscore.
+
+All objects and corresponding functions other than BTF related should go
+to ``libbpf.h``. BTF types and functions should go to ``btf.h``.
+
+Auxiliary functions
+-------------------
+
+Auxiliary functions and types that don't fit well in any of categories
+described above should have ``libbpf_`` prefix, e.g.
+``libbpf_get_error`` or ``libbpf_prog_type_by_name``.
+
+AF_XDP functions
+-------------------
+
+AF_XDP functions should have an ``xsk_`` prefix, e.g.
+``xsk_umem__get_data`` or ``xsk_umem__create``. The interface consists
+of both low-level ring access functions and high-level configuration
+functions. These can be mixed and matched. Note that these functions
+are not reentrant for performance reasons.
+
+Please take a look at Documentation/networking/af_xdp.rst in the Linux
+kernel source tree on how to use XDP sockets and for some common
+mistakes in case you do not get any traffic up to user space.
+
+ABI
+==========
+
+libbpf can be both linked statically or used as DSO. To avoid possible
+conflicts with other libraries an application is linked with, all
+non-static libbpf symbols should have one of the prefixes mentioned in
+API documentation above. See API naming convention to choose the right
+name for a new symbol.
+
+Symbol visibility
+-----------------
+
+libbpf follow the model when all global symbols have visibility "hidden"
+by default and to make a symbol visible it has to be explicitly
+attributed with ``LIBBPF_API`` macro. For example:
+
+.. code-block:: c
+
+        LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
+
+This prevents from accidentally exporting a symbol, that is not supposed
+to be a part of ABI what, in turn, improves both libbpf developer- and
+user-experiences.
+
+ABI versionning
+---------------
+
+To make future ABI extensions possible libbpf ABI is versioned.
+Versioning is implemented by ``libbpf.map`` version script that is
+passed to linker.
+
+Version name is ``LIBBPF_`` prefix + three-component numeric version,
+starting from ``0.0.1``.
+
+Every time ABI is being changed, e.g. because a new symbol is added or
+semantic of existing symbol is changed, ABI version should be bumped.
+This bump in ABI version is at most once per kernel development cycle.
+
+For example, if current state of ``libbpf.map`` is:
+
+.. code-block:: c
+
+        LIBBPF_0.0.1 {
+        	global:
+                        bpf_func_a;
+                        bpf_func_b;
+        	local:
+        		\*;
+        };
+
+, and a new symbol ``bpf_func_c`` is being introduced, then
+``libbpf.map`` should be changed like this:
+
+.. code-block:: c
+
+        LIBBPF_0.0.1 {
+        	global:
+                        bpf_func_a;
+                        bpf_func_b;
+        	local:
+        		\*;
+        };
+        LIBBPF_0.0.2 {
+                global:
+                        bpf_func_c;
+        } LIBBPF_0.0.1;
+
+, where new version ``LIBBPF_0.0.2`` depends on the previous
+``LIBBPF_0.0.1``.
+
+Format of version script and ways to handle ABI changes, including
+incompatible ones, described in details in [1].
+
+Stand-alone build
+-------------------
+
+Under https://github.com/libbpf/libbpf there is a (semi-)automated
+mirror of the mainline's version of libbpf for a stand-alone build.
+
+However, all changes to libbpf's code base must be upstreamed through
+the mainline kernel tree.
+
+License
+-------------------
+
+libbpf is dual-licensed under LGPL 2.1 and BSD 2-Clause.
+
+Links
+-------------------
+
+[1] https://www.akkadia.org/drepper/dsohowto.pdf
+    (Chapter 3. Maintaining APIs and ABIs).
-- 
2.29.2

