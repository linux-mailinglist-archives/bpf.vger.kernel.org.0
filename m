Return-Path: <bpf+bounces-67982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6FB50BC9
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864035E7993
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC325D1F7;
	Wed, 10 Sep 2025 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdmJwKQT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9A253B58;
	Wed, 10 Sep 2025 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472407; cv=none; b=lsFo1jPTrN725p2iAknkFxuwqO0JTQZRyQm/kRUaiWRO0mtcUD6ca4/yhMB7UoFoAhVPhWVSwj+GD/bCGfFVtTqQk6faoBwZcu9IaA3xAgQyic/yGHqyNB9TMWD7PHzuyyWN78r1PJa8kutufXiEPmKrrkHdmZbT2Sr637xRyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472407; c=relaxed/simple;
	bh=YAOyLtl/yT0KurVAS8jkCGgDLW5ZDt6xjaeBTXqfenE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTluRAwMEjxtQw7vk6i0mDmhkdmbZ8ZSffbtCqNWR3LDHN/kPCv4V94FLwLszPMaYScB/lQJMAH/6yIRmHLbZCSgVzGwqsNWbRuIHhMVsw3s8hpDldYQr/ydE/haPt95ZCw0vX08b7EZPCkbuj8AUfOHLZIEpDj8tPbnRu5kBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdmJwKQT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-329b760080fso6188170a91.1;
        Tue, 09 Sep 2025 19:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472406; x=1758077206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5jPTpqPMOi1hpcfswRT5c+4UlwlwSKkHLVyMRU04bc=;
        b=HdmJwKQTbfMmkyFJsrbtXF4kpDZqCuwW9p46Oor2wLrAZXbub3afkflh0LBuwrh6bw
         jsGgzxqjTgLXhw+6n0PB0uYV1iDMN8JVwrADtEO6k4guduvSVTr7duucdrJ7SAWFWyC2
         MNbz6pgahVxLDP/8cAPy1ROVMsxYs6so/EMUWDPtMwAXtPQwXNcaBJlJmfoi5oUWinzg
         TQuXIzzRFRZxSm6JpI5mtmCkAYMh7NIH4Gq1R0pHnCiBWVDU7+JJsL36mC6BWBzZQjmK
         04XbmRL7qLHb3xPKkyO/9Gf3DE9FJto605ek88OHkdWEigo+IFzgqVtxafdSBBEMrF+W
         reKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472406; x=1758077206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5jPTpqPMOi1hpcfswRT5c+4UlwlwSKkHLVyMRU04bc=;
        b=lem+8YGTz/dlOu2owmf4GNy6uL4JNKHsRRZkwXS4RTnCA0x8FvCFF/w4Gy3AMdQZwE
         lb6vHuMs3no8J964hk8jFN/EIDbz4CW3p7Wl30ANqGzb10Ir3MhHBfVXU4ln0MqWJJPw
         F1DF/lp6zDweF8KjbMQpoHGf09Qxd5XDp3x4ExpCx5iDE1IYicU2A2Cb86S9++VLo9jn
         pte4QvBuU4quvv5i2NOaiHf/NlJOKJ4l1KPTbGISj/LFP2lXgI9aq67GHYMqdxmvxb1l
         I0ZWoGQRCG8EY+X1unpcqizgfyXeQNrjAk+xfe5aJH+oY7v/EMvV1YvKZ+aIsqIxHu6w
         /ESA==
X-Forwarded-Encrypted: i=1; AJvYcCUv5hhBTGO9yLfCGvXy2sQtlGGieZ6z9DADvLhEEdp6aomK/6amy9v7tHAfFV+ODOua/rEbVL6Bha0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm5QxQrNL/5m2HODQJKeGXOZmT3ApWRaG7r+qrVVyrBvwy2WmR
	CGW96DEuufRaljaVYkbAxc0GBjbc62qJudPMtMGEu27noybHxPZcawQq
