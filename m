Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567062045AE
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 02:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbgFWAgh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 20:36:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51586 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731652AbgFWAgf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Jun 2020 20:36:35 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05N0aL2g029185
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 17:36:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=/WjtTuu69x4/ntg+0tJF8JFgCZ0iWnzVxhW3jWmNGOY=;
 b=WorQRQ4HAKToaKBNNhAYr9wMzH61DWdyOhQTaLcD6mdbiZE/Qi03FJbSyLlt/C3KkoSB
 HkX9t2VF1icWtheX1Qg875I9s+8LxKL/u5I7EA6u6o8tq3UrhJawoo54Fnncc+AjUps5
 0Qpakg8ysxKdI0600hufEk24TTWiLyD1DCk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31sfyku4as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 17:36:34 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 17:36:32 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 1AF163704FDA; Mon, 22 Jun 2020 17:36:26 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v3 00/15] implement bpf iterator for tcp and udp sockets
Date:   Mon, 22 Jun 2020 17:36:26 -0700
Message-ID: <20200623003626.3072825-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_16:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 adultscore=0 cotscore=-2147483648 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230000
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

Changelogs:
  v2 -> v3:
    - change sock_cast*/SOCK_CAST* names to btf_sock* names for generalit=
y (Martin)
    - change gpl_license to false (Martin)
    - fix helper to cast to tcp timewait/request socket. (Martin)
  v1 -> v2:
    - guard init_sock_cast_types() defination properly with CONFIG_NET (M=
artin)
    - reuse the btf_ids, computed for new helper argument, for return
      values (Martin)
    - using BTF_TYPE_EMIT to express intent of btf type generation (Andri=
i)
    - abstract out common net macros into bpf_tracing_net.h (Andrii)

Yonghong Song (15):
  net: bpf: add bpf_seq_afinfo in tcp_iter_state
  net: bpf: implement bpf iterator for tcp
  bpf: support 'X' in bpf_seq_printf() helper
  bpf: allow tracing programs to use bpf_jiffies64() helper
  bpf: add bpf_skc_to_tcp6_sock() helper
  bpf: add bpf_skc_to_{tcp,tcp_timewait,tcp_request}_sock() helpers
  net: bpf: add bpf_seq_afinfo in udp_iter_state
  net: bpf: implement bpf iterator for udp
  bpf: add bpf_skc_to_udp6_sock() helper
  bpf/selftests: move newer bpf_iter_* type redefining to a new header
    file
  tools/bpf: refactor some net macros to libbpf bpf_tracing_net.h
  tools/libbpf: add more common macros to bpf_tracing_net.h
  tools/bpf: selftests: implement sample tcp/tcp6 bpf_iter programs
  tools/bpf: add udp4/udp6 bpf iterator
  bpf/selftests: add tcp/udp iterator programs to selftests

 include/linux/bpf.h                           |  16 ++
 include/net/tcp.h                             |   1 +
 include/net/udp.h                             |   1 +
 include/uapi/linux/bpf.h                      |  37 ++-
 kernel/bpf/btf.c                              |   1 +
 kernel/bpf/verifier.c                         |  43 ++-
 kernel/trace/bpf_trace.c                      |  15 +-
 net/core/filter.c                             | 156 +++++++++++
 net/ipv4/tcp_ipv4.c                           | 153 ++++++++++-
 net/ipv4/udp.c                                | 144 +++++++++-
 scripts/bpf_helpers_doc.py                    |  10 +
 tools/include/uapi/linux/bpf.h                |  37 ++-
 tools/lib/bpf/Makefile                        |   1 +
 tools/lib/bpf/bpf_tracing_net.h               |  51 ++++
 .../selftests/bpf/prog_tests/bpf_iter.c       |  68 +++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |  80 ++++++
 .../selftests/bpf/progs/bpf_iter_bpf_map.c    |  18 +-
 .../selftests/bpf/progs/bpf_iter_ipv6_route.c |  25 +-
 .../selftests/bpf/progs/bpf_iter_netlink.c    |  22 +-
 .../selftests/bpf/progs/bpf_iter_task.c       |  18 +-
 .../selftests/bpf/progs/bpf_iter_task_file.c  |  20 +-
 .../selftests/bpf/progs/bpf_iter_tcp4.c       | 235 ++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_tcp6.c       | 250 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_test_kern3.c |  17 +-
 .../selftests/bpf/progs/bpf_iter_test_kern4.c |  17 +-
 .../bpf/progs/bpf_iter_test_kern_common.h     |  18 +-
 .../selftests/bpf/progs/bpf_iter_udp4.c       |  71 +++++
 .../selftests/bpf/progs/bpf_iter_udp6.c       |  79 ++++++
 28 files changed, 1435 insertions(+), 169 deletions(-)
 create mode 100644 tools/lib/bpf/bpf_tracing_net.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_udp6.c

--=20
2.24.1

