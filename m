Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2A4B3108
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 23:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353184AbiBKWuY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 11 Feb 2022 17:50:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353868AbiBKWuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 17:50:20 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B2AD62
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 14:50:18 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BLIgXv026446
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 14:50:17 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e5sug3q9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 14:50:17 -0800
Received: from twshared14630.35.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 14:50:16 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7A0BA10BC5291; Fri, 11 Feb 2022 14:50:11 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/2] Make BPF skeleton easier to use from C++ code
Date:   Fri, 11 Feb 2022 14:50:05 -0800
Message-ID: <20220211225007.2693813-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _3ck334NDXMjUSY1b5GxxbuGVIotYstH
X-Proofpoint-GUID: _3ck334NDXMjUSY1b5GxxbuGVIotYstH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=582
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202110115
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

Andrii Nakryiko (2):
  bpftool: add C++-specific open/load/etc skeleton wrappers
  selftests/bpf: add Skeleton templated wrapper as an example

 tools/bpf/bpftool/gen.c                  | 26 ++++++-
 tools/testing/selftests/bpf/test_cpp.cpp | 89 +++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 4 deletions(-)

-- 
2.30.2

