Return-Path: <bpf+bounces-17820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5F8813099
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718DC1F212CD
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B23D4E614;
	Thu, 14 Dec 2023 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6kiN4Qf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07601128;
	Thu, 14 Dec 2023 04:51:47 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6d089e8b1b2so2981831b3a.3;
        Thu, 14 Dec 2023 04:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702558307; x=1703163107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NLQupAZumzbZoKpNAG12sWAtAVUuthZdQhUM0QKlyo=;
        b=J6kiN4QfixXuDKgDz0tUKRaKWkxF2HGVa13+74hYzIn7jDHWIozSEIfq134WE0/BbA
         vL+YFIbckugPuoaYmeyGS/GZ9goapr+zqKUoUv+feNL1W0jW7VbHgJG6pAF8+tct8Kzh
         IZyqCtJaYwAIrejDDIHmhIq2mDvrxQ+65q1k52DsCqKsB+hKxWmKqCgtw4srZ19cbJIL
         siN3zpXSn4oOTba+VzO+8BeT4dCjWqUcyTkkBjNbnwKDSOaE3FKRtnLwEQd3IhTe9guW
         dQKPEKSyObjeq52RLYNLvZFPdhogU6shZlx3huMpFnz8na7VHmSKLknKPKKyxfckMBnA
         s3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558307; x=1703163107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NLQupAZumzbZoKpNAG12sWAtAVUuthZdQhUM0QKlyo=;
        b=IjiAhpt1TNsEbCGw9mlKRszWvqAOXoAJDbHQo1v7xMJZG6LHzpQaKRpCs6s1ShU1YR
         FPgaX+6N52OGO8cIwX2S73oLzRykdaIPnr0WvynjVx3b6C8KG33LXrQLWCCdvSwRKfWq
         ku8fT+qTgsA7mWxPa970JtZvpKjK+YhziHFRimcSba3AUQwEbjMNMIwWXK86GfkqpGkS
         mQewr/AP4MT0sIXMzGsHo7ZoLfM3O09czjalR0EP38khWyPGq6Zq3roqsLu2XPFVOsYC
         u3FQxIToH5h1CG05rhcO91ec/WnDIBCp5hMkFcMdaYt/O68JVeMZ1Xn9ZVv8DzR0Kj34
         6RZw==
X-Gm-Message-State: AOJu0Yy+43m6MY0DxZ4HPIlfKYPXa2XuU7pG9RDvMUXIoeaZhhaOTVbI
	1/3NqBJ33G3eB0Dv3g+DN9I=
X-Google-Smtp-Source: AGHT+IFyrMV98A56t+dmpjQI6o3tD3UVYHPGWsTpR7EYC7ExrRnRkFX6PbWwWnOn+9SdsmHBpk2UrQ==
X-Received: by 2002:a05:6a20:13cc:b0:190:2c2f:7df9 with SMTP id ho12-20020a056a2013cc00b001902c2f7df9mr4835222pzc.64.1702558307403;
        Thu, 14 Dec 2023 04:51:47 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001d36b2e3dddsm1184528plb.192.2023.12.14.04.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:51:46 -0800 (PST)
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
Subject: [PATCH v5 bpf-next 4/5] security: selinux: Implement set_mempolicy hook
Date: Thu, 14 Dec 2023 12:50:32 +0000
Message-Id: <20231214125033.4158-5-laoar.shao@gmail.com>
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


