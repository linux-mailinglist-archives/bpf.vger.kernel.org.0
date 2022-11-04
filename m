Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721BA619C53
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 16:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiKDP6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 11:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiKDP6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 11:58:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F5D31228
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 08:58:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4FVKhA001418;
        Fri, 4 Nov 2022 15:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=AENL95pD2+cZZmiVHzd6he+R8Xv9064Yg0E+GgIptsc=;
 b=pZbAYawz878gxgb8f/Y1gzeTSQeNVxkzYGESUQ7Kh0zbr06IiarFbVUlxIYR5IevrzJm
 Nw6AJO0uExyYmTK63G/i1yrqxYRPGbxFtaUFR9dwIpjAhhmX3KlQ6AbLOs0EC1erWXrH
 T1ofvGWVSgZ4JnjbIJAZvpFwJvRiDEfMH7FUGNltZviuWB8j11Eo18tdtunz+51bO3fX
 nOgqQ3QoBfWcjnc2B7j3NgCgHuuXJvCd7669wQ8LRyDEBgZnwhLxRV0NNoqqSQ1ocWda
 1WL5r1scQxZ31rVu9Qnk3xpQXZ8410b1GZjioBmKDhKQHw79ufcO5rHnCTUS20k7ij/e 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkdfhud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 15:58:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4EjkcT023392;
        Fri, 4 Nov 2022 15:58:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpwnpec8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 15:58:22 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A4FwITk025431;
        Fri, 4 Nov 2022 15:58:22 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-178-135.vpn.oracle.com [10.175.178.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kmpwnpe7w-2;
        Fri, 04 Nov 2022 15:58:22 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, ast@kernel.org, martin.lau@linux.dev,
        daniel@iogearbox.net
Cc:     song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 1/2] bpf: support standalone BTF in modules
Date:   Fri,  4 Nov 2022 15:58:06 +0000
Message-Id: <1667577487-9162-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1667577487-9162-1-git-send-email-alan.maguire@oracle.com>
References: <1667577487-9162-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040104
X-Proofpoint-ORIG-GUID: PVozCsLJlrk6sAMfZxCmGqebEtBeN1tg
X-Proofpoint-GUID: PVozCsLJlrk6sAMfZxCmGqebEtBeN1tg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Not all kernel modules can be built in-tree when the core
kernel is built. This presents a problem for split BTF, because
split module BTF refers to type ids in the base kernel BTF, and
if that base kernel BTF changes (even in minor ways) those
references become invalid.  Such modules then cannot take
advantage of BTF (or at least they only can until the kernel
changes enough to invalidate their vmlinux type id references).
This problem has been discussed before, and the initial approach
was to allow BTF mismatch but fail to load BTF.  See [1]
for more discussion.

Generating standalone BTF for modules helps solve this problem
because the BTF generated is self-referential only.  However,
tooling is geared towards split BTF - for example bpftool assumes
a module's BTF is defined relative to vmlinux BTF.  To handle
this, dynamic remapping of standalone BTF is done on module
load to make it appear like split BTF - type ids and string
offsets are remapped such that they appear as they would in
split BTF.  It just so happens that the BTF is self-referential.
With this approach, existing tooling works with standalone
module BTF from /sys/kernel/btf in the same way as before;
no knowledge of split versus standalone BTF is required.

