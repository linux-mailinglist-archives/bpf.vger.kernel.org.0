Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7902B51CB
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 21:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgKPUBS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 15:01:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29776 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726575AbgKPUBS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 15:01:18 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AGJqV6T001431
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 12:01:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=W1Yp867SWEe170iVg6tuyuN/HjciEy/s51B7qWAP3jU=;
 b=b9iO7bY3cMXVf0XoLa65qhsudZRc0r6aKVam5bxQ/BjXwiJYL95QqmYrAmzi8laWyDIF
 92WqjRdHxvRH2o3jB78KwfS8GOOP1zYeC1hZWmcuWLuEoSI1BtCOK3E+e2uUrbFPd1BU
 mPrtv4gqQ9TWmeSnORHBFed+FUJb16mBgyE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34tbss9udh-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 12:01:16 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 16 Nov 2020 12:01:14 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 79F7F2945F03; Mon, 16 Nov 2020 12:01:13 -0800 (PST)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Subject: [PATCH bpf-next] bpf: Fix the irq and nmi check in bpf_sk_storage for tracing usage
Date:   Mon, 16 Nov 2020 12:01:13 -0800
Message-ID: <20201116200113.2868539-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_10:2020-11-13,2020-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 suspectscore=13 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=412
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011160116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The intention of the current check is to avoid using bpf_sk_storage
in irq and nmi.  Jakub pointed out that the current check cannot
do that.  For example, in_serving_softirq() returns true
if the softirq handling is interrupted by hard irq.

Fixes: 8e4597c627fb ("bpf: Allow using bpf_sk_storage in FENTRY/FEXIT/RAW=
_TP")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/bpf_sk_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 359908a7d3c1..a32037daa933 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -415,7 +415,7 @@ static bool bpf_sk_storage_tracing_allowed(const stru=
ct bpf_prog *prog)
 BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct soc=
k *, sk,
 	   void *, value, u64, flags)
 {
-	if (!in_serving_softirq() && !in_task())
+	if (in_irq() || in_nmi())
 		return (unsigned long)NULL;
=20
 	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags);
@@ -424,7 +424,7 @@ BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map=
 *, map, struct sock *, sk,
 BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
 	   struct sock *, sk)
 {
-	if (!in_serving_softirq() && !in_task())
+	if (in_irq() || in_nmi())
 		return -EPERM;
=20
 	return ____bpf_sk_storage_delete(map, sk);
--=20
2.24.1

