Return-Path: <bpf+bounces-11-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0386F75E5
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267D928108A
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720B79F6;
	Thu,  4 May 2023 19:47:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906F11C87
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 19:47:06 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B2111D;
	Thu,  4 May 2023 12:46:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 538EA637B8;
	Thu,  4 May 2023 19:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1372C433A0;
	Thu,  4 May 2023 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683229591;
	bh=VM2vo1YQKFMHenaXVsD91Ap0kaBngepTBIMWG0E+15A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOyJV7kdbwo1Z1YYzj2XITbLpSxjbiEo3vcTBf6xsSLiTqfwdktsHVrnlAECIcLeQ
	 YRUt4WBAIjqtZXK39+39/QqFsp5NQytM95xYDYiIyY8t9AFmiIRfkfpyvPdUozP91/
	 hMXtSB3DYuG/tnvKcL5CtT7f32vXLOTT0MruuZWoFzFYdNTF0xl3owgdhntqx5UVHX
	 AV+CQncdw1fz/gGqyOh1CPrniClBW6sNuJ9dl5Ytlny2xEDsKCrniX80gtG/OfII6H
	 j+/D0+5L74CIWX/FPk8WXKgSttTIznZqHZfLSt9rGfYVOAb6dwc2EZ7dM/g+CQgN/2
	 qC2YPRtdyAPfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/49] bpf: Annotate data races in bpf_local_storage
Date: Thu,  4 May 2023 15:45:39 -0400
Message-Id: <20230504194626.3807438-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit 0a09a2f933c73dc76ab0b72da6855f44342a8903 ]

There are a few cases where hlist_node is checked to be unhashed without
holding the lock protecting its modification. In this case, one must use
hlist_unhashed_lockless to avoid load tearing and KCSAN reports. Fix
this by using lockless variant in places not protected by the lock.

Since this is not prompted by any actual KCSAN reports but only from
code review, I have not included a fixes tag.

Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20230221200646.2500777-4-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index f27fa5ba7d722..d9d88a2cda5e5 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -51,11 +51,21 @@ owner_storage(struct bpf_local_storage_map *smap, void *owner)
 	return map->ops->map_owner_storage_ptr(owner);
 }
 
+static bool selem_linked_to_storage_lockless(const struct bpf_local_storage_elem *selem)
+{
+	return !hlist_unhashed_lockless(&selem->snode);
+}
+
 static bool selem_linked_to_storage(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->snode);
 }
 
+static bool selem_linked_to_map_lockless(const struct bpf_local_storage_elem *selem)
+{
+	return !hlist_unhashed_lockless(&selem->map_node);
+}
+
 static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->map_node);
@@ -165,7 +175,7 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	bool free_local_storage = false;
 	unsigned long flags;
 
-	if (unlikely(!selem_linked_to_storage(selem)))
+	if (unlikely(!selem_linked_to_storage_lockless(selem)))
 		/* selem has already been unlinked from sk */
 		return;
 
@@ -199,7 +209,7 @@ void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
 
-	if (unlikely(!selem_linked_to_map(selem)))
+	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
 		return;
 
@@ -410,7 +420,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		err = check_flags(old_sdata, map_flags);
 		if (err)
 			return ERR_PTR(err);
-		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
+		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
 			copy_map_value_locked(&smap->map, old_sdata->data,
 					      value, false);
 			return old_sdata;
-- 
2.39.2


