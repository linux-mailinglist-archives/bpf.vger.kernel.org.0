Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6837B396897
	for <lists+bpf@lfdr.de>; Mon, 31 May 2021 21:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhEaT6I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 May 2021 15:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhEaT6D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 May 2021 15:58:03 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E044C06174A;
        Mon, 31 May 2021 12:56:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id j189so12183074qkf.2;
        Mon, 31 May 2021 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kj6zRGYEtkUYP/ZhrvSXDDkV4bGbgnX583PNemCHyPI=;
        b=KSi2LLMU2oPMHeF2fy7CgcMNdRnWPwtN+YDF4mUEUgk79G7tLYmZOgjBR7SAQJQ7A4
         KQ5v9iEOC7DyeJ7oCGM8yeK8JvzDd+mOwnLAsYS9DyiBWPUYzhKfAQ+DC/6WjLDPkXjG
         Zdf0PENw6Mi29XmneGdXQGYWCL7KjoLmHCnbsahRcTa2X7Ou/zX3ksOzW7fJdW/XOj5N
         yRV1a0dO37HPVnbUhdehdU79l9ObO/RRh27CeGF2wuNOM/LJYLjz1xzBLqx+FMm4US/G
         JLARMEfzRRo8BN6RWYn0zlJ0kaRpdJtrJYVlH5RPiU212Kxrunf25yp5c0qGWxREVMtf
         z9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kj6zRGYEtkUYP/ZhrvSXDDkV4bGbgnX583PNemCHyPI=;
        b=aZ4DT+9VO/9vbZs2WT7flRD3+4eBA3Eqsw1nFdEtiR95u+Hr+F84L/tJSxopxXN0ct
         H3tz+er6whkp2ncf48LV6BN4YBzX+W7UTb6c+eT1/sZ02g/UlX8vvqeYg4ZX5J5o9Zgn
         1SiTXJeYDLSDd+6fYCDL8JUwRdbrhh1oxCJQ9HzP/3RnkWDHVgjHaABZ/nGjuIaqXccL
         IZV1wvH8J+ldl6JTCTsvs3BQuYqrBLqCc1p9k9hZl85QxJbrLJlN3phDe4a6zAvnjvoC
         iEB9lG7kLuePKivWQX2ftg+0yHEkiJb0xSRjPpfRBUvdldJttJKyfRPDCJlQf3Gi3tPW
         O8cQ==
X-Gm-Message-State: AOAM532FtQDJF80Nrp5vfKZAgwBhRWmoOekmkphJu8g+xPhvudOwBQz2
        WDCT+ybXzzhQbR7Ox03JnvM=
X-Google-Smtp-Source: ABdhPJy9KrXzIDAF0vETlpUPKeYFb2GHGTPBQ3o73j23iSGt7fMehUPY9NRhDEsSH1lSic9Of7U6Ug==
X-Received: by 2002:a05:620a:1585:: with SMTP id d5mr17960373qkk.29.1622490977414;
        Mon, 31 May 2021 12:56:17 -0700 (PDT)
Received: from localhost.localdomain (pool-108-54-205-133.nycmny.fios.verizon.net. [108.54.205.133])
        by smtp.gmail.com with ESMTPSA id d18sm9939549qkc.28.2021.05.31.12.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:56:17 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, grantseltzer@gmail.com,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/2] Remove duplicate README doc from libbpf
Date:   Mon, 31 May 2021 19:55:53 +0000
Message-Id: <20210531195553.168298-3-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210531195553.168298-1-grantseltzer@gmail.com>
References: <20210531195553.168298-1-grantseltzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This removes the README.rst file from libbpf code which is moved into
Documentation/bpf/libbpf in the previous commit

Signed-off-by: grantseltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/README.rst | 168 ---------------------------------------
 1 file changed, 168 deletions(-)
 delete mode 100644 tools/lib/bpf/README.rst

