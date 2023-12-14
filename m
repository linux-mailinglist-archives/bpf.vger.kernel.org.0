Return-Path: <bpf+bounces-17817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C0C813092
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F35283188
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4C4EB5E;
	Thu, 14 Dec 2023 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjzxaWeZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700DB113;
	Thu, 14 Dec 2023 04:51:43 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d375714590so1598745ad.1;
        Thu, 14 Dec 2023 04:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702558303; x=1703163103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FXGf9L1hz/wQQ/jUv0sNTidQzM378s4gfN4y5IQE/M=;
        b=TjzxaWeZGlzHHr1y6n5UQSd7RwqTk/x6G9Ek/Bnk6qvhX41w3dJ4tWNuc8S2hppQhs
         vqGNR4OEvcl4JAJJzmjyEXfs/zcPDdzMGqjunCpW1zR0cz9wdoZiF/vx9v/DABYSekKA
         7F+gxXQFOlA/e8DflC0l5llm8hQwOlf3tdVY54wfB3yK5grweE4VZBsIiDG91a4C39ET
         RL+PURY0zioQ8VseRxRa+7bmlgZwIiDJgTNHgsj2bcGrqw0VBCl4wOACJCKsmLab30YK
         NWJQR4ewiH5avOtmXrCnWLgcYj8bSSOP3UVIk9lg35gOiOGInq7LwbRagtbn0eppAzsc
         Pe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558303; x=1703163103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FXGf9L1hz/wQQ/jUv0sNTidQzM378s4gfN4y5IQE/M=;
        b=IttHJDU0OFCzRUHqAFzqEASRqZ2GwphIFK/LzUwnU3fMZ0iFXNQP9QcHUIQwIjWPSH
         GQ+j+NwFNEC97c/KA0qVVLuakqicEGp0BrSSkRyiN9QlmvOGEd0HboM7zs1Mt4k4ZyeS
         YX+pcH0lavFBOuS4SFyxEedVuoCLv3q3h0yJNjPBRqF4vXNp0ZcBqAfrzBdFkAYvijQR
         6fz3WcViZi2L7SRhAgkeRD40fPzPubwOKnTv7y+hCRqi373tBB/EM1VZjVroU1p3o9bN
         S4lZq51uLKrvicYKtKzNtNQrTgcfydg7G01qlxAItWrP9KOkA2AdEmME/yQaCFYtXci/
         4K6A==
X-Gm-Message-State: AOJu0Ywvt27yTuxcjIvhMQPC1tk3wdde8nBX4FhVyNsUHMBeqdCrFJor
	p6Y4n1XjQEoB/izTFAx5G9c=
X-Google-Smtp-Source: AGHT+IGun9zwMBNgulopQ02olJANVXRIqTshnpV14IXmUgWVJbUSdBEHOhQ1kCfxytlwL/jT6XC2+A==
X-Received: by 2002:a17:902:c98a:b0:1d3:71dc:b3f with SMTP id g10-20020a170902c98a00b001d371dc0b3fmr434698plc.36.1702558302859;
        Thu, 14 Dec 2023 04:51:42 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001d36b2e3dddsm1184528plb.192.2023.12.14.04.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:51:42 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	kpsingh@kernel.org,
	mhocko@suse.com,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 1/5] mm, doc: Add doc for MPOL_F_NUMA_BALANCING
Date: Thu, 14 Dec 2023 12:50:29 +0000
Message-Id: <20231214125033.4158-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231214125033.4158-1-laoar.shao@gmail.com>
References: <20231214125033.4158-1-laoar.shao@gmail.com>
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


