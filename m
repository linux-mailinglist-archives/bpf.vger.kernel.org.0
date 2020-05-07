Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D46F1C81C8
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 07:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEGFkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 01:40:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42998 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgEGFjr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 01:39:47 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0475djFl007909
        for <bpf@vger.kernel.org>; Wed, 6 May 2020 22:39:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=eJLQ62bQx4LdPhuSBJVtSzd3ICo+jrisskPoO9DUyKA=;
 b=MohMY+GCuhFQ2YVPBouvTmAUfD6rPZZkKSNgjnaQLtXUDW9d3a5SnbWFDn0ztAnAEl+L
 2FfagAxL2ER74PaeV1vnojKQKZu+PkMcYBLs+sVfWD3fFXM4s+WsNfenrNOonCNXB5ly
 atxlFHVMOYjZV68YIHTrGxdxrKhwpU1gh/c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30v0hp3gwc-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 22:39:46 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 6 May 2020 22:39:23 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 22AA63701B99; Wed,  6 May 2020 22:39:18 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v3 03/21] bpf: support bpf tracing/iter programs for BPF_LINK_CREATE
Date:   Wed, 6 May 2020 22:39:18 -0700
Message-ID: <20200507053918.1542509-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200507053915.1542140-1-yhs@fb.com>
References: <20200507053915.1542140-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_02:2020-05-05,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=2
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070044
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Given a bpf program, the step to create an anonymous bpf iterator is:
  - create a bpf_iter_link, which combines bpf program and the target.
    In the future, there could be more information recorded in the link.
    A link_fd will be returned to the user space.
  - create an anonymous bpf iterator with the given link_fd.

The bpf_iter_link can be pinned to bpffs mount file system to
create a file based bpf iterator as well.

The benefit to use of bpf_iter_link:
  - using bpf link simplifies design and implementation as bpf link
    is used for other tracing bpf programs.
  - for file based bpf iterator, bpf_iter_link provides a standard
    way to replace underlying bpf programs.
  - for both anonymous and free based iterators, bpf link query
    capability can be leveraged.

The patch added support of tracing/iter programs for BPF_LINK_CREATE.
A new link type BPF_LINK_TYPE_ITER is added to facilitate link
querying. Currently, only prog_id is needed, so there is no
additional in-kernel show_fdinfo() and fill_link_info() hook
is needed for BPF_LINK_TYPE_ITER link.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/linux/bpf_types.h      |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/bpf_iter.c          | 62 ++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           | 14 ++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 6 files changed, 80 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f28bdd714754..e93d2d33c82c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1143,6 +1143,7 @@ struct bpf_iter_reg {
 int bpf_iter_reg_target(struct bpf_iter_reg *reg_info);
 void bpf_iter_unreg_target(const char *target);
 bool bpf_iter_prog_supported(struct bpf_prog *prog);
+int bpf_iter_link_attach(const union bpf_attr *attr, struct bpf_prog *pr=
og);
=20
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 8345cdf553b8..29d22752fc87 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -124,3 +124,4 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
 #ifdef CONFIG_CGROUP_BPF
 BPF_LINK_TYPE(BPF_LINK_TYPE_CGROUP, cgroup)
 #endif
+BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 047b19fe716e..2bf33979f9ae 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -229,6 +229,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_RAW_TRACEPOINT =3D 1,
 	BPF_LINK_TYPE_TRACING =3D 2,
 	BPF_LINK_TYPE_CGROUP =3D 3,
+	BPF_LINK_TYPE_ITER =3D 4,
=20
 	MAX_BPF_LINK_TYPE,
 };
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index dec182d8395a..03f5832909db 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -15,6 +15,11 @@ struct bpf_iter_target_info {
 	u32 btf_id;	/* cached value */
 };
=20
+struct bpf_iter_link {
+	struct bpf_link link;
+	struct bpf_iter_target_info *tinfo;
+};
+
 static struct list_head targets =3D LIST_HEAD_INIT(targets);
 static DEFINE_MUTEX(targets_mutex);
