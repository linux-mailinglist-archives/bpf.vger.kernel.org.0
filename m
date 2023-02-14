Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A354C697197
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjBNXMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjBNXMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:12:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2853E1B5
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:12:49 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EMi8nh028094;
        Tue, 14 Feb 2023 23:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zLf5pdxQOXdmqzTFhgclQM/YYwXeaMLO71r6cu5ljls=;
 b=gyNQEwOoxmsy68YvaEWn4gEd9zQhiuZ4YnAEelT/yUS++JEovfbhcvZFZbB9r9oGF7k+
 sVQhtHfySA5IOJNRKx4AG2NvvV1TQnWxXrRVbBFA0WXn2EswGH/g2MajQJtciIwd9lxo
 Jju3w0PaP4CA50CFFEnbcz91XJ2PmWIMMOtyYtCgOQ1AIGIz2a5AFRkGm+c4V5cK1Mkt
 9MU+/mBV1T2IFTL8K2IuB/Avk3RuTqMtVGfUjkCCJmU+NG5BW70EdrJmj7UiUsNU8157
 QK/VBGHUmczNscycoiwC+nuOq3xscw2QdhrbXdp67tMIRuy5rZURq/SDlM5luLaQIEWC XQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrkbprjav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:31 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31EKAhK0017639;
        Tue, 14 Feb 2023 23:12:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6mmuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31ENCPK523527784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 23:12:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 785752004D;
        Tue, 14 Feb 2023 23:12:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E506620040;
        Tue, 14 Feb 2023 23:12:24 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.53.135])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 23:12:24 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 1/8] libbpf: Introduce bpf_{btf,link,map,prog}_get_info_by_fd()
Date:   Wed, 15 Feb 2023 00:12:14 +0100
Message-Id: <20230214231221.249277-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214231221.249277-1-iii@linux.ibm.com>
References: <20230214231221.249277-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K21ET8jyE9jtyxR1X-bT5_SqESQmTAKc
X-Proofpoint-ORIG-GUID: K21ET8jyE9jtyxR1X-bT5_SqESQmTAKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140198
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These are type-safe wrappers around bpf_obj_get_info_by_fd(). They
found one problem in selftests, and are also useful for adding
Memory Sanitizer annotations.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf.c      | 24 ++++++++++++++++++++++++
 tools/lib/bpf/bpf.h      | 13 +++++++++++++
 tools/lib/bpf/libbpf.map |  5 +++++
 3 files changed, 42 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9aff98f42a3d..b562019271fe 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1044,6 +1044,30 @@ int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
 	return libbpf_err_errno(err);
 }
 
+int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
+			    __u32 *info_len)
+{
+	return bpf_obj_get_info_by_fd(prog_fd, info, info_len);
+}
+
+int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info,
+			   __u32 *info_len)
+{
+	return bpf_obj_get_info_by_fd(map_fd, info, info_len);
+}
+
+int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info,
+			   __u32 *info_len)
+{
+	return bpf_obj_get_info_by_fd(btf_fd, info, info_len);
+}
+
+int bpf_link_get_info_by_fd(int link_fd, struct bpf_link_info *info,
+			    __u32 *info_len)
+{
+	return bpf_obj_get_info_by_fd(link_fd, info, info_len);
+}
+
 int bpf_raw_tracepoint_open(const char *name, int prog_fd)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, raw_tracepoint);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7468978d3c27..9f698088c9bc 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -386,6 +386,19 @@ LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_link_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
 LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
+/* Type-safe variants of bpf_obj_get_info_by_fd(). The callers still needs to
+ * pass info_len, which should normally be
+ * sizeof(struct bpf_{prog,map,btf,link}_info), in order to be compatible with
+ * different libbpf and kernel versions.
+ */
+LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
+				       __u32 *info_len);
+LIBBPF_API int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info,
+				      __u32 *info_len);
+LIBBPF_API int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info,
+				      __u32 *info_len);
+LIBBPF_API int bpf_link_get_info_by_fd(int link_fd, struct bpf_link_info *info,
+				       __u32 *info_len);
 
 struct bpf_prog_query_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 11c36a3c1a9f..50dde1f6521e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -384,4 +384,9 @@ LIBBPF_1.1.0 {
 } LIBBPF_1.0.0;
 
 LIBBPF_1.2.0 {
+	global:
+		bpf_btf_get_info_by_fd;
+		bpf_link_get_info_by_fd;
+		bpf_map_get_info_by_fd;
+		bpf_prog_get_info_by_fd;
 } LIBBPF_1.1.0;
-- 
2.39.1

