Return-Path: <bpf+bounces-28073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0D58B570E
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 13:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C377286CBF
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 11:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFEA4C63D;
	Mon, 29 Apr 2024 11:46:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD747A5C;
	Mon, 29 Apr 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391205; cv=none; b=m/zdKh+dY6uC9MIwuQbvcat3c/J00nS+OGsSsGuLjip1rm1knE+Hn7GcYhZlRhksoVvJf5dqq4Yfh+u33DcNO/Asb1VSEL8h2lCe2iXB/nFEm8S6b5ZtYNA09ZEbE8Y2dzUhv9mpdnvEkR3DDIaCDFVm6nr2P7smpuFy3KpWCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391205; c=relaxed/simple;
	bh=ITYF6YQ6atV387lGaOq8pM/DKovLv/P+pLmkVn+3D5c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VqVemaMl6L6yxFt9U33wrpXwa8ANI4+9OWRbDzSZPnNyNMwQJ1VqEUWIOXsysQXl0VaLuF96nCD9LtbZybbWvx4SYTM/2RNLcZHzIJ1feqhNFK5TNV7qlai+n0gAq0Fl/PoVLzxQtHDCT7egUi8MhRsU7UtyDWpp8osCYvY9vvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VShNB3rkQzccJ0;
	Mon, 29 Apr 2024 19:45:30 +0800 (CST)
Received: from dggpemd500003.china.huawei.com (unknown [7.185.36.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 715DC180A9F;
	Mon, 29 Apr 2024 19:46:37 +0800 (CST)
Received: from huawei.com (10.67.108.248) by dggpemd500003.china.huawei.com
 (7.185.36.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 29 Apr
 2024 19:46:37 +0800
From: felix <fuzhen5@huawei.com>
To: <paul@paul-moore.com>, <casey@schaufler-ca.com>,
	<roberto.sassu@huawei.com>, <stefanb@linux.ibm.com>, <zohar@linux.ibm.com>,
	<kamrankhadijadj@gmail.com>, <andrii@kernel.org>, <omosnace@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<xiujianfeng@huawei.com>, <wangweiyang2@huawei.com>
Subject: [PATCH -next] lsm: fix default return value for inode_set(remove)xattr
Date: Mon, 29 Apr 2024 19:46:36 +0800
Message-ID: <20240429114636.123395-1-fuzhen5@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd500003.china.huawei.com (7.185.36.29)

From: Felix Fu <fuzhen5@huawei.com>

The return value of security_inode_set(remove)xattr should
be 1. If it return 0, cap_inode_setxattr would not be
executed when no lsm exist, which is not what we expected,
any user could set some security.* xattr for a file.

Before commit 260017f31a8c ("lsm: use default hook return
value in call_int_hook()") was approved, this issue would
still happened when lsm only include bpf, because bpf_lsm_
inode_setxattr return 0 by default which cause cap_inode_set
xattr to be not executed.

Fixes: 260017f31a8c ("lsm: use default hook return value in call_int_hook()")
Signed-off-by: Felix Fu <fuzhen5@huawei.com>
---
 include/linux/lsm_hook_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index f804b76cde44..9c768b954264 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -144,14 +144,14 @@ LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
 LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, int ia_valid)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
-LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
+LSM_HOOK(int, 1, inode_setxattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name, const void *value,
 	 size_t size, int flags)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
+LSM_HOOK(int, 1, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
-- 
2.34.1


