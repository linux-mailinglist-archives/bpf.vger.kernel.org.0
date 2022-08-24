Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A124B5A03C9
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiHXWKu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240341AbiHXWKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:10:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9637C1D1;
        Wed, 24 Aug 2022 15:10:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so1666064wme.1;
        Wed, 24 Aug 2022 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xQYpj8va1i1LYRLCU/dXszytidkDLrLoIAWMCzKNsNE=;
        b=Mv0qn3VihU9Gy3x0mXZ0Oks5xNyRFbB4Xhx6ubsuW2rnfTV3ABvG1/YA99ePMP+TOF
         6SxOjhDKxY7mDjDl+WBgwiHfX+fPBDFtH+Bx9DsaH/9Ll7NvGrIG1d87FSgOOHk6NCuc
         V9+c1xpJoJ1kW4Deb3DrQ3GtTo2b9FrwfVO693r0nFMLqZQmYUwIbvlaSMpdVWBkuVs4
         SCGgNDoSysfMnpypztYZ4cnamWFHxmAeER+3XwGSBkd8+WmwHdiOCngsSk7wiicxuStz
         hudzuuErM02LfBMqoFU3pSngW6cgiBiZj5WOwiZK2j6mZhk1Xc5P5cHJ7qOZLmgjjpx1
         lfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xQYpj8va1i1LYRLCU/dXszytidkDLrLoIAWMCzKNsNE=;
        b=KbjMtb9K/fc8NWSqr0Ap1Sq6h1viZaYH1yC0SrWfQ261+k/GSoMTOgBQ4BTtAScNmh
         UhuPHF0DPF4vag60IAr1cmjJwfdu8Cu0RN7aNxsiaWM2xs3USGxNxkchgUbZpiMgUTsS
         NSx9E3gS/RzH4BSU5BpxKJHmEvFO82Kzj42R3G+BCHLqg0wxxyQzRR0JoyI0re+PXg/t
         JkzttvbSqAlM69cMM9L+E0GQuwi1OgpvVNe7c7YLboEi+L8rcheLlsJDvs1CXkrUC0O7
         Hl8caY4QULitFefha1hs0TqBrgojJvQrcDu54cCWifvZmmOZnaP0/LSGBzdHBLGTfORf
         I0hw==
X-Gm-Message-State: ACgBeo1pSnZEcqDXHQKcQHYPKW5QfNoGWnli9nps+yp6htcToTmkWNsc
        P0oPSLw47mKsJhDI4twZJ6IpopjHOFuXBg==
X-Google-Smtp-Source: AA6agR4p5LJAEOxRdRtkMMyPKhKjBQIJL/To86hO4utvKX/kwrUQVkSrmUHwsxRAIKgOAB+qJYa2aA==
X-Received: by 2002:a05:600c:35d0:b0:3a5:f7ee:82be with SMTP id r16-20020a05600c35d000b003a5f7ee82bemr437154wmq.206.1661379044671;
        Wed, 24 Aug 2022 15:10:44 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b44b:882e:8988:f510])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b003a5ce167a68sm3399930wms.7.2022.08.24.15.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:10:44 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v2 2/2] Add table of BPF program types to libbpf docs
Date:   Wed, 24 Aug 2022 23:10:18 +0100
Message-Id: <20220824221018.24684-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824221018.24684-1-donald.hunter@gmail.com>
References: <20220824221018.24684-1-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/bpf/libbpf/Makefile          | 36 ++++++++++++++++++++++
 Documentation/bpf/libbpf/index.rst         |  3 ++
 Documentation/bpf/libbpf/program_types.rst | 18 +++++++++++
 Documentation/bpf/programs.rst             |  3 ++
 5 files changed, 62 insertions(+), 1 deletion(-)
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
index 000000000000..c0c2811c4dd6
--- /dev/null
+++ b/Documentation/bpf/libbpf/Makefile
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Rules to convert BPF program types in tools/lib/bpf/libbpf.c
+# into a .csv file
+
+FILES = program_types.csv
+
+TARGETS := $(addprefix $(BUILDDIR)/, $(FILES))
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
index 3722537d1384..2c04a9b3aa1f 100644
--- a/Documentation/bpf/libbpf/index.rst
+++ b/Documentation/bpf/libbpf/index.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
+.. _libbpf:
+
 libbpf
 ======
 
@@ -9,6 +11,7 @@ libbpf
    API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>
    libbpf_naming_convention
    libbpf_build
+   program_types
 
 This is documentation for libbpf, a userspace library for loading and
 interacting with bpf programs.
diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
new file mode 100644
index 000000000000..dc65ede09eef
--- /dev/null
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+.. _program_types_and_elf:
+
+Program Types  and ELF Sections
+===============================
+
+The table below lists the program types, their attach types where relevant and the ELF section
+names supported by libbpf for them. The ELF section names follow these rules:
+
+- ``type`` is an exact match, e.g. ``SEC("socket")``
+- ``type+`` means it can be either exact ``SEC("type")`` or well-formed ``SEC("type/extras")``
+  with a ‘``/``’ separator, e.g. ``SEC("tracepoint/syscalls/sys_enter_open")``
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

