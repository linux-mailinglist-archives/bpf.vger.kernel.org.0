Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B67594F51
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 06:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiHPEXJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 16 Aug 2022 00:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiHPEWy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 00:22:54 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD37937C414
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:56:21 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIbvjC010485
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:19:41 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hx9pypces-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:19:41 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 15 Aug 2022 17:19:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 59F401DAC7DAD; Mon, 15 Aug 2022 17:19:36 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/4] libbpf: clean up deprecated and legacy aliases
Date:   Mon, 15 Aug 2022 17:19:28 -0700
Message-ID: <20220816001929.369487-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220816001929.369487-1-andrii@kernel.org>
References: <20220816001929.369487-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: EvnJDRRtA3U7SfBICfgFh3Mmjzoh9h-j
X-Proofpoint-ORIG-GUID: EvnJDRRtA3U7SfBICfgFh3Mmjzoh9h-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove two missed deprecated APIs that were aliased to new APIs:
bpf_object__unload and bpf_prog_attach_xattr.

Also move legacy API libbpf_find_kernel_btf (aliased to
btf__load_vmlinux_btf) into libbpf_legacy.h.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c           | 5 -----
 tools/lib/bpf/btf.c           | 2 --
 tools/lib/bpf/btf.h           | 1 -
 tools/lib/bpf/libbpf.c        | 2 --
 tools/lib/bpf/libbpf_legacy.h | 2 ++
 5 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index e3a0bd7efa2f..1d49a0352836 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -641,11 +641,6 @@ int bpf_prog_attach_opts(int prog_fd, int target_fd,
 	return libbpf_err_errno(ret);
 }
 
-__attribute__((alias("bpf_prog_attach_opts")))
-int bpf_prog_attach_xattr(int prog_fd, int target_fd,
-			  enum bpf_attach_type type,
-			  const struct bpf_prog_attach_opts *opts);
-
 int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, replace_bpf_fd);
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d14f1a52d7a..361131518d63 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1225,8 +1225,6 @@ int btf__load_into_kernel(struct btf *btf)
 	return btf_load_into_kernel(btf, NULL, 0, 0);
 }
 
-int btf__load(struct btf *) __attribute__((alias("btf__load_into_kernel")));
-
 int btf__fd(const struct btf *btf)
 {
 	return btf->fd;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 583760df83b4..ae543144ee30 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -116,7 +116,6 @@ LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_b
 
 LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
 LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf);
-LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
 
 LIBBPF_API struct btf *btf__load_from_kernel_by_id(__u32 id);
 LIBBPF_API struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 89f192a3ef77..9aaf6f7e89df 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7260,8 +7260,6 @@ static int bpf_object_unload(struct bpf_object *obj)
 	return 0;
 }
 
-int bpf_object__unload(struct bpf_object *obj) __attribute__((alias("bpf_object_unload")));
-
 static int bpf_object__sanitize_maps(struct bpf_object *obj)
 {
 	struct bpf_map *m;
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index 5b7e0155db6a..1e1be467bede 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -125,6 +125,8 @@ struct bpf_map;
 struct btf;
 struct btf_ext;
 
+LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
+
 LIBBPF_API enum bpf_prog_type bpf_program__get_type(const struct bpf_program *prog);
 LIBBPF_API enum bpf_attach_type bpf_program__get_expected_attach_type(const struct bpf_program *prog);
 LIBBPF_API const char *bpf_map__get_pin_path(const struct bpf_map *map);
-- 
2.30.2

