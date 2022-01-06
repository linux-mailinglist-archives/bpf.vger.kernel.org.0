Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4C4863D4
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 12:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiAFLqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 06:46:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231423AbiAFLqY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 06:46:24 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206AaZ17013829;
        Thu, 6 Jan 2022 11:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K2QMoGFuSpFKeZJByjm2VO7QK0NA81oticGuC7WKtf8=;
 b=oCxhEEdMf46sRIsX4W5qDn0iT91AXiqqOGGjLDsfqleTbECFyJg3e2YvpzTQVHFMGNqA
 4itOWNEY0afdXfzbOUmKWA1NqhaYOL/M/onz8mssJ9zm6MBwuuTxqM33rKBRj05bz4vb
 qmObt4oXE81IDUxiy79Xj1n3tQx1xZxhjca2lz2fSxKRtmhoXsY8erEaoKiP2q95rqsd
 XUCaBrQHd9uKx15yHml54KSvcf3rv9eZPkaO2nWTHzRDbfNMc+0Fh2gE3plsTAqE+ns1
 FK3qh/K3cJmoKDGVWjnMQExkeE3zNdIQBnzXc2x6RffRvDrBqMB4JajouOgcBBFOrpMO +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddtq3wcm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:03 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 206BjDjh001658;
        Thu, 6 Jan 2022 11:46:03 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddtq3wckg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 206BhoJf024824;
        Thu, 6 Jan 2022 11:46:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ddmsvmrg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 206BjvEs48169366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 11:45:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98A7FA405C;
        Thu,  6 Jan 2022 11:45:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC62FA405B;
        Thu,  6 Jan 2022 11:45:54 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.91.118])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 11:45:54 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 01/13] bpf: Guard against accessing NULL pt_regs in bpf_get_task_stack()
Date:   Thu,  6 Jan 2022 17:15:05 +0530
Message-Id: <d5ef83c361cc255494afd15ff1b4fb02a36e1dcf.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6y-OC_0Y1bcVEydTLOOM2NVONqN3MqnT
X-Proofpoint-GUID: H1FYQmXokP83cgF464Gseesfg6-TRJ8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_04,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

task_pt_regs() can return NULL on powerpc for kernel threads. This is
then used in __bpf_get_stack() to check for user mode, resulting in a
kernel oops. Guard against this by checking return value of
task_pt_regs() before trying to obtain the call chain.

Fixes: fa28dcb82a38f8 ("bpf: Introduce helper bpf_get_task_stack()")
Cc: stable@vger.kernel.org # v5.9+
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/bpf/stackmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 6e75bbee39f0b5..0dcaed4d3f4cec 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -525,13 +525,14 @@ BPF_CALL_4(bpf_get_task_stack, struct task_struct *, task, void *, buf,
 	   u32, size, u64, flags)
 {
 	struct pt_regs *regs;
-	long res;
+	long res = -EINVAL;
 
 	if (!try_get_task_stack(task))
 		return -EFAULT;
 
 	regs = task_pt_regs(task);
-	res = __bpf_get_stack(regs, task, NULL, buf, size, flags);
+	if (regs)
+		res = __bpf_get_stack(regs, task, NULL, buf, size, flags);
 	put_task_stack(task);
 
 	return res;
-- 
2.34.1

