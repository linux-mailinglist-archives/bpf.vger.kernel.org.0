Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C185F89DF
	for <lists+bpf@lfdr.de>; Sun,  9 Oct 2022 09:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJIHJj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 03:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJIHJh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 03:09:37 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A083E1F5;
        Sun,  9 Oct 2022 00:09:34 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CAEA81E80CAE;
        Sun,  9 Oct 2022 15:03:29 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2Egupsgxpkmd; Sun,  9 Oct 2022 15:03:27 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D3C5B1E80CE4;
        Sun,  9 Oct 2022 15:03:19 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     lkp@intel.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kbuild-all@lists.01.org, kpsingh@kernel.org,
        kunyu@nfschina.com, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org, yhs@fb.com
Subject: [PATCH] lib: bpf: Optimized variable usage in the btf_parse_elf function
Date:   Sun,  9 Oct 2022 15:08:28 +0800
Message-Id: <20221009070827.525694-2-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <202210082050.nPzAbV1v-lkp@intel.com>
References: <202210082050.nPzAbV1v-lkp@intel.com>
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

