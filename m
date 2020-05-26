Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF7A1E2950
	for <lists+bpf@lfdr.de>; Tue, 26 May 2020 19:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbgEZRqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 13:46:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388622AbgEZRqR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 13:46:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6ABE8AC5F;
        Tue, 26 May 2020 17:46:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, andriin@fb.com, bpf@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] libbpf: Install headers as part of make install
Date:   Tue, 26 May 2020 20:46:12 +0300
Message-Id: <20200526174612.5447-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current 'make install' results in only pkg-config and library binaries
being installed. For consistency also install headers as part of
"make install"

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tools/lib/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index aee7f1a83c77..d02c4d910aad 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -264,7 +264,7 @@ install_pkgconfig: $(PC_FILE)
 	$(call QUIET_INSTALL, $(PC_FILE)) \
 		$(call do_install,$(PC_FILE),$(libdir_SQ)/pkgconfig,644)
 
-install: install_lib install_pkgconfig
+install: install_lib install_pkgconfig install_headers
 
 ### Cleaning rules
 
-- 
2.17.1