X-Gm-Gg: ASbGncvyeJIe5qwe18wi6JWPAkJUBT6eVDwrtb0jSHClVbhlmEGyxpLu5fackjMa2PK
	WGb61LirCZwXaNgfMROT1BUNQcIWvvOyAa8ahLNcryMlclRQHfa9BQEQBKmnyLxWD0NzZvPvWjf
	sAC39HRAVBLppss+XeceooeP+TQP3w2wlFPLnrR0nD97Gt84c5hUIkx/TmJcpR0u3dq+Feg0R7E
	T/ZaSrFaQfUCPVZu3Kj4tLkO4Tavi/7KXXPMhJW+rMpW5hIkpLM+I8faOLBcwNvhtB0dfvKXgkE
	tFucwDX8FhWOPaCcr/1FiH36fTznf/pyhXdfP8uOYEjEiy9Rz+UgR1ardF+/Fi9IAt159Jsn3+7
	xt4OqJhDczEjg6PtI8ekcgz4clZG/YT4A1XqAvaLgxwCgNBMk2OjaMklpFXor+J0b3wSHcF4NUV
	SpjYKJkHEYpfBqzLoamdRb+U4m
X-Google-Smtp-Source: AGHT+IFZpY3V/uOIGTyZ8BzKdRQSeK3R6TIpn8+CqivqfkEb3qFahG1VblvOigKRq+kSt04Qfxrjgg==
X-Received: by 2002:a17:90b:2fd0:b0:329:f535:6e3c with SMTP id 98e67ed59e1d1-32d43f9338cmr18153184a91.35.1757472405568;
        Tue, 09 Sep 2025 19:46:45 -0700 (PDT)
Received: from localhost.localdomain ([101.82.183.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm635831a91.12.2025.09.09.19.46.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 19:46:45 -0700 (PDT)
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
Subject: [PATCH v7 mm-new 10/10] Documentation: add BPF-based THP policy management
Date: Wed, 10 Sep 2025 10:44:47 +0800
Message-Id: <20250910024447.64788-11-laoar.shao@gmail.com>
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

Add the documentation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 1654211cc6cf..1e072eaacf65 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -738,3 +738,49 @@ support enabled just fine as always. No difference can be noted in
 hugetlbfs other than there will be less overall fragmentation. All
 usual features belonging to hugetlbfs are preserved and
 unaffected. libhugetlbfs will also work fine as usual.
+
+BPF-based THP adjustment
+========================
+
+Overview
+--------
+
+When the system is configured with "always" or "madvise" THP mode, a BPF program
+can be used to adjust THP allocation policies dynamically. This enables
+fine-grained control over THP decisions based on various factors including
+workload identity, allocation context, and system memory pressure.
+
+Program Interface
+-----------------
+
+This feature implements a struct_ops BPF program with the following interface::
+
+  int thp_get_order(struct vm_area_struct *vma,
+                    enum bpf_thp_vma_type vma_type,
+                    enum tva_type tva_type,
+                    unsigned long orders);
+
+Parameters::
+
+  @vma: vm_area_struct associated with the THP allocation
+  @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
+             BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE
+             if neither is set.
+  @tva_type: TVA type for current @vma
+  @orders: Bitmask of requested THP orders for this allocation
+           - PMD-mapped allocation if PMD_ORDER is set
+           - mTHP allocation otherwise
+
+Return value::
+
+  The suggested THP order from the BPF program for allocation. It will not
+  exceed the highest requested order in @orders. Return -1 to indicate that the
+  original requested @orders should remain unchanged.
+
+Implementation Notes
+--------------------
+
+This is currently an experimental feature.
+CONFIG_BPF_GET_THP_ORDER must be enabled to use it.
+Only one BPF program can be attached at a time, but the program can be updated
+dynamically to adjust policies without requiring affected tasks to be restarted.
-- 
2.47.3


