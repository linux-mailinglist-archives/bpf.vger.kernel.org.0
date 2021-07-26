Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2563D5AFC
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhGZNaZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 09:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhGZNaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 09:30:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE40C061757
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 07:10:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c11so11684208plg.11
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxXpK8JZtEoj1akFN6GT4knuE9THbtFb2DqznOSt3lc=;
        b=hg70VGp8IcwcmoTXkgZGmansWDWGFlq4XnEw3MX6hHWG97n3jFbvXw5Rss2uwlGR0+
         Jg7IlzlrHxVpF1zTa2GGDhCx+iqqCIwarL36F+eg0kSPZbseGWImms90ASWHVe4TClpE
         CM4KhgTKAxPfRnmKwyUGRKOTHGRYTifN87lepGBmP7syCI3cgGRS6Rf5zwMwUwm6yrqO
         NcjF/hCK/wOu3f9EN43H0jTVllgNivITlNRAG9uumeKUSf4WLgqGqmu/TAq9Sgi//rdQ
         sLlL5cc/MS/YoRyd3o4t6nFR1wgoSJoJQRTaSRdS2/0ulrPAahBaiLTx6pBocc9OQtJi
         hO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxXpK8JZtEoj1akFN6GT4knuE9THbtFb2DqznOSt3lc=;
        b=Vsl/K6qNk5mCDCsssjZbrtNgZDnf7Cbs5HlCkS8uqqASJmY+2x0zq5SK439XPZfQST
         xm1AsBpyCFB6JgBzYuOdxwXDwii1ZA6LXJZKx0fjtsHL6m+aJIyodGQVmW1Xi4qmmXGM
         OMBHjN+vYTzkeA896VA5hi1ns4QuKcwYB0g2HccEwRH21GqidsrzLtbNv5DIgz0q+ZZm
         a6zlSSn/Z1NdPlHJynqJjsqqM8zp7Xg26S55mq8dhl8BVRHPKxmujjg+Op3RUuZTLBU/
         tWnJ694LYbQwbUsFAM9R6HqRVJgoRe7wFJq5r2sZsm+/7kzJazOgbx/D00rAkJrhTrHZ
         rhPA==
X-Gm-Message-State: AOAM530gIfMDdBJi29JBlOTWjxsGZwIeQoPeP894b+MdwYFWRg7fMLNt
        UPvQuAUPeLNJ9OLmslN4MKPXBq74AYoD3A==
X-Google-Smtp-Source: ABdhPJxbT9VjCln7zLRs+foHcQ4V+nYjwUJTifj8LQ9meDlGmnu4yebdb/pJjQM5L8t3u6eXJxHVpg==
X-Received: by 2002:a63:ff25:: with SMTP id k37mr18307428pgi.353.1627308651433;
        Mon, 26 Jul 2021 07:10:51 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id r18sm4847074pgk.54.2021.07.26.07.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:10:51 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, jolsa@kernel.org,
        yanivagman@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v4 1/2] tools/resolve_btfids: emit warnings and patch zero id for missing symbols
Date:   Mon, 26 Jul 2021 22:10:12 +0800
Message-Id: <20210726141013.2239765-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726141013.2239765-1-hengqi.chen@gmail.com>
References: <20210726141013.2239765-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kernel functions referenced by .BTF_ids may be changed from global to static
and get inlined or get renamed/removed, and thus disappears from BTF.
This causes kernel build failure when resolve_btfids do id patch for symbols
in .BTF_ids in vmlinux. Update resolve_btfids to emit warning messages and
patch zero id for missing symbols instead of aborting kernel build process.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/bpf/resolve_btfids/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 3ad9301b0f00..3ea19e33250d 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -291,7 +291,7 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
 	sh->sh_addralign = expected;
 
 	if (gelf_update_shdr(scn, sh) == 0) {
-		printf("FAILED cannot update section header: %s\n",
+		pr_err("FAILED cannot update section header: %s\n",
 			elf_errmsg(-1));
 		return -1;
 	}
@@ -317,6 +317,7 @@ static int elf_collect(struct object *obj)
 
 	elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
 	if (!elf) {
+		close(fd);
 		pr_err("FAILED cannot create ELF descriptor: %s\n",
 			elf_errmsg(-1));
 		return -1;
@@ -484,7 +485,7 @@ static int symbols_resolve(struct object *obj)
 	err = libbpf_get_error(btf);
 	if (err) {
 		pr_err("FAILED: load BTF from %s: %s\n",
-			obj->path, strerror(-err));
+			obj->btf ?: obj->path, strerror(-err));
 		return -1;
 	}
 
@@ -555,8 +556,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
 	int i;
 
 	if (!id->id) {
-		pr_err("FAILED unresolved symbol %s\n", id->name);
-		return -EINVAL;
+		pr_err("WARN: unresolved symbol %s\n", id->name);
 	}
 
 	for (i = 0; i < id->addr_cnt; i++) {
@@ -734,8 +734,9 @@ int main(int argc, const char **argv)
 
 	err = 0;
 out:
-	if (obj.efile.elf)
+	if (obj.efile.elf) {
 		elf_end(obj.efile.elf);
-	close(obj.efile.fd);
+		close(obj.efile.fd);
+	}
 	return err;
 }
-- 
2.25.1

