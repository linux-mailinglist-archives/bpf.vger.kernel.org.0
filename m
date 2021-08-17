Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777BC3EF5CD
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 00:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhHQWnD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 18:43:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61520 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229466AbhHQWnC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 18:43:02 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17HMcDeN010987
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 15:42:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=a2Bbv2r4Czdq2hAQuzLUjTPvdwK5KriPNPzNO0H15oQ=;
 b=qcmvepHiQTIw/RC0BHsDH9kxv/7zTfcPl4mdNivKjjMLMB8R2A8OS47JudAgu9Co78sz
 SCUM2jaYpRMya1rLnBipgslsBvxRh5pnAHBMjayrk9hewIHRfvFj+GDXZkyovr5Kvte4
 +V2RDYMFARgkng9tQRCzBKUz9UR+5xr9ic0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3aftpf1v27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 15:42:28 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 15:42:27 -0700
Received: by devbig577.ftw3.facebook.com (Postfix, from userid 201728)
        id 1C6B06E8CF18; Tue, 17 Aug 2021 15:42:23 -0700 (PDT)
From:   Prankur gupta <prankgup@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <prankur.07@gmail.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next 1/2] bpf: Add support for {set|get} socket options from setsockopt BPF
Date:   Tue, 17 Aug 2021 15:42:20 -0700
Message-ID: <20210817224221.3257826-2-prankgup@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817224221.3257826-1-prankgup@fb.com>
References: <20210817224221.3257826-1-prankgup@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: smFi04k7yVu9NBiM0cReDMyOENqzLb-r
X-Proofpoint-GUID: smFi04k7yVu9NBiM0cReDMyOENqzLb-r
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_08:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add logic to call bpf_setsockopt and bpf_getsockopt from
setsockopt BPF programs.
Example use case, when the user sets the IPV6_TCLASS socket option
we would also like to change the tcp-cc for that socket.
We don't have any use case for calling bpf_setsockopt from
supposedly read-only sys_getsockopti, so it is made available to
BPF_CGROUP_SETSOCKOPT only.

Signed-off-by: Prankur gupta <prankgup@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 9f35928bab0a..8e9d99e2ade4 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1873,6 +1873,14 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
+	case BPF_FUNC_setsockopt:
+		if (prog->expected_attach_type =3D=3D BPF_CGROUP_SETSOCKOPT)
+			return &bpf_sk_setsockopt_proto;
+		return NULL;
+	case BPF_FUNC_getsockopt:
+		if (prog->expected_attach_type =3D=3D BPF_CGROUP_SETSOCKOPT)
+			return &bpf_sk_getsockopt_proto;
+		return NULL;
 #endif
 #ifdef CONFIG_INET
 	case BPF_FUNC_tcp_sock:
--=20
2.30.2

