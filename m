Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A190958CA29
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbiHHOIn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbiHHOId (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:08:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ADFFD1C
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E530B80EB7
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E78C433D7;
        Mon,  8 Aug 2022 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967703;
        bh=tMToDOdyqOKRWuLq6A6FWQMvwPO2a9/YJ2D2sK9RWOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FULk5KM6+0OE/kR6yzw3FVM7WQ9gs5Ek8JbE18aN31e1+CUEcbBC6bVcZNeAwF9aN
         WYylpSUROHySvh6IF9Vw2K8mOG+sDgRXxXAGVEvtMkcEIdCfQpNRiCKinGi4FaJOo3
         WBsZ4hhCY7wjJp73snbXaapSuiOkTY3HbBASQm5YFeb8oMJ6G+6crhzVcMQAW9loYt
         eYIkjlI9Olp1vH6b+DhryJrUp2CuUzxwcEQBL9DJ+EaFkN+oy/48D+1cL03CXpv6Yh
         vLOzTS1cWvg6HalEBgroU/MsH3lBc4dbeuxgtIweABVFAl4RozTO6VCtm7fz9Pl8e4
         twkOgpMnBB5qw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC PATCH bpf-next 10/17] bpf: Add support to attach program to multiple trampolines
Date:   Mon,  8 Aug 2022 16:06:19 +0200
Message-Id: <20220808140626.422731-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808140626.422731-1-jolsa@kernel.org>
References: <20220808140626.422731-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support to attach program to multiple trampolines
with new attach/detach interface:

  int bpf_trampoline_multi_attach(struct bpf_tramp_prog *tp,
                                  struct bpf_tramp_id *id)
  int bpf_trampoline_multi_detach(struct bpf_tramp_prog *tp,
                                  struct bpf_tramp_id *id)

The program is passed as bpf_tramp_prog object and trampolines to
attach it to are passed as bpf_tramp_id object.

The interface creates new bpf_trampoline object which is initialized
as 'multi' trampoline and stored separtely from standard trampolines.

There are following rules how the standard and multi trampolines
go along:
  - multi trampoline can attach on top of existing single trampolines,
    which creates 2 types of function IDs:

      1) single-IDs - functions that are attached within existing single
         trampolines
      2) multi-IDs  - functions that were 'free' and are now taken by new
         'multi' trampoline

  - we allow overlapping of 2 'multi' trampolines if they are attached
    to same IDs
  - we do now allow any other overlapping of 2 'multi' trampolines
  - any new 'single' trampoline cannot attach to existing multi-IDs IDs.

Maybe better explained on following example:

   - you want to attach program P to functions A,B,C,D,E,F
     via bpf_trampoline_multi_attach

   - D,E,F already have standard trampoline attached

   - the bpf_trampoline_multi_attach will create new 'multi' trampoline
     which spans over A,B,C functions and attach program P to single
     trampolines D,E,F

   - A,B,C functions are now 'not attachable' by any trampoline
     until the above 'multi' trampoline is released

  -  D,E,F functions are still attachable by any new trampoline

If the bpf_tramp_id object contains ID that exists as the standard
trampoline the interface will add the program

These limitations are there to avoid extra complexity of splitting
existing trampolines, which turned out to be nightmare. However the
current code does not prevent any such feature improvement in the
future.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |   8 +
 kernel/bpf/trampoline.c | 393 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 394 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a23ff5b8d14c..9842554e4fa4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -901,6 +901,12 @@ struct bpf_trampoline {
 	struct module *mod;
 	struct bpf_shim_tramp_link *shim_link;
 	struct bpf_tramp_update update;
+	struct {
+		struct list_head list;
+		struct bpf_tramp_id *id;
+		struct bpf_tramp_id *id_multi;
+		struct bpf_tramp_id *id_singles;
+	} multi;
 };
 
 struct bpf_attach_target_info {
@@ -945,6 +951,8 @@ void bpf_trampoline_put(struct bpf_trampoline *tr);
 struct bpf_tramp_id *bpf_tramp_id_alloc(u32 cnt);
 void bpf_tramp_id_put(struct bpf_tramp_id *id);
 int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
+int bpf_trampoline_multi_detach(struct bpf_tramp_prog *tp, struct bpf_tramp_id *id);
+int bpf_trampoline_multi_attach(struct bpf_tramp_prog *tp, struct bpf_tramp_id *id);
 #define BPF_DISPATCHER_INIT(_name) {				\
 	.mutex = __MUTEX_INITIALIZER(_name.mutex),		\
 	.func = &_name##_func,					\
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b6b57aa09364..9be6e5737eba 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -14,6 +14,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/bpf_lsm.h>
 #include <linux/delay.h>
+#include <linux/bsearch.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -33,6 +34,7 @@ static DEFINE_MUTEX(trampoline_mutex);
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex,
 				 struct list_head *upd);
