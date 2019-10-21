Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20704DE2A3
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2019 05:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfJUDja (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Oct 2019 23:39:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4148 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727021AbfJUDj3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 20 Oct 2019 23:39:29 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9L3U6AN029846
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2019 20:39:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=YCPor7IDddhS2XsHLQmmePjuLiX3llqVS2QljwMr5uM=;
 b=qaOoJ5on8JLJpZUGirrvXTKxFvk33+06e+Xaty8z0isJElIrZZ4UhiKWpTaJkV4RDFDe
 7io8hk/0LwDXk3CpyEa5VPaaPp4iaavC0/HyDmozvZpWNM4GxtztJEko7Z2pMl+2UacA
 /5c85VQgU3gy7FFHEOCfxq+swUN0iEECQPE= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2vqwyyd5k2-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2019 20:39:28 -0700
Received: from 2401:db00:12:909f:face:0:3:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sun, 20 Oct 2019 20:39:25 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 3135F861976; Sun, 20 Oct 2019 20:39:20 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 7/7] selftest/bpf: get rid of a bunch of explicit BPF program type setting
Date:   Sun, 20 Oct 2019 20:39:02 -0700
Message-ID: <20191021033902.3856966-8-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021033902.3856966-1-andriin@fb.com>
References: <20191021033902.3856966-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_01:2019-10-18,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=8 mlxlogscore=530 impostorscore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910210029
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that libbpf can correctly guess BPF program types from section
names, remove a bunch of explicit bpf_program__set_type() calls
throughout tests.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/attach_probe.c | 5 -----
 tools/testing/selftests/bpf/prog_tests/core_reloc.c   | 1 -
 tools/testing/selftests/bpf/prog_tests/rdonly_maps.c  | 4 ----
 tools/testing/selftests/bpf/test_maps.c               | 4 ----
 4 files changed, 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 4f50d32c4abb..0ee1ce100a4a 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -99,11 +99,6 @@ void test_attach_probe(void)
 		  "prog '%s' not found\n", uretprobe_name))
 		goto cleanup;
 
-	bpf_program__set_kprobe(kprobe_prog);
-	bpf_program__set_kprobe(kretprobe_prog);
-	bpf_program__set_kprobe(uprobe_prog);
-	bpf_program__set_kprobe(uretprobe_prog);
-
 	/* create maps && load programs */
 	err = bpf_object__load(obj);
 	if (CHECK(err, "obj_load", "err %d\n", err))
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 2b3586dc6c86..523dca82dc82 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -391,7 +391,6 @@ void test_core_reloc(void)
 		if (CHECK(!prog, "find_probe",
 			  "prog '%s' not found\n", probe_name))
 			goto cleanup;
-		bpf_program__set_type(prog, BPF_PROG_TYPE_RAW_TRACEPOINT);
 
 		load_attr.obj = obj;
 		load_attr.log_level = 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c b/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
index 9bf9de0aaeea..d90acc13d1ec 100644
--- a/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
+++ b/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
@@ -36,10 +36,6 @@ void test_rdonly_maps(void)
 	if (CHECK(IS_ERR(obj), "obj_open", "err %ld\n", PTR_ERR(obj)))
 		return;
 
-	bpf_object__for_each_program(prog, obj) {
-		bpf_program__set_raw_tracepoint(prog);
-	}
-
 	err = bpf_object__load(obj);
 	if (CHECK(err, "obj_load", "err %d errno %d\n", err, errno))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 806b298397d3..02eae1e864c2 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1142,7 +1142,6 @@ static void test_sockmap(unsigned int tasks, void *data)
 #define MAPINMAP_PROG "./test_map_in_map.o"
 static void test_map_in_map(void)
 {
-	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct bpf_map *map;
 	int mim_fd, fd, err;
@@ -1179,9 +1178,6 @@ static void test_map_in_map(void)
 		goto out_map_in_map;
 	}
 
-	bpf_object__for_each_program(prog, obj) {
-		bpf_program__set_xdp(prog);
-	}
 	bpf_object__load(obj);
 
 	map = bpf_object__find_map_by_name(obj, "mim_array");
-- 
2.17.1

