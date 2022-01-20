Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463F449472D
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 07:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358761AbiATGOx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 01:14:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36858 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1358709AbiATGO3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 01:14:29 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20K5OhsH016447
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:14:28 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dq1jhg784-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:14:28 -0800
Received: from twshared21922.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 22:14:27 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 31DDEFBA125F; Wed, 19 Jan 2022 22:14:25 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/4] libbpf: streamline netlink-based XDP APIs
Date:   Wed, 19 Jan 2022 22:14:18 -0800
Message-ID: <20220120061422.2710637-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Fr3TxDOsCEwxUE_1DJ9ngmSBGudsvl1u
X-Proofpoint-GUID: Fr3TxDOsCEwxUE_1DJ9ngmSBGudsvl1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=733
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Revamp existing low-level XDP APIs provided by libbpf to follow more
consistent naming (new APIs follow bpf_tc_xxx() approach where it makes
sense) and be extensible without ABI breakages (OPTS-based). See patch #1 for
details, remaining patches switch bpftool, selftests/bpf and samples/bpf to
new APIs.

Andrii Nakryiko (4):
  libbpf: streamline low-level XDP APIs
  bpftool: use new API for attaching XDP program
  selftests/bpf: switch to new libbpf XDP APIs
  samples/bpf: adapt samples/bpf to bpf_xdp_xxx() APIs

 samples/bpf/xdp1_user.c                       |   8 +-
 samples/bpf/xdp_adjust_tail_user.c            |   8 +-
 samples/bpf/xdp_fwd_user.c                    |   4 +-
 samples/bpf/xdp_router_ipv4_user.c            |  10 +-
 samples/bpf/xdp_rxq_info_user.c               |   8 +-
 samples/bpf/xdp_sample_pkts_user.c            |   8 +-
 samples/bpf/xdp_sample_user.c                 |   9 +-
 samples/bpf/xdp_tx_iptunnel_user.c            |  10 +-
 samples/bpf/xdpsock_ctrl_proc.c               |   2 +-
 samples/bpf/xdpsock_user.c                    |  10 +-
 samples/bpf/xsk_fwd.c                         |   4 +-
 tools/bpf/bpftool/net.c                       |   2 +-
 tools/lib/bpf/libbpf.h                        |  29 +++++
 tools/lib/bpf/libbpf.map                      |   4 +
 tools/lib/bpf/netlink.c                       | 117 +++++++++++++-----
 .../selftests/bpf/prog_tests/xdp_attach.c     |  29 ++---
 .../bpf/prog_tests/xdp_cpumap_attach.c        |   8 +-
 .../bpf/prog_tests/xdp_devmap_attach.c        |   8 +-
 .../selftests/bpf/prog_tests/xdp_info.c       |  14 +--
 .../selftests/bpf/prog_tests/xdp_link.c       |  26 ++--
 .../selftests/bpf/xdp_redirect_multi.c        |   8 +-
 tools/testing/selftests/bpf/xdping.c          |   4 +-
 22 files changed, 205 insertions(+), 125 deletions(-)

-- 
2.30.2

