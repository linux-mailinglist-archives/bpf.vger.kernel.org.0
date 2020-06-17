Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA71FD1DD
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 18:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQQVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 12:21:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20202 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726815AbgFQQVi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Jun 2020 12:21:38 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HGGaAm001728
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 09:21:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=p6s6yy2to69lAotDnkW6qYKDvQMUksQa7VIbz34yPfk=;
 b=bdHg3hkUw0enBKjbNcbhbjK1FuyEJ+0d/LcV2Wy/Dfsdjz6mvQZpjf8fkMrmOw8Bw84i
 x0iHY0/6QyQ3G4QdOvOsEPtIuWncFQzoqd/WVkqYv5DaYRkoIvGP1zSQRk4gWEFYABDn
 cnriPycfq7BBuig+Kl5IW7roI/tMQT7Sm+Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q65d5cjg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 09:21:38 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 09:21:37 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id A876C2EC36EA; Wed, 17 Jun 2020 09:19:10 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 7/9] libbpf: wrap source argument of BPF_CORE_READ macro in parentheses
Date:   Wed, 17 Jun 2020 09:18:30 -0700
Message-ID: <20200617161832.1438371-8-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200617161832.1438371-1-andriin@fb.com>
References: <20200617161832.1438371-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_06:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=8 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 cotscore=-2147483648
 phishscore=0 impostorscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170129
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wrap source argument of BPF_CORE_READ family of macros into parentheses t=
o
allow uses like this:

BPF_CORE_READ((struct cast_struct *)src, a, b, c);

Fixes: 7db3822ab991 ("libbpf: Add BPF_CORE_READ/BPF_CORE_READ_INTO helper=
s")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/bpf_core_read.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.=
h
index 7009dc90e012..eae5cccff761 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -217,7 +217,7 @@ enum bpf_field_info_kind {
  */
 #define BPF_CORE_READ_INTO(dst, src, a, ...)				    \
 	({								    \
-		___core_read(bpf_core_read, dst, src, a, ##__VA_ARGS__)	    \
+		___core_read(bpf_core_read, dst, (src), a, ##__VA_ARGS__)   \
 	})
=20
 /*
@@ -227,7 +227,7 @@ enum bpf_field_info_kind {
  */
 #define BPF_CORE_READ_STR_INTO(dst, src, a, ...)			    \
 	({								    \
-		___core_read(bpf_core_read_str, dst, src, a, ##__VA_ARGS__) \
+		___core_read(bpf_core_read_str, dst, (src), a, ##__VA_ARGS__)\
 	})
=20
 /*
@@ -254,8 +254,8 @@ enum bpf_field_info_kind {
  */
 #define BPF_CORE_READ(src, a, ...)					    \
 	({								    \
-		___type(src, a, ##__VA_ARGS__) __r;			    \
-		BPF_CORE_READ_INTO(&__r, src, a, ##__VA_ARGS__);	    \
+		___type((src), a, ##__VA_ARGS__) __r;			    \
+		BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);	    \
 		__r;							    \
 	})
=20
--=20
2.24.1

