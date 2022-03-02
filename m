Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942444C9A03
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 01:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbiCBAop convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 1 Mar 2022 19:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCBAop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 19:44:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B6A5EBC3
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 16:44:01 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 221GjMp0005235
        for <bpf@vger.kernel.org>; Tue, 1 Mar 2022 16:44:01 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ehgh4wxf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Mar 2022 16:44:01 -0800
Received: from twshared6457.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 16:44:00 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 17BA32B478458; Tue,  1 Mar 2022 16:43:50 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 0/2] fixes for bpf_prog_pack
Date:   Tue, 1 Mar 2022 16:43:37 -0800
Message-ID: <20220302004339.3932356-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: COqNqdD4txkcH6637RVjcK9Ahdth7UCb
X-Proofpoint-GUID: COqNqdD4txkcH6637RVjcK9Ahdth7UCb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 mlxlogscore=325 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 clxscore=1034 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020001
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

Two fixes for bpf_prog_pack.

Song Liu (2):
  x86: disable HAVE_ARCH_HUGE_VMALLOC on 32-bit x86
  bpf, x86: set header->size properly before freeing it

 arch/x86/Kconfig            | 2 +-
 arch/x86/net/bpf_jit_comp.c | 6 +++++-
 kernel/bpf/core.c           | 7 ++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

--
2.30.2
