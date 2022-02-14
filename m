Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA0B4B4DC5
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343635AbiBNLNv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:13:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350274AbiBNLNZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:13:25 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B645EA360
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 02:42:52 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E9MQsV031392;
        Mon, 14 Feb 2022 10:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iLAJlG8FaVBV8smwR6edAPEzNg+XPnb2S7khYUvw26A=;
 b=lZ4fUxUyAIR8/1rGzQqWrOIF0E4mtAxUvQdvQcXImz0Gmo3zShmEP2J9z1Jq6lqzNAuN
 DP48bEHvu5z5A4oRFIRkgkqK3xjtVmSbsMm8N1hmq1NFM00kwvkVenG7bqS2fB18J1T+
 YZ/dpBaa650wBJVuoGOUqUWagP4AtFILdQe9tyAqsrD3LedIWdlzK7pJuiYMR4bDsfX3
 eYOjUnykzUD6rEO3lXaCpp1GXUqxVe9Br45WzhY6Uil2sQAkTPfeusioPsiwVLqcaFs9
 PapgBppZ59pErP5yGhAAA0eDTjIzhO5lOFkiPD4yKLtiETqAr8o6wWELQpj/SlAbIuVr tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e6thxg82n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:26 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EAbwP6030010;
        Mon, 14 Feb 2022 10:42:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e6thxg81u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EAXXJw000919;
        Mon, 14 Feb 2022 10:42:24 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645jc36c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EAW10v35848666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:32:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 732BFAE053;
        Mon, 14 Feb 2022 10:42:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BAD7AE058;
        Mon, 14 Feb 2022 10:42:17 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.124.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 10:42:16 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <bpf@vger.kernel.org>
Subject: [PATCH powerpc/next 05/17] powerpc64/bpf: Use r12 for constant blinding
Date:   Mon, 14 Feb 2022 16:11:39 +0530
Message-Id: <e109f98617eacb4512c17a48525e94eda42889e6.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0QpUWiOGPIBfU5ZR1n02rz58kPxBUOvK
X-Proofpoint-ORIG-GUID: aOcz7zg4bn0UXylnR1suEORZUzUO2CSf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for preserving kernel toc in r2, switch BPF_REG_AX from
r2 to r12. r12 is not used by bpf JIT except during external helper/bpf
calls, or with BPF_NOSPEC. These sequences aren't emitted when
BPF_REG_AX is used for constant blinding and other purposes.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit64.h b/arch/powerpc/net/bpf_jit64.h
index b63b35e45e558c..82cdfee412784a 100644
--- a/arch/powerpc/net/bpf_jit64.h
+++ b/arch/powerpc/net/bpf_jit64.h
@@ -56,7 +56,7 @@ const int b2p[MAX_BPF_JIT_REG + 2] = {
 	/* frame pointer aka BPF_REG_10 */
 	[BPF_REG_FP] = 31,
 	/* eBPF jit internal registers */
-	[BPF_REG_AX] = 2,
+	[BPF_REG_AX] = 12,
 	[TMP_REG_1] = 9,
 	[TMP_REG_2] = 10
 };
-- 
2.35.1

