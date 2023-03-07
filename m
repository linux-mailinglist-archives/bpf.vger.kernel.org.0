Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1DE6ADE48
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 13:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjCGME6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 07:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjCGMEx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 07:04:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B49932510
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 04:04:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p26so7583999wmc.4
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 04:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678190689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzLH3arc+4jLnRYm+fw9unlpZnfpEKzyvHG2hKujgoM=;
        b=T9e8X6AHIx34E8J5gRhqYgRyKoxROqoO9WODsUITsPp0jM77cHE2aG0yWqhftN4jPS
         lO/+v+NQ+Tt7ewCDEY7cZDrkUVGwmyS+S8rbk3zUtj2aviRGeCI27ffJXDm72zwuQ0zS
         38bI991WHYrLPDdurWM5dOUHYQePm8kMBcrrXbXXthHtkQCObCZqQSsP4RyypFRg9Skt
         Qcb2T2uaJBzFybajIp1QMpPxL3X2zlJAK6XWEqW/PcxaM/vbz6rdnM2DiBSGjabirIRy
         1s1vM0dpx4CSXK5cwjC4k2hNFAmpnQ4YPSpd+Ie5lzz2XPxr1V3evycYHKgfmESQo6xP
         cw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678190689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzLH3arc+4jLnRYm+fw9unlpZnfpEKzyvHG2hKujgoM=;
        b=jHY0r1feUlg0rGENqatM4nYsN0TSXYufmCr50p4bSL4PWvR6BZWdHYQFZa3++Rt3y9
         E+ybLdAnbU3WPosXE4r7DkNME7GdDR2Lx/59s7nibLgT+M/7U551hmik5hYBajOYPn9K
         XM7q8p2QpqchR+wtS51xLqNSbsPLRcXKYhfWlVBdOdvjuGe1sEzr9Yph1n2+ls22R0rn
         Kam1QDi21+FagJWvmIxyXvztkzkxXy6x6UFwPxSLeuHtmctPPRhL6+ZPWS2fDTuDYC5G
         1YCLRtDJ30onwYpvY9J+Ud78+xoi8//Dl9jrKWqv+MR786EUXN9qW5IkMxZi5ZysmrSd
         Tkbg==
X-Gm-Message-State: AO0yUKUMiNoYLHhAfInwHIYmh9lzXFy/52vvoTBR1PrW2nd1DY+ee0hN
        sRMdxfg5oONwamG9+A0i+lQ=
X-Google-Smtp-Source: AK7set/R87wehPEuDdL6OSlPUYerPVY3iOjI5nCh0Pcfb2NOpJpv5HOWFn2pdmFjIHuyf6ouV20UCw==
X-Received: by 2002:a05:600c:4e41:b0:3ea:e7e7:a2f9 with SMTP id e1-20020a05600c4e4100b003eae7e7a2f9mr12598231wmq.13.1678190689631;
        Tue, 07 Mar 2023 04:04:49 -0800 (PST)
Received: from ip-172-31-2-215.eu-west-1.compute.internal (ec2-34-255-118-91.eu-west-1.compute.amazonaws.com. [34.255.118.91])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003e209b45f6bsm18522081wmq.29.2023.03.07.04.04.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Mar 2023 04:04:48 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        bpf@vger.kernel.org, memxor@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 2/2] libbpf: usdt arm arg parsing support
Date:   Tue,  7 Mar 2023 12:04:40 +0000
Message-Id: <20230307120440.25941-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307120440.25941-1-puranjay12@gmail.com>
References: <20230307120440.25941-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

To test the above changes QEMU's virt[1] board with cortex-a15
CPU was used. libbpf-bootstrap's usdt example[2] was modified to attach
to a test program with DTRACE_PROBE1/2/3/4... probes to test different
combinations.

[1] https://www.qemu.org/docs/master/system/arm/virt.html
[2] https://github.com/libbpf/libbpf-bootstrap/blob/master/examples/c/usdt.bpf.c

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 tools/lib/bpf/usdt.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 293b7a37f8a1..27a4589eda1c 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -1466,6 +1466,86 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 	return len;
 }
 
+#elif defined(__arm__)
+
+static int calc_pt_regs_off(const char *reg_name)
+{
+	static struct {
+		const char *name;
+		size_t pt_regs_off;
+	} reg_map[] = {
+		{ "r0", offsetof(struct pt_regs, uregs[0]) },
+		{ "r1", offsetof(struct pt_regs, uregs[1]) },
+		{ "r2", offsetof(struct pt_regs, uregs[2]) },
+		{ "r3", offsetof(struct pt_regs, uregs[3]) },
+		{ "r4", offsetof(struct pt_regs, uregs[4]) },
+		{ "r5", offsetof(struct pt_regs, uregs[5]) },
+		{ "r6", offsetof(struct pt_regs, uregs[6]) },
+		{ "r7", offsetof(struct pt_regs, uregs[7]) },
+		{ "r8", offsetof(struct pt_regs, uregs[8]) },
+		{ "r9", offsetof(struct pt_regs, uregs[9]) },
+		{ "r10", offsetof(struct pt_regs, uregs[10]) },
+		{ "fp", offsetof(struct pt_regs, uregs[11]) },
+		{ "ip", offsetof(struct pt_regs, uregs[12]) },
+		{ "sp", offsetof(struct pt_regs, uregs[13]) },
+		{ "lr", offsetof(struct pt_regs, uregs[14]) },
+		{ "pc", offsetof(struct pt_regs, uregs[15]) },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(reg_map); i++) {
+		if (strcmp(reg_name, reg_map[i].name) == 0)
+			return reg_map[i].pt_regs_off;
+	}
+
+	pr_warn("usdt: unrecognized register '%s'\n", reg_name);
+	return -ENOENT;
+}
+
+static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
+{
+	char reg_name[16];
+	int len, reg_off;
+	long off;
+
+	if (sscanf(arg_str, " %d @ \[ %15[a-z0-9], #%ld ] %n",
+		   arg_sz, reg_name, &off, &len) == 3) {
+		/* Memory dereference case, e.g., -4@[fp, #96] */
+		arg->arg_type = USDT_ARG_REG_DEREF;
+		arg->val_off = off;
+		reg_off = calc_pt_regs_off(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
+	} else if (sscanf(arg_str, " %d @ \[ %15[a-z0-9] ] %n", arg_sz, reg_name, &len) == 2) {
+		/* Memory dereference case, e.g., -4@[sp] */
+		arg->arg_type = USDT_ARG_REG_DEREF;
+		arg->val_off = 0;
+		reg_off = calc_pt_regs_off(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
+	} else if (sscanf(arg_str, " %d @ #%ld %n", arg_sz, &off, &len) == 2) {
+		/* Constant value case, e.g., 4@#5 */
+		arg->arg_type = USDT_ARG_CONST;
+		arg->val_off = off;
+		arg->reg_off = 0;
+	} else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", arg_sz, reg_name, &len) == 2) {
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
+	return len;
+}
+
 #else
 
 static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
-- 
2.39.1

