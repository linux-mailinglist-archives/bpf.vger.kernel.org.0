Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53141F7EED
	for <lists+bpf@lfdr.de>; Sat, 13 Jun 2020 00:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgFLWes (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 18:34:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25396 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgFLWer (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Jun 2020 18:34:47 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CMYRXW012048
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:34:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=p6s6yy2to69lAotDnkW6qYKDvQMUksQa7VIbz34yPfk=;
 b=QdkUj0xG+PKe6sfUwBBqhxKBlhm/5JgXEBoWfbkDmIjbzAiVIU03pqnfhf82x7U6y/Wm
 S3nfHra3vxpnO1DZlkUtPoM+og1ULNYoQWPRP5nOFmAnMhZeT6P/G+Af8VODUXPDoUF4
 Tym3Pje0niPLtinkw/T3Uep8aspE8tCmcCY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31k6s3kp31-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:34:47 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 12 Jun 2020 15:34:41 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 850552EC1DEE; Fri, 12 Jun 2020 15:32:13 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 7/8] libbpf: wrap source argument of BPF_CORE_READ macro in parentheses
Date:   Fri, 12 Jun 2020 15:31:49 -0700
Message-ID: <20200612223150.1177182-8-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200612223150.1177182-1-andriin@fb.com>
References: <20200612223150.1177182-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_17:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=8 malwarescore=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120168
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

