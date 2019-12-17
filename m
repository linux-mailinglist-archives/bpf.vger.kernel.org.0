Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE37E123A65
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 00:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLQXA5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Dec 2019 18:00:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbfLQXAy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Dec 2019 18:00:54 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHMsBS2002740
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2019 15:00:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ZiK81MIalBtQF5DvkcqT7OXkB9XFoYW32vcKAQX0NE4=;
 b=UPeQfolMqsdmuKN3KyYdod51zhTzVTsrtrX0yWwgLwrxqge16I/R8kBHSRpX6YwaDWap
 HtcW89OlGjOYFDZBtlsPCh05/zuFHX8Gou9pewon87el3zDRCBs5LNFRDwfn2nScAABU
 QCuV+sfoB1XIqrLRXF9eXZwJwagrkSTbIv4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wy1qrj5tq-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2019 15:00:53 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Dec 2019 15:00:46 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 255C12EC1C52; Tue, 17 Dec 2019 15:00:44 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 0/3] Skeleton improvements and documentation
Date:   Tue, 17 Dec 2019 15:00:35 -0800
Message-ID: <20191217230038.1562848-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_04:2019-12-17,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912170183
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Simplify skeleton usage by embedding source BPF object file inside skeleton
itself. This allows to keep skeleton and object file in sync at all times with
no chance of confusion.

Also, add bpftool-gen.rst manpage, explaining concepts and ideas behind
skeleton. In examples section it also includes a complete small BPF
application utilizing skeleton, as a demonstration of API.

Patch #2 also removes BPF_EMBED_OBJ, as there is currently no use of it.

v1->v2:
- remove whitespace from empty lines in code blocks (Yonghong).

Andrii Nakryiko (3):
  bpftool, selftests/bpf: embed object file inside skeleton
  libbpf: remove BPF_EMBED_OBJ macro from libbpf.h
  bpftool: add gen subcommand manpage

 .../bpf/bpftool/Documentation/bpftool-gen.rst | 302 ++++++++++++++++++
 tools/bpf/bpftool/Documentation/bpftool.rst   |   3 +-
 tools/bpf/bpftool/gen.c                       | 226 ++++++++-----
 tools/lib/bpf/libbpf.h                        |  35 --
 .../selftests/bpf/prog_tests/attach_probe.c   |   4 +-
 .../selftests/bpf/prog_tests/core_extern.c    |   4 +-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  10 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |   7 +-
 tools/testing/selftests/bpf/prog_tests/mmap.c |   4 +-
 .../selftests/bpf/prog_tests/skeleton.c       |   4 +-
 .../bpf/prog_tests/stacktrace_build_id.c      |   4 +-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  |   4 +-
 12 files changed, 456 insertions(+), 151 deletions(-)
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-gen.rst

-- 
2.17.1

