Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47633454E7E
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 21:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbhKQUZX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 15:25:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64940 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234385AbhKQUZW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 15:25:22 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHJtBW1016824
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 12:22:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=a78C0wwhT21pTsAPYqJfGkREY3KHax2NpA1BpwS6jbI=;
 b=eMW49TH4pA8ohNOQKaeMJIEZFIWfab2HV4h4FYsP04hGfJXWpYDbN/oHTE7f1Pv+EM1n
 nWFjvbOvAYNu6usbgL7HYVVByym7KvqG0N18Sgj9i1HEGXI/dMO1UTpeRnSFaOHsSLzW
 45/eiOj6DdcEezYaW+hBoSB9e6Ebft+V3vE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cd3y1tf55-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 12:22:23 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 12:22:21 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 6B76628FBA20; Wed, 17 Nov 2021 12:22:19 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves 1/4] libbpf: sync with latest libbpf repo
Date:   Wed, 17 Nov 2021 12:22:19 -0800
Message-ID: <20211117202219.3269370-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117202214.3268824-1-yhs@fb.com>
References: <20211117202214.3268824-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: HVpOa3IqVlG_P7lFVyfMNlLXrPy5S34J
X-Proofpoint-GUID: HVpOa3IqVlG_P7lFVyfMNlLXrPy5S34J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_07,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=805 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync up to commit 94a49850c5ee ("Makefile: enforce gnu89 standard").
This is needed to support BTF_KIND_TYPE_TAG.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index f05791d..94a4985 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit f05791d8cfcbbf9092b4099b9d011bb72e241ef8
+Subproject commit 94a49850c5ee61ea02dfcbabf48013391e8cecdf
--=20
2.30.2

