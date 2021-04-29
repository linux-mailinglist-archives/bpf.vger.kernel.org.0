Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000B736F233
	for <lists+bpf@lfdr.de>; Thu, 29 Apr 2021 23:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhD2Vlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Apr 2021 17:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbhD2Vlv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Apr 2021 17:41:51 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE164C06138B
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 14:41:04 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j19so10000963qtx.13
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 14:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYJ7E1heEgvxDeqLZnL4sn6H/CCcIRlNBxrxvMONl3o=;
        b=NZkk/evOKyx6ICNq6FDsC7XW9ZgERmufjyIg9vMpv3N2dUVcKIluOV6Ez4/1fSOAw0
         sktsd1L8N6Vq2EYcTBPrTIiDHFBfjiQ9IfYQyhLTPeA85EHYFSYK5JKxZ3MnXshcHq/5
         gyf7/rXknjp9j+YA5cqPkHr4QG13bZC6Tf8w4qL0N1uGWbj3oHjJm8GnJhjU9MToVbpS
         XHsdAtpwCvHK8LLn/GE05kjWpE9Wm/fdnwqWulBOT4PheQRhNRfvqnLid1939CkY2Bhp
         ht5MbGR9AzbGO3s5mTIhOt00bQakxyeprk0aAVHCEAYwO/XJxKrXBWuLH9aPN7YGrWbO
         Tp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYJ7E1heEgvxDeqLZnL4sn6H/CCcIRlNBxrxvMONl3o=;
        b=taHzn0iCy0/CQaPtLaBuZE/dwj3p2g2by2GGuf6H3JMVTMwN6calSTDobl8oE8jOqO
         wytcLdC8Fd2GWxOJcfp8BrgrjGYVGOi/qV3QeA5VvDsgtxwtudi/3NewNFXeDXNBnrxK
         ghzMacVxWHLMDzL9XGSv1M/cEAPX/1klbH5vqUS4//6HRFUQh8DW0CkJt1/L53US/RsS
         dUkbOb/Iq0D4/MO7iXyoCSwFt4MzpFGbZjwtu/d0/EDZdw/TStC8ZNgGS96A3qUmUonE
         eHE90VRljR3XZa86Tt22gk2ka1tt+2Rkoh4IA7VoP96z2JV8rz1RKFEUvYiw+Cy6q9Y8
         USrw==
X-Gm-Message-State: AOAM5338l5u1sx27EodYqH9QrBslFEvvA2nHqOvQhR8RdTaOLbSQLJLJ
        Z+y0LN1r5RkyLz2lf/6/0yU=
X-Google-Smtp-Source: ABdhPJwyQExJmDprSPeKzZKCwtugNowKT+nL1xNjTAK6WQN0GUsTtkPJaiLpigfwm283YcXGiamEwQ==
X-Received: by 2002:ac8:530f:: with SMTP id t15mr1487250qtn.189.1619732463922;
        Thu, 29 Apr 2021 14:41:03 -0700 (PDT)
Received: from localhost.localdomain (pool-100-33-2-40.nycmny.fios.verizon.net. [100.33.2.40])
        by smtp.gmail.com with ESMTPSA id m16sm2993869qkm.100.2021.04.29.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:41:03 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net
Cc:     grantseltzer@gmail.com, bpf@vger.kernel.org
Subject: [PATCH bpf-next 3/3] bpf: Add rst docs for libbpf
Date:   Thu, 29 Apr 2021 05:47:34 +0000
Message-Id: <20210429054734.53264-4-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210429054734.53264-1-grantseltzer@gmail.com>
References: <20210429054734.53264-1-grantseltzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds rst files containg documentation files relevant for
libbpf development. naming_convention.rst is pulled from the
previous README.rst file. api.rst is an index page that links
to the api documentation generationg from doxygen+breathe.

Signed-off-by: grantseltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/docs/api.rst                    | 60 +++++++++++++++++++
 tools/lib/bpf/docs/build.rst                  | 39 ++++++++++++
 tools/lib/bpf/docs/index.rst                  |  6 ++
 .../naming_convention.rst}                    | 18 +++---
 4 files changed, 116 insertions(+), 7 deletions(-)
 create mode 100644 tools/lib/bpf/docs/api.rst
 create mode 100644 tools/lib/bpf/docs/build.rst
 rename tools/lib/bpf/{README.rst => docs/naming_convention.rst} (97%)

