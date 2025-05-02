Return-Path: <bpf+bounces-57268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25744AA798E
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6DA177733
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1251DE3AD;
	Fri,  2 May 2025 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JPYY1KKp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F6194080
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746211954; cv=none; b=lUi8SnnJEPcMsJV3VLb1Xaa3OjP9Yf/fbfckwCCMFvBsrU1ybxYesmqfkz2gCNh7g99mmhB6AN/skh3v71Yy89DY28TcPi2WbgLsQ2giKilbQpNQdiGO4nYOVgtueGMdRz7x+OOlxMqUPQya/KWRMsBz8buAeVCGCoyU7032ltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746211954; c=relaxed/simple;
	bh=WwFHPpYiJtPWSvVKRAQ6LCXVIkNWRRF6DXqHpHiRv3I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CzK8xUCaqhjBRwnfXZEXoPVVPLhTYGm28fZz6PCZVDo0GDeJOCbjK20BPUf45jhEY+BIvxLifS4V/ctRZu8zZkVOM9qRmq77MGIZ1jjiCh1l/09awwu5qM7avWBMxV3GZp4Wf6JDLzmTUJQadf2BOv+z7EnXg4bqN6QShufgENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JPYY1KKp; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 542F0htj011027
	for <bpf@vger.kernel.org>; Fri, 2 May 2025 11:52:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=/jbLj2IuHQv5eYqx6c
	C7dtGQdy7Uy1+CLaJsfU1UcxM=; b=JPYY1KKpI9L5b1YkAnT7U+9/jvIBIsu1hv
	9D8kRZxa4gUEPfOOrTE86mmus+iwnj+9ZatJv4WOWlzfx3N7/TBdJOOmcH1Lfflg
	5UsBotT1jeZRN67kRgYSv8DnaF5f6PIKrz7OQSp/38IGMtEVMJxLzHHo+aVs3rNd
	H6omfh9oxpIUMsMb/hY2eXLx70J5pFl0pfgoFFQNo4ZTx+EMiLVG4Qn+SJr4yzyr
	JAh8aWCI4UUdEt/yTVZ61+HbHXvTtBOXE1BZV+eaPdsoZ43H35aH33n8jaJydFmU
	Lxwz6wykE1HFKQ2D/OE84UMKtOTICigmPoTcM5j5Ug2cGAei/OAQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 46cjpyy6nd-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 02 May 2025 11:52:31 -0700 (PDT)
Received: from twshared35278.32.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 2 May 2025 18:52:25 +0000
Received: by devvm14721.vll0.facebook.com (Postfix, from userid 669379)
	id 61EF122C0376; Fri,  2 May 2025 11:52:23 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <kuba@kernel.org>,
        <jiayuan.chen@linux.dev>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v2] selftests/bpf: remove sockmap_ktls disconnect_after_delete test
Date: Fri, 2 May 2025 11:52:21 -0700
Message-ID: <20250502185221.1556192-1-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDE1MSBTYWx0ZWRfXz9j3rtTw4dnn neV/G3Hs3V1YSvZwLoVZGplP5OO8WWEYILIl0MdHk3C9TUCG+6gBPe7aMgpeOyiUfFv1ZPNdbkj UU8mnk9k5x0IaZQTcM7dT2oeOCRmiikz4k6wwHxGgm9TSBq1dgzZPpdJVRbnPiv2IztaiIk3pX3
 8bsvNTLiHoI1KXgKBXm5ynsRU4j2jTDe8qrZ3L28ifyGklC776XvIW8uJH+26gSai2xzaGct80f DqUjkrOrXx0OSxQJByqRQz3/+UpY0U5vVpnsHSIIoAfcBDqV7mnV/Za8hLHkEADjJedjiaifLw2 wm4PDR1+od2EJdKxcz0RYJIKgmQl//wbFQjVcu9fgx2Owf90iTqL0m4dHR88/4LF/DOKDrCCnyE
 /cSnqnjYV7nZ3b9+qg5EJmVfobI8A1xVcjuWEno5UKN6sQXqV9ixNvbjDJMcvafMWxHqLiWB
