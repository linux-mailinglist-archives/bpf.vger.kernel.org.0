Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F862F295A
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 08:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392184AbhALH4V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 02:56:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392168AbhALH4T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 02:56:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A4DB22E03;
        Tue, 12 Jan 2021 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610438138;
        bh=o5Rzs1vuE1D3WbehT8AKNB1TH9/Fl1BevYeZL7iOe6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQp0xAdm/ORxZ4vMwjFAOfRsLxKwVfhx3grAextT73CSeikuqC4Xj4JAAvOtkPmwq
         mBB8Bn+2ekPf1I8CtUtxdfDhboP49N3Zi0FhRSKRGxqy21b49Bu00ZZcBoQlQ8q+Yo
         c5VwGtS9J69opplGMDo/82hFsZ/UcS/X/sbbxDCafefLBC3puvDZNtbcuYwr4eAd2v
         oeD6CQUqeMwH3zaw/OEeqOsU/uXTjbMB/u8MquDJg6YXDxXS/GlGPgqTgSc7JKz0fG
         mWemE7k8GXerpvloIMHpsCklrDWh1cgUITP+X8G6dDSspor+7kJcvAdyR56jbbq1To
         VVCRQRH2fjDcw==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf v3 3/3] bpf: Fix typo in bpf_inode_storage.c
Date:   Tue, 12 Jan 2021 07:55:25 +0000
Message-Id: <20210112075525.256820-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210112075525.256820-1-kpsingh@kernel.org>
References: <20210112075525.256820-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix "gurranteed" -> "guaranteed" in bpf_inode_storage.c

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/bpf_inode_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index dbc1dbdd2cbf..2f0597320b6d 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -183,7 +183,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 	if (sdata)
 		return (unsigned long)sdata->data;
 
-	/* This helper must only called from where the inode is gurranteed
+	/* This helper must only called from where the inode is guaranteed
 	 * to have a refcount and cannot be freed.
 	 */
 	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
@@ -203,7 +203,7 @@ BPF_CALL_2(bpf_inode_storage_delete,
 	if (!inode)
 		return -EINVAL;
 
-	/* This helper must only called from where the inode is gurranteed
+	/* This helper must only called from where the inode is guaranteed
 	 * to have a refcount and cannot be freed.
 	 */
 	return inode_storage_delete(inode, map);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

