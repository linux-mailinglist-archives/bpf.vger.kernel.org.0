Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD756AA72D
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 02:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCDBPP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 20:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCDBPH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 20:15:07 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E589E12041
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 17:14:16 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id a32so4097514ljr.9
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 17:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677892380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwuJQrpuQ+ZQh5urgKWxlvgnKse+UVAp5vfvlEdDc2I=;
        b=qCvgQXPw5i1CEQhP3ZzPhAyLvA5g/38tmE83lywruENW6mAivlvYfVmhdpCvWPxE9f
         59gLdF1XSpQ0glo+oAq090tvavezWawR0XHzuaFyA9XyopVetykitV4Vqc2a4+TT2hcG
         b/hDliYLqDnQs+Mv5E3EVIghm5ODC/PICQxYdMsO60sN173QbMLWSpMifGnIBy5xSJ2P
         CVm0DJTENXTq1D/ckeRS6KtXjwHiaYb4LpkleT8xQGlTD0u/1F7BgYuzTEIb6XOjuVnh
         FI0p60w+1Zv7b2/xcEgfwr7R7WrotXiMW2tCH+/T6/U/6MEz/4MladJlrA01JtORwEAo
         phzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677892380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwuJQrpuQ+ZQh5urgKWxlvgnKse+UVAp5vfvlEdDc2I=;
        b=ng0RTGba/BVXznpBG7FdqpoLFgewMdBzJ3AAMEAj9hs0y/KKc1aCUcf1VsCt/mpyKS
         FUeV8HLOJXzC0viaU3a3ND+6MSuBIkZR3eZ53g9pPQUdOShW1b6nvdQqOscZtt+VthE2
         6chGB1/WPPqfrPn7pQJLLUlUTcpIJ0dcSC2+mgATP1stj4lIQ9EQeHSC649sHqG6LfzM
         nMJztXZNvYZbJ+o3gCoUwz7tVpVmuf+vU9w6b2NvYEDp0zzq0facE5YFgPM6rTYayNkr
         kcdBTcd3r42Y1/V4l1y7rWZKwgNqY1HD0gPJ7yySCdiqpqAESGqgJiEfWPweQo4QTVa6
         X4Ew==
X-Gm-Message-State: AO0yUKVo58itOmdWO+PDbCFhRTGqypGB5LCmOjG9xjECxE0Ym3DnKizG
        BNtruIXT99A3dpS7n08At5ScB9Ph/6fsYw==
X-Google-Smtp-Source: AK7set+giRyKGx+Bq9Tyz/ucssUKdwwGuMdzU2W7z49HUveyo8cDfTXL9mcXRMXSl3J8dbfz3Vg1mg==
X-Received: by 2002:a2e:8012:0:b0:294:899:afc3 with SMTP id j18-20020a2e8012000000b002940899afc3mr1276863ljg.35.1677892380331;
        Fri, 03 Mar 2023 17:13:00 -0800 (PST)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x7-20020a05651c104700b00295b588d21dsm569609ljm.49.2023.03.03.17.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 17:13:00 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: test if pointer type is tracked for BPF_ST_MEM
Date:   Sat,  4 Mar 2023 03:12:46 +0200
Message-Id: <20230304011247.566040-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230304011247.566040-1-eddyz87@gmail.com>
References: <20230304011247.566040-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Check that verifier tracks pointer types for BPF_ST_MEM instructions
and reports error if pointer types do not match for different
execution branches.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/verifier/unpriv.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/unpriv.c b/tools/testing/selftests/bpf/verifier/unpriv.c
index 878ca26c3f0a..af0c0f336625 100644
--- a/tools/testing/selftests/bpf/verifier/unpriv.c
+++ b/tools/testing/selftests/bpf/verifier/unpriv.c
@@ -239,6 +239,29 @@
 	.errstr = "same insn cannot be used with different pointers",
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
+{
+	/* Same as above, but use BPF_ST_MEM to save 42
+	 * instead of BPF_STX_MEM.
+	 */
+	"unpriv: spill/fill of different pointers st",
+	.insns = {
+	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
+	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_1, offsetof(struct __sk_buff, mark), 42),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "same insn cannot be used with different pointers",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
 {
 	"unpriv: spill/fill of different pointers stx - ctx and sock",
 	.insns = {
-- 
2.39.1

