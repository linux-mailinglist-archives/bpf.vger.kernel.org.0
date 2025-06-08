Return-Path: <bpf+bounces-60002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16909AD1172
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 09:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDB9188A8EB
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E861F30A2;
	Sun,  8 Jun 2025 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLY+0sCD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1DF1632C8
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749368156; cv=none; b=kj7r9+peJexEhZdrEIcK4U+EYi5m+kaxifihV/mwoi7he+HdObP49xZP8rTC2HX93jKWMChakDoFKeSf17zCuDRZ8gNWdgguNjEFJqGJkCxPMVobzzVu3FVUuoXQXs4mj6STWWkucHZPwZf0McD6iIj5amyPgJuCr13ERrGvT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749368156; c=relaxed/simple;
	bh=rGM8S+KtjDHJ3oXJ0MfXfz4vwWsPE5xJR3L9YgE4I/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SwNn87XC03tVaHLoLvgUnk7fBh0zvJoxd817gq/QMYtHD9nk3r9U4i0xKhDFfMLE2ttEwkIUoQ2xL5ZngYFNkFsAeYv1ek1Iahqa7j09kDZBEO15vOCJAZtfWunOu1LRD06OqluEf678G9tPfatPd+mTz/BK2lQS1/b/DLhNdd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLY+0sCD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30e8feb1886so3861662a91.0
        for <bpf@vger.kernel.org>; Sun, 08 Jun 2025 00:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749368154; x=1749972954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82yaegHLFsASqj+XWM49q+aOIMcpndoHXnjQ9vsc/ZI=;
        b=KLY+0sCDFUl6kN3YrRG+EoHuTHA3RZ7do4dk76uk+EKgEIT2e7mkKFofI6Ih4Fdg14
         4yB5as6unjdBQsEZFXutwfgyb+A0O6D02c4QlBI3H6DENUkAebS4XV1OzmtvpdEyOJjN
         2/d8d5uYmQZ0ojIUG9Z3yRzdhwwekqgQ2Nui/jLEFwsVzZbArQMTA9mWOhQJZ7yWdSYh
         i/k7VEa7NOOf43gb1b4w/eCe+OZAFk+82LH++KTafAEK0bd60+ysqVNf+YRZogj0CCfC
         PG4JVqs1KJSvdpUpv29kwnaDKT7RSnkPKnhqXIv9z5kZyeVupoFjiQ5yq34q/yKAV146
         XaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749368154; x=1749972954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82yaegHLFsASqj+XWM49q+aOIMcpndoHXnjQ9vsc/ZI=;
        b=lzLFlj25KksjojA/NWKPZ3d0zK+D9ElYK0K9NQorrdAG8+bOL1uYYi8CfY0mTDrNLS
         3gVz8oOMiNwp75PYBaP4JKbx2BZNvUy5xqdgSAXWJmU/Y6GKuTExGOqZ8XE7uU5PZu94
         Y7vpIm4MzvpVoHvMsAszPY0mETe/6G0jvMGEGFs3PCrcPsVUZAKC1UaA3woRlbaXeb2w
         gKNpilsxp0LAZ5S38rWIuep1kIJgEVRh13r/PzTH7NdCRQKoVf38Hqthqmvi0yvcSL/V
         VF3gM/0kDKT0jd/iiJZ+Vi2uNRaD3LoCjE7p3FuihtDWdoUUNrY03+E4ASJ8yIkjs3rf
         sORQ==
X-Gm-Message-State: AOJu0YyTAJN1x7BgdiZwIHTQ7t1hGrjiX5k1h8tU0DJ0cgFqrehmUFN0
	s9bs+22plF7OdTQFq6k52/klOrrv5AzRawB6z5NFvY7CzNoevXXekpys
X-Gm-Gg: ASbGncs9pF+Em8DRLf5baqyex1q2JMWBBxQvO62oIV0wBK/EuDZmG2jWW00B2fcqWX6
	a2Dof5qlmFkdzjrhfW1hjDDDWRM8AEFBGUVNgb+fKlMDKulc6+J09imKvaF80H2wP2JIO+/U9A0
	FoRyWeWGKGAD0BpOF9lXzNrZ4mREL+Di8OTpUcrjdVqCnbgUTvjAJmlUTSmW5XecsQCsGAdChJQ
	YdD6AUMNKVKUQ5IwYD+pNzDqySt0AAc+IBgjfO0vBxT+FxAEW5oAJSpQn/cnB4AXvR/4MkXYvNj
	fnP1NuXS1kUfWHAVHWPMjtGyN+R260HWu3DEd5fGjINNzSwjyv/n4gnHC6lwkueFGihITKKbtuY
	deaNmRmYdwQ==
X-Google-Smtp-Source: AGHT+IGWcgoM5g+uaSjhejGmxbyBd1a7vW+yi1SrD1CvD8JQ9hesATBeS6/eofhl8xl3rJpbpjfqiA==
X-Received: by 2002:a17:90b:2252:b0:311:f684:d3cd with SMTP id 98e67ed59e1d1-313472fcd3dmr16524290a91.12.1749368154162;
        Sun, 08 Jun 2025 00:35:54 -0700 (PDT)
Received: from localhost.localdomain ([39.144.124.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236035069c3sm35968135ad.234.2025.06.08.00.35.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Jun 2025 00:35:53 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 1/5] mm, thp: use __thp_vma_allowable_orders() in khugepaged_enter_vma()
Date: Sun,  8 Jun 2025 15:35:12 +0800
Message-Id: <20250608073516.22415-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250608073516.22415-1-laoar.shao@gmail.com>
References: <20250608073516.22415-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The order has already been validated in hugepage_pmd_enabled(), so there's
no need to recheck it in thp_vma_allowable_orders().

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/khugepaged.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 15203ea7d007..79e208999ddb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -474,8 +474,8 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    hugepage_pmd_enabled()) {
-		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
-					    PMD_ORDER))
+		if (__thp_vma_allowable_orders(vma, vm_flags, TVA_ENFORCE_SYSFS,
+					       BIT(PMD_ORDER)))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
-- 
2.43.5


