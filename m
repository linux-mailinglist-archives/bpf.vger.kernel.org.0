Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919BA3C0B9
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2019 02:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbfFKA45 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jun 2019 20:56:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38922 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388999AbfFKA45 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Jun 2019 20:56:57 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5B0hoZA022150
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 17:56:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=srw5tfveHj9krlvBEHzIgoUlpexOB0gVJJfWJxn3m54=;
 b=oaZ/Ksl//Y8Tm9fwIIpq2MEkB+ZQwEFu5gqzaziu8Jz2OBRqi9a9i+RlnWl36mH9e+UT
 tsHDalmd5isBUBCcrGL/woUCte5hv3bYhZarC+KXM50hnk8SKTlxq3VOtL5cnYs5VzoQ
 azjI1TPq7dLfKx03KSYq7hIFI3KK3Vb4cSY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t1r8j2hnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 17:56:55 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Jun 2019 17:56:55 -0700
Received: by devvm3632.prn2.facebook.com (Postfix, from userid 172007)
        id 96FE2D0D72E0; Mon, 10 Jun 2019 17:56:53 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Hechao Li <hechaol@fb.com>
Smtp-Origin-Hostname: devvm3632.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <kernel-team@fb.com>, Hechao Li <hechaol@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v6 bpf-next 0/3] Add a new API libbpf_num_possible_cpus()
Date:   Mon, 10 Jun 2019 17:56:49 -0700
Message-ID: <20190611005652.3827331-1-hechaol@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110003
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Getting number of possible CPUs is commonly used for per-CPU BPF maps
and perf_event_maps. Add a new API libbpf_num_possible_cpus() that
helps user with per-CPU related operations and remove duplicate
implementations in bpftool and selftests.

v2: Save errno before calling pr_warning in case it is changed.
v3: Make sure libbpf_num_possible_cpus never returns 0 so that user only
    has to check if ret value < 0.
v4: Fix error code when reading 0 bytes from possible CPU file.
v5: Fix selftests compliation issue.
v6: Split commit to reuse libbpf_num_possible_cpus() into two commits:
    One commit to remove bpf_util.h from test BPF C programs.
    One commit to reuse libbpf_num_possible_cpus() in bpftools 
    and bpf_util.h.


Hechao Li (3):
  bpf: add a new API libbpf_num_possible_cpus()
  selftests/bpf: remove bpf_util.h from BPF C progs
  bpf: use libbpf_num_possible_cpus internally

 tools/bpf/bpftool/common.c                    | 53 ++---------------
 tools/lib/bpf/libbpf.c                        | 57 +++++++++++++++++++
 tools/lib/bpf/libbpf.h                        | 16 ++++++
 tools/lib/bpf/libbpf.map                      |  1 +
 tools/testing/selftests/bpf/bpf_endian.h      |  1 +
 tools/testing/selftests/bpf/bpf_util.h        | 37 ++----------
 .../selftests/bpf/progs/sockmap_parse_prog.c  |  1 -
 .../bpf/progs/sockmap_tcp_msg_prog.c          |  2 +-
 .../bpf/progs/sockmap_verdict_prog.c          |  1 -
 .../selftests/bpf/progs/test_sysctl_prog.c    |  5 +-
 10 files changed, 90 insertions(+), 84 deletions(-)

-- 
2.17.1

