Return-Path: <bpf+bounces-16364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A522800765
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89944B21134
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD01DFE2;
	Fri,  1 Dec 2023 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmCxtAKm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C31B2;
	Fri,  1 Dec 2023 01:47:08 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fa455cd94so244362a12.2;
        Fri, 01 Dec 2023 01:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701424027; x=1702028827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmx346GI6fqI6wzgBEPg9Fgvbs5eLVjahXLFcCzrycE=;
        b=AmCxtAKmvvQspeayK4vJIMVZPb0OjjqFk7DMZhxab0YuSGvd2ZRDfOSVJS8EWnB0oI
         vWEZkt5/6XPRL+tA0SkaIV8OYQhCR95GaO5k9Lyu5Tn6gIap0i0IyBGqHIyT+1HPb9ih
         CbaNSa7b7UY7dDXRzSD467VMqJL1OD715prElZUpZoxXpk5RMrMcWkV/7zJ4rofN6qu1
         0wdt/+TMXSo/QIoysuGThcw0KKzgsieMz+9SV74jJZ20+AB8gHQpHyk5Jjp9pJctUuY5
         nBPaS5LJxal2ZPlMsn9GzxKVkLfSNZgN0YZvADjwS9tKvvE+FNZa8R6/FaTaxuASMnZl
         NpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424027; x=1702028827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmx346GI6fqI6wzgBEPg9Fgvbs5eLVjahXLFcCzrycE=;
        b=eBfut50aqXTKrEivAkItP4zWZKbZjn7Q024WfrlM9kpkhba3tesmIPQ66+lT0jiqhb
         Fo2FPkHWWt3SqZb+5kc364el7XssyKIUXLr+57uYdnduxeMBhr5d5QAQF9z37jE6HO8K
         G35HrJ/+N+RcWoo7t8dZaa8NhQ3XdTe9uOsXRmytjQ+P4aEFUQqvx9CDE+ND4vorLJXD
         1isAxGepelHuqIAR9fcBC6dp8bhlFAWYfm+u/U4g6vXFBb91VMvFhB6b4whX17aw6wkp
         TBgeiOVYmesf316MxN/QN2hzKjPAoIHlSWQGkwt27NFIAUT8Xj+TDSDRIrttAz6edotr
         qxGw==
X-Gm-Message-State: AOJu0YwEruezQTZNxvnQHbbH4H34Z2MUAEORXpSdJGH8MBnIuxPOEcfs
	NmqcvjY1w8Xkctkk9vsUOfw=
X-Google-Smtp-Source: AGHT+IFigdK8sQwXucIFYeMm2TxPUV3X4nzFGv3uOLyaN6ywOAWNYbjC0TurnvUFhtxnQN/TgABwqA==
X-Received: by 2002:a05:6a20:5521:b0:187:f7ac:b8d5 with SMTP id ko33-20020a056a20552100b00187f7acb8d5mr20361920pzb.25.1701424027584;
        Fri, 01 Dec 2023 01:47:07 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001bdd7579b5dsm2875534pls.240.2023.12.01.01.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:47:07 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	mhocko@suse.com,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 1/7] mm, doc: Add doc for MPOL_F_NUMA_BALANCING
Date: Fri,  1 Dec 2023 09:46:30 +0000
Message-Id: <20231201094636.19770-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231201094636.19770-1-laoar.shao@gmail.com>
References: <20231201094636.19770-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The document on MPOL_F_NUMA_BALANCING was missed in the initial commit
The MPOL_F_NUMA_BALANCING document was inadvertently omitted from the
initial commit bda420b98505 ("numa balancing: migrate on fault among
multiple bound nodes")

Let's ensure its inclusion.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index eca38fa81e0f..19071b71979c 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -332,6 +332,33 @@ MPOL_F_RELATIVE_NODES
 	MPOL_PREFERRED policies that were created with an empty nodemask
 	(local allocation).
 
+MPOL_F_NUMA_BALANCING (since Linux 5.12)
+        When operating in MPOL_BIND mode, enables NUMA balancing for tasks,
+        contingent upon kernel support. This feature optimizes page
+        placement within the confines of the specified memory binding
+        policy. The addition of the MPOL_F_NUMA_BALANCING flag augments the
+        control mechanism for NUMA balancing:
+
+        - The sysctl knob numa_balancing governs global activation or
+          deactivation of NUMA balancing.
+
+        - Even if sysctl numa_balancing is enabled, NUMA balancing remains
+          disabled by default for memory areas or applications utilizing
+          explicit memory policies.
+
+        - The MPOL_F_NUMA_BALANCING flag facilitates NUMA balancing
+          activation for applications employing explicit memory policies
+          (MPOL_BIND).
+
+        This flags enables various optimizations for page placement through
+        NUMA balancing. For instance, when an application's memory is bound
+        to multiple nodes (MPOL_BIND), the hint page fault handler attempts
+        to migrate accessed pages to reduce cross-node access if the
+        accessing node aligns with the policy nodemask.
+
+        If the flag isn't supported by the kernel, or is used with mode
+        other than MPOL_BIND, -1 is returned and errno is set to EINVAL.
+
 Memory Policy Reference Counting
 ================================
 
-- 
2.30.1 (Apple Git-130)


