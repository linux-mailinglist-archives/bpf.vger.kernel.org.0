Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B533507DA4
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 02:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350159AbiDTAew (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 20:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbiDTAev (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 20:34:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240CC36E26
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:32:07 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23K0MlTr026251
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:32:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ELzB9aa2d4a6eVgi5xFbN6HdbhtcjMDVzmiOFlVjM0c=;
 b=qfztA+GRvOK+kr84S18QNzae27d8gYMWvWVW6sO1Zq08N8bJHmP0hg3zcUv3541mZNsU
 tTgN3o5eTZrrq1pAG4j6cEAkPi6Qh6LEvgJ3QuWPe6+NWaAzolESbOa1ZK3M3ozMIKKE
 57Tf0fSYitABZW4OzhRewbssDml/Zy4NNJw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fj7k381ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:32:06 -0700
Received: from twshared5730.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 17:22:02 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id AE90E10F663ED; Tue, 19 Apr 2022 17:21:56 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 0/3] Introduce local_storage exclusive caching
Date:   Tue, 19 Apr 2022 17:21:40 -0700
Message-ID: <20220420002143.1096548-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SNgjuizwksLmuVKAggxVQ9VLJ1wIhIAO
X-Proofpoint-GUID: SNgjuizwksLmuVKAggxVQ9VLJ1wIhIAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_08,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, each local_storage type (sk, inode, task) has a 16-entry
cache for local_storage data associated with a particular map. A
local_storage map is assigned a fixed cache_idx when it is allocated.
When looking in a local_storage for data associated with a map the cache
entry at cache_idx is the only place the map can appear in cache. If the
map's data is not in cache it is placed there after a search through the
cache hlist. When there are >16 local_storage maps allocated for a
local_storage type multiple maps have same cache_idx and thus may knock
each other out of cache.

BPF programs that use local_storage may require fast and consistent
local storage access. For example, a BPF program using task local
storage to make scheduling decisions would not be able to tolerate a
long hlist search for its local_storage as this would negatively affect
cycles available to applications. Providing a mechanism for such a
program to ensure that its local_storage_data will always be in cache
would ensure fast access.

This series introduces a BPF_LOCAL_STORAGE_FORCE_CACHE flag that can be
set on sk, inode, and task local_storage maps via map_extras. When a map
with the FORCE_CACHE flag set is allocated it is assigned an 'exclusive'
cache slot that it can't be evicted from until the map is free'd.=20

If there are no slots available to exclusively claim, the allocation
fails. BPF programs are expected to use BPF_LOCAL_STORAGE_FORCE_CACHE
only if their data _must_ be in cache.

The existing cache slots are used - as opposed to a separate cache - as
exclusive caching is not expected to be used by the majority of
local_storage BPF programs. So better to avoid adding a separate cache
that will bloat memory and go unused.

Patches:
* Patch 1 implements kernel-side changes to support the feature
* Patch 2 adds selftests validating functionality
* Patch 3 is a oneline #define dedupe

Dave Marchevsky (3):
  bpf: Introduce local_storage exclusive caching option
  selftests/bpf: Add local_storage exclusive cache test
  bpf: Remove duplicate define in bpf_local_storage.h

 include/linux/bpf_local_storage.h             |   8 +-
 include/uapi/linux/bpf.h                      |  14 +++
 kernel/bpf/bpf_inode_storage.c                |  16 ++-
 kernel/bpf/bpf_local_storage.c                |  42 ++++++--
 kernel/bpf/bpf_task_storage.c                 |  16 ++-
 kernel/bpf/syscall.c                          |   7 +-
 net/core/bpf_sk_storage.c                     |  15 ++-
 .../test_local_storage_excl_cache.c           |  52 +++++++++
 .../bpf/progs/local_storage_excl_cache.c      | 100 ++++++++++++++++++
 .../bpf/progs/local_storage_excl_cache_fail.c |  36 +++++++
 10 files changed, 283 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_sto=
rage_excl_cache.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_excl_=
cache.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_excl_=
cache_fail.c

--=20
2.30.2

