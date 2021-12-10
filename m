Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D844709E9
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 20:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbhLJTOB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 14:14:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343539AbhLJTOA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 14:14:00 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAE9bUL014794
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 11:10:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HfmQf6KZ7XdHhVqoIiTcxrfaF5CKBxfC4/bsNNE/xAk=;
 b=MxYkSZ8Xo7grVxCSw7VyGQL4Qrp0/tRqgniu4DS+CJ3R2P2O4bpejF/2JOYSzQbEa0eK
 3gvlioSr/AWf23yovdAuGhnOKXOKKMn3AgeWLZM3sv500K/+Hf3o1v2scfLR+yLLNJ5u
 Yq7NnpYvJ4SZkyTuE8U3lcPVO6uUhP5RVD0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cv41wby8u-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 11:10:25 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 11:09:55 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id B60A4F0FC30; Fri, 10 Dec 2021 11:09:53 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <ast@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 3/4] tools/perf: Stop using bpf_object__find_program_by_title API.
Date:   Fri, 10 Dec 2021 11:08:55 -0800
Message-ID: <20211210190855.1369060-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210190855.1369060-1-kuifeng@fb.com>
References: <20211210190855.1369060-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 6xRekTpFCjxI1CBgfzPj0DPwDeOAs9iB
X-Proofpoint-ORIG-GUID: 6xRekTpFCjxI1CBgfzPj0DPwDeOAs9iB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=965
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112100105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_obj__find_program_by_title() in libbpf is going to be deprecated.
Call bpf_object_for_each_program to find a program in the section with
a given name instead.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 tools/perf/builtin-trace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 624ea12ce5ca..082ecf2b31bf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3253,10 +3253,22 @@ static void trace__set_bpf_map_syscalls(struct tr=
ace *trace)
=20
 static struct bpf_program *trace__find_bpf_program_by_title(struct trace=
 *trace, const char *name)
 {
+	struct bpf_program *prog =3D NULL;
+	struct bpf_program *pos;
+	const char *sec_name;
+
 	if (trace->bpf_obj =3D=3D NULL)
 		return NULL;
=20
-	return bpf_object__find_program_by_title(trace->bpf_obj, name);
+	bpf_object__for_each_program(pos, trace->bpf_obj) {
+		sec_name =3D bpf_program__section_name(pos);
+		if (sec_name && !strcmp(sec_name, name)) {
+			prog =3D pos;
+			break;
+		}
+	}
+
+	return prog;
 }
=20
 static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *tr=
ace, struct syscall *sc,
--=20
2.30.2

