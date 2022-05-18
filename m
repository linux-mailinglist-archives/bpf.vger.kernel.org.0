Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96C52C2F5
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 21:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbiERS7Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 18 May 2022 14:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbiERS7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 14:59:23 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF35230218
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:22 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IHDbkT020737
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:21 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4ap6ud31-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:21 -0700
Received: from twshared18213.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 11:59:20 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 58AE11A12C538; Wed, 18 May 2022 11:59:16 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/3] Start libbpf 1.0 dev cycle
Date:   Wed, 18 May 2022 11:59:12 -0700
Message-ID: <20220518185915.3529475-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HwpalC9jfbJMCdzXAQ6AgS5fgbWBh6hO
X-Proofpoint-ORIG-GUID: HwpalC9jfbJMCdzXAQ6AgS5fgbWBh6hO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Start preparations for libbpf 1.0 release and as a first test remove
bpf_create_map*() APIs.

Andrii Nakryiko (3):
  libbpf: fix up global symbol counting logic
  libbpf: start 1.0 development cycle
  libbpf: remove bpf_create_map*() APIs

 tools/lib/bpf/Makefile         |  2 +-
 tools/lib/bpf/bpf.c            | 80 ----------------------------------
 tools/lib/bpf/bpf.h            | 42 ------------------
 tools/lib/bpf/libbpf.map       |  4 ++
 tools/lib/bpf/libbpf_version.h |  4 +-
 5 files changed, 7 insertions(+), 125 deletions(-)

-- 
2.30.2

