Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5548355D59B
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbiF0VPp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Jun 2022 17:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241063AbiF0VPo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:15:44 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF4318381
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:43 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RJ1QpD004938
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:42 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gx03ywcyk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:42 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:15:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0B43F1BAC2793; Mon, 27 Jun 2022 14:15:37 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 04/15] libbpf: remove deprecated probing APIs
Date:   Mon, 27 Jun 2022 14:15:16 -0700
Message-ID: <20220627211527.2245459-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627211527.2245459-1-andrii@kernel.org>
References: <20220627211527.2245459-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tlVpsvzt1Urn5Mad6yMr_eFo1OiRxAxj
X-Proofpoint-ORIG-GUID: tlVpsvzt1Urn5Mad6yMr_eFo1OiRxAxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Get rid of deprecated feature-probing APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.h        |   8 ---
 tools/lib/bpf/libbpf.map      |   4 --
 tools/lib/bpf/libbpf_probes.c | 125 ++--------------------------------
 3 files changed, 5 insertions(+), 132 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d1c93a1e7d66..71b19ae1659c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1412,14 +1412,6 @@ bpf_prog_linfo__lfind(const struct bpf_prog_linfo *prog_linfo,
  * user, causing subsequent probes to fail. In this case, the caller may want
  * to adjust that limit with setrlimit().
  */
-LIBBPF_DEPRECATED_SINCE(0, 8, "use libbpf_probe_bpf_prog_type() instead")
-LIBBPF_API bool bpf_probe_prog_type(enum bpf_prog_type prog_type, __u32 ifindex);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use libbpf_probe_bpf_map_type() instead")
-LIBBPF_API bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use libbpf_probe_bpf_helper() instead")
-LIBBPF_API bool bpf_probe_helper(enum bpf_func_id id, enum bpf_prog_type prog_type, __u32 ifindex);
-LIBBPF_DEPRECATED_SINCE(0, 8, "implement your own or use bpftool for feature detection")
-LIBBPF_API bool bpf_probe_large_insn_limit(__u32 ifindex);
 
 /**
  * @brief **libbpf_probe_bpf_prog_type()** detects if host kernel supports
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 713c769f125a..3cea0bab95ea 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -112,9 +112,6 @@ LIBBPF_0.0.1 {
 
 LIBBPF_0.0.2 {
 	global:
-		bpf_probe_helper;
-		bpf_probe_map_type;
-		bpf_probe_prog_type;
 		bpf_map__resize;
 		bpf_map_lookup_elem_flags;
 		bpf_object__btf;
@@ -200,7 +197,6 @@ LIBBPF_0.0.7 {
 		bpf_object__detach_skeleton;
 		bpf_object__load_skeleton;
 		bpf_object__open_skeleton;
-		bpf_probe_large_insn_limit;
 		bpf_program__attach;
 		bpf_program__name;
 		bpf_program__is_extension;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 97b06cede56f..0b5398786bf3 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -17,47 +17,14 @@
 #include "libbpf.h"
 #include "libbpf_internal.h"
 
-static bool grep(const char *buffer, const char *pattern)
-{
-	return !!strstr(buffer, pattern);
-}
-
-static int get_vendor_id(int ifindex)
-{
-	char ifname[IF_NAMESIZE], path[64], buf[8];
-	ssize_t len;
-	int fd;
-
-	if (!if_indextoname(ifindex, ifname))
-		return -1;
-
-	snprintf(path, sizeof(path), "/sys/class/net/%s/device/vendor", ifname);
-
-	fd = open(path, O_RDONLY | O_CLOEXEC);
-	if (fd < 0)
-		return -1;
-
-	len = read(fd, buf, sizeof(buf));
-	close(fd);
-	if (len < 0)
-		return -1;
-	if (len >= (ssize_t)sizeof(buf))
-		return -1;
-	buf[len] = '\0';
-
-	return strtol(buf, NULL, 0);
-}
-
 static int probe_prog_load(enum bpf_prog_type prog_type,
 			   const struct bpf_insn *insns, size_t insns_cnt,
-			   char *log_buf, size_t log_buf_sz,
-			   __u32 ifindex)
+			   char *log_buf, size_t log_buf_sz)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.log_buf = log_buf,
 		.log_size = log_buf_sz,
 		.log_level = log_buf ? 1 : 0,
-		.prog_ifindex = ifindex,
 	);
 	int fd, err, exp_err = 0;
 	const char *exp_msg = NULL;
@@ -161,31 +128,10 @@ int libbpf_probe_bpf_prog_type(enum bpf_prog_type prog_type, const void *opts)
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0, 0);
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0);
 	return libbpf_err(ret);
 }
 
-bool bpf_probe_prog_type(enum bpf_prog_type prog_type, __u32 ifindex)
-{
-	struct bpf_insn insns[2] = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN()
-	};
-
-	/* prefer libbpf_probe_bpf_prog_type() unless offload is requested */
-	if (ifindex == 0)
-		return libbpf_probe_bpf_prog_type(prog_type, NULL) == 1;
-
-	if (ifindex && prog_type == BPF_PROG_TYPE_SCHED_CLS)
-		/* nfp returns -EINVAL on exit(0) with TC offload */
-		insns[0].imm = 2;
-
-	errno = 0;
-	probe_prog_load(prog_type, insns, ARRAY_SIZE(insns), NULL, 0, ifindex);
-
-	return errno != EINVAL && errno != EOPNOTSUPP;
-}
-
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 			 const char *str_sec, size_t str_len)
 {
@@ -242,15 +188,13 @@ static int load_local_storage_btf(void)
 				     strs, sizeof(strs));
 }
 
