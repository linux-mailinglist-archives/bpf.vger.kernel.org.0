Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0349568F933
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 21:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjBHU5h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 15:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjBHU51 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 15:57:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF66D48597
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 12:57:20 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318J0Ybm027893;
        Wed, 8 Feb 2023 20:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YVjshs5ZaIE/WPYD704TBQu19VbtI81FfZexo7zcVcg=;
 b=ApBBA9pR/lTXoMs3ApfwRBMc8HKKwfH5kxRkEHc2mseVA/wcT6SWGHM0E2rcx502+A81
 +J1KZecgbNaWvgs36+Y/8QHadHGiWOBtk3Ti0VenNwtLMYItNNh6LyLzFkEkhn2RQ+Se
 QF5LUhHIy/GMfosV47sW9Gy1EHg32gCYMcSqbX1QAoKH3SuMM2pdfZa1661ByQ/aV6w6
 6mqcfwfPK+yJQXHtED2lxdKZJV/fLEUcVUVenoT4l42IkYTkXq/TOpTDsobTiSackENl
 zWvoOWAsjvJZBF9OPFLH9eG3Wje9mN5YmzLw9UIkG9g9puOHyUgVFS1B9mXDHOzvFikh rA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmf6pybgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:57:03 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3186FtDZ001926;
        Wed, 8 Feb 2023 20:57:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06nbep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:57:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318KuvOt47120816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 20:56:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB0EB20049;
        Wed,  8 Feb 2023 20:56:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ABAA20040;
        Wed,  8 Feb 2023 20:56:57 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.24.149])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 20:56:57 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 9/9] selftests/bpf: Add MSan annotations
Date:   Wed,  8 Feb 2023 21:56:42 +0100
Message-Id: <20230208205642.270567-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208205642.270567-1-iii@linux.ibm.com>
References: <20230208205642.270567-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aGpAYej1uTOW71P5GlKVWSUsaQ0t5N9T
X-Proofpoint-ORIG-GUID: aGpAYej1uTOW71P5GlKVWSUsaQ0t5N9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080175
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

eBPF selftests produce a few false positives with MSan. These can be
divided in two classes:

- Sending uninitalized data via a socket.
- bpf_obj_get_info_by_fd() calls.

The first class is trivial; the second should ideally be handled by
libbpf, but it doesn't look possible at the moment, since we don't
know the type of the eBPF object referred to by fd, and therefore the
structure of the output data.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/cap_helpers.c             |  3 +++
 tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c   | 10 ++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c   |  3 +++
 tools/testing/selftests/bpf/prog_tests/btf.c          | 11 +++++++++++
 tools/testing/selftests/bpf/prog_tests/send_signal.c  |  2 ++
 .../selftests/bpf/prog_tests/tp_attach_query.c        |  6 ++++++
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c  |  3 +++
 tools/testing/selftests/bpf/xdp_synproxy.c            |  2 ++
 8 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/cap_helpers.c b/tools/testing/selftests/bpf/cap_helpers.c
