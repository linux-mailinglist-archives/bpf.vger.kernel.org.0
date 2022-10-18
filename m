Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5F602EA9
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 16:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiJROiI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJROiE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 10:38:04 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF36C97CC;
        Tue, 18 Oct 2022 07:38:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MsGcT5n69zKG7J;
        Tue, 18 Oct 2022 22:35:37 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP3 (Coremail) with SMTP id _Ch0CgBne11Guk5jh5e9AQ--.19076S2;
        Tue, 18 Oct 2022 22:37:59 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH] libbpf: Avoid allocating reg_name with sscanf in parse_usdt_arg()
Date:   Tue, 18 Oct 2022 10:55:38 -0400
Message-Id: <20221018145538.2046842-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBne11Guk5jh5e9AQ--.19076S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW8Xw4fuF1rKF17Kw1rJFb_yoW5Ar43pw
        4Sgw1qvrn7J3ySga4DXanYq34UCrZrJrZYyr18ta45ZF4fWr95t34fKF4Fywn5GFW7AF4a
        9F4rCryrGFy5Xr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
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

The reg_name in parse_usdt_arg() is used to hold register name, which
is short enough to be held in a 16-byte array, so we could define
reg_name as char reg_name[16] to avoid dynamically allocating reg_name
with sscanf.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/usdt.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 49f3c3b7f609..28fa1b2283de 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -1225,26 +1225,24 @@ static int calc_pt_regs_off(const char *reg_name)
 
 static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
 {
-	char *reg_name = NULL;
+	char reg_name[16];
 	int arg_sz, len, reg_off;
 	long off;
 
-	if (sscanf(arg_str, " %d @ %ld ( %%%m[^)] ) %n", &arg_sz, &off, &reg_name, &len) == 3) {
+	if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", &arg_sz, &off, reg_name, &len) == 3) {
 		/* Memory dereference case, e.g., -4@-20(%rbp) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
 		reg_off = calc_pt_regs_off(reg_name);
-		free(reg_name);
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
-	} else if (sscanf(arg_str, " %d @ %%%ms %n", &arg_sz, &reg_name, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ %%%15s %n", &arg_sz, reg_name, &len) == 2) {
 		/* Register read case, e.g., -4@%eax */
 		arg->arg_type = USDT_ARG_REG;
 		arg->val_off = 0;
 
 		reg_off = calc_pt_regs_off(reg_name);
-		free(reg_name);
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
@@ -1456,16 +1454,15 @@ static int calc_pt_regs_off(const char *reg_name)
 
 static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
 {
-	char *reg_name = NULL;
+	char reg_name[16];
 	int arg_sz, len, reg_off;
 	long off;
 
-	if (sscanf(arg_str, " %d @ %ld ( %m[a-z0-9] ) %n", &arg_sz, &off, &reg_name, &len) == 3) {
+	if (sscanf(arg_str, " %d @ %ld ( %15[a-z0-9] ) %n", &arg_sz, &off, reg_name, &len) == 3) {
 		/* Memory dereference case, e.g., -8@-88(s0) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
 		reg_off = calc_pt_regs_off(reg_name);
-		free(reg_name);
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
@@ -1474,12 +1471,11 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		arg->arg_type = USDT_ARG_CONST;
 		arg->val_off = off;
 		arg->reg_off = 0;
-	} else if (sscanf(arg_str, " %d @ %m[a-z0-9] %n", &arg_sz, &reg_name, &len) == 2) {
+	} else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", &arg_sz, reg_name, &len) == 2) {
 		/* Register read case, e.g., -8@a1 */
 		arg->arg_type = USDT_ARG_REG;
 		arg->val_off = 0;
 		reg_off = calc_pt_regs_off(reg_name);
-		free(reg_name);
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
-- 
2.30.2

