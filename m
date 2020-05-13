Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0015F1D1CD4
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390036AbgEMSCT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 14:02:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20496 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390035AbgEMSCS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 14:02:18 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DI0uWh000834
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 11:02:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=w5rk5SHOPjhrSefM3UGYa/4MBtDsHwmfu0pN+QrAjd0=;
 b=Ug81gI6pgQxUO8nb8Tl6nvgkHSSsH8P7Y4zPCSnpqYBoqfbFkLuRiUQWsMdG53ZrP2gY
 NMmvEsC2M4fevJEfBoK5ccr1DqPulVcrfXYbfLjIIf6S1bZabDrbxtsxPgB8YNbYkyVu
 8+mxrwjYSXZGtc5jj0PtprrFVhkzP/zU2yk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100y1pdyw-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 11:02:18 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 11:02:17 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7E50337009B0; Wed, 13 May 2020 11:02:15 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 0/7] bpf: misc fixes for bpf_iter
Date:   Wed, 13 May 2020 11:02:15 -0700
Message-ID: <20200513180215.2949164-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_08:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=660 clxscore=1015
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130153
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit ae24345da54e ("bpf: Implement an interface to register
bpf_iter targets") and its subsequent commits in the same patch set
introduced bpf iterator, a way to run bpf program when iterating
kernel data structures.

This patch set addressed some followup issues. One big change
is to allow target to pass ctx arg register types to verifier
for verification purpose. Please see individual patch for details.

Changelogs:
  v1 -> v2:
    . add "const" qualifier to struct bpf_iter_reg for
      bpf_iter_[un]reg_target, and this results in
      additional "const" qualifiers in some other places
    . drop the patch which will issue WARN_ONCE if
      seq_ops->show() returns a positive value.
      If this does happen, code review should spot
      this or author does know what he is doing.
      In the future, we do want to implement a
      mechanism to find out all registered targets
      so we will be aware of new additions.

Yonghong Song (7):
  tools/bpf: selftests : explain bpf_iter test failures with llvm 10.0.0
  bpf: change btf_iter func proto prefix to "bpf_iter_"
  bpf: add comments to interpret bpf_prog return values
  bpf: net: refactor bpf_iter target registration
  bpf: change func bpf_iter_unreg_target() signature
  bpf: enable bpf_iter targets registering ctx argument types
  samples/bpf: remove compiler warnings

 include/linux/bpf.h                    | 22 ++++++++----
 include/net/ip6_fib.h                  |  7 ++++
 kernel/bpf/bpf_iter.c                  | 49 +++++++++++++++-----------
 kernel/bpf/btf.c                       | 15 +++++---
 kernel/bpf/map_iter.c                  | 23 +++++++-----
 kernel/bpf/task_iter.c                 | 42 ++++++++++++++--------
 kernel/bpf/verifier.c                  |  1 -
 net/ipv6/ip6_fib.c                     |  5 ---
 net/ipv6/route.c                       | 25 +++++++------
 net/netlink/af_netlink.c               | 23 +++++++-----
 samples/bpf/offwaketime_kern.c         |  4 +--
 samples/bpf/sockex2_kern.c             |  4 +--
 samples/bpf/sockex3_kern.c             |  4 +--
 tools/lib/bpf/libbpf.c                 |  2 +-
 tools/testing/selftests/bpf/README.rst | 43 ++++++++++++++++++++++
 15 files changed, 183 insertions(+), 86 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/README.rst

--=20
2.24.1

