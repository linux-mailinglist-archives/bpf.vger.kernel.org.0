Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE594446B52
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 00:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhKEXpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 19:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhKEXpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 19:45:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D91C061570
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 16:42:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l3so8258730pfu.13
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ABQOeB9AdPtbQJY+ocY7DetEIFVmOp4s/zu0NqDdUfI=;
        b=i8Fj+Oq8P8UcUZWHmsE1AsEGw/QjjjLewox2Cb0GXcWecBatFUr28ykZFsWLCdUbtJ
         a7p0rJRKooJDAydazVXW/y/hW21xheV1TRIscYZpWdYfUtUAZq8vLz0ySxlOaDBs/1Wu
         iDwRVwTEHCtSDpyGanVpCrfDWwOvB2d/45fUlGGP3nz/Yz/659e5VsqfBEf3poj9AU4z
         AUlprp3lyuEG0OIV++Plu0s9gfxMBj0n0hI+8dYA+izygQ/KT25ELdoOrLETUOpeeTvG
         d9zVUdCFluxkMOMyMMOhLUra2IUaPhrUOLPULR44Aj+j0AYpAYTBqvkTRrJ4NsEMPPTH
         4ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABQOeB9AdPtbQJY+ocY7DetEIFVmOp4s/zu0NqDdUfI=;
        b=3wZ3RGBGSCgWXyvy1OPVwNe/Qjo/5A8VRzVY3zPePd2ug0WBrUivumVmbJZvM196YR
         98mTpY0SwW+lCTRy4noixQEc74J9+T0vHN7FDyKrU5TX0n6OOi4toRyOpda9gXhndPY6
         yqdDrLv7bAtJ0Yb9BOw55F12JAQc/7nrP+bYXAxEk/JutI/Qpz/Flirpx3Ku5RAbKWhP
         5PmEEkXOq2A2aSRdlW9LLvaqkfRAYt3nScHL1sztsfk3woXRgLAzXMDzuiFKtGB/5pjc
         muRSI+yHlXMX2MjHcxVVA/pPk76+yOC/oC1e0r4jio3vZFs6//9ZTiFvRSaYRrSsd52C
         72dQ==
X-Gm-Message-State: AOAM533dT/K0Y8xQ4xn90tM7DqzkFjFESsdZQxzKLTqTFCd6eTn2YLtE
        kS60Gz5PplcULaglwYFBpCiFj9gFMa8QCw==
X-Google-Smtp-Source: ABdhPJzRdctZwCwl/Cm2F+rpyFL7d7kbkzQ7CQeQN/6HuszoSLTgc66f+EQxFZNtunbAV86HMLqv1Q==
X-Received: by 2002:a63:bf41:: with SMTP id i1mr47434805pgo.412.1636155772564;
        Fri, 05 Nov 2021 16:42:52 -0700 (PDT)
Received: from localhost ([2405:201:6014:d916:31fc:9e49:a605:b093])
        by smtp.gmail.com with ESMTPSA id m4sm10320992pjl.11.2021.11.05.16.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 16:42:52 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 2/6] libbpf: fix non-C89 loop variable declaration in gen_loader.c
Date:   Sat,  6 Nov 2021 05:12:39 +0530
Message-Id: <20211105234243.390179-3-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105234243.390179-1-memxor@gmail.com>
References: <20211105234243.390179-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=memxor@gmail.com; h=from:subject; bh=641ALvgZw7a8zc4U/CSTvGJ0wLN+uKQSpctSEAZW8Wk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhhb9AZCxLeFfs1X2183T5UeQ4Qv259tzQ0z1NhcQZ 8QDnTpaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYYW/QAAKCRBM4MiGSL8RykMqD/ sEJgKiMOQAhXupIfMOIds91FV/AxLpVbMSYZpAKP4nIq6UhVgud477vYlwL5oqaxIcENy5tC2PLZGb UOVwtMHeuEs12NQ2C4ZvPm5SkpV/AtTe5puX8CYBPxk61Mr40kwTNxeV+f+VEwGcmqLvvKzxwm5PKC Ti3hykQrohlpfRjoOkBZvmz4JvRYudZBKxTeyot3x3Ia1iS+YnVfOLgi28l6/IuH7dFx9g5i0e1hZ+ UX6cIQOx518oc5tkZc4f7IH/QNTG8G3WWMV0FaEZHM5z7vO+23UKc5EfAD7GrN/sGtfe/39SWmndVO csK/nZ7o4rc9YM1Xd5782OWVDWacnbeX9ojoWssxXL+jlJYk6XaxD7o1zf+L7nsG/sO+eZ8foUNF1C l4yEEW2T52f0oTWIw+ymsEQaLgaI3SI14w2NYPhBLKrGcDQV56MHVEY6babbntgBp3Y7fQox5qf6iv sZIxMOQRIR9nmDia6LW2ruMJIA/Pj/Ohk49gxh6s68u4L7jnb/A9NGxaj+J1gAe4IvaS6oUjMj+asU RnfLTBIMno2ATEmW90nT9noCMiRHFv+74nwqqO/ekGjvG9pdDVqC87M2HJnT7tJBZaUwaD+hM65sq7 ZrGIU3uBxK2ixG0qEZc6oS7QtSh0QorOLMhpYIj09lVvP5crS+D/GvG7XaMw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Fix the `int i` declaration inside the for statement. This is non-C89
compliant. See [0] for user report breaking BCC build.

  [0] https://github.com/libbpf/libbpf/issues/403

Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC relocations")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/gen_loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 502dea53a742..2e10776b6d85 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -584,8 +584,9 @@ void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
 static struct ksym_desc *get_ksym_desc(struct bpf_gen *gen, struct ksym_relo_desc *relo)
 {
 	struct ksym_desc *kdesc;
+	int i;
 
-	for (int i = 0; i < gen->nr_ksyms; i++) {
+	for (i = 0; i < gen->nr_ksyms; i++) {
 		if (!strcmp(gen->ksyms[i].name, relo->name)) {
 			gen->ksyms[i].ref++;
 			return &gen->ksyms[i];
-- 
2.33.1

