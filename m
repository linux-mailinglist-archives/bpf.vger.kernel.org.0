Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A61E57EB3E
	for <lists+bpf@lfdr.de>; Sat, 23 Jul 2022 04:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiGWCEY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 22:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiGWCET (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 22:04:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1DD97A11
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 19:04:18 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26N1htgr017295;
        Sat, 23 Jul 2022 02:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=VXP3NQkDKx9kX4ejevArcykzt49NPoMzs8nMgoiox30=;
 b=FY1ROaDSpZcexhYN1d11HqH684K13kTYJ5pFeQ9+VJHmvdf3uEdc2CgC4QENowWDFdxI
 XJ1LgmjzsOMahxs31zqzSywTVnqZqpreCAprLGOhMtWlMajM+YWB6dRicQ+cmRkuMhT0
 5RxTa/5gDEbElMhyaNXI2wEl3hpJpWLh1bbIhpo0l6HnMb6K/QUnz+qArI42fw1NcSDW
 3UkYLFVvCsXSyMogOn9416JxmHsa1Rf2SNXQRNf/jrA6h2StBhBPS50FUwm2/PaLgg9o
 z/XXPVyyDYIe5Av29RS2V9WEHQcVFMFYa3MXAW4qNH3a4dzXvwd9KYCxBxlW8N+vXoLQ Yg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hg7k5ravb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jul 2022 02:04:05 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26N1pMKE017017;
        Sat, 23 Jul 2022 02:04:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3hbmy8pr2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jul 2022 02:04:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26N23u2925231838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jul 2022 02:03:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8311AE051;
        Sat, 23 Jul 2022 02:03:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 511B5AE045;
        Sat, 23 Jul 2022 02:03:56 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.90.71])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 23 Jul 2022 02:03:56 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/2] Fix test_probe_user on s390x
Date:   Sat, 23 Jul 2022 04:03:42 +0200
Message-Id: <20220723020344.21699-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YB-N7GtTiscaHxoQcyRzasZ7cIOkiQpw
X-Proofpoint-GUID: YB-N7GtTiscaHxoQcyRzasZ7cIOkiQpw
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207230007
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

Ilya Leoshkevich (2):
  libbpf: Extend BPF_KSYSCALL documentation
  selftests/bpf: Attach to socketcall() in test_probe_user

 tools/lib/bpf/bpf_tracing.h                   | 14 +++++---
 .../selftests/bpf/prog_tests/probe_user.c     | 35 +++++++++++++------
 .../selftests/bpf/progs/test_probe_user.c     | 28 +++++++++++++--
 3 files changed, 60 insertions(+), 17 deletions(-)

-- 
2.35.3

