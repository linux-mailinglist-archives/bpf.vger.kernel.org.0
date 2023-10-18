Return-Path: <bpf+bounces-12578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BE07CE105
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 17:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8CC1C20A99
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617833AC07;
	Wed, 18 Oct 2023 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL059UW4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D720307
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 15:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C79BC433C9;
	Wed, 18 Oct 2023 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697642410;
	bh=Zr2L12JqejcIlTbLLIerbGhqiW1yZZSSNZv8I1yqdSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FL059UW4d7zF4SqEOQDHlI9qWMvJTNfpJxRNMVNqZIf3KIUSQ34igV3GhrJx5clcG
	 EP49FyFunMCWDuWbJ2Rgtu8IUQLVkRt8/ZT+zRDwiQhZsHOwvyY5v0Lp489rPOkKmY
	 GF8TBHcovVrhZr42YPDCjfhdyW5LJ2IRqzQUCD1BZxigG2fCZD8NDLVj1ElMvcTUVH
	 UB/pd4w/YRgbME2VUuZNZzzm+zhGK+1gmmY0vh8SuI7roe4HZSuvY/yiJHldr8pFEo
	 x3u0Ezxb0numpcnNjRr4dIHd1m0q7Ofxvc7PgHSUlKpJgCT4fupNNTGBArHzlcrWja
	 XcJUo4C3bgUgw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	bpf@vger.kernel.org
Subject: [bpf-next PATCH v2 3/4] kbuild: skip module BTF with one-time check for vmlinux
Date: Thu, 19 Oct 2023 00:19:49 +0900
Message-Id: <20231018151950.205265-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018151950.205265-1-masahiroy@kernel.org>
References: <20231018151950.205265-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_DEBUG_INFO_BTF_MODULES is enabled, vmlinux presence is
checked in every module build, resulting in repetitive warning
messages if vmlinux is missing.

Check vmlinux and print a warning just once.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

(no changes since v1)

 scripts/Makefile.modfinal | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 8568d256d6fb..9fd7a26e4fe9 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -14,6 +14,15 @@ include $(srctree)/scripts/Makefile.lib
 
 # find all modules listed in modules.order
 modules := $(call read-file, $(MODORDER))
+vmlinux :=
+
+ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+ifneq ($(wildcard vmlinux),)
+vmlinux := vmlinux
+else
+$(warning Skipping BTF generation due to unavailability of vmlinux)
+endif
+endif
 
 __modfinal: $(modules:%.o=%.ko)
 	@:
@@ -36,12 +45,8 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
-	if [ ! -f vmlinux ]; then					\
-		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
-	else								\
 		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
-	fi;
+		$(RESOLVE_BTFIDS) -b vmlinux $@
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies
 newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
@@ -52,9 +57,9 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE
+%.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE
 	+$(call if_changed_except,ld_ko_o,vmlinux)
-ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+ifdef vmlinux
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
 
-- 
2.40.1


