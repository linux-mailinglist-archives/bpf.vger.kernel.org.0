Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECD8176E0A
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 05:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCCEcM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Mar 2020 23:32:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5016 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727237AbgCCEcL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 2 Mar 2020 23:32:11 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0234T9Xs022396
        for <bpf@vger.kernel.org>; Mon, 2 Mar 2020 20:32:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=CfZ6xS9QXFMsvSNaQzvsgRQnkLTRqvY9Mnjhm0CC++s=;
 b=ZjGuzAxcF63jgBCgsJylvGVEktSK+HcgQ7lawoR7EPRiSb5uzg9K96dAV22ZjWF7R0JK
 WmpWfAOUIrWsrQioNGG6EkWyCW8zp4Xi6yfUilm4nCh8YBaPGyOPWivCkkVVQb953o7l
 CFmbtQa5MO6PZhplcGcSJ8PKX+Ja422Mogo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2yfmguuy8u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2020 20:32:10 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 2 Mar 2020 20:32:09 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 5DAB02EC2DD1; Mon,  2 Mar 2020 20:32:04 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 0/3] Introduce pinnable bpf_link kernel abstraction
Date:   Mon, 2 Mar 2020 20:31:56 -0800
Message-ID: <20200303043159.323675-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_09:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 suspectscore=8 impostorscore=0
 mlxlogscore=602 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030033
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series adds bpf_link abstraction, analogous to libbpf's already
existing bpf_link abstraction. This formalizes and makes more uniform existing
bpf_link-like BPF program link (attachment) types (raw tracepoint and tracing
links), which are FD-based objects that are automatically detached when last
file reference is closed. These types of BPF program links are switched to
using bpf_link framework.

FD-based bpf_link approach provides great safety guarantees, by ensuring there
is not going to be an abandoned BPF program attached, if user process suddenly
exits or forgets to clean up after itself. This is especially important in
production environment and is what all the recent new BPF link types followed.

One of the previously existing  inconveniences of FD-based approach, though,
was the scenario in which user process wants to install BPF link and exit, but
let attached BPF program run. Now, with bpf_link abstraction in place, it's
easy to support pinning links in BPF FS, which is done as part of the same
patch #1. This allows FD-based BPF program links to survive exit of a user
process and original file descriptor being closed, by creating an file entry
in BPF FS. This provides great safety by default, with simple way to opt out
for cases where it's needed.

Corresponding libbpf APIs are added in the same patch set, as well as
selftests for this functionality.

Other types of BPF program attachments (XDP, cgroup, perf_event, etc) are
going to be converted in subsequent patches to follow similar approach.

v1->v2:
- use bpf_link_new_fd() uniformly (Alexei).

Andrii Nakryiko (3):
  bpf: introduce pinnable bpf_link abstraction
  libbpf: add bpf_link pinning/unpinning
  selftests/bpf: add link pinning selftests

 include/linux/bpf.h                           |  13 +
 kernel/bpf/inode.c                            |  42 +++-
 kernel/bpf/syscall.c                          | 223 ++++++++++++++----
 tools/lib/bpf/libbpf.c                        | 131 +++++++---
 tools/lib/bpf/libbpf.h                        |   5 +
 tools/lib/bpf/libbpf.map                      |   5 +
 .../selftests/bpf/prog_tests/link_pinning.c   | 105 +++++++++
 .../selftests/bpf/progs/test_link_pinning.c   |  25 ++
 8 files changed, 476 insertions(+), 73 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/link_pinning.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_link_pinning.c

-- 
2.17.1

