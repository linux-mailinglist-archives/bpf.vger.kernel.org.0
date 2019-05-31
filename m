Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6273A31606
	for <lists+bpf@lfdr.de>; Fri, 31 May 2019 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfEaUVq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 May 2019 16:21:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727287AbfEaUVq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 31 May 2019 16:21:46 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4VKGXYc025823
        for <bpf@vger.kernel.org>; Fri, 31 May 2019 13:21:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=P1V9cJKlNhLZkDxQNgJFzwuvBEI04YhLlqY4xdB8FL4=;
 b=gzTf3Mtxl/CG9BeQmFpB/yuUd+85BhiFjrZ5z2scmWDjCZA8a9MFhbsQU1fxbjZb1GP7
 LJJ2IAetjhpbXOsFEWnvQ9vx/04ufnE2m7O36MMl4hzXN+yySP2gj6N4gyd4DDSgIobL
 uWdHcZGR78KzkJM8wS4ZPjsKXjg1b1Xg1SA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2suar203b9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 31 May 2019 13:21:44 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 31 May 2019 13:21:41 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 70280861799; Fri, 31 May 2019 13:21:41 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [RFC PATCH bpf-next 0/8] BTF-defined BPF map definitions
Date:   Fri, 31 May 2019 13:21:24 -0700
Message-ID: <20190531202132.379386-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-31_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905310123
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set implements initial version (as discussed at LSF/MM2019
conference) of a new way to specify BPF maps, relying on BTF type information,
which allows for easy extensibility, preserving forward and backward
compatibility. See details and examples in description for patch #6.

Patch #1 centralizes commonly used min/max macro in libbpf_internal.h.
Patch #2 extracts .BTF and .BTF.ext loading loging from elf_collect().
Patch #3 refactors map initialization logic into user-provided maps and global
data maps, in preparation to adding another way (BTF-defined maps).
Patch #4 adds support for map definitions in multiple ELF sections and
deprecates bpf_object__find_map_by_offset() API which doesn't appear to be
used anymore and makes assumption that all map definitions reside in single
ELF section.
Patch #5 splits BTF intialization from sanitization/loading into kernel to
preserve original BTF at the time of map initialization.
Patch #6 adds support for BTF-defined maps.
Patch #7 adds new test for BTF-defined map definition.
Patch #8 converts test BPF map definitions to use BTF way.

Andrii Nakryiko (8):
  libbpf: add common min/max macro to libbpf_internal.h
  libbpf: extract BTF loading and simplify ELF parsing logic
  libbpf: refactor map initialization
  libbpf: identify maps by section index in addition to offset
  libbpf: split initialization and loading of BTF
  libbpf: allow specifying map definitions using BTF
  selftests/bpf: add test for BTF-defined maps
  selftests/bpf: switch tests to BTF-defined map definitions

 tools/lib/bpf/bpf.c                           |   7 +-
 tools/lib/bpf/bpf_prog_linfo.c                |   5 +-
 tools/lib/bpf/btf.c                           |   3 -
 tools/lib/bpf/btf.h                           |   1 +
 tools/lib/bpf/btf_dump.c                      |   3 -
 tools/lib/bpf/libbpf.c                        | 762 +++++++++++++-----
 tools/lib/bpf/libbpf_internal.h               |   7 +
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  18 +-
 .../selftests/bpf/progs/get_cgroup_id_kern.c  |  18 +-
 .../testing/selftests/bpf/progs/netcnt_prog.c |  22 +-
 .../selftests/bpf/progs/sample_map_ret0.c     |  18 +-
 .../selftests/bpf/progs/socket_cookie_prog.c  |   9 +-
 .../bpf/progs/sockmap_verdict_prog.c          |  36 +-
 .../selftests/bpf/progs/test_btf_newkv.c      |  73 ++
 .../bpf/progs/test_get_stack_rawtp.c          |  27 +-
 .../selftests/bpf/progs/test_global_data.c    |  27 +-
 tools/testing/selftests/bpf/progs/test_l4lb.c |  45 +-
 .../selftests/bpf/progs/test_l4lb_noinline.c  |  45 +-
 .../selftests/bpf/progs/test_map_in_map.c     |  20 +-
 .../selftests/bpf/progs/test_map_lock.c       |  22 +-
 .../testing/selftests/bpf/progs/test_obj_id.c |   9 +-
 .../bpf/progs/test_select_reuseport_kern.c    |  45 +-
 .../bpf/progs/test_send_signal_kern.c         |  22 +-
 .../bpf/progs/test_skb_cgroup_id_kern.c       |   9 +-
 .../bpf/progs/test_sock_fields_kern.c         |  60 +-
 .../selftests/bpf/progs/test_spin_lock.c      |  33 +-
 .../bpf/progs/test_stacktrace_build_id.c      |  44 +-
 .../selftests/bpf/progs/test_stacktrace_map.c |  40 +-
 .../testing/selftests/bpf/progs/test_tc_edt.c |   9 +-
 .../bpf/progs/test_tcp_check_syncookie_kern.c |   9 +-
 .../selftests/bpf/progs/test_tcp_estats.c     |   9 +-
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |  18 +-
 .../selftests/bpf/progs/test_tcpnotify_kern.c |  18 +-
 tools/testing/selftests/bpf/progs/test_xdp.c  |  18 +-
 .../selftests/bpf/progs/test_xdp_noinline.c   |  60 +-
 tools/testing/selftests/bpf/test_btf.c        |  10 +-
 .../selftests/bpf/test_queue_stack_map.h      |  20 +-
 .../testing/selftests/bpf/test_sockmap_kern.h |  72 +-
 38 files changed, 1182 insertions(+), 491 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_btf_newkv.c

-- 
2.17.1

