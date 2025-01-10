Return-Path: <bpf+bounces-48503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE54BA08496
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 02:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512787A32A6
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 01:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669251487CD;
	Fri, 10 Jan 2025 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+G9I++/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C453A1CD;
	Fri, 10 Jan 2025 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471650; cv=none; b=hB34sM//yWriYh69nbJ/pYz5uy8Hc35BMly3e8AN7jy6Y8k945EytD0lmaA3j74xFRw88M7LsdhZwrm+VJjhWmyWwgGOswNZ8cDTbX62GSG6txhyHeLTJJhRbAX3bLOFChIu9FNOR0nSza2mdKoUG/Kp2jwn2Vn54XzKiW/+srw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471650; c=relaxed/simple;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHRXHJDAKdL4YoprRheDozKdCnz5ZqAretU3WCv4+Dzlg+AP8NmWfflK19Pfu5pyj86Ua8tKTOuQNtPaanM9WjB9p7Vop7HOOxiRETTfG7EizWeBFWztwTKibpm8CjpWTVkxjSq31ruV3KjKqXb2V8PQOUpaKiF27KJeGecvi2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+G9I++/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D906C4CED2;
	Fri, 10 Jan 2025 01:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736471650;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+G9I++/wzNhLQOvtG3goPqH9bcsn/HcIyIpEEoFwKC2uvWa6ZNV3/PFn81HT3HGX
	 q96crW0U5QxWDD9/s880QFlJw8XejCRxcbCzZdXPVa8geMwqQWg09oYe5BVFf88Q3w
	 YIwnP6ypH5qJh3zuSYa8NV1lWJ6XpCcZbw44QYjEljLCoRk8TGTVMpkbbK4GinG/Sa
	 xOml+QuQ6M+xJ4A0AkPCFiNwS0sK8LMh8pUugYeP0xzSXSTPZ+9LGv5j5bn1cEE7gU
	 F+Z1gBMGlF+L/JwT20W+cyDi1KuSfCuGDQq0gNnYd3L31Nb7cCvWoXZfH+XQUxNkRk
	 zm8j9NonF0niA==
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
Subject: [PATCH v9 bpf-next 3/7] bpf: lsm: Add two more sleepable hooks
Date: Thu,  9 Jan 2025 17:13:38 -0800
Message-ID: <20250110011342.2965136-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250110011342.2965136-1-song@kernel.org>
References: <20250110011342.2965136-1-song@kernel.org>
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