Currently, the approach taken is to assume that the BTF
associated with a module is split BTF.  If however the
checking of types fails, we fall back to interpreting it as
standalone BTF and carrying out remapping.  As discussed in [1]
there are some heuristics we could use to identify standalone
versus split module BTF, but for now the simplistic fallback
method is used.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/YfK18x%2FXrYL4Vw8o@syu-laptop/
---
 kernel/bpf/btf.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5579ff3..5efdcaf 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5315,11 +5315,120 @@ struct btf *btf_parse_vmlinux(void)
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
+static u32 btf_name_off_renumber(struct btf *btf, u32 name_off)
+{
+	return name_off + btf->start_str_off;
+}
+
+static u32 btf_id_renumber(struct btf *btf, u32 id)
+{
+	/* no need to renumber void */
+	if (id == 0)
+		return id;
+	return id + btf->start_id - 1;
+}
+
+/* Renumber standalone BTF to appear as split BTF; name offsets must
+ * be relative to btf->start_str_offset and ids relative to btf->start_id.
+ * When user sees BTF it will appear as normal module split BTF, the only
+ * difference being it is fully self-referential and does not refer back
+ * to vmlinux BTF (aside from 0 "void" references).
+ */
+static void btf_type_renumber(struct btf_verifier_env *env, struct btf_type *t)
+{
+	struct btf_var_secinfo *secinfo;
+	struct btf *btf = env->btf;
+	struct btf_member *member;
+	struct btf_param *param;
+	struct btf_array *array;
+	struct btf_enum64 *e64;
+	struct btf_enum *e;
+	int i;
+
+	t->name_off = btf_name_off_renumber(btf, t->name_off);
+
+	switch (BTF_INFO_KIND(t->info)) {
+	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
+	case BTF_KIND_TYPE_TAG:
+		/* nothing to renumber here, no type references */
+		break;
+	case BTF_KIND_PTR:
+	case BTF_KIND_FWD:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_FUNC:
+	case BTF_KIND_VAR:
+	case BTF_KIND_DECL_TAG:
+		/* renumber the referenced type */
+		t->type = btf_id_renumber(btf, t->type);
+		break;
+	case BTF_KIND_ARRAY:
+		array = btf_array(t);
+		array->type = btf_id_renumber(btf, array->type);
+		array->index_type = btf_id_renumber(btf, array->index_type);
+		break;
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		member = (struct btf_member *)(t + 1);
+		for (i = 0; i < btf_type_vlen(t); i++) {
+			member->type = btf_id_renumber(btf, member->type);
+			member->name_off = btf_name_off_renumber(btf, member->name_off);
+			member++;
+		}
+		break;
+	case BTF_KIND_FUNC_PROTO:
+		param = (struct btf_param *)(t + 1);
+		for (i = 0; i < btf_type_vlen(t); i++) {
+			param->type = btf_id_renumber(btf, param->type);
+			param->name_off = btf_name_off_renumber(btf, param->name_off);
+			param++;
+		}
+		break;
+	case BTF_KIND_DATASEC:
+		secinfo = (struct btf_var_secinfo *)(t + 1);
+		for (i = 0; i < btf_type_vlen(t); i++) {
+			secinfo->type = btf_id_renumber(btf, secinfo->type);
+			secinfo++;
+		}
+		break;
+	case BTF_KIND_ENUM:
+		e = (struct btf_enum *)(t + 1);
+		for (i = 0; i < btf_type_vlen(t); i++) {
+			e->name_off = btf_name_off_renumber(btf, e->name_off);
+			e++;
+		}
+		break;
+	case BTF_KIND_ENUM64:
+		e64 = (struct btf_enum64 *)(t + 1);
+		for (i = 0; i < btf_type_vlen(t); i++) {
+			e64->name_off = btf_name_off_renumber(btf, e64->name_off);
+			e64++;
+		}
+		break;
+	}
+}
+
+static void btf_renumber(struct btf_verifier_env *env, struct btf *base_btf)
+{
+	struct btf *btf = env->btf;
+	int i;
+
+	btf->start_id = base_btf->nr_types;
+	btf->start_str_off = base_btf->hdr.str_len;
+
+	for (i = 0; i < btf->nr_types; i++)
+		btf_type_renumber(env, btf->types[i]);
+}
+
 static struct btf *btf_parse_module(const char *module_name, const void *data, unsigned int data_size)
 {
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf = NULL, *base_btf;
+	bool standalone = false;
 	int err;
 
 	base_btf = bpf_get_btf_vmlinux();
@@ -5367,9 +5476,32 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
 		goto errout;
 
 	err = btf_check_all_metas(env);
+	if (err) {
+		/* BTF may be standalone; in that case meta checks will
+		 * fail and we fall back to standalone BTF processing.
+		 * Later on, once we have checked all metas, we will
+		 * retain start id from  base BTF so it will look like
+		 * split BTF (but is self-contained); renumbering is done
+		 * also to give the split BTF-like appearance and not
+		 * confuse pahole which assumes split BTF for modules.
+		 */
+		btf->base_btf = NULL;
+		if (btf->types)
+			kvfree(btf->types);
+		btf->types = NULL;
+		btf->types_size = 0;
+		btf->start_id = 0;
+		btf->nr_types = 0;
+		btf->start_str_off = 0;
+		standalone = true;
+		err = btf_check_all_metas(env);
+	}
 	if (err)
 		goto errout;
 
+	if (standalone)
+		btf_renumber(env, base_btf);
+
 	err = btf_check_type_tags(env, btf, btf_nr_types(base_btf));
 	if (err)
 		goto errout;
-- 
1.8.3.1

