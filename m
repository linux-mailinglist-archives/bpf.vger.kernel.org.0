Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAF127DF77
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 06:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgI3E2K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 00:28:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20834 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbgI3E2K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 00:28:10 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U4Prqv026094
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=j+aGWqXDOldytCFdjd9NV8pF/t7bMbcn1o34Y9uH98w=;
 b=lX5qqy6ZoLMkT9pHC81FKr0NVFdMyis6Cj1O6Ykjvf7lGuUT4GLR5Nl6tEv1h6riQ2a5
 n1ub99axGCtygDbrmkgl98eMnWKfR4+55cQ48IskllhsO65ljBjCpSX4YYg+dRhx7Nby
 10GF8NT3aaXRVEXzqyNX03UzEAKlFnuDZHY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33t35n91ww-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:09 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:28:08 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 320DE2EC77F1; Tue, 29 Sep 2020 21:28:07 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 07/11] btf_encoder: discard CUs after BTF encoding
Date:   Tue, 29 Sep 2020 21:27:38 -0700
Message-ID: <20200930042742.2525310-8-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930042742.2525310-1-andriin@fb.com>
References: <20200930042742.2525310-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=251
 mlxscore=0 lowpriorityscore=0 suspectscore=13 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When doing BTF encoding/deduping, DWARF CUs are never used after BTF enco=
ding
is done, so there is no point in wasting memory and keeping them in memor=
y. So
discard them immediately.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 pahole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pahole.c b/pahole.c
index ed87529ce65d..745f77ffe430 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2368,7 +2368,7 @@ static enum load_steal_kind pahole_stealer(struct c=
u *cu,
 			fprintf(stderr, "Encountered error while encoding BTF.\n");
 			exit(1);
 		}
-		return LSK__KEEPIT;
+		return LSK__DELETE;
 	}
=20
 	if (ctf_encode) {
--=20
2.24.1

