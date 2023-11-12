Return-Path: <bpf+bounces-14915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF47E8EF2
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 08:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC2C1F20F83
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 07:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFAA63D2;
	Sun, 12 Nov 2023 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvTisVuc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328B753AE
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 07:35:06 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE43330C2;
	Sat, 11 Nov 2023 23:35:05 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc5b7057d5so30587405ad.2;
        Sat, 11 Nov 2023 23:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699774505; x=1700379305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF16udhUX0adXTLrLbh6IbPub7a4ZNSYXitVXWKEGdk=;
        b=RvTisVucAWu5NecdOBh3/1u+8/7q44e5vMH89JlX1C/qC+ecV2ZEJeVxbznEZFxL+S
         x2oKVhn1jqOB7dN+bjLtt7jnaPWMY6wzb87bGYfsZvx2x6K4PJS6WG0k9A5nhAlUZuz6
         xOPF1Ayze4QlfwwYX7dfx/beikQgzQSfkZ6EIGklIq83UgPbA7DfV/iFUJLezxPIkjPr
         TcVx2SN5wS0e1S+zguJAVYqgAbvYmBt64MWGFe5gVTqW92edBdBKrfmV0w7rgkVSkOZ8
         2HgkYPX4VPySlXCoTezqB+NwIZ9FYNtA7PpIhZwf+iJPIkaJT2eg1G/elpU+mj3QWNuO
         213w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699774505; x=1700379305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF16udhUX0adXTLrLbh6IbPub7a4ZNSYXitVXWKEGdk=;
        b=VPi/3TqE9rN3lXr5sqVe6JvJe/TTHCcmKnumrm/9ubd7rsELFREI41Ioe2eAZr5bvu
         z3USPzXld075tCcG4aGb7/CKIh/ARikm5DD1yGlQUWgxW0EQ3oMeDSqxvcCgSgh8m4jf
         yg/uSZ83mwmrCpfJOyFGRiLsQQ6YTFvqI2v3GVwc0e+xY11d4ZH/WNF7UGwWTeRqdTk+
         MaruPztMahK0Hf+WLqc1Mlkov2FrgIRnvt5wnWb/3VO8VUIwwOUHTMl20qzAMY5jOVgt
         gLY3w74aWWwvhjjUBAEaD6TI4veVJhzCagy5jYf0n0L7rNC1gBNOgwkJEplbgc7gHP2g
         V2Wg==
X-Gm-Message-State: AOJu0YyiH1dt8tvlloYGbrJCQhGo+OIKaVmDOUxXJqxYSvQTxD1lC0Nl
	mNbs5bXvgiHBkGsQ75LzSNc=
X-Google-Smtp-Source: AGHT+IFRF+p6A6m+6oYptnt4iKcO5Ngi/6FUUkp6zcOzgdCiab8IHnyyrYPQ8+IHM1LVXHOf4XGC1w==
X-Received: by 2002:a17:902:f646:b0:1cc:40eb:79ae with SMTP id m6-20020a170902f64600b001cc40eb79aemr5284483plg.63.1699774505378;
        Sat, 11 Nov 2023 23:35:05 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:49b3:5400:4ff:fea5:2304])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001ca4c20003dsm2217394pli.69.2023.11.11.23.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 23:35:04 -0800 (PST)
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
Subject: [RFC PATCH -mm 1/4] mm, security: Add lsm hook for mbind(2)
Date: Sun, 12 Nov 2023 07:34:21 +0000
Message-Id: <20231112073424.4216-2-laoar.shao@gmail.com>
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
kubelet. Therefore, add a new lsm hook for mbind(2), then we can enforce
fine-grained control over memory policy adjustment by the tasks in a
container.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/lsm_hook_defs.h |  4 ++++
 include/linux/security.h      | 10 ++++++++++
 mm/mempolicy.c                |  4 ++++
 security/security.c           |  7 +++++++
 4 files changed, 25 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 99b8176..b1b5e3a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -419,3 +419,7 @@
 LSM_HOOK(int, 0, uring_sqpoll, void)
 LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
+
+LSM_HOOK(int, 0, mbind, unsigned long start, unsigned long len,
+	 unsigned long mode, const unsigned long __user *nmask,
+	 unsigned long maxnode, unsigned int flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1d1df326..9f87543 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -484,6 +484,9 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int security_mbind(unsigned long start, unsigned long len,
+		   unsigned long mode, const unsigned long __user *nmask,
+		   unsigned long maxnode, unsigned int flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1395,6 +1398,13 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+
+static inline int security_mbind(unsigned long start, unsigned long len,
+				 unsigned long mode, const unsigned long __user *nmask,
+				 unsigned long maxnode, unsigned int flags)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590e..98a378c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1483,6 +1483,10 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	if (err)
 		return err;
 
+	err = security_mbind(start, len, mode, nmask, maxnode, flags);
+	if (err)
+		return err;
+
 	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
 }
 
diff --git a/security/security.c b/security/security.c
index dcb3e70..425ec1c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5337,3 +5337,10 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
 	return call_int_hook(uring_cmd, 0, ioucmd);
 }
 #endif /* CONFIG_IO_URING */
+
+int security_mbind(unsigned long start, unsigned long len,
+		   unsigned long mode, const unsigned long __user *nmask,
+		   unsigned long maxnode, unsigned int flags)
+{
+	return call_int_hook(mbind, 0, start, len, mode, nmask, maxnode, flags);
+}
-- 
1.8.3.1