=20
@@ -93,3 +98,60 @@ bool bpf_iter_prog_supported(struct bpf_prog *prog)
=20
 	return supported;
 }
+
+static void bpf_iter_link_release(struct bpf_link *link)
+{
+}
+
+static void bpf_iter_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_iter_link *iter_link =3D
+		container_of(link, struct bpf_iter_link, link);
+
+	kfree(iter_link);
+}
+
+static const struct bpf_link_ops bpf_iter_link_lops =3D {
+	.release =3D bpf_iter_link_release,
+	.dealloc =3D bpf_iter_link_dealloc,
+};
+
+int bpf_iter_link_attach(const union bpf_attr *attr, struct bpf_prog *pr=
og)
+{
+	struct bpf_link_primer link_primer;
+	struct bpf_iter_target_info *tinfo;
+	struct bpf_iter_link *link;
+	bool existed =3D false;
+	u32 prog_btf_id;
+	int err;
+
+	if (attr->link_create.target_fd || attr->link_create.flags)
+		return -EINVAL;
+
+	prog_btf_id =3D prog->aux->attach_btf_id;
+	mutex_lock(&targets_mutex);
+	list_for_each_entry(tinfo, &targets, list) {
+		if (tinfo->btf_id =3D=3D prog_btf_id) {
+			existed =3D true;
+			break;
+		}
+	}
+	mutex_unlock(&targets_mutex);
+	if (!existed)
+		return -ENOENT;
+
+	link =3D kzalloc(sizeof(*link), GFP_USER | __GFP_NOWARN);
+	if (!link)
+		return -ENOMEM;
+
+	bpf_link_init(&link->link, BPF_LINK_TYPE_ITER, &bpf_iter_link_lops, pro=
g);
+	link->tinfo =3D tinfo;
+
+	err  =3D bpf_link_prime(&link->link, &link_primer);
+	if (err) {
+		kfree(link);
+		return err;
+	}
+
+	return bpf_link_settle(&link_primer);
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bb1ab7da6103..6ffe2d8fb6c7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2729,6 +2729,8 @@ attach_type_to_prog_type(enum bpf_attach_type attac=
h_type)
 	case BPF_CGROUP_GETSOCKOPT:
 	case BPF_CGROUP_SETSOCKOPT:
 		return BPF_PROG_TYPE_CGROUP_SOCKOPT;
+	case BPF_TRACE_ITER:
+		return BPF_PROG_TYPE_TRACING;
 	default:
 		return BPF_PROG_TYPE_UNSPEC;
 	}
@@ -3729,6 +3731,15 @@ static int bpf_map_do_batch(const union bpf_attr *=
attr,
 	return err;
 }
=20
+static int tracing_bpf_link_attach(const union bpf_attr *attr, struct bp=
f_prog *prog)
+{
+	if (attr->link_create.attach_type =3D=3D BPF_TRACE_ITER &&
+	    prog->expected_attach_type =3D=3D BPF_TRACE_ITER)
+		return bpf_iter_link_attach(attr, prog);
+
+	return -EINVAL;
+}
+
 #define BPF_LINK_CREATE_LAST_FIELD link_create.flags
 static int link_create(union bpf_attr *attr)
 {
@@ -3765,6 +3776,9 @@ static int link_create(union bpf_attr *attr)
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 		ret =3D cgroup_bpf_link_attach(attr, prog);
 		break;
+	case BPF_PROG_TYPE_TRACING:
+		ret =3D tracing_bpf_link_attach(attr, prog);
+		break;
 	default:
 		ret =3D -EINVAL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 047b19fe716e..2bf33979f9ae 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -229,6 +229,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_RAW_TRACEPOINT =3D 1,
 	BPF_LINK_TYPE_TRACING =3D 2,
 	BPF_LINK_TYPE_CGROUP =3D 3,
+	BPF_LINK_TYPE_ITER =3D 4,
=20
 	MAX_BPF_LINK_TYPE,
 };
--=20
2.24.1

