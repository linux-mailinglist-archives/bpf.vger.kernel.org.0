Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B70657EB45
	for <lists+bpf@lfdr.de>; Sat, 23 Jul 2022 04:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiGWCE0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 22:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbiGWCEX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 22:04:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20964A720E
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 19:04:19 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26N1hrac017239;
        Sat, 23 Jul 2022 02:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OElqhzzb2lk+NJLOVCtgC5+mdoibLt0oMR0zpbqhc4Y=;
 b=Zk2XrgHkCzMyut6prn++dUqckm7Cbv0ouxKQOW2yOpvIddfHb4BxrxbzsNyvl3Kipa4f
 vbSalGQhDAnM6PAiIgrujzWWtrNCoxfeZqe/ZhQCify0kB4C9WdXCI3IGpthuN2V6ZJ2
 d4tcoB0uRF0Un4UT6fnJEPXaMHFVucrzuxUnzp9a9olFIbxiIitqbVdqXn0nip8A8Yjk
 sW3k619pwYy+dGMnbtZmnh5imtMEQEOxscr0rIWAOgiMk/FE+Y3OfJXBjR2PZrKaGuGM
 gMy5iipUzBvxGVQbxNQ6WbLjpDUbvKaXssk5QMG+T1W62CGw2IPhB+pT+0D84EMsw1lK BQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hg7k5raw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jul 2022 02:04:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26N1qBO1024816;
        Sat, 23 Jul 2022 02:04:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3hfyhsrch6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jul 2022 02:04:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26N23wWB15925742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jul 2022 02:03:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6CABAE04D;
        Sat, 23 Jul 2022 02:03:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61EB1AE053;
        Sat, 23 Jul 2022 02:03:58 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.90.71])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 23 Jul 2022 02:03:58 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Attach to socketcall() in test_probe_user
Date:   Sat, 23 Jul 2022 04:03:44 +0200
Message-Id: <20220723020344.21699-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220723020344.21699-1-iii@linux.ibm.com>
References: <20220723020344.21699-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t0T6SPPWLKM13HDXf1aOCsqnnrkXSu_1
X-Proofpoint-GUID: t0T6SPPWLKM13HDXf1aOCsqnnrkXSu_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207230007
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_probe_user fails on architectures where libc uses
socketcall(SYS_CONNECT) instead of connect(). Fix by attaching to
socketcall as well.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/probe_user.c     | 35 +++++++++++++------
 .../selftests/bpf/progs/test_probe_user.c     | 28 +++++++++++++--
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
index abf890d066eb..76c8e06b0357 100644
--- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
@@ -4,25 +4,35 @@
 /* TODO: corrupts other tests uses connect() */
 void serial_test_probe_user(void)
 {
-	const char *prog_name = "handle_sys_connect";
+	const char *prog_names[] = {
+		"handle_sys_connect",
+#if defined(__s390x__)
+		"handle_sys_socketcall",
+#endif
+	};
+	const size_t prog_count = ARRAY_SIZE(prog_names);
 	const char *obj_file = "./test_probe_user.o";
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts, );
 	int err, results_map_fd, sock_fd, duration = 0;
 	struct sockaddr curr, orig, tmp;
 	struct sockaddr_in *in = (struct sockaddr_in *)&curr;
-	struct bpf_link *kprobe_link = NULL;
-	struct bpf_program *kprobe_prog;
+	struct bpf_link *kprobe_links[ARRAY_SIZE(prog_names)] = {};
+	struct bpf_program *kprobe_progs[ARRAY_SIZE(prog_names)];
 	struct bpf_object *obj;
 	static const int zero = 0;
+	size_t i;
 
 	obj = bpf_object__open_file(obj_file, &opts);
 	if (!ASSERT_OK_PTR(obj, "obj_open_file"))
 		return;
 
-	kprobe_prog = bpf_object__find_program_by_name(obj, prog_name);
-	if (CHECK(!kprobe_prog, "find_probe",
-		  "prog '%s' not found\n", prog_name))
-		goto cleanup;
+	for (i = 0; i < prog_count; i++) {
+		kprobe_progs[i] =
+			bpf_object__find_program_by_name(obj, prog_names[i]);
+		if (CHECK(!kprobe_progs[i], "find_probe",
+			  "prog '%s' not found\n", prog_names[i]))
+			goto cleanup;
+	}
 
 	err = bpf_object__load(obj);
 	if (CHECK(err, "obj_load", "err %d\n", err))
@@ -33,9 +43,11 @@ void serial_test_probe_user(void)
 		  "err %d\n", results_map_fd))
 		goto cleanup;
 
-	kprobe_link = bpf_program__attach(kprobe_prog);
-	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe"))
-		goto cleanup;
+	for (i = 0; i < prog_count; i++) {
+		kprobe_links[i] = bpf_program__attach(kprobe_progs[i]);
+		if (!ASSERT_OK_PTR(kprobe_links[i], "attach_kprobe"))
+			goto cleanup;
+	}
 
 	memset(&curr, 0, sizeof(curr));
 	in->sin_family = AF_INET;
@@ -69,6 +81,7 @@ void serial_test_probe_user(void)
 		  inet_ntoa(in->sin_addr), ntohs(in->sin_port)))
 		goto cleanup;
 cleanup:
-	bpf_link__destroy(kprobe_link);
+	for (i = 0; i < ARRAY_SIZE(prog_names); i++)
+		bpf_link__destroy(kprobe_links[i]);
 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
index 8e1495008e4d..78e50c37fa21 100644
--- a/tools/testing/selftests/bpf/progs/test_probe_user.c
+++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
@@ -5,10 +5,13 @@
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
 
+#ifndef SYS_CONNECT
+#define SYS_CONNECT 3
+#endif
+
 static struct sockaddr_in old;
 
-SEC("ksyscall/connect")
-int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in *uservaddr, int addrlen)
+static int handle_sys_connect_common(struct sockaddr_in *uservaddr)
 {
 	struct sockaddr_in new;
 
@@ -19,4 +22,25 @@ int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in *uservaddr, int
 	return 0;
 }
 
+SEC("ksyscall/connect")
+int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in *uservaddr,
+		 int addrlen)
+{
+	return handle_sys_connect_common(uservaddr);
+}
+
+SEC("ksyscall/socketcall")
+int BPF_KSYSCALL(handle_sys_socketcall, int call, unsigned long *args)
+{
+	if (call == SYS_CONNECT) {
+		struct sockaddr_in *uservaddr;
+
+		bpf_probe_read_user(&uservaddr, sizeof(uservaddr), &args[1]);
+
+		return handle_sys_connect_common(uservaddr);
+	}
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.35.3

