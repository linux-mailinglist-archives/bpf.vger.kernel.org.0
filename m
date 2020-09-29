Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C045F27D7E5
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 22:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgI2USi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 16:18:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50302 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727761AbgI2USi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 16:18:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TK3DhF011149;
        Tue, 29 Sep 2020 16:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=aOBG3vSGJwVjBzDN4hBEo1+TcuoP2Zqh44kHMI2eY7Y=;
 b=gCl94Iz7RXAl33ZiazElb2Ze/fC9jZE2IFti5kupzeiOYFuylpCRJ5tUO6wqZSTPPXSw
 sJ4ZT5T3Kl8Ree3Q480QafRYrXa/sm6uXcal4kqaOgDHIAfOiUUqEmJvLBapJpc3pjUX
 oesAtByFqjmR0VV5ZIxHXT/Al4Pkk2Zu5ytcn4+nz796pfeeGlVjWVleQXLXP0pHVss5
 Rz0N8waOVNPQ/X44ytJ0aYqd106RrQeyvxMq4K1nqwDN6ZlLLYdhY4LLwxCZXC4Zn4Nz
 AlQd/fPgwMvzmhhiwmeAH8fVMKdVz9SBobKSk46gM0UawF4QucC9iSKHn3dDZ5QZ3bmJ sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vbhc0jm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 16:18:22 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08TK60Xv021289;
        Tue, 29 Sep 2020 16:18:21 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vbhc0jkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 16:18:21 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08TKGWxa011881;
        Tue, 29 Sep 2020 20:18:19 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 33t16k1v1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 20:18:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08TKIGFQ31916508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 20:18:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B59204C04A;
        Tue, 29 Sep 2020 20:18:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46D304C040;
        Tue, 29 Sep 2020 20:18:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.92.232])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Sep 2020 20:18:16 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Fix endianness issues in sk_lookup/ctx_narrow_access
Date:   Tue, 29 Sep 2020 22:18:14 +0200
Message-Id: <20200929201814.44360-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_13:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290168
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test makes a lot of narrow load checks while assuming little
endian architecture, and therefore fails on s390.

Fix by introducing LSB and LSW macros and using them to perform narrow
loads.

Fixes: 0ab5539f8584 ("selftests/bpf: Tests for BPF_SK_LOOKUP attach point")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/bpf/20200909232443.3099637-3-iii@linux.ibm.com/

v1 -> v2: Make some lines longer than 80 characters in order to
improve readability. Not sure if I can keep Jakub's Reviewed-by after
reformatting, so sending as is.

.../selftests/bpf/progs/test_sk_lookup.c      | 216 ++++++++----------
 1 file changed, 101 insertions(+), 115 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index bbf8296f4d66..1032b292af5b 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -19,6 +19,17 @@
 #define IP6(aaaa, bbbb, cccc, dddd)			\
 	{ bpf_htonl(aaaa), bpf_htonl(bbbb), bpf_htonl(cccc), bpf_htonl(dddd) }
 
