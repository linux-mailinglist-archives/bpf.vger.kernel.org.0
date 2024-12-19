Return-Path: <bpf+bounces-47366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80D79F87AF
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 23:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB8C162DAB
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A3C1DC992;
	Thu, 19 Dec 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsUAeEsk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EDA1C07EC;
	Thu, 19 Dec 2024 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734646506; cv=none; b=T5PTPvSixHdkdMzlsS31KQdfnbwinUI6rf5MQWl7jLZe2o/XToSsiGKAmRoS7LjT4jmdnnMmsk6XxyLS5vnAWMnXhoIkLQztm1wQz87sDeKLVZzItUpsbJm6aaB8VxWDk5Kv9RvZQfdAHqXjVlZ2DoHNv/pVYfLANOMya9lkntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734646506; c=relaxed/simple;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6FTHFJoVjxPrh/EHCtyGU6L2MTyaWW6fKb6zjS+wY7EdBLrWgYazCVNEI6NZmtPVoWT8RUVT7ip/QuzjM5VtUfdvgo16OX2ipVtKBTR6YwAbGQ1wgdMYjbAjX2Act2RQxi4ybOz4DXqfBaDTHMajyu80BcW557OiQ8MV8z5Qms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsUAeEsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C84CC4CECE;
	Thu, 19 Dec 2024 22:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734646505;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsUAeEskZKQajnB6+BUGvLmFSo5s0ZtF1eygQXMk7CBWscze/1lPiOz1tECExjnJ0
	 1MyG/BV3qrBcFWyYIbmLcoRsfq9qAEOu/0a0TqyTlKJDmtpUIjrO+N50gDG2k2Tgys
	 ViSDmotUzfG59e9qWSvXh/7hyeQhazIh7j5xYz94OrWebf7kWUREIgCnbUXplDchWK
	 w/VAMY1EB2aNmJ2Mb7JU4HMty63urGwP+XGtAo3CbQ61mXNJ5hDujy2/8kM2//RAC4
	 P8Cenq53oxO8PnLCTzXAU9SACxBC3DecfUQs8P9eFYXcnE1KFkciPfmCZG9h6GIE9l
	 0AEt4uOq+kXpA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	memxor@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v7 bpf-next 3/7] bpf: lsm: Add two more sleepable hooks
Date: Thu, 19 Dec 2024 14:14:35 -0800
Message-ID: <20241219221439.2455664-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241219221439.2455664-1-song@kernel.org>
References: <20241219221439.2455664-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_lsm_inode_removexattr and bpf_lsm_inode_post_removexattr to list
sleepable_lsm_hooks. These two hooks are always called from sleepable
context.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/bpf_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 967492b65185..0a59df1c550a 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -316,7 +316,9 @@ BTF_ID(func, bpf_lsm_inode_getxattr)
 BTF_ID(func, bpf_lsm_inode_mknod)
 BTF_ID(func, bpf_lsm_inode_need_killpriv)
 BTF_ID(func, bpf_lsm_inode_post_setxattr)
+BTF_ID(func, bpf_lsm_inode_post_removexattr)
 BTF_ID(func, bpf_lsm_inode_readlink)
+BTF_ID(func, bpf_lsm_inode_removexattr)
 BTF_ID(func, bpf_lsm_inode_rename)
 BTF_ID(func, bpf_lsm_inode_rmdir)
 BTF_ID(func, bpf_lsm_inode_setattr)
-- 
2.43.5


