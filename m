Return-Path: <bpf+bounces-16366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF92D800767
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D671C20D4B
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005141F615;
	Fri,  1 Dec 2023 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQl4mazy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA2C10DE;
	Fri,  1 Dec 2023 01:47:10 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cdd4aab5f5so1902163b3a.3;
        Fri, 01 Dec 2023 01:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701424030; x=1702028830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dess//0c2Lh04XmQ2u56zFtWMuXDgxNkubc5UfyU5ak=;
        b=lQl4mazypz+7JgpnradWaXdq19xkZ1iqFM556jppCCtXOlIBxDCMFeDTUliT9j0MtL
         pzcqGiH3Q6tVmGK0TElaS8dilXYY4Tlxmmtl0QoY4AZJg6ODoXXgpQG7aC1oQdyBB2nu
         R9sZs5V+oaC1zEakupZqGITCJDM4NQKehcIqvN984JHcWzVQmVljySJ585Z8f4zAxAw9
         mSBVZajb+6uNp/0C8mbqMbGuDODgvs7NdnRHi5jbx4Y50DuMJdxmXSpW+qO+94k517wZ
         lEYH4cREweO/AFz/7DcmdWi2gOy2ztQj0QHSCmQNpyccTAI7g90U2wu4KQ/p8tqq282b
         6BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424030; x=1702028830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dess//0c2Lh04XmQ2u56zFtWMuXDgxNkubc5UfyU5ak=;
        b=L9SNBCFUcRK9rPjNqiDEcQTpLsZbzJ6PuFJcNU4Txic9jPh32SGS99tgnlyuqHExWT
         zS9GN897A6GB9CZbgCTw4ZjT8VXsv/cc+0hV5o8XScjxzfVHEa5DYe2TB4XYNwkVNNch
         hD6j8PlxAEVADTDE1pTpdz4WkpAnmfovhE8GDLRz35lOcfFeyaU5fUj9ej23p1pOOzkm
         UNSC7dDckyd2cCW1Gao70Dq9H+d5BeFiZ6imEULJczFh3xvzAw5/wQHz2lBExZqlDxgQ
         hIbMrIqmq2DHkuVpJSXNhHBSlD/f26h4W6X2QE77L+tr2yrN5Hrc7PvI8JePYDPS2YOK
         orrA==
X-Gm-Message-State: AOJu0YyX/1UvqQbHw00lS4sJNmJdXdjsiACmRyIPmJM14/vwMPxxCAXI
	nqFn6skzLRPvg1mB+tavJXTBbXvde3WP6eCg
X-Google-Smtp-Source: AGHT+IFKEK9U8bDFol/OVizJQvuY/KulkxmLfMUD7mG6RF1mpjVP4Jnt4qHJlMEuVuE8HB+QA/XgNw==
X-Received: by 2002:a05:6a20:9154:b0:18b:5a66:3f70 with SMTP id x20-20020a056a20915400b0018b5a663f70mr30186543pzc.2.1701424030179;
        Fri, 01 Dec 2023 01:47:10 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001bdd7579b5dsm2875534pls.240.2023.12.01.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:47:09 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	mhocko@suse.com,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 3/7] mm, security: Fix missed security_task_movememory()
Date: Fri,  1 Dec 2023 09:46:32 +0000
Message-Id: <20231201094636.19770-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231201094636.19770-1-laoar.shao@gmail.com>
References: <20231201094636.19770-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Considering that MPOL_F_NUMA_BALANCING or  mbind(2) using either
MPOL_MF_MOVE or MPOL_MF_MOVE_ALL are capable of memory movement, it's
essential to include security_task_movememory() to cover this
functionality as well. It was identified during a code review.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/mempolicy.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..1eafe81d782e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1259,8 +1259,15 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (!new)
 		flags |= MPOL_MF_DISCONTIG_OK;
 
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
+		err = security_task_movememory(current);
+		if (err) {
+			mpol_put(new);
+			return err;
+		}
 		lru_cache_disable();
+	}
+
 	{
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
@@ -1450,6 +1457,8 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 /* Basic parameter sanity check used by both mbind() and set_mempolicy() */
 static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
 {
+	int err;
+
 	*flags = *mode & MPOL_MODE_FLAGS;
 	*mode &= ~MPOL_MODE_FLAGS;
 
@@ -1460,6 +1469,9 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
 	if (*flags & MPOL_F_NUMA_BALANCING) {
 		if (*mode != MPOL_BIND)
 			return -EINVAL;
+		err = security_task_movememory(current);
+		if (err)
+			return err;
 		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
 	}
 	return 0;
-- 
2.30.1 (Apple Git-130)