diff --git a/tools/lib/bpf/README.rst b/tools/lib/bpf/README.rst
deleted file mode 100644
index 8928f7787..000000000
--- a/tools/lib/bpf/README.rst
+++ /dev/null
@@ -1,168 +0,0 @@
-.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-
-libbpf API naming convention
-============================
-
-libbpf API provides access to a few logically separated groups of
-functions and types. Every group has its own naming convention
-described here. It's recommended to follow these conventions whenever a
-new function or type is added to keep libbpf API clean and consistent.
-
-All types and functions provided by libbpf API should have one of the
-following prefixes: ``bpf_``, ``btf_``, ``libbpf_``, ``xsk_``,
-``perf_buffer_``.
-
-System call wrappers
---------------------
-
-System call wrappers are simple wrappers for commands supported by
-sys_bpf system call. These wrappers should go to ``bpf.h`` header file
-and map one-on-one to corresponding commands.
-
-For example ``bpf_map_lookup_elem`` wraps ``BPF_MAP_LOOKUP_ELEM``
-command of sys_bpf, ``bpf_prog_attach`` wraps ``BPF_PROG_ATTACH``, etc.
-
-Objects
--------
-
-Another class of types and functions provided by libbpf API is "objects"
-and functions to work with them. Objects are high-level abstractions
-such as BPF program or BPF map. They're represented by corresponding
-structures such as ``struct bpf_object``, ``struct bpf_program``,
-``struct bpf_map``, etc.
-
-Structures are forward declared and access to their fields should be
-provided via corresponding getters and setters rather than directly.
-
-These objects are associated with corresponding parts of ELF object that
-contains compiled BPF programs.
-
-For example ``struct bpf_object`` represents ELF object itself created
-from an ELF file or from a buffer, ``struct bpf_program`` represents a
-program in ELF object and ``struct bpf_map`` is a map.
-
-Functions that work with an object have names built from object name,
-double underscore and part that describes function purpose.
-
-For example ``bpf_object__open`` consists of the name of corresponding
-object, ``bpf_object``, double underscore and ``open`` that defines the
-purpose of the function to open ELF file and create ``bpf_object`` from
-it.
-
-Another example: ``bpf_program__load`` is named for corresponding
-object, ``bpf_program``, that is separated from other part of the name
-by double underscore.
-
-All objects and corresponding functions other than BTF related should go
-to ``libbpf.h``. BTF types and functions should go to ``btf.h``.
-
-Auxiliary functions
--------------------
-
-Auxiliary functions and types that don't fit well in any of categories
-described above should have ``libbpf_`` prefix, e.g.
-``libbpf_get_error`` or ``libbpf_prog_type_by_name``.
-
-AF_XDP functions
--------------------
-
-AF_XDP functions should have an ``xsk_`` prefix, e.g.
-``xsk_umem__get_data`` or ``xsk_umem__create``. The interface consists
-of both low-level ring access functions and high-level configuration
-functions. These can be mixed and matched. Note that these functions
-are not reentrant for performance reasons.
-
-Please take a look at Documentation/networking/af_xdp.rst in the Linux
-kernel source tree on how to use XDP sockets and for some common
-mistakes in case you do not get any traffic up to user space.
-
-libbpf ABI
-==========
-
-libbpf can be both linked statically or used as DSO. To avoid possible
-conflicts with other libraries an application is linked with, all
-non-static libbpf symbols should have one of the prefixes mentioned in
-API documentation above. See API naming convention to choose the right
-name for a new symbol.
-
-Symbol visibility
------------------
-
-libbpf follow the model when all global symbols have visibility "hidden"
-by default and to make a symbol visible it has to be explicitly
-attributed with ``LIBBPF_API`` macro. For example:
-
-.. code-block:: c
-
-        LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
-
-This prevents from accidentally exporting a symbol, that is not supposed
-to be a part of ABI what, in turn, improves both libbpf developer- and
-user-experiences.
-
-ABI versionning
----------------
-
-To make future ABI extensions possible libbpf ABI is versioned.
-Versioning is implemented by ``libbpf.map`` version script that is
-passed to linker.
-
-Version name is ``LIBBPF_`` prefix + three-component numeric version,
-starting from ``0.0.1``.
-
-Every time ABI is being changed, e.g. because a new symbol is added or
-semantic of existing symbol is changed, ABI version should be bumped.
-This bump in ABI version is at most once per kernel development cycle.
-
-For example, if current state of ``libbpf.map`` is:
-
-.. code-block::
-        LIBBPF_0.0.1 {
-        	global:
-                        bpf_func_a;
-                        bpf_func_b;
-        	local:
-        		\*;
-        };
-
-, and a new symbol ``bpf_func_c`` is being introduced, then
-``libbpf.map`` should be changed like this:
-
-.. code-block::
-        LIBBPF_0.0.1 {
-        	global:
-                        bpf_func_a;
-                        bpf_func_b;
-        	local:
-        		\*;
-        };
-        LIBBPF_0.0.2 {
-                global:
-                        bpf_func_c;
-        } LIBBPF_0.0.1;
-
-, where new version ``LIBBPF_0.0.2`` depends on the previous
-``LIBBPF_0.0.1``.
-
-Format of version script and ways to handle ABI changes, including
-incompatible ones, described in details in [1].
-
-Stand-alone build
-=================
-
-Under https://github.com/libbpf/libbpf there is a (semi-)automated
-mirror of the mainline's version of libbpf for a stand-alone build.
-
-However, all changes to libbpf's code base must be upstreamed through
-the mainline kernel tree.
-
-License
-=======
-
-libbpf is dual-licensed under LGPL 2.1 and BSD 2-Clause.
-
-Links
-=====
-
-[1] https://www.akkadia.org/drepper/dsohowto.pdf
-    (Chapter 3. Maintaining APIs and ABIs).
-- 
2.29.2

