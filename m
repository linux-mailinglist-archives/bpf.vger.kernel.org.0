Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5263A58CA22
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiHHOHx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243183AbiHHOHv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D7FFD22
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40F4F60D14
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28CFC433D7;
        Mon,  8 Aug 2022 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967669;
        bh=0ImTWqSl8rHzkQjsJwwUSMF3ThxfoKnurf9mC2sBqoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGd7U2hrF9hfX2Wa/Zb/P93PC0YnG4MKj6YbTgzKWWpdlBcXWQCnquY9ORLYmnVJC
         arAtvJGRLkDilLwZQ1VQNYq5fyY1+c+Hwytit+WHvoMv4sGBC1/Uh7Eo2n0r/rC9uU
         Ybt9K/5ELtPPN22PjmHhTJVFuj2JaNd0WY9zRgwTVz8r/b1hkr8sFp6hFmVkKGRUsO
         8b/ndNp71/54xehJ99WMJe+a7kwmSkfHSciju1BFf9tkRveitRbXSjD18Bni/VeQ7N
         opHP4Uw/G2OZ8gB/103IpO63+tkApooAkpN7tRv8Oc0gEq16azbCVgckG8UjBu1V3x
         drN65Z2N1ybOQ==
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
Subject: [RFC PATCH bpf-next 07/17] bpf: Add support to postpone trampoline update
Date:   Mon,  8 Aug 2022 16:06:16 +0200
Message-Id: <20220808140626.422731-8-jolsa@kernel.org>
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

Adding support to postpone the trampoline update and record
it to the update list. If the update list is provided, all
the reg/unreg/modify functions only add trampoline to the
update list and stores the requested update information/data
to the trampoline.

It will bed used in following changes where we need to do the
actual trampoline update at the end of the attachment.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     | 31 ++++++++++++-----
 kernel/bpf/trampoline.c | 76 +++++++++++++++++++++++++++++------------
 2 files changed, 78 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a5738d57f6bd..a23ff5b8d14c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -768,6 +768,28 @@ struct btf_func_model {
  */
 #define BPF_MAX_TRAMP_LINKS 38
 
+enum bpf_tramp_update_action {
+	BPF_TRAMP_UPDATE_REG,
+	BPF_TRAMP_UPDATE_UNREG,
+	BPF_TRAMP_UPDATE_MODIFY,
+};
+
+enum bpf_tramp_prog_type {
+	BPF_TRAMP_FENTRY,
+	BPF_TRAMP_FEXIT,
+	BPF_TRAMP_MODIFY_RETURN,
+	BPF_TRAMP_MAX,
+	BPF_TRAMP_REPLACE, /* more than MAX */
+};
+
+struct bpf_tramp_update {
+	enum bpf_tramp_update_action action;
+	struct bpf_tramp_image *im;
+	enum bpf_tramp_prog_type kind;
+	struct bpf_prog_array *old_array;
+	struct list_head list;
+};
+
 struct bpf_tramp_prog {
 	struct bpf_prog *prog;
 	u64 cookie;
@@ -827,14 +849,6 @@ struct bpf_ksym {
 	bool			 prog;
 };
 
-enum bpf_tramp_prog_type {
-	BPF_TRAMP_FENTRY,
-	BPF_TRAMP_FEXIT,
-	BPF_TRAMP_MODIFY_RETURN,
-	BPF_TRAMP_MAX,
-	BPF_TRAMP_REPLACE, /* more than MAX */
-};
-
 struct bpf_tramp_image {
 	void *image;
 	struct bpf_ksym ksym;
@@ -886,6 +900,7 @@ struct bpf_trampoline {
 	u64 selector;
 	struct module *mod;
 	struct bpf_shim_tramp_link *shim_link;
+	struct bpf_tramp_update update;
 };
 
 struct bpf_attach_target_info {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d28070247fa3..e926692ded85 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -31,7 +31,8 @@ static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
 static DEFINE_MUTEX(trampoline_mutex);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
+static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex,
+				 struct list_head *upd);
 
 static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, enum ftrace_ops_cmd cmd)
 {
@@ -87,13 +88,13 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, enum ftrace_ops_cmd
 
 		if ((tr->flags & BPF_TRAMP_F_CALL_ORIG) &&
 		    !(tr->flags & BPF_TRAMP_F_ORIG_STACK))
-			ret = bpf_trampoline_update(tr, false /* lock_direct_mutex */);
+			ret = bpf_trampoline_update(tr, false /* lock_direct_mutex */, NULL);
 		break;
 	case FTRACE_OPS_CMD_DISABLE_SHARE_IPMODIFY_PEER:
 		tr->flags &= ~BPF_TRAMP_F_SHARE_IPMODIFY;
 
 		if (tr->flags & BPF_TRAMP_F_ORIG_STACK)
-			ret = bpf_trampoline_update(tr, false /* lock_direct_mutex */);
+			ret = bpf_trampoline_update(tr, false /* lock_direct_mutex */, NULL);
 		break;
 	default:
 		ret = -EINVAL;
@@ -244,12 +245,20 @@ static void bpf_trampoline_module_put(struct bpf_trampoline *tr)
 	tr->mod = NULL;
 }
 
-static int unregister_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im)
+static int unregister_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im,
+			     struct list_head *upd)
 {
 	void *old_addr = im->image;
 	void *ip = tr->func.addr;
 	int ret;
 
+	if (upd) {
+		tr->update.action = BPF_TRAMP_UPDATE_UNREG;
+		tr->update.im = NULL;
+		list_add_tail(&tr->update.list, upd);
+		return 0;
+	}
+
 	if (tr->func.ftrace_managed)
 		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr);
 	else
