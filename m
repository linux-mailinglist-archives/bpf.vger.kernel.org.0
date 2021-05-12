Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1037EF39
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbhELXAF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346932AbhELVpH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:45:07 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E2EC08C5D5
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 33so948945pgo.5
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8AcIl5md7fk2g3CMFXafxtbyBSfIRUWUdNKveJZBCOk=;
        b=Mct98C1+Apa86lMtupHGq/qC7oclNFP6fKggR6B4P4GrgwijuVVY7zOIWmxZz5niRg
         mQRykmKbbzCHzIQmLLZ6YhBm5ZcLybAYyzWTblUuecgIUCOtj40Xs44Unp/Av/g9Ayoc
         0w0B9jU190TyzuMJv3Jf9IBuPFxuiHaUpcB3HR/OqLnn+/oaomUNs6YKFmBAID/pqMMb
         GjymaZ85/PIXPBjQO+6OGhl3apLBei9x0s8uoxbAKj5dP1Or9Rtm8XgWpo9iKDsHhwvr
         PaaeeNppADPGT+9pJsHgxgW0lCGzW8Eq/Su/oM3hoeifQtCDO+GEPw2WANC1TPbf8z/a
         K7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8AcIl5md7fk2g3CMFXafxtbyBSfIRUWUdNKveJZBCOk=;
        b=d2zr1rTEmCtCO3mG8S+W86uW4mcKHBkrsBtiNkTOtblBds1jWaaeF/0Q8QZ7RRgllN
         g/DORQfgBP6MAAKXp4LxW989MZ/HEffv/8jh5id7mSJIHmyUM9p7iyi6CmKQuWSr1OOB
         bRo1cDzuqP4eKYjMTANGYfVjA99HQumthHf5XI4Qp5bMJ5a8ME8NW3fKTUecFabzCTtA
         hPRb8JJI5BoSrSd+o6xQEiu4kOmXVtespnn+fOUpyrNChGuiLXQCIbCorpLh2QhbLhZM
         Xa5x9uaSvjdbtw/6ZaFWmMwyoSBq/O2Zpm+rBFYNUZGALf/yk4j3aHtZIFUEE3TTVzDr
         bEiQ==
X-Gm-Message-State: AOAM531cmtkB05xz7okOOR4VREi7nQuJgOqq0L+7fiWdDDAnPAB9J4xT
        nI/MEXGpYYASTGPd/W9erQo=
X-Google-Smtp-Source: ABdhPJzmztSdF2lUS+raUSFDA8vVNmxeabiA5MWZIHWje6E7lnI07rITSUd+amxueF26kR3hIGVjiA==
X-Received: by 2002:a05:6a00:1742:b029:2cc:b1b0:731c with SMTP id j2-20020a056a001742b02902ccb1b0731cmr7429319pfc.15.1620855204514;
        Wed, 12 May 2021 14:33:24 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:23 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 13/21] libbpf: Preliminary support for fd_idx
Date:   Wed, 12 May 2021 14:32:48 -0700
Message-Id: <20210512213256.31203-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Prep libbpf to use FD_IDX kernel feature when generating loader program.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8ea6120c9849..276d51527a86 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -412,6 +412,8 @@ struct module_btf {
 	int fd;
 };
 
+struct bpf_gen;
+
 struct bpf_object {
 	char name[BPF_OBJ_NAME_LEN];
 	char license[64];
@@ -432,6 +434,8 @@ struct bpf_object {
 	bool loaded;
 	bool has_subcalls;
 
+	struct bpf_gen *gen_loader;
+
 	/*
 	 * Information when doing elf related work. Only valid if fd
 	 * is valid.
@@ -6369,19 +6373,34 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 
 		switch (relo->type) {
 		case RELO_LD64:
-			insn[0].src_reg = BPF_PSEUDO_MAP_FD;
-			insn[0].imm = obj->maps[relo->map_idx].fd;
+			if (obj->gen_loader) {
+				insn[0].src_reg = BPF_PSEUDO_MAP_IDX;
+				insn[0].imm = relo->map_idx;
+			} else {
+				insn[0].src_reg = BPF_PSEUDO_MAP_FD;
+				insn[0].imm = obj->maps[relo->map_idx].fd;
+			}
 			break;
 		case RELO_DATA:
-			insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
 			insn[1].imm = insn[0].imm + relo->sym_off;
-			insn[0].imm = obj->maps[relo->map_idx].fd;
+			if (obj->gen_loader) {
+				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
+				insn[0].imm = relo->map_idx;
+			} else {
+				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
+				insn[0].imm = obj->maps[relo->map_idx].fd;
+			}
 			break;
 		case RELO_EXTERN_VAR:
 			ext = &obj->externs[relo->sym_off];
 			if (ext->type == EXT_KCFG) {
-				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
-				insn[0].imm = obj->maps[obj->kconfig_map_idx].fd;
+				if (obj->gen_loader) {
+					insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
+					insn[0].imm = obj->kconfig_map_idx;
+				} else {
+					insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
+					insn[0].imm = obj->maps[obj->kconfig_map_idx].fd;
+				}
 				insn[1].imm = ext->kcfg.data_off;
 			} else /* EXT_KSYM */ {
 				if (ext->ksym.type_id) { /* typed ksyms */
-- 
2.30.2

