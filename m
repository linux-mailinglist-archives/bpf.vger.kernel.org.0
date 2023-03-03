Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A93A6A92B4
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 09:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCCIhy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 03:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCCIhy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 03:37:54 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ABC5A6CA
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 00:37:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so777636wmi.3
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 00:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677832644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/7aKUJBN+ko3CMZWvvKttzwhegztVQpvIgzv6IgwzUI=;
        b=AbNE8NGjxM0etd4SOV/o38/mMvefwynFJBwVZDF2SywSwA+LarE78ivLiJcc8o3hNO
         iuNbT9B4wsxMBP5Dfbg2CFn+0H7Efafono5K2khSyjUDTqLr/EV25HBAeyJg0nLHJCKs
         7R1OyyUGxukJbE/kzj1hvakFx/ZC+WNhtSn0aSFIob0RPHu8jYs4j5ayMzkkzQoGF+15
         8/3v1KZke5fLjzwP8qND90Sw8NR7F7ImgovSIPio7ry+1rGDJYtVReKtKHRZNnozRzdY
         u8Yspi+GYEs++WRtFzOX7fgOC3NQg2z98Xip7YQWUy9+9nfPz7s3jXfET3hzrIj2TD03
         b1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677832644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7aKUJBN+ko3CMZWvvKttzwhegztVQpvIgzv6IgwzUI=;
        b=1gRPszc2KZcVyb1vL6DRI0bRaPjAxhjGwfsjCfNsFj8w4/s7G8j/AM0srLiGlWd8Mv
         kMv34P1WEx/beMqkqe7ihpYZ7fxAB/DIGoJgD6pQ81J/l1D+y+jIrFWy0CCdrbeOwvAd
         39zICnB15OX2ZeQN4a/W0glRwysjf8O9VAuRnD2yOjJVnPiglahO9g+Tm3MT07vHW+uv
         xY0nXF9BfOhEp5N89hlzDP4jhRo1Ub/3X4YnKRL5kPnso37JumlbCchJA/kWwZYuhC0h
         uF3DNXgVDNzn8KwqAkl65dCtKrIEBR4DAs2tQT17pMRBaDnscQF5CpgerwJaSJkZhwnW
         uMeg==
X-Gm-Message-State: AO0yUKX8zvHz1vs2EwEoGBvGzMgmXdq3eDuM2h2UJiUeNcWN9zs4qyKV
        vwLOKS+SMO8Hat48BrXKadk=
X-Google-Smtp-Source: AK7set/KT50hf0Eje72owxqVYm5mAJuZFZ/yZTyGJBKeMrIXqzXcN3OufZItBnH4Z7bm9azfAsWBBg==
X-Received: by 2002:a05:600c:1e10:b0:3eb:39e0:3530 with SMTP id ay16-20020a05600c1e1000b003eb39e03530mr738346wmb.41.1677832644066;
        Fri, 03 Mar 2023 00:37:24 -0800 (PST)
Received: from ip-172-31-2-215.eu-west-1.compute.internal (ec2-34-255-118-91.eu-west-1.compute.amazonaws.com. [34.255.118.91])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c15d200b003e20a6fd604sm1750577wmf.4.2023.03.03.00.37.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2023 00:37:23 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        bpf@vger.kernel.org, memxor@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 bpf-next] libbpf: usdt arm arg parsing support
Date:   Fri,  3 Mar 2023 08:37:06 +0000
Message-Id: <20230303083706.3597-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Parsing of USDT arguments is architecture-specific; on arm it is
relatively easy since registers used are r[0-10], fp, ip, sp, lr,
pc. Format is slightly different compared to aarch64; forms are

- "size @ [ reg, #offset ]" for dereferences, for example
  "-8 @ [ sp, #76 ]" ; " -4 @ [ sp ]"
- "size @ reg" for register values; for example
  "-4@r0"
- "size @ #value" for raw values; for example
  "-8@#1"

Add support for parsing USDT arguments for ARM architecture.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
Changes in V1[1] to V2
- Resending as V1 shows up as Superseded in patchwork.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20230220212741.13515-1-puranjay12@gmail.com/
---
 tools/lib/bpf/usdt.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 75b411fc2c77..ef097b882a4d 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -1505,6 +1505,88 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 	return len;
 }
 
+#elif defined(__arm__)
+
+static int calc_pt_regs_off(const char *reg_name)
+{
+	int reg_num;
+
+	if (sscanf(reg_name, "r%d", &reg_num) == 1) {
+		if (reg_num >= 0 && reg_num <= 10)
+			return offsetof(struct pt_regs, uregs[reg_num]);
+	} else if (strcmp(reg_name, "fp") == 0) {
+		return offsetof(struct pt_regs, ARM_fp);
+	} else if (strcmp(reg_name, "ip") == 0) {
+		return offsetof(struct pt_regs, ARM_ip);
+	} else if (strcmp(reg_name, "sp") == 0) {
+		return offsetof(struct pt_regs, ARM_sp);
+	} else if (strcmp(reg_name, "lr") == 0) {
+		return offsetof(struct pt_regs, ARM_lr);
+	} else if (strcmp(reg_name, "pc") == 0) {
+		return offsetof(struct pt_regs, ARM_pc);
+	}
+	pr_warn("usdt: unrecognized register '%s'\n", reg_name);
+	return -ENOENT;
+}
+
+static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
+{
+	char reg_name[16];
+	int arg_sz, len, reg_off;
+	long off;
+
+	if (sscanf(arg_str, " %d @ \[ %15[a-z0-9], #%ld ] %n", &arg_sz, reg_name,
+								&off, &len) == 3) {
+		/* Memory dereference case, e.g., -4@[fp, #96] */
+		arg->arg_type = USDT_ARG_REG_DEREF;
+		arg->val_off = off;
+		reg_off = calc_pt_regs_off(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
+	} else if (sscanf(arg_str, " %d @ \[ %15[a-z0-9] ] %n", &arg_sz, reg_name, &len) == 2) {
+		/* Memory dereference case, e.g., -4@[sp] */
+		arg->arg_type = USDT_ARG_REG_DEREF;
+		arg->val_off = 0;
+		reg_off = calc_pt_regs_off(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
+	} else if (sscanf(arg_str, " %d @ #%ld %n", &arg_sz, &off, &len) == 2) {
+		/* Constant value case, e.g., 4@#5 */
+		arg->arg_type = USDT_ARG_CONST;
+		arg->val_off = off;
+		arg->reg_off = 0;
+	} else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", &arg_sz, reg_name, &len) == 2) {
+		/* Register read case, e.g., -8@r4 */
+		arg->arg_type = USDT_ARG_REG;
+		arg->val_off = 0;
+		reg_off = calc_pt_regs_off(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
+	} else {
+		pr_warn("usdt: unrecognized arg #%d spec '%s'\n", arg_num, arg_str);
+		return -EINVAL;
+	}
+
+	arg->arg_signed = arg_sz < 0;
+	if (arg_sz < 0)
+		arg_sz = -arg_sz;
+
+	switch (arg_sz) {
+	case 1: case 2: case 4: case 8:
+		arg->arg_bitshift = 64 - arg_sz * 8;
+		break;
+	default:
+		pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d\n",
+			arg_num, arg_str, arg_sz);
+		return -EINVAL;
+	}
+
+	return len;
+}
+
 #else
 
 static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
-- 
2.39.1

