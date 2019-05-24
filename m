Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43392A1CC
	for <lists+bpf@lfdr.de>; Sat, 25 May 2019 01:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfEXXwO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 19:52:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37422 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbfEXXwN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 May 2019 19:52:13 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4ONjUgN017438
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 16:52:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=lKhanow2gCoKTpUe2uSEXYyid+Hsa+6G59YaV2LcGMw=;
 b=q/bezWZDs790XJnKg6uMsQsq77tTQY9NxoZP2n2SuTG7sbHc1b8TnttaZedQBRvYPzp1
 +vpePghRRq11eu5vfnIPJ7y/158MgcuLUjPTwTaIb8xs75hlHveROmZr9nfRwEUDA6qV
 ZfDGKrow9cI4lcxX74L4CRJVs+8PlbjvSRQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2spgw723ex-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 16:52:12 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 24 May 2019 16:52:11 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 4425B1267AEBA; Fri, 24 May 2019 16:51:57 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Yonghong Song <yhs@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 3/4] selftests/bpf: enable all available cgroup v2 controllers
Date:   Fri, 24 May 2019 16:51:55 -0700
Message-ID: <20190524235156.4076591-4-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524235156.4076591-1-guro@fb.com>
References: <20190524235156.4076591-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=866 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240162
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable all available cgroup v2 controllers when setting up
the environment for the bpf kselftests. It's required to properly test
the bpf prog auto-detach feature. Also it will generally increase
the code coverage.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 57 ++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 6692a40a6979..0d89f0396be4 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -33,6 +33,60 @@
 	snprintf(buf, sizeof(buf), "%s%s%s", CGROUP_MOUNT_PATH, \
 		 CGROUP_WORK_DIR, path)
 
+/**
+ * enable_all_controllers() - Enable all available cgroup v2 controllers
+ *
+ * Enable all available cgroup v2 controllers in order to increase
+ * the code coverage.
+ *
+ * If successful, 0 is returned.
+ */
+int enable_all_controllers(char *cgroup_path)
+{
+	char path[PATH_MAX + 1];
+	char buf[PATH_MAX];
+	char *c, *c2;
+	int fd, cfd;
+	size_t len;
+
+	snprintf(path, sizeof(path), "%s/cgroup.controllers", cgroup_path);
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		log_err("Opening cgroup.controllers: %s", path);
+		return 1;
+	}
+
+	len = read(fd, buf, sizeof(buf) - 1);
+	if (len < 0) {
+		close(fd);
+		log_err("Reading cgroup.controllers: %s", path);
+		return 1;
+	}
+	buf[len] = 0;
+	close(fd);
+
+	/* No controllers available? We're probably on cgroup v1. */
+	if (len == 0)
+		return 0;
+
+	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
+	cfd = open(path, O_RDWR);
+	if (cfd < 0) {
+		log_err("Opening cgroup.subtree_control: %s", path);
+		return 1;
+	}
+
+	for (c = strtok_r(buf, " ", &c2); c; c = strtok_r(NULL, " ", &c2)) {
+		if (dprintf(cfd, "+%s\n", c) <= 0) {
+			log_err("Enabling controller %s: %s", c, path);
+			close(cfd);
+			return 1;
+		}
+	}
+	close(cfd);
+	return 0;
+}
+
 /**
  * setup_cgroup_environment() - Setup the cgroup environment
  *
@@ -71,6 +125,9 @@ int setup_cgroup_environment(void)
 		return 1;
 	}
 
+	if (enable_all_controllers(cgroup_workdir))
+		return 1;
+
 	return 0;
 }
 
-- 
2.21.0

