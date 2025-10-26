Return-Path: <bpf+bounces-72225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA76C0A5D3
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 11:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FB43ABC2D
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02DE26F2AA;
	Sun, 26 Oct 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQT6MvKw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA81D5154
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761473003; cv=none; b=uih+lfKObzQokZwMS7uJzcQbqWK/Bsrgjc5LeaDmDIWPgZrPITYmo8z8to54heJ0Ed7S1JebOoEzBRGuuYQUPnpK1d/l6032RIBdGnUfNtmXIFRU9kmsfKvMOQQonXmvU3pExOwbvHysjW46+BhE67dgtzhWIHMsrvDHyow1XQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761473003; c=relaxed/simple;
	bh=fc9irx3vRw/gH5bSMSmH3mDpC2kosNeUafUCgNF3xss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lh3Q/gsrkmXkGR3tihoewyVIJjC9NE/kEyipXVnqhGIJcnK/KReE0cTFVhs7Az8Cb112E+5UokXWaUISIzow2fv/SDW9DPDVHA3Wt+LDohh8Lc9I6nQftBb7tOU58PipsoEcOl9m8EoQhHBAEtBN1Dvog23gfy9HC+DQmHpsz50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQT6MvKw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-793021f348fso3014613b3a.1
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761473001; x=1762077801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTbcM0ayqoWwS8U5wGMUp/PcPN32NyXKHTXTAAB8Oig=;
        b=QQT6MvKwC95FN+PbfqN4+ff3OLlje8L+IjN7EI2d7YAbhn5lI5B34vtwTFeM/JJdkz
         7ngO3LI3+x51E+rbkcou/9NxiSZ/QHHurYd59kHsOV3rauYU7oiS/QmhEiex0G8xHEv+
         F3xBlmKN6CJeHUWDjgdjd6qR4CNIhimCt/1kdv44DYUHFk6dRf3wx/+xir3R4jiNWXrC
         o0pognO1sY/3jyyi5+f4Z+WBcNJFXBXZcGGjeckU0zWhzLWFmh1LmcZN85T7qUEQDh9D
         eIHv7/JpmIE7RPc6SLPLlJas18Dn8LP8iaY/yLRIX8buh0kvJ13eYuMza2QjfUSuy8+W
         D5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761473001; x=1762077801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTbcM0ayqoWwS8U5wGMUp/PcPN32NyXKHTXTAAB8Oig=;
        b=p5/TFm15RbRz/H+Z9oQOa2AEzCNqCpjD2UcbZ7le52dWcs2WBSAsOcuOR01GppmfR9
         eJg7S8LBSJTBH83a8yvvucPu2DJct2nvLup6nPsOKuXxESK9l2/eKzA1k4cIANvU8TED
         X4J5BiXhQYIbOBcYrWl8bcDqLJdihc7tQsd31WMZs7au0pq4qJ3t9LHjMV1+MJIAUogV
         z5bz99O7uQV4fJfAENK6kRekq6Oa7aCSe6GNlN8ziemxtA2HS+T+7yvNLV/+kqU05Mir
         YTDemWFU1I8tqFtGc48YFMgEC9BGHAIer8rEeKOT7mLGX6tl36WRpPGITxZhJtfDRfV7
         VcRA==
X-Forwarded-Encrypted: i=1; AJvYcCVlhHntO6agc9XE4yYL/Xni7dxqi82lOQ4NUmpc9JPFrgFWC06o6HrpP6dscbmzn3NlYWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JBcDpCdlJI/X/XZrNnRjnUhLZaQjgGd6rtRw7Y7RvYt4lSPs
	zDRyGQ8I2eIBeOFZ9EXNL8/q1R6uLPSGBjtW6G5ubHJl1t9kp+OlusrC
X-Gm-Gg: ASbGnctj9j3rLy6W3VUGFp1tGKpK1RpwX04h+NEcmx5BGoKxpoBXG/fre5k/F3hnn9J
	IP4QtnXl/JlmxI+gstTFzMtofrOIxqwkncpSC7U5USZUOuRYdwiF7BcwxdOFHVPswZFKYA0Mgd3
	zBC5op6KNXxswhRVo7mnP2qTy6zLrcY7qRCOMLqJhXSDfRD/l+TccrDII8HrsIicUZLmVYfTBSx
	JMz8ssCOJ1gv3jYk+GInIug5L9FUsLBcSbxdVTBwK3usXiJJME3GbooApqba6VJpFm85t0HnRnM
	+qiYjGOMr3Bp/eTjnn7FvofaWl1c7Vi+CTgqLZd9vyl5QD2rM7+Dc8maekdHJN6ql39+sc3GJnW
	sppkIxd0D898FIesjMJwIoJjqz/P7EDuysselZPVqaGzigPdfZwf6qazmkjcOpoXqeHbK0txwO/
	/yA/YDVlFLgLDnX2Bpb56fgeEsFHksDXm0sMg=
