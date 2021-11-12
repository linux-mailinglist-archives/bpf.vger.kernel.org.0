Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E7144EE1F
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 21:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhKLUwS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 15:52:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34578 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235727AbhKLUwR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 15:52:17 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACKmIKk025613
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 12:49:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=o7kl54CnyEyHTSSegHJxaHjz7JLAnWhmIyNLx3fXEhE=;
 b=p3KxL5c/GBHDHXuS4OnzYJfrMKSBEBB+YOyRd+BSa4TnjrREkTcW2ja2ZmVDQGhog6EU
 ehusLgURVqa5RCsoawyZpMr6GPDW/V2X2CvVPKwdPQFE6mexzyDgW/t0tfR5+bt58Gt+
 GESlBNeyTIjnHrPei6bHcv+DFVqbrKOgGTc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9jt9x0ss-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 12:49:25 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 12 Nov 2021 12:48:37 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id BCB2425602C5; Fri, 12 Nov 2021 12:48:33 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: fix an unused-but-set-variable compiler warning
Date:   Fri, 12 Nov 2021 12:48:33 -0800
Message-ID: <20211112204833.3579457-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: qsdTxtvK1SLe8OC02X1WZI3D2_jew73d
X-Proofpoint-GUID: qsdTxtvK1SLe8OC02X1WZI3D2_jew73d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=927 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using clang to build selftests with LLVM=3D1 in make commandline,
I hit the following compiler warning:
  xdpxceiver.c:747:6: warning: variable 'total' set but not used [-Wunuse=
d-but-set-variable]
          u32 total =3D 0;
              ^

This patch fixed the issue by removing that declaration and its
assocatied unused operation.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/xdpxceiver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/sel=
ftests/bpf/xdpxceiver.c
index 6c7cf8aadc79..fe7f423b8c3f 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -744,7 +744,6 @@ static void receive_pkts(struct pkt_stream *pkt_strea=
m, struct xsk_socket_info *
 	struct pkt *pkt =3D pkt_stream_get_next_rx_pkt(pkt_stream);
 	struct xsk_umem_info *umem =3D xsk->umem;
 	u32 idx_rx =3D 0, idx_fq =3D 0, rcvd, i;
-	u32 total =3D 0;
 	int ret;
=20
 	while (pkt) {
@@ -799,7 +798,6 @@ static void receive_pkts(struct pkt_stream *pkt_strea=
m, struct xsk_socket_info *
=20
 		pthread_mutex_lock(&pacing_mutex);
 		pkts_in_flight -=3D rcvd;
-		total +=3D rcvd;
 		if (pkts_in_flight < umem->num_frames)
 			pthread_cond_signal(&pacing_cond);
 		pthread_mutex_unlock(&pacing_mutex);
--=20
2.30.2

