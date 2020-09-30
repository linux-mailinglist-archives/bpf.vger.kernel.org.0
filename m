Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1639927DF78
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 06:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgI3E2L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 00:28:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62060 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbgI3E2L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 00:28:11 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U4S9BD011182
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=L2yuisBJNOx0vy1ySJ3Ee2fOtCR7/zd+StlKwujDeks=;
 b=aizB9nQY/PdKZhyTIjKizia31Em0Fw4SoloK66gzPEBiICMONQBPj4h+g/cj6K001bu/
 GNunC9kaZVmxN4FPv8CtSbN48AQzM8Po0T+ee4D7ipjGc4H96MqTbjc7A853YLv4G1vK
 GVcKNClolYlMRkxxiU3j8dXY00l7BMffAOY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33v1ndd3ur-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:11 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:28:00 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 27E2A2EC77F1; Tue, 29 Sep 2020 21:27:56 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 02/11] btf_encoder: detect BTF encoding errors and exit
Date:   Tue, 29 Sep 2020 21:27:33 -0700
Message-ID: <20200930042742.2525310-3-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930042742.2525310-1-andriin@fb.com>
References: <20200930042742.2525310-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=701 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=13 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't silently swallow BTF encoding errors and continue onto next CU. If =
any
of CU fails to properly encode BTF, exit with an error message.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 pahole.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/pahole.c b/pahole.c
index ee5f2f7f76b0..ed87529ce65d 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2363,8 +2363,11 @@ static enum load_steal_kind pahole_stealer(struct =
cu *cu,
 		goto filter_it;
=20
 	if (btf_encode) {
-		cu__encode_btf(cu, global_verbose, btf_encode_force,
-			       skip_encoding_btf_vars);
+		if (cu__encode_btf(cu, global_verbose, btf_encode_force,
+				   skip_encoding_btf_vars)) {
+			fprintf(stderr, "Encountered error while encoding BTF.\n");
+			exit(1);
+		}
 		return LSK__KEEPIT;
 	}
=20
--=20
2.24.1

