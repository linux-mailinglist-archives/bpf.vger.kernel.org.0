Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67E4697196
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjBNXMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjBNXMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:12:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74892101
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:12:49 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ENCUch028634;
        Tue, 14 Feb 2023 23:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SYi+mooL0fsDmQlBoEmoSrOgPVc2PSOJR0jd4wVvubw=;
 b=ob8laOnlPPwvIq6Ct1o6GM/3CIi40Vg7m27Wre+qYqCB63vweYh/OWy3SZwnIILtfWzP
 DMf6uQSbW1HOhxyeJcjxZJFf7Lo6ecjXSNVaStMHZ4X7NNh9LoEfl9vj3xq7mE78SctM
 dVMhLSv2hqKIm6OkCm4KuCMwY/svblC8q2Zng/c78g90E348BEQEqBz27CrK2de1zxiu
 KUHVjBUm/00KEUHOdxW+ByREZbzFT9E4gFevFxgIohAyp5zSbO0mO18Qt1GTJuAAegSM
 2wk5AReaATGK7NGUgM37osSJN2/i3o2zsOKZcZICilMP0ooTts5OMQjPN59eADPZQTtz DQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrkrur05t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31EJCbdq011341;
        Tue, 14 Feb 2023 23:12:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6vnj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31ENCSsx46727644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 23:12:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B712D20043;
        Tue, 14 Feb 2023 23:12:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 304E720040;
        Tue, 14 Feb 2023 23:12:28 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.53.135])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 23:12:28 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 4/8] samples/bpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
Date:   Wed, 15 Feb 2023 00:12:17 +0100
Message-Id: <20230214231221.249277-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214231221.249277-1-iii@linux.ibm.com>
References: <20230214231221.249277-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pxqpigOOk_wn3v1pJj2Jpu9IPT74eg4p
X-Proofpoint-GUID: pxqpigOOk_wn3v1pJj2Jpu9IPT74eg4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140198
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