X-Proofpoint-GUID: OK8I8z2hU5KH6TPFPVlqH4wLRbW8Zm5J
X-Proofpoint-ORIG-GUID: OK8I8z2hU5KH6TPFPVlqH4wLRbW8Zm5J
X-Authority-Analysis: v=2.4 cv=NM/V+16g c=1 sm=1 tr=0 ts=6815146f cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=wzi3Pb8H_usUsDU_QI0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_04,2025-04-30_01,2025-02-21_01

"sockmap_ktls disconnect_after_delete" is effectively moot after
disconnect has been disabled for TLS [1][2]. Remove the test
completely.

[1] https://lore.kernel.org/bpf/20250416170246.2438524-1-ihor.solodrai@li=
nux.dev/
[2] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.o=
rg/

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 67 -------------------
 1 file changed, 67 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tool=
s/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 71b18fb1f719..3044f54b16d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -61,71 +61,6 @@ static int create_ktls_pairs(int family, int sotype, i=
nt *c, int *p)
 	return 0;
 }
=20
-static int tcp_server(int family)
-{
-	int err, s;
-
-	s =3D socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(s, 0, "socket"))
-		return -1;
-
-	err =3D listen(s, SOMAXCONN);
-	if (!ASSERT_OK(err, "listen"))
-		return -1;
-
-	return s;
-}
-
-static int disconnect(int fd)
-{
-	struct sockaddr unspec =3D { AF_UNSPEC };
-
-	return connect(fd, &unspec, sizeof(unspec));
-}
-
-/* Disconnect (unhash) a kTLS socket after removing it from sockmap. */
-static void test_sockmap_ktls_disconnect_after_delete(int family, int ma=
p)
-{
-	struct sockaddr_storage addr =3D {0};
-	socklen_t len =3D sizeof(addr);
-	int err, cli, srv, zero =3D 0;
-
-	srv =3D tcp_server(family);
-	if (srv =3D=3D -1)
-		return;
-
-	err =3D getsockname(srv, (struct sockaddr *)&addr, &len);
-	if (!ASSERT_OK(err, "getsockopt"))
-		goto close_srv;
-
-	cli =3D socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(cli, 0, "socket"))
-		goto close_srv;
-
-	err =3D connect(cli, (struct sockaddr *)&addr, len);
-	if (!ASSERT_OK(err, "connect"))
-		goto close_cli;
-
-	err =3D bpf_map_update_elem(map, &zero, &cli, 0);
-	if (!ASSERT_OK(err, "bpf_map_update_elem"))
-		goto close_cli;
-
-	err =3D setsockopt(cli, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
-	if (!ASSERT_OK(err, "setsockopt(TCP_ULP)"))
-		goto close_cli;
-
-	err =3D bpf_map_delete_elem(map, &zero);
-	if (!ASSERT_OK(err, "bpf_map_delete_elem"))
-		goto close_cli;
-
-	err =3D disconnect(cli);
-
-close_cli:
-	close(cli);
-close_srv:
-	close(srv);
-}
-
 static void test_sockmap_ktls_update_fails_when_sock_has_ulp(int family,=
 int map)
 {
 	struct sockaddr_storage addr =3D {};
@@ -313,8 +248,6 @@ static void run_tests(int family, enum bpf_map_type m=
ap_type)
 	if (!ASSERT_GE(map, 0, "bpf_map_create"))
 		return;
=20
-	if (test__start_subtest(fmt_test_name("disconnect_after_delete", family=
, map_type)))
-		test_sockmap_ktls_disconnect_after_delete(family, map);
 	if (test__start_subtest(fmt_test_name("update_fails_when_sock_has_ulp",=
 family, map_type)))
 		test_sockmap_ktls_update_fails_when_sock_has_ulp(family, map);
=20
--=20
2.47.1


