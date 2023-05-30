Return-Path: <bpf+bounces-1452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA8A716AEE
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 19:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89C4281268
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 17:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3358D271F0;
	Tue, 30 May 2023 17:28:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCC23C9E
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:28:29 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A87196
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:28:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so5253609e87.1
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685467676; x=1688059676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ylH0VNTL1ZMVzN8kk9IdT3VsBrdm3nHhmLd8htJ54A=;
        b=CGrCfU/9gf1+sLTuRLficMZQRvjHBU65xgNt/UT/GGX1Fec5Wqu4ZrG9mCzEtRHqw2
         8ganVHMjl8gRb7vRglfoY9suvBVnl2jWaKCdCcliCjDp8aKD5LW4mwYAfJM7o9FaOJIK
         /Vb+M9+kjme7y91ceH1WVwmY8iio6FNXiBXMB5ClHbCebebd7BFczgA+AiQXYv9xBrTx
         YDoIz1G8h5x45lK4l8Sa0rCcSmx8P7icqFXG//HZsUIcdDdIsTzri+ccbUGStEo8GpxX
         1v00ZesW430N7co4hmtaFZuHCRLtdTDYS5m0tBWGR7sqXygXd0v34f+XPkW6euz9AXi9
         NYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685467676; x=1688059676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ylH0VNTL1ZMVzN8kk9IdT3VsBrdm3nHhmLd8htJ54A=;
        b=A7r6gBnRVXFy/VVRhDHjrkWX4TIUw24LEVCw/2wL0iGonkwVRGpoO/9XtEki7dlgF7
         1Enlsy3vPoz10A6LwCfurirQfqEWDDIzl/2YwqgTh6iLF/0fNKtBjftf/UnIFJ/CpewI
         4By2SUVEq2SxFoKio/fYx0YW3kmZ8YJYWsFdPgv2UVh62/CgoPberBXL5bHMAKj6hatA
         NWRCUj6cOzllluDbCxrBPUpAZ+3tZw1SXSH2XVJJzzmeqDhdZ7dXWURRhAuotzkCI89W
         QiDg80kU4tkQ2JcBVWM1//2JZbfCV1lLSH98wojQqL3SOee/r7vNj0oMkAMSw0KNmCrs
         dY1g==
X-Gm-Message-State: AC+VfDwRg5QxN/YUFThuPnaSPfY8450IMVw08Vf/8TBeSLChT5zQWfBK
	tsw1PaAQVE1h+kPN0XSL0U4NG442Nc0SNA==
X-Google-Smtp-Source: ACHHUZ4Td9XBt+ZKkZebAd5YUrICgo/21da7Y1nR9qazRK+4e3wPVM7rP5WzvoOiSsXw1vAgqdik5g==
X-Received: by 2002:ac2:447c:0:b0:4f3:a61d:19d2 with SMTP id y28-20020ac2447c000000b004f3a61d19d2mr1190902lfl.36.1685467675657;
        Tue, 30 May 2023 10:27:55 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a1-20020a056512020100b004f262997496sm405985lfo.76.2023.05.30.10.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:27:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/4] bpf: filter out scalar ids not used for range transfer in regsafe()
Date: Tue, 30 May 2023 20:27:38 +0300
Message-Id: <20230530172739.447290-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530172739.447290-1-eddyz87@gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

verifier.c:regsafe() uses check_ids() to verify that scalar register
id assignments match between cached and current state. This is costly
because many registers might get an id, but not all of them would
actually gain range through verifier.c:find_equal_scalars().

For example, in the following code range is transferred via
find_equal_scalars():

  1: r0 = call some_func();
  2: r1 = r0;                       // r0 and r1 get same id
  3: if r0 > 10 goto exit;          // r0 and r1 get the same range
     ... use r1 ...

In this case it is important to verify that r0 and r1 have the same id
if there is ever a jump to (3).

However, for the following code registers id mapping is not important
but gets in a way:

  1: r6 = ...
  2: if ... goto <4>;
  3: r0 = call some_func(); // r0.id == 0
  4: goto <6>;
  5: r0 = r6;
  6: if r0 > 10 goto exit;  // first visit with r0.id == 0,
                            // second visit with r0.id != 0
     ... use r0 ...

