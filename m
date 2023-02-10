Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E42A691531
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 01:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBJANG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 19:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBJANG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 19:13:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F045EA0A
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 16:13:04 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319NmkNl016562;
        Fri, 10 Feb 2023 00:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SYi+mooL0fsDmQlBoEmoSrOgPVc2PSOJR0jd4wVvubw=;
 b=PD5FKrNdJmbXBqiMblbub+PXeuq47NUioT/8kmlHPl119tq27m/5026EGZRDEZjPUnuO
 4kLvBuk3MvqL1g6kfcC/0G3cO7H9m2jzy/2YiUmVxp0iEV+YXaV0VBm2gEl0b9GI6sIr
 ZMWsm6tkQ2yD1QI0hpULzUfehyiEQ53Z4lCJIQLkfprEW+YGqeCLbX75bon2Jq4qxBKu
 mTjADlim255d8gbhe2/96wGdzCVOiYSTqlHOaljoUXI88/VYI2O6Ciy5nVleEpJzmZWY
 SMGnfawIaKS3lbl3kcx2z460bDcXPArEb6YG9SMiIhiKwZX/TBVLgJkbW3RgdfX2+PmK 4w== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnau4gvjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:49 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319HLM0t024540;
        Fri, 10 Feb 2023 00:12:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3nhf06mueu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A0CgO917105628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:12:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC65020043;
        Fri, 10 Feb 2023 00:12:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33C9F20040;
        Fri, 10 Feb 2023 00:12:42 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.74.186])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 00:12:42 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 12/16] samples/bpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
Date:   Fri, 10 Feb 2023 01:12:06 +0100
Message-Id: <20230210001210.395194-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210001210.395194-1-iii@linux.ibm.com>
References: <20230210001210.395194-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jSzmrDnHdi7iieKQWdwyZJF-rk2NwZVo
X-Proofpoint-GUID: jSzmrDnHdi7iieKQWdwyZJF-rk2NwZVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_16,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=942 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 samples/bpf/test_map_in_map_user.c  | 2 +-
 samples/bpf/xdp1_user.c             | 2 +-
 samples/bpf/xdp_adjust_tail_user.c  | 2 +-
 samples/bpf/xdp_fwd_user.c          | 4 ++--
 samples/bpf/xdp_redirect_cpu_user.c | 4 ++--
 samples/bpf/xdp_rxq_info_user.c     | 2 +-
 samples/bpf/xdp_sample_pkts_user.c  | 2 +-
 samples/bpf/xdp_tx_iptunnel_user.c  | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/samples/bpf/test_map_in_map_user.c b/samples/bpf/test_map_in_map_user.c
index 9e79df4071f5..55dca43f3723 100644
--- a/samples/bpf/test_map_in_map_user.c
+++ b/samples/bpf/test_map_in_map_user.c
@@ -38,7 +38,7 @@ static void check_map_id(int inner_map_fd, int map_in_map_fd, uint32_t key)
 	uint32_t info_len = sizeof(info);
 	int ret, id;
 
-	ret = bpf_obj_get_info_by_fd(inner_map_fd, &info, &info_len);
+	ret = bpf_map_get_info_by_fd(inner_map_fd, &info, &info_len);
 	assert(!ret);
 
 	ret = bpf_map_lookup_elem(map_in_map_fd, &key, &id);
diff --git a/samples/bpf/xdp1_user.c b/samples/bpf/xdp1_user.c
index 281dc964de8d..f05e797013e9 100644
--- a/samples/bpf/xdp1_user.c
+++ b/samples/bpf/xdp1_user.c
@@ -153,7 +153,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (err) {
 		printf("can't get prog info - %s\n", strerror(errno));
 		return err;
diff --git a/samples/bpf/xdp_adjust_tail_user.c b/samples/bpf/xdp_adjust_tail_user.c
index 167646077c8f..e9426bd65420 100644
--- a/samples/bpf/xdp_adjust_tail_user.c
+++ b/samples/bpf/xdp_adjust_tail_user.c
@@ -184,7 +184,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (err) {
 		printf("can't get prog info - %s\n", strerror(errno));
 		return 1;
diff --git a/samples/bpf/xdp_fwd_user.c b/samples/bpf/xdp_fwd_user.c
index 84f57f1209ce..193b3b79b31f 100644
--- a/samples/bpf/xdp_fwd_user.c
+++ b/samples/bpf/xdp_fwd_user.c
@@ -76,9 +76,9 @@ static int do_detach(int ifindex, const char *ifname, const char *app_name)
 		return prog_fd;
 	}
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &info_len);
 	if (err) {
-		printf("ERROR: bpf_obj_get_info_by_fd failed (%s)\n",
+		printf("ERROR: bpf_prog_get_info_by_fd failed (%s)\n",
 		       strerror(errno));
 		goto close_out;
 	}
diff --git a/samples/bpf/xdp_redirect_cpu_user.c b/samples/bpf/xdp_redirect_cpu_user.c
index a12381c37d2b..e1458405e2ba 100644
--- a/samples/bpf/xdp_redirect_cpu_user.c
+++ b/samples/bpf/xdp_redirect_cpu_user.c
@@ -494,9 +494,9 @@ int main(int argc, char **argv)
 		goto end_cpu;
 	}
 
-	ret = bpf_obj_get_info_by_fd(bpf_map__fd(skel->maps.cpu_map), &info, &infosz);
+	ret = bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.cpu_map), &info, &infosz);
 	if (ret < 0) {
-		fprintf(stderr, "Failed bpf_obj_get_info_by_fd for cpumap: %s\n",
+		fprintf(stderr, "Failed bpf_map_get_info_by_fd for cpumap: %s\n",
 			strerror(errno));
 		goto end_cpu;
 	}
diff --git a/samples/bpf/xdp_rxq_info_user.c b/samples/bpf/xdp_rxq_info_user.c
index 08f5331d2b00..b95e0ef61f06 100644
--- a/samples/bpf/xdp_rxq_info_user.c
+++ b/samples/bpf/xdp_rxq_info_user.c
@@ -602,7 +602,7 @@ int main(int argc, char **argv)
 		return EXIT_FAIL_XDP;
 	}
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (err) {
 		printf("can't get prog info - %s\n", strerror(errno));
 		return err;
diff --git a/samples/bpf/xdp_sample_pkts_user.c b/samples/bpf/xdp_sample_pkts_user.c
index 7df7163239ac..e39d7f654f30 100644
--- a/samples/bpf/xdp_sample_pkts_user.c
+++ b/samples/bpf/xdp_sample_pkts_user.c
@@ -35,7 +35,7 @@ static int do_attach(int idx, int fd, const char *name)
 		return err;
 	}
 
-	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(fd, &info, &info_len);
 	if (err) {
 		printf("can't get prog info - %s\n", strerror(errno));
 		return err;
diff --git a/samples/bpf/xdp_tx_iptunnel_user.c b/samples/bpf/xdp_tx_iptunnel_user.c
index 307baef6861a..7e4b2f7108a6 100644
--- a/samples/bpf/xdp_tx_iptunnel_user.c
+++ b/samples/bpf/xdp_tx_iptunnel_user.c
@@ -295,7 +295,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (err) {
 		printf("can't get prog info - %s\n", strerror(errno));
 		return err;
-- 
2.39.1

