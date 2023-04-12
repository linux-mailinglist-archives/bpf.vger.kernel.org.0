Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0F6DEA96
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 06:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDLEd6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 12 Apr 2023 00:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDLEdu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 00:33:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AFB55AF
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:34 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNTZnD032027
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:34 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pwf17hy9g-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:34 -0700
Received: from twshared29091.48.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 21:33:30 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 326AA2DCF44CF; Tue, 11 Apr 2023 21:33:21 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kpsingh@kernel.org>, <keescook@chromium.org>,
        <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 4/8] bpf, lsm: implement bpf_map_create_security LSM hook
Date:   Tue, 11 Apr 2023 21:32:56 -0700
Message-ID: <20230412043300.360803-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412043300.360803-1-andrii@kernel.org>
References: <20230412043300.360803-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GSks_I7iu-w5tORMTd5tK6ddwY-QDewc
X-Proofpoint-GUID: GSks_I7iu-w5tORMTd5tK6ddwY-QDewc
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

Add new LSM hook, bpf_map_create_security, that allows custom LSM
security policies controlling BPF map creation permissions granularly
and precisely.

This new LSM hook allows to implement both LSM policy that could enforce
more granular and restrictive decisions about which processes can create
which BPF maps, by rejecting BPF map creation based on passed in
bpf_attr attributes. But also it allows to bypass CAP_BPF and
CAP_NET_ADMIN restrictions, normally enforced by kernel, for
applications that LSM policy deems trusted. Trustworthiness
determination of the process/user/cgroup/etc is left up to custom LSM
hook implementation and will dependon particular production setup of
each individual use case.

If LSM policy wants to rely on default kernel logic, it can return
0 to delegate back to kernel. If it returns >0 return code,
kernel will bypass its normal checks. This way it's possible to perform
a delegation of trust (specifically for BPF map creation) from
privileged LSM custom policy implementation to unprivileged user
process, verifier and trusted by custom LSM policy.

Such model allows flexible and secure-by-default approach where user
processes that need to use BPF features (BPF map creation, in this case)
are left unprivileged with no CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON, etc.
capabilities, but specific exceptions are implemented (usually in
a centralized server fleet-wide fashion) for trusted
processes/containers/users, allowing them to manipulate BPF facilities,
as long as they are allowed and known apriori.

This patch implements first required part for full-fledged BPF usage:
map creation. The other one, BPF program load, will be addressed in
follow up patches.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     | 12 ++++++++++++
 include/linux/security.h      |  6 ++++++
 kernel/bpf/bpf_lsm.c          |  1 +
 kernel/bpf/syscall.c          | 19 ++++++++++++++++---
 security/security.c           |  4 ++++
 6 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 094b76dc7164..b4fe9ed7021a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -396,6 +396,7 @@ LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
 LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
 LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
 LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
+LSM_HOOK(int, 0, bpf_map_create_security, const union bpf_attr *attr)
 LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
 LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
 LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6e156d2acffc..42bf7c0aa4d8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1598,6 +1598,18 @@
  *	@prog: bpf prog that userspace want to use.
  *	Return 0 if permission is granted.
  *
+ * @bpf_map_create_security:
+ *	Do a check to determine permission to create requested BPF map.
+ *	Implementation can override kernel capabilities checks according to
+ *	the rules below:
+ *	  - 0 should be returned to delegate permission checks to other
+ *	    installed LSM callbacks and/or hard-wired kernel logic, which
+ *	    would enforce CAP_BPF/CAP_NET_ADMIN capabilities;
+ *	  - reject BPF map creation by returning -EPERM or any other
+ *	    negative error code;
+ *	  - allow BPF map creation, overriding kernel checks, by returning
+ *	    a positive result.
+ *
  * @bpf_map_alloc_security:
  *	Initialize the security field inside bpf map.
  *	Return 0 on success, error on failure.
diff --git a/include/linux/security.h b/include/linux/security.h
index 5984d0d550b4..e5374fe92ef6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2023,6 +2023,7 @@ struct bpf_prog_aux;
 extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int size);
 extern int security_bpf_map(struct bpf_map *map, fmode_t fmode);
 extern int security_bpf_prog(struct bpf_prog *prog);