Jump from 4 to 6 would not be considered safe and path starting from 6
would be processed again because of mismatch in r0 id mapping.

This commit modifies find_equal_scalars() to track which ids were
actually used for range transfer. regsafe() can safely omit id mapping
checks for ids that were never used for range transfer.

This brings back most of the performance lost because of the previous commit:

$ ./veristat -e file,prog,states -f 'states_pct!=0' \
             -C master-baseline.log current.log
File             Program                States (A)  States (B)  States (DIFF)
---------------  ---------------------  ----------  ----------  -------------
bpf_host.o       cil_from_host                  37          45   +8 (+21.62%)
bpf_sock.o       cil_sock6_connect              99         103    +4 (+4.04%)
bpf_sock.o       cil_sock6_getpeername          56          57    +1 (+1.79%)
bpf_sock.o       cil_sock6_recvmsg              56          57    +1 (+1.79%)
bpf_sock.o       cil_sock6_sendmsg              93          97    +4 (+4.30%)
test_usdt.bpf.o  usdt12                        116         117    +1 (+0.86%)

(As in the previous commit verification performance is tested for
 object files listed in tools/testing/selftests/bpf/veristat.cfg and
 Cilium object files from [1])

[1] git@github.com:anakryiko/cilium.git

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   4 +
 kernel/bpf/Makefile          |   1 +
 kernel/bpf/u32_hashset.c     | 137 +++++++++++++++++++++++++++++++++++
 kernel/bpf/u32_hashset.h     |  30 ++++++++
 kernel/bpf/verifier.c        |  46 ++++++++++--
 5 files changed, 210 insertions(+), 8 deletions(-)
 create mode 100644 kernel/bpf/u32_hashset.c
 create mode 100644 kernel/bpf/u32_hashset.h

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5b11a3b0fec0..c5bc87403a6f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -557,6 +557,8 @@ struct backtrack_state {
 	u64 stack_masks[MAX_CALL_FRAMES];
 };
 
