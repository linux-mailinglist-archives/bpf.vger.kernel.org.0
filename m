Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490083D4E15
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhGYNib (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhGYNiV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Jul 2021 09:38:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF862C061757
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 07:18:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so15955000pja.5
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mZ0BAaAcHRJOfV2V/eJh8net1ldlY2knOYn3v6tRuTM=;
        b=FoiM4rRXuJU/Mt2hw1nJE8N1j85IW4KrRe0n4jetnYM2JvXFTkSGcq75ynBn3Afdun
         wnvXpsUfBPvyNsMz5OaUA5QG4FkKIcoRqGi22wCH5P59CHpMcT5hwsyIeXvr9qW00Wqf
         2WBfEARU0XSRxYzSVGfgFkOm+7hj1y+6X43tMFImrdQk6Sj1DVBLvl6MIOjALWUEX3me
         bQ94yYnemP1bHyiHSifJ6/ByjS1tkfwZOG1etyHrDh/yqXbXEhovPAdCtWpTzMkSLOAj
         T2FazszGU7bbX53C4VR88Fbu+xOTAaTSbjJdpcazKUjrjZl1WqvNvSv+ebi0MO8xhyNh
         E6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZ0BAaAcHRJOfV2V/eJh8net1ldlY2knOYn3v6tRuTM=;
        b=PphdN3Ojb86lajW1XA8P7up/eLYROaUBW9Z/LXnatr318hLkIvk3nWo04lMObl6lBa
         B81OY31Mi/IT88snE3lhgpK3KpvRygsV95jMMpOiiiWaGqOmDYyT0vNy1zMN1FW5zYo5
         9qfNVhhljpJcVyoHYY3ON1glVwuqEfVlZUxesWU8++ck5r/BUH3K80wE9xIIbuvoodMa
         QW5Hrfwvla4dJQIg04naSPmZTVPNxEX4FC5ZhV9c33hEyFmnyZViGzFy3E/4Qn14ydPe
         Iua3n3uqVT7hXPg/tyDEaDJ8UOejv1W/0ONTnfr/upUMvs8Iju/xkNz5jaOfq8o9NT1w
         ANwg==
X-Gm-Message-State: AOAM530P3NWdU4ciK/xhrapKBFu184dTtoj4paNSrgMQlRoG0ClLKgim
        1UicIdnLATGblfFxcYOHwcUTWGwVkVjQFA==
X-Google-Smtp-Source: ABdhPJxUeitwsYOR0gvUdRaIP1KOmq4gcPmY+n96J3n5vPS96RboeRQpXOzpvObV1N9bbAQk3tZsiQ==
X-Received: by 2002:a63:67c5:: with SMTP id b188mr13896761pgc.333.1627222731281;
        Sun, 25 Jul 2021 07:18:51 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id q17sm48055188pgd.39.2021.07.25.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 07:18:51 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, jolsa@kernel.org,
        yanivagman@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/2] tools/resolve_btfids: emit warnings and patch zero id for missing symbols
Date:   Sun, 25 Jul 2021 22:18:13 +0800
Message-Id: <20210725141814.2000828-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210725141814.2000828-1-hengqi.chen@gmail.com>
References: <20210725141814.2000828-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kernel functions referenced by .BTF_ids may changed from global to static
and get inlined and thus disappears from BTF. This causes kernel build
failure when resolve_btfids do id patch for symbols in .BTF_ids in vmlinux.
Update resolve_btfids to emit warning messages and patch zero id for missing
symbols instead of aborting kernel build process.

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
