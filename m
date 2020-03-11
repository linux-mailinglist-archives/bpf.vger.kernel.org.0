Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E4E1821E7
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 20:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbgCKTPI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 15:15:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7350 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731253AbgCKTPH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Mar 2020 15:15:07 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BJ8ehf019966
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 12:15:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=hq5XLtSBAj7PIxZeRdBKDVJKbSYOVb0sWd+nAKfLqp4=;
 b=XUd0E2O7c5DKAUySK9aEpnvAEruBVBe5P/J6gSC9v/B8rZep1K/NuzFQ3i6Z9TlcZqzD
 9g7DR/Onb5frvIW1qlVNa9t1AS0W9GWSgoV+LxcwqZvLgk+udjYUFT4kphZxS0SdjfDN
 eTOCFMnu+XPpqXIlsWsu1DPcJ+D0w8mguWE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ypfsqe3c6-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 12:15:06 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 11 Mar 2020 12:15:01 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 6E57137007D8; Wed, 11 Mar 2020 12:14:57 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <osandov@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] bpf: Document bpf_inspect drgn tool
Date:   Wed, 11 Mar 2020 12:14:40 -0700
Message-ID: <20200311191440.3988361-1-rdna@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_09:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=634 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=1 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110107
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's a follow-up for discussion in [1].

drgn tool bpf_inspect.py was merged to drgn repo in [2]. Document it in
kernel tree to make BPF developers aware that the tool exists and can
help with getting BPF state unavailable via UAPI.

For now it's just one tool but the doc is written in a way that allows
to cover more tools in the future if needed.

Please refer to the doc itself for more details.

The patch was tested by `make htmldocs` and sanity-checking that
resulting html looks good.

[1]
https://lore.kernel.org/bpf/20200228201514.GB51456@rdna-mbp/T/#mefed65e8a98116bd5d07d09a570a3eac46724951
[2] https://github.com/osandov/drgn/pull/49

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 Documentation/bpf/drgn.rst  | 42 +++++++++++++++++++++++++++++++++++++
 Documentation/bpf/index.rst |  5 +++--
 2 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/bpf/drgn.rst

diff --git a/Documentation/bpf/drgn.rst b/Documentation/bpf/drgn.rst
new file mode 100644
index 000000000000..9a9ad75ab066
--- /dev/null
+++ b/Documentation/bpf/drgn.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+==============
+BPF drgn tools
+==============
+
+drgn scripts are great to debug kernel internals including BPF and get
+information unavailable via conventional kernel UAPI.
+
+If there is a piece of kernel state useful for a small number of users, e.g.
+only for BPF developers, or too expensive to expose to user space, drgn script
+can be a good option to still have access to that state but without extending
+UAPI.
+
+This document describes BPF related drgn tools.
+
+See `drgn/tools`_ for all tools available at the moment and `drgn/doc`_ for
+more details on drgn itself.
+
+bpf_inspect.py
+**************
+
+`bpf_inspect.py`_ is a tool intended to inspect BPF programs and maps. It can
+iterate over all programs and maps in the system and print basic information
+about these objects, including id, type and name.
+
+The main use-case `bpf_inspect.py`_ covers is to show BPF programs of types
+``BPF_PROG_TYPE_EXT`` and ``BPF_PROG_TYPE_TRACING`` attached to other BPF
+programs via ``freplace``/``fentry``/``fexit`` mechanisms, since there is no
+user-space API to get this information.
+
+But developer can edit the tool and get any piece of ``struct bpf_prog`` or
+``struct bpf_map`` they're interested in, e.g. the whole ``struct
+bpf_prog_aux``.
+
+See ``--help`` for more details.
+
+.. Links
+.. _drgn/doc: https://drgn.readthedocs.io/en/latest/
+.. _drgn/tools: https://github.com/osandov/drgn/tree/master/tools
+.. _bpf_inspect.py:
+   https://github.com/osandov/drgn/blob/master/tools/bpf_inspect.py
diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 4f5410b61441..7be43c5f2dcf 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -47,12 +47,13 @@ Program types
    prog_flow_dissector
 
 
-Testing BPF
-===========
+Testing and debugging BPF
+=========================
 
 .. toctree::
    :maxdepth: 1
 
+   drgn
    s390
 
 
-- 
2.17.1

