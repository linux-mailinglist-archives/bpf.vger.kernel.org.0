Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B37204F27
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbgFWKhN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbgFWKhN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 06:37:13 -0400
X-Greylist: delayed 74221 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Jun 2020 03:37:12 PDT
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5FBC061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:37:12 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49rjQH0jxYzvjc1; Tue, 23 Jun 2020 12:37:10 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next] tools, bpftool: Correctly evaluate $(BUILD_BPF_SKELS) in Makefile
Date:   Tue, 23 Jun 2020 12:37:10 +0200
Message-Id: <20200623103710.10370-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, if the clang-bpf-co-re feature is not available, the build
fails with e.g.

  CC       prog.o
prog.c:1462:10: fatal error: profiler.skel.h: No such file or directory
 1462 | #include "profiler.skel.h"
      |          ^~~~~~~~~~~~~~~~~

This is due to the fact that the BPFTOOL_WITHOUT_SKELETONS macro is not
defined, despite BUILD_BPF_SKELS not being set. Fix this by correctly
evaluating $(BUILD_BPF_SKELS) when deciding on whether to add
-DBPFTOOL_WITHOUT_SKELETONS to CFLAGS.

Fixes: 05aca6da3b5a ("tools/bpftool: Generalize BPF skeleton support and generate vmlinux.h")
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 06f436e8191a..8c6563e56ffc 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -155,7 +155,7 @@ $(OUTPUT)pids.o: $(OUTPUT)pid_iter.skel.h
 endif
 endif
 
-CFLAGS += $(if BUILD_BPF_SKELS,,-DBPFTOOL_WITHOUT_SKELETONS)
+CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
 
 $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
-- 
2.27.0

