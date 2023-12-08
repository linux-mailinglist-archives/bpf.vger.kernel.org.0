Return-Path: <bpf+bounces-17121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FD1809ECA
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373EA1C20925
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 09:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72811CAF;
	Fri,  8 Dec 2023 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtlA6IcU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C2171C;
	Fri,  8 Dec 2023 01:06:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d1e1edb10bso16931185ad.1;
        Fri, 08 Dec 2023 01:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702026407; x=1702631207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NLQupAZumzbZoKpNAG12sWAtAVUuthZdQhUM0QKlyo=;
        b=KtlA6IcUmzvgdy5ncakz9CcbDOjJ4sdpwTW4jleIsGbMjCZc+UMiClM4e8ffvQF5Dy
         imItZQg9jpMDglEaNc2n/Gni4OfqpcoYG3F/uDw7ODfgo63GCtURiD1Qgg3s5OERDa89
         BRPnjdkBw/wwrnbsYrbr2XAXetO32mPLrJcV7n8lukiO2ivWjaU31+++P4RaxhsxDem4
         /YAMreuvVEyIE882fegqaewhMftkillwtqdDNZaUnL5L1GAGlI5MXbaOcgwn3Ko0bQSz
         pmWFsOK+8qMK0RIrVYIeyN9TlUbDsjMQ0491ytPKHLRpQPZdiSMnsFs/m4nOXSt1azY7
         bQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702026407; x=1702631207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NLQupAZumzbZoKpNAG12sWAtAVUuthZdQhUM0QKlyo=;
        b=akWobL6NxqWVBSH1aM+DeIin8bJbx6FYQw8Jfu+o6iLITjGd4VMInSUQqQJ4lnLuo8
         hKMON58Jx2b0rrWu8GyGysTxItt1khv7IcectLnqXDGZRXDFZtb3S3RUuLRSX3zlKfZt
         9LFxGX2PjWXjkSH4LctFOK6lOHi/F7oZ2GmywhzsHuP9Df+nhH2rMbSsQNGTDi8dbTxS
         td6vUkfkcM8UyvBJfHJn01r5CuziDdc3g/mBgEbytI5tSouMkkpuinwegDUwuxPgsjbD
         0MVCPEwH1OPf1RRKF4S23w0B5Nu8dcKGgp09654fqGZqkL+XpGxQ03Brcu9YFjXk0vgP
         npHQ==
X-Gm-Message-State: AOJu0YxHcb4+ER2XD/VaN4d1FTytaocTAX1HK+mYa8glEV7nItg7yehj
	KNqX20Ldoq1hGtA8doqQUDo=
X-Google-Smtp-Source: AGHT+IFZVEkMU90veuH9AP4AV43iIfPMyna/tHibWLIRr/K+v5B3aBILYxNOBzTd1wYRXklDq0Kt2w==
X-Received: by 2002:a17:903:41ce:b0:1d0:7c31:197e with SMTP id u14-20020a17090341ce00b001d07c31197emr4774284ple.57.1702026407392;
        Fri, 08 Dec 2023 01:06:47 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:4055:5400:4ff:fead:3bd0])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d057080022sm1188173plo.20.2023.12.08.01.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:06:46 -0800 (PST)
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
Subject: [PATCH v4 4/5] security: selinux: Implement set_mempolicy hook
Date: Fri,  8 Dec 2023 09:06:21 +0000
Message-Id: <20231208090622.4309-5-laoar.shao@gmail.com>
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

Add a SELinux access control for the newly introduced set_mempolicy lsm
hook. A new permission "setmempolicy" is defined under the "process" class
for it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 security/selinux/hooks.c            | 8 ++++++++
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index feda711..1528d4d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4238,6 +4238,13 @@ static int selinux_userns_create(const struct cred *cred)
 			USER_NAMESPACE__CREATE, NULL);
 }
 
+static int selinux_set_mempolicy(unsigned long mode, unsigned short mode_flags,
+				 nodemask_t *nmask, unsigned int flags)
+{
+	return avc_has_perm(current_sid(), task_sid_obj(current), SECCLASS_PROCESS,
+			    PROCESS__SETMEMPOLICY, NULL);
+}
+
 /* Returns error only if unable to parse addresses */
 static int selinux_parse_skb_ipv4(struct sk_buff *skb,
 			struct common_audit_data *ad, u8 *proto)
@@ -7072,6 +7079,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 	LSM_HOOK_INIT(task_kill, selinux_task_kill),
 	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
 	LSM_HOOK_INIT(userns_create, selinux_userns_create),
+	LSM_HOOK_INIT(set_mempolicy, selinux_set_mempolicy),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
 	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index a3c3807..c280d92 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -51,7 +51,7 @@
 	    "getattr", "setexec", "setfscreate", "noatsecure", "siginh",
 	    "setrlimit", "rlimitinh", "dyntransition", "setcurrent",
 	    "execmem", "execstack", "execheap", "setkeycreate",
-	    "setsockcreate", "getrlimit", NULL } },
+	    "setsockcreate", "getrlimit", "setmempolicy", NULL } },
 	{ "process2",
 	  { "nnp_transition", "nosuid_transition", NULL } },
 	{ "system",
-- 
1.8.3.1


