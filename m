Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106AB5F843E
	for <lists+bpf@lfdr.de>; Sat,  8 Oct 2022 10:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJHIVk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Oct 2022 04:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJHIVj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Oct 2022 04:21:39 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28828564CF;
        Sat,  8 Oct 2022 01:21:37 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 623C51E80D9F;
        Sat,  8 Oct 2022 16:15:33 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MHHnS3oqJkSU; Sat,  8 Oct 2022 16:15:30 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 5AB221E80D9D;
        Sat,  8 Oct 2022 16:15:29 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] lib: bpf: Optimized variable usage in the btf_parse_elf function
Date:   Sat,  8 Oct 2022 16:21:00 +0800
Message-Id: <20221008082100.4323-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The following changes were made in the btf_parse_elf function:
1. The initialization assignments of err, fd, scn and elf variables are
removed, and they do not affect function security after analysis.
2. Remove unnecessary assignments to err variable (-error).

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 tools/lib/bpf/btf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d14f1a52d7a..fa9d5fa03da4 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -910,10 +910,10 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 				 struct btf_ext **btf_ext)
 {
 	Elf_Data *btf_data = NULL, *btf_ext_data = NULL;
-	int err = 0, fd = -1, idx = 0;
+	int err, fd, idx = 0;
 	struct btf *btf = NULL;
-	Elf_Scn *scn = NULL;
-	Elf *elf = NULL;
+	Elf_Scn *scn;
+	Elf *elf;
 	GElf_Ehdr ehdr;
 	size_t shstrndx;
 
@@ -924,9 +924,8 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 
 	fd = open(path, O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
-		err = -errno;
 		pr_warn("failed to open %s: %s\n", path, strerror(errno));
-		return ERR_PTR(err);
+		return ERR_PTR(-errno);
 	}
 
 	err = -LIBBPF_ERRNO__FORMAT;
@@ -987,8 +986,6 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 		}
 	}
 
-	err = 0;
-
 	if (!btf_data) {
 		err = -ENOENT;
 		goto done;
-- 
2.18.2

