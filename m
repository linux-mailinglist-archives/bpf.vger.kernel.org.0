Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30558CA18
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiHHOGr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiHHOGq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:06:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BB0E2E
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4138860D14
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF2FC433D6;
        Mon,  8 Aug 2022 14:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967604;
        bh=FLpzInOGRWtAqTPetYbmNbBNH4WOGXjovcX+AjI4KP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2gIJr0QwRsz99PP0a90eziYIOdK/YK35o+WWtJUXsNC48JKcFB10cDIJu8pA6LRg
         3JXDDQFnkrO06Ih7EvSzoB4dyExIz6n+DZxpaH1sKryA6HZLhC63bISyov9HDQ5I3+
         yGLHoEJvixegqbVlYTgfryiV4jlzuSNPHUvh8aC6b7HGEnoqZMSNJGvqZsByNjwWk7
         1GbQSViv8p9GULaVhsTLGb/4nrb/uRKIS6ypX+c7ickaoYqFExf/mE1Q89WHUKrOyX
         xr7oFw000ex1DUvB+hDSQxVjrE7rlKmULKYTEaDGLFD2uzKwb2alVtf66SAh+BTidu
         z708Hc05W8gtw==
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
Subject: [RFC PATCH bpf-next 01/17] bpf: Link shimlink directly in trampoline
Date:   Mon,  8 Aug 2022 16:06:10 +0200
Message-Id: <20220808140626.422731-2-jolsa@kernel.org>
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

We are going to get rid of struct bpf_tramp_link in following
changes and cgroup_shim_find logic does not fit to that.

We can store the link directly in the trampoline and omit the
cgroup_shim_find searching logic.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  3 +++
 kernel/bpf/trampoline.c | 23 +++--------------------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 20c26aed7896..ed2a921094bc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -841,6 +841,8 @@ struct bpf_tramp_image {
 	};
 };
 
+struct bpf_shim_tramp_link;
+
 struct bpf_trampoline {
 	/* hlist for trampoline_table */
 	struct hlist_node hlist;
@@ -868,6 +870,7 @@ struct bpf_trampoline {
 	struct bpf_tramp_image *cur_image;
 	u64 selector;
 	struct module *mod;
+	struct bpf_shim_tramp_link *shim_link;
 };
 
 struct bpf_attach_target_info {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ff87e38af8a7..7a65d33cda60 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -689,24 +689,6 @@ static struct bpf_shim_tramp_link *cgroup_shim_alloc(const struct bpf_prog *prog
 	return shim_link;
 }
 
-static struct bpf_shim_tramp_link *cgroup_shim_find(struct bpf_trampoline *tr,
-						    bpf_func_t bpf_func)
-{
-	struct bpf_tramp_link *link;
-	int kind;
-
-	for (kind = 0; kind < BPF_TRAMP_MAX; kind++) {
-		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
-			struct bpf_prog *p = link->link.prog;
-
-			if (p->bpf_func == bpf_func)
-				return container_of(link, struct bpf_shim_tramp_link, link);
-		}
-	}
-
-	return NULL;
-}
-
 int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 				    int cgroup_atype)
 {
@@ -733,7 +715,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 
 	mutex_lock(&tr->mutex);
 
-	shim_link = cgroup_shim_find(tr, bpf_func);
+	shim_link = tr->shim_link;
 	if (shim_link) {
 		/* Reusing existing shim attached by the other program. */
 		bpf_link_inc(&shim_link->link.link);
@@ -756,6 +738,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 		goto err;
 
 	shim_link->trampoline = tr;
+	tr->shim_link = shim_link;
 	/* note, we're still holding tr refcnt from above */
 
 	mutex_unlock(&tr->mutex);
@@ -789,7 +772,7 @@ void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
 		return;
 
 	mutex_lock(&tr->mutex);
-	shim_link = cgroup_shim_find(tr, bpf_func);
+	shim_link = tr->shim_link;
 	mutex_unlock(&tr->mutex);
 
 	if (shim_link)
-- 
2.37.1

