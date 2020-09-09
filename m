Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0181426399F
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 03:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgIJB7B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 21:59:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729822AbgIJBo5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:44:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089N1up6025509;
        Wed, 9 Sep 2020 19:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kp2f+VHZgUNccwbWt3aRbAZVCwfMbVuF/oAh8BIIM7w=;
 b=OtTUnBx6ALTu+ozRNbAs1acU60izVArPVTlRiKUjiwba5hCSmvZzbY86aYNHBRvrC6lq
 PSEMEzl06AZrC9ki95wZv/bUb+fpOIUp9GpHN9l7ditqx8qnH2fUYtvk8iPqYrMK+NIV
 AZvbnGHhGAbXagBczmck2rQZbfivpoKwrSt56goOcUDfEdWY2ydV8N+JpLfWWfoNeUt/
 TE6j9CSfePFFGI9MNEXFgrG8WwYru2YbDB15ZGa5EItgTBbD+XsTRLlxQBjIt2OFVXq+
 ilx06OeYHvANTw9NrbvobdFPloH4Ttb0VcdqOiZmELUq0TF7CbTmbnvTEFgVMPP3Zsao DQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f8310u08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:25:26 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089NID3F011244;
        Wed, 9 Sep 2020 23:25:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 33c2a811q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 23:25:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089NPLjJ39977220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 23:25:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 136A311C050;
        Wed,  9 Sep 2020 23:25:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACB4D11C04A;
        Wed,  9 Sep 2020 23:25:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 23:25:20 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Fix endianness issues in sk_lookup/ctx_narrow_access
Date:   Thu, 10 Sep 2020 01:24:42 +0200
Message-Id: <20200909232443.3099637-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200909232443.3099637-1-iii@linux.ibm.com>
References: <20200909232443.3099637-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090197
Sender: bpf-owner@vger.kernel.org
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
 .../selftests/bpf/progs/test_sk_lookup.c      | 264 ++++++++++--------
 1 file changed, 149 insertions(+), 115 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index bbf8296f4d66..94e6d370967b 100644
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
@@ -369,171 +380,194 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
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
+	    LSB(ctx->family, 1) != 0 || LSB(ctx->family, 2) != 0 ||
+	    LSB(ctx->family, 3) != 0)
 		return SK_DROP;
-	if (half[0] != (v4 ? AF_INET : AF_INET6))
+	if (LSW(ctx->family, 0) != (v4 ? AF_INET : AF_INET6))
 		return SK_DROP;
 
-	byte = (__u8 *)&ctx->protocol;
-	if (byte[0] != IPPROTO_TCP ||
-	    byte[1] != 0 || byte[2] != 0 || byte[3] != 0)
+	/* Narrow loads from protocol field */
+	if (LSB(ctx->protocol, 0) != IPPROTO_TCP ||
+	    LSB(ctx->protocol, 1) != 0 || LSB(ctx->protocol, 2) != 0 ||
+	    LSB(ctx->protocol, 3) != 0)
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
+		if (LSB(ctx->remote_ip4, 0) == 0 &&
+		    LSB(ctx->remote_ip4, 1) == 0 &&
+		    LSB(ctx->remote_ip4, 2) == 0 &&
+		    LSB(ctx->remote_ip4, 3) == 0)
 			return SK_DROP;
-		half = (__u16 *)&ctx->remote_ip4;
-		if (half[0] == 0 && half[1] == 0)
+		if (LSW(ctx->remote_ip4, 0) == 0 &&
+		    LSW(ctx->remote_ip4, 1) == 0)
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
+		if (LSB(ctx->remote_ip4, 0) != 0 ||
+		    LSB(ctx->remote_ip4, 1) != 0 ||
+		    LSB(ctx->remote_ip4, 2) != 0 ||
+		    LSB(ctx->remote_ip4, 3) != 0)
 			return SK_DROP;
-		half = (__u16 *)&ctx->remote_ip4;
-		if (half[0] != 0 || half[1] != 0)
+		if (LSW(ctx->remote_ip4, 0) != 0 ||
+		    LSW(ctx->remote_ip4, 1) != 0)
 			return SK_DROP;
 
