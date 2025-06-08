Return-Path: <bpf+bounces-60003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA80AD1173
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 09:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2ED16A037
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649DC1F30A2;
	Sun,  8 Jun 2025 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wyp1O08J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C681DFFD
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749368166; cv=none; b=kTA2r+PobG/kL8uAPVkQ5zyT05CKJ7+jvhKut9lSFKrh7Izit/F65OSh7ngI7mL1ZQPwods6lz92LSOd1W7wCzpkbZix7JtZdFZFxoTha9IsM5T1uLIGixM0Lb98nnorC72lYfxKFPcoB3vN6JzgrbS0AruG8fn4939aRH8aAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749368166; c=relaxed/simple;
	bh=kuO86Qb2mBYkhGrJ5FUXentDLhGD+Im6pm61VBWoarI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvEnTKVrVIg7c4eSEH7F1E101tlWk15OEryE6xwds5AOl1toYRW+ukBQef6xVl2ne1rzaBa+1h6POPuP9kwD8JDnLAr+R4qUhE1WrFmsaJrqB9j4pztEFqqDzLWx+m6HW+YfxMa3zL4jvAwArfT4d2hPq9FlBwc86oYGTgIPJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wyp1O08J; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso3492473a91.3
        for <bpf@vger.kernel.org>; Sun, 08 Jun 2025 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749368164; x=1749972964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2m628NYrP7USTIcryjRKrSA3KXDWhbORH7j8zE/N/s=;
        b=Wyp1O08JX72e21syoh325TluNfRnRygDT0WFNIubtGAlfGCpb8bKgTQzPvoZNtk20H
         9lUwLZJA7Hnrx+jJD4dYcQQm7kbp9bmLOmOVeAfahELDy19+mtYK2OpkoYfvSRAXSYPS
         nF9C09gadIhOP6RA5W9kS8aSIYvJCx/lOLnQIl0u4cSK98wyVUlMdjK7VEF4CcXPS2gD
         WXvCQUZ/ekXLVIlmbmnyYn3u4RU2522U1xwHjYl2eYoXykP3i8H0dHiiAzn3GNyKplfM
         qv7rI5NEWiGgzquAMvzSrVqq2z0zx1qUtp0IymSVJm3d2TUfkJb8nHj05uNyMJaeZE9x
         tELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749368164; x=1749972964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2m628NYrP7USTIcryjRKrSA3KXDWhbORH7j8zE/N/s=;
        b=gNvFjqusBFg1YkxD5tUXCHS5pRIgGVEr0ZpPOaUDliUVhO7ScGFf4hYtgQqzYo/eYs
         aIT38wvgHV33Xv8Jww6Z9mpja+okM1/ynCzIWMmHMgCovzfVDQvbCqmFZ68PfYHHY8c5
         V/PpZN8zlYTFiD7KeRh26W+epF4j9ObtEZN549NhjEgbKLFdBQJt4Kki/QmnbzOBzur8
         tn/RxXfUBe+f7OH68V8yCQF30ickNBfpFV1SMBueNDw4pZdotredJ9N/f4A+/wPuJJJ5
         C3Vsn5nPAjilhEMI/YbNAMv9XItINs8chPzGCcJErZCpVYa+ey39C7AzPWMA6jA7+6PD
         fDPw==
X-Gm-Message-State: AOJu0YxjkRwfW4ltImFN2uotkVYbncXa+Z0ybk5nHHxIbg9e3lvPv4qu
	FKCmhjNZ6th9qqC30sKnfhFHC5JjwkGQi6tYXRBQbFqcoxuyrc06z65P
X-Gm-Gg: ASbGnctSVUDDkN9svjCA+XsWmIurTPxJx/NosQqx6Yz0X3EDYVqJEW7GpPqctcAlOmA
	v4cWpxyCPxrHQ+iu0FxyUbsL4xLO+Fp/QIQPsOJUY3thkkCO5e15id1kbWqcisUOlRBVot1sxAf
	iHOQF64bvsCY9BQEnF4jEbZK1UAHyZpC1OjQvUPs6FbZ4HJP5PEt3zFLBxEzU0wdRlqeeXcjHq/
	xhM6SbLepmzoaDvwGwW6w2YLxNY4kgk8Zd4zAGaKENcLi5B8AsLjWzjSZBa7FJCjRRLhyN0dxcZ
	IL65ERgPmOcath4B/hbfczpHAsctvZZE6uylmPC1hlAdZLA7eM5o2XDU9RYx+apuSreKet6TfD8
	=
X-Google-Smtp-Source: AGHT+IGNlJjZXRHFKsukMRnZe4/RiXJmtnS9pDsYAYC3f8MfhRJ3P/eOKaJdQ4DAhSE0zMuC8S4p5A==
X-Received: by 2002:a17:90b:52c6:b0:311:c939:c859 with SMTP id 98e67ed59e1d1-3134769fcdfmr12921231a91.30.1749368163775;
        Sun, 08 Jun 2025 00:36:03 -0700 (PDT)
Received: from localhost.localdomain ([39.144.124.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236035069c3sm35968135ad.234.2025.06.08.00.35.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Jun 2025 00:36:03 -0700 (PDT)
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
Subject: [RFC PATCH v3 2/5] mm, thp: add bpf thp hook to determine thp allocator
Date: Sun,  8 Jun 2025 15:35:13 +0800
Message-Id: <20250608073516.22415-3-laoar.shao@gmail.com>
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

A new hook bpf_thp_allocator() is added to determine if the THP is
allocated by khugepaged or by the current task.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/huge_mm.h | 10 ++++++++++
 mm/khugepaged.c         |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2f190c90192d..db2eadd3f65b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -190,6 +190,14 @@ static inline bool hugepage_global_always(void)
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }
 
+#define THP_ALLOC_KHUGEPAGED (1 << 1)
+#define THP_ALLOC_CURRENT (1 << 2)
+static inline int bpf_thp_allocator(unsigned long vm_flags,
+				     unsigned long tva_flags)
+{
+	return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
+}
+
 static inline int highest_order(unsigned long orders)
 {
 	return fls_long(orders) - 1;
@@ -290,6 +298,8 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
 		unsigned long mask = READ_ONCE(huge_anon_orders_always);
 
+		if (!(bpf_thp_allocator(vm_flags, tva_flags) & THP_ALLOC_CURRENT))
+			return 0;
 		if (vm_flags & VM_HUGEPAGE)
 			mask |= READ_ONCE(huge_anon_orders_madvise);
 		if (hugepage_global_always() ||
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 79e208999ddb..18f800fe7335 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -472,6 +472,8 @@ void __khugepaged_enter(struct mm_struct *mm)
 void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  unsigned long vm_flags)
 {
+	if (!(bpf_thp_allocator(vm_flags, 0) & THP_ALLOC_KHUGEPAGED))
+		return;
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    hugepage_pmd_enabled()) {
 		if (__thp_vma_allowable_orders(vma, vm_flags, TVA_ENFORCE_SYSFS,
-- 
2.43.5