index d5ac507401d7..f5775b342b30 100644
--- a/tools/testing/selftests/bpf/cap_helpers.c
+++ b/tools/testing/selftests/bpf/cap_helpers.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <bpf/libbpf_internal.h>
 #include "cap_helpers.h"
 
 /* Avoid including <sys/capability.h> from the libcap-devel package,
@@ -20,6 +21,7 @@ int cap_enable_effective(__u64 caps, __u64 *old_caps)
 	err = capget(&hdr, data);
 	if (err)
 		return err;
+	libbpf_mark_defined(data, sizeof(data));
 
 	if (old_caps)
 		*old_caps = (__u64)(data[1].effective) << 32 | data[0].effective;
@@ -50,6 +52,7 @@ int cap_disable_effective(__u64 caps, __u64 *old_caps)
 	err = capget(&hdr, data);
 	if (err)
 		return err;
+	libbpf_mark_defined(data, sizeof(data));
 
 	if (old_caps)
 		*old_caps = (__u64)(data[1].effective) << 32 | data[0].effective;
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
index e1c1e521cca2..7253d5dc4bb2 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <bpf/libbpf_internal.h>
 
 #define nr_iters 2
 
@@ -31,6 +32,7 @@ void serial_test_bpf_obj_id(void)
 	__u64 array_value;
 	uid_t my_uid = getuid();
 	time_t now, load_time;
+	int tp_name_len;
 
 	err = bpf_prog_get_fd_by_id(0);
 	CHECK(err >= 0 || errno != ENOENT,
@@ -122,6 +124,10 @@ void serial_test_bpf_obj_id(void)
 					     &info_len);
 		load_time = (real_time_ts.tv_sec - boot_time_ts.tv_sec)
 			+ (prog_infos[i].load_time / nsec_per_sec);
+		if (!err)
+			libbpf_mark_defined(&map_ids[i],
+					    prog_infos[i].nr_map_ids *
+						sizeof(map_ids[0]));
 		if (CHECK(err ||
 			  prog_infos[i].type != BPF_PROG_TYPE_RAW_TRACEPOINT ||
 			  info_len != sizeof(struct bpf_prog_info) ||
@@ -163,6 +169,10 @@ void serial_test_bpf_obj_id(void)
 		link_infos[i].raw_tracepoint.tp_name_len = sizeof(tp_name);
 		err = bpf_obj_get_info_by_fd(bpf_link__fd(links[i]),
 					     &link_infos[i], &info_len);
+		if (!err) {
+			tp_name_len = link_infos[i].raw_tracepoint.tp_name_len;
+			libbpf_mark_defined(tp_name, tp_name_len + 1);
+		}
 		if (CHECK(err ||
 			  link_infos[i].type != BPF_LINK_TYPE_RAW_TRACEPOINT ||
 			  link_infos[i].prog_id != prog_infos[i].id ||
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index e980188d4124..11f02f68e152 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -4,6 +4,7 @@
 #include <linux/err.h>
 #include <netinet/tcp.h>
 #include <test_progs.h>
+#include <bpf/libbpf_internal.h>
 #include "network_helpers.h"
 #include "bpf_dctcp.skel.h"
 #include "bpf_cubic.skel.h"
@@ -39,6 +40,8 @@ static void *server(void *arg)
 	ssize_t nr_sent = 0, bytes = 0;
 	char batch[1500];
 
+	libbpf_mark_defined(batch, sizeof(batch));
+
 	fd = accept(lfd, NULL, NULL);
 	while (fd == -1) {
 		if (errno == EINTR)
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index de1b5b9eb93a..ff6950404c02 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -20,6 +20,7 @@
 #include <assert.h>
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
+#include <bpf/libbpf_internal.h>
 
 #include "bpf_util.h"
 #include "../test_btf.h"
@@ -4500,6 +4501,8 @@ static int test_btf_id(unsigned int test_num)
 	/* Test BPF_OBJ_GET_INFO_BY_ID on btf_id */
 	info_len = sizeof(info[0]);
 	err = bpf_obj_get_info_by_fd(btf_fd[0], &info[0], &info_len);