+extern int security_bpf_map_create(const union bpf_attr *attr);
 extern int security_bpf_map_alloc(struct bpf_map *map);
 extern void security_bpf_map_free(struct bpf_map *map);
 extern int security_bpf_prog_alloc(struct bpf_prog_aux *aux);
@@ -2044,6 +2045,11 @@ static inline int security_bpf_prog(struct bpf_prog *prog)
 	return 0;
 }
 
+static inline int security_bpf_map_create(const union bpf_attr *attr)
+{
+	return 0;
+}
+
 static inline int security_bpf_map_alloc(struct bpf_map *map)
 {
 	return 0;
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index e14c822f8911..931d4dda5dac 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -260,6 +260,7 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 BTF_SET_START(sleepable_lsm_hooks)
 BTF_ID(func, bpf_lsm_bpf)
 BTF_ID(func, bpf_lsm_bpf_map)
+BTF_ID(func, bpf_lsm_bpf_map_create_security)
 BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
 BTF_ID(func, bpf_lsm_bpf_map_free_security)
 BTF_ID(func, bpf_lsm_bpf_prog)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cbea4999e92f..7d1165814efc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -980,7 +980,7 @@ int map_check_no_btf(const struct bpf_map *map,
 }
 
 static int map_check_btf(struct bpf_map *map, const struct btf *btf,
-			 u32 btf_key_id, u32 btf_value_id)
+			 u32 btf_key_id, u32 btf_value_id, bool priv_checked)
 {
 	const struct btf_type *key_type, *value_type;
 	u32 key_size, value_size;
@@ -1008,7 +1008,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
 
-		if (!bpf_capable()) {
+		if (!priv_checked && !bpf_capable()) {
 			ret = -EPERM;
 			goto free_map_tab;
 		}
@@ -1097,10 +1097,12 @@ static int map_create(union bpf_attr *attr)
 	int numa_node = bpf_map_attr_numa_node(attr);
 	u32 map_type = attr->map_type;
 	struct btf_field_offs *foffs;
+	bool priv_checked = false;
 	struct bpf_map *map;
 	int f_flags;
 	int err;
 
+	/* sanity checks */
 	err = CHECK_ATTR(BPF_MAP_CREATE);
 	if (err)
 		return -EINVAL;
@@ -1145,6 +1147,15 @@ static int map_create(union bpf_attr *attr)
 	if (!ops->map_mem_usage)
 		return -EINVAL;
 
+	/* security checks */
+	err = security_bpf_map_create(attr);
+	if (err < 0)
+		return err;
+	if (err > 0) {
+		priv_checked = true;
+		goto skip_priv_checks;
+	}
+
 	/* Intent here is for unprivileged_bpf_disabled to block key object
 	 * creation commands for unprivileged users; other actions depend
 	 * of fd availability and access to bpffs, so are dependent on
@@ -1203,6 +1214,8 @@ static int map_create(union bpf_attr *attr)
 		return -EPERM;
 	}
 
+skip_priv_checks:
+	/* create and init map */
 	map = ops->map_alloc(attr);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
@@ -1243,7 +1256,7 @@ static int map_create(union bpf_attr *attr)
 
 		if (attr->btf_value_type_id) {
 			err = map_check_btf(map, btf, attr->btf_key_type_id,
-					    attr->btf_value_type_id);
+					    attr->btf_value_type_id, priv_checked);
 			if (err)
 				goto free_map;
 		}
diff --git a/security/security.c b/security/security.c
index cf6cc576736f..f9b885680966 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2682,6 +2682,10 @@ int security_bpf_prog(struct bpf_prog *prog)
 {
 	return call_int_hook(bpf_prog, 0, prog);
 }
+int security_bpf_map_create(const union bpf_attr *attr)
+{
+	return call_int_hook(bpf_map_create_security, 0, attr);
+}
 int security_bpf_map_alloc(struct bpf_map *map)
 {
 	return call_int_hook(bpf_map_alloc_security, 0, map);
-- 
2.34.1

