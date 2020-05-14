Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD01D3E6C
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 22:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgENUEZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 16:04:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26538 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgENUEY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 16:04:24 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EK1gL3000652
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:04:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=c8ROn7Pn00moWCvhWbIhtni1xOcaQiWUc3iAonwBEWU=;
 b=Vc3N9ntrGYVeLpYxEX/sVDYmZn0acZ65mQYHtOFDNKB5bHIb+BrYz2ArLBWN0a5ewlgW
 rDeHCwmwd2Sv4xGSZyPTnmCfqwWtDZXfMWyiRctFtbuUl0Sgz7Og3BNYDhucQmPv3SLE
 xEtWXDP7DTSySLijwzKpUvHWiv6Wt6GCujc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100xbdgaq-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:04:24 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 13:04:19 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 9EC1337009C6; Thu, 14 May 2020 13:04:17 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 4/5] selftests/bpf: Add connect_fd_to_fd, connect_wait net helpers
Date:   Thu, 14 May 2020 13:03:48 -0700
Message-ID: <1403fab72300f379ca97ead4820ae43eac4414ef.1589486450.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1589486450.git.rdna@fb.com>
References: <cover.1589486450.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_07:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=15 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140177
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
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 74 +++++++++++++++----
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 2 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
index 0ff64b70b746..999a775484c1 100644
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
@@ -77,9 +81,7 @@ static const size_t timeo_optlen =3D sizeof(timeo_sec);
=20
 int connect_to_fd(int family, int type, int server_fd)
 {
-	struct sockaddr_storage addr;
-	socklen_t len =3D sizeof(addr);
-	int fd;
+	int fd, save_errno;
=20
 	fd =3D socket(family, type, 0);
 	if (fd < 0) {
@@ -87,24 +89,70 @@ int connect_to_fd(int family, int type, int server_fd=
)
 		return -1;
 	}
=20
-	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo_sec, timeo_optlen)) =
{
+	if (connect_fd_to_fd(fd, server_fd) < 0 && errno !=3D EINPROGRESS) {
+		save_errno =3D errno;
+		close(fd);
+		errno =3D save_errno;
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
+	int save_errno;
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
+		if (errno !=3D EINPROGRESS) {
+			save_errno =3D errno;
+			log_err("Failed to connect to server");
+			errno =3D save_errno;
+		}
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

