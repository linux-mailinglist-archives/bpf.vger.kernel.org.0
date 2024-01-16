Return-Path: <bpf+bounces-19635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D2482F666
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 20:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0AD1C2408D
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0E7328A6;
	Tue, 16 Jan 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3WONRA/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F6321A1;
	Tue, 16 Jan 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434289; cv=none; b=npNjefy/+dG/s952dzb23qCgEYCAuRHXodjp2es2oIroOFF6UYEdJ6ldtu2fI0bnssb228CIaYznQVBlVFceD/VUKOR+8QWYl9EGrnl6Vv1/QWLKGF3IMP/JYV4WcroQqfYy8gr69pAh5jY8bdH1wLlhJ8mCTi96q2WSkBI/4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434289; c=relaxed/simple;
	bh=wworOC67y9iTAVp+T5FvBy9JQQc7AjuTaatdOEHECuQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=beUMhtQOPjOvdCuaaqGgV94qKLlS32PTpMFcUYc1LP6RQVVk/+21WYhm8W18g49SN8aK+MhoWmZkt8X6ioFlPDW0y8i22hhxETtv6V4kOOjjtSXCAVodMekqHEDQ3NGFMqWSCNIOwlu0OYGPQ9iGbgQ6sqQfblX35dOmXGsRTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3WONRA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0F0C433F1;
	Tue, 16 Jan 2024 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434288;
	bh=wworOC67y9iTAVp+T5FvBy9JQQc7AjuTaatdOEHECuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3WONRA/rLebnX8wvn35OUQSn6miRa/HJFpfcKfBYw8krVlQ2FHckDsaBG6JcysaK
	 EG7VaFBOKC/nWqLQbyaMcqBNB5r0hAiOWoYUnvvhnGfS7z9LeCOWPCOMnWEeAS/Ofa
	 xZr6g5OAUM1fX3VfKlNDtZgwMPE87O0Y85xUPmCEXKm/VO6spnVigOc3WDbyVjbAzE
	 5ioHkn03sem4+HNAacri6oGgx8WXSxB+0Eq2RlGA37nKVH57iTdj00dcbXJ1yETKT6
	 cmHq4s4SBMpzpZZkVqa551l8V3fmOlkznxaxssfWMUUIB2cVcEyZn7prl1VYXt7cWY
	 g4x62suymEJSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 052/108] bpf: Set uattr->batch.count as zero before batched update or deletion
Date: Tue, 16 Jan 2024 14:39:18 -0500
Message-ID: <20240116194225.250921-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 0ed286b8a0f0..96911f9dedfc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1676,6 +1676,9 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	key = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
@@ -1733,6 +1736,9 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
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


