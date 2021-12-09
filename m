Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85546F22E
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 18:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbhLIRju (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 12:39:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50084 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243112AbhLIRjr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 12:39:47 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B95shbi008353
        for <bpf@vger.kernel.org>; Thu, 9 Dec 2021 09:36:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=OL9ILN8wkuVKjVHt46aQz/JSx8O6cyhcxMdhOOqS6cc=;
 b=B9YO/oLkE4OpADe9P/Rsgsmev9AvZ8oqtRs3177wLT56cpMFO32v9yi85AcN0inJbnEf
 6GTa+yfRcCZ0lqx87nVb/ADHhZTfAdVitRCOYBY++ZrNYCawixERxPlaNktWOmbDJRVw
 NnOEP3Fi7si7nS3MV0liw0sXpv5fktNk9Dg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cuc2nv4u0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 09:36:13 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 09:36:12 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 68F3738B9D87; Thu,  9 Dec 2021 09:36:04 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 5/5] selftests/bpf: specify pahole version requirement for btf_tag test
Date:   Thu, 9 Dec 2021 09:36:04 -0800
Message-ID: <20211209173604.1529864-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209173537.1525283-1-yhs@fb.com>
References: <20211209173537.1525283-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: ya10NtIjFnlOrDiozMwNQUxLgicC9MC6
X-Proofpoint-ORIG-GUID: ya10NtIjFnlOrDiozMwNQUxLgicC9MC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_07,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=928 spamscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112090091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Specify pahole version requirement (1.23) for btf_tag subtests
btf_type_tag_user_{1, 2}.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/README.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selft=
ests/bpf/README.rst
index 42ef250c7acc..eee6656de0e6 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -206,6 +206,7 @@ btf_tag test and Clang version
=20
 The btf_tag selftest requires LLVM support to recognize the btf_decl_tag=
 and
 btf_type_tag attributes. They are introduced in `Clang 14` [0_, 1_].
+The subtests ``btf_type_tag_user_{1, 2}`` also requires pahole version `=
`1.23``.
=20
 Without them, the btf_tag selftest will be skipped and you will observe:
=20
--=20
2.30.2

