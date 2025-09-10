Return-Path: <bpf+bounces-67976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AA1B50BB4
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8821C64121
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6672580EE;
	Wed, 10 Sep 2025 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/ZQtwAn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C459C3FFD;
	Wed, 10 Sep 2025 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472345; cv=none; b=moqtAiU62kbgk/jAnVnmc/s3pvK3+qwQW0ht6e1Lp81DltDO85gEw5weJ6KAyzULQOCwlrtQrW4ttSRc9+N2Iq7e+26/sqiVQ4kVj8ejAenqpzNhQau80wKJPxycxmoHLCOYgHlexGLXX2KS+OrNp0YoKJYVXZepJCFOBk9APvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472345; c=relaxed/simple;
	bh=Vd2FHk1eN9pMYDRWFSk9G9i6OasTJJ9rtGn7Qu5ZNyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4SZsAmkgbTNLN5bqaEkT0Clgg6kr3jekJILqauzjYlrFbLR17X56czSzXZmwlrhL4t1dSDh59w6MW9owuJcjQQy8XT4Q+yMwgo/JaY9gpBCI1T8DpWWhH8TyA5W1Ni42SVVVa3n6mzZWkXOT12eWfx7ZSeJ0o9IFZ/lpB9bRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/ZQtwAn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32b7d165dc6so5694913a91.3;
        Tue, 09 Sep 2025 19:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472343; x=1758077143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO3gM8aH95iDkX6qv/L3rj4+V1nSK5Vf1Drqukjmutg=;
        b=g/ZQtwAnlqjgZejlCPYF1hJzRRs56hezRGiXWQXvNlSAmqnUh8l9JatpuRFMeuR3xo
         lew6lx3H/s/bX1fV2QvSM4Buy4sjPCMYCBlXkWKzgmivX4O+wZfc2HQsimx8Tf1m0MQd
         ANn0rLbXr4HkZervhq5ItbiqNk+dwnW569krTEJdjCR9ONPizCj4zJrPRcufxPClpSdM
         urTzLp/fI0bUt4tb71JXZPdGwEpSfVLAyvL7h6bwMckIiLrPenrkaECK5xy/Z9dzII1u
         PvEQYbD/3hXQLrvT+RGC4hqdFTbR1vt1dMlJOGh6GFA/NMJ3L3nx5LjPjU7rMClyqkJh
         NTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472343; x=1758077143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tO3gM8aH95iDkX6qv/L3rj4+V1nSK5Vf1Drqukjmutg=;
        b=knIoVADZSvwRhbarNLQCoHldCf9jOlB7SfnUrgclpApV+zthQWFx/WCWfpcFvr0JEP
         9Yxb9qsAu4KOHs2lmyT4Hw3Txw/juLBrfvxgvflmWwddqf35sonCShJiEYlU+qBR1Nau
         VkWMPPHv21MVyfyi9638YPl2qg8lIninupj02HZFBQhNTJu2eQ+i7EW6x74JLpkTMSNt
         qENLA4MWEKBc6L0kRJzD9yM0l2fYk0i7XNRmDjlfjICDE3eMgz3a+v4kLMEJHS3K1aza
         u9y6jfF/1HyKXMDPwb0FACFbJRnlCan5MBdGtg8TdHoq5ne7ttTdhhekMlRSGrPxQ0Cx
         0DhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPY3Dkw05m1Su0dm9WblBy4hIzMmAmDK61sfUs7CLCa8lwApXd0CHTDDrITCoOQGkwlxXG2lVPNbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymnmDOCs+yUhW/gnwZ8llKeyW4j6MCo+h3qRV0mnUdp18plf2F
	0rDSzdQMxX8uOal+muCS51iifu8ml+xxW49VZ4LiqNufrzM73kMM6ezM
X-Gm-Gg: ASbGnctvRNdteV/RAUNrafutCLZ2oc7E1Z4Z5GaQMzXxlDhDdk5GGI/8BIA2wxGBnWO
	fvN4A6C20btOxZVJ7k8XselUIRN7jqrhsf9MAr3gNYdq/PU6/x7A/M7G3Vusxnuor43xCQfu8UO
	UvR32Je/ITR9qlewSKj7/W5FrHq39/+kxu16Yq4sonviP0oxNo0V8wsPapK+MAxiSA1iP98nWMi
	9glBQfH8UA4CJEuogXzBKMy2b3j4ItE7sjDp5X7Z80SnT3BN1SmJwaSajedXvfREaBS6H1YEO7i
	PijP0R5dYwH5XYdN+RfwgDJMPPah5TYBZx98HpEWnB4Fl5aYoLZEuU46qCjo6D7q93w7f3rf1FQ
	bwP0kfm0ea7cZ4zGvbdbquhs2slKKeXLNbpQVm1KuRlJcGJlytE4c+SahL0gHt+CPegX1MMe9XO
	luPQ1I00tksfxKdA==
X-Google-Smtp-Source: AGHT+IGLHrt/+HHcQCfm9JLX/3iwkEcxPxZknY81z3v648g7WOhOZb2datUTOMB4DPHSP/I5lhyKEw==
X-Received: by 2002:a17:90b:5185:b0:32b:d851:be44 with SMTP id 98e67ed59e1d1-32d43f0b8e9mr17115914a91.11.1757472342979;
        Tue, 09 Sep 2025 19:45:42 -0700 (PDT)
Received: from localhost.localdomain ([101.82.183.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm635831a91.12.2025.09.09.19.45.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 19:45:42 -0700 (PDT)
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
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 mm-new 04/10] mm: thp: enable THP allocation exclusively through khugepaged
Date: Wed, 10 Sep 2025 10:44:41 +0800
Message-Id: <20250910024447.64788-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250910024447.64788-1-laoar.shao@gmail.com>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, THP allocation cannot be restricted to khugepaged alone while
being disabled in the page fault path. This limitation exists because
disabling THP allocation during page faults also prevents the execution of
khugepaged_enter_vma() in that path.

With the introduction of BPF, we can now implement THP policies based on
different TVA types. This patch adjusts the logic to support this new
capability.

While we could also extend prtcl() to utilize this new policy, such a
change would require a uAPI modification.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/huge_memory.c |  1 -
 mm/memory.c      | 13 ++++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 523153d21a41..1e9e7b32e2cf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1346,7 +1346,6 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	ret = vmf_anon_prepare(vmf);
 	if (ret)
 		return ret;
-	khugepaged_enter_vma(vma, vma->vm_flags);
 
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
diff --git a/mm/memory.c b/mm/memory.c
index d8819cac7930..d0609dc1e371 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6289,11 +6289,14 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (pud_trans_unstable(vmf.pud))
 		goto retry_pud;
 
-	if (pmd_none(*vmf.pmd) &&
-	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORDER)) {
-		ret = create_huge_pmd(&vmf);
-		if (!(ret & VM_FAULT_FALLBACK))
-			return ret;
+	if (pmd_none(*vmf.pmd)) {
+		if (vma_is_anonymous(vma))
+			khugepaged_enter_vma(vma, vm_flags);
+		if (thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORDER)) {
+			ret = create_huge_pmd(&vmf);
+			if (!(ret & VM_FAULT_FALLBACK))
+				return ret;
+		}
 	} else {
 		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
 
-- 
2.47.3


