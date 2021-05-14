Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B80380136
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhENAiB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhENAiB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:38:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50548C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso439323pjx.1
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qRHzW6QO90DVGbLxl8MKyd/t6ZVkIgmLqFGkua0eZnw=;
        b=ilNSNeQO2zgEOiN7y7ZP2SysoClnJ48l23Ak4uE6wA310yHz8R3T7mXXFVDoPCiw2S
         ZbQtLBBlAj8ZFscfWaEUlHUG9BcgBba6DmmESwVZ8fk0mIc59bPyCwaf2ZhHYdGDnU6a
         TknvFmSPPTGl6DnmQ5473/O5pWz+pN2EhI3h8LBltRGqcboP/YRqC2bCxMTsMuH8RGoK
         NrVEATcRvCTnLuieUFJ/QpYHzJ5UMCnv2n63KixAIKBSum4sNGmh65uK9s1uCIMDkjSs
         hAZjKAccu9qLlCa3FmK9w75WD7qCP7DXvdD/CZOL9Y8ITjVBfylrf0ZrKG63ZZWyNxcs
         ANfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qRHzW6QO90DVGbLxl8MKyd/t6ZVkIgmLqFGkua0eZnw=;
        b=fI7TiCNN1TgXf2kK6NwW9vw6TVYn7LkY1fUS8KRk/L0Q2gL+6u9E4DOnW7ZRLuI+v3
         NRviCoi3TPXlFqUWCuxiHS8ISbvBcljc0HG7T5epyrkDCArB99GoNuuuenvi3px+uqFJ
         9ucCTvri0jnOwXrz8G+JssjdvlUJCoWE4k3+9FsvcGGPjvZyqvNnN0IwChihyfmbPzxt
         lxhwLXzg5rU3sXtM3fIkpl/hSqJio/ByVac7T2a5yCXDvmlGsr8yDyV87MFz2fcZSQEt
         3Z4WXeqHYdQyEPqvy0dIGoTFAEapbEfp/NPYNkR23wJWtOyoLKYge1aFEaUZV61kG282
         Lacw==
X-Gm-Message-State: AOAM533QpIBR2xHG0FP5dyOsVCTa+gZPa47FURP9dTZJJj9Kuk/ZqOmK
        0+PAeIbLquIIlytghaRh6GA=
X-Google-Smtp-Source: ABdhPJxIEI/3jlWhpLZAagRx37D7KSkPjK+u7M70yd7mRUBBrDuc8f5pB5C0G6t9y8GBjwn/Kac19A==
X-Received: by 2002:a17:902:bc81:b029:ef:3f99:9f76 with SMTP id bb1-20020a170902bc81b02900ef3f999f76mr20829476plb.33.1620952610833;
        Thu, 13 May 2021 17:36:50 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:50 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 13/21] libbpf: Preliminary support for fd_idx
Date:   Thu, 13 May 2021 17:36:15 -0700
Message-Id: <20210514003623.28033-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Prep libbpf to use FD_IDX kernel feature when generating loader program.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 708b94ad9893..0ba0e80749f8 100644
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
@@ -6383,19 +6387,34 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 
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

