Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64226ADE47
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCGME5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 07:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCGMEw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 07:04:52 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434A432522
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 04:04:50 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso7027866wms.5
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 04:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678190689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ga2t4XKW6O5tB3acM5X/flUuKVu7knbwnYIgerkVpnY=;
        b=JtVWwAv2kOfJLB8ERk0GmxLVQIKc8DcyI4Sc+t7xwe00ilQeLa4lxKz+e/Dd04Q0Xb
         Tc5qGeBcYmXfhrPjdQGy7J8k6lD0twWAfezf4yiugLYam/fp8sq2Wxh5yjgrR3lWxd1h
         3XKZhc68w7CxTkstL9KSttZyIHkCj/PJ4axwNzoyYQcfAA819kadUVvzJCiQmUSmIEZP
         hXLVDzjBvJAnTzKh6gMa3+H7KEggeKl74gcAQn8italnQa1SD0AV12fNchrV/QCPZWPH
         DjnibF7igPAZ/hd/1/jnu4ZsFDsppPR/uqWW4LUB7DZ4VOYMh2pGjKUSqHClcTenWTsO
         VcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678190689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ga2t4XKW6O5tB3acM5X/flUuKVu7knbwnYIgerkVpnY=;
        b=34kqzN3CRODi/nTIBXv7b/XmgEILS0kpOixFysM+C5c8s2EwFoIyPPg5QPiEJqZgAf
         L252qOufFvK6xhNX7OxFC958O0kmyIgrMN+kX9rF5Cdkrzeq4kjtRkheX0khfp3jnm20
         DMDHGdKCYW187gS718Frgqfh268xGFG2QtO1kHey0P6DoB7r2RE0EtkIJOYJDBWnvhfF
         k5ry8IqegVmErd2UD0oHkLHAX7OY1pXUjaf7/5m3jVUnQDB1Mo1nSuo55i40IvTNT6Ty
         wHd0KA0VkHJeMPG8IpJH/y0g1ku2ixjO1pOtJnrClsity57cPr49v8HhKV4HUYziSC5w
         LnMg==
X-Gm-Message-State: AO0yUKWhf7cE0nvatvtxTFuiojelW5g6LMWmJz8aG2pDTOAxfokXZ16Z
        eFmPRMb2sCV10TJp9CUaRF0=
X-Google-Smtp-Source: AK7set8lfRm+gdmdl9TZy6Ksf5bhTeeGhHSPpDJyjWesy49zUUt/KldyRGk8lb8/3j7UXxG0RYdOXw==
X-Received: by 2002:a05:600c:354e:b0:3eb:38e6:f652 with SMTP id i14-20020a05600c354e00b003eb38e6f652mr12188630wmq.13.1678190688512;
        Tue, 07 Mar 2023 04:04:48 -0800 (PST)
Received: from ip-172-31-2-215.eu-west-1.compute.internal (ec2-34-255-118-91.eu-west-1.compute.amazonaws.com. [34.255.118.91])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003e209b45f6bsm18522081wmq.29.2023.03.07.04.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Mar 2023 04:04:48 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        bpf@vger.kernel.org, memxor@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 1/2] libbpf: refactor parse_usdt_arg() to re-use code
Date:   Tue,  7 Mar 2023 12:04:39 +0000
Message-Id: <20230307120440.25941-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307120440.25941-1-puranjay12@gmail.com>
References: <20230307120440.25941-1-puranjay12@gmail.com>
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

The parse_usdt_arg() function is defined differently for each
architecture but the last part of the function is repeated
verbatim for each architecture.

Refactor parse_usdt_arg() to fill the arg_sz and then do the repeated
post-processing in parse_usdt_spec().

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 tools/lib/bpf/usdt.c | 123 +++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 81 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 75b411fc2c77..293b7a37f8a1 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -1141,11 +1141,13 @@ static int parse_usdt_note(Elf *elf, const char *path, GElf_Nhdr *nhdr,
 	return 0;
 }
 
-static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg);
+static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz);
 
 static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note, __u64 usdt_cookie)
 {
+	struct usdt_arg_spec *arg;
 	const char *s;
+	int arg_sz;
 	int len;
 
 	spec->usdt_cookie = usdt_cookie;
@@ -1159,10 +1161,25 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
 			return -E2BIG;
 		}
 
-		len = parse_usdt_arg(s, spec->arg_cnt, &spec->args[spec->arg_cnt]);
+		arg = &spec->args[spec->arg_cnt];
+		len = parse_usdt_arg(s, spec->arg_cnt, arg, &arg_sz);
 		if (len < 0)
 			return len;
 
