Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE95B3FA7
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 21:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIITbT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 9 Sep 2022 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiIITbR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 15:31:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCFF9FD7
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 12:31:14 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289AUIJ8008078
        for <bpf@vger.kernel.org>; Fri, 9 Sep 2022 12:31:14 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jg3s43jc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 12:31:13 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 12:31:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 928931EB4F6EA; Fri,  9 Sep 2022 12:30:54 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/3] BPF mass-verification veristat tool
Date:   Fri, 9 Sep 2022 12:30:50 -0700
Message-ID: <20220909193053.577111-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KhoEnmthvo7ONaGyALqy6scasIn76o7x
X-Proofpoint-GUID: KhoEnmthvo7ONaGyALqy6scasIn76o7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a simple mass-verification and stats collection tool, veristat, to
selftests/bpf for use by everyone. See patch #3 for some more details.

Patch #1 fixes two BPF objects to be more usable with veristat.

Patch #2 fixes libbpf bug which also was discovered trying to mass-verify
a bunch of internal Meta BPF object files.

v1->v2:
  - fix obj leak (Kui-Feng);
  - fix Makefile deps (Daniel).

Andrii Nakryiko (3):
  selftests/bpf: fix test_verif_scale{1,3} SEC() annotations
  libbpf: fix crash if SEC("freplace") programs don't have
    attach_prog_fd set
  selftests/bpf: add veristat tool for mass-verifying BPF object files

 tools/lib/bpf/libbpf.c                        |  13 +-
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   7 +-
 .../selftests/bpf/progs/test_verif_scale1.c   |   2 +-
 .../selftests/bpf/progs/test_verif_scale3.c   |   2 +-
 tools/testing/selftests/bpf/veristat.c        | 537 ++++++++++++++++++
 6 files changed, 555 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/veristat.c

-- 
2.30.2