-		byte = (__u8 *)&ctx->local_ip4;
-		if (byte[0] != 0 || byte[1] != 0 &&
-		    byte[2] != 0 || byte[3] != 0)
+		if (LSB(ctx->local_ip4, 0) != 0 ||
+		    LSB(ctx->local_ip4, 1) != 0 ||
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
+		if (LSB(ctx->remote_ip6[0], 0) == 0 &&
+		    LSB(ctx->remote_ip6[0], 1) == 0 &&
+		    LSB(ctx->remote_ip6[0], 2) == 0 &&
+		    LSB(ctx->remote_ip6[0], 3) == 0 &&
+		    LSB(ctx->remote_ip6[1], 0) == 0 &&
+		    LSB(ctx->remote_ip6[1], 1) == 0 &&
+		    LSB(ctx->remote_ip6[1], 2) == 0 &&
+		    LSB(ctx->remote_ip6[1], 3) == 0 &&
+		    LSB(ctx->remote_ip6[2], 0) == 0 &&
+		    LSB(ctx->remote_ip6[2], 1) == 0 &&
+		    LSB(ctx->remote_ip6[2], 2) == 0 &&
+		    LSB(ctx->remote_ip6[2], 3) == 0 &&
+		    LSB(ctx->remote_ip6[3], 0) == 0 &&
+		    LSB(ctx->remote_ip6[3], 1) == 0 &&
+		    LSB(ctx->remote_ip6[3], 2) == 0 &&
+		    LSB(ctx->remote_ip6[3], 3) == 0)
 			return SK_DROP;
-		half = (__u16 *)&ctx->remote_ip6;
-		if (half[0] == 0 && half[1] == 0 &&
-		    half[2] == 0 && half[3] == 0 &&
-		    half[4] == 0 && half[5] == 0 &&
-		    half[6] == 0 && half[7] == 0)
+		if (LSW(ctx->remote_ip6[0], 0) == 0 &&
+		    LSW(ctx->remote_ip6[0], 1) == 0 &&
+		    LSW(ctx->remote_ip6[1], 0) == 0 &&
+		    LSW(ctx->remote_ip6[1], 1) == 0 &&
+		    LSW(ctx->remote_ip6[2], 0) == 0 &&
+		    LSW(ctx->remote_ip6[2], 1) == 0 &&
+		    LSW(ctx->remote_ip6[3], 0) == 0 &&
+		    LSW(ctx->remote_ip6[3], 1) == 0)
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
+		    LSW(ctx->local_ip6[0], 1) !=
+			    ((DST_IP6[0] >> 16) & 0xffff) ||
+		    LSW(ctx->local_ip6[1], 0) != ((DST_IP6[1] >> 0) & 0xffff) ||
+		    LSW(ctx->local_ip6[1], 1) !=
+			    ((DST_IP6[1] >> 16) & 0xffff) ||
+		    LSW(ctx->local_ip6[2], 0) != ((DST_IP6[2] >> 0) & 0xffff) ||
+		    LSW(ctx->local_ip6[2], 1) !=
+			    ((DST_IP6[2] >> 16) & 0xffff) ||
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
+		if (LSB(ctx->remote_ip6[0], 0) != 0 ||
+		    LSB(ctx->remote_ip6[0], 1) != 0 ||
+		    LSB(ctx->remote_ip6[0], 2) != 0 ||
+		    LSB(ctx->remote_ip6[0], 3) != 0 ||
+		    LSB(ctx->remote_ip6[1], 0) != 0 ||
+		    LSB(ctx->remote_ip6[1], 1) != 0 ||
+		    LSB(ctx->remote_ip6[1], 2) != 0 ||
+		    LSB(ctx->remote_ip6[1], 3) != 0 ||
+		    LSB(ctx->remote_ip6[2], 0) != 0 ||
+		    LSB(ctx->remote_ip6[2], 1) != 0 ||
+		    LSB(ctx->remote_ip6[2], 2) != 0 ||
+		    LSB(ctx->remote_ip6[2], 3) != 0 ||
+		    LSB(ctx->remote_ip6[3], 0) != 0 ||
+		    LSB(ctx->remote_ip6[3], 1) != 0 ||
+		    LSB(ctx->remote_ip6[3], 2) != 0 ||
+		    LSB(ctx->remote_ip6[3], 3) != 0)
 			return SK_DROP;
-		half = (__u16 *)&ctx->remote_ip6;
-		if (half[0] != 0 || half[1] != 0 ||
-		    half[2] != 0 || half[3] != 0 ||
-		    half[4] != 0 || half[5] != 0 ||
-		    half[6] != 0 || half[7] != 0)
+		if (LSW(ctx->remote_ip6[0], 0) != 0 ||
+		    LSW(ctx->remote_ip6[0], 1) != 0 ||
+		    LSW(ctx->remote_ip6[1], 0) != 0 ||
+		    LSW(ctx->remote_ip6[1], 1) != 0 ||
+		    LSW(ctx->remote_ip6[2], 0) != 0 ||
+		    LSW(ctx->remote_ip6[2], 1) != 0 ||
+		    LSW(ctx->remote_ip6[3], 0) != 0 ||
+		    LSW(ctx->remote_ip6[3], 1) != 0)
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
+		if (LSB(ctx->local_ip6[0], 0) != 0 ||
+		    LSB(ctx->local_ip6[0], 1) != 0 ||
+		    LSB(ctx->local_ip6[0], 2) != 0 ||
+		    LSB(ctx->local_ip6[0], 3) != 0 ||
+		    LSB(ctx->local_ip6[1], 0) != 0 ||
+		    LSB(ctx->local_ip6[1], 1) != 0 ||
+		    LSB(ctx->local_ip6[1], 2) != 0 ||
+		    LSB(ctx->local_ip6[1], 3) != 0 ||
+		    LSB(ctx->local_ip6[2], 0) != 0 ||
+		    LSB(ctx->local_ip6[2], 1) != 0 ||
+		    LSB(ctx->local_ip6[2], 2) != 0 ||
+		    LSB(ctx->local_ip6[2], 3) != 0 ||
+		    LSB(ctx->local_ip6[3], 0) != 0 ||
+		    LSB(ctx->local_ip6[3], 1) != 0 ||
+		    LSB(ctx->local_ip6[3], 2) != 0 ||
+		    LSB(ctx->local_ip6[3], 3) != 0)
 			return SK_DROP;
-		half = (__u16 *)&ctx->local_ip6;
-		if (half[0] != 0 || half[1] != 0 ||
-		    half[2] != 0 || half[3] != 0 ||
-		    half[4] != 0 || half[5] != 0 ||
-		    half[6] != 0 || half[7] != 0)
+		if (LSW(ctx->remote_ip6[0], 0) != 0 ||
+		    LSW(ctx->remote_ip6[0], 1) != 0 ||
+		    LSW(ctx->remote_ip6[1], 0) != 0 ||
+		    LSW(ctx->remote_ip6[1], 1) != 0 ||
+		    LSW(ctx->remote_ip6[2], 0) != 0 ||
+		    LSW(ctx->remote_ip6[2], 1) != 0 ||
+		    LSW(ctx->remote_ip6[3], 0) != 0 ||
+		    LSW(ctx->remote_ip6[3], 1) != 0)
 			return SK_DROP;
 	}
 
-- 
2.25.4