+		arg->arg_signed = arg_sz < 0;
+		if (arg_sz < 0)
+			arg_sz = -arg_sz;
+
+		switch (arg_sz) {
+		case 1: case 2: case 4: case 8:
+			arg->arg_bitshift = 64 - arg_sz * 8;
+			break;
+		default:
+			pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d\n",
+				spec->arg_cnt, s, arg_sz);
+			return -EINVAL;
+		}
+
 		s += len;
 		spec->arg_cnt++;
 	}
@@ -1219,13 +1236,13 @@ static int calc_pt_regs_off(const char *reg_name)
 	return -ENOENT;
 }
 
-static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
+static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
 {
 	char reg_name[16];
-	int arg_sz, len, reg_off;
+	int len, reg_off;
 	long off;
 
-	if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", &arg_sz, &off, reg_name, &len) == 3) {
+	if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", arg_sz, &off, reg_name, &len) == 3) {
 		/* Memory dereference case, e.g., -4@-20(%rbp) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
@@ -1233,7 +1250,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
-	} else if (sscanf(arg_str, " %d @ ( %%%15[^)] ) %n", &arg_sz, reg_name, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ ( %%%15[^)] ) %n", arg_sz, reg_name, &len) == 2) {
 		/* Memory dereference case without offset, e.g., 8@(%rsp) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = 0;
@@ -1241,7 +1258,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
-	} else if (sscanf(arg_str, " %d @ %%%15s %n", &arg_sz, reg_name, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ %%%15s %n", arg_sz, reg_name, &len) == 2) {
 		/* Register read case, e.g., -4@%eax */
 		arg->arg_type = USDT_ARG_REG;
 		arg->val_off = 0;
@@ -1250,7 +1267,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
-	} else if (sscanf(arg_str, " %d @ $%ld %n", &arg_sz, &off, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ $%ld %n", arg_sz, &off, &len) == 2) {
 		/* Constant value case, e.g., 4@$71 */
 		arg->arg_type = USDT_ARG_CONST;
 		arg->val_off = off;
@@ -1260,20 +1277,6 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		return -EINVAL;
 	}
 
-	arg->arg_signed = arg_sz < 0;
-	if (arg_sz < 0)
-		arg_sz = -arg_sz;
-
-	switch (arg_sz) {
-	case 1: case 2: case 4: case 8:
-		arg->arg_bitshift = 64 - arg_sz * 8;
-		break;
-	default:
-		pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d\n",
-			arg_num, arg_str, arg_sz);
-		return -EINVAL;
-	}
-
 	return len;
 }
 
@@ -1281,13 +1284,13 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 
 /* Do not support __s390__ for now, since user_pt_regs is broken with -m31. */
 
-static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
+static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
 {
 	unsigned int reg;
-	int arg_sz, len;
+	int len;
 	long off;
 
-	if (sscanf(arg_str, " %d @ %ld ( %%r%u ) %n", &arg_sz, &off, &reg, &len) == 3) {
+	if (sscanf(arg_str, " %d @ %ld ( %%r%u ) %n", arg_sz, &off, &reg, &len) == 3) {
 		/* Memory dereference case, e.g., -2@-28(%r15) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
@@ -1296,7 +1299,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 			return -EINVAL;
 		}
 		arg->reg_off = offsetof(user_pt_regs, gprs[reg]);
-	} else if (sscanf(arg_str, " %d @ %%r%u %n", &arg_sz, &reg, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ %%r%u %n", arg_sz, &reg, &len) == 2) {
 		/* Register read case, e.g., -8@%r0 */
 		arg->arg_type = USDT_ARG_REG;
 		arg->val_off = 0;
@@ -1305,7 +1308,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 			return -EINVAL;
 		}
 		arg->reg_off = offsetof(user_pt_regs, gprs[reg]);
-	} else if (sscanf(arg_str, " %d @ %ld %n", &arg_sz, &off, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ %ld %n", arg_sz, &off, &len) == 2) {
 		/* Constant value case, e.g., 4@71 */
 		arg->arg_type = USDT_ARG_CONST;
 		arg->val_off = off;
@@ -1315,20 +1318,6 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		return -EINVAL;
 	}
 
-	arg->arg_signed = arg_sz < 0;
-	if (arg_sz < 0)
-		arg_sz = -arg_sz;
-
-	switch (arg_sz) {
-	case 1: case 2: case 4: case 8:
-		arg->arg_bitshift = 64 - arg_sz * 8;
-		break;
-	default:
-		pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d\n",
-			arg_num, arg_str, arg_sz);
-		return -EINVAL;
-	}
-
 	return len;
 }
 
