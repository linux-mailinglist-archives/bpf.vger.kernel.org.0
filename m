Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CA869D5AA
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 22:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBTVWj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 16:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBTVWj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 16:22:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07001E2A0
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 13:22:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c5so3168482wrr.5
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 13:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4o7k2fLrIm0e7AL2UREVguMfnwgq/yu2cqr0v+/i8c=;
        b=hLHMrAnCU88nDvzG2XMIcBIil6Rr8XRgQDC1rQywBDyIZuK7xjvlBpnSF3dYhjozcm
         xOR98oKB1s8iYYNvptLf6g2czMwAVy0ysvhbESK1yA3xse+w9CKjcoUWOCgEWaZR7EHN
         4LdgXqJAzzsilfe6/9Y4cUuHbCYzeowMiL4BP40GyBM0WGaKNkOdy9BjQJoKnTPj1NWv
         ozXtdejewQ7kr0RcnhApRJD0nKn1VDjkNXa7p0HkAMMVsxQbA2haLabV7K9BE82F/2cG
         aaU78+krjpDW73o1NEy+UFR2r9wGJJS53FZUM7Km5e++6VGMUGAQU2M70Tl/PdPqmV/w
         WCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4o7k2fLrIm0e7AL2UREVguMfnwgq/yu2cqr0v+/i8c=;
        b=HmscyAHvrWUJy9U5sFjywMiTRxG3TxZQzZofV5wgmMrhJtFCX/j3GpVD57CA+nkAqY
         yx6vCRx1pbuppZ2j2Pj/wdZL5tdsJYjBZ56YkXtJ3x+QhBU1cHtIPicbPs135kB0Ge8o
         4AbausQ/PS6EPZgiXMV+Z3Znykd16Hzkn7dWHfla88fIgrMN36tfnwVFDlo0S7PzCUlT
         YgyHH2lMVIz47bAM+jdGlLndUkrH7cri+9Ve9XE7ogXcjkp/JJqCA42QKTg4WtDrQnTw
         tdkJWkzbQI36yf7mLZMwWFhk4x+8RjeADVBcUP1sJQFs2L9aO+AoTkQJqgHkdabnR2iO
         JZMQ==
X-Gm-Message-State: AO0yUKUHddN974UPtwBev/tgRCEZJJOyKrVF9t7OpIxuPU9se2u8T+YX
        7+qy/v3IPFkYTHL4z2xsoTo=
X-Google-Smtp-Source: AK7set+VgyNO9kcfojtzb4+89KGww5vc5dFvC51QqcUksCEThsP8jiFoflGx+6A+xwYLa89/apV/4g==
X-Received: by 2002:a5d:6052:0:b0:2bd:f5bd:5482 with SMTP id j18-20020a5d6052000000b002bdf5bd5482mr2917049wrt.28.1676928155967;
        Mon, 20 Feb 2023 13:22:35 -0800 (PST)
Received: from ip-172-31-34-25.eu-west-1.compute.internal (ec2-34-246-174-231.eu-west-1.compute.amazonaws.com. [34.246.174.231])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b002c558869934sm7257479wri.81.2023.02.20.13.22.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2023 13:22:35 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     puranjaymohan@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, iii@linux.ibm.com,
        quentin@isovalent.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH] bbpf: usdt arm arg parsing support
Date:   Mon, 20 Feb 2023 21:22:33 +0000
Message-Id: <20230220212233.13229-1-puranjay12@gmail.com>
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

