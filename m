Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2FE606B14
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 00:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJTWNi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 18:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJTWNi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 18:13:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2102112B9
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 15:13:37 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KHaCSp009412
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 15:13:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vTr6RbKSp5SXWBQZQ7WTsQB9FAwJtccH55Rr7CWZNCw=;
 b=GxUpzrKyYzB4OQvNdz2tLnuB+YrvfzqvhPozdjMbCtA0dW43t9cO+zqmMz+lALJOfiFX
 C1uYUvrMEszUVSfq4EmM73+BUVNLEtfC02d86LokCD9arqW1ir9UFbqlwUJo4x71LxLJ
 EGoYaW/oXE2FOQcLP7JB/C55zGbVvDUp0JI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kb799db4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 15:13:36 -0700
Received: from twshared17038.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 15:13:35 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B6D2C10F4ECA8; Thu, 20 Oct 2022 15:13:27 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v2 6/6] docs/bpf: Add documentation for map type BPF_MAP_TYPE_CGRP_STROAGE
Date:   Thu, 20 Oct 2022 15:13:27 -0700
Message-ID: <20221020221327.3557258-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020221255.3553649-1-yhs@fb.com>
References: <20221020221255.3553649-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: o-RuAa5u4arVZMvWqw6DYvsqpvVAdc5Q
X-Proofpoint-ORIG-GUID: o-RuAa5u4arVZMvWqw6DYvsqpvVAdc5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_11,2022-10-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add some descriptions and examples for BPF_MAP_TYPE_CGRP_STROAGE.
Also illustate the major difference between BPF_MAP_TYPE_CGRP_STROAGE
and BPF_MAP_TYPE_CGROUP_STORAGE and recommend to use
BPF_MAP_TYPE_CGRP_STROAGE instead of BPF_MAP_TYPE_CGROUP_STORAGE
in the end.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/map_cgrp_storage.rst | 104 +++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/bpf/map_cgrp_storage.rst

diff --git a/Documentation/bpf/map_cgrp_storage.rst b/Documentation/bpf/m=
ap_cgrp_storage.rst
new file mode 100644
index 000000000000..15691aab7fc7
--- /dev/null
+++ b/Documentation/bpf/map_cgrp_storage.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Meta Platforms, Inc. and affiliates.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+BPF_MAP_TYPE_CGRP_STORAGE
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+The ``BPF_MAP_TYPE_CGRP_STORAGE`` map type represents a local fix-sized
+storage for cgroups. It is only available with ``CONFIG_CGROUP_BPF``.
+The programs are made available by the same Kconfig. The
+data for a particular cgroup can be retrieved by looking up the map
+with that cgroup.
+
+This document describes the usage and semantics of the
+``BPF_MAP_TYPE_CGRP_STORAGE`` map type.
+
+Usage
+=3D=3D=3D=3D=3D
+
+The map key must be ``sizeof(int)`` representing a cgroup fd.
+To access the storage in a program, use ``bpf_cgrp_storage_get``::
+
+    void *bpf_cgrp_storage_get(struct bpf_map *map, struct cgroup *cgrou=
p, void *value, u64 flags)
+
+``flags`` could be 0 or ``BPF_LOCAL_STORAGE_GET_F_CREATE`` which indicat=
es that
+a new local storage will be created if one does not exist.
+
+The local storage can be removed with ``bpf_cgrp_storage_delete``::
+
+    long bpf_cgrp_storage_delete(struct bpf_map *map, struct cgruop *cgr=
oup)
+
+The map is available to all program types.
+
+Examples
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+An bpf-program example with BPF_MAP_TYPE_CGRP_STORAGE::
+
+    #include <vmlinux.h>
+    #include <bpf/bpf_helpers.h>
+    #include <bpf/bpf_tracing.h>
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+            __uint(map_flags, BPF_F_NO_PREALLOC);
+            __type(key, int);
+            __type(value, long);
+    } cgrp_storage SEC(".maps");
+
+    SEC("tp_btf/sys_enter")
+    int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+    {
+            struct task_struct *task =3D bpf_get_current_task_btf();
+            long *ptr;
+
+            ptr =3D bpf_cgrp_storage_get(&cgrp_storage, task->cgroups->d=
fl_cgrp, 0,
+                                       BPF_LOCAL_STORAGE_GET_F_CREATE);
+            if (ptr)
+                __sync_fetch_and_add(ptr, 1);
+
+            return 0;
+    }
+
+Userspace accessing map declared above::
+
+    #include <linux/bpf.h>
+    #include <linux/libbpf.h>
+
+    __u32 map_lookup(struct bpf_map *map, int cgrp_fd)
+    {
+            __u32 *value;
+            value =3D bpf_map_lookup_elem(bpf_map__fd(map), &cgrp_fd);
+            if (value)
+                return *value;
+            return 0;
+    }
+
+Difference Between BPF_MAP_TYPE_CGRP_STORAGE and BPF_MAP_TYPE_CGROUP_STO=
RAGE
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+The main difference between ``BPF_MAP_TYPE_CGRP_STORAGE`` and ``BPF_MAP_=
TYPE_CGROUP_STORAGE``
+is that ``BPF_MAP_TYPE_CGRP_STORAGE`` can be used by all program types w=
hile
+``BPF_MAP_TYPE_CGROUP_STORAGE`` is available only to cgroup program type=
s.
+
+There are some other differences as well.
+
+(1). ``BPF_MAP_TYPE_CGRP_STORAGE`` supports local storage for more than =
one
+     cgroups while ``BPF_MAP_TYPE_CGROUP_STORAGE`` only support one, the=
 one attached
+     by the bpf program.
+
+(2). ``BPF_MAP_TYPE_CGROUP_STORAGE`` allocates local storage at attach t=
ime so
+     ``bpf_get_local_storage()`` always returns non-null local storage.
+     ``BPF_MAP_TYPE_CGRP_STORAGE`` allocates local storage at runtime so
+     it is possible that ``bpf_cgrp_storage_get()`` may return null loca=
l storage.
+     To avoid such null local storage issue, user space can do
+     ``bpf_map_update_elem()`` to pre-allocate local storage.
+
+(3). ``BPF_MAP_TYPE_CGRP_STORAGE`` supports de-allocating local storage =
by bpf program
+     while ``BPF_MAP_TYPE_CGROUP_STORAGE`` only de-allocates storage dur=
ing
+     prog detach time.
+
+So overall, ``BPF_MAP_TYPE_CGRP_STORAGE`` supports all ``BPF_MAP_TYPE_CG=
ROUP_STORAGE``
+functionality and beyond. It is recommended to use ``BPF_MAP_TYPE_CGRP_S=
TORAGE``
+instead of ``BPF_MAP_TYPE_CGROUP_STORAGE``.
--=20
2.30.2

