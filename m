Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F875A45D5
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiH2JPR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 05:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiH2JPQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 05:15:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9531ADB7;
        Mon, 29 Aug 2022 02:15:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r4so9267809edi.8;
        Mon, 29 Aug 2022 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Zvj5Ptf4ZB5FolY5aGzlhnaDTg1DsgEiRO9E3PeZKHA=;
        b=E5UDookjb1IdAyuRGgWlJj/RECqjr5LTMTJ97r3XUzIoKBQgOuUX7FSizOKQ7R0i31
         o4LbCDXxVrk+DXoNV7Gmpz1RnIhTLqwSqkV1MwN4lG0PpYjR82hNxs5G1OZXqd3nsVSM
         XvpFnD6wtM7hpWs/hI7JerOMjaNbzCaAVR0et/ZADOm75FNc6AHCokBsVKJRzlaFIbEw
         4TZfcoBzOL2o53rJp/4weY43/0zep9zsd+b8t2zAB1IF9ARbImPcDkMAmooBa+oIhD1B
         2xvDOjvRkJ+TXeeS39Ro/Xeh8mrQ3pQlwensyQWtgnVaDgFLVqPDZAu2LWt8zyVjqWJe
         z8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Zvj5Ptf4ZB5FolY5aGzlhnaDTg1DsgEiRO9E3PeZKHA=;
        b=iBDAh1xCShylkUpeDAIsk0L7Dum4glJZaEAH3Qg7ka/33YOs3a7sv7FcP0Mb6mTJk+
         DKscu2W4FYZpaOSr1t6KmyWucuX+n5azrUqZgsEwhjZpyaiuNtssD2B1DsOvEqqtBlzK
         E/zy0km/vo7n2NTR0NZn3jjUTvZLQbVYcTbURLM/E4oFVThvTdCE+BWg6gjwfz3J5+KX
         3hScglqIKZ78ryWYt2nd8Pfb4zfEVczuW3pru+4Yl9HAM9l8dOTphBzt8TPtIl5aN8tX
         Z2P9P3FWmqC9yYl1K2GpIyiRbwtvLiMFrkA5aVvNcZTYXrJu+6CRsAFjOZKGCrUn6e0u
         QB+Q==
X-Gm-Message-State: ACgBeo0HtBG3H6L+oVrtgftnaITLx1CrahWL06TGA1324/n4yFyUcGkp
        c3q/HeT5gyiQspEGF4ezG1GcZ2XteVg=
X-Google-Smtp-Source: AA6agR4wYKlqVXcdNijYcmD1XzB46vrxMVBL5ORdpDS9XtN1VKjFjLaGUuh/4xMzygmbuAswocciJQ==
X-Received: by 2002:a05:6402:5008:b0:440:941a:93c3 with SMTP id p8-20020a056402500800b00440941a93c3mr15794292eda.47.1661764512851;
        Mon, 29 Aug 2022 02:15:12 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:612e:4c5:1fc2:7d5d])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090609c100b0073cb0801104sm4287382eje.147.2022.08.29.02.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 02:15:12 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v3 1/2] Add subdir support to Documentation makefile
Date:   Mon, 29 Aug 2022 10:14:59 +0100
Message-Id: <20220829091500.24115-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829091500.24115-1-donald.hunter@gmail.com>
References: <20220829091500.24115-1-donald.hunter@gmail.com>
MIME-Version: 1.0
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

Run make in list of subdirs to build generated sources and migrate
userspace-api/media to use this instead of being a special case.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/Makefile                     | 15 +++++++++++++--
 Documentation/userspace-api/media/Makefile |  2 ++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 64d44c1ecad3..8a63ef2dcd1c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -65,6 +65,12 @@ I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
 # commands; the 'cmd' from scripts/Kbuild.include is not *loopable*
 loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;
 
+BUILD_SUBDIRS = \
+	Documentation/userspace-api/media
+
+quiet_cmd_build_subdir = SUBDIR  $2
+      cmd_build_subdir = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=$2 $3
+
 # $2 sphinx builder e.g. "html"
 # $3 name of the build subfolder / e.g. "userspace-api/media", used as:
 #    * dest folder relative to $(BUILDDIR) and
@@ -74,7 +80,7 @@ loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;
 #    e.g. "userspace-api/media" for the linux-tv book-set at ./Documentation/userspace-api/media
 
 quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
-      cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media $2 && \
+      cmd_sphinx =  \
 	PYTHONDONTWRITEBYTECODE=1 \
 	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
 	$(PYTHON3) $(srctree)/scripts/jobserver-exec \
@@ -93,6 +99,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 
 htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@+$(foreach var,$(BUILD_SUBDIRS),$(call loop_cmd,build_subdir,$(var),html))
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
 linkcheckdocs:
@@ -100,6 +107,7 @@ linkcheckdocs:
 
 latexdocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@+$(foreach var,$(BUILD_SUBDIRS),$(call loop_cmd,build_subdir,$(var),latex))
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$(var)))
 
 ifeq ($(HAVE_PDFLATEX),0)
@@ -112,6 +120,7 @@ else # HAVE_PDFLATEX
 
 pdfdocs: latexdocs
 	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@+$(foreach var,$(BUILD_SUBDIRS),$(call loop_cmd,build_subdir,$(var),latex))
 	$(foreach var,$(SPHINXDIRS), \
 	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" -C $(BUILDDIR)/$(var)/latex || exit; \
 	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
@@ -122,10 +131,12 @@ endif # HAVE_PDFLATEX
 
 epubdocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@+$(foreach var,$(BUILD_SUBDIRS),$(call loop_cmd,build_subdir,$(var),epub))
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(var)))
 
 xmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@+$(foreach var,$(BUILD_SUBDIRS),$(call loop_cmd,build_subdir,$(var),xml))
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var)))
 
 endif # HAVE_SPHINX
@@ -138,7 +149,7 @@ refcheckdocs:
 
 cleandocs:
 	$(Q)rm -rf $(BUILDDIR)
-	$(Q)$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media clean
+	@+$(foreach var,$(BUILD_SUBDIRS),$(call loop_cmd,build_subdir,$(var),clean))
 
 dochelp:
 	@echo  ' Linux kernel internal documentation in different formats from ReST:'
diff --git a/Documentation/userspace-api/media/Makefile b/Documentation/userspace-api/media/Makefile
index 00922aa7efde..783c6f880b72 100644
--- a/Documentation/userspace-api/media/Makefile
+++ b/Documentation/userspace-api/media/Makefile
@@ -50,6 +50,8 @@ $(BUILDDIR)/lirc.h.rst: ${UAPI}/lirc.h ${PARSER} $(SRC_DIR)/lirc.h.rst.exception
 .PHONY: all html epub xml latex
 
 all: $(IMGDOT) $(BUILDDIR) ${TARGETS}
+	@:
+
 html: all
 epub: all
 xml: all
-- 
2.35.1

