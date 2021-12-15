Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18F54752EE
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 07:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhLOGTd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 01:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhLOGTd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 01:19:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B3DC061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 22:19:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF203B81EA5
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 06:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A118C3460C;
        Wed, 15 Dec 2021 06:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639549170;
        bh=mLv9DZS2/wWGp/5zUTY6fgckzNlihTw0Waj7w81ShbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0ZTZgb2Is5rCj6BO1egA5e7TFmVI5BUb3wU/uoNs/MwG/JbfU0mEbVeesrocwJCS
         K3nSTiEtZMPd0R/LmFBkeXMuo278/GWiileywsTYvRkon4UVKtWF58LhVSczkt5uOd
         yVlW2F2f7vFHpyRhiqMRIMazPc5o/lmRw2T7rA//2vD3364lcWUpKZSqtglOPZi33l
         Y8O1pWjn67Q7/BL7XZk7YbHcZbuikW2eodEQTijYcSOA/o47U9tUZvkpJuVGct9DPl
         fgAPBmIoqNJF7P80zbXvFbAsFOLYlK1NDB0/UAnz2oDNWgSbJ85+xFvLtpFb8L9IOb
         org5JwikZkTfg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v3 3/3] bpf: remove the cgroup -> bpf header dependecy
Date:   Tue, 14 Dec 2021 22:19:16 -0800
Message-Id: <20211215061916.715513-4-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211215061916.715513-1-kuba@kernel.org>
References: <20211215061916.715513-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove the dependency from cgroup.h to bpf.h. This reduces
the incremental build size of x86 allmodconfig after bpf.h
was touched from ~17k objects rebuilt to ~5k objects.
bpf.h is 2.2kLoC and is modified relatively often.

cgroup_storage_type() needs to be moved to bpf.h because
it dereferences struct bpf_map.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/bpf-cgroup.h | 12 ++----------
 include/linux/bpf.h        |  9 +++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 11820a430d6c..d966b3dc7666 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -2,7 +2,7 @@
 #ifndef _BPF_CGROUP_H
 #define _BPF_CGROUP_H
 
-#include <linux/bpf.h>
+#include <linux/bpf-cgroup-types.h>
 #include <linux/errno.h>
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
@@ -16,6 +16,7 @@ struct cgroup;
 struct sk_buff;
 struct bpf_map;
 struct bpf_prog;
+struct bpf_prog_aux;
 struct bpf_sock_ops_kern;
 struct bpf_cgroup_storage;
 struct ctl_table;
@@ -194,15 +195,6 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 					    int optname, void *optval,
 					    int *optlen, int retval);
 
-static inline enum bpf_cgroup_storage_type cgroup_storage_type(
-	struct bpf_map *map)
-{
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
-		return BPF_CGROUP_STORAGE_PERCPU;
-
-	return BPF_CGROUP_STORAGE_SHARED;
-}
-
 struct bpf_cgroup_storage *
 cgroup_storage_lookup(struct bpf_cgroup_storage_map *map,
 		      void *key, bool locked);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1e16243623fe..8ea70c26acb5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -288,6 +288,15 @@ static inline bool bpf_map_support_seq_show(const struct bpf_map *map)
 		map->ops->map_seq_show_elem;
 }
 
+static inline enum bpf_cgroup_storage_type cgroup_storage_type(
+	struct bpf_map *map)
+{
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
+		return BPF_CGROUP_STORAGE_PERCPU;
+
+	return BPF_CGROUP_STORAGE_SHARED;
+}
+
 int map_check_no_btf(const struct bpf_map *map,
 		     const struct btf *btf,
 		     const struct btf_type *key_type,
-- 
2.31.1

