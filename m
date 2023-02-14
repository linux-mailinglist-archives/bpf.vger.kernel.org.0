Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8469708D
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjBNWRf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjBNWRe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:17:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9BE2821B
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:32 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EH2eOA003625
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=0IVt0EQN52OBn5o6/YNdOrtKAJxJsFxXkZSRoXGEDkU=;
 b=DvWeESa+YqelxvMJ6OsQtIRGkvRPdhF1W5ppxH+xYrolZgSg8lFgtL51uquVCtk9qIzl
 Rk7L0vevMLuelIzuyvWzXX3BEPVHYOdujIGw9us1LWiQt3TmhrzqW8UocJKJGoH3qcJu
 yCeqqIaAoa3L+FhAWx6yZqfnJ3VCnhf9xUgVcFKNRAVMbDrJK8Ny7WUNMCKje5miJpbe
 PZ5j5EkjIoXtvvFURqdG/WaQ0L0qZXA08+gLmcb7kQgGGbjrsG8BBFAgoGoCwj3ERM2K
 N3+rXFzcSHd2pt1s/hoEoD1eywaFxHPJlxCBejnJ2vTF0e79Z2ccI5n0uowHno6xJwIs 7Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nrc19b7ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:32 -0800
Received: from twshared25383.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 14:17:31 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 333BD5143080; Tue, 14 Feb 2023 14:17:20 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 1/7] bpf: Create links for BPF struct_ops maps.
Date:   Tue, 14 Feb 2023 14:17:12 -0800
Message-ID: <20230214221718.503964-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230214221718.503964-1-kuifeng@meta.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9XbNikaXEwXedKQixGQGPYtvq-hDVMjg
X-Proofpoint-GUID: 9XbNikaXEwXedKQixGQGPYtvq-hDVMjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF struct_ops maps are employed directly to register TCP Congestion
Control algorithms. Unlike other BPF programs that terminate when
their links gone, the struct_ops program reduces its refcount solely
upon death of its FD. The link of a BPF struct_ops map provides a
uniform experience akin to other types of BPF programs.  A TCP
Congestion Control algorithm will be unregistered upon destroying the
FD in the following patches.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h            |  6 +++-
 include/uapi/linux/bpf.h       |  4 +++
 kernel/bpf/bpf_struct_ops.c    | 66 ++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           | 29 ++++++++++-----
 tools/include/uapi/linux/bpf.h |  4 +++
 tools/lib/bpf/bpf.c            |  2 ++
 tools/lib/bpf/libbpf.c         |  1 +
 7 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8b5d0b4c4ada..13683584b071 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1391,7 +1391,11 @@ struct bpf_link {
 	u32 id;
 	enum bpf_link_type type;
 	const struct bpf_link_ops *ops;
-	struct bpf_prog *prog;
+	union {
+		struct bpf_prog *prog;
+		/* Backed by a struct_ops (type =3D=3D BPF_LINK_UPDATE_STRUCT_OPS) */
+		struct bpf_map *map;
+	};
 	struct work_struct work;
 };
=20
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 17afd2b35ee5..1e6cdd0f355d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1033,6 +1033,7 @@ enum bpf_attach_type {
 	BPF_PERF_EVENT,
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
+	BPF_STRUCT_OPS_MAP,
 	__MAX_BPF_ATTACH_TYPE
 };
=20
@@ -6354,6 +6355,9 @@ struct bpf_link_info {
 		struct {
 			__u32 ifindex;
 		} xdp;
+		struct {
+			__u32 map_id;
+		} struct_ops_map;
 	};
 } __attribute__((aligned(8)));
=20
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index ece9870cab68..621c8e24481a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -698,3 +698,69 @@ void bpf_struct_ops_put(const void *kdata)
 		call_rcu(&st_map->rcu, bpf_struct_ops_put_rcu);
 	}
 }
+
+static void bpf_struct_ops_map_link_release(struct bpf_link *link)
+{
+	if (link->map) {
+		bpf_map_put(link->map);
+		link->map =3D NULL;
+	}
+}
+
+static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
+{
+	kfree(link);
+}
+
+static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *l=
ink,
+					    struct seq_file *seq)
+{
+	seq_printf(seq, "map_id:\t%d\n",
+		  link->map->id);
+}
+
+static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link =
*link,
+					       struct bpf_link_info *info)
+{
+	info->struct_ops_map.map_id =3D link->map->id;
+	return 0;
+}
+
+static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
+	.release =3D bpf_struct_ops_map_link_release,
+	.dealloc =3D bpf_struct_ops_map_link_dealloc,
+	.show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
+	.fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
+};
+
+int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
+{
+	struct bpf_link_primer link_primer;
+	struct bpf_map *map;
+	struct bpf_link *link =3D NULL;
+	int err;
+
+	map =3D bpf_map_get(attr->link_create.prog_fd);
+	if (map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS)
+		return -EINVAL;
+
+	link =3D kzalloc(sizeof(*link), GFP_USER);
+	if (!link) {
+		err =3D -ENOMEM;
+		goto err_out;
+	}
+	bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops,=
 NULL);
