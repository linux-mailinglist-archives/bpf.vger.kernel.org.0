Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DF6341165
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 01:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhCSASh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 20:18:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44686 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232549AbhCSASR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Mar 2021 20:18:17 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12J0EYHO021419
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 17:18:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+FwlTZK1j9LgfSFuLiWA531SLG7H/kYuJRz/AkwN104=;
 b=Cc1Vq7xtV/EhDOL2zFWQAo/NAWNZVVxAVDFCzMJ0apl4nrR0XM+UIuD3znXrq078BJRg
 sQsQvKjJ2TuORJmguPKz9xtk7oduLMceWgs9lE8viqufSwWIiKzB9Zk6bQJUb2IthKg7
 n+iijoT9SbGZ+7Do8pY7cCJYYArYMNV1eBY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 37bs1h7s6y-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 17:18:16 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 18 Mar 2021 17:18:15 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 5FC1B790893; Thu, 18 Mar 2021 17:18:10 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH bpf-next 2/2] bpf: fix bpf_cgroup_storage_set() usage in test_run
Date:   Thu, 18 Mar 2021 17:18:10 -0700
Message-ID: <20210319001810.2166977-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319001759.2165191-1-yhs@fb.com>
References: <20210319001759.2165191-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_19:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=711 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103190000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In bpf_test_run(), check the return value of bpf_cgroup_storage_set()
and do bpf_cgroup_storate_unset() properly.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 net/bpf/test_run.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 0abdd67f44b1..4aabf71cd95d 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -106,12 +106,16 @@ static int bpf_test_run(struct bpf_prog *prog, void=
 *ctx, u32 repeat,
=20
 	bpf_test_timer_enter(&t);
 	do {
-		bpf_cgroup_storage_set(storage);
+		ret =3D bpf_cgroup_storage_set(storage);
+		if (ret)
+			break;
=20
 		if (xdp)
 			*retval =3D bpf_prog_run_xdp(prog, ctx);
 		else
 			*retval =3D BPF_PROG_RUN(prog, ctx);
+
+		bpf_cgroup_storage_unset();
 	} while (bpf_test_timer_continue(&t, repeat, &ret, time));
 	bpf_test_timer_leave(&t);
=20
--=20
2.30.2