@@ -257,17 +266,24 @@ static int unregister_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *
 
 	if (!ret)
 		bpf_trampoline_module_put(tr);
+
 	return ret;
 }
 
 static int modify_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im,
-			 bool lock_direct_mutex)
+			 bool lock_direct_mutex, struct list_head *upd)
 {
 	void *old_addr = tr->cur_image->image;
 	void *new_addr = im->image;
 	void *ip = tr->func.addr;
 	int ret;
 
+	if (upd) {
+		tr->update.action = BPF_TRAMP_UPDATE_MODIFY;
+		tr->update.im = im;
+		list_add_tail(&tr->update.list, upd);
+		return 0;
+	}
 	if (tr->func.ftrace_managed) {
 		if (lock_direct_mutex)
 			ret = modify_ftrace_direct_multi(tr->fops, (long)new_addr);
@@ -280,7 +296,8 @@ static int modify_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im,
 }
 
 /* first time registering */
-static int register_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im)
+static int register_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im,
+			   struct list_head *upd)
 {
 	void *new_addr = im->image;
 	void *ip = tr->func.addr;
@@ -294,6 +311,15 @@ static int register_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im
 		tr->func.ftrace_managed = true;
 	}
 
+	if (upd) {
+		if (ip && !tr->func.ftrace_managed)
+			return -ENOTSUPP;
+		tr->update.action = BPF_TRAMP_UPDATE_REG;
+		tr->update.im = im;
+		list_add_tail(&tr->update.list, upd);
+		return 0;
+	}
+
 	if (bpf_trampoline_module_get(tr))
 		return -ENOENT;
 
@@ -477,7 +503,8 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
 	return ERR_PTR(err);
 }
 
-static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
+static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex,
+				 struct list_head *upd)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_tramp_progs *tprogs;
@@ -490,10 +517,12 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		return PTR_ERR(tprogs);
 
 	if (total == 0) {
-		err = unregister_fentry(tr, tr->cur_image);
-		bpf_tramp_image_put(tr->cur_image);
-		tr->cur_image = NULL;
-		tr->selector = 0;
+		err = unregister_fentry(tr, tr->cur_image, upd);
+		if (!upd) {
+			bpf_tramp_image_put(tr->cur_image);
+			tr->cur_image = NULL;
+			tr->selector = 0;
+		}
 		goto out;
 	}
 
@@ -536,10 +565,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	WARN_ON(!tr->cur_image && tr->selector);
 	if (tr->cur_image)
 		/* progs already running at this address */
-		err = modify_fentry(tr, im, lock_direct_mutex);
+		err = modify_fentry(tr, im, lock_direct_mutex, upd);
 	else
 		/* first time registering */
-		err = register_fentry(tr, im);
+		err = register_fentry(tr, im, upd);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	if (err == -EAGAIN) {
@@ -553,7 +582,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		goto again;
 	}
 #endif
-	if (err)
+	if (err || upd)
 		goto out;
 
 	if (tr->cur_image)
@@ -592,7 +621,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	}
 }
 
-static int __bpf_trampoline_link_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline *tr)
+static int __bpf_trampoline_link_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline *tr,
+				      struct list_head *upd)
 {
 	struct bpf_prog_array *old_array, *new_array;
 	const struct bpf_prog_array_item *item;
@@ -638,11 +668,14 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_prog *tp, struct bpf_tram
 		return -ENOMEM;
 	tr->progs_array[kind] = new_array;
 	tr->progs_cnt[kind]++;
-	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
+	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */, upd);
 	if (err) {
 		tr->progs_array[kind] = old_array;
 		tr->progs_cnt[kind]--;
 		bpf_prog_array_free(new_array);
+	} else if (upd) {
+		tr->update.kind = kind;
+		tr->update.old_array = old_array;
 	} else {
 		bpf_prog_array_free(old_array);
 	}
@@ -654,12 +687,13 @@ int bpf_trampoline_link_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline *t
 	int err;
 
 	mutex_lock(&tr->mutex);
-	err = __bpf_trampoline_link_prog(tp, tr);
+	err = __bpf_trampoline_link_prog(tp, tr, NULL);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
 
-static int __bpf_trampoline_unlink_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline *tr)
+static int __bpf_trampoline_unlink_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline *tr,
+					struct list_head *upd)
 {
 	struct bpf_prog_array *old_array, *new_array;
 	enum bpf_tramp_prog_type kind;
@@ -683,7 +717,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_prog *tp, struct bpf_tr
 	tr->progs_cnt[kind]--;
 	tr->progs_array[kind] = new_array;
 	bpf_prog_array_free(old_array);
-	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
+	return bpf_trampoline_update(tr, true /* lock_direct_mutex */, upd);
 }
 
 /* bpf_trampoline_unlink_prog() should never fail. */
@@ -692,7 +726,7 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline
 	int err;
 
 	mutex_lock(&tr->mutex);
-	err = __bpf_trampoline_unlink_prog(tp, tr);
+	err = __bpf_trampoline_unlink_prog(tp, tr, NULL);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
@@ -804,7 +838,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 		goto err;
 	}
 
-	err = __bpf_trampoline_link_prog(&shim_link->tp, tr);
+	err = __bpf_trampoline_link_prog(&shim_link->tp, tr, NULL);
 	if (err)
 		goto err;
 
-- 
2.37.1

