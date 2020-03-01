Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA6174C04
	for <lists+bpf@lfdr.de>; Sun,  1 Mar 2020 07:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCAGYw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Mar 2020 01:24:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12424 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbgCAGYw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 1 Mar 2020 01:24:52 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0216OouX005073
        for <bpf@vger.kernel.org>; Sat, 29 Feb 2020 22:24:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=3TaeMEBsZ1JRAiUBnEbuhLf/lXH9uZY8cvlN5Q2xO0I=;
 b=FC2nnoFk25B2sQ7qyzwyeW5i/RIB1tCu++ivE2QG8ZfVoJGtl1Vym3/wXAxNy/g8mcrC
 fQRbUp3CrvzqTmFZlYaSe86phCo6UzCxayZQi2sxDD9pfSscYaTLrKFnghYERxS25GTF
 aV+bzMtc/b702a3fK5fvWHNabI8p6XYKNQk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2yfmguk7vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 29 Feb 2020 22:24:51 -0800
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 29 Feb 2020 22:24:14 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 89C222EC2CFD; Sat, 29 Feb 2020 22:24:08 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 0/3] Convert BPF UAPI constants into enum values
Date:   Sat, 29 Feb 2020 22:24:02 -0800
Message-ID: <20200301062405.2850114-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-01_01:2020-02-28,2020-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 suspectscore=8 impostorscore=0
 mlxlogscore=284 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003010050
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert BPF-related UAPI constants, currently defined as #define macro, into
anonymous enums. This has no difference in terms of usage of such constants in
C code (they are still could be used in all the compile-time contexts that
`#define`s can), but they are recorded as part of DWARF type info, and
subsequently get recorded as part of kernel's BTF type info. This allows those
constants to be emitted as part of vmlinux.h auto-generated header file and be
used from BPF programs. Which is especially convenient for all kinds of BPF
helper flags and makes CO-RE BPF programs nicer to write.

libbpf's btf_dump logic currently assumes enum values are signed 32-bit
values, but that doesn't match a typical case, so switch it to emit unsigned
values. Once BTF encoding of BTF_KIND_ENUM is extended to capture signedness
properly, this will be made more flexible.

As an immediate validation of the approach, runqslower's copy of
BPF_F_CURRENT_CPU #define is dropped in favor of its enum variant from
vmlinux.h.

v1->v2:
- fix up btf_dump test to use max 32-bit unsigned value instead of negative one.

Andrii Nakryiko (3):
  bpf: switch BPF UAPI #define constants to enums
  libbpf: assume unsigned values for BTF_KIND_ENUM
  tools/runqslower: drop copy/pasted BPF_F_CURRENT_CPU definiton

 include/uapi/linux/bpf.h                      | 272 ++++++++++-------
 include/uapi/linux/bpf_common.h               |  86 +++---
 include/uapi/linux/btf.h                      |  60 ++--
 tools/bpf/runqslower/runqslower.bpf.c         |   3 -
 tools/include/uapi/linux/bpf.h                | 274 +++++++++++-------
 tools/include/uapi/linux/bpf_common.h         |  86 +++---
 tools/include/uapi/linux/btf.h                |  60 ++--
 tools/lib/bpf/btf_dump.c                      |   8 +-
 .../bpf/progs/btf_dump_test_case_syntax.c     |   2 +-
 9 files changed, 502 insertions(+), 349 deletions(-)

-- 
2.17.1

