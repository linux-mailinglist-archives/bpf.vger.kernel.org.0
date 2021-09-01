Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F8C3FE346
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 21:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbhIATpy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 15:45:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32386 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344117AbhIATpx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Sep 2021 15:45:53 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 181JhvKx012356
        for <bpf@vger.kernel.org>; Wed, 1 Sep 2021 12:44:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=GCBKwQWIY3oeAPNyvXcVujQsbDZTt4YCyNa7zkfmQ30=;
 b=gzXRBPG8rKu/izb0LCDp8QUUxSYj69uirSHv3j3rRNnmSMcK9TT8jSZcECLW8exTpkSa
 5XvPzfVrj6kd69vt16T59qb//Qisx4N5c5dcHnsHT6aGS4pF+pm6Gww1n2rwdTdetVha
 h78D+7A/dGpe4uW3VAHiXBxCuQK9ogrUoIQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3atdyh2smm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 12:44:56 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 1 Sep 2021 12:44:54 -0700
Received: by devvm3431.ftw0.facebook.com (Postfix, from userid 239838)
        id C47999CDE3F4; Wed,  1 Sep 2021 12:44:43 -0700 (PDT)
From:   Matt Smith <alastorze@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andriin@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
CC:     Matt Smith <alastorze@fb.com>
Subject: [PATCH v2 bpf-next 1/3] libbpf: Change bpf_object_skelecton data field to const void*
Date:   Wed, 1 Sep 2021 12:44:37 -0700
Message-ID: <20210901194439.3853238-2-alastorze@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901194439.3853238-1-alastorze@fb.com>
References: <20210901194439.3853238-1-alastorze@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: rjlsCiQNmeO0lTeWg6FIfog1Cc2sxykf
X-Proofpoint-ORIG-GUID: rjlsCiQNmeO0lTeWg6FIfog1Cc2sxykf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_05:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109010114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change was necessary to enforce the implied contract
that bpf_object_skeleton->data should not be mutated.  The data
will be cast to `void *` during assignment to handle the case
where a user is compiling with older libbpf headers to avoid
a compiler warning of `const void *` data being cast to `void *`

Signed-off-by: Matt Smith <alastorze@fb.com>
---
 tools/lib/bpf/libbpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f177d897c5f7..2f6f0e15d1e7 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -854,7 +854,7 @@ struct bpf_object_skeleton {
 	size_t sz; /* size of this struct, for forward/backward compatibility *=
/
=20
 	const char *name;
-	void *data;
+	const void *data;
 	size_t data_sz;
=20
 	struct bpf_object **obj;
--=20
2.30.2

