Return-Path: <bpf+bounces-47352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD8F9F85D9
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 21:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF05D164DBC
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 20:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7B1CEAC8;
	Thu, 19 Dec 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8vWu/JG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184EB1B86E9;
	Thu, 19 Dec 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639973; cv=none; b=mnQuGHmH0fKYCpBQx5pullTkuxsck4Vfmz3XJj1q9qeByr/5IqhVgUq8TW5liRy8Qspoi6cEYJrZmTlH5kh8eV6lNBvh5ZXCe56DDhRq8y8Ys3wfFCukI23Dkf93fR6VODa7E6MqugrvQBZ7/VulZ27cFWzVC+AiQ+8QqJmKSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639973; c=relaxed/simple;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozUjnSpVgWoVuF5Rkn+jCOzfQkLrN3EUGAUTgRTlEBOqXhdfVxsCIz/jvYbDhKgeQKUagQ93sXZhv2oJHMs8IMiYQG8dKouMX+MciVvbItM2tw7RAJ0QNExq8v3F810moB2Pw9/1A3wZLgNT0xflf2UUhOHxG7SJbs22HIqFTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8vWu/JG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28A0C4CED0;
	Thu, 19 Dec 2024 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734639973;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8vWu/JGwydMOJ7eqTwxwCPna2orPLpYscXp2K7/E8205QqseqW4QlwhUmtjv9RJt
	 wyjtFrN4KaQrZIOCoxoXdoxv+x4a59cYSrzdYI1WcoWrokqsJqGLP/TFgWTBBe5sMs
	 he9uZpikAvwr6YjIgC5glfs2+uJ6EG9Zoidx8DB+ouwYKS/zELgfcpC6LXzNegqvj3
	 KoVNNqjNkdkpyV0mtCLqGlEmpmYiAkZ660DvaE967JxzMOSn8vrcHdYbDBsS+5+mvW
	 G0GQVAOsP0nglA9cKhqWpFf5C/AkQOZ4HPmN0fHGSkl+75oDKzi9HBCvkJVav6NfKQ
	 qufwW8cFM2UGA==
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
Subject: [PATCH v6 bpf-next 3/7] bpf: lsm: Add two more sleepable hooks
Date: Thu, 19 Dec 2024 12:25:32 -0800
Message-ID: <20241219202536.1625216-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241219202536.1625216-1-song@kernel.org>
References: <20241219202536.1625216-1-song@kernel.org>
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


