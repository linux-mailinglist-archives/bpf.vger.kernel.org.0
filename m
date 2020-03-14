Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716FA1853E2
	for <lists+bpf@lfdr.de>; Sat, 14 Mar 2020 02:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCNBjs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Mar 2020 21:39:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbgCNBjr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Mar 2020 21:39:47 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02E1Sbqq017593
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 18:39:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=QvQkLxQ4MndSmHrJxqXlq80kL9Ktpe+IvK4lx2u7ynM=;
 b=OaLGHkpsywRvABwxLKq6avKv8XbjgWRX9BTDObp6/vJaGdVCF7ZENdrra72/d0IsIQ59
 JOlOpev7Vz5K/U18lPNEyc6HS7yvdZJhmFmnzf0jFg6DfVbYZx/M1deMBUDAWU14+qN6
 DIQNeH7qnR8He/weEIC485AdX8o7zER6Pvg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yqt8jyc3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 18:39:46 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 13 Mar 2020 18:39:44 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 0949E2EC2D6B; Fri, 13 Mar 2020 18:39:35 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/3] selftests/bpf: fix race in tcp_rtt test
Date:   Fri, 13 Mar 2020 18:39:30 -0700
Message-ID: <20200314013932.4035712-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_12:2020-03-12,2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=8 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=642
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003140006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previous attempt to make tcp_rtt more robust introduced a new race, in which
server_done might be set to true before server can actually accept any
connection. Fix this by unconditionally waiting for accept(). Given socket is
non-blocking, if there are any problems with client side, it should eventually
close listening FD and let server thread exit with failure.

Fixes: 4cd729fa022c ("selftests/bpf: Make tcp_rtt test more robust to failures")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index e08f6bb17700..e56b52ab41da 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -226,7 +226,7 @@ static void *server_thread(void *arg)
 		return ERR_PTR(err);
 	}
 
-	while (!server_done) {
+	while (true) {
 		client_fd = accept(fd, (struct sockaddr *)&addr, &len);
 		if (client_fd == -1 && errno == EAGAIN) {
 			usleep(50);
@@ -272,7 +272,7 @@ void test_tcp_rtt(void)
 	CHECK_FAIL(run_test(cgroup_fd, server_fd));
 
 	server_done = true;
-	pthread_join(tid, &server_res);
+	CHECK_FAIL(pthread_join(tid, &server_res));
 	CHECK_FAIL(IS_ERR(server_res));
 
 close_server_fd:
-- 
2.17.1

