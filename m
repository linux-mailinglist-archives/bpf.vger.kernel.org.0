Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C64F890E
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 00:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiDGVqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiDGVql (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 17:46:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585F8FC11C
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 14:44:39 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237Jftxs009645;
        Thu, 7 Apr 2022 21:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PmldemmIhKeCaeKqJ+C0I4fwtpukmmFsTUQbSe6iLxM=;
 b=rjfsG4FlNU0xLpPEbsOwgNJVwLKjD5OXkjNWzY75QlrL+dP0AGlUyS13PxIn2Spj2Xp2
 P3WSl73Ji/bqCpEIVUjym3Hex3p3tcNvOcUdg1wAX0ZU5RM6xvizFXg32SBGQUJ3DshP
 9u+xD9iRVfZGWxUIHytilg+XSw6MqpwdknQciYmuvY6+zAcHA7qBJcSitiXytbl8oj4H
 +ajeoGqYiKrzYseBCS9XemHB2TwXmX6cq1ld/Fjw1EEVmp/ACYlWvrAoiVMdB5Ik1Ltb
 78R3XMMNV6OJt30Hx4sWG+hMXk4feBX6p592btlIO3f3PlGjjeKmgrMVIbSkMp7MQJoG 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fa6bat6dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:20 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 237LQSqG008679;
        Thu, 7 Apr 2022 21:44:20 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fa6bat6de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:19 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 237Lbfkf008028;
        Thu, 7 Apr 2022 21:44:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3f6e490ptj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:18 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 237LiFBp38142222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Apr 2022 21:44:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BAA64C04A;
        Thu,  7 Apr 2022 21:44:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95A394C046;
        Thu,  7 Apr 2022 21:44:14 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.82.41])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Apr 2022 21:44:14 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] libbpf: Add s390-specific USDT arg spec parsing logic
Date:   Thu,  7 Apr 2022 23:44:11 +0200
Message-Id: <20220407214411.257260-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407214411.257260-1-iii@linux.ibm.com>
References: <20220407214411.257260-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3uilT9oSSVuWgGu5dXJZX1EwtIsbk3I5
X-Proofpoint-GUID: d8Ofj6lw77yMFy5R496bvVaQo62MLeNj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_05,2022-04-07_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

The logic is superficially similar to that of x86, but the small
differences (no need for register table and dynamic allocation of
register names, no $ sign before constants) make maintaining a common
implementation too burdensome. Therefore simply add a s390x-specific
version of parse_usdt_arg().

Note that while bcc supports index registers, this patch does not. This
should not be a problem in most cases, since s390 uses a default value
"nor" for STAP_SDT_ARG_CONSTRAINT.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/usdt.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 99a7c614c7b1..da145724e8c0 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -1269,6 +1269,63 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 	return len;
 }
 
+#elif defined(__s390x__)
+
+/* Do not support __s390__ for now, since user_pt_regs is broken with -m31. */
+
+static int parse_usdt_arg(const char *arg_str, int arg_num,
+			  struct usdt_arg_spec *arg)
+{
+	unsigned int reg;
+	int sz, len;
+	long off;
+
+	if (sscanf(arg_str, " %d @ %ld ( %%r%u ) %n", &sz, &off, &reg, &len) == 3) {
+		/* Memory dereference case, e.g., -2@-28(%r15) */
+		arg->arg_type = USDT_ARG_REG_DEREF;
+		arg->val_off = off;
+		if (reg > 15) {
+			pr_warn("usdt: unrecognized register '%%r%u'\n", reg);
+			return -EINVAL;
+		}
+		arg->reg_off = offsetof(user_pt_regs, gprs[reg]);
+	} else if (sscanf(arg_str, " %d @ %%r%u %n", &sz, &reg, &len) == 2) {
+		/* Register read case, e.g., -8@%r0 */
+		arg->arg_type = USDT_ARG_REG;
+		arg->val_off = 0;
+		if (reg > 15) {
+			pr_warn("usdt: unrecognized register '%%r%u'\n", reg);
+			return -EINVAL;
+		}
+		arg->reg_off = offsetof(user_pt_regs, gprs[reg]);
+	} else if (sscanf(arg_str, " %d @ %ld %n", &sz, &off, &len) == 2) {
+		/* Constant value case, e.g., 4@71 */
+		arg->arg_type = USDT_ARG_CONST;
+		arg->val_off = off;
+		arg->reg_off = -1;
+	} else {
+		pr_warn("usdt: unrecognized arg #%d spec '%s'\n", arg_num,
+			arg_str);
+		return -EINVAL;
+	}
+
+	arg->arg_signed = sz < 0;
+	if (sz < 0)
+		sz = -sz;
+
+	switch (sz) {
+	case 1: case 2: case 4: case 8:
+		arg->arg_bitshift = 64 - sz * 8;
+		break;
+	default:
+		pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d\n",
+			arg_num, arg_str, sz);
+		return -EINVAL;
+	}
+
+	return len;
+}
+
 #else
 
 static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
-- 
2.35.1

