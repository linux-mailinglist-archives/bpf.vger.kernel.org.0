Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881F411DA04
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 00:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbfLLXbW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 18:31:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42352 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730934AbfLLXbW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Dec 2019 18:31:22 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCNVDfS000921
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 15:31:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=a2zeB7FAexAkasSiEKYuDCs59vzl3ffb5/2vBgzKjvI=;
 b=NS9Dqhj6qO0B1XaEsptgrMzHC58SLGvyViPx1k961d7jldz9TCrDVtJj8F4bz90UY0OX
 sy2hwmfF7GOwGHHdX75yBfXbLIyES0w8IQM4XSJc5xZfDcBRMtgv5ymYK/Ys9oS+EC5x
 PhrNwOh/8uFNJPdiP+mb3fW8rtM1IvwFw1w= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wusrmsty7-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 15:31:21 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 12 Dec 2019 15:31:02 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 0E0423712A1F; Thu, 12 Dec 2019 15:31:02 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 0/6] bpf: Support replacing cgroup-bpf program in MULTI mode
Date:   Thu, 12 Dec 2019 15:30:47 -0800
Message-ID: <cover.1576193131.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=13 impostorscore=0 adultscore=0 mlxlogscore=364 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912120181
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v1->v2:
- move DECLARE_LIBBPF_OPTS from libbpf.h to bpf.h (patch 4);
- switch new libbpf API to OPTS framework;
- switch selftest to libbpf OPTS framework.

This patch set adds support for replacing cgroup-bpf programs attached with
BPF_F_ALLOW_MULTI flag so that any program in a list can be updated to a new
version without service interruption and order of programs can be preserved.

Please see patch 3 for details on the use-case and API changes.

Other patches:
Patch 1 is preliminary refactoring of __cgroup_bpf_attach to simplify it.
Patch 2 is minor cleanup of hierarchy_allows_attach.
Patch 4 moves DECLARE_LIBBPF_OPTS from libbpf.h to bpf.h
Patch 5 extends libbpf API to support new set of attach attributes.
Patch 6 adds selftest coverage for the new API.


Andrey Ignatov (6):
  bpf: Simplify __cgroup_bpf_attach
  bpf: Remove unused new_flags in hierarchy_allows_attach()
  bpf: Support replacing cgroup-bpf program in MULTI mode
  libbpf: Make DECLARE_LIBBPF_OPTS available in bpf.h
  libbpf: Introduce bpf_prog_attach_xattr
  selftests/bpf: Cover BPF_F_REPLACE in test_cgroup_attach

 include/linux/bpf-cgroup.h                    |  4 +-
 include/uapi/linux/bpf.h                      | 10 ++
 kernel/bpf/cgroup.c                           | 97 ++++++++++---------
 kernel/bpf/syscall.c                          |  4 +-
 kernel/cgroup/cgroup.c                        |  5 +-
 tools/include/uapi/linux/bpf.h                | 10 ++
 tools/lib/bpf/bpf.c                           | 21 +++-
 tools/lib/bpf/bpf.h                           | 34 +++++++
 tools/lib/bpf/libbpf.c                        |  1 -
 tools/lib/bpf/libbpf.h                        | 24 +----
 tools/lib/bpf/libbpf.map                      |  2 +
 .../selftests/bpf/test_cgroup_attach.c        | 62 +++++++++++-
 12 files changed, 191 insertions(+), 83 deletions(-)

-- 
2.17.1

