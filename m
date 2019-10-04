Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B07CB426
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2019 07:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbfJDF3f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Oct 2019 01:29:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17096 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388091AbfJDF3e (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Oct 2019 01:29:34 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x945TVhL010938
        for <bpf@vger.kernel.org>; Thu, 3 Oct 2019 22:29:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=naC/ghNoWbJHW1LB115/hOmoUiC+pgENfHTNKA0APcQ=;
 b=d/HuZLyMByrET2XN0YfHRIOQPOQYEjuj+xAV6BQdionlcXCT0SIi+0JfLPq8f6+5Qqzv
 BuvxlbMPJQ6BaAKyC2ndis0JwfK2OEJJ1EENRBH0Kc47VH3DiEjATnFBVrP8FHhLttFp
 hujZgFedNliG2Cnjc3QPmcGH0vSeypGgxuY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vdjr2kf5c-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2019 22:29:33 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 3 Oct 2019 22:29:27 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 59736861885; Thu,  3 Oct 2019 22:29:24 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/3] Add new-style bpf_object__open APIs
Date:   Thu, 3 Oct 2019 22:29:19 -0700
Message-ID: <20191004052922.2701794-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_03:2019-10-03,2019-10-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 suspectscore=8 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910040048
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_object__open_file() and bpf_object__open_mem() APIs that use a new
approach to providing future-proof non-ABI-breaking API changes. It relies on
APIs accepting optional self-describing "opts" struct, containing its own
size, filled out and provided by potentially outdated (as well as
newer-than-libbpf) user application. A set of internal helper macros
(OPTS_VALID, OPTS_HAS, and OPTS_GET) streamline and simplify a graceful
handling forward and backward compatibility for user applications dynamically
linked against different versions of libbpf shared library.

Users of libbpf are provided with convenience macro LIBBPF_OPTS that takes
care of populating correct structure size and zero-initializes options struct,
which helps avoid obscure issues of unitialized padding. Uninitialized padding
in a struct might turn into garbage-populated new fields understood by future
versions of libbpf.

Patch #3 switches two of test_progs' tests to use new APIs as a validation
that they work as expected.

v1->v2:
- use better approach for tracking last field in opts struct;
- convert few tests to new APIs for validation;
- fix bug with using offsetof(last_field) instead of offsetofend(last_field).

Andrii Nakryiko (3):
  libbpf: stop enforcing kern_version, populate it for users
  libbpf: add bpf_object__open_{file,mem} w/ extensible opts
  selftests/bpf: switch tests to new bpf_object__open_{file,mem}() APIs

 tools/lib/bpf/libbpf.c                        | 128 +++++++++---------
 tools/lib/bpf/libbpf.h                        |  38 +++++-
 tools/lib/bpf/libbpf.map                      |   3 +
 tools/lib/bpf/libbpf_internal.h               |  32 +++++
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   |  42 +++++-
 .../bpf/prog_tests/reference_tracking.c       |   7 +-
 .../selftests/bpf/progs/test_attach_probe.c   |   1 -
 .../bpf/progs/test_get_stack_rawtp.c          |   1 -
 .../selftests/bpf/progs/test_perf_buffer.c    |   1 -
 .../selftests/bpf/progs/test_stacktrace_map.c |   1 -
 11 files changed, 176 insertions(+), 80 deletions(-)

-- 
2.17.1

