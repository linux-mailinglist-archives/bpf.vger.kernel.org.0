Return-Path: <bpf+bounces-17819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01EB813097
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A2C1F21E95
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523005103C;
	Thu, 14 Dec 2023 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbj0UF/c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8819511A;
	Thu, 14 Dec 2023 04:51:46 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d098b87eeeso72653015ad.0;
        Thu, 14 Dec 2023 04:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702558306; x=1703163106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5jNCiht2qhfhgmL/0QXVPaECx4NcLPjGSo+ppuw/OE=;
        b=lbj0UF/czrwp8t93IhuIP3Tp59KiXHHqFe02TFhw9/YTCYda+hcaBy7dRQhn5dIAdO
         b96mL778dDXIgvvkwxfEUmXe1HS0LEfjvKEebSNjcQV3EgA1ZViL9u0RFpayP03/t5e5
         GG38BRpqgShy032YBa6CT45lV5HTEXSj3a1l5pjO7F6uMqgDgvB3J4Z0qdZIOd5rWCrt
         w30ZZD0k+MBgiiWXRcREvLyMat3beG6eJyDYRMfDvBWsIJKCnqjjt+pMbaHL7nwQX+Gm
         IYgGm9y1Y3NLn3/l3Q4blg8OO6hct5qVPGOhTb1/aKQGAaaturdOXaO5kica/US+YdRj
         vGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558306; x=1703163106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5jNCiht2qhfhgmL/0QXVPaECx4NcLPjGSo+ppuw/OE=;
        b=ceC9OFq5mwPGzGeaL5xfzLcmDfnve44icPSK2v/K6c5xox7O/KWVvFjzHSS/xmSUZj
         OP4ZpS3YEdIOAF2D7x448TEgJnYa2UbX3ESl+Bd4H8p5uouM9luZErs2IrQrhWROoa39
         i6428L1uQlign26G7uINFdlf26MwiEzf+JsHZiCkqJkVrHyN/zDl+htLH1hsJks0Arp3
         bKsJ1eAMeKtHBeIefKrlAQrtvf+ZlW9yujKn+c/hG+2/2WyxJUNeFE1wsddjjG3U/TXH
         GaXob34tjlkeEM78cVxnOLdVVVhEy8GT8QjCM0l9hESOL5v0bn7Xy1tuWxWaxsCFpqUu
         EfDQ==
X-Gm-Message-State: AOJu0YxKroIB/ljMt6vSOubHyLL/jfYoo9GrcNAjWHL96bRkVYUVWfns
	hOYzdIcPPh+WAlkBOXdsygw=
X-Google-Smtp-Source: AGHT+IGpqBwIV6/Z1bJz2uXsgixmwbGfGPBUTyaTQL8gEPBIKToLlEPZWt43poMVRrkjwahDoJ6KPg==
X-Received: by 2002:a17:903:22c1:b0:1d0:6ffd:9e2a with SMTP id y1-20020a17090322c100b001d06ffd9e2amr10329616plg.124.1702558305872;
        Thu, 14 Dec 2023 04:51:45 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001d36b2e3dddsm1184528plb.192.2023.12.14.04.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:51:45 -0800 (PST)
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
Subject: [PATCH v5 bpf-next 3/5] mm, security: Add lsm hook for memory policy adjustment
Date: Thu, 14 Dec 2023 12:50:31 +0000
Message-Id: <20231214125033.4158-4-laoar.shao@gmail.com>
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
index ff217a5..5580127 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -419,3 +419,6 @@
 LSM_HOOK(int, 0, uring_sqpoll, void)
 LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
+
+LSM_HOOK(int, 0, set_mempolicy, unsigned long mode, unsigned short mode_flags,
+	 nodemask_t *nmask, unsigned int flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1d1df326..cc4a19a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -484,6 +484,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
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
index 10a590e..9535d9e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1483,6 +1483,10 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	if (err)
 		return err;
 
+	err = security_set_mempolicy(lmode, mode_flags, &nodes, flags);
+	if (err)
+		return err;
+
 	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
 }
 
@@ -1577,6 +1581,10 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	if (err)
 		return err;
 
+	err = security_set_mempolicy(lmode, mode_flags, &nodes, 0);
+	if (err)
+		return err;
+
 	return do_set_mempolicy(lmode, mode_flags, &nodes);
 }
 
diff --git a/security/security.c b/security/security.c
index dcb3e70..685ad79 100644
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
1.8.3.1


