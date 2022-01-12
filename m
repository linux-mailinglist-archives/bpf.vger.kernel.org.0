Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B968248CBD2
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 20:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344280AbiALTZ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 14:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344398AbiALTZ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 14:25:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A45C061756
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:25:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s13-20020a252c0d000000b00611786a6925so6444372ybs.8
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WLIXWpZVKEATWJu5eTPegEpeW0twWlWVehQQ8+8FOxE=;
        b=IATn1j8XXNh5QnUCS84GAaGXz+wGJO5e1Sv0M/GDGavPxGQnUbuD3E9d46xu+SBdJt
         hLrvNtx2BAddqjacdEzxKiOkYqyCQWz2Y4JY4YBKylNriDljP0qiXBp8kWi2f5Zt7ZcX
         0+r8UDoY5AMVstj2BMzBYFrRXeJqzwHcb5W+85FZUJh7U36MQvl+FewJUUdpovMVA26h
         9rn9wkzFeiqkIWXQca+35HSWXqs3b4NXmtbs+3TSn2oUomsSQF/2PWBBb7MvDAJp6pKa
         ISHNbEFp0JA6XuzkMvPT4x9SH/yt1kQ+0OBWBbnKMXdKTUi736hh2+ap23pSr8VUxQsZ
         qqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WLIXWpZVKEATWJu5eTPegEpeW0twWlWVehQQ8+8FOxE=;
        b=ThzlCw4MkY/FrdSr3w4NNB5tPYWzSG368X9vG4K/iB6l4q3B/dyk2H396KZuIvIVqf
         1EbIIDfzyTJfl9Mrovvofts6SOgIquHJrMQnMe3UIpaqHFQsJOjP5CplGDxU049gMIV3
         iaJlrqtEYsMdHV8xFAhEucbQ78fxiSL46hRyvTG1fNQN6BBru1bmdRxrmZOJSBmpCW6T
         fN/mUe+SP5WHN/V/1JSvnOB1g3H/uNXr/fZCaEljncT2WlbH8DCQLjS0jdZB67eKO3Ss
         rhaSoME0q3jWeBvkXHUR8jrKiAj0YT61emtrkYWK+diigdP50g6N8YQGdyrW0YsF33e/
         yDvQ==
X-Gm-Message-State: AOAM531aJIU7crCOifTxDJt8b+/WEP26fADfpS4D+c9D2kDF+aQ2Z1ik
        FLkmqzEJw2dyBcG3hm+KwnC2LdT40a4=
X-Google-Smtp-Source: ABdhPJwMOcii6IXxp52+PEu8f3M6n+TRdKrFngmJTjckpFj8F483qBybtGPwQ7pD7cij3ywVHVjKm4YD6kY=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a5b:30e:: with SMTP id j14mr1720721ybp.60.1642015554999;
 Wed, 12 Jan 2022 11:25:54 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:25:41 -0800
In-Reply-To: <20220112192547.3054575-1-haoluo@google.com>
Message-Id: <20220112192547.3054575-3-haoluo@google.com>
Mime-Version: 1.0
References: <20220112192547.3054575-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 2/8] bpf: Record back pointer to the
 inode in bpffs
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, Joe@google.com,
        Burton@google.com, jevburton.kernel@gmail.com,
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

