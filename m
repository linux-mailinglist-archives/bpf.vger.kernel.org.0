Return-Path: <bpf+bounces-52882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B478A49F72
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B03B1752A0
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB8B26F444;
	Fri, 28 Feb 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ffjOMyu8"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B053327293A;
	Fri, 28 Feb 2025 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761626; cv=none; b=r0s+xZqd9+dgPCTDbJWH0d5m0YoN72b4qnXwFJu8nwndP8Z+jZW+6x2bZIkGSMrUolWwm91VSD0RYIPD8EMA+5pDKczeCfKpHjcYQZ6n30Xt5TGZ2L8nOESYvYoJz+Ts9NO4D47llE8KRqYeNdgrPr+lFj/ZwFMhyFMJy3xt5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761626; c=relaxed/simple;
	bh=2oBlTVf6E8P4THjqzouUPSdIiUYD516KtZWs0B5rex0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVirW5LugTD8ssgpcbJVDTOk7naZzWFFoJGShTpaWfiqLbLYW808BbAN5jOMfSNPkVjOYe0qHZyVPmg+PYo3BgFbZwhb6W9rnkuMwHeTeLAwbMfksuEmBe6Rq7Sk5F/HWWaklBeMOA0wqOMPMhrllzhy+Sa4qZkZYzPNbPjczOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ffjOMyu8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id B1599210D0D7;
	Fri, 28 Feb 2025 08:53:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1599210D0D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740761622;
	bh=Kd2xDhnVQ6n8wTl/L2o712QKmpFi3iFfyfWXq6CW/qo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ffjOMyu8HeDhrLANUDWKRpvzuUuPwy59TXqN1MlqvgTvwIqYSI/Wagpz/YIkc/anv
	 z+0+m7c4wfoFWVxAPBj8TBYkRWug1gUxx6nHhjaztnX1XhYfpZMxE0b2yrEZmgdLfr
	 JTuYnhYtN3psg/X72I8/wfizzHkwrWIw8rIRtJ4c=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	bboscaccy@linux.microsoft.com
Subject: [PATCH 1/1] security: Propagate caller information in bpf hooks
Date: Fri, 28 Feb 2025 08:53:05 -0800
Message-ID: <20250228165322.3121535-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228165322.3121535-1-bboscaccy@linux.microsoft.com>
References: <20250228165322.3121535-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain bpf syscall subcommands are available for usage from both
userspace and the kernel. LSM modules or eBPF gatekeeper programs may
need to take a different course of action depending on whether or not
a BPF syscall originated from the kernel or userspace.

Additionally, some of the bpf_attr struct fields contain pointers to
arbitrary memory. Currently the functionality to determine whether or
not a pointer refers to kernel memory or userspace memory is exposed
to the bpf verifier, but that information is missing from various LSM
hooks.

Here we augment the LSM hooks to provide this data, by simply passing
a boolean flag indicating whether or not the call originated in the
kernel, in any hook that contains a bpf_attr struct that corresponds
to a subcommand that may be called from the kernel.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/linux/lsm_hook_defs.h |  6 +++---
 include/linux/security.h      | 12 ++++++------
 kernel/bpf/syscall.c          | 10 +++++-----
 security/security.c           | 17 ++++++++++-------
 security/selinux/hooks.c      |  6 +++---
 5 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index e2f1ce37c41ef..25f4e74c173be 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -426,14 +426,14 @@ LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
-LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
+LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, bool is_kernel, unsigned int size)
 LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
 LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
 LSM_HOOK(int, 0, bpf_map_create, struct bpf_map *map, union bpf_attr *attr,
-	 struct bpf_token *token)
+	 bool is_kernel, struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf_map *map)
 LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
-	 struct bpf_token *token)
+	 bool is_kernel, struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
 LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr,
 	 const struct path *path)
diff --git a/include/linux/security.h b/include/linux/security.h
index 980b6c207cade..549936a2a4278 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2249,14 +2249,14 @@ struct bpf_map;
 struct bpf_prog;
 struct bpf_token;
 #ifdef CONFIG_SECURITY
-extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int size);
+extern int security_bpf(int cmd, union bpf_attr *attr, bool is_kernel, unsigned int size);
 extern int security_bpf_map(struct bpf_map *map, fmode_t fmode);
 extern int security_bpf_prog(struct bpf_prog *prog);
 extern int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
-				   struct bpf_token *token);
+				   bool is_kernel, struct bpf_token *token);
 extern void security_bpf_map_free(struct bpf_map *map);
 extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
-				  struct bpf_token *token);
+				  bool is_kernel, struct bpf_token *token);
 extern void security_bpf_prog_free(struct bpf_prog *prog);
 extern int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
 				     const struct path *path);
@@ -2265,7 +2265,7 @@ extern int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cm
 extern int security_bpf_token_capable(const struct bpf_token *token, int cap);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
-					     unsigned int size)
+			       bool is_kernel, unsigned int size)
 {
 	return 0;
 }
