Return-Path: <bpf+bounces-56038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A971A8B999
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 14:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1A93B2F44
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 12:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A21155C88;
	Wed, 16 Apr 2025 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oo/LSp24"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18229F9D9
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807747; cv=none; b=k5CNZtDyTagQG8wB+yXcNZWCmxOHYxufzKOx5F/1TxWg7bhvjy+PzxpN9/xGY+rsU36uLcFwkMThtNNhPDSTQaJDWB96aJo6uBjfKa0KGLeoKKM9MD2NdsYan4Vq3sX0C6rRSHffBGC4FC3Zy7SumYKf8zfvMkuTpw/Z6qER04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807747; c=relaxed/simple;
	bh=3x80OKswAWW4KUgCkDm9O/j1aGGjjTqwqDTe6oTvHxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTFBs+e3FUCZnU5Sqx9XIlF1SalLPq+bnMdAdRzfMEQuIKZb587nAqOaylTZufA9qulULGDxlmAcPtEUemqqFJgxAkLOeLq4iyIPgqb6Com5Li6QAaIOfHExNMqGdgag4jGMFuplInc26s1hss+/e8mSLmxy4OovFzxWk2voLIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oo/LSp24; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GB1daJ028300;
	Wed, 16 Apr 2025 12:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=p71ODjKWKQIFuclx+Be1WcttQ6L0HU7dyH9IpNUJh
	a8=; b=oo/LSp24lujhIWTFYoUlOixHFKCpIkuhqFeBjQY+ubY9ocQxtv5ewS6K1
	oPEEDG7zDRDVj2u6Zk1ko6d5xOqoXPF9VzDEShN2vvID4d3/gOjDY2yd57r7kOir
	2Rsa6OJV1N4Nk4/OqMwlBRReMQi86UFw7dqTayuM5grPwEHESVso5fXwByyH7A8S
	Y6NOFJDHhfJTofVqie4gJtmG4dQXrZfrWzZZUOOuFcRbOtn58uc5CN7S/IQT4UIJ
	UQbQC1h7i41IevVGFeMsg82ORHSBrmin29QoN3dVRJwhHhClRYUN8trTsx2EHiqG
	Vs2P7zBwFjIoww0t7n6LMDc2yFIjw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4621dxb4hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 12:48:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9p340001255;
	Wed, 16 Apr 2025 12:48:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602w00hbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 12:48:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GCmllY28836292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 12:48:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68CBD20043;
	Wed, 16 Apr 2025 12:48:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 271BF20040;
	Wed, 16 Apr 2025 12:48:47 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.201.197])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 12:48:47 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] selftests/bpf: Set MACs during veth creation in tc_redirect
Date: Wed, 16 Apr 2025 14:47:58 +0200
Message-ID: <20250416124845.584362-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 53ZWg3MMkvJR0yZoWnb0vXA5scYKL1YK
X-Proofpoint-GUID: 53ZWg3MMkvJR0yZoWnb0vXA5scYKL1YK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1011 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160103

tc_redirect/tc_redirect_dtime fails intermittently on some systems
with:

   (network_helpers.c:303: errno: Operation now in progress) Failed to connect to server

The problem is that on these systems systemd-networkd and systemd-udevd
are installed in the default configuration, which includes:

    /usr/lib/systemd/network/99-default.link
    /usr/lib/udev/rules.d/80-net-setup-link.rules

These configs instruct systemd to change MAC addresses of newly created
interfaces, which includes the ones created by BPF selftests. In this
particular case it causes SYN+ACK packets to be dropped, because they
get the PACKET_OTHERHOST type - the fact that this causes a connect()
on a blocking socket to return -EINPROGRESS looks like a bug, which
needs to be investigated separately.

systemd won't change the MAC address if the kernel reports that it was
already set by userspace; the NET_ADDR_SET check in
link_generate_new_hw_addr() is responsible for this.

In order to eliminate the race window between systemd and the test,
set MAC addresses during link creation. Ignore checkpatch's "quoted
string split across lines" warning, since it points to a command line,
and not a user-visible message.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index c85798966aec..76d72a59365e 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -56,6 +56,8 @@
 
 #define MAC_DST_FWD "00:11:22:33:44:55"
 #define MAC_DST "00:22:33:44:55:66"
+#define MAC_SRC_FWD "00:33:44:55:66:77"
+#define MAC_SRC "00:44:55:66:77:88"
 
 #define IFADDR_STR_LEN 18
 #define PING_ARGS "-i 0.2 -c 3 -w 10 -q"
@@ -207,11 +209,10 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	int err;
 
 	if (result->dev_mode == MODE_VETH) {
-		SYS(fail, "ip link add src type veth peer name src_fwd");
-		SYS(fail, "ip link add dst type veth peer name dst_fwd");
-
-		SYS(fail, "ip link set dst_fwd address " MAC_DST_FWD);
-		SYS(fail, "ip link set dst address " MAC_DST);
+		SYS(fail, "ip link add src address " MAC_SRC " type veth "
+			  "peer name src_fwd address " MAC_SRC_FWD);
+		SYS(fail, "ip link add dst address " MAC_DST " type veth "
+			  "peer name dst_fwd address " MAC_DST_FWD);
 	} else if (result->dev_mode == MODE_NETKIT) {
 		err = create_netkit(NETKIT_L3, "src", "src_fwd");
 		if (!ASSERT_OK(err, "create_ifindex_src"))
-- 
2.49.0


