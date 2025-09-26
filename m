Return-Path: <bpf+bounces-69818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF3BA32C6
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630372A828D
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890472BDC10;
	Fri, 26 Sep 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP8ZBPeR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB92BDC0C
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879290; cv=none; b=H/UpdDdFBxujwQ0UcY+T9fL6p8oQ+krdDjh2x6mEsNQHhYTw1Anla59pEiGHnrT5EvFZOt2O7B8YlNTgCoNAJvcdkDzVeK+j2ql2y3OU5QbDOn4vAkviDs50yICkXLS62jvO+1ieQPNLS45tz1G9xQWc54auUb/2ew0WouO3ME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879290; c=relaxed/simple;
	bh=CXI0qMvWqpeePDr4xBG9e2uqemr9IpjeVUqDleKN93I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YfGxcw2ZIfcSxD66VCNm+OPV2tJgKzQT/+0a7LhvjL7gVBkP52n67SKRmVjSEZodpR9UJNGdY9PTYU6+LaoD4J+1Up5wtHc0xc/eh9vZsP3cbbvjZBrHIFsTkbOcOHTgaOdiOSUOBcbIeHfOQogTv/fH+B5n40JAJUAqFZBDl9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP8ZBPeR; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5579235200so1442890a12.3
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879288; x=1759484088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOprrquoKlbkEreJojZ4KykFg8G0TswcVk79ghRz+Tk=;
        b=DP8ZBPeR5oR1hon/YL568Z773lSOyxCG4Z+gZ1kHN0RH4xkQ6MEp6q4BSo9DC2Q/R4
         IXhE2EY/ogG6D1MV1CeWxmoVWyZMv5j0X1xq708K0wC80ly1w+mBMn24k6ARY5v1CrKr
         XR8NYrFaelqnSyv8jIE46QvZ4FVfYm2V1CgT1xvAGjKaNSc501uTFbiNCVmMeoZsWK9u
         M5hC2gJxnIWMk5vpq6q7D9fuC4rZsWZX8ecHwe0gWFnu9e+nOINMyVQ68oBFYFQn0QBr
         BhFjMLETOR60eoiZFOI+r4JQdbbBoaOY4PoxuEUJeFP/FabMkPoxihECfc0wGwg6kKMY
         u6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879288; x=1759484088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOprrquoKlbkEreJojZ4KykFg8G0TswcVk79ghRz+Tk=;
        b=c+A4x2YuVCtG3vPAnDzTD7zj8/vjNtvOx3a/d082QB+2BmYotME0WL0yiRpyhZeff1
         W3cmjmwjlooB8blrrxtuDq3Q7CuO9C08EkNUbbGVvBcaueNExwje9LKlyzBWWYYGkFoS
         YdJkNWdb0Fhu+7F06coTn9kHXOYzwS5nNtl2gfh1auI2XgGy3IYHK5525AaDO0rKdTVp
         x/tOuKqccQ74ZRHKg4QkRWa3JMSPvELtM0XQUWKIKk5jYoXFs5fz/EPby5yVbjWuTylx
         xdrM1MsgqosZDijOrPI2MaFbP9mUKrmAeiMQRiALGlQW+VOZU/j/9Mj0LcWqGlfsY5NF
         zDSQ==
X-Gm-Message-State: AOJu0YwRatkpKeSSnWfCCOvV2pSG1J8m0qvGZWnGxRxmfu3jA7BLJKk/
	AWhj9kkxrMyLWnxrvn6f7Aj77q7Opf4vnU2yJNPAY9KlCE+NQPjuZieh
X-Gm-Gg: ASbGncv+FSrE/z4Yn/zkz/YNOfNvxY5cYQyjGxmIYFgb8+9pb1hk4DeUTEWQh0krLLo
	gmRcnGKpDPh13qG/BIW8NFnxELM81XEU820JnSSI83Y0LlcPQ9jDB5/6ozM1w1YKFW975HAQ5RK
	Bn0d7rXM4gTTZCKB9bxuYIq19bvv71cv7LrJy2+6PdGoZhe9dwGig5pAxHmkvbe3lZAwYeeTVEv
	ODLSs65aOTjx+1v/qIoN+p7h//MH4bdF6QG7e53XHgrOdh7UDP3ZMykLm9ax96wU0KtcrVvP5c6
	0GMF4RwvqFX2lIzvivS93PxeA4Kdu6Qntu0qDTDS8zj/LUw7q9AxUzh15MKYEPrWYKotFdSvG1r
	CTg5bPpbUuE43OWLkGX3XZVpDOJse8PKeJe6o3dDrKt8HJv4fMa8etRPfpc24aOuhXlwSLOibpn
	1kVT7aBZAUCh5A
X-Google-Smtp-Source: AGHT+IHyNvkqZ/H58qTgrC7RxZoAtdYJitsFBBvDlhUuvEFdmMnVmU2Ltz5BgywZtZV48lyMJHsZWw==
X-Received: by 2002:a17:902:fb4b:b0:26a:b9b4:8342 with SMTP id d9443c01a7336-27ed49e9308mr63284705ad.25.1758879287971;
        Fri, 26 Sep 2025 02:34:47 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.34.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:34:47 -0700 (PDT)
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
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 mm-new 07/12] bpf: mark mm->owner as __safe_rcu_or_null
Date: Fri, 26 Sep 2025 17:33:38 +0800
Message-Id: <20250926093343.1000-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250926093343.1000-1-laoar.shao@gmail.com>
References: <20250926093343.1000-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_MEMCG is enabled, we can access mm->owner under RCU. The
owner can be NULL. With this change, BPF helpers can safely access
mm->owner to retrieve the associated task from the mm. We can then make
policy decision based on the task attribute.

The typical use case is as follows,

  bpf_rcu_read_lock(); // rcu lock must be held for rcu trusted field
  @owner = @mm->owner; // mm_struct::owner is rcu trusted or null
  if (!@owner)
      goto out;

  /* Do something based on the task attribute */

out:
  bpf_rcu_read_unlock();

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..d400e18ee31e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7123,6 +7123,9 @@ BTF_TYPE_SAFE_RCU(struct cgroup_subsys_state) {
 /* RCU trusted: these fields are trusted in RCU CS and can be NULL */
 BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct) {
 	struct file __rcu *exe_file;
+#ifdef CONFIG_MEMCG
+	struct task_struct __rcu *owner;
+#endif
 };
 
 /* skb->sk, req->sk are not RCU protected, but we mark them as such
-- 
2.47.3


