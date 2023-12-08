Return-Path: <bpf+bounces-17120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE385809EC9
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12FA6B20BA4
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2B511701;
	Fri,  8 Dec 2023 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqXOjMZs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F4B10FC;
	Fri,  8 Dec 2023 01:06:46 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c6ce4dffb5so1335786a12.0;
        Fri, 08 Dec 2023 01:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702026406; x=1702631206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5jNCiht2qhfhgmL/0QXVPaECx4NcLPjGSo+ppuw/OE=;
        b=bqXOjMZstiNzXCeuJFFnutI/xdHB1Mg9BPrEbSV5jPejkqMY4mw3foLuufpawJ00rU
         AqloSsi8756OhYOuNUefYfULitd/U9IYeshWi3q/X8Z2Q9nFyJoOMvg+k0eVgP46WhjG
         uS6QJH1JK3AUuGF/G6IQidPMWsrtYvBGQgTU9hC9JlyD0O4YyWBCZp0x7vKVAMrYw8uu
         XIMyRX2ye2KVknw7wz60h+xAU+LX99FEPHEfJmIKLFeMA3++Pe80O4RZ1rq7gcb2D+0U
         KxEJJ1FI2mmmb2XjOq/Xyd6Hu0lbHHjzX5Hb0M2IMeiaNE4b1ZiYz3DvEOjjUYwcOZwD
         g+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702026406; x=1702631206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5jNCiht2qhfhgmL/0QXVPaECx4NcLPjGSo+ppuw/OE=;
        b=D1L1KKWzC4637CaCl3uGcnsF7/Hf403zaH6I3TGn+YepQSh0nYPq8n9lwASbt5aYn5
         M74d5o37tSHHqqVXmYw0oDI53Rp2tK/WL5f724g+4Lqc5J7owqE1FsrVzmlmaIc4gT2M
         2N14/vc9ewj9xB/G/JSPZC9nLK+Nwww6puunYBmk7U0f7fx5VilKIMMuz0sDLLrpHrLJ
         h1niuNDEEzhEoUqXlK+25J15wb4tSGoGWXLiFCXuhKaSqIYKyDAlXNpTo15lwqRM7yN1
         IXaVsflFIeI88EPdnudRsTgSnypw9i9mv5imrpLo8QgYS0oADius9jd7sbJ5vTRx3akQ
         rUNw==
X-Gm-Message-State: AOJu0YxaZsDGL3kWMtHN8b14k9hHXjyHP1W/9V9EgubypH6pxtuKJ4QE
	fhfex7w6hMqdVL1ROx/fqSk=
X-Google-Smtp-Source: AGHT+IEJsoOkgNRvqCeC96DE0QTf43JoGq3IIKgG7QBj8teRqPSX55EqjkbrCFFIwKXuc0Teb88VDg==
X-Received: by 2002:a17:90b:38ca:b0:286:f19f:5022 with SMTP id nn10-20020a17090b38ca00b00286f19f5022mr3458016pjb.27.1702026406051;
        Fri, 08 Dec 2023 01:06:46 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:4055:5400:4ff:fead:3bd0])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d057080022sm1188173plo.20.2023.12.08.01.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:06:45 -0800 (PST)
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
Subject: [PATCH v4 3/5] mm, security: Add lsm hook for memory policy adjustment
Date: Fri,  8 Dec 2023 09:06:20 +0000
Message-Id: <20231208090622.4309-4-laoar.shao@gmail.com>
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


