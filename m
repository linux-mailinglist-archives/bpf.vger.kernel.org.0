Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD8848CC0D
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356818AbiALTf3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 14:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344406AbiALTe3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 14:34:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA2C061757
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:34:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s89-20020a25aa62000000b00611afc92630so2202082ybi.17
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WLIXWpZVKEATWJu5eTPegEpeW0twWlWVehQQ8+8FOxE=;
        b=mH1Ubt3w9U0pqmWlDUXcSlpvOXNkEx9U6fJxkjMJPbmpfl+9wRAw8BcAEyvOAoF9hE
         8nZBvIeAiMH9DiXJkL/rBp6xDDJbPIX3WwbYAOObaayDObqFLf3wZPrLfc741xg1/gVs
         Z2JyUmOrQjk3enKvl4TFqMGyxyDjS++PvLZXBecaYlgU0FEtx4EDAAjaZwN9wOiSSilA
         cDDpB8iRUXxfiJMR+QUZxLgbhPwwxuarWWZ86XL2O8EjNZxsIlZJHnxHl9jz4/Lepwnh
         QQbDKnNZkvZ6ip9L7QXAOLEugjQ7zju1vw3/xndq3jbNk1gIoU79nsyUbQNhelDTGqu/
         y8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WLIXWpZVKEATWJu5eTPegEpeW0twWlWVehQQ8+8FOxE=;
        b=LjdcpmucZuMHkc1T9zbedqxcbtYLrjNPssjJsFdPe1bHfCn4Oz0+D8bd2rdZPZ/slB
         MG3MvC3hQo5lZ8J6NzVqvmGtAYc/6ZOenjihJOpZdOVJS8E9pl6c6+wXoJ96Svdsw6rJ
         CPuyZ3rbX8xmurYt4wyz6bsDEavukXo5xKeXe6OuD5VY/5Brma4Kh0Hv1S+DiowuvQRR
         sPqyQPRppvu4DMGQYuqlJ1VvZcHOhGNSQWJjuO9i0Lvnd55564+6cCkKF/2X5hMTF/E1
         nuIEhObMY9b5fJb8GF2ZDQyM8QJ8dNK9aTz1QCyzHZfRqOYRdUM/FAnsqz3XoWwwiL9x
         6KGA==
X-Gm-Message-State: AOAM532/jVWK0vLI/NQ72HJpu8ONlawhWrRlD6Tq1LV2FYfJqHnvIthX
        bga6Rm8sM4fyrgvV4CvxdZwLcrqbcbU=
X-Google-Smtp-Source: ABdhPJxd+QOF/CnVgQTAklghJbHNdY76dBX/dZ5ROSK1tyb0otcxJmi/YSUjxV96GJwmicv765QlD8IvGD8=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a05:6902:120a:: with SMTP id
 s10mr1619452ybu.197.1642016067996; Wed, 12 Jan 2022 11:34:27 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:31:46 -0800
