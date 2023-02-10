Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA1669152F
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 01:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBJANC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 19:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBJANB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 19:13:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524A5DC3F
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 16:13:00 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A0CS3Y008282;
        Fri, 10 Feb 2023 00:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9OQyfb7woPZ7jr98J9khbsaZXv5wkfJxbuqUaAF/Noo=;
 b=aZ4OA8T9vC3YO9J4NmZL6GgGom1WbkqOGrCxR8bcx5IJ5mVvhwqBBbI+8AmtZjbwOAqE
 jhacDh8/lyvmXyij6JMNwXK9aHd4iRnMS8vQrB+Hqln9v+7Z8aNKBxTJGAMmk53EhXeD
 gR5+44DQnkxcF89150JXQA8Umr0OYJZxojGXXtW/RULC3igq+00dfo9Sn+k+omQYPrgu
 P+f71bV+7kyqAH5zlj2N3RPf9A3E/OGqu5RYu7IP5ZjfF8b8baBGxvuEtn+ozw/XGuMu
 9Y8D8JEi7Qk+wz8g30FNwYkrzUX/7RgfoDZd/birlcABtkbc2bVmJbhNnE/rSkJCkiTr jA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnb61804v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:47 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3193QDiQ005626;
        Fri, 10 Feb 2023 00:12:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3nhf06vugk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A0CfpO43450812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:12:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B463D20040;
        Fri, 10 Feb 2023 00:12:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B14520043;
        Fri, 10 Feb 2023 00:12:41 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.74.186])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 00:12:41 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 11/16] perf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
Date:   Fri, 10 Feb 2023 01:12:05 +0100
Message-Id: <20230210001210.395194-12-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210001210.395194-1-iii@linux.ibm.com>
References: <20230210001210.395194-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aStpojPLgTC8_OPN8ikpN9sqc9YN9F3J
X-Proofpoint-ORIG-GUID: aStpojPLgTC8_OPN8ikpN9sqc9YN9F3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_16,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090217
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the new type-safe wrappers around bpf_obj_get_info_by_fd().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/perf/util/bpf-utils.c   | 4 ++--
 tools/perf/util/bpf_counter.c | 2 +-
 tools/perf/util/bpf_counter.h | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/bpf-utils.c b/tools/perf/util/bpf-utils.c
index 80b1d2b3729b..a4154199f56c 100644
--- a/tools/perf/util/bpf-utils.c
+++ b/tools/perf/util/bpf-utils.c
@@ -121,7 +121,7 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 		return ERR_PTR(-EINVAL);
 
 	/* step 1: get array dimensions */
-	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(fd, &info, &info_len);
 	if (err) {
 		pr_debug("can't get prog info: %s", strerror(errno));
 		return ERR_PTR(-EFAULT);
@@ -183,7 +183,7 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 	}
 
 	/* step 5: call syscall again to get required arrays */
-	err = bpf_obj_get_info_by_fd(fd, &info_linear->info, &info_len);
+	err = bpf_prog_get_info_by_fd(fd, &info_linear->info, &info_len);
 	if (err) {
 		pr_debug("can't get prog info: %s", strerror(errno));
 		free(info_linear);
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index eeee899fcf34..5826a1073cf6 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -304,7 +304,7 @@ static bool bperf_attr_map_compatible(int attr_map_fd)
 	__u32 map_info_len = sizeof(map_info);
 	int err;
 
-	err = bpf_obj_get_info_by_fd(attr_map_fd, &map_info, &map_info_len);
+	err = bpf_map_get_info_by_fd(attr_map_fd, &map_info, &map_info_len);
 
 	if (err)
 		return false;
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
index c6d21c07b14c..c071e9444395 100644
--- a/tools/perf/util/bpf_counter.h
+++ b/tools/perf/util/bpf_counter.h
@@ -97,7 +97,7 @@ static inline __u32 bpf_link_get_id(int fd)
 	struct bpf_link_info link_info = { .id = 0, };
 	__u32 link_info_len = sizeof(link_info);
 
-	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	bpf_link_get_info_by_fd(fd, &link_info, &link_info_len);
 	return link_info.id;
 }
 
@@ -106,7 +106,7 @@ static inline __u32 bpf_link_get_prog_id(int fd)
 	struct bpf_link_info link_info = { .id = 0, };
 	__u32 link_info_len = sizeof(link_info);
 
-	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	bpf_link_get_info_by_fd(fd, &link_info, &link_info_len);
 	return link_info.prog_id;
 }
 
@@ -115,7 +115,7 @@ static inline __u32 bpf_map_get_id(int fd)
 	struct bpf_map_info map_info = { .id = 0, };
 	__u32 map_info_len = sizeof(map_info);
 
-	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
+	bpf_map_get_info_by_fd(fd, &map_info, &map_info_len);
 	return map_info.id;
 }
 
-- 
2.39.1

