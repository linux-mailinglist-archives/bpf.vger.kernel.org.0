Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379EA1653A5
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 01:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgBTAgP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 19 Feb 2020 19:36:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42402 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726731AbgBTAgP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Feb 2020 19:36:15 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01K0Oae8008526
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 16:36:13 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2y9dm30k0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 16:36:13 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 19 Feb 2020 16:36:12 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 235E5760B60; Wed, 19 Feb 2020 16:36:11 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: pull-request: bpf 2020-02-19
Date:   Wed, 19 Feb 2020 16:36:11 -0800
Message-ID: <20200220003611.34197-1-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_07:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=1
 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200001
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

We've added 10 non-merge commits during the last 10 day(s) which contain
a total of 10 files changed, 93 insertions(+), 31 deletions(-).

The main changes are:

1) batched bpf hashtab fixes from Brian and Yonghong.

2) various selftests and libbpf fixes.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Brian Vazquez, David Ahern, David Binderman, Hulk 
Robot, Jakub Kicinski, Jakub Sitnicki, Jonathan Lemon, Lorenz Bauer, 
Martin KaFai Lau, Maxim Mikityanskiy, Quentin Monnet, Ryan Goodfellow, 
Yonghong Song

----------------------------------------------------------------

The following changes since commit 00516d13d4cfa56ce39da144db2dbf08b09b9357:

  qmi_wwan: unconditionally reject 2 ep interfaces (2020-02-10 14:03:27 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to b9aff38de2cb166476988020428985c5f7412ffc:

  bpf: Fix a potential deadlock with bpf_map_do_batch (2020-02-19 16:01:25 -0800)

----------------------------------------------------------------
Brian Vazquez (1):
      bpf: Do not grab the bucket spinlock by default on htab batch ops

Hongbo Yao (1):
      bpf: Make btf_check_func_type_match() static

Jakub Sitnicki (1):
      selftests/bpf: Mark SYN cookie test skipped for UDP sockets

Johannes Krude (1):
      bpf, offload: Replace bitwise AND by logical AND in bpf_prog_offload_info_fill

John Fastabend (1):
      bpf: Selftests build error in sockmap_basic.c

Magnus Karlsson (1):
      xsk: Publish global consumer pointers when NAPI is finished

Martin KaFai Lau (1):
      selftests/bpf: Fix error checking on reading the tcp_fastopen sysctl

Toke Høiland-Jørgensen (2):
      bpf, uapi: Remove text about bpf_redirect_map() giving higher performance
      libbpf: Sanitise internal map names so they are not rejected by the kernel

Yonghong Song (1):
      bpf: Fix a potential deadlock with bpf_map_do_batch

 include/uapi/linux/bpf.h                           | 16 +++---
 kernel/bpf/btf.c                                   |  6 +--
 kernel/bpf/hashtab.c                               | 58 ++++++++++++++++++++--
 kernel/bpf/offload.c                               |  2 +-
 net/xdp/xsk.c                                      |  2 +
 net/xdp/xsk_queue.h                                |  3 +-
 tools/include/uapi/linux/bpf.h                     | 16 +++---
 tools/lib/bpf/libbpf.c                             |  8 ++-
 .../selftests/bpf/prog_tests/select_reuseport.c    |  8 ++-
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  5 ++
 10 files changed, 93 insertions(+), 31 deletions(-)
