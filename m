Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3257E3EDCA3
	for <lists+bpf@lfdr.de>; Mon, 16 Aug 2021 19:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhHPRxk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 13:53:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64790 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhHPRxj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Aug 2021 13:53:39 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GHjO7n011639
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 10:53:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=gh0hMspso3ZIONZHzFbSnSLpw2c28yYj+ffDv40dLfw=;
 b=mSH66c/NV6/4Aa0ATc7i0wd8SyjfFcfHYTMX9VBNwbfmZ40pBYPcO8nLQdk1F2ZXzl/M
 vpGacRa8GML6cIitad75F2+Xw4hy9OMtXctEYXDlFc0vrO59i4w9iQW6zophcSLHiILI
 eGv6Bc/Js5eBBaoTeRZViJQl2lVdV07UBiI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aftmjh28v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 10:53:07 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 10:53:05 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 3CBCE2246300; Mon, 16 Aug 2021 10:52:55 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v1 bpf] selftests/bpf: Add exponential backoff to map_update_retriable in test_maps
Date:   Mon, 16 Aug 2021 10:52:50 -0700
Message-ID: <20210816175250.296110-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 9k67aof18F57odQbpS0yv0DLeF7-nMaf
X-Proofpoint-GUID: 9k67aof18F57odQbpS0yv0DLeF7-nMaf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_06:2021-08-16,2021-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 mlxlogscore=748 mlxscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108160113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using a fixed delay of 1ms is proven flaky in slow CPU environment, eg.  =
github
action CI system. This patch adds exponential backoff with a cap of 50ms,=
 to
reduce the flakyness of the test.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_maps.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/self=
tests/bpf/test_maps.c
index 14cea869235b..ed92d56c19cf 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1400,11 +1400,16 @@ static void test_map_stress(void)
 static int map_update_retriable(int map_fd, const void *key, const void =
*value,
 				int flags, int attempts)
 {
+	int delay =3D 1;
+
 	while (bpf_map_update_elem(map_fd, key, value, flags)) {
 		if (!attempts || (errno !=3D EAGAIN && errno !=3D EBUSY))
 			return -errno;
=20
-		usleep(1);
+		if (delay < 50)
+			delay *=3D 2;
+
+		usleep(delay);
 		attempts--;
 	}
=20
--=20
2.30.2

