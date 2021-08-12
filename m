Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC53EA763
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 17:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbhHLPS4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 11:18:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237941AbhHLPS4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Aug 2021 11:18:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CF3tVd099242;
        Thu, 12 Aug 2021 11:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=oEN+JbesSF9piPctlM8wApI71j5wvHwKavBHBckAPWY=;
 b=A52XnyLIlOpIoMM6EP3M/sDLFNWb/ufkDZ+JKB2vgcqysLUcnorqidO0+XZZ9V9CRXBj
 wGUePxocGA1bnMRBgiA1e9xLAgKqTbkN4ZN8tsP/etLhZJhulR45e1DvzBzY/ZHtXM3O
 SnlrZwOb8MKIjErZAQuWiMWebc8SqSu27a2EiFSaynWi0JI0P3IYipeemK+jp4u5IFb/
 BNkU7InlwwL+Jtl6TUpWOwI3L7z7L7gMDJFU/62fhId1lBUpxFQVZF8PuGkyQgJtXUKC
 4agea1WlPKj0tzibC4GICgwSb6UhedYRjjtA4vR+zuosK4PwRduaa7cOlwDqCcATdIIH wg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3acgg83g3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 11:18:17 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CFDM8c030559;
        Thu, 12 Aug 2021 15:18:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3acf0ktndf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 15:18:16 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CFIC2f55116258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 15:18:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81FDAA4066;
        Thu, 12 Aug 2021 15:18:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EE77A405C;
        Thu, 12 Aug 2021 15:18:12 +0000 (GMT)
Received: from vm.lan (unknown [9.145.77.113])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 15:18:12 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf v3 0/2] selftests: bpf: test that dead ldx_w insns are accepted
Date:   Thu, 12 Aug 2021 17:18:09 +0200
Message-Id: <20210812151811.184086-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nmhFjL9PWrOcqxHF_RA8dWAeleyeH6rk
X-Proofpoint-ORIG-GUID: nmhFjL9PWrOcqxHF_RA8dWAeleyeH6rk
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_05:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120098
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the "verifier bug. zext_dst is set, but no reg is defined" failure
in the "access skb fields ok" test on s390.

Patch 1 is the fix, patch 2 adds a test.

v2: https://lore.kernel.org/bpf/20210812140518.183178-1-iii@linux.ibm.com/
v2 -> v3: Make sure that the test fails in absence of the fix.

v1: https://lore.kernel.org/bpf/20210812111220.181824-1-iii@linux.ibm.com/
v1 -> v2: Rebase to bpf branch, add Fixes:, add a test (Daniel).

Ilya Leoshkevich (2):
  bpf: clear zext_dst of dead insns
  selftests: bpf: test that dead ldx_w insns are accepted

 kernel/bpf/verifier.c                            |  1 +
 tools/testing/selftests/bpf/verifier/dead_code.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

-- 
2.31.1

