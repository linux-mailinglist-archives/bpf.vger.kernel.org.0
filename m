Return-Path: <bpf+bounces-71076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D828BE1B29
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 08:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE1B434E3F1
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 06:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53262D3EC7;
	Thu, 16 Oct 2025 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3zkFoM3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4D2D24B8
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595823; cv=none; b=R+NyZA/HoXXvHB/zmtC7m62CVd9pTIEK0RJhMpL7DhZexo60hCjO58AdLCp4UNHxp4ts0g4baNh8YIVX+YtcisYPZp12FNA31ANR5v7Hx0DCEnYE4uajoCCtDs04SR2VmUzt6TnZRKRnmJ48trAXO0PsBXFj1OGdy5pnYmFDnFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595823; c=relaxed/simple;
	bh=1yA5Zh9DdGmSILwFbPdKZuK0GEFPB0N9Qeq29UXFHko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N6gtqp3BsDoBvGoRP95S8Fta69/wOoNo9IWFKd1zwQpa+pnfPov2qR8a4jyUVjazfyZnr+pepUWezUnOORDEhZT1K8yPEjFPtpjlEK7n7UsyI3PuWFY8Ff2SEszxH+ykf6mGBWXjsD76Dy1dsLVqoznSr8FVyhw601znLxXKGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3zkFoM3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso217567a12.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 23:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760595821; x=1761200621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rtz4T4SjgmeKV/qWrmLOJIqNyfr2IlgLxgCwE5prVBY=;
        b=a3zkFoM3j00+R8XQK94yhWyOl+UzKjAoA/+pjJHtmHISkVvR9LDQTlwa5yJjXqDALg
         70U4q0+cvG2ZXdGM1DbxKoRQovadgtN+JpKSVQTqBo/l/4S0/KneZ6BKuJEltaD+XRF6
         y+vBhO6YlixTJKqTUGNwAh3VWDMYjjrwiFRsamiJoJtG8oD80H9peQfPY8VR9t9P8Lzc
         7liLhVdiPqS4FMXXGH7NgXAfsJNzpcs8/PdM5r83jjFoVtsvRC9rBhewP9lyoh36LEYx
         HLHDHG4JaEXB+BUcYDRiUuZs+SwD8gzN3SMc5Ew4AmhvQHdD26sDuuEKE7aDhT22zSqt
         X6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760595821; x=1761200621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtz4T4SjgmeKV/qWrmLOJIqNyfr2IlgLxgCwE5prVBY=;
        b=gl8ZmJMGQ2dGMvw3z7Nxz5V1UxsRKREfOL+Mlk0Mp5xzaLAKZOlWx4YMSdZLzdL+a4
         ajMuPtbTu8pN0G+NnwLFq6DQi74jGoHlhQZxtMZWRXKmsgoRFtkiw44T/Le+d+3ugRDp
         uKGdFLRCPSWDjBCs7xUrYLIh3Zc0mgnFMGh+sITNe4WuHS0J8fFc6KtHn+jZQUxnTSLw
         lkiU8kqnStc1PPWw4sZJTG6XprM80UaHTOWHJhcLHbA2CrDxBZpivzV0veu7z0tfYlpJ
         wFpMYZDtjHWUOOtvGhs3gq8izOheK/zCWb43D2kKkI8kTCbiyqYJWQlO73jmQikY6uOc
         1OtA==
X-Gm-Message-State: AOJu0YydG312hp8S9Shzdm1LnKQlGCTGvxfbKFlom6MPa4miww+YpvFq
	Xc7jXMeMcCUbpdOH7ni1N98xfl4xsk/7HZIClmN5eFWcvaZUNiRTxIk5+1KIgw==
X-Gm-Gg: ASbGncv0LaWBnjwUVa3CGf+1qGoUTXI+j3IERDJqHPPGWyJC6NAgOGXZ7ZSVnagSeVG
	H73btA2Pm1imudXP1f0LCN8RkhATwpg9G1W5gJ8xCajqftRCPIHMvD5CEwfcEdfvNvVDyoi6hMT
	dxZk4VIL9iPnclVSzDVCpjETH/mRAkH45W4j9YICdFN0SkD505dyEDqhqys+7o4S4CAbiwWN5Iu
	RK1C0qIz44TPROiB/5E1APO+W1mygpxKZFqCMqX49a0Zpf9tUFGw84MeTPL0vykHFE7CqhdUxzB
	D9ihRCqH9GwHN57nxdH3ONvvq2mlUuXDdR+cOX9ITM629rIlJeki4V6/6xY3DABkCmd84qHofDp
	7DEMYjvGd/DhR0pqdc9hEmRMPIIhnxZKMfECzSd8UvXkb/hmG4qHhPRgcOFLmrG1CvcPsM32jqg
	==
X-Google-Smtp-Source: AGHT+IESwFxAIpSSFqLrdEoZVFaRmiySvBkUcf3ONhBLBd1nvcSQxMrGDfjW6hnuWXn+BxA9v7huaQ==
X-Received: by 2002:a17:903:320b:b0:290:6b30:fb3 with SMTP id d9443c01a7336-2906b301035mr187621375ad.16.1760595820600;
        Wed, 15 Oct 2025 23:23:40 -0700 (PDT)
Received: from Shardul.. ([223.185.43.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099aba4f5sm16922655ad.91.2025.10.15.23.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 23:23:39 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: bpf@vger.kernel.org
Cc: shardulsb08@gmail.com
Subject: [PATCH bpf 1/1] bpf: Fix memory leak in __lookup_instance error path
Date: Thu, 16 Oct 2025 11:53:34 +0530
Message-Id: <20251016062334.4102324-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When __lookup_instance() allocates a func_instance structure but fails
to allocate the must_write_set array, it returns an error without freeing
the previously allocated func_instance. This causes a memory leak of 192
bytes (sizeof(struct func_instance)) each time this error path is triggered.

Fix by freeing 'result' on must_write_set allocation failure.

Fixes: b3698c356ad9 ("bpf: callchain sensitive stack liveness tracking using CFG")
Reported-by: BPF Runtime Fuzzer (BRF)
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---
 kernel/bpf/liveness.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 3c611aba7f52..1e6538f59a78 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -195,8 +195,10 @@ static struct func_instance *__lookup_instance(struct bpf_verifier_env *env,
 		return ERR_PTR(-ENOMEM);
 	result->must_write_set = kvcalloc(subprog_sz, sizeof(*result->must_write_set),
 					  GFP_KERNEL_ACCOUNT);
-	if (!result->must_write_set)
+	if (!result->must_write_set) {
+		kvfree(result);
 		return ERR_PTR(-ENOMEM);
+	}
 	memcpy(&result->callchain, callchain, sizeof(*callchain));
 	result->insn_cnt = subprog_sz;
 	hash_add(liveness->func_instances, &result->hl_node, key);
-- 
2.34.1


