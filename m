Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B816988FC
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 01:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBPAAE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 19:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBPAAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 19:00:03 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275DF2367F
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 16:00:02 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FNRsH7040790;
        Wed, 15 Feb 2023 23:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ssh06jHI/W4UbN3bWhFwOv+st9MMIopyxBcM/oVcVJ0=;
 b=hx93inkzKVbF/hb1bYGm5JC1854G0tv2ewSVlIvbBh5GWc/uuSnvWdnUEnJcz+BV1ZGn
 RC5MkJdpklnowiGNhIi+aeWMW6iMhT29gShLKgSf4qmCgiqgbTGZGM/GqyaDOwb6+EYd
 CXblqSFxMPDZI06g55+JawrwwmxranzQZqaYhxfp5ry62iT2Z/rHewwvQOEotF1WMTte
 jTQnfKYsOEgvJaGwsjg5J0+W+Hn1NgMsQZUtNyVoERpgXbl4fdt096l/EdPm5fL10+Xq
 b5CBKCYX1ig1YmzOAqr0p/LjOPUAIz1yggZWkgAvQlY0TZ5cU1vXWl2ep+4x/htthSIo /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns93e0epe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:59:43 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FNqZZ8025769;
        Wed, 15 Feb 2023 23:59:42 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns93e0ep5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:59:42 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FBmXsI031293;
        Wed, 15 Feb 2023 23:59:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3np29fcd8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:59:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FNxbjv47513970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 23:59:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60A1F20043;
        Wed, 15 Feb 2023 23:59:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE3F320040;
        Wed, 15 Feb 2023 23:59:36 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.133])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 23:59:36 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next v2 2/4] bpf: Use BPF_HELPER_CALL in check_subprogs()
Date:   Thu, 16 Feb 2023 00:59:29 +0100
Message-Id: <20230215235931.380197-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215235931.380197-1-iii@linux.ibm.com>
References: <20230215235931.380197-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U7S_MCG5J5d6Dtg2XAbthNJg2YRTCP3F
X-Proofpoint-ORIG-GUID: TaWFd0ndyVS4mK7h2bG-NrQdzkVtPXUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_14,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150200
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The condition src_reg != BPF_PSEUDO_CALL && imm == BPF_FUNC_tail_call
may be satisfied by a kfunc call. This would lead to unnecessarily
setting has_tail_call. Use src_reg == BPF_HELPER_CALL instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 427525fc3791..71158a6786a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2475,8 +2475,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		u8 code = insn[i].code;
 
 		if (code == (BPF_JMP | BPF_CALL) &&
-		    insn[i].imm == BPF_FUNC_tail_call &&
-		    insn[i].src_reg != BPF_PSEUDO_CALL)
+		    insn[i].src_reg == BPF_HELPER_CALL &&
+		    insn[i].imm == BPF_FUNC_tail_call)
 			subprog[cur_subprog].has_tail_call = true;
 		if (BPF_CLASS(code) == BPF_LD &&
 		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
-- 
2.39.1

