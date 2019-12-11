Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7465411A165
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 03:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfLKCea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 21:34:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31052 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727702AbfLKCe3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Dec 2019 21:34:29 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB2RU7w009768
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 18:34:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=tI2AmmfCzZoTF8zAo7nprZ3TSCHI1SJz+tykkpuCUz8=;
 b=juWxRhSyANSJyGGoHofrUUgghCWlUkP1AFtEXNVik7GYTlAT4d98ld1PkqifmBu3peBH
 m5KYnUi54W/mGqftpXDKC/DAiv2HfqjKPwWx7CT+Hjgr3It96OSPkapxsfTXTeh1KmNR
 AcSZwlah37J18+wbHOWTMtEBA8nxcPyY92U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wt0cx6jy8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 18:34:28 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 18:34:00 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 98D053713892; Tue, 10 Dec 2019 18:33:58 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/5] bpf: Support replacing cgroup-bpf program in MULTI mode
Date:   Tue, 10 Dec 2019 18:33:26 -0800
Message-ID: <cover.1576031228.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_08:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=392
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 suspectscore=13
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110021
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds support for replacing cgroup-bpf programs attached with
BPF_F_ALLOW_MULTI flag so that any program a list can be updated to a new
version without service interruption and order of programs can be preserved.

Please see patch 3 for details on the use-case and API changes.

Other patches:
Patch 1 is preliminary refactoring of __cgroup_bpf_attach to simplify it.
Patch 2 is minor cleanup of hierarchy_allows_attach.
Patch 4 extends libbpf API to support new set of attach attributes.
Patch 5 adds selftest coverage for the new API.


Andrey Ignatov (5):
  bpf: Simplify __cgroup_bpf_attach
  bpf: Remove unused new_flags in hierarchy_allows_attach()
  bpf: Support replacing cgroup-bpf program in MULTI mode
  libbpf: Introduce bpf_prog_attach_xattr
  selftests/bpf: Cover BPF_F_REPLACE in test_cgroup_attach

 include/linux/bpf-cgroup.h                    |  4 +-
 include/uapi/linux/bpf.h                      | 10 ++
 kernel/bpf/cgroup.c                           | 97 ++++++++++---------
 kernel/bpf/syscall.c                          |  4 +-
 kernel/cgroup/cgroup.c                        |  5 +-
 tools/include/uapi/linux/bpf.h                | 10 ++
 tools/lib/bpf/bpf.c                           | 22 ++++-
 tools/lib/bpf/bpf.h                           | 10 ++
 tools/lib/bpf/libbpf.map                      |  5 +
 .../selftests/bpf/test_cgroup_attach.c        | 61 +++++++++++-
 10 files changed, 168 insertions(+), 60 deletions(-)

-- 
2.17.1

