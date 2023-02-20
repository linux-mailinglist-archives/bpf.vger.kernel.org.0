Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2EF69D74F
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 00:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjBTXu0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 18:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBTXuZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 18:50:25 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1951DCDCE
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 15:50:24 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KLnsuS007170;
        Mon, 20 Feb 2023 23:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=MnYIJRmz9xlKOFx0J7uWXvlWSkF2sS+AnuabnWUNy08=;
 b=tOhl9sLsu75UQLbphFwpEpU34PBzrvVLBIra7iH9Fjdd7JWrU5q+IzpmIgVXPOh290RJ
 q3Nn66uEbydta7g0zhDMnvae3i00Isb0CVj8AxtZszHwtf1BMmrqhOEBBlCxpqa3TgIa
 p8L5fAnHOfnodWqhWBEhg3jnVgPJr5XheF6gNd3MQ0XwVqnOLZJA+rRdhO4VykGmmcY1
 xfNnJyl5YFkf7P4w/YxFLgTi6HN+vL8PLr29uGNmzkZmf8FH3kFdDv9YmRTgYl6KcG0k
 MESH/EDcmNl9vagkydgpHP8nIIh138hvH8nTrDtXtRkg2ucNBhVKwiz7EM8Na962xDoK 4A== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvh4fa83v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 23:50:09 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KFJRSo001655;
        Mon, 20 Feb 2023 23:50:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ntpa62f9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 23:50:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KNo4D441353562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 23:50:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27BC020040;
        Mon, 20 Feb 2023 23:50:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5947520043;
        Mon, 20 Feb 2023 23:50:03 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.34.203])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 23:50:03 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] libbpf: Document bpf_{btf,link,map,prog}_get_info_by_fd()
Date:   Tue, 21 Feb 2023 00:49:58 +0100
Message-Id: <20230220234958.764997-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gFLCo2xsm11ayWwmOugG80o-KsiC26fQ
X-Proofpoint-GUID: gFLCo2xsm11ayWwmOugG80o-KsiC26fQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_17,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200218
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace the short informal description with the proper doc comments.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf.h | 67 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 9ed9bceb4111..e8c5c5832359 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -386,14 +386,73 @@ LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_link_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
 LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
-/* Type-safe variants of bpf_obj_get_info_by_fd(). The callers still needs to
- * pass info_len, which should normally be
- * sizeof(struct bpf_{prog,map,btf,link}_info), in order to be compatible with
- * different libbpf and kernel versions.
+
+/**
+ * @brief **bpf_prog_get_info_by_fd()** obtains information about the eBPF
+ * program corresponding to *bpf_fd*.
+ *
+ * Populates up to *info_len* bytes of *info* and updates *info_len* with the
+ * actual number of bytes written to *info*.
+ *
+ * @param bpf_fd eBPF program file descriptor
+ * @param info pointer to **struct bpf_prog_info** that will be populated with
+ * eBPF program information
+ * @param info_len pointer to the size of *info*; on success updated with the
+ * number of bytes written to *info*
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
  */
 LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info, __u32 *info_len);
+
+/**
+ * @brief **bpf_map_get_info_by_fd()** obtains information about the eBPF
+ * map corresponding to *bpf_fd*.
+ *
+ * Populates up to *info_len* bytes of *info* and updates *info_len* with the
+ * actual number of bytes written to *info*.
+ *
+ * @param bpf_fd eBPF map file descriptor
+ * @param info pointer to **struct bpf_map_info** that will be populated with
+ * eBPF map information
+ * @param info_len pointer to the size of *info*; on success updated with the
+ * number of bytes written to *info*
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
 LIBBPF_API int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info, __u32 *info_len);
+
+/**
+ * @brief **bpf_btf_get_info_by_fd()** obtains information about the eBPF
+ * BTF corresponding to *bpf_fd*.
+ *
+ * Populates up to *info_len* bytes of *info* and updates *info_len* with the
+ * actual number of bytes written to *info*.
+ *
+ * @param bpf_fd eBPF BTF file descriptor
+ * @param info pointer to **struct bpf_btf_info** that will be populated with
+ * eBPF BTF information
+ * @param info_len pointer to the size of *info*; on success updated with the
+ * number of bytes written to *info*
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
 LIBBPF_API int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info, __u32 *info_len);
+
+/**
+ * @brief **bpf_btf_get_info_by_fd()** obtains information about the eBPF
+ * link corresponding to *bpf_fd*.
+ *
+ * Populates up to *info_len* bytes of *info* and updates *info_len* with the
+ * actual number of bytes written to *info*.
+ *
+ * @param bpf_fd eBPF link file descriptor
+ * @param info pointer to **struct bpf_link_info** that will be populated with
+ * eBPF link information
+ * @param info_len pointer to the size of *info*; on success updated with the
+ * number of bytes written to *info*
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
 LIBBPF_API int bpf_link_get_info_by_fd(int link_fd, struct bpf_link_info *info, __u32 *info_len);
 
 struct bpf_prog_query_opts {
-- 
2.39.1

