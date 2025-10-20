Return-Path: <bpf+bounces-71340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA96BEF2B5
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 05:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76BE84EA8C0
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 03:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B6B29E117;
	Mon, 20 Oct 2025 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOc1vDfJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F9280A52
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930233; cv=none; b=E2xQUj9sGL5Kf0drM+llVy5WuapLqozeso2tcNlxfegodUEBsYPX8QKCZLr2rBmHDN4KihMNJAt/7O6Galjyd8pMTLzZs7Nu0IJiRbSry/ZCvLyih864D8/5x8keYh7UhcjxHeCLd5ZxmtHzZahATcxct+ZiIPhIUM/EiqJ+Gzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930233; c=relaxed/simple;
	bh=Qv1HG9au83J7guckWop8/cgavdJDTQcWIQGKLivyPZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dQeK9A1b2Mggw8L+1Kd7/WOSY0LtJV3PB5xwe+2UxCT66++Fc1cBz+LZW1/jyadYGZJ4OEaHPRlp26/e4zIoqI2pVBfLp/PgRRLsP0SaENL4bZ2cR/Z0jVmg4yZIs80YdHn+l2O2R7lDSYiXNVRkonWv07pAqqn6J38nkbAycM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOc1vDfJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3264061a12.3
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760930230; x=1761535030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGks2sOnnpNLPiQkQk5TdavZHCtfoEFSojg02a8VBgI=;
        b=BOc1vDfJwcdTWnQSl8wErjdt58QEu9d4A4uuWo+Yj9/iecarzaTVNQxe/TSfIk4JX+
         Mk90NQ9WHNRtHT+JYsKxeF6YaKhH0YVOW+o/DIRRAMqwYocl8fBdbaUtSMm0tKmUVS7K
         PV9/XDO+Ac0F8UrdEzAaw5l9ZAnfgs8hkwBlsj/ifiXEAMUe/F8gS/RZdj99qbQD60S2
         bLXFFn6vKRMA59T/b5BQb9s/hTzMzxTZKNY0c1irKjiyXQ4JeN6/9bouexEh4M2+no0j
         Lp96QaVg6dgGHwHRMyF7gB0g96WVcsKyk+gZaptHfOL4TceHZ4Hg40CuqgmxcenhI7Tc
         sSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760930230; x=1761535030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGks2sOnnpNLPiQkQk5TdavZHCtfoEFSojg02a8VBgI=;
        b=pbdo9VfDocLjDzfcRdy4axatoMmN34xbCn0xQ4hkfm4Me8vhHn+mwD8XReXmaNYzC/
         Ptie0ZQSGylmSiPOr+PPPenQ7+aQOAA+rbTMr9gf92wvzBJXpkczBuY/VTgr7kFwh86b
         F9bzfnCj3f13Y+NXLhHj5QxZJjoqpiw1W+vFT1ldZPVPuOn2Rp0Rvv5nwBlZUjAdE7y5
         VuuP/p01aaVnCbmaxm0nvZxPO6ftUtE7NtYBYgGAyybPMum//keyGDTalIWsiV6HEp5j
         VwOj0FmL4hIg2qizcEL73QyDMbiX5QEjeZqg4PT2oPtSfAaWwHXO3Iz9k7T7Uq1FAk6B
         IhTQ==
X-Gm-Message-State: AOJu0Yxp3qLV5aL05tBepxQKL9DsR68ofeU1n8eOd6BVGcnQLe6R7Uq4
	T3Qpjq9bMKXUcDaaY1O79rlYXWqLck5muRSJJOEn3cXKYO3ZjFk85YZI