+struct u32_hashset;
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
@@ -622,6 +624,8 @@ struct bpf_verifier_env {
 	u32 scratched_regs;
 	/* Same as scratched_regs but for stack slots */
 	u64 scratched_stack_slots;
+	/* set of ids that gain range via find_equal_scalars() */
+	struct u32_hashset *range_transfer_ids;
 	u64 prev_log_pos, prev_insn_print_pos;
 	/* buffer used to generate temporary string representations,
 	 * e.g., in reg_type_str() to generate reg_type string
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 1d3892168d32..8e94e549679e 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
+obj-$(CONFIG_BPF_SYSCALL) += u32_hashset.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
diff --git a/kernel/bpf/u32_hashset.c b/kernel/bpf/u32_hashset.c
new file mode 100644
index 000000000000..a2c5429e34e1
--- /dev/null
+++ b/kernel/bpf/u32_hashset.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "linux/gfp_types.h"
+#include "linux/random.h"
+#include "linux/slab.h"
+#include <linux/jhash.h>
+
+#include "u32_hashset.h"
+
+static struct u32_hashset_bucket *u32_hashset_put_in_bucket(struct u32_hashset_bucket *bucket,
+							    u32 item)
+{
+	struct u32_hashset_bucket *new_bucket;
+	u32 new_cap = bucket ? 2 * bucket->cap : 1;
+	u32 cnt = bucket ? bucket->cnt : 0;
+	size_t sz;
+
+	if (!bucket || bucket->cnt == bucket->cap) {
+		sz = sizeof(struct u32_hashset_bucket) + sizeof(u32) * new_cap;
+		new_bucket = krealloc(bucket, sz, GFP_KERNEL);
+		if (!new_bucket)
+			return NULL;
+		new_bucket->cap = new_cap;
+	} else {
+		new_bucket = bucket;
+	}
+
+	new_bucket->items[cnt] = item;
+	new_bucket->cnt = cnt + 1;
+
+	return new_bucket;
+}
+
+static bool u32_hashset_needs_to_grow(struct u32_hashset *set)
+{
+	/* grow if empty or more than 75% filled */
+	return (set->buckets_cnt == 0) || ((set->items_cnt + 1) * 4 / 3 > set->buckets_cnt);
+}
+
+static void u32_hashset_free_buckets(struct u32_hashset_bucket **buckets, size_t cnt)
+{
+	size_t bkt;
+
+	for (bkt = 0; bkt < cnt; ++bkt)
+		kfree(buckets[bkt]);
+	kfree(buckets);
+}
+
+static int u32_hashset_grow(struct u32_hashset *set)
+{
+	struct u32_hashset_bucket **new_buckets;
+	size_t new_buckets_cnt;
+	size_t h, bkt, i;
+	u32 item;
+
+	new_buckets_cnt = set->buckets_cnt ? set->buckets_cnt * 2 : 4;
+	new_buckets = kcalloc(new_buckets_cnt, sizeof(new_buckets[0]), GFP_KERNEL);
+	if (!new_buckets)
+		return -ENOMEM;
+
+	for (bkt = 0; bkt < set->buckets_cnt; ++bkt) {
+		if (!set->buckets[bkt])
+			continue;
+
+		for (i = 0; i < set->buckets[bkt]->cnt; ++i) {
+			item = set->buckets[bkt]->items[i];
+			h = jhash_1word(item, set->seed) % new_buckets_cnt;
+			new_buckets[h] = u32_hashset_put_in_bucket(new_buckets[h], item);
+			if (!new_buckets[h])
+				goto nomem;
+		}
+	}
+
+	u32_hashset_free_buckets(set->buckets, set->buckets_cnt);
+	set->buckets_cnt = new_buckets_cnt;
+	set->buckets = new_buckets;
+	return 0;
+
+nomem:
+	u32_hashset_free_buckets(new_buckets, new_buckets_cnt);
+
+	return -ENOMEM;
+}
+
+void u32_hashset_clear(struct u32_hashset *set)
+{
+	u32_hashset_free_buckets(set->buckets, set->buckets_cnt);
+	set->buckets = NULL;
+	set->buckets_cnt = 0;
+	set->items_cnt = 0;
+}
+
+bool u32_hashset_find(const struct u32_hashset *set, const u32 key)
+{
+	struct u32_hashset_bucket *bkt;
+	u32 i, hash;
+
+	if (!set->buckets)
+		return false;
+
+	hash = jhash_1word(key, set->seed) % set->buckets_cnt;
+	bkt = set->buckets[hash];
+	if (!bkt)
+		return false;
+
+	for (i = 0; i < bkt->cnt; ++i)
+		if (bkt->items[i] == key)
+			return true;
+
+	return false;
+}
+
+int u32_hashset_add(struct u32_hashset *set, u32 key)
+{
+	struct u32_hashset_bucket *new_bucket;
+	u32 hash;
+	int err;
+
+	if (u32_hashset_find(set, key))
+		return 0;
+
+	if (u32_hashset_needs_to_grow(set)) {
+		err = u32_hashset_grow(set);
+		if (err)
+			return err;
+	}
+
+	hash = jhash_1word(key, set->seed) % set->buckets_cnt;
+	new_bucket = u32_hashset_put_in_bucket(set->buckets[hash], key);
+	if (!new_bucket)
+		return -ENOMEM;
+
+	set->buckets[hash] = new_bucket;
+	set->items_cnt++;
+
+	return 0;
+}
diff --git a/kernel/bpf/u32_hashset.h b/kernel/bpf/u32_hashset.h
new file mode 100644
index 000000000000..76f03e2e4f14
--- /dev/null
+++ b/kernel/bpf/u32_hashset.h
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* A hashset for u32 values, based on tools/lib/bpf/hashmap.h */
+
+#ifndef __U32_HASHSET_H__
+#define __U32_HASHSET_H__
+
+#include "linux/gfp_types.h"
+#include "linux/random.h"
+#include "linux/slab.h"
+#include <linux/jhash.h>
+
+struct u32_hashset_bucket {
+	u32 cnt;
+	u32 cap;
+	u32 items[];
+};
+
+struct u32_hashset {
+	struct u32_hashset_bucket **buckets;
+	size_t buckets_cnt;
+	size_t items_cnt;
+	u32 seed;
+};
+
+void u32_hashset_clear(struct u32_hashset *set);
+bool u32_hashset_find(const struct u32_hashset *set, const u32 key);
+int u32_hashset_add(struct u32_hashset *set, u32 key);
+
+#endif /* __U32_HASHSET_H__ */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c10f2619c4f..0d3a695aa4da 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 
 #include "disasm.h"
