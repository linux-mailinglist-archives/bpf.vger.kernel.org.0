Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA20B470F8C
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 01:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbhLKAo2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 10 Dec 2021 19:44:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3124 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237381AbhLKAo1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 19:44:27 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAKJDVd017823
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 16:40:52 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cvcvp1v6x-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 16:40:52 -0800
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:40:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C383CC98BDA0; Fri, 10 Dec 2021 16:40:49 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Emmanuel Deloget <emmanuel.deloget@eho.link>
Subject: [PATCH bpf-next] libbpf: add sane strncpy alternative and use it internally
Date:   Fri, 10 Dec 2021 16:40:43 -0800
Message-ID: <20211211004043.2374068-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: K5fziSEwm3zUyg4pCF6AwQ6jJuHfZm_1
X-Proofpoint-ORIG-GUID: K5fziSEwm3zUyg4pCF6AwQ6jJuHfZm_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_09,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112110001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

strncpy() has a notoriously error-prone semantics which makes GCC
complain about it a lot (and quite often completely completely falsely
at that). Instead of pleasing GCC all the time (-Wno-stringop-truncation
is unfortunately only supported by GCC, so it's a bit too messy to just
enable it in Makefile), add libbpf-internal libbpf_strlcpy() helper
which follows what FreeBSD's strlcpy() does and what most people would
expect from strncpy(): copies up to N-1 first bytes from source string
into destination string and ensures zero-termination afterwards.

Replace all the relevant uses of strncpy/strncat/memcpy in libbpf with
libbpf_strlcpy().

This also fixes the issue reported by Emmanuel Deloget in xsk.c where
memcpy() could access source string beyond its end.

Reported-by: Emmanuel Deloget <emmanuel.deloget@eho.link>
Fixes: 2f6324a3937f8 (libbpf: Support shared umems between queues and devices)
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c             |  4 ++--
 tools/lib/bpf/btf_dump.c        |  4 ++--
 tools/lib/bpf/gen_loader.c      |  6 ++----
 tools/lib/bpf/libbpf.c          |  8 +++-----
 tools/lib/bpf/libbpf_internal.h | 19 +++++++++++++++++++
 tools/lib/bpf/xsk.c             |  9 +++------
 6 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 6b2407e12060..1f84d706eb3e 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -112,7 +112,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 
 	attr.map_type = map_type;
 	if (map_name)
-		strncat(attr.map_name, map_name, sizeof(attr.map_name) - 1);
+		libbpf_strlcpy(attr.map_name, map_name, sizeof(attr.map_name));
 	attr.key_size = key_size;
 	attr.value_size = value_size;
 	attr.max_entries = max_entries;
@@ -271,7 +271,7 @@ int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
 	attr.kern_version = OPTS_GET(opts, kern_version, 0);
 
 	if (prog_name)
-		strncat(attr.prog_name, prog_name, sizeof(attr.prog_name) - 1);
+		libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
 	attr.license = ptr_to_u64(license);
 
 	if (insn_cnt > UINT_MAX)
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index f06a1d343c92..b9a3260c83cb 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2321,8 +2321,8 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 	if (!opts->indent_str)
 		d->typed_dump->indent_str[0] = '\t';
 	else
-		strncat(d->typed_dump->indent_str, opts->indent_str,
-			sizeof(d->typed_dump->indent_str) - 1);
+		libbpf_strlcpy(d->typed_dump->indent_str, opts->indent_str,
+			       sizeof(d->typed_dump->indent_str));
 
 	d->typed_dump->compact = OPTS_GET(opts, compact, false);
 	d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 21dfb930f1d2..26e8f46d4d06 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -449,8 +449,7 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 	attr.map_flags = map_attr->map_flags;
 	attr.map_extra = map_attr->map_extra;
 	if (map_name)
-		memcpy(attr.map_name, map_name,
-		       min((unsigned)strlen(map_name), BPF_OBJ_NAME_LEN - 1));
+		libbpf_strlcpy(attr.map_name, map_name, sizeof(attr.map_name));
 	attr.numa_node = map_attr->numa_node;
 	attr.map_ifindex = map_attr->map_ifindex;
 	attr.max_entries = max_entries;
@@ -956,8 +955,7 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	core_relos = add_data(gen, gen->core_relos,
 			     attr.core_relo_cnt * attr.core_relo_rec_size);
 
