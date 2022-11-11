Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85EF6262E8
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 21:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiKKU2F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 15:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiKKU2D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 15:28:03 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E217845D3
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 12:28:00 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g24so5086448plq.3
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 12:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLzoA6C1VcOgFXhrd/ol3IikbXD4CC3ueplXHs8iYOY=;
        b=c+/8MK3wQWTOan1ehxGSmSq01U8HmorcdxM5upYlHePxH5px0hczFfUcEUKrR4D1CP
         ZyMOTIVz5/7eozMdcMTB+68ChzWONqIm28fOdrnzQIhZfCxHKH6U8yh7eiSZUQqngG5G
         t74xZAz5w4P4J+4Rni0Kzj2GUoujqM8oER7AKkW5ItM2D05pGZCVWcmpxVts5fWKlm8T
         Kp3oO1jeCRCow+B7oC7U6gBHZHBLKm+9X/yF2FTLn9jhTnAZqknpdSumgwFIYvYDONrC
         d64vz7/9/Z4+abS+HfnKnG6mUvLBSq9nlWKAO+fVsNfWcg1amn3GvJ+biXJlCb58KN/Q
         9Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLzoA6C1VcOgFXhrd/ol3IikbXD4CC3ueplXHs8iYOY=;
        b=mhDoBH51a7TcZ3+q6Zh4gqh0sv+W8564jPyO531tBpFLkof8qYTMSHukA+rNXgHJsI
         +SbqXh+L+RDjKB8eA1huZn1lg8EnHgMlml3vCo9fEnbPfVM/Nhi4Fa9qO3AzvUX9Ndd4
         TbPdCbR5VslMgleNteMeucJFUlp+zd+QPNBj4VKncOqnxH1m69z+cUz8JkJH68PUBnTU
         xiY7qTi5BiPfGv6q6bD6V7Rw53FO0ZRcVK0zr/0n8VGrAw/6qLj7YlQtr4G4cHNO95Bc
         n+H/Xp/FD11TM4dLVCzvUr71baL5tQStilzWxc1b8qfc+nZ8llnLRmLFsOLIRQgMfP+a
         LMpQ==
X-Gm-Message-State: ANoB5plDeApmWJzuYU9RjqoWRUga5iP/moLcgOqfL0E8OeF4rw/Wzhpn
        QRx7RVsCKVsQxBenPyVRwRTrzJ4IqQgn4A==
X-Google-Smtp-Source: AA0mqf5ynfNWPE/XD+R8LSQViISG6KQKP+dc4BMrQi6Zg+1kD5LyGkyBdGkFA99G5icwyNqevkdUTw==
X-Received: by 2002:a17:902:e154:b0:187:190f:6aa7 with SMTP id d20-20020a170902e15400b00187190f6aa7mr3898207pla.131.1668198479750;
        Fri, 11 Nov 2022 12:27:59 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id 8-20020a630e48000000b0046fabcb5150sm1680410pgo.93.2022.11.11.12.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 12:27:59 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH bpf v1 2/2] selftests/bpf: Add pruning test case for bpf_spin_lock
Date:   Sat, 12 Nov 2022 01:57:19 +0530
Message-Id: <20221111202719.982118-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111202719.982118-1-memxor@gmail.com>
References: <20221111202719.982118-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319; i=memxor@gmail.com; h=from:subject; bh=4Lj0SCiBlMxIlznwRSj1DNFWI2gsST6+I5SQtbjxYuQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbq/9Hgt//Y33Uyjux3qOe3w3tfjisu6a9w1AccFg ee8KvpOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26v/QAKCRBM4MiGSL8RynkcD/ 4pf3XXjOV4dh7rBm7Z90/c51WZzKud0lL7e/C3rKgwMX9E+dMYXQOVHzX1V+K1mKUwITTwnxL70/uK joz0P8e27glKoOa2h1rc+9Kr0v9DXgZEE3kc17v1kf5u09HeMZVdQwNnZF185IC0OsVAg7B2BeiCl9 LszMvaCKnU7UVnA/UGMygeA6zN+ptoAPaYXUwsjxm8KbeBoOzOMf+Xm54pWN23//NBnIedQZXvj40n p/GQwdpEtBMpIoiadrn3pT7k38TH0BYqolJluz5Og8FHPdhzu7VnHSEhR9sXPXWoD/gKJdmH34285M MEiGZF3HPJXLGG3HOYT+wcsy3TK/HzmIG2BrDrbjn+cE/8WQGYywXaioM/B7nE7oFP9w7WhUIdZjtn 0pGDt9UK6hY9d0SN8Hq/z1SLIlu/erF4lZD5S48iGvPiiqflY/HwpcrjBjRxiuJ4G9rQO4XyVcwI7b xFb4ZPZnD5Z2h0Z7z4xwWVeAng1oN0KK89DtBHTAMc+/yzLP3cis/eY3KQQsywNOS8MuqNUjlSEbOo tPfX8S62IbFRzMrzk1DMaQOiiIjQMQc8ykaoy67px/+8scQ0sfFj9IZP5zXzo/zSMvefHZY6tgm6h+ X77jbXaum1MSdGzJPqVD4LN0ZO0DUV4OJfYVaQniwr+EY4tFgATvmbkfFUtg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test that when reg->id is not same for the same register of type
PTR_TO_MAP_VALUE between current and old explored state, we currently
return false from regsafe and continue exploring.

Without the fix in prior commit, the test case fails.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/verifier/spin_lock.c        | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/spin_lock.c b/tools/testing/selftests/bpf/verifier/spin_lock.c
index 781621facae4..0a8dcfc37fc6 100644
--- a/tools/testing/selftests/bpf/verifier/spin_lock.c
+++ b/tools/testing/selftests/bpf/verifier/spin_lock.c
@@ -331,3 +331,42 @@
 	.errstr = "inside bpf_spin_lock",
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
+{
+	"spin_lock: regsafe compare reg->id for map value",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_6, offsetof(struct __sk_buff, mark)),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 1),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_8),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_spin_lock = { 2 },
+	.result = REJECT,
+	.errstr = "bpf_spin_unlock of different lock",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.flags = BPF_F_TEST_STATE_FREQ,
+},
-- 
2.38.1

