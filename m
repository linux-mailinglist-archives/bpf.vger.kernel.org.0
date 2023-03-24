Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3EC6C8544
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 19:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCXSmy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 14:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCXSmy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 14:42:54 -0400
Received: from out-36.mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D2361B1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 11:42:50 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679683369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hjrseU8NuUpA32L4VqlpXYtbPnyTpdDLYPpvQEpNqEg=;
        b=EGmrf06ltEN+zAwUSUnkw6uF8NC8MnqT8t3z/4seCNNoiri45UjZbQEoBFTs49GV+lplDx
        d1Xy7Rv1dpISDbv0DmeirO1sy57m9WrtN0IP+PBT4EZhcmseQ6IeIjBsPdMblniChIZJvn
        Ia7/4rvyLsmyqxHxAUY7zz7kFtWymnE=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        syzbot+71ccc0fe37abb458406b@syzkaller.appspotmail.com
Subject: [PATCH bpf-next] bpf: Check IS_ERR for the bpf_map_get() return value
Date:   Fri, 24 Mar 2023 11:42:41 -0700
Message-Id: <20230324184241.1387437-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch fixes a mistake in checking NULL instead of
checking IS_ERR for the bpf_map_get() return value.

It also fixes the return value in link_update_map() from -EINVAL
to PTR_ERR(*_map).

Reported-by: syzbot+71ccc0fe37abb458406b@syzkaller.appspotmail.com
Fixes: 68b04864ca42 ("bpf: Create links for BPF struct_ops maps.")
Fixes: aef56f2e918b ("bpf: Update the struct_ops of a bpf_link.")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_struct_ops.c | 4 ++--
 kernel/bpf/syscall.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 6401deca3b56..d3f0a4825fa6 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -871,8 +871,8 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	int err;
 
 	map = bpf_map_get(attr->link_create.map_fd);
-	if (!map)
-		return -EINVAL;
+	if (IS_ERR(map))
+		return PTR_ERR(map);
 
 	st_map = (struct bpf_struct_ops_map *)map;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b4d758fa5981..a09597c95029 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4689,12 +4689,12 @@ static int link_update_map(struct bpf_link *link, union bpf_attr *attr)
 
 	new_map = bpf_map_get(attr->link_update.new_map_fd);
 	if (IS_ERR(new_map))
-		return -EINVAL;
+		return PTR_ERR(new_map);
 
 	if (attr->link_update.flags & BPF_F_REPLACE) {
 		old_map = bpf_map_get(attr->link_update.old_map_fd);
 		if (IS_ERR(old_map)) {
-			ret = -EINVAL;
+			ret = PTR_ERR(old_map);
 			goto out_put;
 		}
 	} else if (attr->link_update.old_map_fd) {
-- 
2.34.1

