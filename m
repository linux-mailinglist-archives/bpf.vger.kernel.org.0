Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7006A42464F
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhJFS6V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60008 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232060AbhJFS6V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:21 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196HKRO1021904
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Ca2tAX79mRls+cQcWCtG2Rd/e144mgxVaPJIN5MSe3Y=;
 b=PJer7iq9JtUuIF4RBdKSKhgiWPZxRAQtpcNRIgE0QdG33AhC/zgBr/IctKYB8hOoOQWE
 JlWGFJ3OE7KwxRtYSB6EZv4UeTS+SERV/WuVyXOKQIXbj/qHeqtB5+loj3FgOD0rMFWM
 osyejShz4gtgUu5N0R26q7zl4qsKZpa4cYk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhg3n0u45-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:28 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:26 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 49C324BDB5C3; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 12/14] selftests/bpf: Fix pid check in fexit_sleep test
Date:   Wed, 6 Oct 2021 11:56:17 -0700
Message-ID: <20211006185619.364369-13-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: hbOLCutl8QPhZm99SFuI-78nO0vyWr0d
X-Proofpoint-ORIG-GUID: hbOLCutl8QPhZm99SFuI-78nO0vyWr0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=760 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

bpf_get_current_pid_tgid() returns u64, whose upper 32 bits are the same
as userspace getpid() return value.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/progs/fexit_sleep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/fexit_sleep.c b/tools/test=
ing/selftests/bpf/progs/fexit_sleep.c
index 03a672d76353..bca92c9bd29a 100644
--- a/tools/testing/selftests/bpf/progs/fexit_sleep.c
+++ b/tools/testing/selftests/bpf/progs/fexit_sleep.c
@@ -13,7 +13,7 @@ int fexit_cnt =3D 0;
 SEC("fentry/__x64_sys_nanosleep")
 int BPF_PROG(nanosleep_fentry, const struct pt_regs *regs)
 {
-	if ((int)bpf_get_current_pid_tgid() !=3D pid)
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
 		return 0;
=20
 	fentry_cnt++;
@@ -23,7 +23,7 @@ int BPF_PROG(nanosleep_fentry, const struct pt_regs *re=
gs)
 SEC("fexit/__x64_sys_nanosleep")
 int BPF_PROG(nanosleep_fexit, const struct pt_regs *regs, int ret)
 {
-	if ((int)bpf_get_current_pid_tgid() !=3D pid)
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
 		return 0;
=20
 	fexit_cnt++;
--=20
2.30.2

