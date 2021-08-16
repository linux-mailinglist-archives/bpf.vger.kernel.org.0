Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4681C3EE042
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 01:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhHPXSD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 19:18:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232692AbhHPXSC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Aug 2021 19:18:02 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GNBT59022106
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 16:17:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=e43ufeHsWr7CME+/FumfAWIsnKIzj07xiz/sZ1k7NQo=;
 b=SQuJZXPyx91oGE3GKe8PP8OsBK/38lCs3nWKd+rDusPxKHepSwg14WXGm7MnejAhk55a
 hjWN5lyZyeavV92EqLqQbrhUQaD/x8dj0HLwdx26a/i/N+cKwcwMIcJRenOLld1fYYdA
 uGqYMRrWq2Gd49XTDRGvbOhI7YViNkpJ0A0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aftmjju09-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 16:17:30 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 16:17:29 -0700
Received: by devbig577.ftw3.facebook.com (Postfix, from userid 201728)
        id 5124E6DC617E; Mon, 16 Aug 2021 16:17:17 -0700 (PDT)
From:   Prankur gupta <prankgup@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <prankur.07@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Add support for {set|get} socket options from setsockopt BPF
Date:   Mon, 16 Aug 2021 16:17:15 -0700
Message-ID: <20210816231716.3824813-2-prankgup@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816231716.3824813-1-prankgup@fb.com>
References: <20210816231716.3824813-1-prankgup@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: vvZrcpbsCIfGJiHXCaNfqOwK7jGhN6vR
X-Proofpoint-GUID: vvZrcpbsCIfGJiHXCaNfqOwK7jGhN6vR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_09:2021-08-16,2021-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108160144
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
---
 kernel/bpf/cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a1dedba4c174..9c92eff9af95 100644
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

