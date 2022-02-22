Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B224C0139
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiBVS0x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 13:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiBVS0w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 13:26:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD67CEB314
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 10:26:26 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MHQFOo001440;
        Tue, 22 Feb 2022 18:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=cLvDnjeNtCNLKH6yg3RwoFnnx7v+VqsJzhUNi1RP0Qo=;
 b=CuMRCv+BhDoK1CFXQLtkUSyA7VnaEC2VJR6/xkkeR9gRNa/bqO5rCjE9DuWKVRAxfzaP
 UDC4dLa4tRn3k5Qt3zF+DyLSkY1Zvv4S1Iw0IQQcoPSKj8p1F3uQXglRJHN4SjQjcZl/
 Favur27me8hUZZtxvkcWMX8oo4514crRQTGZlHB+oXtBBIaMtmKyMGAeMM4LWfsvgmd7
 k6UtlEecAHqC/2cZR7d5MrV2/FNcOoxPu+ignRXY3amxnjvEGm+O0biZnjDbadfga/4T
 UXm0wm/vK7ab+udiHjPIRcYAY9vbfO6mfA3CxQersQ6gK/yCxEHfpS8tPbl3UOmMyor7 lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed2pqvbfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:07 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MHiULV019473;
        Tue, 22 Feb 2022 18:26:06 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed2pqvbex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MIPp9f018591;
        Tue, 22 Feb 2022 18:26:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ear69540y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:05 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MIQ1FU50069814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 18:26:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE5E94C046;
        Tue, 22 Feb 2022 18:26:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A4434C044;
        Tue, 22 Feb 2022 18:26:01 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 18:26:01 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next 0/3] bpf_sk_lookup.remote_port fixes
Date:   Tue, 22 Feb 2022 19:25:56 +0100
Message-Id: <20220222182559.2865596-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I6rZK8MxFOG7L0WW8nKGXRKaDvX_zT1q
X-Proofpoint-GUID: T9IXDrqQLCpgvdB4YrPHKxu48KV_gMnG
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_05,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

These are my current patches for the discussion from [1] and [2].

With these changes tests pass on both x86_64 and s390x, but there are
quite a few things I'm not sure about, hence it's just an RFC:

- Can moving size < target_size check lead to incorrect shifts in some
  corner cases that I missed?

- Are different layouts of remote_port on little- and big-endian a bug
  or a feature? Do we want things to be this way? If not, are we bound
  by the ABI anyway?

- Is there any way to make uapi changes look nicer? A wall of nested
  structs, unions and ifdefs in an otherwise clean struct definition
  isn't looking particularly good.

- What is the Officially Approved way to access the remote_port field
  from C code? I'm leaning towards bpf_ntohs((__u16)remote_port), like
  in [3], and I adjusted the test accordingly.

[1] https://lore.kernel.org/bpf/CAEf4BzaRNLw9_EnaMo5e46CdEkzbJiVU3j9oxnsemBKjNFf3wQ@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20220221180358.169101-1-jakub@cloudflare.com/
[3] https://lore.kernel.org/bpf/20220113070245.791577-1-imagedong@tencent.com/

Ilya Leoshkevich (3):
  bpf: Fix certain narrow loads with offsets
  bpf: Fix bpf_sk_lookup.remote_port on big-endian
  selftests/bpf: Adapt bpf_sk_lookup.remote_port loads

 include/uapi/linux/bpf.h                        | 17 +++++++++++++++--
 kernel/bpf/verifier.c                           | 14 +++++++++-----
 net/core/filter.c                               |  5 ++---
 tools/include/uapi/linux/bpf.h                  | 17 +++++++++++++++--
 .../selftests/bpf/progs/test_sk_lookup.c        | 17 +++++++++++------
 5 files changed, 52 insertions(+), 18 deletions(-)

-- 
2.34.1

