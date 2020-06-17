Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF39A1FD63B
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgFQUoO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 16:44:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56992 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgFQUoO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Jun 2020 16:44:14 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HKaF5L014905
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:44:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=QrkUNXkbh5Eg12bvUgswD3bDLQDsNc3Hn+n8VHbw4Ic=;
 b=gHE7USaDO5IYWJqam1NzZUiM9A/5fRcVjCkbZBKhez6sG6+Z1chJU7fsSFJsf4GBj8HG
 dIAnMocfJ/EIEh+l8PPFkZWVk+ydAApNicazIPdE3wfb4dr+jwU32FiFHziEWLS5Ac4i
 eIYQiVboQchNcMUtQPi6Swu7DRbLfrh1/uQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q65d80vu-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:44:13 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 13:44:06 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 7AE013700B15; Wed, 17 Jun 2020 13:44:01 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/6] bpf: Support access to bpf map fields
Date:   Wed, 17 Jun 2020 13:43:41 -0700
Message-ID: <cover.1592426215.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_11:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=13 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 cotscore=-2147483648
 phishscore=0 impostorscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170154
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds support to access bpf map fields from bpf programs
using btf_struct_access().

That way a program can cast a pointer to map to either `struct bpf_map *`
or map type specific struct pointer such as `struct bpf_array *` or
`struct bpf_htab *`, and access necessary fields, e.g. map->max_entries.

The fields, in turn, should be defined by a user provided struct with
preserve_access_index attribute or included from vmlinux.h.

Please see patch 4 for more details on the feature and use-cases.

Other patches:

Patch 1 is refactoring to simplify btf_parse_vmlinux().
Patch 2 introduces a new function to simplify iteration over btf.
Patch 3 is a rename to avoid having two different `struct bpf_htab`.

Patch 5 enables access to map fields for all map types.
Patch 6 adds selftests.


Andrey Ignatov (6):
  bpf: Switch btf_parse_vmlinux to btf_find_by_name_kind
  bpf: Introduce btf_find_by_name_kind_next()
  bpf: Rename bpf_htab to bpf_shtab in sock_map
  bpf: Support access to bpf map fields
  bpf: Set map_btf_name for all map types
  selftests/bpf: Test access to bpf map pointer

 include/linux/bpf.h                           |   8 +
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/btf.h                           |   2 +
 kernel/bpf/arraymap.c                         |   6 +
 kernel/bpf/bpf_struct_ops.c                   |   1 +
 kernel/bpf/btf.c                              |  97 ++-
 kernel/bpf/cpumap.c                           |   1 +
 kernel/bpf/devmap.c                           |   2 +
 kernel/bpf/hashtab.c                          |   5 +
 kernel/bpf/local_storage.c                    |   1 +
 kernel/bpf/lpm_trie.c                         |   1 +
 kernel/bpf/queue_stack_maps.c                 |   2 +
 kernel/bpf/reuseport_array.c                  |   1 +
 kernel/bpf/ringbuf.c                          |   1 +
 kernel/bpf/stackmap.c                         |   1 +
 kernel/bpf/verifier.c                         |  77 +-
 net/core/bpf_sk_storage.c                     |   1 +
 net/core/sock_map.c                           |  84 +--
 net/xdp/xskmap.c                              |   1 +
 .../selftests/bpf/prog_tests/map_ptr.c        |  32 +
 .../selftests/bpf/progs/map_ptr_kern.c        | 686 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/map_ptr.c  |  62 ++
 .../selftests/bpf/verifier/map_ptr_mixing.c   |   2 +-
 23 files changed, 1007 insertions(+), 68 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_ptr_kern.c
 create mode 100644 tools/testing/selftests/bpf/verifier/map_ptr.c

--=20
2.24.1

