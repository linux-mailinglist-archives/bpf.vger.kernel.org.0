Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7179E6475D0
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 19:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLHS5Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 8 Dec 2022 13:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLHS5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 13:57:22 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6895684248
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 10:57:21 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8IZ4SB007674
        for <bpf@vger.kernel.org>; Thu, 8 Dec 2022 10:57:21 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mbaxjm4bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 10:57:21 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 10:57:20 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D0002231D999B; Thu,  8 Dec 2022 10:57:07 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        =?UTF-8?q?Per=20Sundstr=C3=B6m=20XP?= 
        <per.xp.sundstrom@ericsson.com>
Subject: [PATCH bpf-next 0/6] BTF-to-C dumper fixes and improvements
Date:   Thu, 8 Dec 2022 10:56:57 -0800
Message-ID: <20221208185703.2681797-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-GUID: b542cwoJMxhKTXmzkRJX2IijngQC3pqO
X-Proofpoint-ORIG-GUID: b542cwoJMxhKTXmzkRJX2IijngQC3pqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_11,2022-12-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix few tricky issues in libbpf's BTF-to-C converter, discovered thanks to
Per's reports and his randomized testing script.

Most notably there is a much improved and correct padding handling.  But also
it turned out that some corner cases with enums weren't handled correctly
(mode(byte) attribute was a new discovery for me). See respective patches for
more details.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Per Sundström XP <per.xp.sundstrom@ericsson.com>

Andrii Nakryiko (6):
  libbpf: fix single-line struct definition output in btf_dump
  libbpf: handle non-standardly sized enums better in BTF-to-C dumper
  selftests/bpf: add non-standardly sized enum tests for btf_dump
  libbpf: fix btf__align_of() by taking into account field offsets
  libbpf: fix BTF-to-C converter's padding logic
  selftests/bpf: add few corner cases to test padding handling of
    btf_dump

 tools/lib/bpf/btf.c                           |  13 ++
 tools/lib/bpf/btf_dump.c                      | 214 ++++++++++++++----
 .../bpf/progs/btf_dump_test_case_bitfields.c  |   2 +-
 .../bpf/progs/btf_dump_test_case_packing.c    |  61 ++++-
 .../bpf/progs/btf_dump_test_case_padding.c    | 146 ++++++++++--
 .../bpf/progs/btf_dump_test_case_syntax.c     |  36 +++
 6 files changed, 404 insertions(+), 68 deletions(-)

-- 
2.30.2