+static bool key_in_multi_trampoline(u64 key);
 
 static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, enum ftrace_ops_cmd cmd)
 {
@@ -170,7 +172,6 @@ struct bpf_tramp_id *bpf_tramp_id_alloc(u32 max)
 	return id;
 }
 
-__maybe_unused
 static struct bpf_tramp_id *bpf_tramp_id_get(struct bpf_tramp_id *id)
 {
 	refcount_inc(&id->refcnt);
@@ -226,10 +227,12 @@ static struct bpf_trampoline *bpf_trampoline_alloc(void)
 
 static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 {
-	struct bpf_trampoline *tr;
+	struct bpf_trampoline *tr = NULL;
 	struct hlist_head *head;
 
 	mutex_lock(&trampoline_mutex);
+	if (key_in_multi_trampoline(key))
+		goto out;
 	tr = __bpf_trampoline_lookup(key);
 	if (tr) {
 		refcount_inc(&tr->refcnt);
@@ -357,7 +360,7 @@ static int register_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im
 }
 
 static struct bpf_tramp_progs *
-bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
+bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg, bool *multi)
 {
 	const struct bpf_prog_array_item *item;
 	struct bpf_prog_array *prog_array;
@@ -383,6 +386,7 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 
 		while ((prog = READ_ONCE(item->prog))) {
 			*ip_arg |= prog->call_get_func_ip;
+			*multi |= is_tracing_multi(prog->expected_attach_type);
 			tp->prog = prog;
 			tp->cookie = item->bpf_cookie;
 			tp++; item++;
@@ -524,16 +528,23 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
 	return ERR_PTR(err);
 }
 
+static struct btf_func_model btf_multi_func_model = {
+	.ret_size = 0,
+	.nr_args = 6,
+	.arg_size = { 8, 8, 8, 8, 8, 8, },
+};
+
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex,
 				 struct list_head *upd)
 {
+	struct btf_func_model *model = &tr->func.model;
 	struct bpf_tramp_image *im;
 	struct bpf_tramp_progs *tprogs;
 	u32 orig_flags = tr->flags;
-	bool ip_arg = false;
+	bool ip_arg = false, multi = false;
 	int err, total;
 
-	tprogs = bpf_trampoline_get_progs(tr, &total, &ip_arg);
+	tprogs = bpf_trampoline_get_progs(tr, &total, &ip_arg, &multi);
 	if (IS_ERR(tprogs))
 		return PTR_ERR(tprogs);
 
@@ -568,6 +579,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 
 	if (ip_arg)
 		tr->flags |= BPF_TRAMP_F_IP_ARG;
+	if (multi) {
+		tr->flags |= BPF_TRAMP_F_ORIG_STACK;
+		model = &btf_multi_func_model;
+	}
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 again:
@@ -577,7 +592,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 #endif
 
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + PAGE_SIZE,
-					  &tr->func.model, tr->flags, tprogs,
+					  model, tr->flags, tprogs,
 					  tr->func.addr);
 	if (err < 0)
 		goto out;
@@ -949,11 +964,18 @@ static void __bpf_trampoline_put(struct bpf_trampoline *tr)
 	 * fexit progs. The fentry-only trampoline will be freed via
 	 * multiple rcu callbacks.
 	 */
-	hlist_del(&tr->hlist);
 	if (tr->fops) {
 		ftrace_free_filter(tr->fops);
 		kfree(tr->fops);
 	}
+	if (tr->multi.id) {
+		bpf_tramp_id_put(tr->multi.id);
+		bpf_tramp_id_put(tr->multi.id_multi);
+		bpf_tramp_id_put(tr->multi.id_singles);
+		list_del(&tr->multi.list);
+	} else {
+		hlist_del(&tr->hlist);
+	}
 	kfree(tr);
 }
 
