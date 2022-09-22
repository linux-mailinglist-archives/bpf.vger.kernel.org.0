Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB375E61C2
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiIVLx1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 07:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiIVLxY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 07:53:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009069AFA6;
        Thu, 22 Sep 2022 04:53:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n10so15069675wrw.12;
        Thu, 22 Sep 2022 04:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Zvj5Ptf4ZB5FolY5aGzlhnaDTg1DsgEiRO9E3PeZKHA=;
        b=Jygs2lQ/TVCZaY/iIFWymzrTaklKkKXqFKjhdr8wYt0TO6z/7Mwah9erUI7/G3J09l
         Kc78LiilAiNpxN0zIoab2huAHebpUoUoMpjWxVmG7KD8T7KbjoZ81Vh5o/oSCCd8PoM2
         ad1sE9Bsi8w++yuCuj3VEXECxg+qOjjJXKpVq6fd4vTZFFhiJ8puTADD1JFBnYoqzX5Z
         cS3TqVDxp9MVwuTSNeXBXMs7pJY/7fh4lwWLCaOBqXTJ/sYdpSYXk1IFvRODmtTSld7M
         AA9dQ23PzGSInwtrWqhtyUltU30L0/zPCSH4J538GXdb9umb0KPlG4vMC8fISsfeUU1G
         utxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Zvj5Ptf4ZB5FolY5aGzlhnaDTg1DsgEiRO9E3PeZKHA=;
        b=QAHblKc6bFWK2R/r0+2IgKLTE5TkNkk8zf08ehSphApyohl4DfsvvtW99/7xPFWnzi
         foDFpzh0bTXy4ICp+5XVYnSsuprnMZcxAEclODoKPYI2PVEntAQHJX/0haFmTovCySEp
         LvW5W/tYtFbvNucq3ENUeAZ/35cV9y3zl0n7Fp0jbsdbkaKm2wVJsCkTm5y2oMG1Uymx
         3Ttr0BU9pNUi/BQ+4G3UW4CSYLE6j5UGXID+D2BuUS1aBIcmLrfH8gd9W219hhftzkJc
         nDJ+tPFqKjcGmobCeqw7Q1By/qlHyFacSKCgcxXnyGvoZbQ/6c5SmOp4Jh5YDr4SUN+w
         dQPQ==
X-Gm-Message-State: ACrzQf195AORxjKc8/vwD0p1dWY89tufQx6u2/1TdUQ4MnLnp3iQPKGq
        E4iDnz8AZXPkfWqQkSHHinz+KjoblhaWTw==
X-Google-Smtp-Source: AMsMyM6OEH5Mb7kIP8yBdU3z0Vkhh+/rFUXlSLA3DijHdXK3ieijgkzvrTSiyc619apkE8VDym6eig==
X-Received: by 2002:adf:f706:0:b0:22b:1942:4be6 with SMTP id r6-20020adff706000000b0022b19424be6mr1745731wrp.640.1663847596762;
        Thu, 22 Sep 2022 04:53:16 -0700 (PDT)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id bg17-20020a05600c3c9100b003a5f4fccd4asm5865074wmb.35.2022.09.22.04.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:53:16 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v4 1/2] Add subdir support to Documentation makefile
Date:   Thu, 22 Sep 2022 12:52:56 +0100
Message-Id: <20220922115257.99815-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922115257.99815-1-donald.hunter@gmail.com>
References: <20220922115257.99815-1-donald.hunter@gmail.com>
MIME-Version: 1.0
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

