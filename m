Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD345FA059
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 16:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJJOnl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 10:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJJOnk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 10:43:40 -0400
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Oct 2022 07:43:37 PDT
Received: from mail-200165.simplelogin.co (mail-200165.simplelogin.co [176.119.200.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991026B8E9
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=dkim;
        t=1665412708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X6F4ocx+qrtRke2RwY23Bo84cVUEo/S+1zJTOfDrqP8=;
        b=xYF8d8BVp2Co+mTSQjMyqZjdMHCY5GIXEy1NgKayTrdoNOiAcwjPY3KFjGJkGobNS/PMiC
        UtFVDyf7zOYifaGJcoTmHuAFDby5u/j1hbXw/eFtzwS8RttlA8HVTQ5Yexm88FBwHCWKFF
        PMzdhkn/dVnKGaBJ9NMeROXsR3puYxI=
Subject: [PATCH] bpf: fix checkpatch POINTER_LOCATION, SPACING,
 ASSIGN_IN_IF error
Date:   Mon, 10 Oct 2022 22:37:32 +0800
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From:   Rui Li <me@lirui.org>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <166541270808.7.8609812300412049909.67986182@lirui.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 67986182
X-SimpleLogin-Want-Signing: yes
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit cleans up checkpatch errors as follows:
ERROR:POINTER_LOCATION: "foo* bar" should be "foo *bar"
ERROR:ASSIGN_IN_IF: do not use assignment in if condition
ERROR:SPACING: space required after that ',' (ctx:VxV)

There still are some false positive errors like spaces required.

Signed-off-by: Rui Li <me@lirui.org>
---
 kernel/bpf/arraymap.c | 10 ++++++----
 kernel/bpf/btf.c      |  2 +-
 kernel/bpf/core.c     |  8 +++++---
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 832b2659e96e..271af4b934d4 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -154,7 +154,7 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	return &array->map;
 }
 
-static void *array_map_elem_ptr(struct bpf_array* array, u32 index)
+static void *array_map_elem_ptr(struct bpf_array *array, u32 index)
 {
 	return array->value + (u64)array->elem_size * index;
 }
@@ -814,9 +814,11 @@ int bpf_fd_array_map_lookup_elem(struct bpf_map *map, void *key, u32 *value)
 
 	rcu_read_lock();
 	elem = array_map_lookup_elem(map, key);
-	if (elem && (ptr = READ_ONCE(*elem)))
-		*value = map->ops->map_fd_sys_lookup_elem(ptr);
-	else
+	if (elem) {
+		ptr = READ_ONCE(*elem);
+		if (ptr)
+			*value = map->ops->map_fd_sys_lookup_elem(ptr);
+	} else
 		ret = -ENOENT;
 	rcu_read_unlock();
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eba603cec2c5..a31e31951d60 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5482,7 +5482,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
 		if (ctx_arg_info->offset == off) {
 			if (!ctx_arg_info->btf_id) {
-				bpf_log(log,"invalid btf_id for context argument offset %u\n", off);
+				bpf_log(log, "invalid btf_id for context argument offset %u\n", off);
 				return false;
 			}
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 711fd293b6de..3a63787598c5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -467,9 +467,11 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 	 * We need to probe here before we do any reallocation where
 	 * we afterwards may not fail anymore.
 	 */
-	if (insn_adj_cnt > cnt_max &&
-	    (err = bpf_adj_branches(prog, off, off + 1, off + len, true)))
-		return ERR_PTR(err);
+	if (insn_adj_cnt > cnt_max) {
+		err = bpf_adj_branches(prog, off, off + 1, off + len, true);
+		if (err)
+			return ERR_PTR(err);
+	}
 
 	/* Several new instructions need to be inserted. Make room
 	 * for them. Likely, there's no need for a new allocation as
-- 
2.30.2


