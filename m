Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C83287F30
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 01:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgJHXkP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 8 Oct 2020 19:40:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28296 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730070AbgJHXkP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Oct 2020 19:40:15 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098NdIXZ026557
        for <bpf@vger.kernel.org>; Thu, 8 Oct 2020 16:40:14 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3429jq8vv4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 16:40:14 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 8 Oct 2020 16:40:13 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 529B52EC7C76; Thu,  8 Oct 2020 16:40:12 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH v2 dwarves 4/8] btf_encoder: discard CUs after BTF encoding
Date:   Thu, 8 Oct 2020 16:39:56 -0700
Message-ID: <20201008234000.740660-5-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201008234000.740660-1-andrii@kernel.org>
References: <20201008234000.740660-1-andrii@kernel.org>
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_15:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=13
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=268 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010080167
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

When doing BTF encoding/deduping, DWARF CUs are never used after BTF encoding
is done, so there is no point in wasting memory and keeping them in memory. So
discard them immediately.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 pahole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pahole.c b/pahole.c
index 61522175519e..bd9b993777ee 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2384,7 +2384,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			fprintf(stderr, "Encountered error while encoding BTF.\n");
 			exit(1);
 		}
-		return LSK__KEEPIT;
+		return LSK__DELETE;
 	}
 
 	if (ctf_encode) {
-- 
2.24.1

