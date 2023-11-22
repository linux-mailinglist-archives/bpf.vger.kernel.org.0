Return-Path: <bpf+bounces-15651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208C7F48B6
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DB8B212C6
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1703258114;
	Wed, 22 Nov 2023 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+zK/skz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FCE101;
	Wed, 22 Nov 2023 06:16:24 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab56so3026856b3a.3;
        Wed, 22 Nov 2023 06:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700662584; x=1701267384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/MT70BN3YE30s8hUB70yCLmTZgANuDoSG8Z4XUzLV4=;
        b=T+zK/skzhDiebKP4Rt3BTLsdRCSKtV8NZ3RNSY1sGbnA0CERKiJ+IVZ1Ul/kHFXbqe
         Bwz7IySrK6Q/LwHMgyvW8L9CvUKRIo/sZvoaxuOgoAvDfQPiKeKAyueR8z2cg8q7iu63
         uUwjojG641ZxDgAFSZB9D1S4ga78cxQt5crhqCh5bJLzoEU50dBWafUpk+L3VZ5IgJlm
         jLAXyOP3g8zUfugxJHdIy3omzQn8p+99EPbwScSMWMfMlBdrjfagpOU+YeaWZedwMLVi
         k6Lb4kbcs4b4yKTkOrJ8pXnHIs2b+Xm68AX6eqaT2m6StAdHSYbkmuaToR3DieWoB+sF
         UEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662584; x=1701267384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/MT70BN3YE30s8hUB70yCLmTZgANuDoSG8Z4XUzLV4=;
        b=fIo06SHPjQP8g1wFL+wDa2FdrW5xQMS+WzzCNf7k/uomhWmHa7kaCFzAldWXzNns3s
         WVwjMapOJ6Z+EdXgi4lE4RLFWZwYLQMEnhSxM4wClPUffhivBrMJuJEBkFxQsOtTirEV
         EvKBTcXXOFQjPbOQdQ9mNQAcfzWjYA/VLzZz5w2HSS+L5+Zo7j7n1MRg+I48TFh5wicI
         yVTH3JhdTGLaCYTAaEJHyWutgW2fCogbdkgUCgzawQk1TLck8Fbs7ZZUT4ELONNduoZj
         10hOthkFxyuhmsT052GxYFq22NE6amnLWE827PuG7hPSkzZm2dcZgqkWg53iDxZxZZFH
         qSiQ==
X-Gm-Message-State: AOJu0YymEXdcdhZWQYMgNMS09XYMCBl4hosm8PxLFO8G6M9c+u35Z99C
	2Erx8YKElrqXT+LbMYn5nFk=
X-Google-Smtp-Source: AGHT+IHBbCOf8ziLWGyNkSYBub43r5HaSVROiW9/4GVd+5hMyRcAH/fQNAV5DPcevfm6AUJFh0U55A==
X-Received: by 2002:a05:6a20:54a4:b0:18b:4c44:d09 with SMTP id i36-20020a056a2054a400b0018b4c440d09mr1612194pzk.0.1700662584215;
        Wed, 22 Nov 2023 06:16:24 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac01:a71:5400:4ff:fea8:5687])
        by smtp.gmail.com with ESMTPSA id p18-20020a63fe12000000b0058988954686sm9356260pgh.90.2023.11.22.06.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:16:23 -0800 (PST)
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 4/6] mm, security: Add lsm hook for memory policy adjustment
Date: Wed, 22 Nov 2023 14:15:57 +0000
Message-Id: <20231122141559.4228-5-laoar.shao@gmail.com>
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
index ded2e0e62e24..aa09198cbd29 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1490,6 +1490,10 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	if (err)
 		return err;
 
+	err = security_set_mempolicy(lmode, mode_flags, &nodes, flags);
+	if (err)
+		return err;
+
 	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
 }
 
@@ -1584,6 +1588,10 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
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


