Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3E95A45D7
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 11:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiH2JPU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 05:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiH2JPT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 05:15:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A5A1C110;
        Mon, 29 Aug 2022 02:15:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id se27so6680570ejb.8;
        Mon, 29 Aug 2022 02:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vr2KR0kpkzOU3iCxlbjFB0Xu1rOwulObIcfuCs6jByc=;
        b=P60X7mx3WNgJ/KRbXMDAp/TeiFsnHnV/r3LpHb6fIo+orSmgY6T6CiZTAOTeOgE8kt
         agJ7G8azspMm2gO8cmCqVTrtp8Sr33B+43aWwnw+8i8cwBDyShtlrBp6nLyaxC7wd2j/
         mu/Z9Z/fY8iy56saXXthUWFGllG4lyN9Z07+6kNODnGB1ccCeRXWTp7hdFWzn20xBuhO
         ECSpFHamPKMLdYTJ3Ig8jykKZOZyVhTV0XndWlUAgEyrfq4QednBFjtXEmK7jlbGrG47
         QBlM0ZW0N99ryHt75lGKN/lIC6JTUe9wDTTz/5v/tfFxO11W8R8ot0Sl0JeAVI5hBecj
         VVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vr2KR0kpkzOU3iCxlbjFB0Xu1rOwulObIcfuCs6jByc=;
        b=7Ju9p3UdsGsLpn6o/0qYNnHsnzlJlVN+u/1uCeRIyLQ8IZAzon+mfpMCNUe8pNQ/tR
         NMWX1lEWbYnRHYltWP6Z5qHKx8DxEZPtDagHdNEnl+Dx1IFmAEk06BeWtwlHXodVg6+x
         1bGN/nREdXEbp4vDaJ2ckoCJYQpJV9OjmwGNr1gqJF9/PYsH5wV9nj4/cFzgqSb33z1F
         +j7c5STYqXYnxVO+oonfupefsxNBiq18H9hDoA1IcnOuOJiTQalnUG0l86n9Qdrg5Lgg
         pidwsGq9+H1IEJ0CXKy6C1sUiUZd9EIwukXJ901eh5TeCVNjNqjaVm0IIQaMldVfgktO
         6/pQ==
X-Gm-Message-State: ACgBeo1vmOd5FGuyxip/IGe9SEBYbk3yHFmIIYyTRLVSE9K8At2wthmL
        YmhMcUZV/3FksvvkcUrIFewGdaP9S68=
X-Google-Smtp-Source: AA6agR4NrMnICbNHKf9+32lw5z0UO62MaAKkuN57ThLlWa6rGHBAa7rzecD3DRLsDm+DgJURwO+TTg==
X-Received: by 2002:a17:906:4795:b0:73d:d6e8:52a7 with SMTP id cw21-20020a170906479500b0073dd6e852a7mr11607261ejc.59.1661764515543;
        Mon, 29 Aug 2022 02:15:15 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:612e:4c5:1fc2:7d5d])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090609c100b0073cb0801104sm4287382eje.147.2022.08.29.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 02:15:14 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v3 2/2] Add table of BPF program types to libbpf docs
Date:   Mon, 29 Aug 2022 10:15:00 +0100
Message-Id: <20220829091500.24115-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829091500.24115-1-donald.hunter@gmail.com>
References: <20220829091500.24115-1-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/bpf/libbpf/Makefile          | 49 ++++++++++++++++++++++
 Documentation/bpf/libbpf/index.rst         |  3 ++
 Documentation/bpf/libbpf/program_types.rst | 32 ++++++++++++++
 Documentation/bpf/programs.rst             |  3 ++
 5 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/bpf/libbpf/Makefile
 create mode 100644 Documentation/bpf/libbpf/program_types.rst

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
diff --git a/Documentation/bpf/libbpf/Makefile b/Documentation/bpf/libbpf/Makefile
new file mode 100644
index 000000000000..b3dc096c4a96
--- /dev/null
+++ b/Documentation/bpf/libbpf/Makefile
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Rules to convert BPF program types in tools/lib/bpf/libbpf.c
+# into a .csv file
+
+FILES = program_types.csv
+
+TARGETS := $(addprefix $(BUILDDIR)/, $(FILES))
+
+# Extract program types and properties from the section definitions in libbpf.c such as
+# SEC_DEF("socket", SOCKET_FILTER, 0, SEC_NONE) to generate program_types.csv
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
+$(BUILDDIR)/program_types.csv:	$(srctree)/tools/lib/bpf/libbpf.c
+	$(Q)awk -F'[",[:space:]]+' \
+	'BEGIN { print "Program Type,Attach Type,ELF Section Name,Sleepable" } \
+	/SEC_DEF\(\"/ && !/SEC_DEPRECATED/ { \
+	type = "``BPF_PROG_TYPE_" $$4 "``"; \
+	attach = index($$5, "0") ? "" : "``" $$5 "``"; \
+	section = "``" $$3 "``"; \
+	sleepable = index($$0, "SEC_SLEEPABLE") ? "Yes" : ""; \
+	print type "," attach "," section "," sleepable }' \
+	$< > $@
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
index 000000000000..04fbb48b8a6a
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
+  program_types.csv is generated from tools/lib/bpf/libbpf.c and is fomatted like this:
+    Program Type,Attach Type,ELF Section Name,Sleepable
+    ``BPF_PROG_TYPE_SOCKET_FILTER``,,``socket``,
+    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE``,``sk_reuseport/migrate``,
+    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT``,``sk_reuseport``,
+    ``BPF_PROG_TYPE_KPROBE``,,``kprobe+``,
+    ``BPF_PROG_TYPE_KPROBE``,,``uprobe+``,
+    ``BPF_PROG_TYPE_KPROBE``,,``uprobe.s+``,Yes
+
+.. csv-table:: Program Types and Their ELF Section Names
+   :file: ../../output/program_types.csv
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
-- 
2.35.1

