Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF42104AF8
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 08:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfKUHIT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Nov 2019 02:08:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfKUHIS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Nov 2019 02:08:18 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAL75VNk012445
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2019 23:08:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=vLhlE2BF26RKcogV/faxfnGZ9jr1e8PMC76sXqcp3Sc=;
 b=dfgeRz6n0v6gx3JQ/J2lpTneVJzokDNVby/Y3mZDO5VtrgoRN7oP97O4PJetkUU+MPBx
 gxa2OXyxxsr3Ou/H283OxavlAa3K0yjhxe6q0yhUZeFQeQhEZF/0ckAiZJ6sqAfuIRIM
 CpQCmcAhvYydHnPmQVH/QDIO5XSkZqxjQWc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wd91hkxup-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2019 23:08:18 -0800
Received: from 2401:db00:2050:5076:face:0:7:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 20 Nov 2019 23:08:17 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id A49762EC178E; Wed, 20 Nov 2019 23:08:14 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/4] Support global variables
Date:   Wed, 20 Nov 2019 23:07:39 -0800
Message-ID: <20191121070743.1309473-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_08:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=796 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210062
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set salvages all the non-extern-specific changes out of blocked
externs patch set ([0]). In addition to small clean ups, it also refactors
libbpf's handling of relocations and allows support for global (non-static)
variables.

  [0] https://patchwork.ozlabs.org/project/netdev/list/?series=143358&state=*

Andrii Nakryiko (4):
  selftests/bpf: ensure no DWARF relocations for BPF object files
  libbpf: refactor relocation handling
  libbpf: fix various errors and warning reported by checkpatch.pl
  libbpf: support initialized global variables

 tools/lib/bpf/libbpf.c                        | 292 ++++++++++--------
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/progs/test_core_reloc_arrays.c        |   4 +-
 .../progs/test_core_reloc_bitfields_direct.c  |   4 +-
 .../progs/test_core_reloc_bitfields_probed.c  |   4 +-
 .../bpf/progs/test_core_reloc_existence.c     |   4 +-
 .../bpf/progs/test_core_reloc_flavors.c       |   4 +-
 .../bpf/progs/test_core_reloc_ints.c          |   4 +-
 .../bpf/progs/test_core_reloc_kernel.c        |   4 +-
 .../bpf/progs/test_core_reloc_misc.c          |   4 +-
 .../bpf/progs/test_core_reloc_mods.c          |   4 +-
 .../bpf/progs/test_core_reloc_nesting.c       |   4 +-
 .../bpf/progs/test_core_reloc_primitives.c    |   4 +-
 .../bpf/progs/test_core_reloc_ptr_as_arr.c    |   4 +-
 .../bpf/progs/test_core_reloc_size.c          |   4 +-
 15 files changed, 185 insertions(+), 161 deletions(-)

-- 
2.17.1