@@ -966,6 +988,363 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	mutex_unlock(&trampoline_mutex);
 }
 
+static LIST_HEAD(multi_trampolines);
+
+static int btf_id_cmp(const void *a, const void *b)
+{
+	const u32 *x = a;
+	const u32 *y = b;
+
+	if (*x == *y)
+		return 0;
+	return *x < *y ? -1 : 1;
+}
+
+static bool id_match(struct bpf_tramp_id *a, struct bpf_tramp_id *b)
+{
+	if (a->obj_id != b->obj_id)
+		return false;
+	if (a->cnt != b->cnt)
+		return false;
+	return memcmp(a->id, b->id, sizeof(u32) * a->cnt) == 0;
+}
+
+static bool id_cross(struct bpf_tramp_id *a, struct bpf_tramp_id *b)
+{
+	u32 i, id;
+
+	for (i = 0; i < a->cnt; i++) {
+		id = a->id[i];
+		if (bsearch(&id, b->id, b->cnt, sizeof(u32), btf_id_cmp))
+			return true;
+	}
+	return false;
+}
+
+static void id_add(struct bpf_tramp_id *id, int btf_id, void *addr)
+{
+	if (WARN_ON_ONCE(id->cnt >= id->max))
+		return;
+	id->id[id->cnt] = btf_id;
+	id->addr[id->cnt] = addr;
+	id->cnt++;
+}
+
+static bool key_in_multi_trampoline(u64 key)
+{
+	struct bpf_trampoline *tr;
+	struct bpf_tramp_id *id;
+	u32 obj_id, btf_id;
+
+	bpf_trampoline_unpack_key(key, &obj_id, &btf_id);
+
+	list_for_each_entry(tr, &multi_trampolines, multi.list) {
+		id = tr->multi.id_multi;
+
+		if (obj_id != id->obj_id)
+			continue;
+		if (bsearch(&btf_id, id->id, id->cnt, sizeof(u32), btf_id_cmp))
+			return true;
+	}
+	return false;
+}
+
+static void bpf_trampoline_rollback(struct bpf_trampoline *tr)
+{
+	struct bpf_tramp_update *upd = &tr->update;
+
+	tr->progs_array[upd->kind] = upd->old_array;
+	tr->progs_cnt[upd->kind]--;
+	if (tr->update.im)
+		bpf_tramp_image_put(tr->update.im);
+}
+
+static void bpf_trampoline_commit(struct bpf_trampoline *tr)
+{
+	if (tr->cur_image)
+		bpf_tramp_image_put(tr->cur_image);
+	tr->cur_image = tr->update.im;
+	if (tr->update.action == BPF_TRAMP_UPDATE_UNREG)
+		tr->selector = 0;
+	else
+		tr->selector++;
+}
+
+static int bpf_tramp_update_set(struct list_head *upd)
+{
+	struct bpf_trampoline *tr, *trm = NULL;
+	int i, rollback_cnt = 0, err = -EINVAL;
+	unsigned long ip, image_new, image_old;
+
+	list_for_each_entry(tr, upd, update.list) {
+		if (tr->multi.id_multi) {
+			trm = tr;
+			continue;
+		}
+
+		ip = (unsigned long) tr->func.addr;
+		image_new = tr->update.im ? (unsigned long) tr->update.im->image : 0;
+		image_old = tr->cur_image ? (unsigned long) tr->cur_image->image : 0;
+
+		switch (tr->update.action) {
+		case BPF_TRAMP_UPDATE_REG:
+			err = register_ftrace_direct_multi(tr->fops, image_new);
+			break;
+		case BPF_TRAMP_UPDATE_MODIFY:
+			err = modify_ftrace_direct_multi(tr->fops, image_new);
+			break;
+		case BPF_TRAMP_UPDATE_UNREG:
+			err = unregister_ftrace_direct_multi(tr->fops, image_old);
+			break;
+		}
+		if (err)
+			goto out_rollback;
+		rollback_cnt++;
+	}
+
+	if (!trm)
+		return 0;
+
+	if (trm->update.action == BPF_TRAMP_UPDATE_REG) {
+		for (i = 0; i < trm->multi.id_multi->cnt; i++) {
+			ip = (unsigned long) trm->multi.id_multi->addr[i];
+			err = ftrace_set_filter_ip(trm->fops, ip, 0, 0);
+			if (err)
+				goto out_rollback;
+		}
+	}
+
+	image_new = trm->update.im ? (unsigned long) trm->update.im->image : 0;
+	image_old = trm->cur_image ? (unsigned long) trm->cur_image->image : 0;
+
+	switch (trm->update.action) {
+	case BPF_TRAMP_UPDATE_REG:
+		err = register_ftrace_direct_multi(trm->fops, image_new);
+		break;
+	case BPF_TRAMP_UPDATE_MODIFY:
+		err = modify_ftrace_direct_multi(trm->fops, image_new);
+		break;
+	case BPF_TRAMP_UPDATE_UNREG:
+		err = unregister_ftrace_direct_multi(trm->fops, image_old);
+		break;
+	default:
+		break;
+	}
+
+	if (!err)
+		return 0;
+
+out_rollback:
+	i = 0;
+	list_for_each_entry(tr, upd, update.list) {
+		if (tr->multi.id_multi)
+			continue;
+
+		ip = (unsigned long) tr->func.addr;
+		image_new = tr->update.im ? (unsigned long) tr->update.im->image : 0;
+		image_old = tr->cur_image ? (unsigned long) tr->cur_image->image : 0;
+
+		switch (tr->update.action) {
+		case BPF_TRAMP_UPDATE_REG:
+			err = unregister_ftrace_direct_multi(tr->fops, image_new);
+			break;
+		case BPF_TRAMP_UPDATE_MODIFY:
+			err = modify_ftrace_direct_multi(tr->fops, image_old);
+			break;
+		case BPF_TRAMP_UPDATE_UNREG:
+			err = register_ftrace_direct_multi(tr->fops, image_old);
+			break;
+		}
+		if (rollback_cnt == ++i)
+			break;
+	}
+
+	return err;
+}
+
+static struct bpf_trampoline*
+multi_trampoline_alloc(struct bpf_tramp_id *id, struct bpf_tramp_prog *tp)
+{
+	struct bpf_tramp_id *id_multi = NULL, *id_singles = NULL;
+	struct bpf_trampoline *tr, *trm;
+	u64 key;
+	int i;
+
+	trm = bpf_trampoline_alloc();
+	if (!trm)
+		return NULL;
+
+	id_multi = bpf_tramp_id_alloc(id->cnt);
+	id_singles = bpf_tramp_id_alloc(id->cnt);
+	if (!id_multi || !id_singles)
+		goto error;
+
+	for (i = 0; i < id->cnt; i++) {
+		key = bpf_trampoline_compute_key(NULL, tp->prog->aux->attach_btf,
+						 id->id[i]);
+		tr = __bpf_trampoline_lookup(key);
+		if (!tr) {
+			id_add(id_multi, id->id[i], id->addr[i]);
+			continue;
+		}
+		id_add(id_singles, id->id[i], id->addr[i]);
+	}
+
+	trm->multi.id = bpf_tramp_id_get(id);
+	trm->multi.id_multi = id_multi;
+	trm->multi.id_singles = id_singles;
+
+	list_add_tail(&trm->multi.list, &multi_trampolines);
+	return trm;
+error:
+	bpf_tramp_id_put(id_multi);
+	bpf_tramp_id_put(id_singles);
+	kfree(trm);
+	return NULL;
+}
+
+int bpf_trampoline_multi_attach(struct bpf_tramp_prog *tp, struct bpf_tramp_id *id)
+{
+	struct bpf_trampoline *tr, *trm = NULL, *n;
+	struct bpf_tramp_id *id_singles = NULL;
+	int i, err = -EBUSY;
+	LIST_HEAD(upd);
+	u64 key;
+
+	mutex_lock(&trampoline_mutex);
+
+	list_for_each_entry(tr, &multi_trampolines, multi.list) {
+		if (id_match(id, tr->multi.id)) {
+			trm = tr;
+			break;
+		}
+		if (id_cross(id, tr->multi.id))
+			goto out_unlock;
+	}
+
+	if (trm) {
+		id_singles = tr->multi.id_singles;
+		refcount_inc(&tr->refcnt);
+	} else {
+		trm = multi_trampoline_alloc(id, tp);
+		if (!trm)
+			goto out_rollback;
+		id_singles = trm->multi.id_singles;
+	}
+
+	mutex_lock(&trm->mutex);
+	err = __bpf_trampoline_link_prog(tp, trm, &upd);
+	if (err) {
+		mutex_unlock(&trm->mutex);
+		__bpf_trampoline_put(trm);
+		goto out_unlock;
+	}
+
+	for (i = 0; i < id_singles->cnt; i++) {
+		key = bpf_trampoline_compute_key(NULL, tp->prog->aux->attach_btf,
+						 id_singles->id[i]);
+		tr = __bpf_trampoline_lookup(key);
+		if (!tr)
+			continue;
+		mutex_lock(&tr->mutex);
+		err = __bpf_trampoline_link_prog(tp, tr, &upd);
+		if (err) {
+			mutex_unlock(&tr->mutex);
+			goto out_rollback;
+		}
+		refcount_inc(&tr->refcnt);
+	}
+
+	err = bpf_tramp_update_set(&upd);
+	if (err)
+		goto out_rollback;
+
+	list_for_each_entry_safe(tr, n, &upd, update.list) {
+		bpf_trampoline_commit(tr);
+		list_del_init(&tr->update.list);
+		mutex_unlock(&tr->mutex);
+	}
+
+out_unlock:
+	mutex_unlock(&trampoline_mutex);
+	return err;
+
+out_rollback:
+	list_for_each_entry_safe(tr, n, &upd, update.list) {
+		bpf_trampoline_rollback(tr);
+		list_del_init(&tr->update.list);
+		mutex_unlock(&tr->mutex);
+		__bpf_trampoline_put(tr);
+	}
+	mutex_unlock(&trampoline_mutex);
+	return err;
+}
+
+int bpf_trampoline_multi_detach(struct bpf_tramp_prog *tp, struct bpf_tramp_id *id)
+{
+	struct bpf_trampoline *tr, *trm = NULL, *n;
+	LIST_HEAD(upd);
+	int i, err;
+	u64 key;
+
+	mutex_lock(&trampoline_mutex);
+	list_for_each_entry(tr, &multi_trampolines, multi.list) {
+		if (id_match(tr->multi.id, id)) {
+			trm = tr;
+			break;
+		}
+	}
+	if (!trm) {
+		err = -EINVAL;
+		goto fail_unlock;
+	}
+
+	mutex_lock(&trm->mutex);
+	err = __bpf_trampoline_unlink_prog(tp, trm, &upd);
+	if (err) {
+		mutex_unlock(&trm->mutex);
+		goto fail_unlock;
+	}
+
+	for (i = 0; i < trm->multi.id_singles->cnt; i++) {
+		key = bpf_trampoline_compute_key(NULL, tp->prog->aux->attach_btf,
+						 trm->multi.id_singles->id[i]);
+		tr = __bpf_trampoline_lookup(key);
+		if (!tr) {
+			err = -EINVAL;
+			goto fail_unlock;
+		}
+		mutex_lock(&tr->mutex);
+		err = __bpf_trampoline_unlink_prog(tp, tr, &upd);
+		if (err) {
+			mutex_unlock(&tr->mutex);
+			goto fail_unlock;
+		}
+	}
+
+	err = bpf_tramp_update_set(&upd);
+	if (err)
+		goto fail_unlock;
+
+	list_for_each_entry_safe(tr, n, &upd, update.list) {
+		bpf_trampoline_commit(tr);
+		list_del_init(&tr->update.list);
+		mutex_unlock(&tr->mutex);
+		__bpf_trampoline_put(tr);
+	}
+
+	mutex_unlock(&trampoline_mutex);
+	return 0;
+fail_unlock:
+	list_for_each_entry_safe(tr, n, &upd, update.list) {
+		bpf_trampoline_rollback(tr);
+		list_del_init(&tr->update.list);
+		mutex_unlock(&tr->mutex);
+	}
+	mutex_unlock(&trampoline_mutex);
+	return err;
+}
+
 #define NO_START_TIME 1
 static __always_inline u64 notrace bpf_prog_start_time(void)
 {
-- 
2.37.1

