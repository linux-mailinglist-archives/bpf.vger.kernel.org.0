Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AE85A03C8
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbiHXWKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbiHXWKo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:10:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EE97C515;
        Wed, 24 Aug 2022 15:10:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l33-20020a05600c1d2100b003a645240a95so1553766wms.1;
        Wed, 24 Aug 2022 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Zvj5Ptf4ZB5FolY5aGzlhnaDTg1DsgEiRO9E3PeZKHA=;
        b=Ik80QC6/Gh611yuSUjM7EK5K2wu6LltTcpJpWSMN/6sl/xdtcVDgzHCZ9Uz2m/dzd8
         Uc3pdhrEBdG9L3U9TACQquC1dJcb6Xlm8Rrq3Wm4kYcH76h87nzxbrBjQl4nbiSgGebf
         Wm3bbkkPXERfzJxbVo78UcSQHdS8HC0LNyVCEUwF/1RmrzB4OWskdYRCOd3/Umon8OTG
         SO6gR2/mQS/cB/RTFmT/w0ocLBHLXzK6Vclb/bOLF91Vmb9xaP0/U7VKI5ixuQQCzLK8
         HL66P73DX25vpTleQR8w7lJ3vXkvqAQ57Jfa5GT3go69sTQsbV/mMiET6Qlm3B9ifWfI
         jJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Zvj5Ptf4ZB5FolY5aGzlhnaDTg1DsgEiRO9E3PeZKHA=;
        b=O9O+36fe3W9XY7KyAV5MSGO9wLzynLWNDm0FL/jLIfNvGA9GrPeWgehlaysePnL7m5
         I0yrum+n4liz8P/nYCHD8IcewiKbscD5ww84AKe2t6iv2MutWqsKB338p3ssa+Zx+WT+
         quJVbT1NHRn1Asu4G6+WmfCKvnO4vOx4C0zSHKauQUk+hnfQa5Olrg2InS+43AU1NiKV
         98C7AwW9FUkssNjz8zu+4ub53+sbura0RnUxobOmNKzXvfplGetIikpIBCbVkKCAEqzU
         Lb8EAd/dTgx19prU6B2bu+izGk+0JZvrIUf71qrzJ3vmV0TTtYdQXG/wC+uxUVPpKHbt
         HowA==
X-Gm-Message-State: ACgBeo3pPDk+oP3uSr1GibDnRq/jJeFbrAr6LTumxDasOb4WRpmaN22i
        V9vV65an/mESTE6NhMF/iRCbJMyZwuUpvA==
X-Google-Smtp-Source: AA6agR75pwzYNTpDT7w4rOXGSiYWOfOlN8GT36XFTBjfaictWWCV34TwNq5SbssZbd342GzbL59Vjg==
X-Received: by 2002:a05:600c:20f:b0:3a5:a785:7f2a with SMTP id 15-20020a05600c020f00b003a5a7857f2amr6344788wmi.94.1661379040384;
        Wed, 24 Aug 2022 15:10:40 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b44b:882e:8988:f510])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b003a5ce167a68sm3399930wms.7.2022.08.24.15.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:10:39 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v2 1/2] Add subdir support to Documentation makefile
Date:   Wed, 24 Aug 2022 23:10:17 +0100
Message-Id: <20220824221018.24684-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824221018.24684-1-donald.hunter@gmail.com>
References: <20220824221018.24684-1-donald.hunter@gmail.com>
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

