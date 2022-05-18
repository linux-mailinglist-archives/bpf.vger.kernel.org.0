Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F8D52C2E9
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 21:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241823AbiERS7b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 18 May 2022 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbiERS7b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 14:59:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9063CA5B
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:30 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24IHDXOl031032
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:29 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g4836v7ay-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:29 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 18 May 2022 11:59:26 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8C8351A12C57B; Wed, 18 May 2022 11:59:22 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH bpf-next 3/3] libbpf: remove bpf_create_map*() APIs
Date:   Wed, 18 May 2022 11:59:15 -0700
Message-ID: <20220518185915.3529475-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220518185915.3529475-1-andrii@kernel.org>
References: <20220518185915.3529475-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ak8NiBwLrzOvEhKfcl4QSiZ1JKL4sFVM
X-Proofpoint-ORIG-GUID: Ak8NiBwLrzOvEhKfcl4QSiZ1JKL4sFVM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To test API removal, get rid of bpf_create_map*() APIs. Perf defines
__weak implementation of bpf_map_create() that redirects to old
bpf_create_map() and that seems to compile and run fine.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 80 ---------------------------------------------
 tools/lib/bpf/bpf.h | 42 ------------------------
 2 files changed, 122 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 4677644d80f4..240186aac8e6 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -208,86 +208,6 @@ int bpf_map_create(enum bpf_map_type map_type,
 	return libbpf_err_errno(fd);
 }
 
-int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
-{
-	LIBBPF_OPTS(bpf_map_create_opts, p);
-
-	p.map_flags = create_attr->map_flags;
-	p.numa_node = create_attr->numa_node;
-	p.btf_fd = create_attr->btf_fd;
-	p.btf_key_type_id = create_attr->btf_key_type_id;
-	p.btf_value_type_id = create_attr->btf_value_type_id;
-	p.map_ifindex = create_attr->map_ifindex;
-	if (create_attr->map_type == BPF_MAP_TYPE_STRUCT_OPS)
-		p.btf_vmlinux_value_type_id = create_attr->btf_vmlinux_value_type_id;
-	else
-		p.inner_map_fd = create_attr->inner_map_fd;
-
-	return bpf_map_create(create_attr->map_type, create_attr->name,
-			      create_attr->key_size, create_attr->value_size,
-			      create_attr->max_entries, &p);
-}
-
-int bpf_create_map_node(enum bpf_map_type map_type, const char *name,
-			int key_size, int value_size, int max_entries,
-			__u32 map_flags, int node)
-{
-	LIBBPF_OPTS(bpf_map_create_opts, opts);
-
-	opts.map_flags = map_flags;
-	if (node >= 0) {
-		opts.numa_node = node;
-		opts.map_flags |= BPF_F_NUMA_NODE;
-	}
-
-	return bpf_map_create(map_type, name, key_size, value_size, max_entries, &opts);
-}
-
-int bpf_create_map(enum bpf_map_type map_type, int key_size,
-		   int value_size, int max_entries, __u32 map_flags)
-{
-	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = map_flags);
-
-	return bpf_map_create(map_type, NULL, key_size, value_size, max_entries, &opts);
-}
-
-int bpf_create_map_name(enum bpf_map_type map_type, const char *name,
-			int key_size, int value_size, int max_entries,
-			__u32 map_flags)
-{
-	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = map_flags);
-
-	return bpf_map_create(map_type, name, key_size, value_size, max_entries, &opts);
-}
-
-int bpf_create_map_in_map_node(enum bpf_map_type map_type, const char *name,
-			       int key_size, int inner_map_fd, int max_entries,
-			       __u32 map_flags, int node)
-{
-	LIBBPF_OPTS(bpf_map_create_opts, opts);
-
-	opts.inner_map_fd = inner_map_fd;
-	opts.map_flags = map_flags;
-	if (node >= 0) {
-		opts.map_flags |= BPF_F_NUMA_NODE;
-		opts.numa_node = node;
-	}
-
-	return bpf_map_create(map_type, name, key_size, 4, max_entries, &opts);
-}
-
-int bpf_create_map_in_map(enum bpf_map_type map_type, const char *name,
-			  int key_size, int inner_map_fd, int max_entries,
-			  __u32 map_flags)
-{
-	LIBBPF_OPTS(bpf_map_create_opts, opts,
-		.inner_map_fd = inner_map_fd,
-		.map_flags = map_flags,
-	);
-
-	return bpf_map_create(map_type, name, key_size, 4, max_entries, &opts);
-}
-
 static void *
 alloc_zero_tailing_info(const void *orecord, __u32 cnt,
 			__u32 actual_rec_size, __u32 expected_rec_size)
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 2e0d3731e4c0..cabc03703e29 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -61,48 +61,6 @@ LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      __u32 max_entries,
 			      const struct bpf_map_create_opts *opts);
 
-struct bpf_create_map_attr {
-	const char *name;
-	enum bpf_map_type map_type;
-	__u32 map_flags;
-	__u32 key_size;
-	__u32 value_size;
-	__u32 max_entries;
-	__u32 numa_node;
-	__u32 btf_fd;
-	__u32 btf_key_type_id;
-	__u32 btf_value_type_id;
-	__u32 map_ifindex;
-	union {
-		__u32 inner_map_fd;
-		__u32 btf_vmlinux_value_type_id;
-	};
-};
-
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
-LIBBPF_API int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr);
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
-LIBBPF_API int bpf_create_map_node(enum bpf_map_type map_type, const char *name,
-				   int key_size, int value_size,
-				   int max_entries, __u32 map_flags, int node);
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
-LIBBPF_API int bpf_create_map_name(enum bpf_map_type map_type, const char *name,
-				   int key_size, int value_size,
-				   int max_entries, __u32 map_flags);
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
-LIBBPF_API int bpf_create_map(enum bpf_map_type map_type, int key_size,
-			      int value_size, int max_entries, __u32 map_flags);
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
-LIBBPF_API int bpf_create_map_in_map_node(enum bpf_map_type map_type,
-					  const char *name, int key_size,
-					  int inner_map_fd, int max_entries,
-					  __u32 map_flags, int node);
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
-LIBBPF_API int bpf_create_map_in_map(enum bpf_map_type map_type,
-				     const char *name, int key_size,
-				     int inner_map_fd, int max_entries,
-				     __u32 map_flags);
-
 struct bpf_prog_load_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 
-- 
2.30.2

