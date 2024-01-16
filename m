Return-Path: <bpf+bounces-19650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9982F860
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6A81C24F38
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 20:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E3A131E24;
	Tue, 16 Jan 2024 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYM4D/5J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82817131754;
	Tue, 16 Jan 2024 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434693; cv=none; b=YksD1rHYvOmbWnCFsUUD/teXzR3e4SCQ9E8wx4AYaEu39/EZDzkRqK5eXRZsaYcx0crvKRTyoIuShswKt0HVq+Fe7ncSCyM4zA7OIU6c1/V2GDJ7fOHIi3jXa3J83uxguE9nDd0G/6mhAH1S1JMylr+ZDYRHNpzfuKzoh51Hi20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434693; c=relaxed/simple;
	bh=85DQhWZkGB6JLAW1Xfb+aDd9xevlmh3rNEDoesQ+fm4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=rCilaS6Ht/7Hxz91Xsp2tbYeitGHVFal4CWIWJsIdwNk7VdW4DifDWZdUJIzkIfY/sfp8+zs8doBG1+HM0pUL6x1dM0qrBM18hwZ+bqSXCFhaU1Be/wJkrmfSmQE+dxibOTUgZMEivXgDbs608FpU82jSzFUozGnEjbQoLHI3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYM4D/5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B52C43601;
	Tue, 16 Jan 2024 19:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434693;
	bh=85DQhWZkGB6JLAW1Xfb+aDd9xevlmh3rNEDoesQ+fm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYM4D/5JCj6ICTczexvJwVjdT2aSGEjNjn5YGURSiJzCMyvx6AlT7H9iNu5Cpgrvd
	 UGo9J3P4qG06DF6JbyKjZVxcynZXBjAuOW0SiqRx5Hy+PNRvCzqkZ3P1Z89v5tD621
	 0FbMJkVxgSgHhxXnHLZcxUJyXVKyPMOK/O8KIAZEtyCEpcSyRCyi8div2rdhj1m6+V
	 pAToAC7oTHAkW9juNMK38YW6Q1OHdK61WVU0ItV2lJgd3stKNGpOevaZdYxpCVcdav
	 +C95cVOoQBsAkEGPpctcO39vqRef0FjXB692P8zIqYg3HGrA/TeHyPzyEGkJ0a1q3Z
	 kDa6OfuBC/eAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 051/104] bpf: Set uattr->batch.count as zero before batched update or deletion
Date: Tue, 16 Jan 2024 14:46:17 -0500
Message-ID: <20240116194908.253437-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 06e5c999f10269a532304e89a6adb2fbfeb0593c ]

generic_map_{delete,update}_batch() doesn't set uattr->batch.count as
zero before it tries to allocate memory for key. If the memory
allocation fails, the value of uattr->batch.count will be incorrect.

Fix it by setting uattr->batch.count as zero beore batched update or
deletion.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20231208102355.2628918-6-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d77b2f8b9364..164a5902571a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1673,6 +1673,9 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	key = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
@@ -1730,6 +1733,9 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	if (!max_count)
 		return 0;
 
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	key = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
-- 
2.43.0


