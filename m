Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F54A5740
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 07:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiBAGeD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 1 Feb 2022 01:34:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25694 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233545AbiBAGeD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 01:34:03 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21134Vjj018984
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 22:34:03 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxvmp8kr8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 22:34:03 -0800
Received: from twshared11487.23.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 22:34:01 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 2C995290EC8FE; Mon, 31 Jan 2022 22:28:17 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        <iii@linux.ibm.com>, Song Liu <song@kernel.org>
Subject: [PATCH v8 bpf-next 4/9] bpf: use prog->jited_len in  bpf_prog_ksym_set_addr()
Date:   Mon, 31 Jan 2022 22:27:58 -0800
Message-ID: <20220201062803.2675204-5-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201062803.2675204-1-song@kernel.org>
References: <20220201062803.2675204-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EE0LB_IhjZW2yPU7PXEY5Z5BQYpMIVoh
X-Proofpoint-GUID: EE0LB_IhjZW2yPU7PXEY5Z5BQYpMIVoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_02,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1034 phishscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202010033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using prog->jited_len is simpler and more accurate than current
estimation (header + header->size).

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 14199228a6f0..e3fe53df0a71 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -537,13 +537,10 @@ long bpf_jit_limit_max __read_mostly;
 static void
 bpf_prog_ksym_set_addr(struct bpf_prog *prog)
 {
-	const struct bpf_binary_header *hdr = bpf_jit_binary_hdr(prog);
-	unsigned long addr = (unsigned long)hdr;
-
 	WARN_ON_ONCE(!bpf_prog_ebpf_jited(prog));
 
 	prog->aux->ksym.start = (unsigned long) prog->bpf_func;
-	prog->aux->ksym.end   = addr + hdr->size;
+	prog->aux->ksym.end   = prog->aux->ksym.start + prog->jited_len;
 }
 
 static void
-- 
2.30.2

