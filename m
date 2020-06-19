Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F63201CEE
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 23:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392356AbgFSVMT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 17:12:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49734 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392160AbgFSVMN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 17:12:13 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05JKvnG7006643
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=y8mXRTQ5kuSaMH0e8mjpIgdTQaWl5iXHU4sfxO1X78k=;
 b=O5V3xrvCVq9c/kq2B23n2l3Gn5COPn6ic9NQIz38qEdvwZDmeiZpO5FHAJWJRPEq8W5s
 NgeXsQjTQMRFrOo+qEaTerbopUDQI+9MnMPNKTvWpiuYtqvtKSXzyvi483tRF9J1CKDr
 KnYtitJzJHkFulQMNUPVdKGuMbI0BjGPsaQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31q6456ruq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:12 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 14:12:11 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 5ED573700BAE; Fri, 19 Jun 2020 14:12:05 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 0/5] bpf: Support access to bpf map fields
Date:   Fri, 19 Jun 2020 14:11:40 -0700
Message-ID: <cover.1592600985.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 cotscore=-2147483648 suspectscore=13 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v1->v2:
- move btf id cache to a new bpf_map_ops.map_btf_id field (Martin, Andrii=
);
- don't check btf names for collisions (Martin);
- drop btf_find_by_name_kind_next() patch since it was needed only for
  collision check;
- don't fall back to `struct bpf_map` if a map type doesn't specify both
  map_btf_name and map_btf_id;

This patch set adds support to access bpf map fields from bpf programs
using btf_struct_access().

That way a program can cast a pointer to map to either `struct bpf_map *`
or map type specific struct pointer such as `struct bpf_array *` or
`struct bpf_htab *`, and access necessary fields, e.g. map->max_entries.

The fields, in turn, should be defined by a user provided struct with
preserve_access_index attribute or included from vmlinux.h.

Please see patch 3 for more details on the feature and use-cases.

Other patches:

Patch 1 is refactoring to simplify btf_parse_vmlinux().
Patch 2 is a rename to avoid having two different `struct bpf_htab`.

Patch 4 enables access to map fields for all map types.
Patch 5 adds selftests.


Andrey Ignatov (5):
  bpf: Switch btf_parse_vmlinux to btf_find_by_name_kind
  bpf: Rename bpf_htab to bpf_shtab in sock_map
  bpf: Support access to bpf map fields
  bpf: Set map_btf_{name,id} for all map types
  selftests/bpf: Test access to bpf map pointer

 include/linux/bpf.h                           |   9 +
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/arraymap.c                         |  18 +
 kernel/bpf/bpf_struct_ops.c                   |   3 +
 kernel/bpf/btf.c                              |  63 +-
 kernel/bpf/cpumap.c                           |   3 +
 kernel/bpf/devmap.c                           |   6 +
 kernel/bpf/hashtab.c                          |  15 +
 kernel/bpf/local_storage.c                    |   3 +
 kernel/bpf/lpm_trie.c                         |   3 +
 kernel/bpf/queue_stack_maps.c                 |   6 +
 kernel/bpf/reuseport_array.c                  |   3 +
 kernel/bpf/ringbuf.c                          |   3 +
 kernel/bpf/stackmap.c                         |   3 +
 kernel/bpf/verifier.c                         |  82 ++-
 net/core/bpf_sk_storage.c                     |   3 +
 net/core/sock_map.c                           |  88 +--
 net/xdp/xskmap.c                              |   3 +
 .../selftests/bpf/prog_tests/map_ptr.c        |  32 +
 .../selftests/bpf/progs/map_ptr_kern.c        | 686 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/map_ptr.c  |  62 ++
 .../selftests/bpf/verifier/map_ptr_mixing.c   |   2 +-
 22 files changed, 1030 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_ptr_kern.c
 create mode 100644 tools/testing/selftests/bpf/verifier/map_ptr.c

--=20
2.24.1

