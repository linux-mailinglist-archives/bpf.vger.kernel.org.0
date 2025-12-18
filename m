Return-Path: <bpf+bounces-77011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F5ACCD0BF
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA42E3023D5B
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07009306487;
	Thu, 18 Dec 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtoGMOG1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FBB1A073F
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080597; cv=none; b=i/rQpngzOqKuB5H2VY7qNBDFRxjfHXJJyQ2Dqmi1Ix8HgFPCFq1sZwmz5U6KdX4x12bKwzW8Nj2u2NiLYaErJPCLISexQsGTvAV3MkotDdgkrqb5e3sV2RVZSoG3y54xGPzQmbX1buvHpl6SUahgP2dPL93ce5i91pxthh/OS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080597; c=relaxed/simple;
	bh=tmiLK/QXvuHxbV6KyoQ/lch7ZxtexpAcoErhdNty0s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRDxwnEWR3SF/Fh1Bn2t/1xaQingcuUrWw1nwnHxVw388cQzSxyEPziQT55566SXvqfuOC0SK0TKe9QAiW2U0msQbF2vvWiekzj7srEyHtOA+oOPs2jkC1L8XpKknqwP/5k2JKcGizuhfn0pvl1k03OCjD8vd2JP2eQJ+n0OKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtoGMOG1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29f30233d8aso12481785ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080594; x=1766685394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaMnPHjGoxUf/2OLjbS8/CLxdLVEofMKtwjQQ+W9WNk=;
        b=MtoGMOG1GX5bZXVW/TKgGc29+xNUxN2pZ0qlL4etCkTYiNJTN4P5J6CTQEdbYeptyQ
         tjEY1KCxtiSckMBynA3ghDJPYzBeifT+1xuaFT6r7tnrE3sMVnFIg36LTsnSX+rpOPwG
         9wCqILIx/WvIZNVaZ9qp0EMalP9mIIX8TL4ZV78R1jIntdh5puut8EpZFmstnheYwqOq
         d45PKqG0uPmNF6cocJhObEbcpRc0in4untT4q5kH2urcH65jhKKBhQ7YECLj4VIPpzNR
         Avg1nqjtjrNNlV6F47kYTZ7L2VAGpsAeI+z+0wTUlIW+v+46dBoRWvAZYApD9LVvi8Iq
         MjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080594; x=1766685394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CaMnPHjGoxUf/2OLjbS8/CLxdLVEofMKtwjQQ+W9WNk=;
        b=YPFaxu0ta7Mgkoas5Rnl5uBI4MheJLrQI6B9C/ApahbVMLymBV2xtZL9Y0oSSGIZVL
         QDyzLlt3diUKtRKP3Zo8sg6niEajxeAb5lzTkkONcRckFEVeGPK7osJZcywm0FdsoTA8
         dOmhHtfAlaIShW4sgGOaK5L+e7cHLqyJ0Lk/O8Y6uzRH4X03X4YqXeCzxcFqmlkFxpkM
         npVpy3l56hgkNBbDFhFTuLG9KNh/ARwva/yB9oaQVMz4nUwxAL63rBwjiV3aCIhlpdv1
         y5synjz02Psy2CPTH27tK0d3UcvyCtnoApSrNYJabpUPF1cx51SDY0n399n1PpdK3OXd
         k2bA==
X-Gm-Message-State: AOJu0Yypib+dOGdUCb/tVeRqA8kmr1SnbblNfRyTmlvRxGJ5tZ2GFOOn
	QlzJAl48uP7U18oqZT8+DqGNwJq2nqWo6ieHTKL57owRRzCcd2Y+NCZxda3Fsw==
