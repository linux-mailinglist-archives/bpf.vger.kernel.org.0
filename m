Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21CB581455
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 15:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiGZNkc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 09:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbiGZNkb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 09:40:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FE613E1D
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 06:40:29 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QCH4ep003177;
        Tue, 26 Jul 2022 13:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=SisixK9x2uYCMv6JH6q2JgxopWTj+Fwpm6LsrSe4xCQ=;
 b=kAXPVt7cQHz32nb5cerV7H7Yp8rk2Wjb+j+XoWV6jCq2vdEFda45LHkvq2Ex0C5g29Ph
 cI6pP88HNhFQe/nVCYfMrKfnNMnimutM9usN7FwM7XYcOMiVqRaXGT6K8+6kIct0h6ab
 DDVximEQ2Fakr7aEYNegmxoFofBaKwlFcjB9V5LqMntVLxBu/Ef9MWkn70+dQbcje7V4
 e5nrgpaY22pJJhjBs+pWdb8+blu11il7kzoys6bkqkCDu6dA5ld+BB2k78KruBNp/ZXg
 e6bcI3f2+6Gr5JZ5MSqxCCEcVoUkyeqAkWSDdRv+c7ws8w0TcPFzm9m3EFVgURwa0CkL xQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjg4wata9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 13:40:14 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26QDLSm9001575;
        Tue, 26 Jul 2022 13:40:13 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3hg946bu23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 13:40:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26QDe9mv11600254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 13:40:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B633DA405F;
        Tue, 26 Jul 2022 13:40:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 472D4A4060;
        Tue, 26 Jul 2022 13:40:09 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.20.53])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jul 2022 13:40:09 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 0/2] Fix test_probe_user on s390x
Date:   Tue, 26 Jul 2022 15:40:06 +0200
Message-Id: <20220726134008.256968-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rZCjLdjQZhfaajiof9_h1g1x8r9rO9gF
X-Proofpoint-GUID: rZCjLdjQZhfaajiof9_h1g1x8r9rO9gF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207260051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

This is a fix for [1]: test_probe_user fails on s390x, because it hooks
only connect(), but not socketcall(SYS_CONNECT).

Patch 1 adds this quirk to BPF_KSYSCALL documentation.
Patch 2 fixes the test by attaching a prog to socketcall().

Best regards,
Ilya

[1] https://lore.kernel.org/bpf/06631b122b9bd6258139a36b971bba3e79543503.camel@linux.ibm.com/

v1: https://lore.kernel.org/bpf/20220723020344.21699-1-iii@linux.ibm.com/
v1 -> v2: Add CONFIG_ prefix to CLONE_BACKWARDS* symbols (Jiri).
          Change the type of prog_names to make checkpatch happy.
          Use prog_count everywhere (Jiri).
          #ifdef out handle_sys_socketcall() on non-s390x (Jiri).

Ilya Leoshkevich (2):
  libbpf: Extend BPF_KSYSCALL documentation
  selftests/bpf: Attach to socketcall() in test_probe_user

 tools/lib/bpf/bpf_tracing.h                   | 15 +++++---
 .../selftests/bpf/prog_tests/probe_user.c     | 35 +++++++++++++------
 .../selftests/bpf/progs/test_probe_user.c     | 32 +++++++++++++++--
 3 files changed, 65 insertions(+), 17 deletions(-)

-- 
2.35.3

