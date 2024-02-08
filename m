Return-Path: <bpf+bounces-21489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BD84DC6E
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 10:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F5D2874BE
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960836BB2A;
	Thu,  8 Feb 2024 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVgRbRvX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5D6A02A
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383380; cv=none; b=IsJ31Anu/srYWhijdFhOvOyLWXpDiLbV4U8eiO1rM4TkMharsrgH4d351uJpgmkcI+vwQtYOjUsGBcN+wQj813w6c+/65xc/Kuk+yyxm+9QRpRSquyv4gNwN09Drfvwa9yspcZf2EFhqximUeD75d+pvaAV+6rrt8JMR2LK+gl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383380; c=relaxed/simple;
	bh=0Xg8D3thkvvTg+XTPkXUNVMk3MvQtOboB6WznyesL7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l7IFeAXpe9rkQysmbCYyD1F1LhAMjQq81qIsZ2gwz1MWYg2cqLMQRfY+bENHzdVFd9AuBiMIwO3Nq7NI8Pk6p8WKLoe/+Y3rurrQvJaPVnfv3f6djK5IMxcdFMHXr18ANMLfTrEjebLMcFXPxS/o7sQ8XJoEcxwXVgBf4rDRzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVgRbRvX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7858a469aso12831725ad.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 01:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707383378; x=1707988178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCpdk8A8Md1t87+15YVAWFKDKY6a11dgmE/s4ip1vTM=;
        b=UVgRbRvXz0n4/cohCXquRDQ5ULHSkxNYYKgcECwhe0RnGtcI8xOF8Q7UqZqXoxQr4Z
         p9f+uj4A1OAKPdOyqhmj4u7U7w0S0Sl5+R55HHnFxBxL1oWI7omujAMN0L9FZQywZXR0
         kMm9iiF8Ar7hiqRhHt6ajFD0LD82dJrLqYvkIwOh/OkUGe0gjneuKs/mCx1a+EDhWzDv
         u2DZh9DnnNDtp/I1pAGrqLjt/e0L6KJvgA34/SukZP+JCf4q8B1yWSe9R2FZqCtgz8Aw
         lWQlGelc8vTH3MdYto1P3MDz8PDPnE4b7TvKplM5yBrBtsRAPjDOJ3+EqyYYbh4+AWIm
         oITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383378; x=1707988178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCpdk8A8Md1t87+15YVAWFKDKY6a11dgmE/s4ip1vTM=;
        b=b7MPno7YaaonY65M8RLdj/ESD6fslGkSjBMA9yyH+TyuIsd3PROKmgb338qGCsTdPt
         2IsPKOg6f0VyPLW3vIq9r07wB5juHI2GtgzB8oxaDHpu5PvzmIB7wvzhIhDbgc4pgeiE
         2tB9/9oe00rEKzVi/QrCyF0517lVn+cnIBUKg7SsUK5NlFFjFmt1unBESVDjPKsLQXaD
         XSaHV3VIv9GVcYx3SWuEctA4+JOrb8yqbQLYDUSrQ9vuV1nAelGnHEVy435nBPFKfpCy
         7FowHnzWMfQwmF7lzAwDYm30KTzsXSvnw4TgAblFY61P13UgRu8GzIUHP5Mv6vAGngPA
         w1ng==
X-Gm-Message-State: AOJu0YxGLf/xc171KxsoqoYCMy5DpFGLqn6cqy5Jto035xmTCDb1JMrQ
	SZyR7ctqOeaUVJc0NNbdQf5WJULmWoseIKzrDTg9J6MaSNGq1WCf
X-Google-Smtp-Source: AGHT+IEdzvjrujz6FgX01DHlL8gAEn5weJnMx5wxnLdUUDADYL+fTVRNKB8wMNeINVQDJoVcMY8Ijw==
X-Received: by 2002:a17:90b:20d:b0:296:a529:4d5d with SMTP id fy13-20020a17090b020d00b00296a5294d5dmr5588826pjb.39.1707383377928;
        Thu, 08 Feb 2024 01:09:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUytfFkHBfoKZ/N/IlBI9mcDCrSMxcnk5VqXR7CnbxpCzKRHNdSufLDSzto9ay16YlUplByG7F9HQfOiQo5pE37kgoUUKcL/EahAogfc+YonGVn+w+i9J0qZEysGT+vzQfi7Ox64kQUTkzQ5lJFN6IsJ3TGkheDv/j84ButBjimFSaUJY9k/fzK2jGsnSsYhL898VRlk3zwOBSnWNr686RUohC1TSxKBfQR3d+DzC8ZvfgrXMFqErnAUv6ZxE2gELTDTRPdDwjrUPE4F5SdkqWs/7azLr2ToJeIHWU0AkL1xiFegGnHB72lve/JvqIRs892xu4fz7aL+lk+wyEH3Odxo+9LKloSLNo9J4l1f0v1WzfIvjzSwu1uFxV7gJlndVI0iMtePrxIxp6tJBpMkdUPEpw93U6pKX/KUhd0
Received: from localhost.localdomain ([39.144.103.18])
        by smtp.gmail.com with ESMTPSA id gg18-20020a17090b0a1200b0029685873233sm952361pjb.45.2024.02.08.01.09.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2024 01:09:37 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next 1/3] bpf: Fix an issue due to uninitialized bpf_iter_task
Date: Thu,  8 Feb 2024 17:09:04 +0800
Message-Id: <20240208090906.56337-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240208090906.56337-1-laoar.shao@gmail.com>
References: <20240208090906.56337-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failure to initialize it->pos, coupled with the presence of an invalid
value in the flags variable, can lead to it->pos referencing an invalid
task, potentially resulting in a kernel panic. To mitigate this risk, it's
crucial to ensure proper initialization of it->pos to 0. 

Fixes: c68a78ffe2cb ("bpf: Introduce task open coded iterator kfuncs")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/bpf/task_iter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index e5c3500443c6..ec4e97c61eef 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -978,6 +978,8 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
 					__alignof__(struct bpf_iter_task));
 
+	kit->pos = NULL;
+
 	switch (flags) {
 	case BPF_TASK_ITER_ALL_THREADS:
 	case BPF_TASK_ITER_ALL_PROCS:
-- 
2.39.1


