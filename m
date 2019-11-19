Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F013102D14
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 20:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfKST5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 14:57:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbfKST5Q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Nov 2019 14:57:16 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJJoNw5019761
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 11:57:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=L436sXJ8GdyOxGsIUr9my29l6XfcyJU4WoztqEny7jw=;
 b=EioC/ZieCR1FoUsXZNtxAPI9JJt3RtAYD+Coe5Zu+K3EXbbwRPVWy12YRkFNoSW2Q3Tp
 LFNhupTcU5oKqeNUbGw6x8LVEsVRCnWcc/XkPkZqRUs9eII4EITVu/gQmyf+ZBC/dWhP
 9Kt5YvWPI9+AttocP/yIyGEJWnHJYvZNfyU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wb1pfm1bg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 11:57:16 -0800
Received: from 2401:db00:2050:5102:face:0:37:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 19 Nov 2019 11:57:14 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7CA6E3702314; Tue, 19 Nov 2019 11:57:11 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 0/3] bpf: allow s32/u32 return types in verifier for bpf helpers
Date:   Tue, 19 Nov 2019 11:57:11 -0800
Message-ID: <20191119195711.3691681-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=467 suspectscore=13
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190163
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

This patch set enhanced verifier to handle s32/u32 helper
return values properly to avoid verification failure
due to conservative return value range marking.
Patch #1 refactored the verifier code to have an internal helper
  which will be used in Patch #2.
Patch #2 added 32-bit helper return type support.
  The commit message has details of explanation.
Patch #3 added two test cases to selftests test_verifier.

Yonghong Song (3):
  bpf: add a helper to set preciseness of an unknown register
  bpf: allow s32/u32 return types in verifier for bpf helpers
  tools/bpf: add verifier test for s32/u32 helper return values

 include/linux/bpf.h                           |  4 +-
 include/linux/tnum.h                          |  3 +-
 kernel/bpf/helpers.c                          |  8 +--
 kernel/bpf/tnum.c                             |  3 +-
 kernel/bpf/verifier.c                         | 50 ++++++++++++++++---
 kernel/trace/bpf_trace.c                      |  4 +-
 net/core/filter.c                             | 16 +++---
 .../selftests/bpf/verifier/helper_ret.c       | 50 +++++++++++++++++++
 8 files changed, 113 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/helper_ret.c

-- 
2.17.1

