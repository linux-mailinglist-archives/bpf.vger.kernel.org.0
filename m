Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5F5E61C4
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 13:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiIVLx2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 07:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiIVLxY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 07:53:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B38D9B857;
        Thu, 22 Sep 2022 04:53:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n12so15095951wrx.9;
        Thu, 22 Sep 2022 04:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=g3z6by+wCdHYfsTybTWcUcSO/HVJ9Iqcx8nY//emzRE=;
        b=Aomae147o/xrsvydAMuQ7L7JCo8iXmSR8yRLqBfFoFNKVT2MmO9a3J6wJVgyo6Wv5D
         T2DXOPU4zsST6FYfBzoOPO3jaF64q1/C5l3Z/8rv82OCy58CQiQ2d6DBqDRU+UfF52Vz
         IK5MTj3MJcarMBWAgDe3LR5HF/WgZykXJrKcqx7FAOf8ThfU26uReOMBBpTcu6pXntMn
         yPGZ8cIASYsU5hmJc6eRcUBAN86+32EAAUQm0VvUOSmrfIv/7uPymz7amkLcPjTeR59G
         g+ZCjgpv0wHq/SSur5T2xOlNRoyLeqqrB7yo4JwZiPr5My5P5F4j/VXZt6yItItnKjbx
         dygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=g3z6by+wCdHYfsTybTWcUcSO/HVJ9Iqcx8nY//emzRE=;
        b=GWfoIF/6yCcwthF3D7HhqXEeGMX+ir5dZK6pmi5LTnlZQjNehMD1B4ANp+qH6cRS/P
         YnIClanwunarQHvIN42LJpjYW2HcqSMXuXohpku1boXjW6EgDGy1WNTZC2rIaItQKpBc
         r51Dwjej1xrvWOSfdJeDAsf8ots7WUKQQ4aRX/W/Jw8ZYfOLUS1s36RR0WPSHH4adU8Y
         7cmsJ5ghmvejOk3JwSwommkjNnJu178F9GJTG+HlWD5LS9Br771MA0BSxWNxG5Ue4LcX
         XXcC7EGGXuqLBDgM80opsyXfn7PR6ZhkTDwoT8DPHhGNABxw5jUIC8+0SpR41VLT22Nt
         Uifw==
X-Gm-Message-State: ACrzQf3IMArds+v1A+B6myMD9GjlzBN5JDi/mBvaxVayR4mlIVSkaGCp
        lasN4OMdavWimMj7NOswm4oNT5BdsuFr3A==
X-Google-Smtp-Source: AMsMyM6wVfpFqB/342Dhsonq4dXRxac4CQXnrXqfDiC7x2ql3L5/SydHNLsbJKL8BQc2FNnF2X65KA==
X-Received: by 2002:a5d:5503:0:b0:22a:2fd7:d778 with SMTP id b3-20020a5d5503000000b0022a2fd7d778mr1742076wrv.44.1663847598765;
        Thu, 22 Sep 2022 04:53:18 -0700 (PDT)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id bg17-20020a05600c3c9100b003a5f4fccd4asm5865074wmb.35.2022.09.22.04.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:53:18 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v4 2/2] Add table of BPF program types to libbpf docs
Date:   Thu, 22 Sep 2022 12:52:57 +0100
Message-Id: <20220922115257.99815-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922115257.99815-1-donald.hunter@gmail.com>
References: <20220922115257.99815-1-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the libbpf documentation with a table of program types,
attach points and ELF section names. This table uses data from
program_types.csv which is generated from tools/lib/bpf/libbpf.c
during the documentation build.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/Makefile                     |  3 +-
 Documentation/bpf/libbpf/.gitignore        |  1 +
 Documentation/bpf/libbpf/Makefile          | 29 ++++++++++++++++++
 Documentation/bpf/libbpf/index.rst         |  3 ++
 Documentation/bpf/libbpf/program_types.rst | 32 ++++++++++++++++++++
 Documentation/bpf/programs.rst             |  3 ++
 scripts/gen-bpf-progtypes.sh               | 34 ++++++++++++++++++++++
 7 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/bpf/libbpf/.gitignore
 create mode 100644 Documentation/bpf/libbpf/Makefile
 create mode 100644 Documentation/bpf/libbpf/program_types.rst
 create mode 100755 scripts/gen-bpf-progtypes.sh

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 8a63ef2dcd1c..f007314770e1 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -66,7 +66,8 @@ I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
 loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;
 
 BUILD_SUBDIRS = \
-	Documentation/userspace-api/media
+	Documentation/userspace-api/media \
+	Documentation/bpf/libbpf
 
 quiet_cmd_build_subdir = SUBDIR  $2
       cmd_build_subdir = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=$2 $3
