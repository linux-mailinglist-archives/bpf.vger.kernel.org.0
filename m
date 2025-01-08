Return-Path: <bpf+bounces-48314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8CFA068E8
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 23:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B59E1886196
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 22:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C894204C1A;
	Wed,  8 Jan 2025 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tql5HO5L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6C2046BB;
	Wed,  8 Jan 2025 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376728; cv=none; b=OT38XWYzrHhOWwPsv1mrsj89TcnQeUhXuvX6OI2/22uXhr3IUej0UbuOS8ObxB9axhquNML6lumdTxvIL3fPM3N7ElBSjSfk5Tl+vXZmdUqu2oSkEPnq/eht+Dcvfd/6PGU01LtMUaZpS+zh3rDp8HrDzx7i55cq/aNced8v00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376728; c=relaxed/simple;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3Bj4xEZ1ctn96ghKLCF/+n4NfnmBQ6Zoijpj9mGXPoX09zCqCfad/Ale4FixVDxWjIDSOp0Je+rYzIppNoHew8c96jCnSo/dsZEo6/R6fN4kJyUGUovo3s68xiTIlIvnVWTpimJFmBcm/TE0QyhpR3jF99zLcASpKs0hJNL+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tql5HO5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799A5C4CED3;
	Wed,  8 Jan 2025 22:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736376726;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tql5HO5LEJ5y1VW0GtOa3S/BvKJMSMdD9vx/PIXcY/pFBL8eesjRteGlSe92ez2ua
	 Iizb+xZuX+Net+hNmYk6YMg1b8IlCDPZPrZyP3sOGH+X0aXSDkmVEVI2IhQhOzV69n
	 4GQBnI6GoQ9NUWbdmSKkiLLQTUXKCxyavqiYCbPVscM8fXCyuktOKZfPRJD9TMgr98
	 WbTAzdjlCK8O3vGdyPY5aB5tfucL7ZpA506EUVC1wYC+nTwN6SvjVUOAIKtoBZy5w0
	 ppC6emHB21ofhU7ud+c7TTUna4Kie7TJQzXa+ongT1oSPrgk28sTljzsK2CIu9fqUS
	 Xw2J8/1Bs3G1A==
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
Subject: [PATCH v8 bpf-next 3/7] bpf: lsm: Add two more sleepable hooks
Date: Wed,  8 Jan 2025 14:51:36 -0800
Message-ID: <20250108225140.3467654-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108225140.3467654-1-song@kernel.org>
References: <20250108225140.3467654-1-song@kernel.org>
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


