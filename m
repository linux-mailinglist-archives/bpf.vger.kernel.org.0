Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87A24A668D
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 21:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiBAUzw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 15:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiBAUzu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 15:55:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19A6C06174A
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 12:55:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c76-20020a25c04f000000b00613e2c514e2so34888595ybf.21
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 12:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TrRMtZ7rpWFBy3mN9jukrWT5/O4hvi4cjTw+7/27mDs=;
        b=BPfKMhRpkmr59DmiYl06B1vd1XGK2BTPFlXloc47Xbchd+K/D+0T1O0zu3r4KG8C+J
         MJ/jYs/i09fQ+Cew4BlHmC+o3+WajaBpAGlrdUGMA5vUBqPiFevv4KSVLTJus8MkWVqY
         RuD/0Z0NzzF4XEAwu4Ut3Vx4z9TYtxa1XmuQ8j4mB9KNcFx4NqmqTTyTVmFb6pO9Y4Mi
         mhXSXxERDH4vv8UFz50UA6wr4aeDcnSobbJty/OmrZ1sw4QlPzFtIhCzosR2M9DQ6YoG
         Pedp3zA2Hnkm5ncjXAJ9tHGc7IbOi8BvkurHiApQh8C2x4IpF3Hr4EeUYH9pjYaH5m/+
         nsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TrRMtZ7rpWFBy3mN9jukrWT5/O4hvi4cjTw+7/27mDs=;
        b=tpkDqWn8jlmbd9BVi0EthrG7DtQTOctl6bGpFx3v/wY1oU87CiIhy0AZ4CWvJpmnrf
         JIaSKlrJCY8MK85y2HOK+74ZLE1dxG8qG+FIC3YaE3BEFZrZ3RTLEqV/7ytVvDpOyczW
         3gPSDKhNIcmJUgMJVkF1vYbSl0OBX/st5201ohfLy9uLWBqOz3SAPpswfOdmEYYzFUJs
         5cp+RcYOsip1HFZ5p0tT7P3g+XNyrXjBgPdKD79qcRdBg4BZURVGf8E+TJJ+/+QLlApb
         DJw7s4wtsX3mBsZBYaJELsJLcNsRuzaSxMuieqYPOgQWhBo1NFswDc2KqYzWCJblFZky
         OukA==
X-Gm-Message-State: AOAM530kCloRiTeHJ/UhLABpDUJaJsgZNtsTnBzbMosMcGWhh7UsFPT2
        YMhgE3SjKTE/X2+oUcgAc4O+fg8b+7g=
X-Google-Smtp-Source: ABdhPJzyYTbnOcjPUT6K25yIzD0kbUD9e8z1MZA8T/wWw87xYomk8IAVurjv9l7i2v1Png4zCo10PSVDCeg=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:1cdb:a263:2495:80fd])
 (user=haoluo job=sendgmr) by 2002:a0d:d782:: with SMTP id z124mr93207ywd.28.1643748949022;
 Tue, 01 Feb 2022 12:55:49 -0800 (PST)
Date:   Tue,  1 Feb 2022 12:55:33 -0800
In-Reply-To: <20220201205534.1962784-1-haoluo@google.com>
Message-Id: <20220201205534.1962784-5-haoluo@google.com>
Mime-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH RFC bpf-next v2 4/5] bpf: Pin cgroup_view
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When pinning cgroup_view iter into bpffs, the pinning adds a tag to
the parent directory, indicating the underneath directory hierarchy
is a replicate of the cgroup hierarchy. Each of the directory connects
to a cgroup directory. Whenever a subdirectory is created, if there is
a subcgroup of the same name exists, the subdirectory will be populated
with entries holding a list of bpf objects registered in the tag's
inherit list. The inherit list is formed by the objects pinned in the
top level tagged directory. For example,

 bpf_obj_pin(cgroup_view_link, "/sys/fs/bpf/A/obj");

pins a link in A. A becomes tagged and the link object is registered
in the inherit list of A's tag.

 mkdir("/sys/fs/bpf/A/B");

When A/B is created, B inherits the pinned objects in A. B is populated
with objects.

 > ls /sys/fs/bpf/A/B
 obj

