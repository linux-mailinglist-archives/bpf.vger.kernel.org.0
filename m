Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33B33E504F
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 02:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhHJAR4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 20:17:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49760 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231439AbhHJAR4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 20:17:56 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A0Fq5j028729
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 17:17:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+heyorf5B1DnnuxN8u9u35O3pP4+xe948WdFEXa0Vbg=;
 b=EMJL5d6nw+PQPlOEbceT8tdTo9HgaCQmPSG2uuoJcGKJeXYgfLVTpwGCw4SrOps2R5gI
 yxaqgZVFqXYI5Lb2DpDtrcVS0K77JcijV6b/Uphdkb3x5bDc0zp8GeeHh5XAgsKqzoMJ
 CITe2UKAO5ICBXeBh2lrD9mPC1nf7koUeEM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ab71pjx6b-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 17:17:35 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 17:17:32 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 3DE1A1E2CB6E; Mon,  9 Aug 2021 17:17:25 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v2 bpf-next 4/5] Display test number when listing test names
Date:   Mon, 9 Aug 2021 17:16:24 -0700
Message-ID: <20210810001625.1140255-5-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810001625.1140255-1-fallentree@fb.com>
References: <20210810001625.1140255-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 9oAalS4Pwo0nDOSTy_0sP8AtbAZWr8V1
X-Proofpoint-ORIG-GUID: 9oAalS4Pwo0nDOSTy_0sP8AtbAZWr8V1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=750 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108100000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds tests number to the output when using "test_prog -l".

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 82d012671552..5cc808992b00 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -867,7 +867,8 @@ int main(int argc, char **argv)
 		}
=20
 		if (env.list_test_names) {
-			fprintf(env.stdout, "%s\n", test->test_name);
+			fprintf(env.stdout, "# %d %s\n",
+				test->test_num, test->test_name);
 			env.succ_cnt++;
 			continue;
 		}
--=20
2.30.2

