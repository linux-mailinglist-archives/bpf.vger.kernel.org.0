Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C7F149117
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 23:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAXWlv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 17:41:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729094AbgAXWlv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jan 2020 17:41:51 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00OMec2Y011871
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 14:41:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=lzs5mIRs2O578Kk3zJOnIF9ediUWwofM0vCgrnTwOqA=;
 b=IQx5Zdtsh/ZtYD0xufGvvjPZbo2ZbZBSWfRJfo5yCJQ8r59S0KlcGNA67AHnxDwS86G/
 vIkBF47MvrvIb/zEm3k7CPUxlmeIOTwfYo7GrSiKLRrFUJRC8oHmosDCAEYAzs20VeqR
 sArzCapMJMhXCMlp2N7/uD2lsNkJGUqf5zw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xr664h0jk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 14:41:50 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Jan 2020 14:41:49 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id EDA343711F06; Fri, 24 Jan 2020 14:41:47 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] tools/bpf: Allow overriding llvm tools for runqslower
Date:   Fri, 24 Jan 2020 14:41:42 -0800
Message-ID: <20200124224142.1833678-1-rdna@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_08:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=566 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=13 clxscore=1015 phishscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1911200001 definitions=main-2001240184
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tools/testing/selftests/bpf/Makefile supports overriding clang, llc and
other tools so that custom ones can be used instead of those from PATH.
It's convinient and heavily used by some users.

Apply same rules to runqslower/Makefile.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/bpf/runqslower/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index faf5418609ea..0c021352beed 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 OUTPUT := .output
-CLANG := clang
-LLC := llc
-LLVM_STRIP := llvm-strip
+CLANG ?= clang
+LLC ?= llc
+LLVM_STRIP ?= llvm-strip
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
-- 
2.17.1

