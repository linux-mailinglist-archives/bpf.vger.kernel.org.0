Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C4743A6A3
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 00:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhJYWgN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 18:36:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9328 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233187AbhJYWgN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 18:36:13 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMGN4x017421
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:33:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gTIetxaSyuKlS96+b1d5uOAu5FQzIv1FUEI8oEa4DsE=;
 b=D5XSJ9KaLqRymxcnH/GknnKmfjMOW5cJidfgs/f8TMANDTpKUn+vx/dTyWvItgLHgbNk
 O3NkXduPmJ4qfCTzcfnBTqEf55+CdhJgAw2Xjm+vQvQeJZlER5Yc0Yu34oYlXuGYWwn1
 NQ5rqnNM2TVVee3pw0gpIq2XWPKUVUAX1Y0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4gn8dc3-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:33:50 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 15:33:48 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 3797B5DB8D3C; Mon, 25 Oct 2021 15:33:46 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH bpf-next 1/4] selfetests/bpf: Update vmtest.sh defaults
Date:   Mon, 25 Oct 2021 15:33:42 -0700
Message-ID: <20211025223345.2136168-2-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025223345.2136168-1-fallentree@fb.com>
References: <20211025223345.2136168-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: ppvpMYeYK3kMqTNAmsVBsmPh7v8w9APK
X-Proofpoint-ORIG-GUID: ppvpMYeYK3kMqTNAmsVBsmPh7v8w9APK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=497 phishscore=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110250127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

Increase memory to 4G, 8 SMP core with host cpu passthrough. This
make it run faster in parallel mode and more likely to succeed.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selfte=
sts/bpf/vmtest.sh
index 8889b3f55236..027198768fad 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -224,10 +224,10 @@ EOF
 		-nodefaults \
 		-display none \
 		-serial mon:stdio \
-		-cpu kvm64 \
+		-cpu host \
 		-enable-kvm \
-		-smp 4 \
-		-m 2G \
+		-smp 8 \
+		-m 4G \
 		-drive file=3D"${rootfs_img}",format=3Draw,index=3D1,media=3Ddisk,if=3D=
virtio,cache=3Dnone \
 		-kernel "${kernel_bzimage}" \
 		-append "root=3D/dev/vda rw console=3DttyS0,115200"
--=20
2.30.2

