Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5240240A2CA
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 03:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhINBtC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 13 Sep 2021 21:49:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20710 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233411AbhINBs6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 21:48:58 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DM9bLv010603
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 18:47:41 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1wgtf8ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 18:47:41 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 18:47:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0EF133F9D7B4; Mon, 13 Sep 2021 18:47:37 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 1/4] selftests/bpf: update selftests to always provide "struct_ops" SEC
Date:   Mon, 13 Sep 2021 18:47:30 -0700
Message-ID: <20210914014733.2768-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914014733.2768-1-andrii@kernel.org>
References: <20210914014733.2768-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: VUy7lzCFbBW3a6evcTg5IiEIR96OdKF5
X-Proofpoint-ORIG-GUID: VUy7lzCFbBW3a6evcTg5IiEIR96OdKF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=613 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update struct_ops selftests to always specify "struct_ops" section
prefix. Libbpf will require a proper BPF program type set in the next
patch, so this prevents tests breaking.

Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_cubic.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cubic.c
index f62df4d023f9..d9660e7200e2 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c
@@ -169,11 +169,7 @@ static __always_inline void bictcp_hystart_reset(struct sock *sk)
 	ca->sample_cnt = 0;
 }
 
-/* "struct_ops/" prefix is not a requirement
- * It will be recognized as BPF_PROG_TYPE_STRUCT_OPS
- * as long as it is used in one of the func ptr
- * under SEC(".struct_ops").
- */
+/* "struct_ops/" prefix is a requirement */
 SEC("struct_ops/bpf_cubic_init")
 void BPF_PROG(bpf_cubic_init, struct sock *sk)
 {
@@ -188,10 +184,8 @@ void BPF_PROG(bpf_cubic_init, struct sock *sk)
 		tcp_sk(sk)->snd_ssthresh = initial_ssthresh;
 }
 
-/* No prefix in SEC will also work.
- * The remaining tcp-cubic functions have an easier way.
- */
-SEC("no-sec-prefix-bictcp_cwnd_event")
+/* "struct_ops" prefix is a requirement */
+SEC("struct_ops/bpf_cubic_cwnd_event")
 void BPF_PROG(bpf_cubic_cwnd_event, struct sock *sk, enum tcp_ca_event event)
 {
 	if (event == CA_EVENT_TX_START) {
-- 
2.30.2