@@ -1348,13 +1337,13 @@ static int calc_pt_regs_off(const char *reg_name)
 	return -ENOENT;
 }
 
-static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
+static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
 {
 	char reg_name[16];
-	int arg_sz, len, reg_off;
+	int len, reg_off;
 	long off;
 
-	if (sscanf(arg_str, " %d @ \[ %15[a-z0-9], %ld ] %n", &arg_sz, reg_name, &off, &len) == 3) {
+	if (sscanf(arg_str, " %d @ \[ %15[a-z0-9], %ld ] %n", arg_sz, reg_name, &off, &len) == 3) {
 		/* Memory dereference case, e.g., -4@[sp, 96] */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
@@ -1362,7 +1351,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
-	} else if (sscanf(arg_str, " %d @ \[ %15[a-z0-9] ] %n", &arg_sz, reg_name, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ \[ %15[a-z0-9] ] %n", arg_sz, reg_name, &len) == 2) {
 		/* Memory dereference case, e.g., -4@[sp] */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = 0;
@@ -1370,12 +1359,12 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
-	} else if (sscanf(arg_str, " %d @ %ld %n", &arg_sz, &off, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ %ld %n", arg_sz, &off, &len) == 2) {
 		/* Constant value case, e.g., 4@5 */
 		arg->arg_type = USDT_ARG_CONST;
 		arg->val_off = off;
 		arg->reg_off = 0;
-	} else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", &arg_sz, reg_name, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", arg_sz, reg_name, &len) == 2) {
 		/* Register read case, e.g., -8@x4 */
 		arg->arg_type = USDT_ARG_REG;
 		arg->val_off = 0;
@@ -1388,20 +1377,6 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		return -EINVAL;
 	}
 
-	arg->arg_signed = arg_sz < 0;
-	if (arg_sz < 0)
-		arg_sz = -arg_sz;
-
-	switch (arg_sz) {
-	case 1: case 2: case 4: case 8:
-		arg->arg_bitshift = 64 - arg_sz * 8;
-		break;
-	default:
-		pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d\n",
-			arg_num, arg_str, arg_sz);
-		return -EINVAL;
-	}
-
 	return len;
 }
 
@@ -1456,13 +1431,13 @@ static int calc_pt_regs_off(const char *reg_name)
 	return -ENOENT;
 }
 
-static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
+static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
 {
 	char reg_name[16];
-	int arg_sz, len, reg_off;
+	int len, reg_off;
 	long off;
 
-	if (sscanf(arg_str, " %d @ %ld ( %15[a-z0-9] ) %n", &arg_sz, &off, reg_name, &len) == 3) {
+	if (sscanf(arg_str, " %d @ %ld ( %15[a-z0-9] ) %n", arg_sz, &off, reg_name, &len) == 3) {
 		/* Memory dereference case, e.g., -8@-88(s0) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
@@ -1470,12 +1445,12 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
-	} else if (sscanf(arg_str, " %d @ %ld %n", &arg_sz, &off, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ %ld %n", arg_sz, &off, &len) == 2) {
 		/* Constant value case, e.g., 4@5 */
 		arg->arg_type = USDT_ARG_CONST;
 		arg->val_off = off;
 		arg->reg_off = 0;
-	} else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", &arg_sz, reg_name, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", arg_sz, reg_name, &len) == 2) {
 		/* Register read case, e.g., -8@a1 */
 		arg->arg_type = USDT_ARG_REG;
 		arg->val_off = 0;
@@ -1488,26 +1463,12 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		return -EINVAL;
 	}
 
-	arg->arg_signed = arg_sz < 0;
-	if (arg_sz < 0)
-		arg_sz = -arg_sz;
-
-	switch (arg_sz) {
-	case 1: case 2: case 4: case 8:
-		arg->arg_bitshift = 64 - arg_sz * 8;
-		break;
-	default:
-		pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d\n",
-			arg_num, arg_str, arg_sz);
-		return -EINVAL;
-	}
-
 	return len;
 }
 
 #else
 
-static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
+static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
 {
 	pr_warn("usdt: libbpf doesn't support USDTs on current architecture\n");
 	return -ENOTSUP;
-- 
2.39.1

