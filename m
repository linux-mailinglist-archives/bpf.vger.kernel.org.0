Return-Path: <bpf+bounces-14916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321157E8EF4
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 08:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1BDB20A2E
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 07:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0329A6D3F;
	Sun, 12 Nov 2023 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co/wzYau"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015553B4
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 07:35:07 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C262D61;
	Sat, 11 Nov 2023 23:35:07 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2809414efa9so2807122a91.1;
        Sat, 11 Nov 2023 23:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699774506; x=1700379306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYdTWpyOP7c7R9n9smRutRRnuRGusrKmaHsoBCdqEUQ=;
        b=co/wzYauKRvgg2aZ2evl03J5YXNh6Uh+91uut8t/qsN6vEbgQgpmWyETHOrRtsAs8Q
         El9rDmUsLZiYmoxA2JXvA6g7wWezXAJvDO6wWT+ayb9jXMRNYn80r8ue9WmtUDtgMrkk
         lN4/xeTBaPgMV0xjgv8y8ssV4Bcu7i9XTgvU5shOeQSa7xLAVovKgsDv34EviqizoRhB
         L9ws22nl6oA8UxLj8bfSvE1lM74YAFRNBhmMi+mF3yBSwRrYEibfTvPtkOWzrU3c6nmA
         cHCQ/t3LcLPqjIaAdpT3rQyMYLYCBM8cuPXrh5oK/2SdGAwcfgjzp1uKc1uBGQq+NSfd
         OUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699774506; x=1700379306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYdTWpyOP7c7R9n9smRutRRnuRGusrKmaHsoBCdqEUQ=;
        b=Qk2bJcZUKjACeBPSyCvqdApMsUvvbmg0yec7XqIpEm+EgxQkiglVQGe5CQLNkTaFXG
         roI+bEeA1AXyQ0ALFFVy7thYhlMw2jrSKYdCn4UQ8CXUq37mT6UAc6JUDDraExPBJuEw
         tvT3lke8A/G2D1ULMLxTJ//aZeSIqLECSsDpF0EEr//OG1FCHl3l24nn6Q71bD1KAhvg
         lgLeAuk0VtLQJmgxZfNSm7qPNiltJ1ZGHWF7wYk68zXZOjuT0+2bhA3/C63NJYCwh88t
         bONZJlyKBQ7huF0l+24yjK7Qnj4glOLwfCRDp0aZ2CVXM0/X3v3rIDm+HPe6vv2UNV+/
         GeSA==
X-Gm-Message-State: AOJu0YztO74OkLullIecMpziHp+wRbhLNmTLC5GG8POiGkRpySlUFihB
	mnedCrrwvg9vtWP4PBJHtNo=
X-Google-Smtp-Source: AGHT+IHjlVvRXpoL792rjf7RUUS52eXc/ptj/2L/sng6wD12M2FPp02r4/UYbl9EPmrQlc3ZHvc0Tw==
X-Received: by 2002:a17:90b:4b0b:b0:281:b37:2038 with SMTP id lx11-20020a17090b4b0b00b002810b372038mr2194799pjb.1.1699774506515;
        Sat, 11 Nov 2023 23:35:06 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:49b3:5400:4ff:fea5:2304])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001ca4c20003dsm2217394pli.69.2023.11.11.23.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 23:35:06 -0800 (PST)
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
Subject: [RFC PATCH -mm 2/4] mm, security: Add lsm hook for set_mempolicy(2)
Date: Sun, 12 Nov 2023 07:34:22 +0000
Message-Id: <20231112073424.4216-3-laoar.shao@gmail.com>
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
kubelet. Therefore, add a new lsm hook for set_mempolicy(2), then we can
enforce fine-grained control over memory policy adjustment by the tasks in
a container.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 ++
 include/linux/security.h      | 8 ++++++++
 mm/mempolicy.c                | 4 ++++
 security/security.c           | 5 +++++
 4 files changed, 19 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index b1b5e3a..725a03d 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -423,3 +423,5 @@
 LSM_HOOK(int, 0, mbind, unsigned long start, unsigned long len,
 	 unsigned long mode, const unsigned long __user *nmask,
 	 unsigned long maxnode, unsigned int flags)
+LSM_HOOK(int, 0, set_mempolicy, int mode, const unsigned long __user *nmask,
+	 unsigned long maxnode)
diff --git a/include/linux/security.h b/include/linux/security.h
index 9f87543..93c91b6a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -487,6 +487,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_mbind(unsigned long start, unsigned long len,
 		   unsigned long mode, const unsigned long __user *nmask,
 		   unsigned long maxnode, unsigned int flags);
+int security_set_mempolicy(int mode, const unsigned long __user *nmask,
+			   unsigned long maxnode);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1405,6 +1407,12 @@ static inline int security_mbind(unsigned long start, unsigned long len,
 {
 	return 0;
 }
+
+static inline int security_set_mempolicy(int mode, const unsigned long __user *nmask,
+					 unsigned long maxnode)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 98a378c..0a76cd2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1581,6 +1581,10 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	if (err)
 		return err;
 
+	err = security_set_mempolicy(mode, nmask, maxnode);
+	if (err)
+		return err;
+
 	return do_set_mempolicy(lmode, mode_flags, &nodes);
 }
 
diff --git a/security/security.c b/security/security.c
index 425ec1c..79ae17d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5344,3 +5344,8 @@ int security_mbind(unsigned long start, unsigned long len,
 {
 	return call_int_hook(mbind, 0, start, len, mode, nmask, maxnode, flags);
 }
+
+int security_set_mempolicy(int mode, const unsigned long __user *nmask, unsigned long maxnode)
+{
+	return call_int_hook(set_mempolicy, 0, mode, nmask, maxnode);
+}
-- 
1.8.3.1


