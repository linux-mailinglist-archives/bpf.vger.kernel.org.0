Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1142486CBC
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 22:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbiAFVvU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 16:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244511AbiAFVvT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 16:51:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAEBC061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 13:51:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n2-20020a255902000000b0060f9d75eafeso7687481ybb.1
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXsPIbfQ05P0repzOjAvu6+3E/heYEca8fbLMQGQFvE=;
        b=C1W8WQ3q+cmeGWXi6BFv9NecPmQIAGB176bAGZnRgwIGol82lcSMwFd2Kg8P8dATef
         AfmUHuuMk3WbMhiyUGUA4zx+NSk28vH6jo6mmTQ4ZQQ2CrqeY3jhbUsHeQF8CIiiDkOp
         QP9vjypboOOBAWwy7FCYf9jp1UUHazevP3JOU6TVUJBICQPRkuwWDq/Ym0ngAlUR36wi
         pbySI8V6t5qDmFZmdYEfFUzz54Nz74VlhuV4NwLv8g2wN7legWlcVzx9VrbOMpS0Csuh
         YUduTG2qwTo1/XHGzKVliwnhLaBRMo9TZlEI11uclsNQQ7/2CoPpXHaWzsdxru31EisU
         edPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXsPIbfQ05P0repzOjAvu6+3E/heYEca8fbLMQGQFvE=;
        b=kFPa8wMxIJecG6m7l4ZyrblGPiCj8ZxY6ZpRujerkh5ZEs6ad9k1VPAwbUvauBdmvE
         73ul5z4c8JxnzAg61EfQ+8AazGCFmCcwsOO8/sCyMUkq60rm4G84vt4RGyh9Tln955nP
         WzGEt4rVy4qowSGj5AS12ja3NRSYIT100ahcjIpSAOO7RHN37ROBKNN1i5zrgiI1VbfV
         5j5PRcMuq/JP+eP8ugA9kIHMZ28LMNyVNZrK7fYkvx1MhiWDd3GRCWvyt2pqTNcRBfg0
         +qYWhuISjwuBhEP4HIEfP5w8DndBnxKWIcNGGACK4l6WHDHEDlsVlR43C5TieDwqf45u
         V7Ww==
X-Gm-Message-State: AOAM533BLgs5lzwb+qee/yCrGi3cur9a9Xbabx7lO4bHVI7/DBYHGcFh
        S4/KEWJZ/8WZngAqvkMRbBaVMgDh4G0=
X-Google-Smtp-Source: ABdhPJxETQssjG1CpTafGjdgKn/nIgR1Kz7orjkpzH5foiYucXFWWqV5PDY7nDIiJ+8hrOzFe3mES8S+2UM=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:3a2:a76c:b77f:b671])
 (user=haoluo job=sendgmr) by 2002:a25:2315:: with SMTP id j21mr71106173ybj.672.1641505878976;
 Thu, 06 Jan 2022 13:51:18 -0800 (PST)
Date:   Thu,  6 Jan 2022 13:50:55 -0800
In-Reply-To: <20220106215059.2308931-1-haoluo@google.com>
Message-Id: <20220106215059.2308931-5-haoluo@google.com>
Mime-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH RFC bpf-next v1 4/8] bpf: Support removing kernfs entries
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a bpf object has been exposed in kernfs, there should be a way
to remove it. Kernfs doesn't implement unlink, therefore one can not
remove the entry in a normal way. To remove the file, we can allow
writing a special command to the new entry, which can trigger a
remove_self() for removal.

So far there are two ways to remove an entry that is created by pinning
bpf objects in kernfs:

 1. unpin the object from bpffs.
 2. write a special command to the kernfs entry.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/kernfs_node.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/kernfs_node.c b/kernel/bpf/kernfs_node.c
index c1c45f7b948b..3d331d8357db 100644
--- a/kernel/bpf/kernfs_node.c
+++ b/kernel/bpf/kernfs_node.c
@@ -9,6 +9,9 @@
 
 /* file_operations for kernfs file system */
 
+/* Command for removing a kernfs entry */
+#define REMOVE_CMD "rm"
+
 /* Handler when the watched inode is freed. */
 static void kn_watch_free_inode(void *obj, enum bpf_type type, void *kn)
 {
@@ -22,8 +25,27 @@ static const struct notify_ops notify_ops = {
 	.free_inode = kn_watch_free_inode,
 };
 
+static ssize_t bpf_generic_write(struct kernfs_open_file *of, char *buf,
+				 size_t bytes, loff_t off)
+{
+	if (sysfs_streq(buf, REMOVE_CMD)) {
+		kernfs_remove_self(of->kn);
+		return bytes;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t bpf_generic_read(struct kernfs_open_file *of, char *buf,
+				size_t bytes, loff_t off)
+{
+	return -EIO;
+}
+
 /* Kernfs file operations for bpf created files. */
 static const struct kernfs_ops bpf_generic_ops = {
+	.write          = bpf_generic_write,
+	.read           = bpf_generic_read,
 };
 
 /* Test whether a given dentry is a kernfs entry. */
-- 
2.34.1.448.ga2b2bfdf31-goog

