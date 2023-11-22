Return-Path: <bpf+bounces-15650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310C7F48B5
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031A8B210F7
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110E55646A;
	Wed, 22 Nov 2023 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Beb4BOiG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9F19D;
	Wed, 22 Nov 2023 06:16:23 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b8382b8f5aso945926b6e.0;
        Wed, 22 Nov 2023 06:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700662583; x=1701267383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCohkZOlhmClx79gxDRv3lIssVMr2jJPQS/93j1RD9I=;
        b=Beb4BOiGlbxl5Qv1YG1LmB8pL9Zf5n9nm/FeZpHLFPU2FrPLmCgebrq3/6Nhm7VWy4
         S3BBr4q68WSu529hrw1clZfg65K1d7p2lwxTChd+CUgI1G0FSH25mW8pzN5D5pj6oIXA
         SEGY5/gWnVu9TIjLXSXRd5t3164GoF/TZGsfOLNdkoFW9olUQWWQlhcuxnWV/u2TRhXy
         K5YMZ5Te/dytc0tBFl/CatKsxQf5765B9p44zAAzHV6TLNYqa8dhiDp5yDLJf4360gOw
         I9iYyiAN1Mh6dC+SQNoeuPIwx2Aj4pgGEUsTYnV4DKPozZ0OhcRycb+DSkggLDtQVmUM
         Bcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662583; x=1701267383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCohkZOlhmClx79gxDRv3lIssVMr2jJPQS/93j1RD9I=;
        b=VmZC4MsZOKN0misPIJaocG3FTtioxJd+xkSQZvYSgJf9FDkBTL8HHKLvXDVdRHG/p/
         COVDqRnkZPeuu2La9LalmMe9TUo2FTqf/7jPnVSp8PEOPEQDA+NDHuGN6K7tiijUagco
         gVNP4Tu8wH234LZnCDuACkq6cmOl8fMbYpYRPxP3zWQagZi8nSKdrFMELko6+RkgFEj6
         8XSON8Mo076CtyLKXfFsc7Doxd3BqIKTZxCRsZ/k2m4g0dQnbV5m4q+fD22yPIVbI5PS
         VFVPmLrmpjyYWuxVEctWQ0POwaBlheHBIdlfkXgl5a+9gkKtbfhRejHvXm/dA27W+DEd
         GT5Q==
X-Gm-Message-State: AOJu0YxldfoQhmNvDkju8QGGAhp8aKp2XmKv8hzBoY16Kswfj5CuBdZu
	0ejnzNCyEJElpVtntd1QXzwRU6QM4jMiyg==
X-Google-Smtp-Source: AGHT+IFPQzNlhHQv85DvH7rICMBG6EPDsKSzKKxxrGWE7E6Dc9LlipZ3FkuurVVO/TYfDh7rCoO6nw==
X-Received: by 2002:a05:6808:f87:b0:3b2:f54b:8b1f with SMTP id o7-20020a0568080f8700b003b2f54b8b1fmr2792746oiw.35.1700662582831;
        Wed, 22 Nov 2023 06:16:22 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac01:a71:5400:4ff:fea8:5687])
        by smtp.gmail.com with ESMTPSA id p18-20020a63fe12000000b0058988954686sm9356260pgh.90.2023.11.22.06.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:16:22 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	mhocko@suse.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 3/6] mm, security: Fix missed security_task_movememory() in mbind(2)
Date: Wed, 22 Nov 2023 14:15:56 +0000
Message-Id: <20231122141559.4228-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231122141559.4228-1-laoar.shao@gmail.com>
References: <20231122141559.4228-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Considering that mbind(2) using either MPOL_MF_MOVE or MPOL_MF_MOVE_ALL is
capable of memory movement, it's essential to include
security_task_movememory() to cover this functionality as well. It was
identified during a code review.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/mempolicy.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..ded2e0e62e24 100644
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
-- 
2.30.1 (Apple Git-130)


