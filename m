Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C368D2A8F11
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 06:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgKFFye convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 6 Nov 2020 00:54:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64182 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726273AbgKFFye (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Nov 2020 00:54:34 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A65cakU024874
        for <bpf@vger.kernel.org>; Thu, 5 Nov 2020 21:54:33 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34mek35th9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 21:54:33 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 21:54:30 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 3EC6B2EC8EFB; Thu,  5 Nov 2020 21:51:34 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <jeyu@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next 2/5] bpf: assign ID to vmlinux BTF and return extra info for BTF in GET_OBJ_INFO
Date:   Thu, 5 Nov 2020 21:51:07 -0800
Message-ID: <20201106055111.3972047-3-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201106055111.3972047-1-andrii@kernel.org>
References: <20201106055111.3972047-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_01:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 suspectscore=75 bulkscore=0 mlxlogscore=690
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011060039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allocate ID for vmlinux BTF. This makes it visible when iterating over all BTF
objects in the system. To allow distinguishing vmlinux BTF (and later kernel
module BTF) from user-provided BTFs, expose extra kernel_btf flag, as well as
BTF name ("vmlinux" for vmlinux BTF, will equal to module's name for module
BTF).  We might want to later allow specifying BTF name for user-provided BTFs
as well, if that makes sense. But currently this is reserved only for
in-kernel BTFs.

Having in-kernel BTFs exposed IDs will allow to extend BPF APIs that require
in-kernel BTF type with ability to specify BTF types from kernel modules, not
just vmlinux BTF. This will be implemented in a follow up patch set for
fentry/fexit/fmod_ret/lsm/etc.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/btf.c               | 39 ++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  3 +++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e6ceac3f7d62..7955b144f267 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4418,6 +4418,9 @@ struct bpf_btf_info {
 	__aligned_u64 btf;
 	__u32 btf_size;
 	__u32 id;
+	__aligned_u64 name;
+	__u32 name_len;
+	__u32 kernel_btf;
 } __attribute__((aligned(8)));
 
 struct bpf_link_info {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f61944a3873b..09f1483934d2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -215,6 +215,8 @@ struct btf {
 	struct btf *base_btf;
 	u32 start_id; /* first type ID in this BTF (0 for base BTF) */
 	u32 start_str_off; /* first string offset (0 for base BTF) */
+	char name[MODULE_NAME_LEN];
+	bool kernel_btf;
 };
 
 enum verifier_phase {
@@ -4441,6 +4443,8 @@ struct btf *btf_parse_vmlinux(void)
 
 	btf->data = __start_BTF;
 	btf->data_size = __stop_BTF - __start_BTF;
+	btf->kernel_btf = true;
+	snprintf(btf->name, sizeof(btf->name), "vmlinux");
 
 	err = btf_parse_hdr(env);
 	if (err)
@@ -4466,8 +4470,13 @@ struct btf *btf_parse_vmlinux(void)
 
 	bpf_struct_ops_init(btf, log);
 
-	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
+
+	err = btf_alloc_id(btf);
+	if (err)
+		goto errout;
+
+	btf_verifier_env_free(env);
 	return btf;
 
 errout:
@@ -5565,7 +5574,8 @@ int btf_get_info_by_fd(const struct btf *btf,
 	struct bpf_btf_info info;
 	u32 info_copy, btf_copy;
 	void __user *ubtf;
-	u32 uinfo_len;
+	char __user *uname;
+	u32 uinfo_len, uname_len, name_len;
 
 	uinfo = u64_to_user_ptr(attr->info.info);
 	uinfo_len = attr->info.info_len;
@@ -5582,6 +5592,31 @@ int btf_get_info_by_fd(const struct btf *btf,
 		return -EFAULT;
 	info.btf_size = btf->data_size;
 
+	info.kernel_btf = btf->kernel_btf;
+
+	uname = u64_to_user_ptr(info.name);
+	uname_len = info.name_len;
+	if (!uname ^ !uname_len)
+		return -EINVAL;
+
+	name_len = strlen(btf->name);
+	info.name_len = name_len;
+
+	if (uname) {
+		if (uname_len >= name_len + 1) {
+			if (copy_to_user(uname, btf->name, name_len + 1))
+				return -EFAULT;
+		} else {
+			char zero = '\0';
+
+			if (copy_to_user(uname, btf->name, uname_len - 1))
+				return -EFAULT;
+			if (put_user(zero, uname + uname_len - 1))
+				return -EFAULT;
+			return -ENOSPC;
+		}
+	}
+
 	if (copy_to_user(uinfo, &info, info_copy) ||
 	    put_user(info_copy, &uattr->info.info_len))
 		return -EFAULT;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e6ceac3f7d62..7955b144f267 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4418,6 +4418,9 @@ struct bpf_btf_info {
 	__aligned_u64 btf;
 	__u32 btf_size;
 	__u32 id;
+	__aligned_u64 name;
+	__u32 name_len;
+	__u32 kernel_btf;
 } __attribute__((aligned(8)));
 
 struct bpf_link_info {
-- 
2.24.1

