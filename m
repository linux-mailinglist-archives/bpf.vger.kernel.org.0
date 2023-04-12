Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBC86DEA99
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 06:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjDLEeO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 12 Apr 2023 00:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDLEdw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 00:33:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECB759D6
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:37 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNTaoB032111
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:37 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pwf17hy9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:37 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 21:33:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 69D702DCF45A2; Tue, 11 Apr 2023 21:33:27 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kpsingh@kernel.org>, <keescook@chromium.org>,
        <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 7/8] bpf, lsm: implement bpf_btf_load_security LSM hook
Date:   Tue, 11 Apr 2023 21:32:59 -0700
Message-ID: <20230412043300.360803-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412043300.360803-1-andrii@kernel.org>
References: <20230412043300.360803-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t8dY6tsq_mz9iGVOj4YFQH4TMWyJCYc-
X-Proofpoint-GUID: t8dY6tsq_mz9iGVOj4YFQH4TMWyJCYc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new LSM hook, bpf_btf_load_security, that allows custom LSM security
policies controlling BTF data loading permissions (BPF_BTF_LOAD command
of bpf() syscall) granularly and precisely.

This complements bpf_map_create_security LSM hook added earlier and
follow the same semantics: 0 means perform standard kernel capabilities-based
checks, negative error rejects BTF object load, while positive one skips
CAP_BPF check and allows BTF data object creation.

With this hook, together with bpf_map_create_security, we now can also allow
trusted unprivileged process to create BPF maps that require BTF, which
we take advantaged in the next patch to improve the coverage of added
BPF selftest.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     | 13 +++++++++++++
 include/linux/security.h      |  6 ++++++
 kernel/bpf/bpf_lsm.c          |  1 +
 kernel/bpf/syscall.c          | 10 ++++++++++
 security/security.c           |  4 ++++
 6 files changed, 35 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index b4fe9ed7021a..92cb0f95b970 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -396,6 +396,7 @@ LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
 LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
 LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
 LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
+LSM_HOOK(int, 0, bpf_btf_load_security, const union bpf_attr *attr)
 LSM_HOOK(int, 0, bpf_map_create_security, const union bpf_attr *attr)
 LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
 LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 42bf7c0aa4d8..cde96b5e15e2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1598,6 +1598,19 @@
  *	@prog: bpf prog that userspace want to use.
  *	Return 0 if permission is granted.
  *
+ * @bpf_btf_load_security:
+ *	Do a check to determine permission to create BTF data object
+ *	(BPF_BTF_LOAD command of bpf() syscall).
+ *	Implementation can override kernel capabilities checks according to
+ *	the rules below:
+ *	  - 0 should be returned to delegate permission checks to other
+ *	    installed LSM callbacks and/or hard-wired kernel logic, which
+ *	    would enforce CAP_BPF capability;
+ *	  - reject BTF data object creation by returning -EPERM or any other
+ *	    negative error code;
+ *	  - allow BTF data object creation, overriding kernel checks, by
+ *	    returning a positive result.
+ *
  * @bpf_map_create_security:
  *	Do a check to determine permission to create requested BPF map.
  *	Implementation can override kernel capabilities checks according to
diff --git a/include/linux/security.h b/include/linux/security.h
index e5374fe92ef6..f3ee1800392d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2023,6 +2023,7 @@ struct bpf_prog_aux;
 extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int size);
 extern int security_bpf_map(struct bpf_map *map, fmode_t fmode);
 extern int security_bpf_prog(struct bpf_prog *prog);
+extern int security_bpf_btf_load(const union bpf_attr *attr);
 extern int security_bpf_map_create(const union bpf_attr *attr);
 extern int security_bpf_map_alloc(struct bpf_map *map);
 extern void security_bpf_map_free(struct bpf_map *map);
@@ -2045,6 +2046,11 @@ static inline int security_bpf_prog(struct bpf_prog *prog)
 	return 0;
 }
 
+static inline int security_bpf_btf_load(const union bpf_attr *attr)
+{
+	return 0;
+}
+
 static inline int security_bpf_map_create(const union bpf_attr *attr)
 {
 	return 0;
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 931d4dda5dac..53c39a18fd2c 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -260,6 +260,7 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 BTF_SET_START(sleepable_lsm_hooks)
 BTF_ID(func, bpf_lsm_bpf)
 BTF_ID(func, bpf_lsm_bpf_map)
+BTF_ID(func, bpf_lsm_bpf_btf_load_security)
 BTF_ID(func, bpf_lsm_bpf_map_create_security)
 BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
 BTF_ID(func, bpf_lsm_bpf_map_free_security)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 42d8473237ab..bbf70bddc770 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4449,12 +4449,22 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 
 static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
+	int err;
+
 	if (CHECK_ATTR(BPF_BTF_LOAD))
 		return -EINVAL;
 
+	/* security checks */
+	err = security_bpf_btf_load(attr);
+	if (err < 0)
+		return err;
+	if (err > 0)
+		goto skip_priv_checks;
+
 	if (!bpf_capable())
 		return -EPERM;
 
+skip_priv_checks:
 	return btf_new_fd(attr, uattr, uattr_size);
 }
 
diff --git a/security/security.c b/security/security.c
index f9b885680966..8869802ef5f5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2682,6 +2682,10 @@ int security_bpf_prog(struct bpf_prog *prog)
 {
 	return call_int_hook(bpf_prog, 0, prog);
 }
+int security_bpf_btf_load(const union bpf_attr *attr)
+{
+	return call_int_hook(bpf_btf_load_security, 0, attr);
+}
 int security_bpf_map_create(const union bpf_attr *attr)
 {
 	return call_int_hook(bpf_map_create_security, 0, attr);
-- 
2.34.1