X-Google-Smtp-Source: AGHT+IHEY8mqdGcAazzp5rPEyr5waMaxx6tTVi2B3EGGTaAB1FjtGvhczK73gV51ecEw4czYNqbexw==
X-Received: by 2002:a05:6a21:3989:b0:342:6c97:3680 with SMTP id adf61e73a8af0-3426c973993mr2025707637.53.1761473001223;
        Sun, 26 Oct 2025 03:03:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a84:d:452e:d344:ffb:662b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm4824966a91.5.2025.10.26.03.03.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 03:03:20 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	ziy@nvidia.com,
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
	rdunlap@infradead.org,
	clm@meta.com,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 mm-new 07/10] Documentation: add BPF THP
Date: Sun, 26 Oct 2025 18:01:56 +0800
Message-Id: <20251026100159.6103-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251026100159.6103-1-laoar.shao@gmail.com>
References: <20251026100159.6103-1-laoar.shao@gmail.com>
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
 Documentation/admin-guide/mm/transhuge.rst | 113 +++++++++++++++++++++
 mm/Kconfig                                 |   2 +
 2 files changed, 115 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 2569a92fd96c..a85ebcf7e07c 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -776,3 +776,116 @@ support enabled just fine as always. No difference can be noted in
 hugetlbfs other than there will be less overall fragmentation. All
 usual features belonging to hugetlbfs are preserved and
 unaffected. libhugetlbfs will also work fine as usual.
+
+BPF THP
+=======
+
+:Author: Yafang Shao <laoar.shao@gmail.com>
+:Date: October 2025
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
+    struct bpf_thp_ops {
+        pid_t pid;
+        thp_order_fn_t *thp_get_order;
+    };
+
+Callback Functions
+------------------
+
+thp_get_order()
+~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+    int thp_get_order(struct vm_area_struct *vma,
+                      enum tva_type type,
+                      unsigned long orders);
+
+Parameters
+^^^^^^^^^^
+
+``vma``
+    ``vm_area_struct`` associated with the THP allocation.
+
+``type``
+    TVA type for the current ``vma``.
+
+``orders``
+    Bitmask of available THP orders for this allocation.
+
+Return value
+^^^^^^^^^^^^
+
+- The suggested THP order for allocation from the BPF program
+- Must be a valid, available order from the provided ``orders`` bitmask
+
+Operation Modes
+---------------
+
+Per Process Mode
+~~~~~~~~~~~~~~~~
+
+When registering a BPF-THP with a specific PID, the program is installed in the
+target task's ``mm_struct``::
+
+    struct mm_struct {
+        struct bpf_thp_ops __rcu *bpf_thp;
+    };
+
+Inheritance Behavior
+^^^^^^^^^^^^^^^^^^^^
+
+- Existing child processes are unaffected
+- Newly forked children inherit the BPF-THP from their parent
+- The BPF-THP persists across execve() calls
+
+Management Rules
+^^^^^^^^^^^^^^^^
+
+- When a BPF-THP instance is unregistered, all managed tasks' ``bpf_thp``
+  pointers are reset to ``NULL``
+- When a BPF-THP instance is updated, all managed tasks' ``bpf_thp`` pointers
+  are automatically updated to the new version
+- Each process can be managed by only one BPF-THP instance at a time
+
+Global Mode
+~~~~~~~~~~~
+
+If no PID is specified during registration, the BPF-THP operates in global mode.
+In this mode, all tasks in the system are managed by the global instance.
+
+Global Mode Precedence
+^^^^^^^^^^^^^^^^^^^^^^
+
+- The global instance takes precedence over all per-process instances
+- All existing per-process instances are disabled when a global instance is
+  registered
+- New per-process registrations are blocked while a global instance is active
+- Existing per-process instances remain registered (no forced unregistration)
+
+Instance Management
+^^^^^^^^^^^^^^^^^^^
+
+- Updates are type-isolated: global instances can only be updated by new global
+  instances, and per-process instances by new per-process instances
+- Only one global BPF-THP can be registered at a time
+- Global instances can be updated dynamically without requiring task restarts
+
+Implementation Notes
+--------------------
+
+- This is currently an experimental feature
+- ``CONFIG_BPF_THP`` must be enabled to use this functionality
+- The feature depends on proper THP configuration ("always" or "madvise" mode)
diff --git a/mm/Kconfig b/mm/Kconfig
index 12a2fbdc0909..c374a0f4acc4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1476,6 +1476,8 @@ config BPF_THP
 	  Enable dynamic THP policy adjustment using BPF programs. This feature
 	  is currently experimental.
 
+	  See Documentation/admin-guide/mm/transhuge.rst for more information.
+
 	  WARNING: This feature is unstable and may change in future kernel
 endif # BPF_MM
 
-- 
2.47.3


