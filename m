Return-Path: <bpf+bounces-73038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D70CC20EAD
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D3734EBF3F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17310363BBE;
	Thu, 30 Oct 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JBT6OLyq"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30C363B9C
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837954; cv=none; b=nssY8NEjZu4fbYyizdqFgkKx9+UIIDYRHwj5lqQkDssUqfcQLADkqD5luMOHx5ixz48YQSYou3TXmwwS+KmUnNBif+nWAhH7ljAbpuwJGKxmSKF5JB3QZw3DP3B+pVInoBwcqKkEMmpq7d8a7xejG08PY80EtFe7nu8YHvzNQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837954; c=relaxed/simple;
	bh=H67r4w88zlU1921c5/QKXr/Bl4R9EUxsrk8OaJ2KI6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2IRJG80NnQBftIXS7z4rYZLpalif6ykiJYnSlJBjYli8TGpsRuk0VI5IenFnOiHTAO5ROGnXNMpFWXqyEw6c1riKFuOcCXCXp/1v01ZBBuoZP5bRIDgs0XbVh3VtavbNfXosUqCk7GC1GjTIV4s5oWxHnNE7707dcg518epv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JBT6OLyq; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761837950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U7kvFPkRp/dS2L9NbQ/G23ovFdfU8KUNzcqgDlTrqmc=;
	b=JBT6OLyqL/vjHQhB6jtxJDzNTE1FP1PeS5UnxvFwIl7EaUSmVKzh9h09dHQL0NCPRSEQ8+
	8lEqZu9afpy6z4KXEi6UorfSsTNWtr4rENMf0yMHu5CIecHIECXppb0xPvg3tF3GU9OJhz
	gTB1PyBGAgxbBKtDbz96eXkOorJRoWM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v4 3/4] bpf: Free special fields when update local storage maps with BPF_F_LOCK
Date: Thu, 30 Oct 2025 23:24:50 +0800
Message-ID: <20251030152451.62778-4-leon.hwang@linux.dev>
In-Reply-To: <20251030152451.62778-1-leon.hwang@linux.dev>
References: <20251030152451.62778-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When updating local storage maps with BPF_F_LOCK on the fast path, the
special fields were not freed after being replaced. This could cause
memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
map gets freed.

Similarly, on the other path, the old sdata's special fields were never
freed when BPF_F_LOCK was specified, causing the same issue.

Fix this by calling 'bpf_obj_free_fields()' after
'copy_map_value_locked()' to properly release the old fields.

Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/bpf_local_storage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b931fbceb54da..9f447530f9564 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -609,6 +609,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
 			copy_map_value_locked(&smap->map, old_sdata->data,
 					      value, false);
+			bpf_obj_free_fields(smap->map.record, old_sdata->data);
 			return old_sdata;
 		}
 	}
@@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (old_sdata && (map_flags & BPF_F_LOCK)) {
 		copy_map_value_locked(&smap->map, old_sdata->data, value,
 				      false);
+		bpf_obj_free_fields(smap->map.record, old_sdata->data);
 		selem = SELEM(old_sdata);
 		goto unlock;
 	}
-- 
2.51.1


