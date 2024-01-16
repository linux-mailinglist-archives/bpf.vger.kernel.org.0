Return-Path: <bpf+bounces-19670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3191182FA45
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8B428B014
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB22030D;
	Tue, 16 Jan 2024 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofH19HSd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F94152DFC;
	Tue, 16 Jan 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435157; cv=none; b=V12J8xE7EraEnrXwALnFBKupCHOKewoYVSYoxd5Qsd0tCnVPcb0HUm9QP741hUbV+qvOaE6YSXp9pHbvlOr2wOdat66zxolL85nrHdZ7ScgWK72VAhzeVlLMj6+dlq3dv8LgCdBRgI+WLkfo3DO/j216hWD9I63TJkWk6PUz5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435157; c=relaxed/simple;
	bh=8+/btd7tj5pClWvQfHKd7sNC8iH8bZYd+Ucq27C2W6o=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=mue9NF0Zflt8URjL+n+r+RK7U2uIMWG7l6z2gFn5KswAKMlP5cG3KkoG3dfwUP3t/yfRr4F+7gCMol21boN1T0TpwT4G2XfaGtN2f6XP356J+ylr6C7ci3bjRWBtHPN6CC47rVhQIagSse+gDnk5erE3z9Sll7ZW0zpVzaQBIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofH19HSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E512EC433F1;
	Tue, 16 Jan 2024 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435156;
	bh=8+/btd7tj5pClWvQfHKd7sNC8iH8bZYd+Ucq27C2W6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofH19HSdbQ4L38MA8sumxiRCrqolhmMiSzfzzbQ9ccuwKSvDuv9Pk6h0s3r5Oo8hU
	 0tgrnVDKQBj+gNF0UElcuc/20md63Tfmpeg85xHkvJpPnEI38hdhLUPWk6nKZxoRCc
	 9e9iG5uhe5yRHh0Tj9LmaGZMN7Qabcs3ryyfdYWY6uSVPcCTZocIupiI5SbrkJ5LqM
	 eQ7UTQrjjTDt/CPmU+xOk+pnCK+IQjZEPpwjKq8dvVQUIgTOXoD0ZPwi4YrfDONn6P
	 g0wjOvNzGSpSZztzN9xfgc20g1sc1TxEgD2BET2VbXo1O3B6UYlhr0x6X2jlKvwXIP
	 S7frJ/Zdt8uqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 20/47] bpf: Set uattr->batch.count as zero before batched update or deletion
Date: Tue, 16 Jan 2024 14:57:23 -0500
Message-ID: <20240116195834.257313-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index ad41b8230780..a58f1d805ea8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1314,6 +1314,9 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	key = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
@@ -1372,6 +1375,9 @@ int generic_map_update_batch(struct bpf_map *map,
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