diff --git a/tools/lib/bpf/docs/api.rst b/tools/lib/bpf/docs/api.rst
new file mode 100644
index 000000000..36bac417b
--- /dev/null
+++ b/tools/lib/bpf/docs/api.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+.. _api:
+
+.. contents:: Table of Contents
+   :local:
+   :depth: 1
+
+LIBBPF API
+==================
+
+
+libbpf.h
+------------------
+
+.. doxygenfile:: libbpf.h
+   :project: libbpf
+
+bpf_core_read.h
+------------------
+
+.. doxygenfile:: bpf_core_read.h
+   :project: libbpf
+
+btf.h
+------------------
+
+.. doxygenfile:: btf.h
+   :project: libbpf
+
+bpf_endian.h
+------------------
+
+.. doxygenfile:: bpf_endian.h
+   :project: libbpf
+
+libbpf_common.h
+------------------
+
+.. doxygenfile:: libbpf_common.h
+   :project: libbpf
+
+hashmap.h
+------------------
+
+.. doxygenfile:: hashmap.h
+   :project: libbpf
+
+
+bpf_helpers.h
+------------------
+
+.. doxygenfile:: bpf_helpers.h
+   :project: libbpf
+
+bpf_helper_defs.h
+------------------
+
+.. doxygenfile:: hashmap.h
+   :project: libbpf
diff --git a/tools/lib/bpf/docs/build.rst b/tools/lib/bpf/docs/build.rst
new file mode 100644
index 000000000..749f96dd2
--- /dev/null
+++ b/tools/lib/bpf/docs/build.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+.. _build:
+
+Building libbpf
+=======================================
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
diff --git a/tools/lib/bpf/docs/index.rst b/tools/lib/bpf/docs/index.rst
index 31a6ecfab..76bb93580 100644
--- a/tools/lib/bpf/docs/index.rst
+++ b/tools/lib/bpf/docs/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
 libbpf documentation
 =======================================
 
@@ -13,3 +15,7 @@ be that this was already addressed or answered before.
 
 .. toctree::
    :caption: Documentation:
+
+   api
+   naming_convention
+   build
\ No newline at end of file
diff --git a/tools/lib/bpf/README.rst b/tools/lib/bpf/docs/naming_convention.rst
similarity index 97%
rename from tools/lib/bpf/README.rst
rename to tools/lib/bpf/docs/naming_convention.rst
index 8928f7787..6b9ae9701 100644
--- a/tools/lib/bpf/README.rst
+++ b/tools/lib/bpf/docs/naming_convention.rst
@@ -1,6 +1,8 @@
 .. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
-libbpf API naming convention
+.. _naming_convention:
+
+API naming convention
 ============================
 
 libbpf API provides access to a few logically separated groups of
@@ -76,7 +78,7 @@ Please take a look at Documentation/networking/af_xdp.rst in the Linux
 kernel source tree on how to use XDP sockets and for some common
 mistakes in case you do not get any traffic up to user space.
 
-libbpf ABI
+ABI
 ==========
 
 libbpf can be both linked statically or used as DSO. To avoid possible
@@ -116,7 +118,8 @@ This bump in ABI version is at most once per kernel development cycle.
 
 For example, if current state of ``libbpf.map`` is:
 
-.. code-block::
+.. code-block:: c
+
         LIBBPF_0.0.1 {
         	global:
                         bpf_func_a;
@@ -128,7 +131,8 @@ For example, if current state of ``libbpf.map`` is:
 , and a new symbol ``bpf_func_c`` is being introduced, then
 ``libbpf.map`` should be changed like this:
 
-.. code-block::
+.. code-block:: c
+
         LIBBPF_0.0.1 {
         	global:
                         bpf_func_a;
@@ -148,7 +152,7 @@ Format of version script and ways to handle ABI changes, including
 incompatible ones, described in details in [1].
 
 Stand-alone build
-=================
+-------------------
 
 Under https://github.com/libbpf/libbpf there is a (semi-)automated
 mirror of the mainline's version of libbpf for a stand-alone build.
@@ -157,12 +161,12 @@ However, all changes to libbpf's code base must be upstreamed through
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
2.29.2

