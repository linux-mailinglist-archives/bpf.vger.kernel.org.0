Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B5E2ACA55
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 02:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgKJBWm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 9 Nov 2020 20:22:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37968 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729956AbgKJBWk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Nov 2020 20:22:40 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AA1KKbu007884
        for <bpf@vger.kernel.org>; Mon, 9 Nov 2020 17:22:39 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34nqy2b3n3-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 17:22:39 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 9 Nov 2020 17:22:36 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 5DBD52EC9241; Mon,  9 Nov 2020 17:19:38 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <jeyu@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 bpf-next 2/5] bpf: assign ID to vmlinux BTF and return extra info for BTF in GET_OBJ_INFO
Date:   Mon, 9 Nov 2020 17:19:29 -0800
Message-ID: <20201110011932.3201430-3-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201110011932.3201430-1-andrii@kernel.org>
References: <20201110011932.3201430-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_15:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=659 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=75 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100008
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
 kernel/bpf/btf.c               | 43 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |  3 +++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9879d6793e90..162999b12790 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4466,6 +4466,9 @@ struct bpf_btf_info {
 	__aligned_u64 btf;
 	__u32 btf_size;
 	__u32 id;
+	__aligned_u64 name;
+	__u32 name_len;
+	__u32 kernel_btf;
 } __attribute__((aligned(8)));
 
 struct bpf_link_info {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 727c1c27053f..856585db7aa7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -214,6 +214,8 @@ struct btf {
 	struct btf *base_btf;
 	u32 start_id; /* first type ID in this BTF (0 for base BTF) */
 	u32 start_str_off; /* first string offset (0 for base BTF) */
+	char name[MODULE_NAME_LEN];
+	bool kernel_btf;
 };
 
 enum verifier_phase {
@@ -4429,6 +4431,8 @@ struct btf *btf_parse_vmlinux(void)
 
 	btf->data = __start_BTF;
 	btf->data_size = __stop_BTF - __start_BTF;
+	btf->kernel_btf = true;
+	snprintf(btf->name, sizeof(btf->name), "vmlinux");
 
 	err = btf_parse_hdr(env);
 	if (err)
@@ -4454,8 +4458,13 @@ struct btf *btf_parse_vmlinux(void)
 
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
@@ -5553,7 +5562,9 @@ int btf_get_info_by_fd(const struct btf *btf,
 	struct bpf_btf_info info;
 	u32 info_copy, btf_copy;
 	void __user *ubtf;
-	u32 uinfo_len;
+	char __user *uname;
+	u32 uinfo_len, uname_len, name_len;
+	int ret = 0;
 
 	uinfo = u64_to_user_ptr(attr->info.info);
 	uinfo_len = attr->info.info_len;
@@ -5570,11 +5581,37 @@ int btf_get_info_by_fd(const struct btf *btf,
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
+			/* let user-space know about too short buffer */
+			ret = -ENOSPC;
+		}
+	}
+
 	if (copy_to_user(uinfo, &info, info_copy) ||
 	    put_user(info_copy, &uattr->info.info_len))
 		return -EFAULT;
 
-	return 0;
+	return ret;
 }
 
 int btf_get_fd_by_id(u32 id)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9879d6793e90..162999b12790 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4466,6 +4466,9 @@ struct bpf_btf_info {
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