+#include "u32_hashset.h"
 
 static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type) \
@@ -13629,16 +13630,25 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 	return true;
 }
 
-static void find_equal_scalars(struct bpf_verifier_state *vstate,
-			       struct bpf_reg_state *known_reg)
+static int find_equal_scalars(struct bpf_verifier_env *env,
+			      struct bpf_verifier_state *vstate,
+			      struct bpf_reg_state *known_reg)
 {
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
+	int err = 0, count = 0;
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
+		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id) {
 			copy_register_state(reg, known_reg);
+			++count;
+		}
 	}));
+
+	if (count > 1)
+		err = u32_hashset_add(env->range_transfer_ids, known_reg->id);
+
+	return err;
 }
 
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
@@ -13803,8 +13813,13 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 						    src_reg, dst_reg, opcode);
 			if (src_reg->id &&
 			    !WARN_ON_ONCE(src_reg->id != other_branch_regs[insn->src_reg].id)) {
-				find_equal_scalars(this_branch, src_reg);
-				find_equal_scalars(other_branch, &other_branch_regs[insn->src_reg]);
+				err = find_equal_scalars(env, this_branch, src_reg);
+				if (err)
+					return err;
+				err = find_equal_scalars(env, other_branch,
+							 &other_branch_regs[insn->src_reg]);
+				if (err)
+					return err;
 			}
 
 		}
@@ -13816,8 +13831,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
 	    !WARN_ON_ONCE(dst_reg->id != other_branch_regs[insn->dst_reg].id)) {
-		find_equal_scalars(this_branch, dst_reg);
-		find_equal_scalars(other_branch, &other_branch_regs[insn->dst_reg]);
+		err = find_equal_scalars(env, this_branch, dst_reg);
+		if (err)
+			return err;
+		err = find_equal_scalars(env, other_branch, &other_branch_regs[insn->dst_reg]);
+		if (err)
+			return err;
 	}
 
 	/* if one pointer register is compared to another pointer
@@ -15170,8 +15189,13 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * The only state difference between first and second visits of (5) is
 		 * bpf_reg_state::id assignments for r6 and r7: (b, b) vs (a, b).
 		 * Thus, use check_ids() to distinguish these states.
+		 *
+		 * All children states of 'rold' are already verified.
+		 * Thus env->range_transfer_ids contains all ids that gained range via
+		 * find_equal_scalars() during children verification.
 		 */
-		if (!check_ids(rold->id, rcur->id, idmap))
+		if (u32_hashset_find(env->range_transfer_ids, rold->id) &&
+		    !check_ids(rold->id, rcur->id, idmap))
 			return false;
 		if (regs_exact(rold, rcur, idmap))
 			return true;
@@ -19289,6 +19313,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (!env->explored_states)
 		goto skip_full_check;
 
+	env->range_transfer_ids = kzalloc(sizeof(*env->range_transfer_ids), GFP_KERNEL);
+	if (!env->range_transfer_ids)
+		goto skip_full_check;
+
 	ret = add_subprog_and_kfunc(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -19327,6 +19355,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 
 skip_full_check:
 	kvfree(env->explored_states);
+	u32_hashset_clear(env->range_transfer_ids);
+	kvfree(env->range_transfer_ids);
 
 	if (ret == 0)
 		ret = check_max_stack_depth(env);
-- 
2.40.1


