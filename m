Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E25B59ECE5
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 21:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiHWTvh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 15:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiHWTvH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 15:51:07 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262644F650
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 11:55:07 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w19so29267186ejc.7
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YW1sLT45zOLuNc7+I1Go1iXbU4Fm2wky+Wgtd/aYq5c=;
        b=ewRAWJ1G+v91jSkODr5zOtnscMNiBt5ZcmPLd45c3yT0S516T7efN/PSKD0ooeCctz
         K/DqHlqkVzJcvHoAQcRz/xMeUo91MgRjXN55ZuFDmlMfZprYCnVLUoIa5EmhBP9OjqM1
         OkUB5oTwYzP7wcVQKapOEqgi4ZGuR38sWaAJpGIK3yT3Qk5wcwln7ZGB9xgFojKAyYIY
         kAKvJ8/vqM2gJcf5YmSr3VAkPlixDoUessaZx0XWxl8CD2zlWBOC305w87nl+9h8boeD
         baUVsTHuIXVEGVFMj/4sXrWbXg0SAzjcYgHjgLEN6AaHceePzfK1I7yzoL1IjtUtZDU9
         eY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YW1sLT45zOLuNc7+I1Go1iXbU4Fm2wky+Wgtd/aYq5c=;
        b=TRupsNciJcpMM2doyULAwyhB5FRyk5ocHgwe6ZA0Y57pINmb9dU1SYKollZAmqHqgl
         icGb4S3NnZ+FKl8zD3SugzuGiZa4hqINxo+fk1ceChI82N9CyPfCMBYeZUXh98rMXMCv
         3oWKHHVRbJoPQPLtd8HBA9owVdM2R7Ok4BSabY1NStXK0YY+DYdRrnWeVElk2D8o6ZoR
         A4Xtz68MgnSTKPMKvGIfW+4UwE4Hw+5XUVkRDdluOaG9gLNvDciqzkTtgHQsycApMjAZ
         167Iww+ygbz5w3KhEzEFariQdyWLV2LiMSKugzJJ1U6rarKwNVFp+yq8G95s1/TWrV09
         563A==
X-Gm-Message-State: ACgBeo0j0AiFBZGJkWQmoBBrKwmqPESbfzRG7QXSoA90JRNDUR4yQbi3
        U8Zh5tQvuT95yGVpFvjn+GVFFbosFwo=
X-Google-Smtp-Source: AA6agR7uO1sQUVeisgYlVX1eqjhNRyXemCDiqu7iGvgjeM+nSiuWQ6zZOqHl6acvuxH1ZBCNZeuPHA==
X-Received: by 2002:a17:907:2c57:b0:73d:aa21:8027 with SMTP id hf23-20020a1709072c5700b0073daa218027mr649715ejc.42.1661280905312;
        Tue, 23 Aug 2022 11:55:05 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7c44d000000b00446639c01easm1814271edr.44.2022.08.23.11.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:55:05 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 2/2] selftests/bpf: Add regression test for pruning fix
Date:   Tue, 23 Aug 2022 20:55:00 +0200
Message-Id: <20220823185500.467-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220823185300.406-1-memxor@gmail.com>
References: <20220823185300.406-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; i=memxor@gmail.com; h=from:subject; bh=kGl6AEuTvv/gD7y+LLM2RPoiGQhu9X82DSrHCzmE5kc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjBSIEpcTs7KUtih6Yxfb4whexlvXZI6pm0DUiZM3h LDYivh6JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYwUiBAAKCRBM4MiGSL8RypndD/ wNPK2h6hlY1jFgevVh9umU8LaiAE9jywPVBU5KgZxlboqyOpXfkbV2otjv8ofUd3p06JSRWWku4QiH x8Qyb4qtKY7BPLRO4Pgvh3Uy5r6UqVcBHqOIsU9Rd7GNtyYfX9IJdmuFmKAKiMYYqKCYqHHYdfMTo/ fRjh/hWEEkaWb6EiX3EaB75cEClqrfyNB4KRkiZCP02aR3Kut4Zm1ag5b/fYcj1RDKMZQtazGkDkEW LAp86961hdPM+DIu/xK+aWgJtzDLr1ODKLEFAtpjtScP8FS2t5sEsOxLGv1tApmqNSEHpWtMqSM9Dp sC9/gISqclWv4hKD6FlUyIR1bGo7HZmHoCeURsvrNpRvEz575SmYGtq1ncNnbTck+tKwu12faTj0TW eAFcTsdgXOsXG4zSR8WMlx/dZJoukAuH4hGrlBB0Ab67CGDSpa68VVXfJ5hwxzjzISAfXSl4cAliZa UpCNmhKFbkledhCsh0jvX8ggP03LO39Elq755oLBugAoBZzvPPLsxvLyLzrhT2Hx5CxvkK4KnD4Ww6 rQbKiPLf0VSDnbrYKXX+Cc/cABcGvYEdviP79duMQEPo3j4GXLsdA2wJSKgWY1Fni1QD0Mod+6c5vI SrBS5LGJgXf0UFZX6/r9rhVvwUiE3I34fCWJBIOBe6+gJNpXaEV1EB3L+Uuw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test to ensure we do mark_chain_precision for the argument type
ARG_CONST_ALLOC_SIZE_OR_ZERO. For other argument types, this was already
done, but propagation for missing for this case. Without the fix, this
test case loads successfully.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/verifier/precise.c  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 9e754423fa8b..6c03a7d805f9 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -192,3 +192,28 @@
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
 },
+{
+	"precise: mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct xdp_md, ingress_ifindex)),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_MOV64_IMM(BPF_REG_2, 1),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0, 1),
+	BPF_MOV64_IMM(BPF_REG_2, 0x1000),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 42),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_ringbuf = { 1 },
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.flags = BPF_F_TEST_STATE_FREQ,
+	.errstr = "invalid access to memory, mem_size=1 off=42 size=8",
+	.result = REJECT,
+},
-- 
2.34.1

