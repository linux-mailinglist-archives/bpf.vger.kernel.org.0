Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03024D8832
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 07:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbfJPFuF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Oct 2019 01:50:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2788 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387567AbfJPFuE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Oct 2019 01:50:04 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G5o4OZ016627
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 22:50:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=hS4iJL06oeu1TUdZwSRUSIfQxECsHd9BwMVjK3BQ+EY=;
 b=E5ogMLlcT75wEZMNKkiZxj57gRvU+29ktixmi/j70xEuXTxSZYEQ/wnMsIyfrYGyPpzi
 CN5BDC/eq9DoK2/SbDx33+miHaaPNPGz5TF7nbRFKi8vQAMIE8pwCKmp8+C9vBAu2Bmt
 Bb0+b/ucH29mL6ufyDSDANPp2y9TkxtJ8m8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vnf1wm210-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 22:50:04 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 15 Oct 2019 22:49:48 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 2A58686193C; Tue, 15 Oct 2019 22:49:48 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 0/7] Fix, clean up, and revamp selftests/bpf Makefile
Date:   Tue, 15 Oct 2019 22:49:38 -0700
Message-ID: <20191016054945.1988387-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_02:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=9 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160054
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set extensively revamps selftests/bpf's Makefile to generalize test
runner concept and apply it uniformly to test_maps and test_progs test
runners, along with test_progs' few build "flavors", exercising various ways
to build BPF programs.

As we do that, we fix dependencies between various phases of test runners, and
simplify some one-off rules and dependencies currently present in Makefile.
test_progs' flavors are now built into root $(OUTPUT) directory and can be run
without any extra steps right from there. E.g., test_progs-alu32 is built and
is supposed to be run from $(OUTPUT). It will cd into alu32/ subdirectory to
load correct set of BPF object files (which are different from the ones built
for test_progs).

Outline:
- patch #1 teaches test_progs about flavor sub-directories;
- patch #2 fixes one of CO-RE tests to not depend strictly on process name;
- patch #3 changes test_maps's usage of map_tests/tests.h to be the same as
  test_progs' one;
- patch #4 adds convenient short `make test_progs`-like targets to build only
  individual tests, if necessary;
- patch #5 is a main patch in the series; it uses a bunch of make magic
  (mainly $(call) and $(eval)) to define test runner "skeleton" and apply it
  to 4 different test runners, lots more details in corresponding commit
  description;
- patch #6 does a bit of post-clean up for test_queue_map and test_stack_map
  BPF programs;
- patch #7 cleans up test_libbpf.sh/test_libbpf_open superseded by test_progs.

v2->v3:
- drop test_xdp.o mixed compilation mode, remove test_libbpf.sh (Alexei);

v1->v2:
- drop test_progs-native causing compilation failures due to
  __builtin_preserve_field_access, add back test_xdp.o override, which will
  now emit rule re-definition warning.


Andrii Nakryiko (7):
  selftests/bpf: teach test_progs to cd into subdir
  selftests/bpf: make CO-RE reloc test impartial to test_progs flavor
  selftests/bpf: switch test_maps to test_progs' test.h format
  selftests/bpf: add simple per-test targets to Makefile
  selftests/bpf: replace test_progs and test_maps w/ general rule
  selftests/bpf: move test_queue_stack_map.h into progs/ where it
    belongs
  selftest/bpf: remove test_libbpf.sh and test_libbpf_open

 tools/testing/selftests/bpf/.gitignore        |   7 +-
 tools/testing/selftests/bpf/Makefile          | 338 ++++++++++--------
 .../selftests/bpf/prog_tests/core_reloc.c     |   4 +-
 .../selftests/bpf/progs/core_reloc_types.h    |   2 +-
 .../bpf/progs/test_core_reloc_kernel.c        |   3 +-
 .../bpf/{ => progs}/test_queue_stack_map.h    |   0
 tools/testing/selftests/bpf/test_libbpf       | Bin 0 -> 384568 bytes
 tools/testing/selftests/bpf/test_libbpf.sh    |  43 ---
 tools/testing/selftests/bpf/test_libbpf_open  | Bin 0 -> 396096 bytes
 tools/testing/selftests/bpf/test_maps.c       |   8 +-
 tools/testing/selftests/bpf/test_progs.c      |  33 +-
 11 files changed, 234 insertions(+), 204 deletions(-)
 rename tools/testing/selftests/bpf/{ => progs}/test_queue_stack_map.h (100%)
 create mode 100755 tools/testing/selftests/bpf/test_libbpf
 delete mode 100755 tools/testing/selftests/bpf/test_libbpf.sh
 create mode 100755 tools/testing/selftests/bpf/test_libbpf_open

-- 
2.17.1

