Return-Path: <bpf+bounces-19661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7698182F986
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141F21F2862A
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFBE60271;
	Tue, 16 Jan 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2u9N++2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E17160260;
	Tue, 16 Jan 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434979; cv=none; b=aChy7eHcJPCPCfvykdK1UYlZKte3nDWErah/g3Ah2Iuy+r2gIjdgpEPvDTwQCKlIOVbuEXWowggfu7JlmByFsRMNKxQIyWhDE1V2h2w+w/1f3FjxnJ+p+Ch+oYAdfChhPojOPRYM+Lwz3a80JBMDXs5NNBCIJGY15H6T8burExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434979; c=relaxed/simple;
	bh=q3pkUZ197SUzjPVsSZO7lyWfte34I9+HrOeuD/xuMqQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=DQrCYoCjm3zONJcKjuiN/jt3504lYZztCoiI3c3O9AL7Yvdjw4TliIhZ/VbgTBRfrahANpWNr3b8W7c8wndyNVYuLmmi52EbexJehRv1xgH7Mf7aC6pfVSl0Jc+BQLTn/9o3/SUjxhZeQCzPYmAYbPblH+VsTGJbYo8yTrVJ9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2u9N++2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C587C433C7;
	Tue, 16 Jan 2024 19:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434978;
	bh=q3pkUZ197SUzjPVsSZO7lyWfte34I9+HrOeuD/xuMqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2u9N++2npTusmZI3rtJcpPAVuqf617R/Y8036rRCgQ6imHtEoxNLunw0I/XzOesU
	 ljradGFIpM94rDAOyoa0mfHiveYlWHHu+eB51hpz1luFp3i/dMidelJ1r007uOcM+y
	 vC4hRUVxt1wZ2Re5p0XGiUMdxDQVCWMFXCuU2xY0OThag9VIqieIWxUwIZUXp3v4dI
	 C2qbiNcCyLGD4yCntvFLfOwQNoiAGbKyqYVI8MBnJ0xEbTWcTeQwSCsOXR9QKRni8Z
	 KuHehueFEX2cxAJJXR2fzdHK6irWAjBxWOz4gIXiH84M8RkCj5TNbcjk6R1R1iBVg9
	 5ZHL4/7/kJEyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 29/68] bpf: Set uattr->batch.count as zero before batched update or deletion
Date: Tue, 16 Jan 2024 14:53:28 -0500
Message-ID: <20240116195511.255854-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index 0c8b7733573e..e9fa3bbafe56 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1576,6 +1576,9 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	key = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
@@ -1635,6 +1638,9 @@ int generic_map_update_batch(struct bpf_map *map,
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


