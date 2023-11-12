Return-Path: <bpf+bounces-14917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27147E8EF3
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 08:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C00280CE8
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 07:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B237F53B4;
	Sun, 12 Nov 2023 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5h7uHtS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E76613B
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 07:35:09 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D16C2D7C;
	Sat, 11 Nov 2023 23:35:08 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d30d9f4549so2142101a34.0;
        Sat, 11 Nov 2023 23:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699774507; x=1700379307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM+z4PYBGo1mm2pkGctatP2LhDD0LXLs8IszYhVAzsM=;
        b=B5h7uHtSA9M/kKuywos28JAXq5L80oz71JP+sxo5ad5TX1NM5utneDp+bkuJTYJZ2a
         aDZ4LHfLwnYFy/4mW9wWy9MX3tMp60qAds0gNDeRos5zFW86TjsbgFxThmnaZcPZ8LpY
         JeGJU2jf3+UzKyqR1vmnCipT4YWneagOGL9+mliGza/EshYYDYerQTy5VbOPf68yk9wJ
         iiuPW4AYCOhASiBf2VMpreUUBVoucHlq2jGapnkkmUHVeceezw5F1p1fQdoHjrt3Qdao
         wB0dAKvvxCH5Gcyuc/t0DqWHpj3Wj4j8hg6lPnSSvPc44R7w03r11LKIu/qoltASsNgs
         54/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699774507; x=1700379307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM+z4PYBGo1mm2pkGctatP2LhDD0LXLs8IszYhVAzsM=;
        b=Ibkj6/QdeRBHxM0BuTfZcdSmwkX6UBuytNoRx0KKApmC+W/LxoUHqcmNTaol+o/6FD
         VvhzDBlk46d5famwWAf4kgDxEFwCc59VVQTynWA0OpriZ9y2003OpgMtguH50vwUgXP5
         3846IF96cNk+ZkJ8MYO3am9+T7UZ1AaU5jppywuIfT+PdrzGVjALUry48hz8GVoEOMRd
         vfJ/Qu1Xo3GN+x89xyL1rbUzahRrasdj21e+Zn6GfI+qeDTqyAChCECLzgafEnzWEJsx
         TqwZpw3KMm1lHlgdnipVf3WByb/ntonIdEqTaxUaLzIixKIjCt8JaCXeoZW5QpSvmUGR
         fDWg==
X-Gm-Message-State: AOJu0YwtTXF8KzdMWLgpTraY7ZCBW3qX5lfqQDfJGfFJT2LoEWXtshvh
	4FnHinyFWnjIj9lBIqUqycwngeezzZbYTmFzEHs=
X-Google-Smtp-Source: AGHT+IEjrQA3GC8YAYZ605VpsU18IZ6mMsKqu+CCJxCxJoo10R6PPum6k2MxheaGhmm8FC2lWjmU5g==
X-Received: by 2002:a05:6830:16ca:b0:6d3:e5c:768f with SMTP id l10-20020a05683016ca00b006d30e5c768fmr4341945otr.11.1699774507662;
        Sat, 11 Nov 2023 23:35:07 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:49b3:5400:4ff:fea5:2304])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001ca4c20003dsm2217394pli.69.2023.11.11.23.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 23:35:07 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	mhocko@suse.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH -mm 3/4] mm, security: Add lsm hook for set_mempolicy_home_node(2)
Date: Sun, 12 Nov 2023 07:34:23 +0000
Message-Id: <20231112073424.4216-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112073424.4216-1-laoar.shao@gmail.com>
References: <20231112073424.4216-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In container environment, we don't want users to bind their memory to a
specific numa node, while we want to unit control memory resource with
kubelet. Therefore, add a new lsm hook for set_mempolicy_home_node(2), then
we can enforce fine-grained control over memory policy adjustment by the
tasks in a container.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 ++
 include/linux/security.h      | 8 ++++++++
 mm/mempolicy.c                | 5 +++++
 security/security.c           | 7 +++++++
 4 files changed, 22 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 725a03d..109883e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -425,3 +425,5 @@
 	 unsigned long maxnode, unsigned int flags)
 LSM_HOOK(int, 0, set_mempolicy, int mode, const unsigned long __user *nmask,
 	 unsigned long maxnode)
+LSM_HOOK(int, 0, set_mempolicy_home_node, unsigned long start, unsigned long len,
+	 unsigned long home_node, unsigned long flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index 93c91b6a..7b7096f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -489,6 +489,8 @@ int security_mbind(unsigned long start, unsigned long len,
 		   unsigned long maxnode, unsigned int flags);
 int security_set_mempolicy(int mode, const unsigned long __user *nmask,
 			   unsigned long maxnode);
+int security_set_mempolicy_home_node(unsigned long start, unsigned long len,
+				     unsigned long home_node, unsigned long flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1413,6 +1415,12 @@ static inline int security_set_mempolicy(int mode, const unsigned long __user *n
 {
 	return 0;
 }
+
+static inline int security_set_mempolicy_home_node(unsigned long start, unsigned long len,
+						   unsigned long home_node, unsigned long flags)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0a76cd2..54106e1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1523,6 +1523,11 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 		return -EINVAL;
 	if (end == start)
 		return 0;
+
+	err = security_set_mempolicy_home_node(start, len, home_node, flags);
+	if (err)
+		return err;
+
 	mmap_write_lock(mm);
 	prev = vma_prev(&vmi);
 	for_each_vma_range(vmi, vma, end) {
diff --git a/security/security.c b/security/security.c
index 79ae17d..0a2e062 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5349,3 +5349,10 @@ int security_set_mempolicy(int mode, const unsigned long __user *nmask, unsigned
 {
 	return call_int_hook(set_mempolicy, 0, mode, nmask, maxnode);
 }
+
+int security_set_mempolicy_home_node(unsigned long start, unsigned long len,
+				     unsigned long home_node, unsigned long flags)
+{
+
+	return call_int_hook(set_mempolicy_home_node, 0, start, len, home_node, flags);
+}
-- 
1.8.3.1


