Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713FD48CBD8
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 20:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbiALT0h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 14:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344398AbiALT0A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 14:26:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165C9C061751
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:26:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q185-20020a25d9c2000000b00611ae9c8773so2545191ybg.18
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXsPIbfQ05P0repzOjAvu6+3E/heYEca8fbLMQGQFvE=;
        b=OVkw/OOQFATmzm1SJea+QKvbMcvbrUZuyRpLKQiqbaK5v2Tnvmu+BZ0ots7zJCdUHU
         z8ccxQc7x69F99FJgAIRsTcsBG1ISQK7GavxRUeCpdJp7zfJW1nCzASnhVjx4Ng0xmIe
         C44vlOxJa6I+pJxIfsk1hiZt+lu6sBOAUI3WPPBvbN6UiS7GG3CdDzAQ0O1c8uvnAXai
         O6Hd4heEx0/z5vJzDL1M5KdGMZttUn5ReRHQMQmSA+7ykquom4vhDJv0DStOsLAorR2N
         csWjLeU6++lgIkjcyWgPfzztPqg29O6fOEN4A+Bxq1bMisAZj/obE5R8IY0i+SKCxSbH
         WzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXsPIbfQ05P0repzOjAvu6+3E/heYEca8fbLMQGQFvE=;
        b=zDW6iCLRRu1xS4o2atHwxd59CJN2PeP1gn740lKBzl7mP/71U6ugwvQw9cZi2DNKv+
         i3dBKCE1RRz5lgJRmPrIRosUfEm2P6veXtgLr7RiFsHqcBVNJ5zMWZmxV0JctPPjgiKM
         FsL2V1Huf/pMmhAY/LQ7U0ZiHKXVyUHeq7LPe8GrgDhisyDmbLSlXN0aaN245VS7w2gZ
         v+SrsfBdqkumNZdJsQV1ORTUlx8kLE/Ok9GxJxP9gVQ9QZmp9Rn6zmU5GcKiAy+B6E+A
         +NwA5mqphHMYqXH9HfmI9ptAVeMk9J3zpNFeXuYNQciSJsKmUhg6IErzKQAOI2cREI+x
         GqTA==
X-Gm-Message-State: AOAM533guwWOBcyXij4uziPBMBGfLY+dOehn8rWsQeNhvt3Zrv8rZfey
        7VgV+SvUYUnmkbMGFwRZadWMA9fgiII=
X-Google-Smtp-Source: ABdhPJxYm5u9VpP7OA8U6j16gepHc9xNcbC+H/aOGc5oUb0spGUr2hCdgYEzAcb2fZU4jMdkNLKi5RoNLG4=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a25:ac24:: with SMTP id w36mr656053ybi.610.1642015559343;
 Wed, 12 Jan 2022 11:25:59 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:25:43 -0800
In-Reply-To: <20220112192547.3054575-1-haoluo@google.com>
Message-Id: <20220112192547.3054575-5-haoluo@google.com>
Mime-Version: 1.0
References: <20220112192547.3054575-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 4/8] bpf: Support removing kernfs entries
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

