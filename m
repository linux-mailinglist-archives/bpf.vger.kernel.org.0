Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F472696FFD
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 22:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBNVod (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 16:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjBNVoc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 16:44:32 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8E029E3F
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 13:44:29 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EK7G84027903;
        Tue, 14 Feb 2023 21:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=/TwE0xZTKVZhkLdn4VycvoR+rgkqvMSLbvJPjaxKFoM=;
 b=DdPVGQaPOgEjQ9csEeW4Naypc3LfKnp4omsZeRfyaFqozNVZ4V52muOX5xAXl0MU792L
 FFqDY1+jDxh08HWOa63kb2Zn3shu2gOJFyXbJTxisIdT8tm5uv415ScnbpexrnMusVO5
 jBNvzhmo6qaPhHpVbGaI/lVaenDkdtZpd/7rVpQA80YZa5kdaBQPjjGW6xJVuSwjrtDw
 9vlDZOt2BGmpvge53ENA1geltSpTa7z6S58VEna+21YTrAPX3PoMCQA5QBYnbFClM9dv
 id6QutqjOLeEBhUAUONX9E6RYbnKCtDq84fA5zQPFdkAPahNhGGPTZL3XAwGE9ns1l8/ xg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrh2c2frw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:28:18 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31E0I7H4031205;
        Tue, 14 Feb 2023 21:28:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3np2n6bam1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:28:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31ELSCQG52756768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 21:28:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 619E02004B;
        Tue, 14 Feb 2023 21:28:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B08C720043;
        Tue, 14 Feb 2023 21:28:11 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.47.108])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 21:28:11 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next 0/1] bpf: Support 64-bit pointers to kfuncs
Date:   Tue, 14 Feb 2023 22:28:08 +0100
Message-Id: <20230214212809.242632-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZKNIFbIDyZWwIedzeRpwzxRX9CZjYOpy
X-Proofpoint-ORIG-GUID: ZKNIFbIDyZWwIedzeRpwzxRX9CZjYOpy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0 adultscore=0
 mlxlogscore=990 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140182
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

This is the first attempt to solve the problems outlined in [1, 2, 3].
The main problem is that kfuncs in modules do not fit into bpf_insn.imm
on s390x; the secondary problem is that there is a conflict between
"abstract" XDP metadata function BTF ids and their "concrete"
addresses.

The proposed solution is to keep fkunc BTF ids in bpf_insn.imm, and put
the addresses into bpf_kfunc_desc, which does not have size
restrictions.

Jiri and I discussed putting them into bpf_insn_aux_data, but at the
very beginning of the implementation it became clear that this struct
is freed at the end of verification and is not available during JITing.

I regtested this only on s390x, where it does not regress anything. If
this approach is fine (especially w.r.t. dev-bound kfuncs), I can check
the other arches.

[1] https://lore.kernel.org/bpf/Y9%2FyrKZkBK6yzXp+@krava/
[2] https://lore.kernel.org/bpf/20230128000650.1516334-1-iii@linux.ibm.com/
[3] https://lore.kernel.org/bpf/20230128000650.1516334-32-iii@linux.ibm.com/

Best regards,
Ilya

Ilya Leoshkevich (1):
  bpf: Support 64-bit pointers to kfuncs

 include/linux/bpf.h   |  2 ++
 kernel/bpf/core.c     | 23 ++++++++++---
 kernel/bpf/verifier.c | 79 +++++++++++++------------------------------
 3 files changed, 45 insertions(+), 59 deletions(-)

-- 
2.39.1

