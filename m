Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8FF220461
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 07:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgGOF3Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 01:29:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51710 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728494AbgGOF3Y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 01:29:24 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06F5TMdN000589
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2020 22:29:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=jBPZIxmT9Tkpkif76heASl4sVSO1vN4U8creO7C5kTw=;
 b=YqOjZ4HO45MXyBDGi3PDQusGNeZmVI9uOeefacBEFlS6w6nB3LC9BQDI92djT5OrwI2F
 OpIUgUh6KNSYN+m6lE+/P99StWAKnjR3G4MalttSSfegRqoTYke0pIf1Cm+W/DoH1L79
 ZCvF6+QVNa9I4rdErCBu1GRHu/WBNjZgwaM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 327b8j12pg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2020 22:29:23 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 14 Jul 2020 22:29:02 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 72EA162E52DD; Tue, 14 Jul 2020 22:26:04 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 0/2] bpf: fix stackmap on perf_events with PEBS
Date:   Tue, 14 Jul 2020 22:25:59 -0700
Message-ID: <20200715052601.2404533-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_02:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=962 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150046
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

This set fixes this issue with helper proto bpf_get_stackid_pe and
bpf_get_stack_pe.

[1] https://lore.kernel.org/lkml/ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.=
com/

Changes v1 =3D> v2:
1. Simplify the design and avoid introducing new helper function. (Andrii=
)

Song Liu (2):
  bpf: separate bpf_get_[stack|stackid] for perf events BPF
  selftests/bpf: add callchain_stackid

 include/linux/bpf.h                           |   2 +
 kernel/bpf/stackmap.c                         | 204 ++++++++++++++++--
 kernel/trace/bpf_trace.c                      |   4 +-
 .../bpf/prog_tests/perf_event_stackmap.c      | 120 +++++++++++
 .../selftests/bpf/progs/perf_event_stackmap.c |  64 ++++++
 5 files changed, 374 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_event_sta=
ckmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/perf_event_stackmap=
.c

--
2.24.1
