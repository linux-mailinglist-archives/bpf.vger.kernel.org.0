Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBEC3F6760
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbhHXRdN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Aug 2021 13:33:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59670 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241504AbhHXRbK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Aug 2021 13:31:10 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17OHTrJK023706
        for <bpf@vger.kernel.org>; Tue, 24 Aug 2021 10:30:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=QkuSMorJK9amTtraW+MA3m8gUlTlB6ploxMETt8BRlE=;
 b=PodE7dcV9FuZIf6EsQYu+Ob5kpE2ilm4k0FH+jdc3OQySEjYUQrTlUmYaV8BkmFulF39
 M66lkOQnbfIlIIPkKjaJwm2W3WLoS126vf4xEIphStnb4KRWxZ0j7LHmddp2BGj3r0Im
 uzvxgR+4CCRzmDm3qQsZba11h8qkVisAz6E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3an506r408-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 24 Aug 2021 10:30:25 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 24 Aug 2021 10:30:23 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id CE49F2940D05; Tue, 24 Aug 2021 10:30:19 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Subject: [PATCH v2 bpf-next 3/4] bpf: selftests: Add connect_to_fd_opts to network_helpers
Date:   Tue, 24 Aug 2021 10:30:19 -0700
Message-ID: <20210824173019.3977910-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210824173000.3976470-1-kafai@fb.com>
References: <20210824173000.3976470-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: iPv9hnqck6TQNGh6jCNyUgwLON8pEOUi
X-Proofpoint-ORIG-GUID: iPv9hnqck6TQNGh6jCNyUgwLON8pEOUi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_05:2021-08-24,2021-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=782 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108240115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The next test requires to setsockopt(TCP_CONGESTION) before
connect(), so a new arg is needed for the connect_to_fd() to specify
the cc's name.

This patch adds a new "struct network_helper_opts" for the future
option needs.  It starts with the "cc" and "timeout_ms" option.
A new helper connect_to_fd_opts() is added to take the new
"const struct network_helper_opts *opts" as an arg.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 23 +++++++++++++++++--
 tools/testing/selftests/bpf/network_helpers.h |  6 +++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
index d6857683397f..7e9f6375757a 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -218,13 +218,18 @@ static int connect_fd_to_addr(int fd,
 	return 0;
 }
=20
-int connect_to_fd(int server_fd, int timeout_ms)
+static const struct network_helper_opts default_opts;
+
+int connect_to_fd_opts(int server_fd, const struct network_helper_opts *=
opts)
 {
 	struct sockaddr_storage addr;
 	struct sockaddr_in *addr_in;
 	socklen_t addrlen, optlen;
 	int fd, type;
=20
+	if (!opts)
+		opts =3D &default_opts;
+
 	optlen =3D sizeof(type);
 	if (getsockopt(server_fd, SOL_SOCKET, SO_TYPE, &type, &optlen)) {
 		log_err("getsockopt(SOL_TYPE)");
@@ -244,7 +249,12 @@ int connect_to_fd(int server_fd, int timeout_ms)
 		return -1;
 	}
=20
-	if (settimeo(fd, timeout_ms))
+	if (settimeo(fd, opts->timeout_ms))
+		goto error_close;
+
+	if (opts->cc && opts->cc[0] &&
+	    setsockopt(fd, SOL_TCP, TCP_CONGESTION, opts->cc,
+		       strlen(opts->cc) + 1))
 		goto error_close;
=20
 	if (connect_fd_to_addr(fd, &addr, addrlen))
@@ -257,6 +267,15 @@ int connect_to_fd(int server_fd, int timeout_ms)
 	return -1;
 }
=20
+int connect_to_fd(int server_fd, int timeout_ms)
+{
+	struct network_helper_opts opts =3D {
+		.timeout_ms =3D timeout_ms,
+	};
+
+	return connect_to_fd_opts(server_fd, &opts);
+}
+
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
 {
 	struct sockaddr_storage addr;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testin=
g/selftests/bpf/network_helpers.h
index c59a8f6d770b..da7e132657d5 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -17,6 +17,11 @@ typedef __u16 __sum16;
 #define VIP_NUM 5
 #define MAGIC_BYTES 123
=20
+struct network_helper_opts {
+	const char *cc;
+	int timeout_ms;
+};
+
 /* ipv4 test vector */
 struct ipv4_packet {
 	struct ethhdr eth;
@@ -41,6 +46,7 @@ int *start_reuseport_server(int family, int type, const=
 char *addr_str,
 			    unsigned int nr_listens);
 void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_fd(int server_fd, int timeout_ms);
+int connect_to_fd_opts(int server_fd, const struct network_helper_opts *=
opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_=
len,
 		     int timeout_ms);
--=20
2.30.2

