Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA58621C18D
	for <lists+bpf@lfdr.de>; Sat, 11 Jul 2020 03:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgGKB3L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 21:29:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30258 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726927AbgGKB3L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Jul 2020 21:29:11 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06B1OTFT027668
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 18:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=UkMus7+Vz7Uc0JQLrYIg82Co1meCRFb5ndzEGIP5M7A=;
 b=S0xHc77zlybck52+BD/SPd8coZyfQcB+YYwSxpH1gvByjEKie2Tk+0Bx6H+nfPPQ5M5q
 EDXUrmRe0XTCnQUIsF+kaco0XOWhxaS6NTahsccGg2HegeUU37LYg5CSLYK04ftdePJV
 YhwxruwiiCZ8BXBX8z+BWpFLjD5+Q0v+mIo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 325k2cd84t-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 18:29:10 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 10 Jul 2020 18:29:07 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 4AB3C62E4FE4; Fri, 10 Jul 2020 18:26:50 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/5] bpf: fix stackmap on perf_events with PEBS
Date:   Fri, 10 Jul 2020 18:26:34 -0700
Message-ID: <20200711012639.3429622-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_14:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007110006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Calling get_perf_callchain() on perf_events from PEBS entries may cause
unwinder errors. To fix this issue, perf subsystem fetches callchain earl=
y,
and marks perf_events are marked with __PERF_SAMPLE_CALLCHAIN_EARLY.
Similar issue exists when BPF program calls get_perf_callchain() via
helper functions. For more information about this issue, please refer to
discussions in [1].

This set provides a solution for this problem.

1/5 blocks ioctl(PERF_EVENT_IOC_SET_BPF) attaching BPF program that calls
    get_perf_callchain() to perf events with PEBS entries.
2/5 exposes callchain fetched by perf subsystem to BPF program.
3/5 introduces bpf_get_callchain_stackid(), which is alternative to
    bpf_get_stackid() for perf_event with PEBS.
4/5 adds selftests for 1/5.
5/5 adds selftests for 2/5 and 3/5.

[1] https://lore.kernel.org/lkml/ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.=
com/

Song Liu (5):
  bpf: block bpf_get_[stack|stackid] on perf_event with PEBS entries
  bpf: add callchain to bpf_perf_event_data
  bpf: introduce bpf_get_callchain_stackid
  selftests/bpf: add get_stackid_cannot_attach
  selftests/bpf: add callchain_stackid

 include/linux/bpf.h                           |  1 +
 include/linux/filter.h                        |  3 +-
 include/linux/perf_event.h                    |  5 --
 include/linux/trace_events.h                  |  5 ++
 include/uapi/linux/bpf.h                      | 43 +++++++++++++
 include/uapi/linux/bpf_perf_event.h           |  7 +++
 kernel/bpf/btf.c                              |  5 ++
 kernel/bpf/stackmap.c                         | 63 ++++++++++++++-----
 kernel/bpf/verifier.c                         |  7 ++-
 kernel/events/core.c                          | 10 +++
 kernel/trace/bpf_trace.c                      | 29 +++++++++
 scripts/bpf_helpers_doc.py                    |  2 +
 tools/include/uapi/linux/bpf.h                | 43 +++++++++++++
 tools/include/uapi/linux/bpf_perf_event.h     |  8 +++
 .../bpf/prog_tests/callchain_stackid.c        | 61 ++++++++++++++++++
 .../prog_tests/get_stackid_cannot_attach.c    | 57 +++++++++++++++++
 .../selftests/bpf/progs/callchain_stackid.c   | 37 +++++++++++
 17 files changed, 364 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/callchain_stac=
kid.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_stackid_ca=
nnot_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/callchain_stackid.c

--
2.24.1
