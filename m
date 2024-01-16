Return-Path: <bpf+bounces-19677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D341D82FAE7
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1AD1F28C3A
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055632032C;
	Tue, 16 Jan 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6v+qIHm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1515CD6C;
	Tue, 16 Jan 2024 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435292; cv=none; b=arOyQIzgKANOdD2/xI1acgmMDDwl8Z3zs6uraKWDxQtq7tJfpKgsqCcxOmfkx33X6pNq+e8hWQTclUEOV/3WaNYpJ0Dyrf0yt0dwEIIPWjCBhxFrYbee2jsdt8C/C2kCAHI1GTUFaaEqMZ9KnS+4IyTOSzZQDEGutDoDNS+KcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435292; c=relaxed/simple;
	bh=yb6LNy7ADxfioEwyvILdwpFFJbfJjNpZK/vzIoDYJKo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=iJ9JWz/VSDz6aSNr36tBR+tDsYqdkuFepJTD/Z8P66POOLrUhOdsyz8me5yW5aQonSHuuBMRHyE6IyNd32P1iGKW5g2a6031OYOblgRrm9Q3wSfcLDNsLUm3f+b05RgZdcWwua5b02PCHcJkcIO1nVoLL+2YukW1f+9CUSZWAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6v+qIHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F02C433F1;
	Tue, 16 Jan 2024 20:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435292;
	bh=yb6LNy7ADxfioEwyvILdwpFFJbfJjNpZK/vzIoDYJKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6v+qIHmyA7L/uauNI8nsDaDcD43kLFDyd9pBM5iydfdJNtMuZu9C9/xB/hnYRiHK
	 vlDokkEnDnPSvGpS8ayOwaiDqii1JGPKzeXdyK3HoXcpsDLY3bcxjTfUMhPoG9kyF6
	 Kl0eZGcfdf4VFLmneVGNJSVF6ggeXmZ4/jvsizfhj0lIsp5Bdt6fxCxLVtbQ9sdYBK
	 sFAAlCiCFOYjDexqp6uTrPWGGJX+d5dHS7HC2DI8MQAdkJTYPDipLsN+zDiyeWEDT1
	 eIZnI6hVNckaGB7TLo6eiAdwrm2zmWsZi7K2d3ii7WH5h+ehlYH3SHFBZtjTskio9A
	 H3Lxl/UxhzAqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 19/44] bpf: Set uattr->batch.count as zero before batched update or deletion
Date: Tue, 16 Jan 2024 14:59:48 -0500
Message-ID: <20240116200044.258335-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index aaad2dce2be6..16affa09db5c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1285,6 +1285,9 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	key = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
@@ -1343,6 +1346,9 @@ int generic_map_update_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	key = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
-- 
2.43.0


