Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C02E6181844
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 13:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgCKMki (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 08:40:38 -0400
Received: from sym2.noone.org ([178.63.92.236]:54622 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbgCKMki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 08:40:38 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2020 08:40:37 EDT
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48crxT4NVczvjdX; Wed, 11 Mar 2020 13:34:21 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH] bpftool: fix iprofiler build on systems without /usr/include/asm symlink
Date:   Wed, 11 Mar 2020 13:34:21 +0100
Message-Id: <20200311123421.3634-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When compiling bpftool on a system where the /usr/include/asm symlink
doesn't exist (e.g. on an Ubuntu system without gcc-multilib installed),
the build fails with:

    CLANG    skeleton/profiler.bpf.o
  In file included from skeleton/profiler.bpf.c:4:
  In file included from /usr/include/linux/bpf.h:11:
  /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not found
  #include <asm/types.h>
           ^~~~~~~~~~~~~
  1 error generated.
  make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1

To fix this, add /usr/include/$(uname -m)-linux-gnu to the clang search
path so <asm/types.h> can be found.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 20a90d8450f8..3cc0644fd91e 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -120,7 +120,7 @@ $(OUTPUT)_bpftool: $(_OBJS) $(LIBBPF)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(_OBJS) $(LIBS)
 
 skeleton/profiler.bpf.o: skeleton/profiler.bpf.c
-	$(QUIET_CLANG)$(CLANG) -I$(srctree)/tools/lib -g -O2 -target bpf -c $< -o $@
+	$(QUIET_CLANG)$(CLANG) -I/usr/include/$(shell uname -m)-linux-gnu -I$(srctree)/tools/lib -g -O2 -target bpf -c $< -o $@
 
 profiler.skel.h: $(OUTPUT)_bpftool skeleton/profiler.bpf.o
 	$(QUIET_GEN)$(OUTPUT)./_bpftool gen skeleton skeleton/profiler.bpf.o > $@
-- 
2.25.1

