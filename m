Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4A6473BD8
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 04:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhLND7t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 22:59:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230389AbhLND7s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 22:59:48 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BDMcR2s031341
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 19:59:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JD2PCGky332YeXupqsPf651t+k+QAardVW41h4anoaM=;
 b=goUcIkRGe6T1LA3vWrzn32spy3d5mAzHjqrYWCh9ndZkO+IGPSUVPruqGvU4hPOxjMu6
 mzgs0yktU1uj95jJ/Dgdft0X0WUTap5sR94sRDNX3A7AIpKnKxUWonNm8AZQBuKSlSMj
 qXUVP7sO8LrIALToqliDVuMSH6T99ENzoS4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3cx9rq4d1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 19:59:47 -0800
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 19:59:47 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 6E80211317AC; Mon, 13 Dec 2021 19:59:33 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH v4 bpf-next 4/4] libbpf: Mark bpf_object__find_program_by_title API deprecated.
Date:   Mon, 13 Dec 2021 19:59:31 -0800
Message-ID: <20211214035931.1148209-5-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214035931.1148209-1-kuifeng@fb.com>
References: <20211214035931.1148209-1-kuifeng@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 8Pbb8v0VZDFzjlmWz0xhHLUMp8wxdJAG
X-Proofpoint-GUID: 8Pbb8v0VZDFzjlmWz0xhHLUMp8wxdJAG
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_01,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=825 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate this API since v0.7.  All callers should move to
bpf_object__find_program_by_name if possible, otherwise use
bpf_object__for_each_program to find a program out from a given
section.

[0] Closes: https://github.com/libbpf/libbpf/issues/292

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 tools/lib/bpf/libbpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 4802c1e736c3..cd9dec4def41 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -187,6 +187,7 @@ struct btf;
 LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
 LIBBPF_API int bpf_object__btf_fd(const struct bpf_object *obj);
=20
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__find_program_by_name() inst=
ead")
 LIBBPF_API struct bpf_program *
 bpf_object__find_program_by_title(const struct bpf_object *obj,
 				  const char *title);
--=20
2.30.2

