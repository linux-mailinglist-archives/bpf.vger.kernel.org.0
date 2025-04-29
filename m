Return-Path: <bpf+bounces-56995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4DFAA3D7E
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7E916F1A4
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 23:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA132882CB;
	Tue, 29 Apr 2025 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf8LUMPZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6C2882B5;
	Tue, 29 Apr 2025 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970680; cv=none; b=bkatAGdLHlX/r/4EA8bE/RCssos2BXtKW5zIuZxj2yp50yd/qQCGUhaXeY28gT4gA1Qzk9GZOrgRBYrQYG3puBn0BevKeIz411w0dM3dcQ7AEIaaUzXd59M2/a0oZ0iR4lhDHqpu6Pbef8+GZeq2pN+XTPe+laShtO/ojhpTCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970680; c=relaxed/simple;
	bh=wrrML4pxE+9AHB6OWNTxSwPIC9LEhzO2dbS1B4lfjlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eXfAbRQnQFq1rSPSwEx8+0Zz88hF8yCVouZ79F8ROxFYQTg5UU4u3OhRUi01z/WuiJ3lzoA7MSVqDS0/dmBLVTRT+JhG+IoMsOH3CIpxp+tF1Nbiy0zmAEo/BJFHVgm4Z/XVHdR7UijyOx9+E8hLeBuj5MvfxAZsJfKg/iudWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf8LUMPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECBFC4CEE3;
	Tue, 29 Apr 2025 23:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970680;
	bh=wrrML4pxE+9AHB6OWNTxSwPIC9LEhzO2dbS1B4lfjlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nf8LUMPZeyXNzBauIlofdP5tqFruYcyYQTb8QkbaL9a2W3W+unRISq7uci5BJwfaw
	 hbH4v5nmyF2Xpgu5oFoA5LABUyT/IB9EupgshUo1fgI+syawzy4UfgJMPP/2rkuc5/
	 YQKkIzuBq7tEtY7p67NSXJUMxegcSB6CwIzrAmqBavbOm13DkaPCwDJujQTaRvGLXv
	 2UVzwAhq1tSBdWJveVQ/+02o9xQ6lARoAawH7cCIGbrtQcJwszo+vdZMLGvLKP/ry1
	 rbGdzIps77e1T18CpfCXAR1i5ccqNfGVKW252aO0wVQRy5Xy6U16JGbJGeW3v0U+HX
	 ThB29fAnunBxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brandon Kammerdiener <brandon.kammerdiener@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 38/39] bpf: fix possible endless loop in BPF map iteration
Date: Tue, 29 Apr 2025 19:50:05 -0400
Message-Id: <20250429235006.536648-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>

[ Upstream commit 75673fda0c557ae26078177dd14d4857afbf128d ]

The _safe variant used here gets the next element before running the callback,
avoiding the endless loop condition.

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Link: https://lore.kernel.org/r/20250424153246.141677-2-brandon.kammerdiener@intel.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4a9eeb7aef855..43574b0495c30 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2224,7 +2224,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 		b = &htab->buckets[i];
 		rcu_read_lock();
 		head = &b->head;
-		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+		hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
 			key = elem->key;
 			if (is_percpu) {
 				/* current cpu value for percpu map */
-- 
2.39.5


