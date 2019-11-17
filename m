Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D2BFFB54
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2019 19:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfKQS1I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Nov 2019 13:27:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39382 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbfKQS1I (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 17 Nov 2019 13:27:08 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAHIDmvb015306
        for <bpf@vger.kernel.org>; Sun, 17 Nov 2019 10:27:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Id/xz5T6cVkgT7vDEOpqKTf7IXAQcdNmo7QN0fMWvPY=;
 b=b7ZjzeuzkPN0Lac02OL3hnAI9krb2Okg6qOpEJY8Ic2e5V4sItPWcqd7eg3sAguo1UAw
 YClTs9WjSg3mJ+rN9+jSqN3cY9LDhZy03aN1gELf+/9FYw8l/mzA2PY6BqIK5nJVOFtt
 aKslQDuA9yxUbBaqIBXZ4iqn28ZwH0K3jtU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wb1pvk55n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 17 Nov 2019 10:27:07 -0800
Received: from 2401:db00:2050:5076:face:0:1f:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 Nov 2019 10:27:06 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 2A8C33701AEE; Sun, 17 Nov 2019 10:27:04 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] [bpf] allow s32/u32 return types in verifier for bpf helpers
Date:   Sun, 17 Nov 2019 10:27:04 -0800
Message-ID: <20191117182704.656602-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-17_04:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=494
 suspectscore=13 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911170175
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, for all helpers with integer return type,
the verifier permits a single return type, RET_INTEGER,
which represents 64-bit return value from the helper,
and the verifier will assign 64-bit value ranges for these
return values. Such an assumption is different
from what compiler sees and the generated code with
llvm alu32 mode, and may lead verification failure.

This patch enhanced verifier to handle s32/u32 helper
return values properly to avoid verification failure
due to conservative return value range marking.
Patch #1 commit message has details of explanation and
Patch #2 added test cases to selftests test_verifier.

Yonghong Song (2):
  [bpf] allow s32/u32 return types in verifier for bpf helpers
  [tools/bpf] add verifier test for s32/u32 helper return values

 include/linux/bpf.h                           |  4 +-
 kernel/bpf/helpers.c                          |  8 +--
 kernel/bpf/verifier.c                         | 30 +++++++++--
 kernel/trace/bpf_trace.c                      |  4 +-
 net/core/filter.c                             | 16 +++---
 .../selftests/bpf/verifier/helper_ret.c       | 50 +++++++++++++++++++
 6 files changed, 94 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/helper_ret.c

-- 
2.17.1