diff --git a/Documentation/bpf/libbpf/.gitignore b/Documentation/bpf/libbpf/.gitignore
new file mode 100644
index 000000000000..c9013b8cae08
--- /dev/null
+++ b/Documentation/bpf/libbpf/.gitignore
@@ -0,0 +1 @@
+/program_types.csv
diff --git a/Documentation/bpf/libbpf/Makefile b/Documentation/bpf/libbpf/Makefile
new file mode 100644
index 000000000000..9cc3f67b5602
--- /dev/null
+++ b/Documentation/bpf/libbpf/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Rules to convert BPF program types in tools/lib/bpf/libbpf.c
+# into a .csv file
+
+PROGRAM_TYPES = $(srctree)/Documentation/bpf/libbpf/program_types.csv
+
+TARGETS := $(PROGRAM_TYPES)
+
+
+$(PROGRAM_TYPES):	$(srctree)/tools/lib/bpf/libbpf.c
+	$(Q)$(srctree)/scripts/gen-bpf-progtypes.sh $< $@
+
+.PHONY: all html epub xml latex linkcheck clean
+
+all: $(BUILDDIR) ${TARGETS}
+	@:
+
+html: all
+epub: all
+xml: all
+latex: all
+linkcheck:
+
+clean:
+	-$(Q)rm -f ${TARGETS} 2>/dev/null
+
+$(BUILDDIR):
+	$(Q)mkdir -p $@
diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbpf/index.rst
index 3722537d1384..f9b3b252e28f 100644
--- a/Documentation/bpf/libbpf/index.rst
+++ b/Documentation/bpf/libbpf/index.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
+.. _libbpf:
+
 libbpf
 ======
 
@@ -7,6 +9,7 @@ libbpf
    :maxdepth: 1
 
    API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>
+   program_types
    libbpf_naming_convention
    libbpf_build
 
diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
new file mode 100644
index 000000000000..b74fbf3363dd
--- /dev/null
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+.. _program_types_and_elf:
+
+Program Types and ELF Sections
+==============================
+
+The table below lists the program types, their attach types where relevant and the ELF section
+names supported by libbpf for them. The ELF section names follow these rules:
+
+- ``type`` is an exact match, e.g. ``SEC("socket")``
+- ``type+`` means it can be either exact ``SEC("type")`` or well-formed ``SEC("type/extras")``
+  with a ‘``/``’ separator between ``type`` and ``extras``.
+
+When ``extras`` are specified, they provide details of how to auto-attach the BPF program.
+The format of ``extras`` depends on the program type, e.g. ``SEC("tracepoint/<category>/<name>")``
+for tracepoints or ``SEC("usdt/<path-to-binary>:<usdt_provider>:<usdt_name>")`` for USDT probes.
+
+..
+  program_types.csv is generated from tools/lib/bpf/libbpf.c and is formatted like this:
+    Program Type,Attach Type,ELF Section Name,Sleepable
+    ``BPF_PROG_TYPE_SOCKET_FILTER``,,``socket``,
+    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE``,``sk_reuseport/migrate``,
+    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT``,``sk_reuseport``,
+    ``BPF_PROG_TYPE_KPROBE``,,``kprobe+``,
+    ``BPF_PROG_TYPE_KPROBE``,,``uprobe+``,
+    ``BPF_PROG_TYPE_KPROBE``,,``uprobe.s+``,Yes
+
+.. csv-table:: Program Types and Their ELF Section Names
+   :file: program_types.csv
+   :widths: 40 30 20 10
+   :header-rows: 1
diff --git a/Documentation/bpf/programs.rst b/Documentation/bpf/programs.rst
index 620eb667ac7a..c99000ab6d9b 100644
--- a/Documentation/bpf/programs.rst
+++ b/Documentation/bpf/programs.rst
@@ -7,3 +7,6 @@ Program Types
    :glob:
 
    prog_*
+
+For a list of all program types, see :ref:`program_types_and_elf` in
+the :ref:`libbpf` documentation.
diff --git a/scripts/gen-bpf-progtypes.sh b/scripts/gen-bpf-progtypes.sh
new file mode 100755
index 000000000000..3bf36f26a2f7
--- /dev/null
+++ b/scripts/gen-bpf-progtypes.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2022 Red Hat.
+#
+# Generate a .csv table of BPF program types
+
+if [ "$#" -lt 2 ]; then
+    echo "Usage: gen-bpf-progtypes.sh </path/to/libbpf.c> </path/to/generated.csv>"
+    exit 1
+fi
+
+# Extract program types and properties from the section definitions in libbpf.c such as
+# SEC_DEF("socket", SOCKET_FILTER, 0, SEC_NONE) to generate a table of program types in
+# .csv format.
+#
+# Here is a sample of the generated output that includes .rst formatting:
+#
+#  Program Type,Attach Type,ELF Section Name,Sleepable
+#  ``BPF_PROG_TYPE_SOCKET_FILTER``,,``socket``,
+#  ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE``,``sk_reuseport/migrate``,
+#  ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT``,``sk_reuseport``,
+#  ``BPF_PROG_TYPE_KPROBE``,,``kprobe+``,
+#  ``BPF_PROG_TYPE_KPROBE``,,``uprobe+``,
+#  ``BPF_PROG_TYPE_KPROBE``,,``uprobe.s+``,Yes
+
+awk -F'[",[:space:]]+' \
+    'BEGIN { print "Program Type,Attach Type,ELF Section Name,Sleepable" }
+    /SEC_DEF\(\"/ && !/SEC_DEPRECATED/ {
+    type = "``BPF_PROG_TYPE_" $4 "``"
+    attach = index($5, "0") ? "" : "``" $5 "``";
+    section = "``" $3 "``"
+    sleepable = index($0, "SEC_SLEEPABLE") ? "Yes" : "";
+    print type "," attach "," section "," sleepable }' $1 | sort > $2
-- 
2.35.1

