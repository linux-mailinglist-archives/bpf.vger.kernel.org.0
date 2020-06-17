Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A121FD6EC
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 23:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgFQVQS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 17:16:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20699 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbgFQVQR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Jun 2020 17:16:17 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HLG5PD024498
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 14:16:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=UJYI0QLyDJDdjykKMkoh/W5NWn4PRirekMHEjUEHQXQ=;
 b=i09Xb0Cl2iSrNbHy/vNud6wP2Qes3RlTzoQayT3YqunTFD9LxMsucdDZqaDSm0lBynnf
 keq07MBaMFdcgXiFZnjXGX8t5s4GOIYyKDJ3z4obaWtNpTI4ykzYng01WSMRvZkLVzCi
 2sjT81Tzh71G9xWjhFOW+K4EfBmvBqEW6Ow= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q653g1m7-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 14:16:16 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 14:15:38 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id CD55D3704EF2; Wed, 17 Jun 2020 14:15:36 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 00/13] implement bpf iterator for tcp and udp sockets
Date:   Wed, 17 Jun 2020 14:15:36 -0700
Message-ID: <20200617211536.1854348-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_11:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170159
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf iterator implments traversal of kernel data structures and these
data structures are passed to a bpf program for processing.
This gives great flexibility for users to examine kernel data
structure without using e.g. /proc/net which has limited and
fixed format.

Commit 138d0be35b14 ("net: bpf: Add netlink and ipv6_route bpf_iter targe=
ts")
implemented bpf iterators for netlink and ipv6_route.
This patch set intends to implement bpf iterators for tcp and udp.

Currently, /proc/net/tcp is used to print tcp4 stats and /proc/net/tcp6
is used to print tcp6 stats. /proc/net/udp[6] have similar usage model.
In contrast, only one tcp iterator is implemented and it is bpf program
resposibility to filter based on socket family. The same is for udp.
This will avoid another unnecessary traversal pass if users want
to check both tcp4 and tcp6.

Several helpers are also implemented in this patch
  bpf_skc_to_{tcp, tcp6, tcp_timewait, tcp_request, udp6}_sock
The argument for these helpers is not a fixed btf_id. For example,
  bpf_skc_to_tcp(struct sock_common *), or
  bpf_skc_to_tcp(struct sock *), or
  bpf_skc_to_tcp(struct inet_sock *), ...
are all valid. At runtime, the helper will check whether pointer cast
is legal or not. Please see Patch #5 for details.

Since btf_id's for both arguments and return value are known at
build time, the btf_id's are pre-computed once vmlinux btf becomes
valid. Jiri's "adding d_path helper" patch set
  https://lore.kernel.org/bpf/20200616100512.2168860-1-jolsa@kernel.org/T=
/
provides a way to pre-compute btf id during vmlinux build time.
This can be applied here as well. A followup patch can convert
to build time btf id computation after Jiri's patch landed.

Yonghong Song (13):
  bpf: add bpf_seq_afinfo in tcp_iter_state
  net: bpf: implement bpf iterator for tcp
  bpf: support 'X' in bpf_seq_printf() helper
  bpf: allow tracing programs to use bpf_jiffies64() helper
  bpf: add bpf_skc_to_tcp6_sock() helper
  bpf: add bpf_skc_to_{tcp,tcp_timewait,tcp_request}_sock() helpers
  bpf: add bpf_seq_afinfo in udp_iter_state
  net: bpf: implement bpf iterator for udp
  bpf: add bpf_skc_to_udp6_sock() helper
  bpf/selftests: move newer bpf_iter_* type redefining to a new header
    file
  tools/bpf: selftests: implement sample tcp/tcp6 bpf_iter programs
  tools/bpf: add udp4/udp6 bpf iterator
  bpf/selftests: add tcp/udp iterator programs to selftests

 include/linux/bpf.h                           |  14 +
 include/net/tcp.h                             |   1 +
 include/net/udp.h                             |   1 +
 include/uapi/linux/bpf.h                      |  37 ++-
 kernel/bpf/btf.c                              |  11 +
 kernel/bpf/verifier.c                         |  41 ++-
 kernel/trace/bpf_trace.c                      |  15 +-
 net/core/filter.c                             | 161 ++++++++++
 net/ipv4/tcp_ipv4.c                           | 153 +++++++++-
 net/ipv4/udp.c                                | 145 ++++++++-
 scripts/bpf_helpers_doc.py                    |  10 +
 tools/include/uapi/linux/bpf.h                |  37 ++-
 .../selftests/bpf/prog_tests/bpf_iter.c       |  68 +++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |  80 +++++
 .../selftests/bpf/progs/bpf_iter_bpf_map.c    |  18 +-
 .../selftests/bpf/progs/bpf_iter_ipv6_route.c |  18 +-
 .../selftests/bpf/progs/bpf_iter_netlink.c    |  18 +-
 .../selftests/bpf/progs/bpf_iter_task.c       |  18 +-
 .../selftests/bpf/progs/bpf_iter_task_file.c  |  20 +-
 .../selftests/bpf/progs/bpf_iter_tcp4.c       | 261 +++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_tcp6.c       | 277 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_test_kern3.c |  17 +-
 .../selftests/bpf/progs/bpf_iter_test_kern4.c |  17 +-
 .../bpf/progs/bpf_iter_test_kern_common.h     |  18 +-
 .../selftests/bpf/progs/bpf_iter_udp4.c       |  81 +++++
 .../selftests/bpf/progs/bpf_iter_udp6.c       |  88 ++++++
 26 files changed, 1465 insertions(+), 160 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_udp6.c

--=20
2.24.1

