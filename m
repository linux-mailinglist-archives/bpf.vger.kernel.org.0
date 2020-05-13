Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471BE1D213C
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 23:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgEMVjY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 17:39:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53048 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729258AbgEMVjX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 17:39:23 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DLdIMM030462
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 14:39:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HynFpvEUD2Y6XuOyNovUrDusN7xztU6v07/sTQlrTCU=;
 b=Hfy1knTOJmcZ9Q55xdz04UnUSxAfpD6bZYKxGaW6M02MGF1v0Alr0HHJOYvD57Psx6vM
 hbyRpkwk9zypRMAim0VtjjUeA3wyAr8HyILdeMHBp9lwTx2HHag3HdSncAE1hx50OKOk
 LdxKBJKNOkVeiT+97RBoDHC0RFoLI+pvSCs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x5ykp7-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 14:39:22 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 14:39:16 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id D3F31370094C; Wed, 13 May 2020 14:39:06 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 4/5] selftests/bpf: Add connect_fd_to_fd, connect_wait net helpers
Date:   Wed, 13 May 2020 14:38:39 -0700
Message-ID: <bf2359639287db9adef2c4ddc1a5e16e466a594a.1589405669.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1589405669.git.rdna@fb.com>
References: <cover.1589405669.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 cotscore=-2147483648
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=15 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130185
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two new network helpers.

connect_fd_to_fd connects an already created client socket fd to address
of server fd. Sometimes it's useful to separate client socket creation
and connecting this socket to a server, e.g. if client socket has to be
created in a cgroup different from that of server cgroup.

Additionally connect_to_fd is now implemented using connect_fd_to_fd,
both helpers don't treat EINPROGRESS as an error and let caller decide
how to proceed with it.

connect_wait is a helper to work with non-blocking client sockets so
that if connect_to_fd or connect_fd_to_fd returned -1 with errno =3D=3D
EINPROGRESS, caller can wait for connect to finish or for connection
timeout. The helper returns -1 on error, 0 on timeout (1sec,
hard-coded), and positive number on success.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 66 +++++++++++++++----
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 2 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
index 0ff64b70b746..542d71ed7f5d 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -4,10 +4,14 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+
+#include <sys/epoll.h>
+
 #include <linux/err.h>
 #include <linux/in.h>
 #include <linux/in6.h>
=20
+#include "bpf_util.h"
 #include "network_helpers.h"
=20
 #define clean_errno() (errno =3D=3D 0 ? "None" : strerror(errno))
@@ -77,8 +81,6 @@ static const size_t timeo_optlen =3D sizeof(timeo_sec);
=20
 int connect_to_fd(int family, int type, int server_fd)
 {
-	struct sockaddr_storage addr;
-	socklen_t len =3D sizeof(addr);
 	int fd;
=20
 	fd =3D socket(family, type, 0);
@@ -87,24 +89,64 @@ int connect_to_fd(int family, int type, int server_fd=
)
 		return -1;
 	}
=20
-	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo_sec, timeo_optlen)) =
{
+	if (connect_fd_to_fd(fd, server_fd) < 0 && errno !=3D EINPROGRESS) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+int connect_fd_to_fd(int client_fd, int server_fd)
+{
+	struct sockaddr_storage addr;
+	socklen_t len =3D sizeof(addr);
+
+	if (setsockopt(client_fd, SOL_SOCKET, SO_RCVTIMEO, &timeo_sec,
+		       timeo_optlen)) {
 		log_err("Failed to set SO_RCVTIMEO");
-		goto out;
+		return -1;
 	}
=20
 	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
 		log_err("Failed to get server addr");
-		goto out;
+		return -1;
 	}
=20
-	if (connect(fd, (const struct sockaddr *)&addr, len) < 0) {
-		log_err("Fail to connect to server with family %d", family);
-		goto out;
+	if (connect(client_fd, (const struct sockaddr *)&addr, len) < 0) {
+		if (errno !=3D EINPROGRESS)
+			log_err("Failed to connect to server");
+		return -1;
 	}
=20
-	return fd;
+	return 0;
+}
+
+int connect_wait(int fd)
+{
+	struct epoll_event ev =3D {}, events[2];
+	int timeout_ms =3D 1000;
+	int efd, nfd;
+
+	efd =3D epoll_create1(EPOLL_CLOEXEC);
+	if (efd < 0) {
+		log_err("Failed to open epoll fd");
+		return -1;
+	}
+
+	ev.events =3D EPOLLRDHUP | EPOLLOUT;
+	ev.data.fd =3D fd;
+
+	if (epoll_ctl(efd, EPOLL_CTL_ADD, fd, &ev) < 0) {
+		log_err("Failed to register fd=3D%d on epoll fd=3D%d", fd, efd);
+		close(efd);
+		return -1;
+	}
+
+	nfd =3D epoll_wait(efd, events, ARRAY_SIZE(events), timeout_ms);
+	if (nfd < 0)
+		log_err("Failed to wait for I/O event on epoll fd=3D%d", efd);
=20
-out:
-	close(fd);
-	return -1;
+	close(efd);
+	return nfd;
 }
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testin=
g/selftests/bpf/network_helpers.h
index a0be7db4f67d..86914e6e7b53 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -35,5 +35,7 @@ extern struct ipv6_packet pkt_v6;
=20
 int start_server(int family, int type);
 int connect_to_fd(int family, int type, int server_fd);
+int connect_fd_to_fd(int client_fd, int server_fd);
+int connect_wait(int client_fd);
=20
 #endif
--=20
2.24.1

