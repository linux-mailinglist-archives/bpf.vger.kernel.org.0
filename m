Return-Path: <bpf+bounces-66520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AB1B35587
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE7117CAE5
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC0B2F6589;
	Tue, 26 Aug 2025 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TInW23W0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C124284678;
	Tue, 26 Aug 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192923; cv=none; b=G8nHSwXf3kQXbkf1pFH9lwAIoREAZsjr/GKtZg2lgjLXqwicM3IE5PtyDNnupq3YHrJIR7tGjZx28nUbaEXyorFR0m8Ich3LB284eHTckasMR8aN0JhNXbYta/wpBEuElm8JUbglQn7gHxoCjVDm8DgPYx6LGcOlHebObo8bAPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192923; c=relaxed/simple;
	bh=mU2bzFJoqM7Sr6cE941TbbsOfyo+P5lzg61rKDAVbtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sFVYYErcI98HjeFt3IYeCzP4T6MRoCdA/tE6TZedM0qk/bntmhu34SuQ6vgZrdE+tEG8707RlQJgbAa2cq3nij0WbjVhSVL7JG96K9CADyAtORRsedi43qzqFSNd46TCvmpk/2js0PkaFcNUuOWRuqsZYVhLM7pswL5Ol/oi7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TInW23W0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-771f3f89952so659156b3a.0;
        Tue, 26 Aug 2025 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192921; x=1756797721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wbac2bbB4Agf6ejMhEQ8dWLbxrMb1NMiLXWF/bBnvXI=;
        b=TInW23W0XwWB9wuHqLK7puBRDmHhiDjcWHUSb6e/vBWJTj/SMOGt2aEeZ7K/5GFdjv
         L5sBKcmoC/pVG6owKZlyxwgJu/aEemNj7/O9uAznoMIrDOZrIm7mBafZgzzTx2StSf43
         FrU0rOIZZRp3sE15RtSuh0uchRoudnvX0kRA8f504M/YYE4P2u3QX5PcOetSPgn3XNOa
         uuAQs/u46uMkrfNa9amcLIfvjPzXDrE2STxgFuoHBnnWkui+mafFHnqVm8TT2tTiWdFR
         gNmSvAQ6S0pVuh+0lLwXTJMS9k28zEVxFbWYkNfe+fW6HXYJx3JVXH/V4zdGS5rTO1I8
         gFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192921; x=1756797721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wbac2bbB4Agf6ejMhEQ8dWLbxrMb1NMiLXWF/bBnvXI=;
        b=kLOs4S2IKq2etjSSANtGUfUR8yhSrzf5/yy9aImO3rs6ggVb17Bq+bVgtonMxKSxQP
         89qSKngJi3mnUFbaum/GKF3MfWjS/N3p7TiG7VH56NWfKzQ03j4rt2P9e5DCttrV7idw
         9jDiB2/d7qAZTDji7fADpsQnltZ3JbU2hLubqJL+xkPplXY0R7ZWQ1c5n/08+YC2kbTm
         R7nkWSqc9mJEQCgLuM+FqAF97tYUlhJTnG3Fmy43akWdWhusGsS918YBRMND4u2gF+eA
         ZsQ4Ms3pPZ2rXZxAOOZ9p0KA2taf1DBgyYuX3EfdmOE3axOhFOpFyyqeNqUPpwVIasjt
         QqNg==
X-Forwarded-Encrypted: i=1; AJvYcCWATJeGnAF9OrRL3ODqFszVGoHZffyP8JEyOu+BSZJu41epiSYIrE/oZP8iBXj+Nbsx3aG05ROhguE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/OFSmwn+2OJM/FSLc/k29sQiXEeTLTqvi13K+RvNKGykasNIQ
	kX1uOKMTOx641w+FYX5M41GKbSVGuavyjqSJlPb3fuc0fMzz8kO6ziBT
X-Gm-Gg: ASbGncsfQ1L+qIRLChAQQ1BKdJxNZCoZV8T3Mz5fdJ1GBGN+LRxBJAElYd+DKLtpNw8
	iiKi87IIEsKIdItdBje0ab5gmB0xTVWlHz5oJloME7Wsl+aEyszCpnbnMubJGtJr3XXMWVO26ce
	PGu3Wl0rGM2JzP2CbG9mDDIaSakwvdrAhmJWBxb/l+VYx6PxKtZMtAm2xX7ju4QhxtQZvB0Xnhz
	ZAyz7H6oMs0aaUYs8+6JPHjID/SCo7JQWwthHbaVwq+pO1xCsmZ6s1zfj5YsPm2JaWeolMy1FZ2
	RH4EATYCcNommaN3KCYoSmXO0NFF8xqfUA7/MfrCEluLN6JBzUV1E/RZVgvclNpjHnf+bxmw3Xu
	Liny9DXAHOfZMIZ9MXi+dyo+mKw8dTMOs7+BnlyPL3mlQzjAqPidMV9A92T1i5Ua23GHvgqOvM2
	jcFqnOEg7h30XRCA==
X-Google-Smtp-Source: AGHT+IHDKkxVACQPZ2nUxU4qBHmNtw5UPdoF1DrAv6TDPleHClAcC9RQjauPOEwrVtJF+n2mv+hsyg==
X-Received: by 2002:a05:6a00:3d47:b0:76e:99fc:db91 with SMTP id d2e1a72fcca58-771fc292f2dmr715991b3a.3.1756192920839;
        Tue, 26 Aug 2025 00:22:00 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm9686052b3a.75.2025.08.26.00.21.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 00:22:00 -0700 (PDT)
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
	corbet@lwn.net
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 mm-new 10/10] MAINTAINERS: add entry for BPF-based THP adjustment
Date: Tue, 26 Aug 2025 15:19:48 +0800
Message-Id: <20250826071948.2618-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250826071948.2618-1-laoar.shao@gmail.com>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add maintainership entry for the experimental BPF-driven THP adjustment
feature. This experimental component may be removed in future releases.
I will help with maintenance tasks for this feature during its development
lifecycle.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 390829ae9803..71d0f7c58ce8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16239,6 +16239,7 @@ F:	Documentation/admin-guide/mm/transhuge.rst
 F:	include/linux/huge_mm.h
 F:	include/linux/khugepaged.h
 F:	include/trace/events/huge_memory.h
+F:	mm/bpf_thp.c
 F:	mm/huge_memory.c
 F:	mm/khugepaged.c
 F:	mm/mm_slot.h
@@ -16246,6 +16247,15 @@ F:	tools/testing/selftests/mm/khugepaged.c
 F:	tools/testing/selftests/mm/split_huge_page_test.c
 F:	tools/testing/selftests/mm/transhuge-stress.c
 
+MEMORY MANAGEMENT - THP WITH BPF SUPPORT
+M:	Yafang Shao <laoar.shao@gmail.com>
+L:	bpf@vger.kernel.org
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	mm/bpf_thp.c
+F:	tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+F:	tools/testing/selftests/bpf/progs/test_thp_adjust*
+
 MEMORY MANAGEMENT - USERFAULTFD
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Peter Xu <peterx@redhat.com>
-- 
2.47.3