-static int probe_map_create(enum bpf_map_type map_type, __u32 ifindex)
+static int probe_map_create(enum bpf_map_type map_type)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts);
 	int key_size, value_size, max_entries;
 	__u32 btf_key_type_id = 0, btf_value_type_id = 0;
 	int fd = -1, btf_fd = -1, fd_inner = -1, exp_err = 0, err;
 
-	opts.map_ifindex = ifindex;
-
 	key_size	= sizeof(__u32);
 	value_size	= sizeof(__u32);
 	max_entries	= 1;
@@ -326,12 +270,6 @@ static int probe_map_create(enum bpf_map_type map_type, __u32 ifindex)
 
 	if (map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS ||
 	    map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
-		/* TODO: probe for device, once libbpf has a function to create
-		 * map-in-map for offload
-		 */
-		if (ifindex)
-			goto cleanup;
-
 		fd_inner = bpf_map_create(BPF_MAP_TYPE_HASH, NULL,
 					  sizeof(__u32), sizeof(__u32), 1, NULL);
 		if (fd_inner < 0)
@@ -370,15 +308,10 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	ret = probe_map_create(map_type, 0);
+	ret = probe_map_create(map_type);
 	return libbpf_err(ret);
 }
 
-bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
-{
-	return probe_map_create(map_type, ifindex) == 1;
-}
-
 int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
 			    const void *opts)
 {
@@ -407,7 +340,7 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 	}
 
 	buf[0] = '\0';
-	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf), 0);
+	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
 	if (ret < 0)
 		return libbpf_err(ret);
 
@@ -427,51 +360,3 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 		return 0;
 	return 1; /* assume supported */
 }
-
-bool bpf_probe_helper(enum bpf_func_id id, enum bpf_prog_type prog_type,
-		      __u32 ifindex)
-{
-	struct bpf_insn insns[2] = {
-		BPF_EMIT_CALL(id),
-		BPF_EXIT_INSN()
-	};
-	char buf[4096] = {};
-	bool res;
-
-	probe_prog_load(prog_type, insns, ARRAY_SIZE(insns), buf, sizeof(buf), ifindex);
-	res = !grep(buf, "invalid func ") && !grep(buf, "unknown func ");
-
-	if (ifindex) {
-		switch (get_vendor_id(ifindex)) {
-		case 0x19ee: /* Netronome specific */
-			res = res && !grep(buf, "not supported by FW") &&
-				!grep(buf, "unsupported function id");
-			break;
-		default:
-			break;
-		}
-	}
-
-	return res;
-}
-
-/*
- * Probe for availability of kernel commit (5.3):
- *
- * c04c0d2b968a ("bpf: increase complexity limit and maximum program size")
- */
-bool bpf_probe_large_insn_limit(__u32 ifindex)
-{
-	struct bpf_insn insns[BPF_MAXINSNS + 1];
-	int i;
-
-	for (i = 0; i < BPF_MAXINSNS; i++)
-		insns[i] = BPF_MOV64_IMM(BPF_REG_0, 1);
-	insns[BPF_MAXINSNS] = BPF_EXIT_INSN();
-
-	errno = 0;
-	probe_prog_load(BPF_PROG_TYPE_SCHED_CLS, insns, ARRAY_SIZE(insns), NULL, 0,
-			ifindex);
-
-	return errno != E2BIG && errno != EINVAL;
-}
-- 
2.30.2

