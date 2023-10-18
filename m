Return-Path: <bpf+bounces-12579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A51D57CE10A
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 17:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607F31F22FA1
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E143AC23;
	Wed, 18 Oct 2023 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTIyxfwr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692220307
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 15:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED347C433CA;
	Wed, 18 Oct 2023 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697642412;
	bh=64NbOJwL+HDqWyuM6JoXFyBcAlHXP3zz+QUuLv6Cm7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTIyxfwrpTY5bgbva8rPbkcGlgqoZai0aO3PkJiKLsjwlaQN26q9Yhf7zRd2wjkRW
	 WZduFe/lFbU/q+9u4epT/mVv1LqRuauO0bz5OWF23Kd8JMxngIYbgEwwc+f4kmivhh
	 VJTyepbpLsgfF5FtZVGl8dMHPuvoQ8QD6No7cMYjk689j0+PdrMxAx2gcLvk6LY2TW
	 Ety129FzUIr6FfwD15PVqI3wl9DSL9mvUBfMHnmNmKqGI6SnKNxfdm/eFbapyE1BFX
	 gpiFW89j2Z6bS6GGInAnAKbVxMu33QTPYYdJA91bLmvH3+wqGmgTWgilv6JfdU0Nwc
	 KdvBwAIq+VCYg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	bpf@vger.kernel.org
Subject: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
Date: Thu, 19 Oct 2023 00:19:50 +0900
Message-Id: <20231018151950.205265-4-masahiroy@kernel.org>
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

newer_prereqs_except and if_changed_except are ugly hacks of the
newer-prereqs and if_changed in scripts/Kbuild.include.

Remove.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Fix if_changed_except to if_changed

 scripts/Makefile.modfinal | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 9fd7a26e4fe9..fc07854bb7b9 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -19,6 +19,9 @@ vmlinux :=
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 ifneq ($(wildcard vmlinux),)
 vmlinux := vmlinux
+cmd_btf = ; \
+	LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
+	$(RESOLVE_BTFIDS) -b vmlinux $@
 else
 $(warning Skipping BTF generation due to unavailability of vmlinux)
 endif
@@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
-		-T scripts/module.lds -o $@ $(filter %.o, $^)
+		-T scripts/module.lds -o $@ $(filter %.o, $^)		\
+	$(cmd_btf)
 
-quiet_cmd_btf_ko = BTF [M] $@
-      cmd_btf_ko = 							\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b vmlinux $@
-
-# Same as newer-prereqs, but allows to exclude specified extra dependencies
-newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
-
-# Same as if_changed, but allows to exclude specified extra dependencies
-if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
-	$(cmd);                                                              \
-	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
-
-# Re-generate module BTFs if either module's .ko or vmlinux changed
 %.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE
-	+$(call if_changed_except,ld_ko_o,vmlinux)
-ifdef vmlinux
-	+$(if $(newer-prereqs),$(call cmd,btf_ko))
-endif
+	+$(call if_changed,ld_ko_o)
 
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o)
 
-- 
2.40.1


