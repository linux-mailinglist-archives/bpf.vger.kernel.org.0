Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AB369D5C7
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 22:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBTV1r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 16:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBTV1q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 16:27:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018361D919
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 13:27:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c12so2490147wrw.1
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 13:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4o7k2fLrIm0e7AL2UREVguMfnwgq/yu2cqr0v+/i8c=;
        b=SnJrkm8vjGFXXJZs39AOc/YLCVlk+wi+VV8eTZf9mhYgvPQy+X45Xz4Vfnx/tFD7M/
         2KkpQQU6973RLh7AZ8C9QcSMF0bNK5xKv+6hevTCjwUoP+PKaNl5pmj+goK69OnEyjzx
         vCTdRG8oCHjr+LNmncl/asbJ28INZjhXuHt/vSuUrsD2ZGIWM8IP3NvDez7gqft7aA8v
         9mqjoZDl0orXlaLi+Z/6ULZbSS5ieYZ1Y0Ab5hsUGZ0/mqi6nzcfW14UijxfZBb5wNaQ
         lLnhHVZ/4ytP8pi/V10M6SdSwTYHZxvq5Sufff9czaiRN7mreC7bIHY4zkbs6W+x+L0Y
         2RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4o7k2fLrIm0e7AL2UREVguMfnwgq/yu2cqr0v+/i8c=;
        b=UJlLaUFYSKNzvD/amaDntE9ri6q6YfOhYeXudnZcS8W8KfXr7VT8aAmk2GOyERRAd4
         wDirUoyOJMDkSgfpTkUSU3wAafuZ/6aNxTVZZr2UA90OMXhVbZLLk0EzZF/+6cqOJbaH
         fjebG8emAEGOxl+Ok4WBguryN0FPtkLBwT9zXLzEN4UViOEyGmJlKgIcaHbwUXo24Se+
         1rk4Ih/FtqzSkvTDqf4cpCEBNx/KXFnzM8vqsDPdbDR4Ze7JJiFPMjtGygulLmUbIgkM
         EfEg6MCKjA/Lgghm1YkLSBR105sbTaK4ohGP2znH/2kEkH1h0dR2hlRSqcWQ0UqdieLl
         bRaQ==
X-Gm-Message-State: AO0yUKWQpfdpcfB7yAUTNlP9iTdFIWYa0YSnK2cF7D+AX0JximJomuCu
        VULqS9d7BJPIMoJaWxUevDdcGmsXGWGDSLDa6HI=
X-Google-Smtp-Source: AK7set/c7aTOk1c+YM6jS0hI7kabC67Y94WG5QHNCCOCKgu9ZxZ0ZXukyMT3hK9nIhZzdmUfH2W3ng==
X-Received: by 2002:adf:dd11:0:b0:2c5:a321:bcba with SMTP id a17-20020adfdd11000000b002c5a321bcbamr2462436wrm.42.1676928463221;
        Mon, 20 Feb 2023 13:27:43 -0800 (PST)
Received: from ip-172-31-34-25.eu-west-1.compute.internal (ec2-34-246-174-231.eu-west-1.compute.amazonaws.com. [34.246.174.231])
        by smtp.gmail.com with ESMTPSA id t23-20020a05600c2f9700b003dc521f336esm1661348wmn.14.2023.02.20.13.27.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2023 13:27:42 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     puranjaymohan@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, iii@linux.ibm.com,
        quentin@isovalent.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next] libbpf: usdt ARM arg parsing support
Date:   Mon, 20 Feb 2023 21:27:41 +0000
Message-Id: <20230220212741.13515-1-puranjay12@gmail.com>
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

