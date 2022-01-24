Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2402E498F37
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 20:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244945AbiAXTvY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 24 Jan 2022 14:51:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6724 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1355676AbiAXTnI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 14:43:08 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20OHVhvE017042
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 11:43:06 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dssutbkqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 11:43:06 -0800
Received: from twshared2974.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 11:43:05 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 27C6DFF02AFC; Mon, 24 Jan 2022 11:42:59 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 2/7] libbpf: deprecate bpf_map__resize()
Date:   Mon, 24 Jan 2022 11:42:49 -0800
Message-ID: <20220124194254.2051434-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124194254.2051434-1-andrii@kernel.org>
References: <20220124194254.2051434-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9FpTxfgYYn4EATKZyiFHHwE8XUWFZ9Xd
X-Proofpoint-GUID: 9FpTxfgYYn4EATKZyiFHHwE8XUWFZ9Xd
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=752
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201240129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecated bpf_map__resize() in favor of bpf_map__set_max_entries()
setter. In addition to having a surprising name (users often don't
realize that they need to use bpf_map__resize()), the name also implies
some magic way of resizing BPF map after it is created, which is clearly
not the case.

Another minor annoyance is that bpf_map__resize() disallows 0 value for
max_entries, which in some cases is totally acceptable (e.g., like for
BPF perf buf case to let libbpf auto-create one buffer per each
available CPU core).

  [0] Closes: https://github.com/libbpf/libbpf/issues/304

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c89d9b4456fd..9cff3e615cd3 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -716,6 +716,7 @@ LIBBPF_API int bpf_map__set_type(struct bpf_map *map, enum bpf_map_type type);
 /* get/set map size (max_entries) */
 LIBBPF_API __u32 bpf_map__max_entries(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_map__set_max_entries() instead")
 LIBBPF_API int bpf_map__resize(struct bpf_map *map, __u32 max_entries);
 /* get/set map flags */
 LIBBPF_API __u32 bpf_map__map_flags(const struct bpf_map *map);
-- 
2.30.2