Currently, only pinning cgroup_view link can tag a directory. And once
tagged, only rmdir can remove the tag.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/inode.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9ae17a2bf779..b71840bf979d 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -71,6 +71,7 @@ static void free_obj_list(struct kref *kref)
 	list_for_each_entry(e, &list->list, list) {
 		list_del_rcu(&e->list);
 		bpf_any_put(e->obj, e->type);
+		kfree(e->name.name);
 		kfree(e);
 	}
 	kfree(list);
@@ -486,9 +487,20 @@ static int bpf_mkmap(struct dentry *dentry, umode_t mode, void *arg)
 			     &bpffs_map_fops : &bpffs_obj_fops);
 }
 
+static int
+bpf_inherit_object(struct dentry *dentry, umode_t mode, void *obj,
+		   enum bpf_type type);
+
 static int bpf_mklink(struct dentry *dentry, umode_t mode, void *arg)
 {
 	struct bpf_link *link = arg;
+	int err;
+
+	if (bpf_link_support_inherit(link)) {
+		err = bpf_inherit_object(dentry, mode, link, BPF_TYPE_LINK);
+		if (err)
+			return err;
+	}
 
 	return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops,
 			     bpf_link_is_iter(link) ?
@@ -586,6 +598,78 @@ static const struct inode_operations bpf_dir_iops = {
 	.unlink		= simple_unlink,
 };
 
+/* bpf_inherit_object - register an object in a diretory tag's inherit list
+ * @dentry: dentry of the location to pin
+ * @mode: mode of created file entry
+ * @obj: bpf object
+ * @type: type of bpf object
+ *
+ * Could be called from bpf_obj_do_pin() or from mkdir().
+ */
+static int bpf_inherit_object(struct dentry *dentry, umode_t mode,
+			      void *obj, enum bpf_type type)
+{
+	struct inode *dir = d_inode(dentry->d_parent);
+	struct obj_list *inherits;
+	struct bpf_inherit_entry *e;
+	struct bpf_dir_tag *tag;
+	const char *name;
+	bool queued = false, new_tag = false;
+
+	/* allocate bpf_dir_tag */
+	tag = inode_tag(dir);
+	if (!tag) {
+		new_tag = true;
+		tag = kzalloc(sizeof(struct bpf_dir_tag), GFP_KERNEL);
+		if (unlikely(!tag))
+			return -ENOMEM;
+
+		tag->type = BPF_DIR_KERNFS_REP;
+		inherits = kzalloc(sizeof(struct obj_list), GFP_KERNEL);
+		if (unlikely(!inherits)) {
+			kfree(tag);
+			return -ENOMEM;
+		}
+
+		kref_init(&inherits->refcnt);
+		INIT_LIST_HEAD(&inherits->list);
+		tag->inherit_objects = inherits;
+		/* initial tag points to the default root cgroup. */
+		tag->private = cgrp_dfl_root.kf_root->kn;
+		dir->i_private = tag;
+	} else {
+		inherits = tag->inherit_objects;
+	}
+
+	list_for_each_entry_rcu(e, &inherits->list, list) {
+		if (!strcmp(dentry->d_name.name, e->name.name)) {
+			queued = true;
+			break;
+		}
+	}
+
+	/* queue in tag's inherit_list. */
+	if (!queued) {
+		e = kzalloc(sizeof(struct bpf_inherit_entry), GFP_KERNEL);
+		if (!e) {
+			if (new_tag) {
+				kfree(tag);
+				kfree(inherits);
+			}
+			return -ENOMEM;
+		}
+
+		INIT_LIST_HEAD(&e->list);
+		e->mode = mode;
+		e->obj = obj;
+		e->type = type;
+		name = kstrdup(dentry->d_name.name, GFP_USER | __GFP_NOWARN);
+		e->name = (struct qstr)QSTR_INIT(name, strlen(name));
+		list_add_rcu(&e->list, &inherits->list);
+	}
+	return 0;
+}
+
 /* pin iterator link into bpffs */
 static int bpf_iter_link_pin_kernel(struct dentry *parent,
 				    const char *name, struct bpf_link *link)
-- 
2.35.0.rc2.247.g8bbb082509-goog

