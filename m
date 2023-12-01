Return-Path: <bpf+bounces-16369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9F180076B
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F72B2123D
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DA01E524;
	Fri,  1 Dec 2023 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ06Gg5Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D310F9;
	Fri,  1 Dec 2023 01:47:12 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cd97c135e8so1753573b3a.0;
        Fri, 01 Dec 2023 01:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701424032; x=1702028832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hrd8Q/aZ94cCzu/B8oHzIUPKN1cXCmsoH2G1FVF6YII=;
        b=WJ06Gg5Y2l0Kve01pUObWIYRfzTPMdp0PZNSOMDGHrWbopIJpkaoyJbGoHGI1vqxhr
         NsRC4eE8mV4Yyy1+ruwfc5mTiI3hu1s/XzDXNE1GjHKnB5T3k7K+BjmWzz1r/UvQUbqq
         VoMp0P/AaOEB9+D8/81Gp5PqQvAknnqvz/4f8ubAeZ9D6I/PVtgR0DQeFKign+pUoryQ
         WsLWl1tPt7UAyxb7w2V+jNWROQt18MStBUCvbzE/naGvBjyNyFTEKbMSnLZMbuWA5FHq
         /CU37492EsQi9UKUz6Id5AF+wZpTnz6cb/V447UuUdmz4KY6XByRq0Oow7viuGfss5jh
         0+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424032; x=1702028832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hrd8Q/aZ94cCzu/B8oHzIUPKN1cXCmsoH2G1FVF6YII=;
        b=M5JSXQGW9rae2V2Sp3ukwlQ0AB6CmTOPjZ/ng2fcHQC1WNjn7n/fjRhGyDCXLr1bs2
         zB/dBPtXbhJp1uDYXQNX1Sr8RGSY+P4BzO7ApniYn3XTtqo8naSHLOAKj60JDk9zrdk7
         dN9X90vvh6+l/UdiH3t4A1tC/HeHJ+uWtib5neg5+fuslJoJMGv7ZIR9E0Qp+xQGZq8v
         wbL9RfqiIJ6yhaPjHGrEMO5dDhP8XChqAjCfB8pbJLYQjAlICooweNIKkoFl3UDpd/cQ
         A47hqAosdGhriDJLAL9dK+nIo+/m7HBPIo45kzgqi2LG3ulVno9ta90l/PDLnYsWoy21
         A2Lg==
X-Gm-Message-State: AOJu0YxDs7nARNnlXLUgOZMHg3JGjcB0eHdmxD/WuBcfMG0mhp69nSfN
	MUcoyhEZBcpZwht/a4xDAfI=
X-Google-Smtp-Source: AGHT+IGTfBMOdaKabUHzgD6/ex7gttFCAVl5dyu04ZCxUj3YMK/ifw1iGQwqNjXNRb2rj7NPqQSuqQ==
X-Received: by 2002:a05:6a21:6215:b0:16c:b5ce:50f with SMTP id wm21-20020a056a21621500b0016cb5ce050fmr19689003pzb.32.1701424032510;
        Fri, 01 Dec 2023 01:47:12 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001bdd7579b5dsm2875534pls.240.2023.12.01.01.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:47:12 -0800 (PST)
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
Subject: [PATCH v3 5/7] security: selinux: Implement set_mempolicy hook
Date: Fri,  1 Dec 2023 09:46:34 +0000
Message-Id: <20231201094636.19770-6-laoar.shao@gmail.com>
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

Add a SELinux access control for the newly introduced set_mempolicy lsm
hook. A new permission "setmempolicy" is defined under the "process" class
for it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 security/selinux/hooks.c            | 8 ++++++++
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index feda711c6b7b..1528d4dcfa03 100644
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
@@ -7072,6 +7079,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_kill, selinux_task_kill),
 	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
 	LSM_HOOK_INIT(userns_create, selinux_userns_create),
+	LSM_HOOK_INIT(set_mempolicy, selinux_set_mempolicy),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
 	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index a3c380775d41..c280d92a409f 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -51,7 +51,7 @@ const struct security_class_mapping secclass_map[] = {
 	    "getattr", "setexec", "setfscreate", "noatsecure", "siginh",
 	    "setrlimit", "rlimitinh", "dyntransition", "setcurrent",
 	    "execmem", "execstack", "execheap", "setkeycreate",
-	    "setsockcreate", "getrlimit", NULL } },
+	    "setsockcreate", "getrlimit", "setmempolicy", NULL } },
 	{ "process2",
 	  { "nnp_transition", "nosuid_transition", NULL } },
 	{ "system",
-- 
2.30.1 (Apple Git-130)