@@ -2281,7 +2281,7 @@ static inline int security_bpf_prog(struct bpf_prog *prog)
 }
 
 static inline int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
-					  struct bpf_token *token)
+					  bool is_kernel, struct bpf_token *token)
 {
 	return 0;
 }
@@ -2290,7 +2290,7 @@ static inline void security_bpf_map_free(struct bpf_map *map)
 { }
 
 static inline int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
-					 struct bpf_token *token)
+					 bool is_kernel, struct bpf_token *token)
 {
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 694a675769a60..e2d9a1e0c1188 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1306,7 +1306,7 @@ static bool bpf_net_capable(void)
 
 #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
 /* called via syscall */
-static int map_create(union bpf_attr *attr)
+static int map_create(union bpf_attr *attr, bool is_kernel)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
@@ -1498,7 +1498,7 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
 
-	err = security_bpf_map_create(map, attr, token);
+	err = security_bpf_map_create(map, attr, is_kernel, token);
 	if (err)
 		goto free_map_sec;
 
@@ -2947,7 +2947,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err < 0)
 		goto free_prog;
 
-	err = security_bpf_prog_load(prog, attr, token);
+	err = security_bpf_prog_load(prog, attr, uattr.is_kernel, token);
 	if (err)
 		goto free_prog_sec;
 
@@ -5776,13 +5776,13 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	if (copy_from_bpfptr(&attr, uattr, size) != 0)
 		return -EFAULT;
 
-	err = security_bpf(cmd, &attr, size);
+	err = security_bpf(cmd, &attr, uattr.is_kernel, size);
 	if (err < 0)
 		return err;
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr);
+		err = map_create(&attr, uattr.is_kernel);
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
diff --git a/security/security.c b/security/security.c
index 143561ebc3e89..ee267ddbe4230 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5626,7 +5626,8 @@ int security_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
  * security_bpf() - Check if the bpf syscall operation is allowed
  * @cmd: command
  * @attr: bpf attribute
- * @size: size
+ * @is_kernel: whether or not call originated from kernel
+ * @size: size of bpf attribute
  *
  * Do a initial check for all bpf syscalls after the attribute is copied into
  * the kernel. The actual security module can implement their own rules to
@@ -5634,9 +5635,9 @@ int security_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
+int security_bpf(int cmd, union bpf_attr *attr, bool is_kernel, unsigned int size)
 {
-	return call_int_hook(bpf, cmd, attr, size);
+	return call_int_hook(bpf, cmd, attr, is_kernel, size);
 }
 
 /**
@@ -5672,6 +5673,7 @@ int security_bpf_prog(struct bpf_prog *prog)
  * security_bpf_map_create() - Check if BPF map creation is allowed
  * @map: BPF map object
  * @attr: BPF syscall attributes used to create BPF map
+ * @is_kernel: whether or not call originated from kernel
  * @token: BPF token used to grant user access
  *
  * Do a check when the kernel creates a new BPF map. This is also the
@@ -5680,15 +5682,16 @@ int security_bpf_prog(struct bpf_prog *prog)
  * Return: Returns 0 on success, error on failure.
  */
 int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
-			    struct bpf_token *token)
+			    bool is_kernel, struct bpf_token *token)
 {
-	return call_int_hook(bpf_map_create, map, attr, token);
+	return call_int_hook(bpf_map_create, map, attr, is_kernel, token);
 }
 
 /**
  * security_bpf_prog_load() - Check if loading of BPF program is allowed
  * @prog: BPF program object
  * @attr: BPF syscall attributes used to create BPF program
+ * @is_kernel: whether or not call originated from kernel
  * @token: BPF token used to grant user access to BPF subsystem
  *
  * Perform an access control check when the kernel loads a BPF program and
@@ -5698,9 +5701,9 @@ int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
  * Return: Returns 0 on success, error on failure.
  */
 int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
-			   struct bpf_token *token)
+			   bool is_kernel, struct bpf_token *token)
 {
-	return call_int_hook(bpf_prog_load, prog, attr, token);
+	return call_int_hook(bpf_prog_load, prog, attr, is_kernel, token);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88ba..6ac30498916f0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6866,7 +6866,7 @@ static int selinux_ib_alloc_security(void *ib_sec)
 
 #ifdef CONFIG_BPF_SYSCALL
 static int selinux_bpf(int cmd, union bpf_attr *attr,
-				     unsigned int size)
+		       bool is_kernel, unsigned int size)
 {
 	u32 sid = current_sid();
 	int ret;
@@ -6953,7 +6953,7 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 }
 
 static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
-				  struct bpf_token *token)
+				  bool is_kernel, struct bpf_token *token)
 {
 	struct bpf_security_struct *bpfsec;
 
@@ -6976,7 +6976,7 @@ static void selinux_bpf_map_free(struct bpf_map *map)
 }
 
 static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
-				 struct bpf_token *token)
+				 bool is_kernel, struct bpf_token *token)
 {
 	struct bpf_security_struct *bpfsec;
 
-- 
2.48.1


