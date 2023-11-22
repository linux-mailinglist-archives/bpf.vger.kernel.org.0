Return-Path: <bpf+bounces-15647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F27F48B2
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F1D1C20BA0
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D894D5BE;
	Wed, 22 Nov 2023 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcsUGyv3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92419D;
	Wed, 22 Nov 2023 06:16:20 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso5928761b3a.1;
        Wed, 22 Nov 2023 06:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700662580; x=1701267380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEKF8LLG6U3WOQ+0Jd5b+JaDhInk2g16roqp0OT/5iQ=;
        b=IcsUGyv3r72G7slMp6GHDoKK55hqMYE20fFUiAi8OSjJ8/uLEFNZt45bDDUpcWcBvJ
         36CenbaP70wYGtrI6iJUGliE4sdqHXKJsS57Hxsd0MGqQTePI03LLRkE9gYBlq7oaL7G
         Aj5g4B+KG3jPCNhugmjgDlhzNB2Nw+S1dq4AzA1ociIPzQphfsU+7UWXIApRK5DiY9E6
         aHTaPat5qyBgIvTSxMtQvzy9T+NjDQG14Tz9h5AbD+pHJfXLGEcrTlaI9h37dO2v9R0I
         tfsUg9tHIhLldBrGMfZscQgZlMX7TtLfNRLn0CgiUgD7CX9Byq7GEDyKydGJj1lMAP12
         qoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662580; x=1701267380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEKF8LLG6U3WOQ+0Jd5b+JaDhInk2g16roqp0OT/5iQ=;
        b=h4r8Zab0vnwXRZ/34lr8FeKgaDnW5nIivUTEIaWCMqX4tspHhEdpgr5PcSRI5vqPIW
         H6Kz25LQM29cK/UlaHAVfLawK5rerrZ9ip6lnvu4xWcZ39DQoD0eu2Nq5EXlYN6qe4GU
         DE4VsbNtsFRwjgQL19zjdxiPhrHb98COzSsefqOEEFDW1F+qhX6dyF9HF3MEylOgOFel
         to0EztWx6WyHu0DmXmk8zwLM35HrBbO9WEjbAi7jRfAARFCiEDz1n8iCjX6FHaVPLj+g
         XO37QPB7efTTaYEL0jH9KIF+j8i6U6LzvOCY1pv0mNd/Ay9A1fysulbflhja2hYnL9lL
         t7OA==
X-Gm-Message-State: AOJu0YwPdlsN/+jftZo9U6iHGBO6p/1RFaqlDLcXYzloZs4hqan5dYX0
	vFJrXjm6D7d0n1Ip7W0O2/8=
X-Google-Smtp-Source: AGHT+IHaW2MTTY6XpXzARVPEMKHa87mJ8Yxq3K7qITmUxY6o2gfygIc8izDK27aA06ZWTKsysRRh+w==
X-Received: by 2002:a05:6a20:e126:b0:187:7917:189d with SMTP id kr38-20020a056a20e12600b001877917189dmr2568042pzb.29.1700662579836;
        Wed, 22 Nov 2023 06:16:19 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac01:a71:5400:4ff:fea8:5687])
        by smtp.gmail.com with ESMTPSA id p18-20020a63fe12000000b0058988954686sm9356260pgh.90.2023.11.22.06.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:16:19 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	mhocko@suse.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>,
	"Huang, Ying" <ying.huang@intel.com>
Subject: [RFC PATCH v2 1/6] mm, doc: Add doc for MPOL_F_NUMA_BALANCING
Date: Wed, 22 Nov 2023 14:15:54 +0000
Message-Id: <20231122141559.4228-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231122141559.4228-1-laoar.shao@gmail.com>
References: <20231122141559.4228-1-laoar.shao@gmail.com>
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
Cc: "Huang, Ying" <ying.huang@intel.com>
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


