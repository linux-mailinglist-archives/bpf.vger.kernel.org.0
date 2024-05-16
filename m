Return-Path: <bpf+bounces-29839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D978C7202
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 09:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4A61C21543
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 07:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE91F3E470;
	Thu, 16 May 2024 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqc/wdnS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532C18027;
	Thu, 16 May 2024 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844294; cv=none; b=qizqxXD4gJzG4i7OW2JOIwLDIk4fPvK9LXUP3BN+kot2SbtGX54/KOS9PJCRadCq6cW/4GfCBln9w85SvtPJ5+D0gee3WgusDkUrzJSfUsT8WGbSVGQ4BPQqp6wo3/BhI2lYIJS/FwN39w8ZyVqMtvA1tfDxFIKTNkvcg7v4fYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844294; c=relaxed/simple;
	bh=g9492Twcc0ahr7Jf/C3czdRqWylDYeDZbT/BFWNKY8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LI9YMhb3HW/LaPq2mEdOZXxYEoDDMnr2V+DTVIE89PkGFXHifd6c6brkZEwgeMLHovymmZwGnJDXYMJoW6Asf5fpFin6XLS2S+iwTGww+O3EVx3ZCr/77L4yxlOqS6Yvixqgi/LStOcGu0B3HxAAkBau+596C8iVI9dC1T7xRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqc/wdnS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4178aec15so6677636b3a.0;
        Thu, 16 May 2024 00:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715844292; x=1716449092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=msB0+W4DryTLkvamOtMiiyMFoOqzx8rr6TQbHpCIY2U=;
        b=Lqc/wdnSmzgFK43MvUCMW98WGze42YhnSld2eOMyo/PQhkDt4skdA17ja8kCH+kovd
         wD5FNc2lRZf+DuTWWYylRbT/L0AujU7GWZ/Jaw0RAVKmnwvuFAasMBSRp7L8SuKRuW7e
         rExDE/nYjYHqpqWq6T/KZsZSxOUdXb5mz7SBOuHmM+PadRBDZx0NXP+DsXyZmyRtshZf
         nUYOoba0T0kv1ZMMviYj965ztZc05DNLjbPONtjx+8O25GHiyMJX4w8ar3t2mDLG7iqN
         XkxGWAQ9fJpIWswvVjFEyM+CWqFoANWSqAKdBrldPejiuJRqq3nNJylD/4rlKwn5cQJM
         hlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715844292; x=1716449092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msB0+W4DryTLkvamOtMiiyMFoOqzx8rr6TQbHpCIY2U=;
        b=Q5zD6uH5vvltWeRXqxk8gPUcCemQYl5TQHKvf1MWfsK7LPsZtg0ibs/S198TJDhLYM
         AplEw3FUn9swt6nmAtRJMeGkxL0u+wUduKXDrd55kyfHNQ4dLtYgY6pW6dVzk68GJ/su
         vJf68dgS/nPbLiJ4v296eNT9+oQj9gPBwH5CpSgmMy9x7QXPYvRx5LNtZexnVrWGrG+f
         NOcosgk6dA0ibXCdtlatwwOSpbCZoPy2Xbeuk9x90TQzIR06niNUMJrZ5/pmPfuviF45
         KfY7rrRybcI2j7wRXkU1uBFFJHfOzFNTa/Ooh2qY++6outm3Sx/Eyylwzp7/QCY5W2IA
         VCMw==
X-Forwarded-Encrypted: i=1; AJvYcCX6OeCpi3Dtf+q03mDCA01/bCFBGWT3vEn92vSd7sLTVMJVNWFUA1PRU2jTDayObhYFpRYqlSBAsxDaBJj3Apw58rL5N4LydyrBNEHNlT1MDPgmEu28DjKJEPciGtiuWoRR
X-Gm-Message-State: AOJu0YzcGznvwu3JMxSYn707pGs3N0VmJodzSPE8c3wPojqP2BE9b26W
	tpBMRSd/XWRMqVdp/rkHS6LIWfpVGMtSN2lMpDenC4B9bgoJPj7B
X-Google-Smtp-Source: AGHT+IGnb4XKQOd5DKRd2XUCtzRqidFYGUFwEF1188FQvmEFgBR+8SubBV94y6j7Bg8YtQtrquUHPg==
X-Received: by 2002:a05:6a00:3c83:b0:6ea:950f:7d29 with SMTP id d2e1a72fcca58-6f4e02d36c2mr19464582b3a.20.1715844292282;
        Thu, 16 May 2024 00:24:52 -0700 (PDT)
Received: from localhost ([2405:201:a42a:e93e:5cb4:f88c:4291:d698])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-6f4d2aa16dfsm12652677b3a.93.2024.05.16.00.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 00:24:52 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: fix order of args in call to bpf_map_kvcalloc
Date: Thu, 16 May 2024 12:54:11 +0530
Message-ID: <20240516072411.42016-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original function call passed size of smap->bucket before the number of
buckets which raises the error 'calloc-transposed-args' on compilation.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 976cb258a0ed..c938dea5ddbf 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -782,8 +782,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	nbuckets = max_t(u32, 2, nbuckets);
 	smap->bucket_log = ilog2(nbuckets);
 
-	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
-					 nbuckets, GFP_USER | __GFP_NOWARN);
+	smap->buckets = bpf_map_kvcalloc(&smap->map, nbuckets,
+					 sizeof(*smap->buckets), GFP_USER | __GFP_NOWARN);
 	if (!smap->buckets) {
 		err = -ENOMEM;
 		goto free_smap;
-- 
2.45.1


