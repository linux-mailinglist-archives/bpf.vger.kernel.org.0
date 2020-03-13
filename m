Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C51841DF
	for <lists+bpf@lfdr.de>; Fri, 13 Mar 2020 08:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCMH4M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Mar 2020 03:56:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41272 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgCMH4L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Mar 2020 03:56:11 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02D7rg2F021461
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 00:56:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=JMHnkq0o3wRDAm6a/domM9KBfqI16YAUmg9gBu8Twgw=;
 b=eI04pMoVh6b/2G8RUGVdcOUWfcZ/PKA6TgDNfuqsfphOOgdYQdPY1ybJ5MYBEwlSEM67
 KNgPlYz3dZ+trfa2mDpSzGuxbLvxSzPyq/XkmV0IeC4pDAsopqfgC/IU49E1Qdku8JLq
 Ccyzk6WB2M/TqbqsE87bwz+AbfSBNIrHgYA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yqt96tv05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 00:56:10 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 13 Mar 2020 00:56:08 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id D29672EC2DC7; Fri, 13 Mar 2020 00:56:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/4] selftests/bpf: ensure consistent test failure output
Date:   Fri, 13 Mar 2020 00:54:38 -0700
Message-ID: <20200313075442.4071486-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313075442.4071486-1-andriin@fb.com>
References: <20200313075442.4071486-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_03:2020-03-11,2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=25 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130044
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

printf() doesn't seem to honor using overwritten stdout/stderr (as part of
stdio hijacking), so ensure all "standard" invocations of printf() do
fprintf(stdout, ...) instead.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 10 +++++-----
 tools/testing/selftests/bpf/test_progs.h |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index b6201dd82edf..f85a06512541 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -216,7 +216,7 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name)
 
 	map = bpf_object__find_map_by_name(obj, name);
 	if (!map) {
-		printf("%s:FAIL:map '%s' not found\n", test, name);
+		fprintf(stdout, "%s:FAIL:map '%s' not found\n", test, name);
 		test__fail();
 		return -1;
 	}
@@ -387,7 +387,7 @@ static int libbpf_print_fn(enum libbpf_print_level level,
 {
 	if (env.verbosity < VERBOSE_VERY && level == LIBBPF_DEBUG)
 		return 0;
-	vprintf(format, args);
+	vfprintf(stdout, format, args);
 	return 0;
 }
 
@@ -633,7 +633,7 @@ int cd_flavor_subdir(const char *exec_name)
 	if (!flavor)
 		return 0;
 	flavor++;
-	printf("Switching to flavor '%s' subdirectory...\n", flavor);
+	fprintf(stdout, "Switching to flavor '%s' subdirectory...\n", flavor);
 	return chdir(flavor);
 }
 
@@ -716,8 +716,8 @@ int main(int argc, char **argv)
 			cleanup_cgroup_environment();
 	}
 	stdio_restore();
-	printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
-	       env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
+	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
+		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
 
 	free(env.test_selector.blacklist.strs);
 	free(env.test_selector.whitelist.strs);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index bcfa9ef23fda..fd85fa61dbf7 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -109,10 +109,10 @@ extern struct ipv6_packet pkt_v6;
 	int __save_errno = errno;					\
 	if (__ret) {							\
 		test__fail();						\
-		printf("%s:FAIL:%s ", __func__, tag);			\
-		printf(format);						\
+		fprintf(stdout, "%s:FAIL:%s ", __func__, tag);		\
+		fprintf(stdout, ##format);				\
 	} else {							\
-		printf("%s:PASS:%s %d nsec\n",				\
+		fprintf(stdout, "%s:PASS:%s %d nsec\n",			\
 		       __func__, tag, duration);			\
 	}								\
 	errno = __save_errno;						\
@@ -124,7 +124,7 @@ extern struct ipv6_packet pkt_v6;
 	int __save_errno = errno;					\
 	if (__ret) {							\
 		test__fail();						\
-		printf("%s:FAIL:%d\n", __func__, __LINE__);		\
+		fprintf(stdout, "%s:FAIL:%d\n", __func__, __LINE__);	\
 	}								\
 	errno = __save_errno;						\
 	__ret;								\
-- 
2.17.1

