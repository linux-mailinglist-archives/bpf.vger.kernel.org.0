Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837A64A04B3
	for <lists+bpf@lfdr.de>; Sat, 29 Jan 2022 00:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbiA1X5R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 28 Jan 2022 18:57:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51536 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344481AbiA1X5P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Jan 2022 18:57:15 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20SKoHg8026536
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 15:57:15 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dv7skemmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 15:57:15 -0800
Received: from twshared0654.04.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 15:57:14 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id F3B2528E02F93; Fri, 28 Jan 2022 15:45:35 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        <iii@linux.ibm.com>, Song Liu <song@kernel.org>
Subject: [PATCH v7 bpf-next 6/9] bpf: introduce bpf_arch_text_copy
Date:   Fri, 28 Jan 2022 15:45:14 -0800
Message-ID: <20220128234517.3503701-7-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128234517.3503701-1-song@kernel.org>
References: <20220128234517.3503701-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UhaT9gej7BXkjGp6mOTyZ6cLPKmmYhM1
X-Proofpoint-ORIG-GUID: UhaT9gej7BXkjGp6mOTyZ6cLPKmmYhM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_08,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=998
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1034 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This will be used to copy JITed text to RO protected module memory. On
x86, bpf_arch_text_copy is implemented with text_poke_copy.

bpf_arch_text_copy returns pointer to dst on success, and ERR_PTR(errno)
on errors.

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 7 +++++++
 include/linux/bpf.h         | 2 ++
 kernel/bpf/core.c           | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ce1f86f245c9..9792bf10d881 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2413,3 +2413,10 @@ bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
 }
+
+void *bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+	if (text_poke_copy(dst, src, len) == NULL)
+		return ERR_PTR(-EINVAL);
+	return dst;
+}
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 28ac752f21ba..7f58fe256671 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2350,6 +2350,8 @@ enum bpf_text_poke_type {
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
+void *bpf_arch_text_copy(void *dst, void *src, size_t len);
+
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7cbcf6bfbb52..dc0142e20c72 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2448,6 +2448,11 @@ int __weak bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	return -ENOTSUPP;
 }
 
+void * __weak bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 EXPORT_SYMBOL(bpf_stats_enabled_key);
 
-- 
2.30.2

