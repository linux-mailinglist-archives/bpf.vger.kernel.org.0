Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA344F89E2
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 00:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiDGVql (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 17:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiDGVqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 17:46:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4555F10FD1
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 14:44:38 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237LOciG029858;
        Thu, 7 Apr 2022 21:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ml43Khri0WFgzys3dvBe6mBChJA2QIKJ18F4SaimRPQ=;
 b=q1SseCrIcC+RDFnlQgwNWQzb9Mr7QGXlbCufchR4roLIh26tm2MRzXd0UaZ4TFVV6aMK
 UhRzW9e8Kq1vmEf/G+QNpwQ1/fjiYUsX/u5dtXGTJZnRIeq2eynO859Q8CnNjMYe1CZU
 //JjaaczzbE7ssCuLUu2nZJm4VKpizv1e34IO+u1RpOkY0VR6CDuX2iegbsd7d8HPzN1
 5MnH0aniQQ3cE8FyyJjZtHTDI68Ftm/TARMXY0ubPkrjvimq0/+Do4t4dMPPC2r5st1d
 Qvp7QkgENtDHvcfT/6fakjZwQEYkeHCOrBI1Sd+aQeYGWpAoTW/iYrPIPv6Rwt0rEWU1 eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fa574bjry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:20 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 237LiJVo026177;
        Thu, 7 Apr 2022 21:44:19 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fa574bjrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:19 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 237LbaAS015454;
        Thu, 7 Apr 2022 21:44:17 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3f6e48rq0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 237LVtNj20054504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Apr 2022 21:31:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 829284C044;
        Thu,  7 Apr 2022 21:44:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DFDF4C046;
        Thu,  7 Apr 2022 21:44:14 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.82.41])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Apr 2022 21:44:13 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/3] libbpf: Make BPF-side of USDT support work on big-endian machines
Date:   Thu,  7 Apr 2022 23:44:10 +0200
Message-Id: <20220407214411.257260-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407214411.257260-1-iii@linux.ibm.com>
References: <20220407214411.257260-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7ccJMR_c2-sMPCJ-47uAoFH80GOvrPpC
X-Proofpoint-ORIG-GUID: RlGNTLA8D10473BXor3MheyiWWXKdrzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_05,2022-04-07_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF_USDT_ARG_REG_DEREF handling always reads 8 bytes, regardless of
the actual argument size. On little-endian the relevant argument bits
end up in the lower bits of val, and later on the code that handles
all the argument types expects them to be there.

On big-endian they end up in the upper bits of val, breaking that
expectation. Fix by right-shifting val on big-endian.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/usdt.bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 420d743734e1..881a2422a8ef 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -177,6 +177,9 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 		err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
 		if (err)
 			return err;
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		val >>= arg_spec->arg_bitshift;
+#endif
 		break;
 	default:
 		return -EINVAL;
-- 
2.35.1

