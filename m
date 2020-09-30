Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9921C27DF7F
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 06:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgI3E2T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 00:28:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40034 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgI3E2T (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 00:28:19 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U4QZ05001869
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mX9KE6mb3xhDNfI80kVyZe5AkD9OP3wbxlF8NxUF65U=;
 b=aO7Ljzadv3RaiyG6iBYB9AHX/xt15X1qc2hUE4JvIgLjchYoq6vycL2UH/v5Y0wmI0hK
 mn+2DErQGAJnwJyCy1+H4I8KJBEi8ibPJVE7IHAvnWkQv/Hhr+UjmcROHse4vpcKuIjo
 g+a7EJHI7hWSY2RJGOyyzCPlqAPOpmoXw3M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33v3vtvjhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:18 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:28:17 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 8E66A2EC77F1; Tue, 29 Sep 2020 21:28:11 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 09/11] dwarf_loader: increase the size of lookup hash map
Date:   Tue, 29 Sep 2020 21:27:40 -0700
Message-ID: <20200930042742.2525310-10-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930042742.2525310-1-andriin@fb.com>
References: <20200930042742.2525310-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=13 phishscore=0 mlxlogscore=629 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

One of the primary use cases for using pahole is BTF deduplication during
Linux kernel build. That means that DWARF contains more than 5 million ty=
pes
is loaded. So using a hash map with a small number of buckets is quite
expensive due to hash collisions. This patch bumps the size of the hash m=
ap
and reduces overhead of this part of the DWARF loading process.

This shaves off about 1 second out of about 20 seconds total for Linux BT=
F
dedup.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 63988011978f..05c96bef09e3 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -89,7 +89,7 @@ static void dwarf_tag__set_spec(struct dwarf_tag *dtag,=
 dwarf_off_ref spec)
 	*(dwarf_off_ref *)(dtag + 1) =3D spec;
 }
=20
-#define HASHTAGS__BITS 8
+#define HASHTAGS__BITS 15
 #define HASHTAGS__SIZE (1UL << HASHTAGS__BITS)
=20
 #define obstack_chunk_alloc malloc
--=20
2.24.1

