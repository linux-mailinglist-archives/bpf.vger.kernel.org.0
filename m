Return-Path: <bpf+bounces-17118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7544F809EC6
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B75F1C209C0
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A311714;
	Fri,  8 Dec 2023 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/DRJ7vk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A82A10F1;
	Fri,  8 Dec 2023 01:06:43 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d0aaa979f0so14208615ad.0;
        Fri, 08 Dec 2023 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702026403; x=1702631203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FXGf9L1hz/wQQ/jUv0sNTidQzM378s4gfN4y5IQE/M=;
        b=E/DRJ7vkip0DXH3MTqZgLBRkgyu0Qx4wHpAM+PElVOLu1lPYAXxtQsc7u5FRMFItFT
         qXWTj3+uPOkQ3CaNMT1JX4meGzRSWBjyKXOKU05iW5PhKCuU+C6SWPzukc2+03pDTFiz
         lnZJeQmD389wGMJrBh1ZyVRVfdBV6G6k4sN1X4gimkgOcGpHcz6W68IL8bRyt5ysquJr
         GAXVPzPYmJpOsQ53nSfRs4FCPBjoidKCyq31HwkrtFeKO6JEZYarDDwaGhb21nI1tb4c
         TDGP4cpEWNbMYxRMFsRnByE2g4Pg20kPF2JrQzyWZawWOyFJ/Ga49TdKh+4ilHUI9VBO
         nwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702026403; x=1702631203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FXGf9L1hz/wQQ/jUv0sNTidQzM378s4gfN4y5IQE/M=;
        b=PHgZsZhx2ABYpSR+VTs++mDI3EfSs/50+F2zqTy3ubm9pJ2G42/piebhLUhRhdlmxP
         A5hPZ/YKE17+ZJ+wEImZKpUHtGGbtm45110xFgjEB8qMnHUXM5Vfi6QOHCnkxuJZyTUm
         K38jayU+7oc0nIKHFkI7TtfyawfqNiE6Z7WYQ+vGR8PCzG4vMLMxXyWc3bfVEXaVTLSP
         5o6z9NADIBXYZRbGQmDhWV/R8XQcTq+KPcrFdTtmTHbvNzGq/hpzfFX5HdEPl8OhAVFh
         rZl+5xK0EjxmRyIeXt/8wkE/AeYWJFJEN3jB+aClL3VokpGk7eXJ59UXN9YPcj5NCKEE
         8j2Q==
X-Gm-Message-State: AOJu0YySqD2QWS2YuYY+ZQC60LvjN0q0kGL/2xN6pvGafCXe82XVaJVA
	n4cz5zwUPQMrKTvulakp0Ni0CciJSFNnb43S1D0=
X-Google-Smtp-Source: AGHT+IFlw/JLS1hN3T0ahEP+Fd1/GMCS9LQMI06Z1/BK/WYt8tyi7FPO5YKhxacr/lJxGfNAdtearg==
X-Received: by 2002:a17:903:22cb:b0:1d0:a7b7:74b7 with SMTP id y11-20020a17090322cb00b001d0a7b774b7mr3612483plg.104.1702026402988;
        Fri, 08 Dec 2023 01:06:42 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:4055:5400:4ff:fead:3bd0])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d057080022sm1188173plo.20.2023.12.08.01.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:06:42 -0800 (PST)
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
Subject: [PATCH v4 1/5] mm, doc: Add doc for MPOL_F_NUMA_BALANCING
Date: Fri,  8 Dec 2023 09:06:18 +0000
Message-Id: <20231208090622.4309-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231208090622.4309-1-laoar.shao@gmail.com>
References: <20231208090622.4309-1-laoar.shao@gmail.com>
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
 .../admin-guide/mm/numa_memory_policy.rst          | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index eca38fa..19071b71 100644
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
1.8.3.1


