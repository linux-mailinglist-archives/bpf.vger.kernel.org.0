Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99521A4AD9
	for <lists+bpf@lfdr.de>; Fri, 10 Apr 2020 21:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgDJTy3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 15:54:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgDJTy2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Apr 2020 15:54:28 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AJl0J8025721
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 12:54:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mt0B1Pv0sv5LjbCr3a3pJaJ1H1XQSg9++vojzfvTTgg=;
 b=nPqRw5rZ8k+P6/Afapb9rkt7PdFUgtMiWB22q3ocpdj4T0lt80yKS35GUmMhQFaCGbkc
 T5eaKFLrtQNjEAwrIsrYf3L1jAAhqaRf9/2HsUGk1k35TCy0ie1lno1varvn+i4dUAWE
 +OVZNhUm37I54fVBXlTC/kJDsmpIrhvMKUc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30aur39cvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 12:54:28 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 10 Apr 2020 12:54:27 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id D205237007ED; Fri, 10 Apr 2020 12:54:23 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf 2/2] selftests/bpf: Test cgroup_skb/egress/expected section name
Date:   Fri, 10 Apr 2020 12:54:01 -0700
Message-ID: <5250d2981a5287858fc9c342b31e8a8492c0a04f.1586547735.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1586547735.git.rdna@fb.com>
References: <cover.1586547735.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_08:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100146
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftests for cgroup_skb/egress/expected:
  # ./test_progs --name=3Dsection_names
  #44 section_names:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/section_names.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/too=
ls/testing/selftests/bpf/prog_tests/section_names.c
index 9d9351dc2ded..2928ca93f7a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -51,6 +51,11 @@ static struct sec_name_test tests[] =3D {
 		{0, BPF_PROG_TYPE_CGROUP_SKB, 0},
 		{0, BPF_CGROUP_INET_EGRESS},
 	},
+	{
+		"cgroup_skb/egress/expected",
+		{0, BPF_PROG_TYPE_CGROUP_SKB, BPF_CGROUP_INET_EGRESS},
+		{0, BPF_CGROUP_INET_EGRESS},
+	},
 	{"cgroup/skb", {0, BPF_PROG_TYPE_CGROUP_SKB, 0}, {-EINVAL, 0} },
 	{
 		"cgroup/sock",
--=20
2.24.1