X-Gm-Gg: ASbGncvWXscxmTy1UBHEm7YJhGbgITLUamIwPXrbGMF31Y6km75aiReVhsYSngRSwNx
	a48rtWZGa5n+wL+lZdCYAtz8ulkHnzrkRGJ1HYoP3NciCUH+JCXjC+oFLpYn5Nd9yo9XNU+M04O
	zLGKYqNoaFDUxnmsW4o/jZ5hdapuibEAI3x9KRX1YA0A8Ds20eGbTnYJT0RfUCcEJ4g/BnrQrbd
	e7hPnAjnDux4XWzygf36GRrq5/gQG6t2aBZVXz8FZUPXU4XG5JE55MSA11uhmMaSIaP3tdO3nHP
	3XiRieRgRuszU2Q47jGtyMzMr47rF4qECCXnO04m/72jkUvWEZvERtWjPl77tk+Em0OIgvCd270
	eRuXxpr3tVJlTZwRDW+kCbNOUEu8IaJmPNRfDTVEEyUGDqqqDu0O9VRD52umRtqknFgQ4E+GnI9
	HGPQFjQGojJOVrN+gHzJ1GZN3wYobc2k93gpLrhcSF61rAbQ==
X-Google-Smtp-Source: AGHT+IHgkWxUzoUUp0gWSk3OAPdv3h9UX6IroOzlUnb1eY2K5j3hSN09VNabSt60qr2F5Tmrcms9KQ==
X-Received: by 2002:a17:903:41c6:b0:25d:37fc:32df with SMTP id d9443c01a7336-290cb65c914mr164540365ad.47.1760930230150;
        Sun, 19 Oct 2025 20:17:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1da1:a41d:3815:5989:6e28:9b6d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fddfesm66373435ad.88.2025.10.19.20.17.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 20:17:09 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	david@redhat.com,
	ziy@nvidia.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v11 mm-new 05/10] mm: thp: enable THP allocation exclusively through khugepaged
Date: Mon, 20 Oct 2025 11:16:50 +0800
Message-Id: <20251020031655.1093-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

khugepaged_enter_vma() ultimately invokes any attached BPF function with
the TVA_KHUGEPAGED flag set when determining whether or not to enable
khugepaged THP for a freshly faulted in VMA.

Currently, on fault, we invoke this in do_huge_pmd_anonymous_page(), as
invoked by create_huge_pmd() and only when we have already checked to
see if an allowable TVA_PAGEFAULT order is specified.

Since we might want to disallow THP on fault-in but allow it via
khugepaged, we move things around so we always attempt to enter
khugepaged upon fault.

This change is safe because:
- khugepaged operates at the MM level rather than per-VMA. The THP
  allocation might fail during page faults due to transient conditions
  (e.g., memory pressure), it is safe to add this MM to khugepaged for
  subsequent defragmentation.
- If __thp_vma_allowable_orders(TVA_PAGEFAULT) returns 0, then
  __thp_vma_allowable_orders(TVA_KHUGEPAGED) will also return 0.

While we could also extend prctl() to utilize this new policy, such a
change would require a uAPI modification to PR_SET_THP_DISABLE.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>
---
 mm/huge_memory.c |  1 -
 mm/memory.c      | 13 ++++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e105604868a5..45d13c798525 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1390,7 +1390,6 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	ret = vmf_anon_prepare(vmf);
 	if (ret)
 		return ret;
-	khugepaged_enter_vma(vma);
 
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
diff --git a/mm/memory.c b/mm/memory.c
index 7a242cb07d56..5007f7526694 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6327,11 +6327,14 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (pud_trans_unstable(vmf.pud))
 		goto retry_pud;
 
-	if (pmd_none(*vmf.pmd) &&
-	    thp_vma_allowable_order(vma, TVA_PAGEFAULT, PMD_ORDER)) {
-		ret = create_huge_pmd(&vmf);
-		if (!(ret & VM_FAULT_FALLBACK))
-			return ret;
+	if (pmd_none(*vmf.pmd)) {
+		if (vma_is_anonymous(vma))
+			khugepaged_enter_vma(vma);
+		if (thp_vma_allowable_order(vma, TVA_PAGEFAULT, PMD_ORDER)) {
+			ret = create_huge_pmd(&vmf);
+			if (!(ret & VM_FAULT_FALLBACK))
+				return ret;
+		}
 	} else {
 		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
 
-- 
2.47.3


