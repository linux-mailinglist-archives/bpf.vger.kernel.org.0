Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D247567A57
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 00:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiGEWuA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 5 Jul 2022 18:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiGEWtq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 18:49:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A11C121
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 15:48:38 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265JH2Pb006834
        for <bpf@vger.kernel.org>; Tue, 5 Jul 2022 15:48:38 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4uajsa72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 15:48:37 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 5 Jul 2022 15:48:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 55D8A1BF1EBEC; Tue,  5 Jul 2022 15:48:25 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/3] Fix few compiler warnings in selftests and libbpf
Date:   Tue, 5 Jul 2022 15:48:15 -0700
Message-ID: <20220705224818.4026623-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-GUID: peIj0Dg2gjQLWFMQAZ3okSDkt0m3HI6F
X-Proofpoint-ORIG-GUID: peIj0Dg2gjQLWFMQAZ3okSDkt0m3HI6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_18,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Few small patches fixing compiler warning issues detected by Coverity or by
building selftests in -O2 mode.

Andrii Nakryiko (3):
  selftests/bpf: fix bogus uninitialized variable warning
  selftests/bpf: fix few more compiler warnings
  libbpf: remove unnecessary usdt_rel_ip assignments

 tools/lib/bpf/usdt.c                                       | 6 ++----
 tools/testing/selftests/bpf/network_helpers.c              | 2 +-
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 4 ++--
 tools/testing/selftests/bpf/prog_tests/usdt.c              | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c      | 2 +-
 5 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.30.2

