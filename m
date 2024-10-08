Return-Path: <bpf+bounces-41264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508BE995525
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D55286FB6
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 16:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0FE1E0E1C;
	Tue,  8 Oct 2024 16:58:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADEB1DEFDC;
	Tue,  8 Oct 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406681; cv=none; b=Wa7QQA270e+jRHj5CVVLjya/F50GvQppqIXROEcJrdMoV6SXKYpYFYGjoES5QatsW87UPG1wjw1e6qr36DXmevE3TcsfIPHyf+n3fhZF8y9rpK+bjbKDN4BxHANAjFzwpn0iKrQBII5kt4yChdqQKFrRJzleHqGc84EeuHczfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406681; c=relaxed/simple;
	bh=cABlkqAmSXMHna6jw/aL76yVMPEfA1rryVgcyRi5B6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxspwvVj+gnFCoVTpo/FcKf99RAd4LJ5he5l4MgxLJ3xKCziiKBmZq/b2uCSR97INymxxTkL8Bnr8pC0X6u8EB0u5YGQaYABeAUA6SIY9ZGqyVaeChJ8xjPFmS+s64UDIIjmW9pVC1SvrWbjM+c3MX68y1IoJXT62DVkSFsRm2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNMBn15J3z9v7Hm;
	Wed,  9 Oct 2024 00:37:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id ABCEF1401EA;
	Wed,  9 Oct 2024 00:57:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDnlseAZAVng2B7Ag--.64194S3;
	Tue, 08 Oct 2024 17:57:50 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ebpqwerty472123@gmail.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 2/3] ima: Ensure lock is held when setting iint pointer in inode security blob
Date: Tue,  8 Oct 2024 18:57:31 +0200
Message-Id: <20241008165732.2603647-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDnlseAZAVng2B7Ag--.64194S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF48tryfJw4rtr4UJw47Jwb_yoW5GF17pa
	1qga4UJ34UXFZ7Wrs5AasF9r4fK3yIgFy8Gw45Aw1qyFsrJr1jqr40yry7ury5Gr4rtwna
	vr1UKws8ua1qyr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0GY
	LDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBGcElX4LAwAAsM

From: Roberto Sassu <roberto.sassu@huawei.com>

IMA stores a pointer of the ima_iint_cache structure, containing integrity
metadata, in the inode security blob. However, check and assignment of this
pointer is not atomic, and it might happen that two tasks both see that the
iint pointer is NULL and try to set it, causing a memory leak.

Ensure that the iint check and assignment is guarded, by adding a lockdep
assertion in ima_inode_get().

Consequently, guard the remaining ima_inode_get() calls, in
ima_post_create_tmpfile() and ima_post_path_mknod(), to avoid the lockdep
warnings.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_iint.c |  5 +++++
 security/integrity/ima/ima_main.c | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index c176fd0faae7..fe676ccec32f 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -87,8 +87,13 @@ static void ima_iint_free(struct ima_iint_cache *iint)
  */
 struct ima_iint_cache *ima_inode_get(struct inode *inode)
 {
+	struct ima_iint_cache_lock *iint_lock;
 	struct ima_iint_cache *iint;
 
+	iint_lock = ima_inode_security(inode->i_security);
+	if (iint_lock)
+		lockdep_assert_held(&iint_lock->mutex);
+
 	iint = ima_iint_find(inode);
 	if (iint)
 		return iint;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 7852212c43ce..2425067b887d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -705,14 +705,19 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 	if (!must_appraise)
 		return;
 
+	ima_iint_lock(inode);
+
 	/* Nothing to do if we can't allocate memory */
 	iint = ima_inode_get(inode);
-	if (!iint)
+	if (!iint) {
+		ima_iint_unlock(inode);
 		return;
+	}
 
 	/* needed for writing the security xattrs */
 	set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
 	iint->ima_file_status = INTEGRITY_PASS;
+	ima_iint_unlock(inode);
 }
 
 /**
@@ -737,13 +742,18 @@ static void ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 	if (!must_appraise)
 		return;
 
+	ima_iint_lock(inode);
+
 	/* Nothing to do if we can't allocate memory */
 	iint = ima_inode_get(inode);
-	if (!iint)
+	if (!iint) {
+		ima_iint_unlock(inode);
 		return;
+	}
 
 	/* needed for re-opening empty files */
 	iint->flags |= IMA_NEW_FILE;
+	ima_iint_unlock(inode);
 }
 
 /**
-- 
2.34.1


