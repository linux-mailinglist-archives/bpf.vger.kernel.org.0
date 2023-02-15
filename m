Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1BA6988FA
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 01:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBPAAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 19:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBOX77 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 18:59:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD4A2367F
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 15:59:59 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FMugIa024304;
        Wed, 15 Feb 2023 23:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=uF7JyQlI3Eog3HIg7abUsX4Vn4NK7l0Ji3M28Cs8uLE=;
 b=j/O2wVdXoM74DamlxttMLo4qBdxurcn4/iEQJEmgBPtacE9aBLDbFHTSDb2tgahxatj0
 79Ey6WZqf0t1CrykvOx1xI78AjmyP6K1g8uQUG8Ore+0VdUAd1Xvqco31zyNroi+XeGT
 3wHlsFw5brFnhNeMfEU6Bi6opSuesI/FZJgq3Pwjh5xBOY7VAxdlhaQUf/+7XBe0mhoe
 cjpObwy8sMVthyrTZyUyRX9T4x86DihpqJgf6tpsAucTxKLtmH7PQOD86b28mk2A08kG
 jN8SQvXE8fK174BT4/hzmpoWAJtw8zweCkti7nhUt++LSg6+3j55V+jYdy/mVY3prknV oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns8ms90w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:59:42 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FNuMMI028010;
        Wed, 15 Feb 2023 23:59:41 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns8ms90vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:59:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FBpVSH030092;
        Wed, 15 Feb 2023 23:59:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3np29fnyun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:59:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FNxYGG21496254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 23:59:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC5192004D;
        Wed, 15 Feb 2023 23:59:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1253220043;
        Wed, 15 Feb 2023 23:59:34 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.133])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 23:59:33 +0000 (GMT)
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
Subject: [PATCH RFC bpf-next v2 0/4] bpf: Support 64-bit pointers to kfuncs
Date:   Thu, 16 Feb 2023 00:59:27 +0100
Message-Id: <20230215235931.380197-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gq7yVn7mx5G1yrRDN9kYbJgiwTDLi87S
X-Proofpoint-ORIG-GUID: IPoqdMoNQiPcG8Zs5RoZ1jECNUi5CSGG
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_14,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=930 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150200
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v1: https://lore.kernel.org/bpf/20230214212809.242632-1-iii@linux.ibm.com/T/#t
v1 -> v2: Add BPF_HELPER_CALL (Stanislav).
          Add check_subprogs() cleanup - noticed while reviewing the
          code for BPF_HELPER_CALL.
          Drop WARN_ON_ONCE (Stanislav, Alexei).
          Add bpf_jit_get_func_addr() to x86_64 JIT.

Hi,

This series solves the problems outlined in [1, 2, 3]. The main problem
is that kfuncs in modules do not fit into bpf_insn.imm on s390x; the
secondary problem is that there is a conflict between "abstract" XDP
metadata function BTF ids and their "concrete" addresses.

The solution is to keep fkunc BTF ids in bpf_insn.imm, and put the
addresses into bpf_kfunc_desc, which does not have size restrictions.

Regtested with test_verifier and test_progs on x86_64 and s390x.
TODO: Need to add bpf_jit_get_func_addr() to arm, sparc and i386 JITs.

[1] https://lore.kernel.org/bpf/Y9%2FyrKZkBK6yzXp+@krava/
[2] https://lore.kernel.org/bpf/20230128000650.1516334-1-iii@linux.ibm.com/
[3] https://lore.kernel.org/bpf/20230128000650.1516334-32-iii@linux.ibm.com/

Best regards,
Ilya

Ilya Leoshkevich (4):
  bpf: Introduce BPF_HELPER_CALL
  bpf: Use BPF_HELPER_CALL in check_subprogs()
  bpf, x86: Use bpf_jit_get_func_addr()
  bpf: Support 64-bit pointers to kfuncs

 arch/x86/net/bpf_jit_comp.c    | 15 ++++--
 include/linux/bpf.h            |  2 +
 include/uapi/linux/bpf.h       |  4 ++
 kernel/bpf/core.c              | 21 ++++++--
 kernel/bpf/disasm.c            |  2 +-
 kernel/bpf/verifier.c          | 95 ++++++++++++----------------------
 tools/include/linux/filter.h   |  2 +-
 tools/include/uapi/linux/bpf.h |  4 ++
 8 files changed, 75 insertions(+), 70 deletions(-)

-- 
2.39.1

