Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498DA4A7B5D
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 23:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347969AbiBBW7j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Feb 2022 17:59:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33946 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242439AbiBBW7i (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 17:59:38 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212LkjEP019079
        for <bpf@vger.kernel.org>; Wed, 2 Feb 2022 14:59:38 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dyjy4p3bu-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 14:59:38 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:59:32 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 15B73103F6E34; Wed,  2 Feb 2022 14:59:20 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/6] Clean up leftover uses of deprecated APIs
Date:   Wed, 2 Feb 2022 14:59:10 -0800
Message-ID: <20220202225916.3313522-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mOggftRjfjLqNtpSbFFE51scYDvmX0a8
X-Proofpoint-GUID: mOggftRjfjLqNtpSbFFE51scYDvmX0a8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=773 malwarescore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202020125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Clean up remaining missed uses of deprecated libbpf APIs across samples/bpf,
selftests/bpf, libbpf, and bpftool.

Also fix uninit variable warning in bpftool.

Andrii Nakryiko (6):
  libbpf: stop using deprecated bpf_map__is_offload_neutral()
  bpftool: stop supporting BPF offload-enabled feature probing
  bpftool: fix uninit variable compilation warning
  selftests/bpf: remove usage of deprecated feature probing APIs
  selftests/bpf: redo the switch to new libbpf XDP APIs
  samples/bpf: get rid of bpf_prog_load_xattr() use

 samples/bpf/xdp1_user.c                       | 16 ++++++----
 samples/bpf/xdp_adjust_tail_user.c            | 17 +++++++----
 samples/bpf/xdp_fwd_user.c                    | 15 ++++++----
 samples/bpf/xdp_router_ipv4_user.c            | 17 ++++++-----
 samples/bpf/xdp_rxq_info_user.c               | 16 ++++++----
 samples/bpf/xdp_tx_iptunnel_user.c            | 17 ++++++-----
 tools/bpf/bpftool/common.c                    |  2 +-
 tools/bpf/bpftool/feature.c                   | 29 +++++++++++--------
 tools/lib/bpf/libbpf.c                        |  2 +-
 .../selftests/bpf/prog_tests/xdp_attach.c     | 29 +++++++++----------
 .../bpf/prog_tests/xdp_cpumap_attach.c        |  8 ++---
 .../bpf/prog_tests/xdp_devmap_attach.c        |  8 ++---
 .../selftests/bpf/prog_tests/xdp_info.c       | 14 ++++-----
 .../selftests/bpf/prog_tests/xdp_link.c       | 26 ++++++++---------
 tools/testing/selftests/bpf/test_maps.c       |  2 +-
 tools/testing/selftests/bpf/test_verifier.c   |  4 +--
 .../selftests/bpf/xdp_redirect_multi.c        |  8 ++---
 tools/testing/selftests/bpf/xdping.c          |  4 +--
 18 files changed, 132 insertions(+), 102 deletions(-)

-- 
2.30.2

