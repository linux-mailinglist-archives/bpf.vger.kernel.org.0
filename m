Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACFE435A75
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 07:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhJUFsv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 21 Oct 2021 01:48:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34234 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229499AbhJUFsv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 01:48:51 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19L04lvN026193
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 22:46:35 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3btwba1j7t-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 22:46:35 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 22:46:32 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9D5196E76CAB; Wed, 20 Oct 2021 22:46:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Evgeny Vereshchagin <evvers@ya.ru>
Subject: [PATCH bpf] libbpf: fix BTF header parsing checks
Date:   Wed, 20 Oct 2021 22:46:23 -0700
Message-ID: <20211021054623.3871933-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: I1yxlnYQqhQkfnisUTMlKwDCwWN6ozie
X-Proofpoint-ORIG-GUID: I1yxlnYQqhQkfnisUTMlKwDCwWN6ozie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_01,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=771 spamscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Original code assumed fixed and correct BTF header length. That's not
always the case, though, so fix this bug with a proper additional check.
And use actual header length instead of sizeof(struct btf_header) in
sanity checks.

Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
Fixes: a138aed4a80 ("bpf: btf: Add BTF support to libbpf")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 1ced31ecaf7f..aab7e4ece0a0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -231,13 +231,19 @@ static int btf_parse_hdr(struct btf *btf)
 		}
 		btf_bswap_hdr(hdr);
 	} else if (hdr->magic != BTF_MAGIC) {
-		pr_debug("Invalid BTF magic:%x\n", hdr->magic);
+		pr_debug("Invalid BTF magic: %x\n", hdr->magic);
 		return -EINVAL;
 	}
 
-	meta_left = btf->raw_size - sizeof(*hdr);
+	if (btf->raw_size < hdr->hdr_len) {
+		pr_debug("BTF header len %u larger than data size %u\n",
+			 hdr->hdr_len, btf->raw_size);
+		return -EINVAL;
+	}
+
+	meta_left = btf->raw_size - hdr->hdr_len;
 	if (meta_left < (long long)hdr->str_off + hdr->str_len) {
-		pr_debug("Invalid BTF total size:%u\n", btf->raw_size);
+		pr_debug("Invalid BTF total size: %u\n", btf->raw_size);
 		return -EINVAL;
 	}
 
-- 
2.30.2

