Return-Path: <bpf+bounces-41266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC8399552E
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76DF5B22E1F
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317171E132D;
	Tue,  8 Oct 2024 16:58:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B501E0DE2;
	Tue,  8 Oct 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406683; cv=none; b=NWpYC/FR2lA0arzovyXUfwwu7vCn64RKJ0d3g7+snw8vYO5BZbqe3st5+mMePhzBve6171Ao7LZKoiKr0mRwE7ct3Hp2KmgQoYh1OS28Cgt3zQgOu5J4sOpCLfFaRyQbBh/Ahh9TKA35jdK7kGcaOMLzX0CYqHPLuydnzbd93dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406683; c=relaxed/simple;
	bh=72BH+7dd3CukjfZzS71uAos02pWQ3nHiqzJ+LRPT6q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ho7atEBdy9lGs3YEhKz6SiZXRtOIQZNQ3RqFkBXSbpViXqbVQ+yuW25ZlQctQ+gPyz2jVRrviC+hTdZcLJvvsnGMJU+vykK+VfoiFXzmkEN8jR79F3lcgkQH1s75qNXxs5QtsjWESeWHAcJkXx9rA+UEFDc3GfSpu6ehw0HJnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNMBp327Fz9v7Hl;
	Wed,  9 Oct 2024 00:37:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id F1593140156;
	Wed,  9 Oct 2024 00:57:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDnlseAZAVng2B7Ag--.64194S4;
	Tue, 08 Oct 2024 17:57:56 +0100 (CET)
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
Subject: [PATCH 3/3] ima: Mark concurrent accesses to the iint pointer in the inode security blob
Date: Tue,  8 Oct 2024 18:57:32 +0200
Message-Id: <20241008165732.2603647-3-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwDnlseAZAVng2B7Ag--.64194S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyUGF4kZFyfAr43CryfWFg_yoWkKrX_uw
	nYvr1Utw15uFZ3u3yDAa4aqayv9Fy8Cr48Ka4ftanrA345Jr98XrWUJFnaqFy8Xr42gan8
	Grnakry3t3ZrWjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
	4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0jN
	t3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBGcElPgLOAAAsz

From: Roberto Sassu <roberto.sassu@huawei.com>

Use the READ_ONCE() and WRITE_ONCE() macros to mark concurrent read and
write accesses to the portion of the inode security blob containing the
iint pointer.

Writers are serialized by the iint lock.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6474a15b584a..3fe1651395ce 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -215,7 +215,7 @@ ima_inode_get_iint(const struct inode *inode)
 		return NULL;
 
 	iint_lock = ima_inode_security(inode->i_security);
-	return iint_lock->iint;
+	return READ_ONCE(iint_lock->iint);
 }
 
 static inline void ima_inode_set_iint(const struct inode *inode,
@@ -227,7 +227,7 @@ static inline void ima_inode_set_iint(const struct inode *inode,
 		return;
 
 	iint_lock = ima_inode_security(inode->i_security);
-	iint_lock->iint = iint;
+	WRITE_ONCE(iint_lock->iint, iint);
 }
 
 struct ima_iint_cache *ima_iint_find(struct inode *inode);
-- 
2.34.1


