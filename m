Return-Path: <bpf+bounces-16365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B9800764
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328FB1C20F3F
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB71EA73;
	Fri,  1 Dec 2023 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMkI7FMU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FE910F3;
	Fri,  1 Dec 2023 01:47:11 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d04c097e34so2721845ad.0;
        Fri, 01 Dec 2023 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701424031; x=1702028831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x2gW85qXpDm39JWWNR8xOYWTSjKi1NE52O+Y4CVIzE=;
        b=KMkI7FMU9Atz0ySZLeHG7OtdPqYVZis4QBNf0frUQoGNdhT6sqbkwyH+I3xrPDBrVa
         HS1358VQ834+DAkw0itc5MoM377WJumHC6uz/ZVxOqXXj8xSnAQ17cL5F7n1aU9Tcdq4
         qKJ8gVoaQaIdb2lEGWVwXyguZKANvWRyn9az2TGeY29yKTiN7WHYWFamkIGSzAMFki0B
         oWHOhFBB/njSUdLAFwLIveWR/XfGCQDTQ//PTBlW6aYsoKnQkzHdzM+C2rKcmjaaL8GT
         LE+vNg0LiN6eGDnYdrePZ2sabdRT7cDkDZmWf0KFwzT3dU5hEZf+2iw/mau7oCIWEKDe
         wYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424031; x=1702028831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+x2gW85qXpDm39JWWNR8xOYWTSjKi1NE52O+Y4CVIzE=;
        b=rgl6yFHal3ZhwgieBT8jPzUsLrmVzBCu9ljf37d4I4JPeQNoL4ETFL1/NLkvk/Jc3W
         fdhZZ9VM2CILg599Ra0PuhiPS5Fl2IdinSRIdgCFasitoRglBWWXRWfZ6zXGnV2Bb5Yn
         LTG9b8E25gxp3z9iB5+whdaWunKGiFxnBAirb2YpXrs5A98MUVfOh9gsd+QZ+lrkUrdw
         uInpUBxONjZmcBR2S4GZtWJcpxmBgwHTdpr//jOWqAACl+g8epCtFQ9hW9wlanRo4G50
         GSzkPeetrrsbhW3vhH75wrNuIEcRUYbTdOc638WF+8NAAKaJ9HecDVc5RRcMfCtUq00g
         G4gA==
X-Gm-Message-State: AOJu0YxwYsi8lx+xQViLVA2G2u3mC10dbEbhgE0SnM8NhwMRU6AlX1Sb
	IwaF4d6Ov23xaBogtdWqwh8=
X-Google-Smtp-Source: AGHT+IEfi8CntkWgmrNALbbEki4QUlWGaiYFcUK8uZQCNPbFfdkSpNYq2ORQNXwcZZsO/tOOLRY9fA==
X-Received: by 2002:a17:903:447:b0:1d0:5302:4642 with SMTP id iw7-20020a170903044700b001d053024642mr1803858plb.16.1701424031283;
        Fri, 01 Dec 2023 01:47:11 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001bdd7579b5dsm2875534pls.240.2023.12.01.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:47:10 -0800 (PST)
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
Subject: [PATCH v3 4/7] mm, security: Add lsm hook for memory policy adjustment
Date: Fri,  1 Dec 2023 09:46:33 +0000
Message-Id: <20231201094636.19770-5-laoar.shao@gmail.com>
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

In a containerized environment, independent memory binding by a user can
lead to unexpected system issues or disrupt tasks being run by other users
on the same server. If a user genuinely requires memory binding, we will
allocate dedicated servers to them by leveraging kubelet deployment.

At present, users have the capability to bind their memory to a specific
node without explicit agreement or authorization from us. Consequently, a
new LSM hook is introduced to mitigate this. This implementation allows us
to exercise fine-grained control over memory policy adjustments within our
container environment

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/lsm_hook_defs.h |  3 +++
 include/linux/security.h      |  9 +++++++++
 mm/mempolicy.c                |  8 ++++++++
 security/security.c           | 13 +++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ff217a5ce552..558012719f98 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -419,3 +419,6 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
 LSM_HOOK(int, 0, uring_sqpoll, void)
 LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
+
+LSM_HOOK(int, 0, set_mempolicy, unsigned long mode, unsigned short mode_flags,
+	 nodemask_t *nmask, unsigned int flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1d1df326c881..cc4a19a0888c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -484,6 +484,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int security_set_mempolicy(unsigned long mode, unsigned short mode_flags,
+			   nodemask_t *nmask, unsigned int flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1395,6 +1397,13 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+
+static inline int
+security_set_mempolicy(unsigned long mode, unsigned short mode_flags,
+		       nodemask_t *nmask, unsigned int flags)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1eafe81d782e..9a260dd24a4b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1495,6 +1495,10 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	if (err)
 		return err;
 
+	err = security_set_mempolicy(lmode, mode_flags, &nodes, flags);
+	if (err)
+		return err;
+
 	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
 }
 
@@ -1589,6 +1593,10 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	if (err)
 		return err;
 
+	err = security_set_mempolicy(lmode, mode_flags, &nodes, 0);
+	if (err)
+		return err;
+
 	return do_set_mempolicy(lmode, mode_flags, &nodes);
 }
 
diff --git a/security/security.c b/security/security.c
index dcb3e7014f9b..685ad7993753 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5337,3 +5337,16 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
 	return call_int_hook(uring_cmd, 0, ioucmd);
 }
 #endif /* CONFIG_IO_URING */
+
+/**
+ * security_set_mempolicy() - Check if memory policy can be adjusted
+ * @mode: The memory policy mode to be set
+ * @mode_flags: optional mode flags
+ * @nmask: modemask to which the mode applies
+ * @flags: mode flags for mbind(2) only
+ */
+int security_set_mempolicy(unsigned long mode, unsigned short mode_flags,
+			   nodemask_t *nmask, unsigned int flags)
+{
+	return call_int_hook(set_mempolicy, 0, mode, mode_flags, nmask, flags);
+}
-- 
2.30.1 (Apple Git-130)


