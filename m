Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B26D4380F8
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 02:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhJWAeX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 22 Oct 2021 20:34:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21054 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231293AbhJWAeW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 20:34:22 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19MNlh0U029156
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 17:32:04 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3bv79fg4w8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 17:32:04 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 17:32:03 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3E13770F2EC0; Fri, 22 Oct 2021 17:32:00 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Evgeny Vereshchagin <evvers@ya.ru>
Subject: [PATCH v3 bpf-next 1/2] libbpf: fix overflow in BTF sanity checks
Date:   Fri, 22 Oct 2021 17:31:56 -0700
Message-ID: <20211023003157.726961-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: fouHvgAmFH1mdWIV19KqAwgWpK1lpoVf
X-Proofpoint-GUID: fouHvgAmFH1mdWIV19KqAwgWpK1lpoVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_05,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110230001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_header's str_off+str_len or type_off+type_len can overflow as they
are u32s. This will lead to bypassing the sanity checks during BTF
parsing, resulting in crashes afterwards. Fix by using 64-bit signed
integers for comparison.

Fixes: d8123624506c ("libbpf: Fix BTF data layout checks and allow empty BTF")
Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 66997d985ff8..05b945208815 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -241,12 +241,12 @@ static int btf_parse_hdr(struct btf *btf)
 	}
 
 	meta_left = btf->raw_size - sizeof(*hdr);
-	if (meta_left < hdr->str_off + hdr->str_len) {
+	if (meta_left < (long long)hdr->str_off + hdr->str_len) {
 		pr_debug("Invalid BTF total size:%u\n", btf->raw_size);
 		return -EINVAL;
 	}
 
-	if (hdr->type_off + hdr->type_len > hdr->str_off) {
+	if ((long long)hdr->type_off + hdr->type_len > hdr->str_off) {
 		pr_debug("Invalid BTF data sections layout: type data at %u + %u, strings data at %u + %u\n",
 			 hdr->type_off, hdr->type_len, hdr->str_off, hdr->str_len);
 		return -EINVAL;
-- 
2.30.2