In-Reply-To: <20220112193152.3058718-1-haoluo@google.com>
Message-Id: <20220112193152.3058718-3-haoluo@google.com>
Mime-Version: 1.0
References: <20220112193152.3058718-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 2/8] bpf: Record back pointer to the
 inode in bpffs
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When an object is pinned in bpffs, record the bpffs inode in the object.
The previous patch introduced bpf_watch_inode(), which can also be used
to watch the bpffs inode. This capability will be used in the following
patches to expose bpf objects to file systems where the nodes in the
file system are not backed by an inode.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h |  5 +++-
 kernel/bpf/inode.c  | 60 ++++++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/inode.h  |  9 +++++++
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6e947cd91152..2ec693c3d6f6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -184,7 +184,8 @@ struct bpf_map {
 	char name[BPF_OBJ_NAME_LEN];
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
-	/* 14 bytes hole */
+	struct inode *backing_inode; /* back pointer to the inode in bpffs */
+	/* 6 bytes hole */
 
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
@@ -991,6 +992,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	struct inode *backing_inode; /* back pointer to the inode in bpffs */
 };
 
 struct bpf_array_aux {
@@ -1018,6 +1020,7 @@ struct bpf_link {
 	const struct bpf_link_ops *ops;
 	struct bpf_prog *prog;
 	struct work_struct work;
+	struct inode *backing_inode; /* back pointer to the inode in bpffs */
 };
 
 struct bpf_link_ops {
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index b4066dd986a8..9ba10912cbf8 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -226,6 +226,57 @@ static int bpf_inode_type(const struct inode *inode, enum bpf_type *type)
 	return 0;
 }
 
+/* Conditionally set an object's backing inode. */
+static void cond_set_backing_inode(void *obj, enum bpf_type type,
+				   struct inode *old, struct inode *new)
+{
+	struct inode **ptr;
+
+	if (type == BPF_TYPE_PROG) {
+		struct bpf_prog *prog = obj;
+		ptr = &prog->aux->backing_inode;
+	} else if (type == BPF_TYPE_MAP) {
+		struct bpf_map *map = obj;
+		ptr = &map->backing_inode;
+	} else if (type == BPF_TYPE_LINK) {
+		struct bpf_link *link = obj;
+		ptr = &link->backing_inode;
+	} else {
+		return;
+	}
+
+	if (*ptr == old)
+		*ptr = new;
+}
+
+struct inode *get_backing_inode(void *obj, enum bpf_type type)
+{
+	struct inode *inode = NULL;
+
+	if (type == BPF_TYPE_PROG) {
+		struct bpf_prog *prog = obj;
+		inode = prog->aux->backing_inode;
+	} else if (type == BPF_TYPE_MAP) {
+		struct bpf_map *map = obj;
+		inode = map->backing_inode;
+	} else if (type == BPF_TYPE_LINK) {
+		struct bpf_link *link = obj;
+		inode = link->backing_inode;
+	}
+
+	if (!inode)
+		return NULL;
+
+	spin_lock(&inode->i_lock);
+	if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		spin_unlock(&inode->i_lock);
+		return NULL;
+	}
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
+	return inode;
+}
+
 static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 				struct inode *dir)
 {
@@ -418,6 +469,8 @@ static int bpf_mkobj_ops(struct dentry *dentry, umode_t mode, void *raw,
 {
 	struct inode *dir = dentry->d_parent->d_inode;
 	struct inode *inode = bpf_get_inode(dir->i_sb, dir, mode);
+	enum bpf_type type;
+
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -425,6 +478,9 @@ static int bpf_mkobj_ops(struct dentry *dentry, umode_t mode, void *raw,
 	inode->i_fop = fops;
 	inode->i_private = raw;
 
+	if (!bpf_inode_type(inode, &type))
+		cond_set_backing_inode(raw, type, NULL, inode);
+
 	bpf_dentry_finalize(dentry, inode, dir);
 	return 0;
 }
@@ -703,8 +759,10 @@ static void bpf_free_inode(struct inode *inode)
 
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
-	if (!bpf_inode_type(inode, &type))
+	if (!bpf_inode_type(inode, &type)) {
+		cond_set_backing_inode(inode->i_private, type, inode, NULL);
 		bpf_any_put(inode->i_private, type);
+	}
 	free_inode_nonrcu(inode);
 }
 
diff --git a/kernel/bpf/inode.h b/kernel/bpf/inode.h
index 3f53a4542028..e7fe8137be80 100644
--- a/kernel/bpf/inode.h
+++ b/kernel/bpf/inode.h
@@ -30,4 +30,13 @@ int bpf_watch_inode(struct inode *inode, const struct notify_ops *ops,
 }
 #endif  // CONFIG_FSNOTIFY
 
+/* Get the backing inode of a bpf object. When an object is pinned in bpf
+ * file system, an inode is associated with the object. This function returns
+ * that inode.
+ *
+ * On success, the inode is returned with refcnt incremented.
+ * On failure, NULL is returned.
+ */
+struct inode *get_backing_inode(void *obj, enum bpf_type);
+
 #endif  // __BPF_INODE_H_
-- 
2.34.1.448.ga2b2bfdf31-goog

