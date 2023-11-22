Return-Path: <bpf+bounces-15652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCDC7F48B7
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280D928172A
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D0C5A119;
	Wed, 22 Nov 2023 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvuJnPvR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D80D45;
	Wed, 22 Nov 2023 06:16:26 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso5573313b3a.0;
        Wed, 22 Nov 2023 06:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700662585; x=1701267385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hrd8Q/aZ94cCzu/B8oHzIUPKN1cXCmsoH2G1FVF6YII=;
        b=PvuJnPvRDT3dFSPJQEOi0Gni+GO0isWd0WRSvU/ai6tg2xxZ4iZm7S/xl/j1ZSAMsQ
         syCcURikd+rg575FcwtJdrG48/5pHhC95gSIZPxoK1FL1uI9YTqb/W6Snm4JSG/z0Dvy
         C+VOMNREwfTrCb96GvK5KAnWMUIUOEvvOoygvu9SR/9FGpQCcsBQyJ7onfHm7S7OHqY8
         bRgbltg3bJuYjF9b9k08KGE1K1tHImRaTSPrySwlGQspPj5usqiRnEkwS3VvYhZzCoxL
         VTF3ec+EvwcfZkEjUsIlYC+0DLfxq3jS4+H8k7TvMAFZKHJNTC+SoDbNQW0ChcEcT+y/
         8qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662585; x=1701267385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hrd8Q/aZ94cCzu/B8oHzIUPKN1cXCmsoH2G1FVF6YII=;
        b=uNlKkdcpHMHt6N4nMbUZZTRcMiWiYdAUhV0T6mve+yWF0nJFMdljrr3pYZA6YSqrPZ
         zpIkOATAjjLSgpFYbPZ+5uK+7Pm74VE725bJXxYOpA1EM+fD+tLSbAiyC1chW2Jsafqf
         bJv4zGY8BctCUHAkJ7XDrWhiXYKoQ7haKJT3bP2kr2cQmPGqWhXBU6zUUHt24N+RsoCh
         msucms1GhK0ZDQdSL+LC6lKmpugieWyhJjVlPJa/+RvthuhcEAQtQfRlrthFZO9EPCr+
         UPMuzkfBx+XvpZhsUFW7yubARFtLLecYjwRSDL5hJR0XZY/NFwBTXtwhRlpmh15+RYiq
         5q+Q==
X-Gm-Message-State: AOJu0YzfR7PqAohyy66nxvcYr6wtoYUETiygcrpkeQU91Ez2KvJpgAk9
	1/flSLVArSbw9ebpa2w+yyQ=
X-Google-Smtp-Source: AGHT+IGF0KDGd0J4OzHwSICvSyOZwIZbK788qwUREZr+VnXmoQq3XSPFAWg5FrUvb1keh4HsnjevJg==
X-Received: by 2002:a05:6a20:e113:b0:18a:db62:6922 with SMTP id kr19-20020a056a20e11300b0018adb626922mr2719249pzb.35.1700662585570;
        Wed, 22 Nov 2023 06:16:25 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac01:a71:5400:4ff:fea8:5687])
        by smtp.gmail.com with ESMTPSA id p18-20020a63fe12000000b0058988954686sm9356260pgh.90.2023.11.22.06.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:16:25 -0800 (PST)
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
Subject: [RFC PATCH v2 5/6] security: selinux: Implement set_mempolicy hook
Date: Wed, 22 Nov 2023 14:15:58 +0000
Message-Id: <20231122141559.4228-6-laoar.shao@gmail.com>
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


