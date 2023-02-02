Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFF8687C34
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 12:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjBBL2t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 06:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjBBL2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 06:28:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17C26B354
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 03:28:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7198861AEF
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 11:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BCCC433EF;
        Thu,  2 Feb 2023 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675337324;
        bh=32mioVtyrCn0BqVkHG2N+EmqHNh9EUvATrFZ9nL5cIw=;
        h=From:To:Cc:Subject:Date:From;
        b=iJH/UCb7iKpchxin440dO+iBtCnBzyanBBZ44dpbcRBo8BiNAoK/IYYwkb1Na/fUD
         VVHa0BK6PkadVu8Go+FCg9YYhOEca85hCf8TCg5LDXmAOBGrq+1A3apRUHlXZhUvvS
         HcuZYaiywScY/+VO0gxqak05JnwGWyE3FAxa4qgHHaYgcc5q4fZJ1b3va9Q856MFGo
         oSQhJnlWC7kz/wjMRpYDO01hxjNjh19anjJ/88dZLtDHgjxU8GsG37AYBvCi94u6I+
         siJM1x4hIqqF+HGTKy3evPiQVhQ1uNk8ykDLpHBJGxDbWw2uaP2V8Br2vZlJ5KdiJe
         pC1cXP1q1QuLA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next] tools/resolve_btfids: Compile resolve_btfids as host program
Date:   Thu,  2 Feb 2023 12:28:39 +0100
Message-Id: <20230202112839.1131892-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Making resolve_btfids to be compiled as host program so
we can avoid cross compile issues as reported by Nathan.

Also we no longer need HOST_OVERRIDES for BINARY target,
just for 'prepare' targets.

Cc: Ian Rogers <irogers@google.com>
Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/resolve_btfids/Build    | 4 +++-
 tools/bpf/resolve_btfids/Makefile | 9 ++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
index ae82da03f9bf..077de3829c72 100644
--- a/tools/bpf/resolve_btfids/Build
+++ b/tools/bpf/resolve_btfids/Build
@@ -1,3 +1,5 @@
+hostprogs := resolve_btfids
+
 resolve_btfids-y += main.o
 resolve_btfids-y += rbtree.o
 resolve_btfids-y += zalloc.o
@@ -7,4 +9,4 @@ resolve_btfids-y += str_error_r.o
 
 $(OUTPUT)%.o: ../../lib/%.c FORCE
 	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
+	$(call if_changed_dep,host_cc_o_c)
diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index daed388aa5d7..abdd68ac08f4 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -22,6 +22,9 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
 		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
 
 RM      ?= rm
+HOSTCC  ?= gcc
+HOSTLD  ?= ld
+HOSTAR  ?= ar
 CROSS_COMPILE =
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
@@ -64,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
 LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
-CFLAGS += -g \
+HOSTCFLAGS += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
@@ -73,11 +76,11 @@ CFLAGS += -g \
 
 LIBS = $(LIBELF_LIBS) -lz
 
-export srctree OUTPUT CFLAGS Q
+export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
 include $(srctree)/tools/build/Makefile.include
 
 $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
-	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
+	$(Q)$(MAKE) $(build)=resolve_btfids
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
 	$(call msg,LINK,$@)
-- 
2.39.1

