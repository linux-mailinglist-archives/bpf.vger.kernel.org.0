Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B623B0C4
	for <lists+bpf@lfdr.de>; Tue,  4 Aug 2020 01:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgHCXLW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Aug 2020 19:11:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50946 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729185AbgHCXLW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Aug 2020 19:11:22 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073MtAS8011116
        for <bpf@vger.kernel.org>; Mon, 3 Aug 2020 16:11:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6tAT+doT1U/Hj+Jq4B5YaWu3S+rEo2R4DqnySvTWGdA=;
 b=Ck9vIQFZd+S4OXXUvONmPR2P1O6CBWINS3KRrO29sA0k/Dplj4rvLsHo4z0QXGQTdqs9
 RlEhpM2gMdIUE9REQ+0U4N4pY6cejzoSusXLAzVf5AnwoLDrkdz9L/L5ZDzcVXQQxc5Z
 ADWOsx+TDQ0Y1Xstb72SMCULXh6m64YFkHQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32n81jhgyv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2020 16:11:21 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 3 Aug 2020 16:11:19 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 2580D2943872; Mon,  3 Aug 2020 16:11:17 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>, <kernel-team@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>, <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC PATCH v4 bpf-next 10/12] bpf: selftests: Add fastopen_connect to network_helpers
Date:   Mon, 3 Aug 2020 16:11:17 -0700
Message-ID: <20200803231117.2685614-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200803231013.2681560-1-kafai@fb.com>
References: <20200803231013.2681560-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=13 lowpriorityscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008030158
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a fastopen_connect() helper which will
be used in a later test.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 37 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
index f56655690f9b..12ee40284da0 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -104,6 +104,43 @@ int start_server(int family, int type, const char *a=
ddr_str, __u16 port,
 	return -1;
 }
=20
+int fastopen_connect(int server_fd, const char *data, unsigned int data_=
len,
+		     int timeout_ms)
+{
+	struct sockaddr_storage addr;
+	socklen_t addrlen =3D sizeof(addr);
+	struct sockaddr_in *addr_in;
+	int fd, ret;
+
+	if (getsockname(server_fd, (struct sockaddr *)&addr, &addrlen)) {
+		log_err("Failed to get server addr");
+		return -1;
+	}
+
+	addr_in =3D (struct sockaddr_in *)&addr;
+	fd =3D socket(addr_in->sin_family, SOCK_STREAM, 0);
+	if (fd < 0) {
+		log_err("Failed to create client socket");
+		return -1;
+	}
+
+	if (settimeo(fd, timeout_ms))
+		goto error_close;
+
+	ret =3D sendto(fd, data, data_len, MSG_FASTOPEN, (struct sockaddr *)&ad=
dr,
+		     addrlen);
+	if (ret !=3D data_len) {
+		log_err("sendto(data, %u) !=3D %d\n", data_len, ret);
+		goto error_close;
+	}
+
+	return fd;
+
+error_close:
+	save_errno_close(fd);
+	return -1;
+}
+
 static int connect_fd_to_addr(int fd,
 			      const struct sockaddr_storage *addr,
 			      socklen_t addrlen)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testin=
g/selftests/bpf/network_helpers.h
index c3728f6667e4..7205f8afdba1 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -37,6 +37,8 @@ int start_server(int family, int type, const char *addr=
, __u16 port,
 		 int timeout_ms);
 int connect_to_fd(int server_fd, int timeout_ms);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
+int fastopen_connect(int server_fd, const char *data, unsigned int data_=
len,
+		     int timeout_ms);
 int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
=20
--=20
2.24.1

