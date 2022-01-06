Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4B4863DE
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 12:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiAFLqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 06:46:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238456AbiAFLqw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 06:46:52 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206AaZLI013742;
        Thu, 6 Jan 2022 11:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6PaxeNEWRq8q0ZODF7HaiF9yWPyun62jz4eAHSmUxK4=;
 b=gIPE4WZ9iutkAxa3U5JIZbFyCWsGsVKT19PRjyo++dOl4+1xqnYYF8rBlOck8Zs0QH/3
 CYEQGjb80zd70ma/GZWgXUcPusNDf0qgtSQpFweUwDitEgblra10RNoh7t6KUITQtiDG
 khkkgfIXNMsBagmmV5YaIfieS+GsEoQgazJoKg4o80PsdNCTQNOy27rjlQRl0O/S+2G0
 JlKrqnLgsLjWkHaMz4pbWWM/y4ph8vTuD4NHVRgByFW7RYOyaywul+3kqGuyIm5qn1hK
 luHzIotv9rwE68dIKqSXO73wGvHxvUNmIC97E0QRjKU4wF7QD0/vkxniuzB0Su08lh55 rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddtq3wcuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:34 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 206BkXpA005019;
        Thu, 6 Jan 2022 11:46:33 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddtq3wcu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:33 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 206Bg43I026571;
        Thu, 6 Jan 2022 11:46:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3ddn4e4mqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 206BkSxX43975142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 11:46:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D321A4066;
        Thu,  6 Jan 2022 11:46:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F88FA405F;
        Thu,  6 Jan 2022 11:46:25 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.91.118])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 11:46:24 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 10/13] powerpc64/bpf: Use r12 for constant blinding
Date:   Thu,  6 Jan 2022 17:15:14 +0530
Message-Id: <089ae2bcf57e79402e83259020531b85f14ea93f.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g22QD1SQ7MRR27y6xgx8ww_G0-2dALxq
X-Proofpoint-GUID: HwK4iWF2MhRfPQxkh55P8HUZYCUqLPBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_04,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=811 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060081
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
2.34.1

