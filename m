Return-Path: <bpf+bounces-40983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D272A990BE6
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2D91F220A9
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7883C1DACB4;
	Fri,  4 Oct 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEfR9cOd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB01EF0BC;
	Fri,  4 Oct 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066124; cv=none; b=jKtKF4kJySsSoSGb8RywtasXYqSyOvuS3KlBt41porjrDrE/kG1cKSg7LeGspywZiqsQnJL8PZfPeAx/R88Olkw9IJYFoIScYbwZC9Oplvcb/1PtZ4xGjOmLMnBK9kSlrsuopZtmJjz8+OKvMeC+vipN00ru9crz7bIc8kANBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066124; c=relaxed/simple;
	bh=5Bh4TTwH0WivaKR5pVnaai1z9H1dk+fO8e5BQ2qk7a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTbQPA4DNuTUNxVytUgmLSAwzzWwzj/ZdUH0D+m8SwRaxreoFjZMO8JbCCrFKidxAWjWmk7x06UXvJD/qVS7zMjn5GrsPumXY3Yt8bOpCjDa0cmyPO0l0q68lXWlqFLD4BrZ2ObR5u6FqOaN9tbXc4v+2r/CSFoi6S6+lngCmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEfR9cOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C817C4CEC6;
	Fri,  4 Oct 2024 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066123;
	bh=5Bh4TTwH0WivaKR5pVnaai1z9H1dk+fO8e5BQ2qk7a8=;
	h=From:To:Cc:Subject:Date:From;
	b=AEfR9cOdpyP75C5vL7lvU4J5cebM/TkORD402r2P4f/PrVzCLmtJIyFHC/gFjnao/
	 zpqKbEyKVqCknktzgidu6yGv21E9sqeR/0IMqgyD8JEfhQQJEn4IaJkQ+LenlEYBq+
	 8Y282M6E02UekwTSD3LL5fTa54poqVd7Y1HmVveKDBSPGJoAhC0mFYbNxmfR9NWJko
	 YaRcBXgRS/xGe1y3+MrRhn9QPifGBtXdMn0Lbz4S4W9bWoJg2mfgxvt8aPZVjBF1Et
	 ngYAOsAkXoqZp1UD88Vu3OWLk+qnoOXmvAwb21B3IrR1ijkX3TsPconotayt7eAR6h
	 pZg8KklQEoUUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 01/70] bpf: Call the missed btf_record_free() when map creation fails
Date: Fri,  4 Oct 2024 14:19:59 -0400
Message-ID: <20241004182200.3670903-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 87e9675a0dfd0bf4a36550e4a0e673038ec67aee ]

When security_bpf_map_create() in map_create() fails, map_create() will
call btf_put() and ->map_free() callback to free the map. It doesn't
free the btf_record of map value, so add the missed btf_record_free()
when map creation fails.

However btf_record_free() needs to be called after ->map_free() just
like bpf_map_free_deferred() did, because ->map_free() may use the
btf_record to free the special fields in preallocated map value. So
factor out bpf_map_free() helper to free the map, btf_record, and btf
orderly and use the helper in both map_create() and
bpf_map_free_deferred().

Signed-off-by: Hou Tao <houtao1@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20240912012845.3458483-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f45ed6adc092a..92590ddb2042d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -733,15 +733,11 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 	}
 }
 
-/* called from workqueue */
-static void bpf_map_free_deferred(struct work_struct *work)
+static void bpf_map_free(struct bpf_map *map)
 {
-	struct bpf_map *map = container_of(work, struct bpf_map, work);
 	struct btf_record *rec = map->record;
 	struct btf *btf = map->btf;
 
-	security_bpf_map_free(map);
-	bpf_map_release_memcg(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
 	/* Delay freeing of btf_record for maps, as map_free
@@ -760,6 +756,16 @@ static void bpf_map_free_deferred(struct work_struct *work)
 	btf_put(btf);
 }
 
+/* called from workqueue */
+static void bpf_map_free_deferred(struct work_struct *work)
+{
+	struct bpf_map *map = container_of(work, struct bpf_map, work);
+
+	security_bpf_map_free(map);
+	bpf_map_release_memcg(map);
+	bpf_map_free(map);
+}
+
 static void bpf_map_put_uref(struct bpf_map *map)
 {
 	if (atomic64_dec_and_test(&map->usercnt)) {
@@ -1411,8 +1417,7 @@ static int map_create(union bpf_attr *attr)
 free_map_sec:
 	security_bpf_map_free(map);
 free_map:
-	btf_put(map->btf);
-	map->ops->map_free(map);
+	bpf_map_free(map);
 put_token:
 	bpf_token_put(token);
 	return err;
-- 
2.43.0


