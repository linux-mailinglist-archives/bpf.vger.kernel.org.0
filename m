Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91F2F3EC3
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 05:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfKHEUr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 23:20:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726219AbfKHEUr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Nov 2019 23:20:47 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xA84C49r019940
        for <bpf@vger.kernel.org>; Thu, 7 Nov 2019 20:20:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=3wXOvqwWqtSRCarD3S0whkHi9qTivXaF8erfbqGKlRk=;
 b=mr7BVoIKSrYa7njdYGNAGFRv5MscFm7TuhoHA/7s+w7+gbX0PLIHICzymy0DjAY1nMYo
 Ona4xTnWQUR3FB8zbDVHkgBU2NuqdH5GCY10h6ng2CfrGX6EXcsZV5g98ClfPSWsgabe
 w/h5WdPykJMOl0KB+SXo79xP7qyq7H9Btvc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2w4tyjhs38-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 20:20:45 -0800
Received: from 2401:db00:2050:5076:face:0:9:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 20:20:44 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id B937A2EC19DF; Thu,  7 Nov 2019 20:20:43 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/3] Add support for memory-mapping BPF array maps
Date:   Thu, 7 Nov 2019 20:20:38 -0800
Message-ID: <20191108042041.1549144-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_07:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=8
 phishscore=0 lowpriorityscore=0 mlxlogscore=502 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911080040
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds ability to memory-map BPF array maps (single- and
multi-element). The primary use case is memory-mapping BPF array maps, created
to back global data variables, created by libbpf implicitly. This allows for
much better usability, along with avoiding syscalls to read or update data
completely.

Due to memory-mapping requirements, BPF array map that is supposed to be
memory-mapped, has to be created with special BPF_F_MMAPABLE attribute, which
triggers slightly different memory allocation strategy internally. See
patch 1 for details.

Libbpf is extended to detect kernel support for this flag, and if supported,
will specify it for all global data maps automatically.

Andrii Nakryiko (3):
  bpf: add mmap() support for BPF_MAP_TYPE_ARRAY
  libbpf: make global data internal arrays mmap()-able, if possible
  selftests/bpf: add BPF_TYPE_MAP_ARRAY mmap() tests

 include/linux/bpf.h                           |   8 +-
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/arraymap.c                         |  96 ++++++++++-
 kernel/bpf/syscall.c                          |  39 +++++
 tools/include/uapi/linux/bpf.h                |   3 +
 tools/lib/bpf/libbpf.c                        |  31 +++-
 .../selftests/bpf/prog_tests/core_reloc.c     |  45 +++--
 tools/testing/selftests/bpf/prog_tests/mmap.c | 154 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_mmap.c |  31 ++++
 9 files changed, 380 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_mmap.c

-- 
2.17.1

