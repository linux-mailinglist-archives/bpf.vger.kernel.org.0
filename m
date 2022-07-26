Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFDB581453
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 15:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiGZNkd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiGZNkb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 09:40:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F0517E3C
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 06:40:29 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QCH13l003043;
        Tue, 26 Jul 2022 13:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=m+9WCWCnqrjRVmAeiGskU04hJpCm1xZDjPOrh/PTxOE=;
 b=hpdpJbQcJw5X0bpZeGvQQoSpou7aDkXipAw+B43R7ysrIIMV1c/yU77ujn/gCQklddMc
 +4YSYdSkZX/wditrb4fbiv+4i5L7d/+gxt3hwvIytEdvuMwFsaLZBRAap63vhKK8N4xm
 0hFGVwjRF+f/aXJxoDvaosm8x6OvBRS1dq0rJxeGKFU1HUC80Lxh7TRlZdQBtVNtO65C
 R0fJA5wj4w7lo/esIzv8nYIsSI+VyvbbIp4cXda0fUU6zdxd3RFWT8YHvpjI3QGOq/d5
 rJK+mj5yBTekQrtXjdpQrX9NxARcUxqdrbld4cbOKQmJTTOcOCwgESQ7dBIJddn2BV0t dw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjg4wataq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 13:40:15 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26QDLPeS016912;
        Tue, 26 Jul 2022 13:40:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3hg95yavjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 13:40:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26QDeAbB15204634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 13:40:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6B3EA4066;
        Tue, 26 Jul 2022 13:40:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51E8BA405B;
        Tue, 26 Jul 2022 13:40:10 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.20.53])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jul 2022 13:40:10 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Attach to socketcall() in test_probe_user
Date:   Tue, 26 Jul 2022 15:40:08 +0200
Message-Id: <20220726134008.256968-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220726134008.256968-1-iii@linux.ibm.com>
References: <20220726134008.256968-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Kd5P1-n2BJeuCKOUiTupv6OqlRREcooz
X-Proofpoint-GUID: Kd5P1-n2BJeuCKOUiTupv6OqlRREcooz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207260051
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
 .../selftests/bpf/progs/test_probe_user.c     | 32 +++++++++++++++--
 2 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
index abf890d066eb..34dbd2adc157 100644
--- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
@@ -4,25 +4,35 @@
 /* TODO: corrupts other tests uses connect() */
 void serial_test_probe_user(void)
 {
-	const char *prog_name = "handle_sys_connect";
+	static const char *const prog_names[] = {
+		"handle_sys_connect",
+#if defined(__s390x__)
+		"handle_sys_socketcall",
+#endif
+	};
+	enum { prog_count = ARRAY_SIZE(prog_names) };
 	const char *obj_file = "./test_probe_user.o";
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts, );
 	int err, results_map_fd, sock_fd, duration = 0;
 	struct sockaddr curr, orig, tmp;
 	struct sockaddr_in *in = (struct sockaddr_in *)&curr;
-	struct bpf_link *kprobe_link = NULL;
-	struct bpf_program *kprobe_prog;
+	struct bpf_link *kprobe_links[prog_count] = {};
+	struct bpf_program *kprobe_progs[prog_count];
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
+	for (i = 0; i < prog_count; i++)
+		bpf_link__destroy(kprobe_links[i]);
 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
index 8e1495008e4d..476e310f8a0a 100644
--- a/tools/testing/selftests/bpf/progs/test_probe_user.c
+++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
@@ -7,8 +7,7 @@
 
 static struct sockaddr_in old;
 
-SEC("ksyscall/connect")
-int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in *uservaddr, int addrlen)
+static int handle_sys_connect_common(struct sockaddr_in *uservaddr)
 {
 	struct sockaddr_in new;
 
@@ -19,4 +18,33 @@ int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in *uservaddr, int
 	return 0;
 }
 
+SEC("ksyscall/connect")
+int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in *uservaddr,
+		 int addrlen)
+{
+	return handle_sys_connect_common(uservaddr);
+}
+
+#if defined(bpf_target_s390)
+
+#ifndef SYS_CONNECT
+#define SYS_CONNECT 3
+#endif
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
+#endif
+
 char _license[] SEC("license") = "GPL";
-- 
2.35.3

