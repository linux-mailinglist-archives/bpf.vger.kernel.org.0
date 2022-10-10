Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9825F9884
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 08:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiJJGrI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 02:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiJJGrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 02:47:07 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0917651404;
        Sun,  9 Oct 2022 23:47:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Mm8Xx2Vg4z6S2WX;
        Mon, 10 Oct 2022 14:44:49 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP2 (Coremail) with SMTP id Syh0CgDnf9Tiv0NjoL4qAA--.49036S4;
        Mon, 10 Oct 2022 14:47:03 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Hou Tao <houtao1@huawei.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf v2 2/5] libbpf: Fix memory leak in parse_usdt_arg()
Date:   Mon, 10 Oct 2022 03:04:51 -0400
Message-Id: <20221010070454.577433-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221010070454.577433-1-xukuohai@huaweicloud.com>
References: <20221010070454.577433-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnf9Tiv0NjoL4qAA--.49036S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4fuw4ktry8GFy7CF13CFg_yoW5Cw18p3
        yagw12vw1kJ3yftF1rXFnYqry3CrsrJr98Ar1Fya45ZF4fGrs5t3s3tr4ft3s8JFW7AFWa
        9F48tFWrGryUXF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

In the arm64 version of parse_usdt_arg(), when sscanf returns 2, reg_name
is allocated but not freed. Fix it.

Fixes: 0f8619929c57 ("libbpf: Usdt aarch64 arg parsing support")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/usdt.c | 59 +++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index e83b497c2245..f3b5be7415b5 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -1351,8 +1351,10 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 	char *reg_name = NULL;
 	int arg_sz, len, reg_off;
 	long off;
+	int ret;
 
-	if (sscanf(arg_str, " %d @ \[ %m[a-z0-9], %ld ] %n", &arg_sz, &reg_name, &off, &len) == 3) {
+	ret = sscanf(arg_str, " %d @ \[ %m[a-z0-9], %ld ] %n", &arg_sz, &reg_name, &off, &len);
+	if (ret == 3) {
 		/* Memory dereference case, e.g., -4@[sp, 96] */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
@@ -1361,32 +1363,37 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
-	} else if (sscanf(arg_str, " %d @ \[ %m[a-z0-9] ] %n", &arg_sz, &reg_name, &len) == 2) {
-		/* Memory dereference case, e.g., -4@[sp] */
-		arg->arg_type = USDT_ARG_REG_DEREF;
-		arg->val_off = 0;
-		reg_off = calc_pt_regs_off(reg_name);
-		free(reg_name);
-		if (reg_off < 0)
-			return reg_off;
-		arg->reg_off = reg_off;
-	} else if (sscanf(arg_str, " %d @ %ld %n", &arg_sz, &off, &len) == 2) {
-		/* Constant value case, e.g., 4@5 */
-		arg->arg_type = USDT_ARG_CONST;
-		arg->val_off = off;
-		arg->reg_off = 0;
-	} else if (sscanf(arg_str, " %d @ %m[a-z0-9] %n", &arg_sz, &reg_name, &len) == 2) {
-		/* Register read case, e.g., -8@x4 */
-		arg->arg_type = USDT_ARG_REG;
-		arg->val_off = 0;
-		reg_off = calc_pt_regs_off(reg_name);
-		free(reg_name);
-		if (reg_off < 0)
-			return reg_off;
-		arg->reg_off = reg_off;
 	} else {
-		pr_warn("usdt: unrecognized arg #%d spec '%s'\n", arg_num, arg_str);
-		return -EINVAL;
+		if (ret == 2)
+			free(reg_name);
+
+		if (sscanf(arg_str, " %d @ \[ %m[a-z0-9] ] %n", &arg_sz, &reg_name, &len) == 2) {
+			/* Memory dereference case, e.g., -4@[sp] */
+			arg->arg_type = USDT_ARG_REG_DEREF;
+			arg->val_off = 0;
+			reg_off = calc_pt_regs_off(reg_name);
+			free(reg_name);
+			if (reg_off < 0)
+				return reg_off;
+			arg->reg_off = reg_off;
+		} else if (sscanf(arg_str, " %d @ %ld %n", &arg_sz, &off, &len) == 2) {
+			/* Constant value case, e.g., 4@5 */
+			arg->arg_type = USDT_ARG_CONST;
+			arg->val_off = off;
+			arg->reg_off = 0;
+		} else if (sscanf(arg_str, " %d @ %m[a-z0-9] %n", &arg_sz, &reg_name, &len) == 2) {
+			/* Register read case, e.g., -8@x4 */
+			arg->arg_type = USDT_ARG_REG;
+			arg->val_off = 0;
+			reg_off = calc_pt_regs_off(reg_name);
+			free(reg_name);
+			if (reg_off < 0)
+				return reg_off;
+			arg->reg_off = reg_off;
+		} else {
+			pr_warn("usdt: unrecognized arg #%d spec '%s'\n", arg_num, arg_str);
+			return -EINVAL;
+		}
 	}
 
 	arg->arg_signed = arg_sz < 0;
-- 
2.30.2

