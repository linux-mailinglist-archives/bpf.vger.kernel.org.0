Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C615469152E
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 01:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBJANA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 19:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjBJAM7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 19:12:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3D65DC3F
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 16:12:58 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319NftYI029645;
        Fri, 10 Feb 2023 00:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zLf5pdxQOXdmqzTFhgclQM/YYwXeaMLO71r6cu5ljls=;
 b=IU7drUkeXGPZal7vA39RO6cd1NXHOHkUbusmcrKBlmT5ET/52lLPFwSKUdY6WmDhZaWO
 Qe4K6t7M2ZFuT2MoTuWWA/xdHUfGo+gKuc5tWY2wDq8BhF8L1il4TbKYRhupTgcOSxaY
 OeZApyIocknJYS5iWjcJ47fJ49JZZ8F17Q1SMwAQslpQjJOHPfbyOkyuq0q2uOwNt8kU
 SZW9uwoVUETmB3CS6kORFOQ9UeaerXz0LwnVT9aLJ3B7PvPnLrRsnFFsqsTJhxb9TpXJ
 3iqIkNs7OfDmhu6TgITZXo2ePvOK10txkeIfFQkOoYISpWC8SlWVyps+1dA/gUQzFB1w QQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnaqu0yau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319CkNqZ023807;
        Fri, 10 Feb 2023 00:12:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06xt68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A0CcQG47251938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:12:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 805DA20043;
        Fri, 10 Feb 2023 00:12:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF0E520040;
        Fri, 10 Feb 2023 00:12:37 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.74.186])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 00:12:37 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 08/16] libbpf: Introduce bpf_{btf,link,map,prog}_get_info_by_fd()
Date:   Fri, 10 Feb 2023 01:12:02 +0100
Message-Id: <20230210001210.395194-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210001210.395194-1-iii@linux.ibm.com>
References: <20230210001210.395194-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7zM4ZWEZ4dJSX_s1HKbGWmKKC7qrMx3P
X-Proofpoint-ORIG-GUID: 7zM4ZWEZ4dJSX_s1HKbGWmKKC7qrMx3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302090217
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

