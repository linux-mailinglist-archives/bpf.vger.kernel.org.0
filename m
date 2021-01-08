Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750992EFAE3
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 23:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbhAHWKc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Jan 2021 17:10:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46660 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726088AbhAHWKW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Jan 2021 17:10:22 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 108M94AU020001
        for <bpf@vger.kernel.org>; Fri, 8 Jan 2021 14:09:40 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 35x79rpt9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Jan 2021 14:09:40 -0800
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 8 Jan 2021 14:09:38 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 566342ECD237; Fri,  8 Jan 2021 14:09:33 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hao Luo <haoluo@google.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 bpf-next 1/7] bpf: add bpf_patch_call_args prototype to include/linux/bpf.h
Date:   Fri, 8 Jan 2021 14:09:24 -0800
Message-ID: <20210108220930.482456-2-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210108220930.482456-1-andrii@kernel.org>
References: <20210108220930.482456-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_11:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=744 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_patch_call_args() prototype. This function is called from BPF verifier
and only if CONFIG_BPF_JIT_ALWAYS_ON is not defined. This fixes compiler
warning about missing prototype in some kernel configurations.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 1ea47e01ad6e ("bpf: add support for bpf_call to interpreter")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 07cb5d15e743..ef9309604b3e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1403,7 +1403,10 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 /* verify correctness of eBPF program */
 int bpf_check(struct bpf_prog **fp, union bpf_attr *attr,
 	      union bpf_attr __user *uattr);
+
+#ifndef CONFIG_BPF_JIT_ALWAYS_ON
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
+#endif
 
 struct btf *bpf_get_btf_vmlinux(void);
 
-- 
2.24.1