+	if (!err)
+		libbpf_mark_defined(user_btf[0], info[0].btf_size);
 	if (CHECK(err, "errno:%d", errno)) {
 		err = -1;
 		goto done;
@@ -4513,6 +4516,8 @@ static int test_btf_id(unsigned int test_num)
 
 	ret = 0;
 	err = bpf_obj_get_info_by_fd(btf_fd[1], &info[1], &info_len);
+	if (!err)
+		libbpf_mark_defined(user_btf[1], info[1].btf_size);
 	if (CHECK(err || info[0].id != info[1].id ||
 		  info[0].btf_size != info[1].btf_size ||
 		  (ret = memcmp(user_btf[0], user_btf[1], info[0].btf_size)),
@@ -4639,6 +4644,8 @@ static void do_test_get_info(unsigned int test_num)
 
 	ret = 0;
 	err = bpf_obj_get_info_by_fd(btf_fd, &info, &info_len);
+	if (!err)
+		libbpf_mark_defined(user_btf, info.btf_size);
 	if (CHECK(err || !info.id || info_len != sizeof(info) ||
 		  info.btf_size != raw_btf_size ||
 		  (ret = memcmp(raw_btf, user_btf, expected_nbytes)),
@@ -4788,6 +4795,8 @@ static void do_test_file(unsigned int test_num)
 	info.func_info = ptr_to_u64(func_info);
 
 	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!err)
+		libbpf_mark_defined(func_info, info.nr_func_info * rec_size);
 
 	if (CHECK(err < 0, "invalid get info (2nd) errno:%d", errno)) {
 		fprintf(stderr, "%s\n", btf_log_buf);
@@ -6436,6 +6445,8 @@ static int test_get_finfo(const struct prog_info_raw_test *test,
 	info.func_info_rec_size = rec_size;
 	info.func_info = ptr_to_u64(func_info);
 	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!err)
+		libbpf_mark_defined(func_info, info.nr_func_info * rec_size);
 	if (CHECK(err < 0, "invalid get info (2nd) errno:%d", errno)) {
 		fprintf(stderr, "%s\n", btf_log_buf);
 		err = -1;
diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index d63a20fbed33..94f42b48e45d 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <bpf/libbpf_internal.h>
 #include <sys/time.h>
 #include <sys/resource.h>
 #include "test_send_signal_kern.skel.h"
@@ -58,6 +59,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 		ASSERT_OK(setpriority(PRIO_PROCESS, 0, -20), "setpriority");
 
 		/* notify parent signal handler is installed */
+		libbpf_mark_defined(buf, 1);
 		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
 
 		/* make sure parent enabled bpf program to send_signal */
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
index a479080533db..259bd8102907 100644
--- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <bpf/libbpf_internal.h>
 
 void serial_test_tp_attach_query(void)
 {
@@ -65,6 +66,7 @@ void serial_test_tp_attach_query(void)
 		if (i == 0) {
 			/* check NULL prog array query */
 			query->ids_len = num_progs;
+			query->prog_cnt = 0;
 			err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
 			if (CHECK(err || query->prog_cnt != 0,
 				  "perf_event_ioc_query_bpf",
@@ -109,6 +111,10 @@ void serial_test_tp_attach_query(void)
 
 		query->ids_len = num_progs;
 		err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
+		if (!err)
+			libbpf_mark_defined(query->ids,
+					    query->prog_cnt *
+						sizeof(query->ids[0]));
 		if (CHECK(err || query->prog_cnt != (i + 1),
 			  "perf_event_ioc_query_bpf",
 			  "err %d errno %d query->prog_cnt %u\n",
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index 5e3a26b15ec6..2620c66533b9 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -14,6 +14,7 @@
 #include <net/if.h>
 #include <linux/if_link.h>
 #include "test_progs.h"
+#include "bpf/libbpf_internal.h"
 #include "network_helpers.h"
 #include <linux/if_bonding.h>
 #include <linux/limits.h>
@@ -224,6 +225,8 @@ static int send_udp_packets(int vary_dst_ip)
 	int i, s = -1;
 	int ifindex;
 
+	libbpf_mark_defined(buf, sizeof(buf));
+
 	s = socket(AF_PACKET, SOCK_RAW, IPPROTO_RAW);
 	if (!ASSERT_GE(s, 0, "socket"))
 		goto err;
diff --git a/tools/testing/selftests/bpf/xdp_synproxy.c b/tools/testing/selftests/bpf/xdp_synproxy.c
index 6dbe0b745198..7667393bc7b5 100644
--- a/tools/testing/selftests/bpf/xdp_synproxy.c
+++ b/tools/testing/selftests/bpf/xdp_synproxy.c
@@ -12,6 +12,7 @@
 #include <sys/types.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include <bpf/libbpf_internal.h>
 #include <net/if.h>
 #include <linux/if_link.h>
 #include <linux/limits.h>
@@ -297,6 +298,7 @@ static int syncookie_open_bpf_maps(__u32 prog_id, int *values_map_fd, int *ports
 		fprintf(stderr, "Error: bpf_obj_get_info_by_fd: %s\n", strerror(-err));
 		goto out;
 	}
+	libbpf_mark_defined(map_ids, prog_info.nr_map_ids * sizeof(map_ids[0]));
 
 	if (prog_info.nr_map_ids < 2) {
 		fprintf(stderr, "Error: Found %u BPF maps, expected at least 2\n",
-- 
2.39.1

