Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED7222F57
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 01:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgGPXp6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jul 2020 19:45:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44006 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbgGPXp6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Jul 2020 19:45:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GMoKkY008939
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 16:01:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=LL2rGApnWJch90rgZTalBSdlaarxIQ3540QQIkq13K0=;
 b=SEWq1E9UlTTJFt8WWCCY16XLbk/XwxiN0s3fI4RRBgSclvbQ27nKvvN3MODXhy5z/trt
 yGpm+BBWl+nu01MIvnjPyVBtNyetJmqz98LYOOfjcZKc2bAQdviOBrrYnSVY+kJeuiwz
 e0hP2dEvW4WQ3E5pbJ0gncxbQOvRoVgbdMI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32avg5h41h-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 16:01:51 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 16 Jul 2020 16:01:39 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B453F62E523E; Thu, 16 Jul 2020 15:59:36 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 0/2] bpf: fix stackmap on perf_events with PEBS
Date:   Thu, 16 Jul 2020 15:59:31 -0700
Message-ID: <20200716225933.196342-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_11:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=994 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160148
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

Changes v2 =3D> v3:
1. Fix handling of stackmap skip field. (Andrii)
2. Simplify the code in a few places. (Andrii)

Changes v1 =3D> v2:
1. Simplify the design and avoid introducing new helper function. (Andrii=
)

Song Liu (2):
  bpf: separate bpf_get_[stack|stackid] for perf events BPF
  selftests/bpf: add callchain_stackid

 include/linux/bpf.h                           |   2 +
 kernel/bpf/stackmap.c                         | 202 ++++++++++++++++--
 kernel/trace/bpf_trace.c                      |   4 +-
 .../bpf/prog_tests/perf_event_stackmap.c      | 116 ++++++++++
 .../selftests/bpf/progs/perf_event_stackmap.c |  59 +++++
 5 files changed, 363 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_event_sta=
ckmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/perf_event_stackmap=
.c

--
2.24.1