X-Gm-Gg: AY/fxX5SeuCrtOJpGet8VD0zZx3ApBttGu6k0v7HFKNIz54qyZkoyhwtGTUtzrxUWDP
	xQHXo1X0ZkCW6m2xew0eVRPONfx+N61lM7dlkCytxxnjO8z1Lsovrp68OTe3Ixril4yW+cewZdv
	ePpBo4PmEdsvs+2aejth9GiadXXcWC0asgZt+89h+cyWGfuGo/pQaJG/MOjFjTyIKpw0S4oGd4d
	wbWXAu9TeZ53Jyrlyue1vQ0NAh5J0YeYNiGX8D2teT4SDkQacLJT/UVbqPjsCScKXspXbQQQAAK
	+jF8X3N8dqpHkb03sKFcpmnK9KlxilAZOxwqmhPejohTbZHy2gD+KpogajgJDXbn7yz3s8uj4Da
	vmSc5CXY0AtxvbvrbFyfNjorkYQBG7vvaNKv2pp8ldUgGqNCdOijAI2heLmHr/863d9AbHQXxRH
	meddD9+si0ZwprHcecBG+xg2x7
X-Google-Smtp-Source: AGHT+IGhT9jGyvWNCmxkKzIMdbd16hynnIfy/SolyN1zjlrmg5q4BBbSXCO7JSiNoWrfE7BYsMsHsg==
X-Received: by 2002:a17:902:daca:b0:295:5dbe:f629 with SMTP id d9443c01a7336-2a2f21fc4c9mr1162685ad.8.1766080594121;
        Thu, 18 Dec 2025 09:56:34 -0800 (PST)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926cb0sm32083015ad.69.2025.12.18.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:33 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 03/16] bpf: Open code bpf_selem_unlink_storage in bpf_selem_unlink
Date: Thu, 18 Dec 2025 09:56:13 -0800
Message-ID: <20251218175628.1460321-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for changing bpf_local_storage::lock to rqspinlock, open code
bpf_selem_unlink_storage() in the only caller, bpf_selem_unlink(), since
unlink_map and unlink_storage must be done together after all the
necessary locks are acquired.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 63 ++++++++++++++++------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 94a20c147bc7..0e3fa5fbaaf3 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -313,33 +313,6 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	return free_local_storage;
 }
 
-static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
-				     bool reuse_now)
-{
-	struct bpf_local_storage *local_storage;
-	bool free_local_storage = false;
-	HLIST_HEAD(selem_free_list);
-	unsigned long flags;
-
-	if (unlikely(!selem_linked_to_storage_lockless(selem)))
-		/* selem has already been unlinked from sk */
-		return;
-
-	local_storage = rcu_dereference_check(selem->local_storage,
-					      bpf_rcu_lock_held());
-
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
-	if (likely(selem_linked_to_storage(selem)))
-		free_local_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, &selem_free_list);
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
-
-	bpf_selem_free_list(&selem_free_list, reuse_now);
-
-	if (free_local_storage)
-		bpf_local_storage_free(local_storage, reuse_now);
-}
-
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem)
 {
@@ -396,17 +369,39 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
 
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
+	struct bpf_local_storage *local_storage;
+	bool free_local_storage = false;
+	HLIST_HEAD(selem_free_list);
+	unsigned long flags;
 	int err;
 
-	/* Always unlink from map before unlinking from local_storage
-	 * because selem will be freed after successfully unlinked from
-	 * the local_storage.
-	 */
-	err = bpf_selem_unlink_map(selem);
-	if (err)
+	if (unlikely(!selem_linked_to_storage_lockless(selem)))
+		/* selem has already been unlinked from sk */
 		return;
 
-	bpf_selem_unlink_storage(selem, reuse_now);
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
+
+	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	if (likely(selem_linked_to_storage(selem))) {
+		/* Always unlink from map before unlinking from local_storage
+		 * because selem will be freed after successfully unlinked from
+		 * the local_storage.
+		 */
+		err = bpf_selem_unlink_map(selem);
+		if (err)
+			goto out;
+
+		free_local_storage = bpf_selem_unlink_storage_nolock(
+			local_storage, selem, &selem_free_list);
+	}
+out:
+	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+
+	bpf_selem_free_list(&selem_free_list, reuse_now);
+
+	if (free_local_storage)
+		bpf_local_storage_free(local_storage, reuse_now);
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
-- 
2.47.3


