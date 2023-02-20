Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B30969D16D
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 17:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjBTQid (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 11:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBTQic (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 11:38:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D5C9776
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 08:38:31 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KF9E51014218;
        Mon, 20 Feb 2023 16:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=q4BcUihlFYWp2t4uchiCFSrZonbFVS9h2hg0IhezUaU=;
 b=qGC56x0fAS8Rnzih28APl1cIASXugyMAihUBP7i0spZkYCB4HqAumun/Nwf/z1Rv/31K
 vZ4LmPGm0JlatvlGOO+ptoa2tZrL65Umd8ne+8EGmTb/MdoWRX3Vml5YfZAmDIXx6D4J
 7bsss0hsCgX1Yw3xP3Vr3IgbpXkbDCx8lwYwoWjiPRA3wGPy6ze5aTuv/3Z1JFtba808
 +qjVXkG4oGPRm/plhkqnnYTpmUJBMbJeQv9IHmUFYx/fnbIbZDyG4Q14rv24foanW5pr
 Xeqp6rR/ktHIkGV0VPknNBTBdbnfYy175sX/4RhB/j4dS8w4yHCgqjm0Ylhn3ciCWEZQ Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvb8jthn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 16:38:17 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31KFLE7I005608;
        Mon, 20 Feb 2023 16:38:17 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvb8jthma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 16:38:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KFJZXg016665;
        Mon, 20 Feb 2023 16:38:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6ax1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 16:38:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KGcAJ354854140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 16:38:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0BC020043;
        Mon, 20 Feb 2023 16:38:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57D3020040;
        Mon, 20 Feb 2023 16:38:10 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 16:38:10 +0000 (GMT)
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
Subject: [PATCH bpf-next] bpf: Check for helper calls in check_subprogs()
Date:   Mon, 20 Feb 2023 17:37:56 +0100
Message-Id: <20230220163756.753713-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: okbKbaz55HoIQFQuizkkegKDR0mI-ph6
X-Proofpoint-ORIG-GUID: b30GtEQ0KgnOAwNd8m5d27rUz29K1fwv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_13,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200151
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The condition src_reg != BPF_PSEUDO_CALL && imm == BPF_FUNC_tail_call
may be satisfied by a kfunc call. This would lead to unnecessarily
setting has_tail_call. Use src_reg == 0 instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e63af41a7e95..6d4632476c9c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2462,8 +2462,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		u8 code = insn[i].code;
 
 		if (code == (BPF_JMP | BPF_CALL) &&
-		    insn[i].imm == BPF_FUNC_tail_call &&
-		    insn[i].src_reg != BPF_PSEUDO_CALL)
+		    insn[i].src_reg == 0 &&
+		    insn[i].imm == BPF_FUNC_tail_call)
 			subprog[cur_subprog].has_tail_call = true;
 		if (BPF_CLASS(code) == BPF_LD &&
 		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
-- 
2.39.1