+/* Macros for least-significant byte and word accesses. */
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define LSE_INDEX(index, size) (index)
+#else
+#define LSE_INDEX(index, size) ((size) - (index) - 1)
+#endif
+#define LSB(value, index)				\
+	(((__u8 *)&(value))[LSE_INDEX((index), sizeof(value))])
+#define LSW(value, index)				\
+	(((__u16 *)&(value))[LSE_INDEX((index), sizeof(value) / 2)])
+
 #define MAX_SOCKS 32
 
 struct {
@@ -369,171 +380,146 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
 	int err, family;
-	__u16 *half;
-	__u8 *byte;
 	bool v4;
 
 	v4 = (ctx->family == AF_INET);
 
 	/* Narrow loads from family field */
-	byte = (__u8 *)&ctx->family;
-	half = (__u16 *)&ctx->family;
-	if (byte[0] != (v4 ? AF_INET : AF_INET6) ||
-	    byte[1] != 0 || byte[2] != 0 || byte[3] != 0)
+	if (LSB(ctx->family, 0) != (v4 ? AF_INET : AF_INET6) ||
+	    LSB(ctx->family, 1) != 0 || LSB(ctx->family, 2) != 0 || LSB(ctx->family, 3) != 0)
 		return SK_DROP;
-	if (half[0] != (v4 ? AF_INET : AF_INET6))
+	if (LSW(ctx->family, 0) != (v4 ? AF_INET : AF_INET6))
 		return SK_DROP;
 
-	byte = (__u8 *)&ctx->protocol;
-	if (byte[0] != IPPROTO_TCP ||
-	    byte[1] != 0 || byte[2] != 0 || byte[3] != 0)
+	/* Narrow loads from protocol field */
+	if (LSB(ctx->protocol, 0) != IPPROTO_TCP ||
+	    LSB(ctx->protocol, 1) != 0 || LSB(ctx->protocol, 2) != 0 || LSB(ctx->protocol, 3) != 0)
 		return SK_DROP;
-	half = (__u16 *)&ctx->protocol;
-	if (half[0] != IPPROTO_TCP)
+	if (LSW(ctx->protocol, 0) != IPPROTO_TCP)
 		return SK_DROP;
 
 	/* Narrow loads from remote_port field. Expect non-0 value. */
-	byte = (__u8 *)&ctx->remote_port;
-	if (byte[0] == 0 && byte[1] == 0 && byte[2] == 0 && byte[3] == 0)
+	if (LSB(ctx->remote_port, 0) == 0 && LSB(ctx->remote_port, 1) == 0 &&
+	    LSB(ctx->remote_port, 2) == 0 && LSB(ctx->remote_port, 3) == 0)
 		return SK_DROP;
-	half = (__u16 *)&ctx->remote_port;
-	if (half[0] == 0)
+	if (LSW(ctx->remote_port, 0) == 0)
 		return SK_DROP;
 
 	/* Narrow loads from local_port field. Expect DST_PORT. */
-	byte = (__u8 *)&ctx->local_port;
-	if (byte[0] != ((DST_PORT >> 0) & 0xff) ||
-	    byte[1] != ((DST_PORT >> 8) & 0xff) ||
-	    byte[2] != 0 || byte[3] != 0)
+	if (LSB(ctx->local_port, 0) != ((DST_PORT >> 0) & 0xff) ||
+	    LSB(ctx->local_port, 1) != ((DST_PORT >> 8) & 0xff) ||
+	    LSB(ctx->local_port, 2) != 0 || LSB(ctx->local_port, 3) != 0)
 		return SK_DROP;
-	half = (__u16 *)&ctx->local_port;
-	if (half[0] != DST_PORT)
+	if (LSW(ctx->local_port, 0) != DST_PORT)
 		return SK_DROP;
 
 	/* Narrow loads from IPv4 fields */
 	if (v4) {
 		/* Expect non-0.0.0.0 in remote_ip4 */
-		byte = (__u8 *)&ctx->remote_ip4;
-		if (byte[0] == 0 && byte[1] == 0 &&
-		    byte[2] == 0 && byte[3] == 0)
+		if (LSB(ctx->remote_ip4, 0) == 0 && LSB(ctx->remote_ip4, 1) == 0 &&
+		    LSB(ctx->remote_ip4, 2) == 0 && LSB(ctx->remote_ip4, 3) == 0)
 			return SK_DROP;
-		half = (__u16 *)&ctx->remote_ip4;
-		if (half[0] == 0 && half[1] == 0)
+		if (LSW(ctx->remote_ip4, 0) == 0 && LSW(ctx->remote_ip4, 1) == 0)
 			return SK_DROP;
 
 		/* Expect DST_IP4 in local_ip4 */
-		byte = (__u8 *)&ctx->local_ip4;
-		if (byte[0] != ((DST_IP4 >>  0) & 0xff) ||
-		    byte[1] != ((DST_IP4 >>  8) & 0xff) ||
-		    byte[2] != ((DST_IP4 >> 16) & 0xff) ||
-		    byte[3] != ((DST_IP4 >> 24) & 0xff))
+		if (LSB(ctx->local_ip4, 0) != ((DST_IP4 >> 0) & 0xff) ||
+		    LSB(ctx->local_ip4, 1) != ((DST_IP4 >> 8) & 0xff) ||
+		    LSB(ctx->local_ip4, 2) != ((DST_IP4 >> 16) & 0xff) ||
+		    LSB(ctx->local_ip4, 3) != ((DST_IP4 >> 24) & 0xff))
 			return SK_DROP;
-		half = (__u16 *)&ctx->local_ip4;
-		if (half[0] != ((DST_IP4 >>  0) & 0xffff) ||
-		    half[1] != ((DST_IP4 >> 16) & 0xffff))
+		if (LSW(ctx->local_ip4, 0) != ((DST_IP4 >> 0) & 0xffff) ||
+		    LSW(ctx->local_ip4, 1) != ((DST_IP4 >> 16) & 0xffff))
 			return SK_DROP;
 	} else {
 		/* Expect 0.0.0.0 IPs when family != AF_INET */
-		byte = (__u8 *)&ctx->remote_ip4;
-		if (byte[0] != 0 || byte[1] != 0 &&
-		    byte[2] != 0 || byte[3] != 0)
+		if (LSB(ctx->remote_ip4, 0) != 0 || LSB(ctx->remote_ip4, 1) != 0 ||
+		    LSB(ctx->remote_ip4, 2) != 0 || LSB(ctx->remote_ip4, 3) != 0)
 			return SK_DROP;
-		half = (__u16 *)&ctx->remote_ip4;
-		if (half[0] != 0 || half[1] != 0)
+		if (LSW(ctx->remote_ip4, 0) != 0 || LSW(ctx->remote_ip4, 1) != 0)
 			return SK_DROP;
 
-		byte = (__u8 *)&ctx->local_ip4;
-		if (byte[0] != 0 || byte[1] != 0 &&
-		    byte[2] != 0 || byte[3] != 0)
+		if (LSB(ctx->local_ip4, 0) != 0 || LSB(ctx->local_ip4, 1) != 0 ||
+		    LSB(ctx->local_ip4, 2) != 0 || LSB(ctx->local_ip4, 3) != 0)
 			return SK_DROP;
-		half = (__u16 *)&ctx->local_ip4;
-		if (half[0] != 0 || half[1] != 0)
+		if (LSW(ctx->local_ip4, 0) != 0 || LSW(ctx->local_ip4, 1) != 0)
 			return SK_DROP;
 	}
 
 	/* Narrow loads from IPv6 fields */
 	if (!v4) {
-		/* Expenct non-:: IP in remote_ip6 */
-		byte = (__u8 *)&ctx->remote_ip6;
-		if (byte[0] == 0 && byte[1] == 0 &&
-		    byte[2] == 0 && byte[3] == 0 &&
-		    byte[4] == 0 && byte[5] == 0 &&
-		    byte[6] == 0 && byte[7] == 0 &&
-		    byte[8] == 0 && byte[9] == 0 &&
-		    byte[10] == 0 && byte[11] == 0 &&
-		    byte[12] == 0 && byte[13] == 0 &&
-		    byte[14] == 0 && byte[15] == 0)
+		/* Expect non-:: IP in remote_ip6 */
+		if (LSB(ctx->remote_ip6[0], 0) == 0 && LSB(ctx->remote_ip6[0], 1) == 0 &&
+		    LSB(ctx->remote_ip6[0], 2) == 0 && LSB(ctx->remote_ip6[0], 3) == 0 &&
+		    LSB(ctx->remote_ip6[1], 0) == 0 && LSB(ctx->remote_ip6[1], 1) == 0 &&
+		    LSB(ctx->remote_ip6[1], 2) == 0 && LSB(ctx->remote_ip6[1], 3) == 0 &&
+		    LSB(ctx->remote_ip6[2], 0) == 0 && LSB(ctx->remote_ip6[2], 1) == 0 &&
+		    LSB(ctx->remote_ip6[2], 2) == 0 && LSB(ctx->remote_ip6[2], 3) == 0 &&
+		    LSB(ctx->remote_ip6[3], 0) == 0 && LSB(ctx->remote_ip6[3], 1) == 0 &&
+		    LSB(ctx->remote_ip6[3], 2) == 0 && LSB(ctx->remote_ip6[3], 3) == 0)
 			return SK_DROP;
-		half = (__u16 *)&ctx->remote_ip6;
-		if (half[0] == 0 && half[1] == 0 &&
-		    half[2] == 0 && half[3] == 0 &&
-		    half[4] == 0 && half[5] == 0 &&
-		    half[6] == 0 && half[7] == 0)
+		if (LSW(ctx->remote_ip6[0], 0) == 0 && LSW(ctx->remote_ip6[0], 1) == 0 &&
+		    LSW(ctx->remote_ip6[1], 0) == 0 && LSW(ctx->remote_ip6[1], 1) == 0 &&
+		    LSW(ctx->remote_ip6[2], 0) == 0 && LSW(ctx->remote_ip6[2], 1) == 0 &&
+		    LSW(ctx->remote_ip6[3], 0) == 0 && LSW(ctx->remote_ip6[3], 1) == 0)
 			return SK_DROP;
-
 		/* Expect DST_IP6 in local_ip6 */
-		byte = (__u8 *)&ctx->local_ip6;
-		if (byte[0] != ((DST_IP6[0] >>  0) & 0xff) ||
-		    byte[1] != ((DST_IP6[0] >>  8) & 0xff) ||
-		    byte[2] != ((DST_IP6[0] >> 16) & 0xff) ||
-		    byte[3] != ((DST_IP6[0] >> 24) & 0xff) ||
-		    byte[4] != ((DST_IP6[1] >>  0) & 0xff) ||
-		    byte[5] != ((DST_IP6[1] >>  8) & 0xff) ||
-		    byte[6] != ((DST_IP6[1] >> 16) & 0xff) ||
-		    byte[7] != ((DST_IP6[1] >> 24) & 0xff) ||
-		    byte[8] != ((DST_IP6[2] >>  0) & 0xff) ||
-		    byte[9] != ((DST_IP6[2] >>  8) & 0xff) ||
-		    byte[10] != ((DST_IP6[2] >> 16) & 0xff) ||
-		    byte[11] != ((DST_IP6[2] >> 24) & 0xff) ||
-		    byte[12] != ((DST_IP6[3] >>  0) & 0xff) ||
-		    byte[13] != ((DST_IP6[3] >>  8) & 0xff) ||
-		    byte[14] != ((DST_IP6[3] >> 16) & 0xff) ||
-		    byte[15] != ((DST_IP6[3] >> 24) & 0xff))
+		if (LSB(ctx->local_ip6[0], 0) != ((DST_IP6[0] >> 0) & 0xff) ||
+		    LSB(ctx->local_ip6[0], 1) != ((DST_IP6[0] >> 8) & 0xff) ||
+		    LSB(ctx->local_ip6[0], 2) != ((DST_IP6[0] >> 16) & 0xff) ||
+		    LSB(ctx->local_ip6[0], 3) != ((DST_IP6[0] >> 24) & 0xff) ||
+		    LSB(ctx->local_ip6[1], 0) != ((DST_IP6[1] >> 0) & 0xff) ||
+		    LSB(ctx->local_ip6[1], 1) != ((DST_IP6[1] >> 8) & 0xff) ||
+		    LSB(ctx->local_ip6[1], 2) != ((DST_IP6[1] >> 16) & 0xff) ||
+		    LSB(ctx->local_ip6[1], 3) != ((DST_IP6[1] >> 24) & 0xff) ||
+		    LSB(ctx->local_ip6[2], 0) != ((DST_IP6[2] >> 0) & 0xff) ||
+		    LSB(ctx->local_ip6[2], 1) != ((DST_IP6[2] >> 8) & 0xff) ||
+		    LSB(ctx->local_ip6[2], 2) != ((DST_IP6[2] >> 16) & 0xff) ||
+		    LSB(ctx->local_ip6[2], 3) != ((DST_IP6[2] >> 24) & 0xff) ||
+		    LSB(ctx->local_ip6[3], 0) != ((DST_IP6[3] >> 0) & 0xff) ||
+		    LSB(ctx->local_ip6[3], 1) != ((DST_IP6[3] >> 8) & 0xff) ||
+		    LSB(ctx->local_ip6[3], 2) != ((DST_IP6[3] >> 16) & 0xff) ||
+		    LSB(ctx->local_ip6[3], 3) != ((DST_IP6[3] >> 24) & 0xff))
 			return SK_DROP;
-		half = (__u16 *)&ctx->local_ip6;
-		if (half[0] != ((DST_IP6[0] >>  0) & 0xffff) ||
-		    half[1] != ((DST_IP6[0] >> 16) & 0xffff) ||
-		    half[2] != ((DST_IP6[1] >>  0) & 0xffff) ||
-		    half[3] != ((DST_IP6[1] >> 16) & 0xffff) ||
-		    half[4] != ((DST_IP6[2] >>  0) & 0xffff) ||
-		    half[5] != ((DST_IP6[2] >> 16) & 0xffff) ||
-		    half[6] != ((DST_IP6[3] >>  0) & 0xffff) ||
-		    half[7] != ((DST_IP6[3] >> 16) & 0xffff))
+		if (LSW(ctx->local_ip6[0], 0) != ((DST_IP6[0] >> 0) & 0xffff) ||
+		    LSW(ctx->local_ip6[0], 1) != ((DST_IP6[0] >> 16) & 0xffff) ||
+		    LSW(ctx->local_ip6[1], 0) != ((DST_IP6[1] >> 0) & 0xffff) ||
+		    LSW(ctx->local_ip6[1], 1) != ((DST_IP6[1] >> 16) & 0xffff) ||
+		    LSW(ctx->local_ip6[2], 0) != ((DST_IP6[2] >> 0) & 0xffff) ||
+		    LSW(ctx->local_ip6[2], 1) != ((DST_IP6[2] >> 16) & 0xffff) ||
+		    LSW(ctx->local_ip6[3], 0) != ((DST_IP6[3] >> 0) & 0xffff) ||
+		    LSW(ctx->local_ip6[3], 1) != ((DST_IP6[3] >> 16) & 0xffff))
 			return SK_DROP;
 	} else {
 		/* Expect :: IPs when family != AF_INET6 */
-		byte = (__u8 *)&ctx->remote_ip6;
-		if (byte[0] != 0 || byte[1] != 0 ||
-		    byte[2] != 0 || byte[3] != 0 ||
-		    byte[4] != 0 || byte[5] != 0 ||
-		    byte[6] != 0 || byte[7] != 0 ||
-		    byte[8] != 0 || byte[9] != 0 ||
-		    byte[10] != 0 || byte[11] != 0 ||
-		    byte[12] != 0 || byte[13] != 0 ||
-		    byte[14] != 0 || byte[15] != 0)
+		if (LSB(ctx->remote_ip6[0], 0) != 0 || LSB(ctx->remote_ip6[0], 1) != 0 ||
+		    LSB(ctx->remote_ip6[0], 2) != 0 || LSB(ctx->remote_ip6[0], 3) != 0 ||
+		    LSB(ctx->remote_ip6[1], 0) != 0 || LSB(ctx->remote_ip6[1], 1) != 0 ||
+		    LSB(ctx->remote_ip6[1], 2) != 0 || LSB(ctx->remote_ip6[1], 3) != 0 ||
+		    LSB(ctx->remote_ip6[2], 0) != 0 || LSB(ctx->remote_ip6[2], 1) != 0 ||
+		    LSB(ctx->remote_ip6[2], 2) != 0 || LSB(ctx->remote_ip6[2], 3) != 0 ||
+		    LSB(ctx->remote_ip6[3], 0) != 0 || LSB(ctx->remote_ip6[3], 1) != 0 ||
+		    LSB(ctx->remote_ip6[3], 2) != 0 || LSB(ctx->remote_ip6[3], 3) != 0)
 			return SK_DROP;
-		half = (__u16 *)&ctx->remote_ip6;
-		if (half[0] != 0 || half[1] != 0 ||
-		    half[2] != 0 || half[3] != 0 ||
-		    half[4] != 0 || half[5] != 0 ||
-		    half[6] != 0 || half[7] != 0)
+		if (LSW(ctx->remote_ip6[0], 0) != 0 || LSW(ctx->remote_ip6[0], 1) != 0 ||
+		    LSW(ctx->remote_ip6[1], 0) != 0 || LSW(ctx->remote_ip6[1], 1) != 0 ||
+		    LSW(ctx->remote_ip6[2], 0) != 0 || LSW(ctx->remote_ip6[2], 1) != 0 ||
+		    LSW(ctx->remote_ip6[3], 0) != 0 || LSW(ctx->remote_ip6[3], 1) != 0)
 			return SK_DROP;
 
-		byte = (__u8 *)&ctx->local_ip6;
-		if (byte[0] != 0 || byte[1] != 0 ||
-		    byte[2] != 0 || byte[3] != 0 ||
-		    byte[4] != 0 || byte[5] != 0 ||
-		    byte[6] != 0 || byte[7] != 0 ||
-		    byte[8] != 0 || byte[9] != 0 ||
-		    byte[10] != 0 || byte[11] != 0 ||
-		    byte[12] != 0 || byte[13] != 0 ||
-		    byte[14] != 0 || byte[15] != 0)
+		if (LSB(ctx->local_ip6[0], 0) != 0 || LSB(ctx->local_ip6[0], 1) != 0 ||
+		    LSB(ctx->local_ip6[0], 2) != 0 || LSB(ctx->local_ip6[0], 3) != 0 ||
+		    LSB(ctx->local_ip6[1], 0) != 0 || LSB(ctx->local_ip6[1], 1) != 0 ||
+		    LSB(ctx->local_ip6[1], 2) != 0 || LSB(ctx->local_ip6[1], 3) != 0 ||
+		    LSB(ctx->local_ip6[2], 0) != 0 || LSB(ctx->local_ip6[2], 1) != 0 ||
+		    LSB(ctx->local_ip6[2], 2) != 0 || LSB(ctx->local_ip6[2], 3) != 0 ||
+		    LSB(ctx->local_ip6[3], 0) != 0 || LSB(ctx->local_ip6[3], 1) != 0 ||
+		    LSB(ctx->local_ip6[3], 2) != 0 || LSB(ctx->local_ip6[3], 3) != 0)
 			return SK_DROP;
-		half = (__u16 *)&ctx->local_ip6;
-		if (half[0] != 0 || half[1] != 0 ||
-		    half[2] != 0 || half[3] != 0 ||
-		    half[4] != 0 || half[5] != 0 ||
-		    half[6] != 0 || half[7] != 0)
+		if (LSW(ctx->remote_ip6[0], 0) != 0 || LSW(ctx->remote_ip6[0], 1) != 0 ||
+		    LSW(ctx->remote_ip6[1], 0) != 0 || LSW(ctx->remote_ip6[1], 1) != 0 ||
+		    LSW(ctx->remote_ip6[2], 0) != 0 || LSW(ctx->remote_ip6[2], 1) != 0 ||
+		    LSW(ctx->remote_ip6[3], 0) != 0 || LSW(ctx->remote_ip6[3], 1) != 0)
 			return SK_DROP;
 	}
 
-- 
2.25.4

