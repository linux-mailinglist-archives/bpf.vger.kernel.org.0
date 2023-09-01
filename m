Return-Path: <bpf+bounces-9128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76FE7903ED
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 01:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DDD281984
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 23:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B8315ACF;
	Fri,  1 Sep 2023 23:12:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296415ACA
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 23:12:02 +0000 (UTC)
Received: from out-231.mta0.migadu.com (out-231.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9492EE72
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 16:12:00 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693609919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVAUrPNrJ1PfV+gw+0JjTz2CETbP/jS8ZqN08/q7eAw=;
	b=UDo5/fjz5/3zSUQCYN9AFOdbRcSPwJq5QelExpb44XWxXG820Yhuk/9/zWE10tSacMUJKY
	r3mREzrGKkQnqiPVV3qyjvp54j5IhPRRawT4C92SSH+itQU2CeRZ0o72jE3O/mZZEZ5K14
	WImZu+wQoUVkbnUWloMhxnmp83FbkX8=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 2/3] bpf: bpf_sk_storage: Fix the missing uncharge in sk_omem_alloc
Date: Fri,  1 Sep 2023 16:11:28 -0700
Message-Id: <20230901231129.578493-3-martin.lau@linux.dev>
In-Reply-To: <20230901231129.578493-1-martin.lau@linux.dev>
References: <20230901231129.578493-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Martin KaFai Lau <martin.lau@kernel.org>

The commit c83597fa5dc6 ("bpf: Refactor some inode/task/sk storage functions for reuse"),
refactored the bpf_{sk,task,inode}_storage_free() into
bpf_local_storage_unlink_nolock() which then later renamed
to bpf_local_storage_destroy(). The commit accidentally passed the
"bool uncharge_mem = false" argument to bpf_selem_unlink_storage_nolock()
which then stopped the uncharge from happening to the sk->sk_omem_alloc.

This missing uncharge only happens when the sk is going away (during
__sk_destruct).

This patch fixes it by always passing "uncharge_mem = true". It is a
noop to the task/inode/cgroup storage because they do not have the
map_local_storage_(un)charge enabled in the map_ops. A followup patch will
be done in bpf-next to remove the uncharge_mem argument.

A selftest is added in the next patch.

Fixes: c83597fa5dc6 ("bpf: Refactor some inode/task/sk storage functions for reuse")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 37ad47d52dc5..146824cc9689 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -760,7 +760,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		 * of the loop will set the free_cgroup_storage to true.
 		 */
 		free_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, false, true);
+			local_storage, selem, true, true);
 	}
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-- 
2.34.1


