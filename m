Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DCA4B3357
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 06:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiBLF5s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 12 Feb 2022 00:57:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiBLF5r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 00:57:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C2528E3E
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:57:44 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BLIhHh030151
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:57:44 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e5sv74qq3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:57:44 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 21:57:43 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3106010BF5C60; Fri, 11 Feb 2022 21:57:34 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/2] Make BPF skeleton easier to use from C++ code
Date:   Fri, 11 Feb 2022 21:57:31 -0800
Message-ID: <20220212055733.539056-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bV7YFHYxqm-QuAwsj0ADnYb-9CdJHvoc
X-Proofpoint-ORIG-GUID: bV7YFHYxqm-QuAwsj0ADnYb-9CdJHvoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-12_02,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=566 clxscore=1034
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202120034
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add minimal C++-specific additions to BPF skeleton codegen to facilitate
easier use of C skeletons in C++ applications. These additions don't add any
extra ongoing maintenance and allows C++ users to fit pure C skeleton better
into their C++ code base. All that without the need to design, implement and
support a separate C++ BPF skeleton implementation.

v1->v2:
  - use default argument values in T::open() (Alexei).

Andrii Nakryiko (2):
  bpftool: add C++-specific open/load/etc skeleton wrappers
  selftests/bpf: add Skeleton templated wrapper as an example

 tools/bpf/bpftool/gen.c                  | 24 ++++++-
 tools/testing/selftests/bpf/test_cpp.cpp | 87 +++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 4 deletions(-)

-- 
2.30.2

