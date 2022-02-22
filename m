Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935CD4C013C
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 19:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiBVS04 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 13:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiBVS0z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 13:26:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845A9EB314
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 10:26:29 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MIGICk005666;
        Tue, 22 Feb 2022 18:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TzTFF2TVwdCmr/St4hox7DzKKD+ch0GOQUs8P8AhqRg=;
 b=VBE+tQVIWRy9JFPdGTsazXU/Uw5pexa3kqsc/o9t2O3KKG1bmlkc3xsnYQSmL+xpJ/HS
 K/n8ohOOlaNnzeAYYGaaqameKJacPksVTSsjhZfsTaL8zWtjhxc3mRKSWgNKt8GRN8up
 dDDRf4rvSRVRDn95Oh5zr8LW1lKyPSK8tB2DL94a/RZ+M++ETAE/3ER9tpJyU01//nil
 yYzEMgXpFtiH/MKt/JH84OjSr9viV/bMEbs+gb9FOqoFYtRUZ4JUG3xwxlA6dpYX1b6T
 ZfCZsJhMS98D/2AYuWrleuikRet4yuOtuQP89XyxzFq6YpJEmt92Mh4Wr3ZX73xlNkW7 IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed4y9r67u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:10 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MILSaC028202;
        Tue, 22 Feb 2022 18:26:09 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed4y9r66u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:09 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MIPqV2018603;
        Tue, 22 Feb 2022 18:26:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3ear695417-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MIQ4D79830666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 18:26:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72F974C046;
        Tue, 22 Feb 2022 18:26:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 093404C040;
        Tue, 22 Feb 2022 18:26:04 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 18:26:03 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next 3/3] selftests/bpf: Adapt bpf_sk_lookup.remote_port loads
Date:   Tue, 22 Feb 2022 19:25:59 +0100
Message-Id: <20220222182559.2865596-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222182559.2865596-1-iii@linux.ibm.com>
References: <20220222182559.2865596-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TQtmwKYmbqt9iGyugfJu5sF_LHUYtgNW
X-Proofpoint-ORIG-GUID: 8l6qaOoFgvjKnEVVKAi1MliSSIVTjMRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_05,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

- Remove some remote_port tests that are not applicable to u16.
- Use remote_port_compat for backward compatibility tests.
- Add LSB/LSW backward compatibility tests.
- u32 load produces SRC_PORT on both little- and big-endian machines,
  so check just that.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/progs/test_sk_lookup.c        | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index bf5b7caefdd0..7106fedfd2cc 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -392,7 +392,7 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
 	int err, family;
-	__u32 val_u32;
+	__u32 *ptr_u32;
 	bool v4;
 
 	v4 = (ctx->family == AF_INET);
@@ -413,15 +413,20 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 
 	/* Narrow loads from remote_port field. Expect SRC_PORT. */
 	if (LSB(ctx->remote_port, 0) != ((SRC_PORT >> 0) & 0xff) ||
-	    LSB(ctx->remote_port, 1) != ((SRC_PORT >> 8) & 0xff) ||
-	    LSB(ctx->remote_port, 2) != 0 || LSB(ctx->remote_port, 3) != 0)
+	    LSB(ctx->remote_port, 1) != ((SRC_PORT >> 8) & 0xff))
 		return SK_DROP;
-	if (LSW(ctx->remote_port, 0) != SRC_PORT)
+	if (ctx->remote_port != SRC_PORT)
 		return SK_DROP;
 
 	/* Load from remote_port field with zero padding (backward compatibility) */
-	val_u32 = *(__u32 *)&ctx->remote_port;
-	if (val_u32 != bpf_htonl(bpf_ntohs(SRC_PORT) << 16))
+	ptr_u32 = &ctx->remote_port_compat;
+	if (LSB(*ptr_u32, 0) != ((SRC_PORT >> 0) & 0xff) ||
+	    LSB(*ptr_u32, 1) != ((SRC_PORT >> 8) & 0xff) ||
+	    LSB(*ptr_u32, 2) != 0 || LSB(*ptr_u32, 3) != 0)
+		return SK_DROP;
+	if (LSW(*ptr_u32, 0) != SRC_PORT || LSW(*ptr_u32, 1) != 0)
+		return SK_DROP;
+	if (*ptr_u32 != SRC_PORT)
 		return SK_DROP;
 
 	/* Narrow loads from local_port field. Expect DST_PORT. */
-- 
2.34.1

