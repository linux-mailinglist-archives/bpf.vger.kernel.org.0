Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5383B93B5
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhGAPMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 11:12:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4929 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232625AbhGAPMP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Jul 2021 11:12:15 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161F6BRq044774;
        Thu, 1 Jul 2021 11:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=emUGj6DJ1Og55PV16oW0zaaUTY5DEtf4p1ekcJZNYiM=;
 b=Wmz1RiM5fRdEZFoDJuJyUpgdRY065JurxkmdKRFsCGSFFD932SG01mVaKx1gGjypb0pt
 szQgDBDDoBwqg3i7uMuoFF31G37BJV5x3VBm3R1BMU6YyrfCr0zcGeX3/mqonblQ9J5Q
 fxlBOfhwmRrfxhix3owxWWA75LrQyxPymbZqM5BbqakLmQq0ml9m84Ztso9s4WAGaclE
 do5wOzaCbjHx7Cih9hUXDED4WP0rQBacWHCXriLJKxQ8A9hIs4fSz3XMGVwQjJgWULJT
 7kkZutjusRdpki0I9wQpV3DgE7iMA/n2rrLOwejIDWe+t//MWJgWV9+4LZEcGySrWhr+ aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hf9h9jyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:09:24 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 161F9Ou2065443;
        Thu, 1 Jul 2021 11:09:24 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hf9h9jxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:09:23 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161ErOUs020620;
        Thu, 1 Jul 2021 15:09:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 39duv8ha65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 15:09:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161F9JjY31130002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 15:09:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99E19AE874;
        Thu,  1 Jul 2021 15:09:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D4B3AE86B;
        Thu,  1 Jul 2021 15:09:15 +0000 (GMT)
Received: from naverao1-tp.in.ibm.com (unknown [9.85.115.110])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jul 2021 15:09:14 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Jackman <jackmanb@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 0/2] powerpc/bpf: Fix issue with atomic ops
Date:   Thu,  1 Jul 2021 20:38:57 +0530
Message-Id: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4YwvqNMIJ9Lohi2dqOfj4stLNMUnMWTf
X-Proofpoint-ORIG-GUID: WynGNAWE5fxhH5JZXWwYVP-m88UPNn66
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=974 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010092
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The first patch fixes an issue that causes a soft lockup on ppc64 with 
the BPF_ATOMIC bounds propagation verifier test. The second one updates 
ppc32 JIT to reject atomic operations properly.

- Naveen

Naveen N. Rao (2):
  powerpc/bpf: Fix detecting BPF atomic instructions
  powerpc/bpf: Reject atomic ops in ppc32 JIT

 arch/powerpc/net/bpf_jit_comp32.c | 14 +++++++++++---
 arch/powerpc/net/bpf_jit_comp64.c |  4 ++--
 2 files changed, 13 insertions(+), 5 deletions(-)


base-commit: 086d9878e1092e7e69a69676ee9ec792690abb1d
-- 
2.31.1

