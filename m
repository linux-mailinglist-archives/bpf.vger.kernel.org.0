Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E468E5AF1A
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2019 08:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfF3GvO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 Jun 2019 02:51:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726472AbfF3GvO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 30 Jun 2019 02:51:14 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5U6nUDH019005
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2019 23:51:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=amUR7/BDAEeo2rsxRUIMWaCoSeGULiFnI3VXX6q1Svc=;
 b=AJ6vekNuquGn1kyNSfWc+lecdUVdzE28CCA5KQLbQ9zj0H3B5+Z0On5HSvo94m1j1Rxl
 nJ4U7POAg1vj4WMtbd+oCz/nlgf1lp7TdrhNlAqvcKUBGJC8DdSYRrIIS2xzfZLBPAVU
 AXsnEkiY/1FN0vXsZUJIExqAcnf01f7cbOY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2te3frjd0g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2019 23:51:13 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 29 Jun 2019 23:51:12 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id BC67A8614EA; Sat, 29 Jun 2019 23:51:10 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <jakub.kicinski@netronome.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 0/4] libbpf: add perf buffer abstraction and API
Date:   Sat, 29 Jun 2019 23:51:05 -0700
Message-ID: <20190630065109.1794420-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-30_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906300090
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds a high-level API for setting up and polling perf buffers
associated with BPF_MAP_TYPE_PERF_EVENT_ARRAY map. Details of APIs are
described in corresponding commit.

Patch #1 adds a set of APIs to set up and work with perf buffer.
Patch #2 enhances libbpf to support auto-setting PERF_EVENT_ARRAY map size.
Patch #3 adds test.
Patch #4 converts bpftool map event_pipe to new API.

v3->v4:
- fixed bpftool event_pipe cmd error handling (Jakub);

v2->v3:
- added perf_buffer__new_raw for more low-level control;
- converted bpftool map event_pipe to new API (Daniel);
- fixed bug with error handling in create_maps (Song);

v1->v2:
- add auto-sizing of PERF_EVENT_ARRAY maps;

Andrii Nakryiko (4):
  libbpf: add perf buffer API
  libbpf: auto-set PERF_EVENT_ARRAY size to number of CPUs
  selftests/bpf: test perf buffer API
  tools/bpftool: switch map event_pipe to libbpf's perf_buffer

 tools/bpf/bpftool/map_perf_ring.c             | 201 +++------
 tools/lib/bpf/libbpf.c                        | 397 +++++++++++++++++-
 tools/lib/bpf/libbpf.h                        |  49 +++
 tools/lib/bpf/libbpf.map                      |   4 +
 .../selftests/bpf/prog_tests/perf_buffer.c    |  94 +++++
 .../selftests/bpf/progs/test_perf_buffer.c    |  29 ++
 6 files changed, 630 insertions(+), 144 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_buffer.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_buffer.c

-- 
2.17.1

