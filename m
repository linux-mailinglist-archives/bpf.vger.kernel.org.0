Return-Path: <bpf+bounces-23099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302C86D7FA
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 00:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C28928665F
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 23:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0E313441C;
	Thu, 29 Feb 2024 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzm8uZVv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F37C09C
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250209; cv=none; b=rWZnkt7z5Jrx7RwroxdQxl5HfUanbxNc/EZREATzSEW7HegBhjuzEAjYjVy4+kDsa2OXGMcFS2eMDkqEImqV0RBDyjc4IQXuFBlKLJuMiS3keRqvcf8ldY4EN4DxwFc3eFO3uZna4qzzP6yQ1bQwV7ZjSfj05fH9JjE/dD6JSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250209; c=relaxed/simple;
	bh=8A8sSzqikDI5zItHYVtxdTIyovaCr/fwt3cOFvUl0jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HUpa0peD7Zl+IN+bMLTUQIBizZKGB7EQDsVfRKa/BVDelXklJ8s05RbwzAE0uj9960KU1ONCfhVb8QntmaO4Qob80V07M8Ks6OWjXgUGSMPyBkcplLAT7aGOuDBmTaDFWUcR8Wyi1S6y7q9mku074MwzpS0cHUJcb6wqVCfDV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzm8uZVv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc09556599so14088385ad.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709250207; x=1709855007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYaENkYQ4G5HZw66zLSCBAz4c9QdNSpOW86RMIeSYNk=;
        b=gzm8uZVvdzRqmUbzLjElAUQi2OvhNV9qjo23tVc9iTBnBGsx34FlA8NHBTPihQwKqY
         KXu00QKSDc0WQva6/X1SbmKFo4oseqeAH3ReiCJnlImKC5NN8kLcv4DfS8F36pL/aJMP
         jHqa0wRYT6MJMY13nxr7paHKhg8kQN1S/zlndFxMHcp1wMHWIsRjPw90Jrl6xp88fVbA
         uvrDviax9ARyqFgl51U5FF34t8ULDWEaQ/lZMSSnXFiBT7g3SdSp2dIuefBytH+DhZOM
         HIMYTVWuo611MF4EdZg/h1fM3RjjvAzqj/WTEamutro+7xoMJeVWLrhR7gc7aTJlNk9k
         Xsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709250207; x=1709855007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYaENkYQ4G5HZw66zLSCBAz4c9QdNSpOW86RMIeSYNk=;
        b=Ewrlr0wRWGojRBtk8SP+kzG5hkUKL7AfpiEl982MhH2GQJhBA6W2Tx60me8BS1JdLv
         WPTuxxdOT9o8T4twNIicRwE3S6Bpy6+KIcOGbrsFix3U3rW2dJK1acU63SkBdEBkfCdF
         Qi/oU4N+DEAHp4RKKRspPeDB291d1GgMyDmcGbHl5Ca1/Mgo4PYIsf0WYXnaZANO+TAE
         wd5mak9eNt9RC82HVHsI3unbcWSfZpmRwQYOd+m+6VvW2QTuKH8ypZbodAhqea0HFnwk
         NdD+z7V/UZxUnx3HbweFO2eFeBLyYd2F62UaQjKCyhnvk49Ry82GuzvuC8JoEO5rmhiC
         N4IQ==
X-Gm-Message-State: AOJu0YyOxX0z1eW9FdXbvezInHBjmMLXAsuOuOYtS7LNSNYHEqOFb9I7
	atT+AVrjLKsbv1Jp0aUOM3cv1FZ9jXi0qFPZiFC+IO5oS2hOfch6BDV9kwCa
X-Google-Smtp-Source: AGHT+IGkWYefSAJiD6V3UAHJP4h3dcMjAtD7ol2bRxxY1LAVjzWJTomMlC/1P8AOvCsvxgL62Mpd0g==
X-Received: by 2002:a17:902:6847:b0:1dc:8790:6824 with SMTP id f7-20020a170902684700b001dc87906824mr50051pln.15.1709250204830;
        Thu, 29 Feb 2024 15:43:24 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090301cc00b001d90a67e10bsm2081312plh.109.2024.02.29.15.43.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Feb 2024 15:43:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	boris.ostrovsky@oracle.com,
	sstabellini@kernel.org,
	jgross@suse.com,
	linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 1/3] mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
Date: Thu, 29 Feb 2024 15:43:14 -0800
Message-Id: <20240229234316.44409-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240229234316.44409-1-alexei.starovoitov@gmail.com>
References: <20240229234316.44409-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

There are various users of get_vm_area() + ioremap_page_range() APIs.
Enforce that get_vm_area() was requested as VM_IOREMAP type and range
passed to ioremap_page_range() matches created vm_area to avoid
accidentally ioremap-ing into wrong address range.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/vmalloc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..f42f98a127d5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -307,8 +307,21 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
 int ioremap_page_range(unsigned long addr, unsigned long end,
 		phys_addr_t phys_addr, pgprot_t prot)
 {
+	struct vm_struct *area;
 	int err;
 
+	area = find_vm_area((void *)addr);
+	if (!area || !(area->flags & VM_IOREMAP)) {
+		WARN_ONCE(1, "vm_area at addr %lx is not marked as VM_IOREMAP\n", addr);
+		return -EINVAL;
+	}
+	if (addr != (unsigned long)area->addr ||
+	    (void *)end != area->addr + get_vm_area_size(area)) {
+		WARN_ONCE(1, "ioremap request [%lx,%lx) doesn't match vm_area [%lx, %lx)\n",
+			  addr, end, (long)area->addr,
+			  (long)area->addr + get_vm_area_size(area));
+		return -ERANGE;
+	}
 	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
 				 ioremap_max_page_shift);
 	flush_cache_vmap(addr, end);
-- 
2.34.1