+	link->map =3D map;
+
+	err =3D bpf_link_prime(link, &link_primer);
+	if (err)
+		goto err_out;
+
+	return bpf_link_settle(&link_primer);
+
+err_out:
+	bpf_map_put(map);
+	kfree(link);
+	return err;
+}
+
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cda8d00f3762..54e172d8f5d1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2738,7 +2738,9 @@ static void bpf_link_free(struct bpf_link *link)
 	if (link->prog) {
 		/* detach BPF program, clean up used resources */
 		link->ops->release(link);
-		bpf_prog_put(link->prog);
+		if (link->type !=3D BPF_LINK_TYPE_STRUCT_OPS)
+			bpf_prog_put(link->prog);
+		/* The struct_ops links clean up map by them-selves. */
 	}
 	/* free bpf_link and its containing memory */
 	link->ops->dealloc(link);
@@ -2794,16 +2796,19 @@ static void bpf_link_show_fdinfo(struct seq_file =
*m, struct file *filp)
 	const struct bpf_prog *prog =3D link->prog;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
=20
-	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
 	seq_printf(m,
 		   "link_type:\t%s\n"
-		   "link_id:\t%u\n"
-		   "prog_tag:\t%s\n"
-		   "prog_id:\t%u\n",
+		   "link_id:\t%u\n",
 		   bpf_link_type_strs[link->type],
-		   link->id,
-		   prog_tag,
-		   prog->aux->id);
+		   link->id);
+	if (link->type !=3D BPF_LINK_TYPE_STRUCT_OPS) {
+		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
+		seq_printf(m,
+			   "prog_tag:\t%s\n"
+			   "prog_id:\t%u\n",
+			   prog_tag,
+			   prog->aux->id);
+	}
 	if (link->ops->show_fdinfo)
 		link->ops->show_fdinfo(link, m);
 }
@@ -4278,7 +4283,8 @@ static int bpf_link_get_info_by_fd(struct file *fil=
e,
=20
 	info.type =3D link->type;
 	info.id =3D link->id;
-	info.prog_id =3D link->prog->aux->id;
+	if (link->type !=3D BPF_LINK_TYPE_STRUCT_OPS)
+		info.prog_id =3D link->prog->aux->id;
=20
 	if (link->ops->fill_link_info) {
 		err =3D link->ops->fill_link_info(link, &info);
@@ -4531,6 +4537,8 @@ static int bpf_map_do_batch(const union bpf_attr *a=
ttr,
 	return err;
 }
=20
+extern int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uat=
tr);
+
 #define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
@@ -4541,6 +4549,9 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
 	if (CHECK_ATTR(BPF_LINK_CREATE))
 		return -EINVAL;
=20
+	if (attr->link_create.attach_type =3D=3D BPF_STRUCT_OPS_MAP)
+		return link_create_struct_ops_map(attr, uattr);
+
 	prog =3D bpf_prog_get(attr->link_create.prog_fd);
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 17afd2b35ee5..1e6cdd0f355d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1033,6 +1033,7 @@ enum bpf_attach_type {
 	BPF_PERF_EVENT,
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
+	BPF_STRUCT_OPS_MAP,
 	__MAX_BPF_ATTACH_TYPE
 };
=20
@@ -6354,6 +6355,9 @@ struct bpf_link_info {
 		struct {
 			__u32 ifindex;
 		} xdp;
+		struct {
+			__u32 map_id;
+		} struct_ops_map;
 	};
 } __attribute__((aligned(8)));
=20
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9aff98f42a3d..e44d49f17c86 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -731,6 +731,8 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, tracing))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_STRUCT_OPS_MAP:
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 35a698eb825d..75ed95b7e455 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -115,6 +115,7 @@ static const char * const attach_type_name[] =3D {
 	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	=3D "sk_reuseport_select_or_migrat=
e",
 	[BPF_PERF_EVENT]		=3D "perf_event",
 	[BPF_TRACE_KPROBE_MULTI]	=3D "trace_kprobe_multi",
+	[BPF_STRUCT_OPS_MAP]		=3D "struct_ops_map",
 };
=20
 static const char * const link_type_name[] =3D {
--=20
2.30.2

