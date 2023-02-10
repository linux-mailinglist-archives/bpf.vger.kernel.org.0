Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81846691534
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 01:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBJANL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 19:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjBJANJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 19:13:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573DE5DC3F
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 16:13:07 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A0BpkF001356;
        Fri, 10 Feb 2023 00:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zEzFX0aXMQUgMyNiK6Y1RQxy8zjjmTmc70qNuw2oo28=;
 b=tewNtpEJwGe/72uPKVkTQdqGK7s8DTbMylM/2QLtytxCfPaombmGEoYMssGzhafnzwgi
 OMleguaL9uoTuAnEiInLScqJsFCIhqPaZX5NxDBRgWOdkxq2r+UuwEgRuRvQE4c/Tn1+
 WK3Y8st77goedUqzEXRQQVb4+Ma6hoyZXm2++RsqxwITCoro4n8ohiPnzAzUcS/l9fjI
 SfvuEADf/qKLA2KBmdRFuOz8Rwbho9IE+7UOpDuJj5jNkvLmJNiR5+LbyY4c/PTZTBVk
 WR8IeaiZlU2QXAv0xJwtpqg4H4mHKuomda7XaJXqxvrN6zEkPLEWrOJRqwFE0eJbpB+8 wQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnb60g0h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:51 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319HLM0u024540;
        Fri, 10 Feb 2023 00:12:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3nhf06muew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A0CinM44564932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:12:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF16E20043;
        Fri, 10 Feb 2023 00:12:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 520FE20040;
        Fri, 10 Feb 2023 00:12:44 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.74.186])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 00:12:44 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 14/16] libbpf: Factor out is_percpu_bpf_map_type()
Date:   Fri, 10 Feb 2023 01:12:08 +0100
Message-Id: <20230210001210.395194-15-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210001210.395194-1-iii@linux.ibm.com>
References: <20230210001210.395194-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wSR6uamRUDT8mGJJ5FWbhbzPoM8UJCVu
X-Proofpoint-ORIG-GUID: wSR6uamRUDT8mGJJ5FWbhbzPoM8UJCVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_16,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=940 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090217
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This will be useful for unpoisoning map values for Memory Sanitizer.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/libbpf.c          | 11 ++---------
 tools/lib/bpf/libbpf_internal.h |  8 ++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 05c4db355f28..2d47a8e4f7e4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9432,11 +9432,7 @@ static int validate_map_op(const struct bpf_map *map, size_t key_sz,
 	if (!check_value_sz)
 		return 0;
 
-	switch (map->def.type) {
-	case BPF_MAP_TYPE_PERCPU_ARRAY:
-	case BPF_MAP_TYPE_PERCPU_HASH:
-	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
-	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE: {
+	if (is_percpu_bpf_map_type(map->def.type)) {
 		int num_cpu = libbpf_num_possible_cpus();
 		size_t elem_sz = roundup(map->def.value_size, 8);
 
@@ -9445,15 +9441,12 @@ static int validate_map_op(const struct bpf_map *map, size_t key_sz,
 				map->name, value_sz, num_cpu, elem_sz, num_cpu * elem_sz);
 			return -EINVAL;
 		}
-		break;
-	}
-	default:
+	} else {
 		if (map->def.value_size != value_sz) {
 			pr_warn("map '%s': unexpected value size %zu provided, expected %u\n",
 				map->name, value_sz, map->def.value_size);
 			return -EINVAL;
 		}
-		break;
 	}
 	return 0;
 }
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fbaf68335394..d6098b9c9e8e 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -577,4 +577,12 @@ static inline bool is_pow_of_2(size_t x)
 #define PROG_LOAD_ATTEMPTS 5
 int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts);
 
+static inline bool is_percpu_bpf_map_type(__u32 type)
+{
+	return type == BPF_MAP_TYPE_PERCPU_HASH ||
+	       type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	       type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+	       type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
+}
+
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.39.1

