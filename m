Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17123D764C
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 15:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhG0N0p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 09:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbhG0N0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 09:26:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2BC0617A0
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 06:26:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k1so15641761plt.12
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w0DZS25dqNWjln6apj95C/bElmocAC2rNL+DbbtPC48=;
        b=glwmcTCaUbofxvceGZtvinhEW4tIV8M/d5MO+4RtpMQ2x2M3mvl2fJ1S/8YE6OqrhB
         XTizafTB+xePqzWt5ZzArUV5rzrLEKGCNufwAvLugCCsBnq8qhFqyL0WknUtDIMivl8r
         Q2AaW/UHdbUhTMazqDZFv8yVA+fSd2D9B2hXO56OUtOltkZclB+zX0Cog9sZDNFx90VZ
         GMBhAZH7dj9MeTihzimZyrP+iNb9lbZMRj0YWshc1Wd0vKmVZUknfpysL3UkC8lcYzFR
         mb6cw0DRKL912bz4vybE4zqLDRFcfjSpuuo21xkCENs//uO8Mjft2Afw0reFFUumNIz4
         1asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0DZS25dqNWjln6apj95C/bElmocAC2rNL+DbbtPC48=;
        b=QmAB2sHf4ZSTm/oYvwbfZFyWhjcsghLRowXbW+lkdS43nwwG96ON5f9mtNJ17SZmBc
         7gMLSTOcLeRsYMmGyjX7/HwC9Fx5i9FqVK/8c7kASnpMoNlNMy6Wg40rX4/eIzfX1rpQ
         pKzcywoytNxVa7o8FuVu0Xmde+T7VcDhYY8o4KWTdiGJe3N0AQ8piomkv49j16v6WoCV
         nWb+zUf22pH3b+sySnW6hqxZMkY8id4rgGFdhZN7aNubP1rcIzEPCa8mxz3bDAuX8XmZ
         NoGbqev3uETmCsUDqmp536x78COw8JKSsKFjx8WBZZjZ2pY4t7THVBZa73Z88eGQpdgi
         G2MQ==
X-Gm-Message-State: AOAM532ogP7U971qsM4inqhWsQG/9XFRIcobApw5Z7yyKGjtsTSxSTHT
        soL15kqXmYffoKYhTSvwUj3EZnqKSiimqw==
X-Google-Smtp-Source: ABdhPJyFZWy5z/AedWb84dZuaKh4v6nr0at0824H5TiuGlWmjUwWyZVeleWqrsgRGczH0tASR7oTHQ==
X-Received: by 2002:a17:902:6b82:b029:120:3404:ce99 with SMTP id p2-20020a1709026b82b02901203404ce99mr18575538plk.49.1627392361455;
        Tue, 27 Jul 2021 06:26:01 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id l11sm2002892pfd.187.2021.07.27.06.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:26:01 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, jolsa@kernel.org,
        yanivagman@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v5 1/2] tools/resolve_btfids: emit warnings and patch zero id for missing symbols
Date:   Tue, 27 Jul 2021 21:25:31 +0800
Message-Id: <20210727132532.2473636-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727132532.2473636-1-hengqi.chen@gmail.com>
References: <20210727132532.2473636-1-hengqi.chen@gmail.com>
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
index 3ad9301b0f00..de6365b53c9c 100644
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
+		pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
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