-	memcpy(attr.prog_name, prog_name,
-	       min((unsigned)strlen(prog_name), BPF_OBJ_NAME_LEN - 1));
+	libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
 	prog_load_attr = add_data(gen, &attr, attr_size);
 
 	/* populate union bpf_attr with a pointer to license */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d027e1d620fc..2225a5919a67 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1201,12 +1201,10 @@ static struct bpf_object *bpf_object__new(const char *path,
 
 	strcpy(obj->path, path);
 	if (obj_name) {
-		strncpy(obj->name, obj_name, sizeof(obj->name) - 1);
-		obj->name[sizeof(obj->name) - 1] = 0;
+		libbpf_strlcpy(obj->name, obj_name, sizeof(obj->name));
 	} else {
 		/* Using basename() GNU version which doesn't modify arg. */
-		strncpy(obj->name, basename((void *)path),
-			sizeof(obj->name) - 1);
+		libbpf_strlcpy(obj->name, basename((void *)path), sizeof(obj->name));
 		end = strchr(obj->name, '.');
 		if (end)
 			*end = 0;
@@ -1358,7 +1356,7 @@ static int bpf_object__check_endianness(struct bpf_object *obj)
 static int
 bpf_object__init_license(struct bpf_object *obj, void *data, size_t size)
 {
-	memcpy(obj->license, data, min(size, sizeof(obj->license) - 1));
+	libbpf_strlcpy(obj->license, data, sizeof(obj->license));
 	pr_debug("license of %s is %s\n", obj->path, obj->license);
 	return 0;
 }
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 355c41019aed..5e8166a2f3d8 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -169,6 +169,25 @@ static inline void *libbpf_reallocarray(void *ptr, size_t nmemb, size_t size)
 	return realloc(ptr, total);
 }
 
+/* Copy up to sz - 1 bytes from zero-terminated src string and ensure that dst
+ * is zero-terminated string no matter what (unless sz == 0, in which case
+ * it's a no-op). It's conceptually close to FreeBSD's strlcpy(), but differs
+ * in what is returned. Given this is internal helper, it's trivial to extend
+ * this, when necessary. Use this instead of strncpy inside libbpf source code.
+ */
+static inline void libbpf_strlcpy(char *dst, const char *src, size_t sz)
+{
+	size_t i;
+
+	if (sz == 0)
+		return;
+
+	sz--;
+	for (i = 0; i < sz && src[i]; i++)
+		dst[i] = src[i];
+	dst[i] = '\0';
+}
+
 struct btf;
 struct btf_type;
 
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index e8d94c6dd3bc..edafe56664f3 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -548,8 +548,7 @@ static int xsk_get_max_queues(struct xsk_socket *xsk)
 		return -errno;
 
 	ifr.ifr_data = (void *)&channels;
-	memcpy(ifr.ifr_name, ctx->ifname, IFNAMSIZ - 1);
-	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
+	libbpf_strlcpy(ifr.ifr_name, ctx->ifname, IFNAMSIZ);
 	err = ioctl(fd, SIOCETHTOOL, &ifr);
 	if (err && errno != EOPNOTSUPP) {
 		ret = -errno;
@@ -768,8 +767,7 @@ static int xsk_create_xsk_struct(int ifindex, struct xsk_socket *xsk)
 	}
 
 	ctx->ifindex = ifindex;
-	memcpy(ctx->ifname, ifname, IFNAMSIZ -1);
-	ctx->ifname[IFNAMSIZ - 1] = 0;
+	libbpf_strlcpy(ctx->ifname, ifname, IFNAMSIZ);
 
 	xsk->ctx = ctx;
 	xsk->ctx->has_bpf_link = xsk_probe_bpf_link();
@@ -951,8 +949,7 @@ static struct xsk_ctx *xsk_create_ctx(struct xsk_socket *xsk,
 	ctx->refcount = 1;
 	ctx->umem = umem;
 	ctx->queue_id = queue_id;
-	memcpy(ctx->ifname, ifname, IFNAMSIZ - 1);
-	ctx->ifname[IFNAMSIZ - 1] = '\0';
+	libbpf_strlcpy(ctx->ifname, ifname, IFNAMSIZ);
 
 	ctx->fill = fill;
 	ctx->comp = comp;
-- 
2.30.2

